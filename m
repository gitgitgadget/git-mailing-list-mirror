Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A2A4CB3D
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773344; cv=none; b=a2SVDAOlyAz3jz0t63/jW6YKg3lt5mTgw7rqdbAhxwzCqUz+55UWBPSA78WTwZzfiUg+mwoITRI2ZiUkQ0hGasrMp1ITSHnwHtQZ6jbn+O1l4zMRerpUWCH9Emafai0VgRFKhox8xRsanvJEGR9pIdr0JQQn+Gc0wyAN08oMWT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773344; c=relaxed/simple;
	bh=DyO+Ksly2tlLCimpHuKQqyD4l/HqWhBM8uqgk2mx7yY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LT7agX+6zLBDc/qQHHlvz2fBX9y3/VbXg+Kifa3AByh0r9sU0Wy9PLqGj7rjnSuoTu3cRym0X0SGFvXxzYf0VJO2TomTmLZNFyme7mLumXk3DRpqrXdpveCutymBmHhePe1BYXA9Ysatf/nOXLFRUoYRbrNq5Pu6d3X+IXvwZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqX/VVit; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqX/VVit"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-411ab6dbcb5so2744345e9.0
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 13:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707773340; x=1708378140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cev6dQXghVMeKDTOXpfdE6cMeZ6UI/U4cgZ6294/eB0=;
        b=NqX/VVit+CeTA6JAmvTiL7r69x97Q7dDeKlrO+6BAJXOqEvwfDdAoZkaJj9Rh6e2Hx
         Uc+1NvyMMviTzX1BqeYnaUHoTUKs4CipOBIbbsDvfiI244zAV+IXulW0LlenS+vGek4o
         2xojg8iSMTFIoFU0uOK3xAuuaqOCFCp9lh82YCOYQCABA5ZdQnKehgCfJYECvp/J3qeE
         WFADhuAhzQJBoe6vX0/4awshlp4CbBzabN24yACcupreQ/cLFFTy/z1B6tIFOSEPJBoE
         20LcapXbrWSPMnUBUGRVokHZzptRrwaRiFS8e5oRhEIWNc3K1ue2pXEkWY+WX3TTiUDi
         fwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773340; x=1708378140;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cev6dQXghVMeKDTOXpfdE6cMeZ6UI/U4cgZ6294/eB0=;
        b=rOt302dmh5feBXSW9fs9s5uRoqDU2KAH1MMeTYQvi/8ll7ncEnzcxDK40PlL+CojNp
         qPd2lDRl/Qdj7WUnkVvtRwIflR/8IM8/7BSnKxgYCiMPQmnwI7CvoLZH1sgl0tlDq1ni
         Z3QzMiyVNuWQ2fvo2UdW2zg7G8IdOO0Roy1OsoZZ67C8GZi55501N5k5uSfzzZ+14uN4
         ADTVl8yRtG9hj6HRqipzNem2yhBsPVgfGWrgXPZPyX+WgqKmOdFxN9F/51EzoRZibB1L
         5qXGezHepNHHqJFapMCyoCEPr+1qI6wRNzOk67dJatnM9qihy22uoX/hwidYsa59SdGG
         +VwQ==
X-Gm-Message-State: AOJu0YxYrS1otasN+Xmq4F8VAGcQFaMwx9dEcqPoEGT0lz+6nGqhkPqb
	03dVNhrGfVElbiolsQ111J8erBI2MsMZkZR69Pc6DW71k5cJx3eJ
X-Google-Smtp-Source: AGHT+IEVjc8nIhruVYtIsSGoUR2RhGSLicC00CkMDnqsIdJ5lKBSG5pBEElaVbRGOVDvIqE/UkNxsQ==
X-Received: by 2002:a05:600c:474f:b0:40f:cb0d:4de6 with SMTP id w15-20020a05600c474f00b0040fcb0d4de6mr588896wmo.5.1707773340505;
        Mon, 12 Feb 2024 13:29:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKTlTQTmEtrA4wN2zplUnQ20cEaKVyeUVACxnAbrzDvbXwynTkEG7YbMMMr/as+U0lKP1O4/TwOIxiE4hlkrr+sfAH1zwCdubaNOCUr27MD0+E5SReMHCoizSx6SIhkqF1x4mvKeZRBe02/90A
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id bp9-20020a5d5a89000000b0033b4796641asm7869506wrb.22.2024.02.12.13.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 13:29:00 -0800 (PST)
Message-ID: <effd06fb-8344-4476-b5d5-dcb9f6fff692@gmail.com>
Date: Mon, 12 Feb 2024 22:28:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] column: disallow negative padding
To: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Cc: Tiago Pascoal <tiago@pascoal.net>, Chris Torek <chris.torek@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <76688ed2cc20031d70823d9f5d214f42b3bd1409.1707501064.git.code@khaugsbakk.name>
 <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
 <89d32a5f-b5ab-4773-bd9f-d33b4e348e15@gmail.com>
 <09b1ab48-b58f-458c-89f5-0c419d92f61a@app.fastmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <09b1ab48-b58f-458c-89f5-0c419d92f61a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12-feb-2024 17:50:54, Kristoffer Haugsbakk wrote:
> On Sun, Feb 11, 2024, at 23:47, Rubén Justo wrote:
> > While we're here, I wonder if silently ignoring a negative value in
> > .padding is the right thing to do.
> >
> > There are several callers of print_columns():
> >
> > builtin/branch.c:           print_columns(&output, colopts, NULL);
> > builtin/clean.c:    print_columns(&list, colopts, &copts);
> > builtin/clean.c:    print_columns(menu_list, local_colopts, &copts);
> > builtin/column.c:    print_columns(&list, colopts, &copts);
> > help.c:     print_columns(&list, colopts, &copts);
> > wt-status.c:       print_columns(&output, s->colopts, &copts);
> >
> > I haven't checked it thoroughly but it seems we don't need to add the
> > check we're adding to builtin/column.c, to any of the other callers.
> > However, it is possible that these or other new callers may need it in
> > the future.  If so, we should consider doing something like:
> >
> > diff --git a/column.c b/column.c
> > index c723428bc7..4f870c725f 100644
> > --- a/column.c
> > +++ b/column.c
> > @@ -186,6 +186,9 @@ void print_columns(const struct string_list *list,
> > unsigned int colopts,
> >                 return;
> >         assert((colopts & COL_ENABLE_MASK) != COL_AUTO);
> >
> > +       if (opts && (0 > opts->padding))

;-) (fixed)

> > +               BUG("padding must be non-negative");
> > +
> 
> Sure, I could add a `BUG` for `0 > opts->padding` in v3.

Thank you for considering it.
