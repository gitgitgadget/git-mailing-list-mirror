Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D895171A5
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712472075; cv=none; b=kyxSewn48VKzwNl1sFBKTwpxfGXn54RjfuPRLQHI4WlGsmEpf98NCHRLmLLBD3luVfBnP3UwJ6xDKisbTPE73Cr8eJEAcKhaVhffJjjEv9gpNL4J2IVMhjTVlrkE89SMmgWDIuqvfm7lHHQRjJ7zCWW2Uu3tOvHq5pkryM3oCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712472075; c=relaxed/simple;
	bh=HDnK+WLbTVPj2A0bQPDGji4rz/xT7lcXX5VhyElM2ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9q3fvqr53bcs7wF89GuU1fLTjPfeSrhaC1whu6xJVb8JR4+YkUoZ/ZkEf0kpE5RjWyn6He1gQWXbgmyVARs4l25LaCN44rh4LvQw0RO2HrUr01fcAyp+aG/4A/89coXTEVyCp49FmCGiCZ6dmSW0Psgz69H6vo0S0BPgJ6iXpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGgfP/L/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGgfP/L/"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4164e7bd4c3so2769885e9.2
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 23:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712472072; x=1713076872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nBdVQAgfp3LFszatgSMZkT6qjZi/ERXOekyBrYubMg=;
        b=lGgfP/L/+BXlaJl51Tei2GCyuUrBXZ7cfnVF1jJZCAxX/3++MOIIUnpryMM4S55zeM
         3oh2yNe8/26BcSYEGulT/WPN2rkc6LdKn4A/EBk+MfCp5jEshEZKipSTrfmuQ7C1wIIU
         ImUDlsFrZlEJ7K3mzLVI9gQQNQkutWyxO/41Tvy06HzA9r/TbO+W8Li/x7NtcRDUWZ2k
         FIi04embZfstIiFczHdIFnYznRjtQSOAWZEzsgBBTuaAiDdIY3NdaM/yfM9cC1jBgRWt
         JiKtW/J2eaFOL8cfJpw+gxLL8AJtN/wqUkAh1kXcKvnA9NDxmQepnEPgD75+X/zutlnG
         bsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712472072; x=1713076872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nBdVQAgfp3LFszatgSMZkT6qjZi/ERXOekyBrYubMg=;
        b=oW7sHIH3ecPpNecI4lDtkyq6nZingzg6oc3YRcEJGKhULwKjJt4O3iwwrn/eM4CemL
         Y/a5RLVLFG7CILFj4mSWu34drN33THv+jBy0pv7izSPKRDeRvPkHb/n76EsYQNdUcFpC
         XIShzRkQhmeLXE6U3bmavt0IJ5nx3a+qdMxejj2/c69RzOXXPRm9xR5fJqSxhiJ8EDCm
         a1IkQ8VLQGDlum0l/vlJoedceUlGjwe+zgKDDVQ4/OxMI4WWTmCNxadGQbOkCfRcpIbY
         AniwLCLHrlXyynLnoibHYRe0+QrW+vXLEIRjmbtCQdOblbORSHcaHbtSSDmjfbY3z/nP
         S1FQ==
X-Gm-Message-State: AOJu0Yyt0qi/Pxr/cE2kUebqBZjVpBK8CjoKvFpZRKgoRVjnFnO/qt/W
	ImhYByZv1TJJSEAIb2MDJfx7EV2UNV3NogPZlu/G1yQjfsUzi6VCFuEW7tN/MA1kpJdX6yX3xYb
	AaMjaY7Bb0XGWTwGVS15ZvQrLjpeSmDMzi4JZjQ==
X-Google-Smtp-Source: AGHT+IGqiiRr6SG61KiipA5LuzCGfMXiOmlG2oTwY8rOjTHvwE98hNRHEv0RuIlcdVXv4PrUME9S4Mj3+/UBqV8MvPI=
X-Received: by 2002:a5d:44ce:0:b0:343:b5f0:f511 with SMTP id
 z14-20020a5d44ce000000b00343b5f0f511mr3583959wrr.12.1712472072457; Sat, 06
 Apr 2024 23:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407051031.6018-1-leduyquang753@gmail.com>
 <CAPig+cQVQrrXrDqys-TyCqFynR6=pmbxs-NK-ca-s0K8mjADaA@mail.gmail.com> <xmqq4jcdivgw.fsf@gitster.g>
In-Reply-To: <xmqq4jcdivgw.fsf@gitster.g>
From: =?UTF-8?Q?Quang_L=C3=AA_Duy?= <leduyquang753@gmail.com>
Date: Sun, 7 Apr 2024 13:40:36 +0700
Message-ID: <CACXAH50KHrnmc1At_DHX5O=BGuGT_pe9n5nGLSJYt7fXTbe_Yg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Add lines to `git log --graph` to separate
 connected regions
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 12:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> True.  But because we are doing graph, shouldn't we be able to do
> better?  For example, you can draw the two lineage of histories
> on different columns and ...
>
>        * a2
>        * a1
>      * b2
>      * b1
>
> ... that way, you do not need to lose one line of precious vertical
> screen real estate.

I think horizontal screen real estate is even more precious than the vertic=
al
one, since one usually doesn't scroll their terminal horizontally. And then=
 it
would probably be a way more complicated implementation.
