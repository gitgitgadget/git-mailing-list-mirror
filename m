Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184C21E091
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 22:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709664; cv=none; b=k3Ykmo2X+cyeVo2XlDzIIxvLeSXwe34K+5/YS8j4gUZ+SWR7+q179PTSuMEF+au8EcIIVhKKzsxzR3hGgSveUFOJDuyPK0C3UZQ+ba1yiqgaKSiAmatRKXmNpOrtRLJkjIB6xGWh596omX8jEO58RtxSrzupzzXdD+1j9A2eQqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709664; c=relaxed/simple;
	bh=d00mY+LrGIn2CnzfXtMGIh4HT15glz8i280U/iiZbmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xg9QUkg5DRyyANS8iuhtFVEDIRFA+nRWMGbGCm/PR6q39h1nHXq7lFESWnZbllwuBmfyWeBwjrMswB+oEayyE8ImqWfUqym1aQaAWFIztQE4JrRCmv9TLspvFHm+woAZK29FAH7XnS7bfumE2o+mN1X9rDqR71UsKgklQaSlsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWjqsiWu; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWjqsiWu"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71e17ab806bso3379869a34.2
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 14:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738709662; x=1739314462; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DId+4dtLAYq8Ex/p6ofn0TgVGglEJ4pb9uLC+M7ZFro=;
        b=UWjqsiWuqNroQ4iMaKhD21+17Xy9MPo6flFo4n/ZGkTGINnFcIjsVyzNRi4SHvlf+9
         h4Q13xj3daVUtrosiI4tNkAKr7mQiu9TsXEUswEdqWNmV4fWmaC2q8kbMGML5m9z2Eba
         qivWkrZw4whmm5QcRTHKqCJoS32C7KTioSylQSoadDRFIxlAWo09nBdAyFkJ3fQCoM+D
         pGl4bCNZtlyNaD1/lytB0wAV2BUP3ybTALO2hcJtL+SA9hlny3/25533XDJSX0t8TBYk
         wiLvLLj+eNnBDV/1gI1TtBthnAViSpU3vcY+/Jgp4xDGhfiHHbklGaoCMUHzth99d8jl
         rPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738709662; x=1739314462;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DId+4dtLAYq8Ex/p6ofn0TgVGglEJ4pb9uLC+M7ZFro=;
        b=Aw27WtyxO4xAx5f3TRgo1I24MDL1ek9SXOuvTA8V7bE80eK88a6QukTZ6oowHqVn57
         /ErSmKXkJf5U0JLeMsJpF9PKGKyi0rpDuqo62sL+dBVRDEreK0u5ZVjhsYUBnTI8Nhr9
         ZdXfBLVJWO6IZrybZ9xkmbXEmBHVA0M6nfbp7HV5FOECNwyffaxeMY6Pqh6/Z7inEuQX
         5pHjpxeid1O84KWZUghPzVHe066ESgKT5dMkG9hjGATN6XWKXjK9Y5OXK455H/xueClU
         hviBmUyVfWYFz2OWLnLW1x4hslF4k6bTw3cZ2qbaanOaI0zqZ7oipqFdOQQOzzd9vAVV
         5mrQ==
X-Gm-Message-State: AOJu0YyBXZBislPydJgB+CGEQwXIACZd/+DvhukD4iBvhY2axnxtALs/
	3xv06Fcf5CuC/DbMKzeDIawn/vXAJVrIeIxNlw7HZdvhXuFHbK+9NmwzIQ==
X-Gm-Gg: ASbGncuLt1UAfkJBOE+I5nqjuRylVuxvrTv/93f7WXkF1STyRyqpPrd2lQG1eijHAVz
	9nUu8wV7G4Q0xtvbdVQleq+9nvcY/XgsC7BeHNhku6gyCALl0Gg4Wx/d4cF1808xNpcOfIB8OEs
	HVR5FyuwqMUpINjreonQNOwEzzWcs5N1JIwkRxWRS/MN79KU1tpBq4Kc5G9yyb70YWROEmaU6qR
	Saoi7BXx34l1xueu0Rn7fGsNft6+WTneL7fQx7sDFJUwQWjFz+o3gzXBwbkMIUkWWmCkTjHrlji
	W357fbhB
X-Google-Smtp-Source: AGHT+IHqU0Pmk1IAWMcv3/8AM0Azy2sepCKVsnp5QRLCpa1UBiw2Z6tS2ONcwJobqbQdU61F9UgCbg==
X-Received: by 2002:a05:6830:2b2b:b0:71d:5c2f:36ad with SMTP id 46e09a7af769-726a427d24emr442438a34.19.1738709661831;
        Tue, 04 Feb 2025 14:54:21 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-726618b9f72sm3620401a34.50.2025.02.04.14.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 14:54:21 -0800 (PST)
Date: Tue, 4 Feb 2025 16:51:24 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] rev-list: print additional missing object
 information
Message-ID: <ykyebummbcnkwsk4svzqvt2ofluyn4uyghnykobjatv6mfveef@3dg5hkw56dzi>
References: <20250110053417.2602109-2-jltobler@gmail.com>
 <20250201201658.11562-1-jltobler@gmail.com>
 <CAP8UFD0vbv7tRP1cac-q-Qqk7wxo57oP3VLqj7Gn_kHi41y=hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0vbv7tRP1cac-q-Qqk7wxo57oP3VLqj7Gn_kHi41y=hQ@mail.gmail.com>

On 25/02/03 11:45AM, Christian Couder wrote:
> On Sat, Feb 1, 2025 at 9:20 PM Justin Tobler <jltobler@gmail.com> wrote:
> >
> > Greetings,
> >
> > It is possible to configure git-rev-list(1) to print the OID of missing
> > objects by setting the `--missing=print` option. While it is useful
> > knowing about these objects, it would be nice to have even more context
> > about the objects that are missing. Luckily, from an object containing
> > the missing object, it is possible to infer additional information the
> > missing object. For example, if the tree containing a missing blob still
> > exists, the tree entry for the missing object should contain path and
> > type information.
> >
> > This series aims to provide git-rev-list(1) with a new `print-info`
> > missing action for the `--missing` option that, when set, behaves like
> > the existing `print` action but also prints other potentially
> > interesting information about the missing object.
> 
> I took a look and commented a bit on patches 1/4 and 2/4. Not sure my
> comments are worth a reroll on their own. The other patches look good
> to me.
> 
> Anyway I think you might want to address Phillip Wood's concerns too:
> 
> https://lore.kernel.org/git/76390e3b-e749-4d28-98a5-05db7c5fbcd3@gmail.com/
> 
> Thanks.

Thanks Christian for the review!

-Justin
