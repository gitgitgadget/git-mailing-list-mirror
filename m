Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E843E1E47DB
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250098; cv=none; b=OzIw+XTr6pkXfH2MrmJro1ZxACJWI3eazFWh2csErQ6Wkk4eXHe3ijGMpcYhi4wjKCnHM03k25kAJS6Q5imr2aAX6XTahMv0GzJ2d+aB3I7ORgoMrBjUPwFl/1sejcaAyC3uyzhVehNRP0NSAnSUI2h20SbpgmkGyXlJojjRfpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250098; c=relaxed/simple;
	bh=NlVfKXDu6FIP17VONjM/YHs5y2Qzp+aUl0ZlVlEVXTA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Xz8S73ARHfASHTiT0WM7LJRuD6Pzes0UfeqxG/o+SqRblSwUfZ4CkvE8rj2qiPIKPoju1Fb/7etPcFh0apk8v8xjZ6EE1KjrLcdkMAZgI98s0Ej/SYtUAY1D0E2/ibs7E/2yyYOdcBEgThIza/nfDqbIQ5F7N5SHnraO9Jdpju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7c2cRlR; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7c2cRlR"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86112ab1ad4so3805138241.1
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 03:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736250094; x=1736854894; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NlVfKXDu6FIP17VONjM/YHs5y2Qzp+aUl0ZlVlEVXTA=;
        b=V7c2cRlR+b8Zw8OZxGX9a+McmAXSIfJReYjoDIZR9efbCt8rlDU55i5ZlEv4eD93k5
         kjsbwLsjYsDRUVAByNAyGzvsIWVuKpgPX/GTMzy529orMLbt2YRAOzj5hTQgPhVBA616
         hAubLE+xcQHXK1OrXyI8UTQIbWx/R79RFu67T2eK2KiZGgQoc/PiR2SUNWW4L+P6d5xU
         pSwwBx+Gbk+5XHH6P/ZPhEZm9WxIfuopabyAUWR2zlW0LLm30jG2YRjxpzlp6hYNigce
         Oa14fOcxiIlKnkkIqmlnyBJ1ot+P2LFqWm7rBmwH9K2nBRDoasJrGzKcgCbN5H77sgL2
         0GzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736250094; x=1736854894;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlVfKXDu6FIP17VONjM/YHs5y2Qzp+aUl0ZlVlEVXTA=;
        b=CLjLM6bjZGM0VmE3yajGYqpGgMSylO17kNfP46Ku1mWJTc9ol3Cb4pEl3oTTwY4Ik5
         HYjgaeJtXKPVGKEBdGaHAVjB8DLC3RRkVzr0zzOYVpiVX0Kma9/bVls9F8zpSMFaqpDw
         5iP+J+SQGl7BubZIGTAkJCPBGGOkDMpF7gGA2nI23eJhmgAencPlkE2RwYqoXBSriF/1
         2WEkh2cTuil9gnMa07G55rWb6+9Z9R/owSSm3JhjtKGjrOpSZKRnvnlDmw0cwpXPdx4N
         AZiO2LOYSRn3Z6jLJ5mcEWuplFNHV0+m6v+oJtVboWklJZhAcp4huDmfmpgL5+h7xZMS
         6nDw==
X-Forwarded-Encrypted: i=1; AJvYcCU0U3uyg0Cksp0B9o80oIwTHb/Ze+tcDozYwJ+3siLjyNXHjKUtjoTbDDcXFahRTxefIAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFI5ap/zU3PiPe4yEV5ktVTA7Yta+edP+GkzxStgypKoKC3E76
	WlB6r7pxkbWm8TKIFw59jVk5N6Mhshe7zhAwmAwTN5TTx63rXWFpU0M+qIWe+hVErUfREKBlq2c
	umY1Ue6DFrO4HAElcXmcPnNlwD3MmcZsi
X-Gm-Gg: ASbGncuHIeOl1MF7hkviQ1jyNoE2NpNvrWPZEJf6euyXPIwynhaT+bxH9vsNaKvcP/u
	BzQf/B0x2OCnB2bNx6kQdhnLXIzEi2C2dyms70yk=
X-Google-Smtp-Source: AGHT+IGE2YZ/GpgRxuzK/3rKnJyyVNp1d8Top7aRyGNfVTLEd5KjVG6LRj28UU+ZruwUbJTe6dyThgsNJqO94idhBm4=
X-Received: by 2002:a05:6102:e13:b0:4b2:4877:80f4 with SMTP id
 ada2fe7eead31-4b2cc116628mr52696413137.0.1736250093800; Tue, 07 Jan 2025
 03:41:33 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Jan 2025 06:41:33 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 7 Jan 2025 06:41:33 -0500
X-Gm-Features: AbW1kvYD_TDdNflVA1NP2kemv2f8Av_KXcohgHPbkvd0Z3d-6m5yqnpCsuV-X4A
Message-ID: <CAOLa=ZTn2vfmS480G2wnaMehoK6+Z7EZ3Wx=ctaaPjBetOkbcA@mail.gmail.com>
Subject: Re: [PATCH 00/14] Stop using `the_repository` in some trivial cases
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000152f7c062b1c3ae8"

--000000000000152f7c062b1c3ae8
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this small patch series performs some refactorings to stop using
> `the_repository` in several subsystems. There wasn't really any
> criterium for which subsystems I picked, except that all of them have
> been trivial to convert.
>
> In this patch series I'm merely bubbling up `the_repository` one more
> layer even though some calling contexts already have a repository
> available. For the sake of triviality I decided not to handle these
> cases though and instead let a future patch series worry about them.
>
> This series is built on v2.48.0-rc0 with ps/build-sign-compare at
> e03d2a9ccb (t/helper: don't depend on implicit wraparound, 2024-12-06)
> merged into it. There's a single merge conflict with 'seen' that can be
> solved like this:

I went through half of the patches a week ago, but got back to reading
through the series today.

The approach here is to simply bubble up the usage of `the_repository`
to upper layers and use `the_repository` there. The alternative approach
would be to try and resolve the dependency on the upper layers and not
use `the_repository`. This approach seems much safer. The patches look
good to me.

Thanks!

--000000000000152f7c062b1c3ae8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 413c04d14e128862_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kOUV1Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0ZXREFDQjhIWHBieEIyenJ1VDV3NEhaaEhsUFVIMwp2Qm9ZTUdpQSti
ZnlscVY3RGhnRlFqeEhxbDBseHZqNVdWZitHYlZTbU0xeVhYY3cvY0RMMmd5M0J4SW9LV04rCnZy
d3JEMG9YM216K2lSd2lnQytTcmpHYUkvWVcrZ0tuYW90cTZUVFY1R2p1VDlpODZFaGNTR2FsbElF
RVpqamUKZlFRZFpHeG5RM3ZFQndxUzh0RDZUeVUzOGs5RDZUU1VZL2U1b3RtUWFhdHFrSzBKQ2JZ
aDF5ZkFOWFpoTFNFaQpJWWlqZVVKNGQzS1FYSHgyaXNydnRoamo1V3FGV0tGRG5DaXc4djhSVEJj
Y0V5RXBKMnF3R2crZjBySWxGb0lICkE4b09ZamlCMWtwUEJpSm1DdDRRYTZDM1JYY2xxTWRFVGo4
NGhxdW1neG5zK2FtR3p4eEZIS0Q4MmpleGpTZTEKTG1qVDFIQnViZTQ1RGpscVcra0t5U2N4YTZS
YUpmc3E0V2ZYL2huNkhLanVyMGZReFZuMmVCL1YvY3grYUdRRwo5Um54WlF4TFRXcDg4WkdKS0ZP
Sk9RbWUxSGNuekF5eVFueDRTN1VyQm81eXBnK3FpNzB2THVDeXNtVDNoRWdMClo3bDV3TjdzY2ZM
WllMLzNTV3BpZGk5eENMdGRDYjBITlh5YnpkMD0KPUo0MWEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000152f7c062b1c3ae8--
