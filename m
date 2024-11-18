Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE43119644B
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940247; cv=none; b=cqWEGBNv4gPccFW44+8pQ0edwR4TbNNSVrFSz97KzgYz9m2LFuNbE/OtsqGab1DrednviA5hHOIslggfVPBXXvYnQGXww3JT5skWkQwlz+ilii23l8X3S3XBNVzL83yzgSYfxSgthA6r2RIsC26nV8CMjfF7rzM5U9UfH5227GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940247; c=relaxed/simple;
	bh=iBRHQAMYe5PZnajbd52D+uBiIzrVg7K0T0XaLzSgVLU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ia9McHM2fEjyBFwYs/cKrHeDNeAawWsrkXNY7NfCDz8Uk2DmflMG3YDBcFEbXpu98yErNlDtqKmdQTG1nsgTTFT74dV+XYhXu68Qwq+EVKBMMkNgKyHBjlwoIL1ZB25BiINlqioOkuPQBMaDEMiw0ANjvkNT52L+e/NYDkSJXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9skmiYG; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9skmiYG"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5146695d946so3064443e0c.1
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 06:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731940245; x=1732545045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EyWsvEjkrG7ufgiKtGgBqrLQcsy6Ono7vaprb02Xf1k=;
        b=g9skmiYGdYI6ZglUkbCWPMPgSKwF9/xZ/MRCjSt8r1HEurzUbprO4rOKro3GyoJraB
         5QFSklbUuiQkhhYs+111ykPlTsd2IxR29kLIAmLaUxPmOED2t69udq6etqOLA7DwfVN6
         nX7QIXgo0utNs86knonoae1OlP6WVil5l3dnUaKy9oAUC04oNb6dVnxXUlithNzWeTwh
         6iN67jzcwfcPOjwUGgaIn4CZBkN1TASsayimNYIV39Pfj3BzWfmHV2l01BKDmMKjQF5N
         p0ETyVm7eK8ifqxZDhsQEYsjxA74qO9pFqS1dj0C2c24s3ZPPDCKbMuPI40XddbnSGg6
         KKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940245; x=1732545045;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyWsvEjkrG7ufgiKtGgBqrLQcsy6Ono7vaprb02Xf1k=;
        b=le72D0yrjKUWslgk/Vc43N79FCKLthnVr1oYewovyuBF5AQAStQ4JTxIHNu84qesvl
         5hM3E4kzB0VePsJiY6wnwQzmgFs1ip+9ak2h4sML34x+kjM1WhsOYTKfM9pi1Ld/kUYC
         UT9fnqla5Gn9jF0ezVbOi7ryv33ouz/E6EQI/Syu0Scu4lKaHedbuZqWu2ajoLI7m28p
         xgjmX76l9HoiGNqgW+q6Wx0i96otcE+v/db5Oi1Om0vgqLt6mtvhalFlbgljCPlYEhU0
         oxOA0htOANCMEgyz9dxcVYUMMPFiU/xLdQbgEqTTMbMamHNI2NGCFXB84c20cx9cnUJO
         Y4qA==
X-Forwarded-Encrypted: i=1; AJvYcCUyIOToPyMZT/j5n3A3SjRlEO+sPAylmsBabBjB9XKrrE4AM2UzMWvCwRwSpTR34ndJLAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPgGqbpwkjflX9qaf1dcsrz3TyidZ7IXS3vSD9xx0Tasa7AUhC
	FcuxindKxD709ZDYTzohYTrZ7ATmg/X4lOtyPtsR92tc+2cdP5ta4EVynDUR65MiRwExLvspE28
	ZgSWtB/z+Apmor2J2e5JZxosv4m/MMzy2
X-Google-Smtp-Source: AGHT+IHtDL1dW+8qsq2p+S4Jt9PMEfTMZ0zGdHID1W49aSD4EsSSPwNMyoNkMuvEvp5C5WuQZdbz7LIiW4GwImQlmEA=
X-Received: by 2002:a05:6122:1d47:b0:50d:39aa:7881 with SMTP id
 71dfb90a1353d-51477c9a10fmr9574722e0c.0.1731940244820; Mon, 18 Nov 2024
 06:30:44 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Nov 2024 14:30:44 +0000
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1731047193.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im> <cover.1731047193.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 14:30:44 +0000
Message-ID: <CAOLa=ZQxtQ9zBqN9U8ZnxaQ+uyMqQ1EnfEL9Br918y6CBxtvVQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] reftable: stop using Git subsystems
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000010be52062730c33d"

--00000000000010be52062730c33d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the second version of my patch series that continues to detangle
> the reftable library from the Git codebase.
>
> Changes compared to v1:
>
>   - Fix a commit message typo.
>
>   - Document the values of the newly introduced reftable format IDs.
>
>   - Include "reftable-basics.h" instead of "basics.h".
>
>   - Adapt `stack_fsync()` to take write options as input instead of the
>     whole stack.
>
> Thanks!
>

[snip]

I went through the patches and I think it looks great!

- Karthik

--00000000000010be52062730c33d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8f148926049fb1d7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jN1Q1SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUJEQy85ajlLSVNRcEQ0K0FQVEtteW5od1l3aENpTgp4OU9HYWVxM29q
SG16ZmM4VUNpYkxEQkpDU1V5RWFGT291QjN5ZmlrWFBORGRZRzlvcUp1Y1NzbU1lVXBVd0w3CnZV
Z2tUK2FMeVZwSTJvWEs0NVdnUnhhVkhQU1FQbjJ4MDl1R1dlOFJWREZXMlRyVlBMdE8xblhVS0l1
SkExTnYKN05pS3VjalRNT0lBNzlzcUl5Q1R1cW55endWSllUdzkxSmdGdis3a0J1cmZsOEpIT3Qw
Qm15bndpWTlLR0hiZgpuOTlvN3ZrZlF4Z3RqL21POGxlU2RlejhGNjNxMWlPNXFlU1d3OXRlNndI
b3J4VENDWXo0RUY2Y1Q3bGxUVTExCjdLUEJFeVU5YmFzdXJnNVlRS0dnSmFSQThNcjZDRlZ0dzQw
bmVwVit5WFN2MzVaeTdzUjZZSnE0cDlLbll3c2IKSHhQVTNsWHFxTUtDV25WTng4Qks0c2hUNDh6
UVpCNHNsMmlDWEVtSkxzODdJT2JTMnBhN1JleFFvaUVXbDhqaQpaY2l5VXFBR0RyaExEWWhnSEdO
MXNYQkRqeHZ3YVhKaFhyMDdiMjVXckFXVXlNa2loZGxqQVVqMFVCQzFTK2VBCmh1d0lNWW5FZXB5
ZmdNbHhQTUkxUTRmWnExdk5kUU1pbmRQQ1JyZz0KPXE5R2MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000010be52062730c33d--
