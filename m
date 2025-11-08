Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B931A2566D9
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762621920; cv=none; b=Q18QEd9MbFNxkP/jiG4ojM3mVd6CPJP9M5JJhmeC984DoLGDOLv+JqT2+YUt+qz2wQCFc8r3rjxh4/D1QlYXbpHcVQpIkNz8fuTcAvEbWQX1FObXSFoq8Y7so/Elzz6PeQbeievS4pC2JV/F8z/wC1QlP1hFoEGVrD68esqIW/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762621920; c=relaxed/simple;
	bh=GSsG8tR75NceTXNlQ7NqhwVUDThtcdr8H15LvkKspyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHWaP94ewbSgswOykAhMp5Ndx+gg+9Hbih4J1OPl6ONXCW6s7jI/gdnWCnO9e/1v2gtZ9bfpCJ5Xxg1ExrmgHRpBTMshIy9IhKJB1Nsu8sjjn27FWnWF3D07afix93UDj3e4CzcSIQ9wHASDcAEEo7q7hgMJI+bMxBaVphG5vTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk0TqtFs; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk0TqtFs"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-93e7d3648a8so67129639f.2
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 09:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762621918; x=1763226718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQlQQ20ICe8XpYcaljFOMaVFQHQK/OIZ8lTVDqDq/B8=;
        b=Uk0TqtFsFdLm+pVN4bGQSdapkBS35Mx1QHBHuqQMb3ktN1pRvs5JpKLXVrEo8f//oY
         guMkQwp8WT+nnJrtKDQoAQPK0YIsplHNAiDb/NPKe0SJr/k9ewl0WXr57TZmTGqMfnsz
         mzLslamq94lMNvqN96JZR6xuEcvjeH+9GfEBTa9iGVYeurSB2bNLXVzROxM31BjFHHLH
         44YowrRKg4o7wqfonM/m01rqmO0z/kNzxbIW6o2eRlDNJVzHriKZndVsw3YtEjUE05QL
         hSj5pAenpx0ysv/77vYRQfo1OeVzw4LbiFO5xrpUqSOnwjVP6ywCjSR92ZDLhKZMke/c
         Z6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762621918; x=1763226718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQlQQ20ICe8XpYcaljFOMaVFQHQK/OIZ8lTVDqDq/B8=;
        b=ZmRBJsN7pnlAtCrAgWMGiQEZCSTXq+UrtIeyjbtao3guPB92aE5ZyI2cCT3cHqB5S6
         sGP2iou3fKOwuswWG2KK00FYVW9dYs+xJqaOWY6Dho4abYPx9xIjMLMbaEcVBTKMxi6+
         4MNL+WIhos+rnSUq9z5SCcV0WABzgTeAHjSe7AAepKJBsTEtvx+fYNn0mjpwRE05n4wx
         9oWRTYl3SDT3N9eUPqWSL3YokZD3mvBeQwiBcqQUeaBXdaw5k0k3sLBQQvzmQRJ/Sjv9
         D/n9VKUvyExEkqPM/RxIlxp2MvEs9GAyDaXCiUDVE7vov05b0O5DrNfesBwYhoWJSNz9
         RXXw==
X-Gm-Message-State: AOJu0Yw/iMppzg1cZgH1voAnp6xzDcz89U2Pahe3Z96uh1L5Oq2KE8fe
	GW/R504VE81echiQaTw/YTcD+G2Gur9WNYcaW5sDregnk1rEkjIohf7tJHa4ylA52dZCPLuR7o+
	KzbJ+HF5WnG1p+CkOkJe2LmwE93naoow=
X-Gm-Gg: ASbGncvU4L3sNDow4QWGr19PgtO0FRgDObfwwY41bwq5DubugULhYsosoPjn/g4KMOF
	TU21fmx9/kYzCzSycO0aqZV5A7YTSAhtvaIiuvv49+pQG87SmGonNmFU3ijLBH4n81Vx7pVft/A
	q/ABwN879BdbnC58Cq59n0ju/DC5yTh7au7ujsUXCAakadACOaueMnyC4LmCZJmCKPlm16QzZn+
	U8k1lNy27OMdBRNi3UC4Cl2YwIU8Dh90yUtdZfYxDVWjR2GiQvXgY+2/GaEy6rVYJK80YQ2DR0=
X-Google-Smtp-Source: AGHT+IHNOjKV9XAkPc7FBLKFDil9xyrmryrdUUO7Eb94LYehtSOniadyMPtouEkqEp8k8lggRwUz1MJ4Pxm975Pe8qY=
X-Received: by 2002:a05:6602:4912:b0:948:81a5:7ac9 with SMTP id
 ca18e2360f4ac-94896050570mr303473339f.18.1762621917807; Sat, 08 Nov 2025
 09:11:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030191931.30837-1-siddharthasthana31@gmail.com>
 <20251105191650.89975-1-siddharthasthana31@gmail.com> <CABPp-BE+-EvQhRBQy22kt9+p8Zw2fOS4oR+UBRZAgcxRhaxS9A@mail.gmail.com>
 <0545bc77-8d69-4cf5-8d1c-ba59035eb556@gmail.com>
In-Reply-To: <0545bc77-8d69-4cf5-8d1c-ba59035eb556@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 8 Nov 2025 09:11:45 -0800
X-Gm-Features: AWmQ_bkDLS1GaICVvAjwfWRYWJhBLJQYGJVpnYE-DlPTh0tkXyAlnFZI2-tA__U
Message-ID: <CABPp-BFXvJQ9fj7zvj3brpcbzWxEXMFWeoVtQxMeNUrcbV9k+w@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] replay: make atomic ref updates the default
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, phillip.wood123@gmail.com, 
	phillip.wood@dunelm.org.uk, gitster@pobox.com, ps@pks.im, 
	karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com, 
	jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 5:22=E2=80=AFAM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:

> >> -:  ---------- > 3:  b7ebe1f534 replay: add replay.refAction config op=
tion
> > There was a third patch in v6, but it doesn't show up in your
> > range-diff?  Did you specify the range incorrectly by chance when you
> > generated this?
>
>
> The range-diff shows all three patches (1:1, 2:2, 3:3), but the third
> one appears as a new addition (-: =E2=86=92 3:) because it underwent sign=
ificant
> restructuring between v6 and v7. The config-related changes were moved
> around between commits, making git see it as essentially new rather than
> modified.

No, the range diff does not show all three patches for v6, it only
shows all three patches for v7.  If you had all three patches shown
for both versions, and the third had undergone significant
restructuring, then you would expect to see two lines such as:

3:  6b2a44c72c < -:  -----------  replay: add replay.refAction config optio=
n
-:  ----------- > 3:  b7ebe1f534 replay: add replay.refAction config option

The first line (missing from your range-diff) would correspond to the
third patch from v6 being treated as deleted, and the second (present
in your range-diff) would represent the third patch from v7 being
considered an addition.  You can verify the first line is missing from
your range-diff by searching for "3:" in
https://lore.kernel.org/git/20251105191650.89975-1-siddharthasthana31@gmail=
.com/
-- you only get one hit instead of the expected two -- which suggests
you either didn't pass the correct range to range-diff or snipped part
of the output when pasting to your email.  In this case it doesn't
matter much, because even if the 3rd patch from v6 was there we'd need
to go an look at the individual patch due to the restructuring, but it
was just a little odd so I pointed it out.
