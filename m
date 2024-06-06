Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4DF194C80
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717671035; cv=none; b=UPqKIyS21a9WfhuTwRgIJcfmvIjynpaBSRlWlbnMai1gJnDSQpRg2o0h4/xpDNU/IeQiGIDMe7RhTPfZxVAMVBDSGfbE1Ijowak3aPF215M+4+rZgp0dediE/8ztsAm51dovkphsxHgWUgzOZbOKNYoZkN9EuAMh3ZHTaY8o3lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717671035; c=relaxed/simple;
	bh=ak0daiZnp0SfQ5zqF3+f3HJlyDfBexAfICE7YK2Faeg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=YwUy8G5LOHtexCVQGJ/atLW+zsczrF5KnlhfYkWpdyOLHxogx8I6ixEgBhNS0Lg1Eg1biC6iL115rQriR8X3d1R8K+fqqWjsc1fTdsvwmglnRuc/vZkdhq+Af2P9Qfr6WXV5iguo2tksFj78NByLh8o8z5e+EeTGTVqu2L9/mNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw64bqmS; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw64bqmS"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ba68cc920fso799629eaf.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 03:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717671033; x=1718275833; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ak0daiZnp0SfQ5zqF3+f3HJlyDfBexAfICE7YK2Faeg=;
        b=Rw64bqmSdjMtplvSKa8ov8QlexMadPLLk1AKhUSQpvCv7lBuWy78CkcbrU1w4EFXgH
         UJfhYiYGZbhI6+sfCCllIAFNlFF3Up+TGwJPErAS+suk5V+HEMrsdlcBSDWUM5zuWnAr
         7gI4op9jLzA8lThxSnNB47EhBq4xppfmxSUBvGL2ccLm8NbeMh4fzHjCGaq+fD1+shJn
         IBmvW1X1fcgRc6aFh1RN9vM8MM1tes90AiA6OKTvwnxrlQaUwkJMfvrxSVHXSfutQsX7
         PZhqasTnPPSxXSz+t7GqTa+OfMWfiFc55UUJGH6WE73JvZNnk4S+48A7dvWWnkPSkuCp
         iCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717671033; x=1718275833;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ak0daiZnp0SfQ5zqF3+f3HJlyDfBexAfICE7YK2Faeg=;
        b=OtQQb6zuUgcv2m0rZaO9eBBrFN/dN6hFxRQyu+t22IpVx8BHbryc6RK06Xsfu2/MRu
         gxxdI5tfunbvXm/7K3hVNS92Qr31V5US+JFBRXacj+xXEqNaNZssNKyMYpSyIDFNLRCb
         LYVYUAiz4U6CURolM2oOo3x+olfkhO7NTPxqVVYhK3LFReW+F1SB7ERVs92Slak5Nsjd
         R9NAtD/grd44uA4HdbgqO4cSp2FluzF2TT36gDCQ0LFZ2TJjgNsv/R+wJk+nne/0kTuD
         gbGBQM7xRLtnOB8/ZRn2TdeN/U6XDQtUcaDCis6gOlHxjy0j4fwT8EzqDtpeKYEZVqiY
         2JBg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Dmce4ye7iiJc8OED0FFZzPaK6lSgDajDpmYJik5mZs583KbHRqZXACVZGDFLweI8vE/6lMlTg2qg+T+/k4yL2SLi
X-Gm-Message-State: AOJu0Yz3l42Zb87LY4J70BmbGKRzOxDtYAf63HIJkhC5l6Fv+KUEd+k7
	48soyae2IYBk2pddg3EGjP1yrOuQ5NFv9oMZr8L4IjpzuPm87qqnDT3i6sgA1io00qzYdemsITv
	awgCwD0JHDXaZILBUKpokHVJgvSA=
X-Google-Smtp-Source: AGHT+IGmMCBywkjeaL8jxVImDyBtpffsYUmyClGS0WWRb8TE5SNS3Jijvc8QfkkZVZU40f/vwFYbQKjH75jEtL9EXCQ=
X-Received: by 2002:a05:6871:451:b0:250:8953:39dd with SMTP id
 586e51a60fabf-254408b1eccmr1079633fac.29.1717671033209; Thu, 06 Jun 2024
 03:50:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Jun 2024 10:50:32 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <930de119116355f0b6df9e7e1d5d0fe38d93755a.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im> <930de119116355f0b6df9e7e1d5d0fe38d93755a.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Jun 2024 10:50:32 +0000
Message-ID: <CAOLa=ZQ5qN9+GGp2Cmks+J2dCbZpNvd0ZEGTWejedUCtzXF9Ew@mail.gmail.com>
Subject: Re: [PATCH 13/29] merge-recursive: fix memory leak when finalizing merge
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c6a1d4061a3673d2"

--000000000000c6a1d4061a3673d2
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We do not free some members of `struct merge_options`' private data.

Nit: s/`struct merge_options`'/`struct merge_options`'s/

[snip]

--000000000000c6a1d4061a3673d2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 64db4f8ab49f7c42_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aaGxIWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdzllREFDVzJYRndKTFFXdk5sOEVmbEtQYnRjb1ZaeApQbk1uYkxyVUF5
WjJuYlpYUkltTG5yaFpsbVBwNnNERFNzQVBLaTdrNHZ2TzZqeS9KT3U1VlZiLzRlZlJHYS85CllF
MWl5MlRqdWthVTgzMmR2Y3F0NmY4STh0VmlsVnUxb3lwMm03WGtlNVlVTSt2WTkrYm9tNmJ4VElV
YUtZSGkKM0I2Zi9Kc0U0QUp5YU4vTDAvc0FuRFR1TWxXeHc1ckFVdUp6M215azRiRTFZSStqNWg0
bUZWYUJiRFJvRVB3VQpFSTFTRTZTNE5Zd0owT2JSV1JvS0RjRnBqVVpoZTZIc0F5cXd4TkU4dzk3
dHR0WGlSdklzR3RWU2pQaE5Ha1prCkxOMTNycEZxNHFPRmpvV29mMVFEajd5a1p5cWthQkZTQ1Fr
bmM1K3V0bXk4WmcwVlVheUV0M0hYQ1lMN0g3aHIKYm5iK09yUlFyUmhwdU5yUGdwWDVaQVFLaUpu
dTJOS0hjbEJZcCtFZW1zOE9NS2RBYXFSZ3hIQ1NGZURUMGlLMQpPR0JiQk5aNkN3ZFdzeU53dXVr
NXRjM1MvS01mUjRnSlpka2xiTjdwMElYZG5xZ0F1THppSkxaMjk3OWVMWUhpCkdocWVIZVUrbjBE
VnE1S09VNThlbVRIbGdoYVZzbWtERlBrVEZtWT0KPXV3NWkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c6a1d4061a3673d2--
