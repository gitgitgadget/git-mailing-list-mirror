Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A91216605
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758470856; cv=none; b=ixiqVVPTYR2+junVMeRw2MAFUCe7bAq/SU1oVltp8CV9VyXMAI9Zoto/ISMTmomeP8qc0ZO+1FnIRnnghra/lm19a4w6eWKxfhb7eaQfUlkhgfO1uVmqgqDYBuKEuXSABJdvsfBHJtkXynO3XRZrpJKrJXDUYHPjfnd2VBQFFko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758470856; c=relaxed/simple;
	bh=kznpM61+UoulZ12CsHgTONWEov7iZ+LDwncQ79+adj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhwNOI/lHmk0SR0zRH7z0MPCjCFveNLJZP5YYsXrdZ3Hip1GSVBmbsvyWS/C3C/EQgg2BcO6QbPJyWt0E/dXHtSdEMgBDxJmQAOhGSshf3RWlz9SK0OveibdtgN2zthjAxeQPWmeU7J4aXQPor/YzIBy7OTCMp/KLUW+VYBmi70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecXRmdZ5; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecXRmdZ5"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-367874aeeacso8605221fa.1
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758470852; x=1759075652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1eMExIr0dQbrrcArIJ4+4xExjupbp+X7tz3XgbuP1Q=;
        b=ecXRmdZ5gBUhDY29b5ioyDZhw9ouwjzZdkP127TrWcbTwnDrm6IKa09ZgTRdOLPT07
         u04lwxr92Mj9Jq/pxlQA2Deg7StMsKRArjeZe/HzsYPhdZUbZUXL/DxO+USO+p+HZRyn
         EWYVvHa/LaWVDskleh4XBRoCLe8eJWzdgWYucDr0TeX3zfIAdH55lWTON7dwGCyGENLs
         428GQJuJlA7Gw5HOQC4HbmZk6XNNvj6jKP0vFE5KV2Kkn4w4mF6SigVyWyWs85LOLOw+
         4YPXKzGxRFFfjP41J2n7pmxS4AQjlr89R/zOWk0rxRD/eS4Jv+UmHS0KRHQy/hZnnkkm
         nM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758470852; x=1759075652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1eMExIr0dQbrrcArIJ4+4xExjupbp+X7tz3XgbuP1Q=;
        b=TAYnYfHsREsZWvgYJLAWB+QfCOCvzdEk2hTSWlSHA4LJWbnIGo5p7D0ACFQzDOM9BR
         o2az2Zqw8gMxfralMN4zlIEVkkhtebjAXRkkQFiXYpEHn3X6p4r5Jxvesin3W8UBEvSr
         13yFHeJgs6r/ATnEDOgUQf0Pk5joMzptUh/bTSTCT6q677FNtvFz+NjCT0mMywbATTB5
         oyocUlRz9ndX/+hf9BfuD9rnvclOeVbJQW5RQHL1nuAM98ErZJrpYs0OSCiWoyixGZtX
         DAy/xg31yxy/kGSIXrE+OwhL4lUvNxwW0BebGLEBvg0xBUXYaY9hJROHaHi9HlsSJ00I
         ZyLw==
X-Forwarded-Encrypted: i=1; AJvYcCW6JfhD/H2YevNeRFQCQ7mlnD5MBN56ASyeRxcmeMkNCxUXzrOJ/A8cSip98kWf/rafiAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Wmacqav22bBPiIT4zBxiNKuuOdza/JJmZPERSwjwLEaB9QLQ
	VNxyVBMudc7W6l19XOs80sh1D5LcFOSkmF9cn7TzzXX45BDLzA8Y8Ru/LJiRrjk/Dvd1mBfQUVJ
	kfi199PQPfe3CQ3K+bhK5tIUZfKGlSGw=
X-Gm-Gg: ASbGncukoUCv4uwuJD/35CF7y4VwbO9NN5WTutRJm5M1U0yPZMKsDwe3hHKkM+1hJMD
	Q9v7Tc2uLWUhnpRtm8vkzivVTCBmra5Ahmv2k0K4L95RcpTg6kd5UjxNhGS8hEJQ23yErZfcUcB
	3njEu6nq33Dywl0n6UtWHzV8OtId7GREh+MhbDn2s1gqwJR6A2gPCm3kRnT+hCm/PpQzrFYKxXe
	nTCcxkt
X-Google-Smtp-Source: AGHT+IE/J4hidnjCpMm/WrHK8bkR1RefJRNnXV8SG1YlLAb0/Kg58sdG2JJDnFRxHAudWRCSN/CavYT1w0VvGh29A8o=
X-Received: by 2002:a05:651c:2112:b0:332:3562:9734 with SMTP id
 38308e7fff4ca-36413561c1fmr29995241fa.8.1758470852369; Sun, 21 Sep 2025
 09:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
 <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com> <e1e94107c9722b751d6111460b17e02a7ffd96d1.1758294992.git.gitgitgadget@gmail.com>
 <d22c61da-bd78-47cd-b3b6-adc0d3873fef@gmail.com>
In-Reply-To: <d22c61da-bd78-47cd-b3b6-adc0d3873fef@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sun, 21 Sep 2025 10:07:20 -0600
X-Gm-Features: AS18NWA7NeTEzEkPQLR_x8cchyZQ--fR7TXmFSueF0tdU5S5zTD2talSmiQJOJ4
Message-ID: <CAH=ZcbA95gYZggsqTw=hv0PZR0FkHByVib7N79XQ3c6-1OySBg@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] xdiff: delete fields ha, line, size in
 xdlclass_t in favor of an xrecord_t
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 7:06=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> > The fields from xdlclass_t are aliases of xrecord_t:
> > xdlclass_t.line -> xrecord_t.ptr
> > xdlclass_t.size -> xrecord_t.size
> > xdlclass_t.ha   -> xrecord_t.ha
> >
> > Remove aliasing from xdlclass_t, to reduce future refactoring mistakes.
>
> This is a rather nebulous reason. I assume this is about changing the
> types used in xrecord_t.

Yes, this is a stepping stone to many more refactorings that I have planned=
.

> in which case it would be helpful to say something like:
> xdlclass_t carries a copy of the data in xrecord_t, but instead of
> embedding xrecord_t it duplicates the individual fields. A future commit
> will change the types used in xrecord_t so embed it in xdlclass_t first
> so we don't have to remember to change the types here as well.

 I've incorporated your wording into my commit message.

> As we're embedding the struct, instead of doing
>
> > -             rcrec->line =3D line;
> > -             rcrec->size =3D rec->size;
> > -             rcrec->ha =3D rec->ha;
> > +             rcrec->rec.ptr =3D rec->ptr;
> > +             rcrec->rec.size =3D rec->size;
> > +             rcrec->rec.ha =3D rec->ha;
>
> it would be simpler do do
>
> -               rcrec->line =3D line;
> -               rcrec->size =3D rec->size;
> -               rcrec->ha =3D rec->ha;
> +               rcrec->rec =3D rec;
>
> which would make it clear we're copying all the struct members.

Makes sense. I'll incorporate that.
