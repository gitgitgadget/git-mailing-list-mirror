Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBF01AD9E8
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699891; cv=none; b=AGgDoTnP52KgMuAq4698tiv9eDa4EcbgKs/ZkUSFcNe7ekVIjWb7963Jd7Zya/+RmCkifgtn0DQ3Tbihl/2cwTta8EvwP6MNeYL7elP/BN3Ip2Ly7ZBmOeO2gJDkJCUCgd8hfDz38R0GZY6CkZUQRPchKWwCIgGJmAVaDTcRAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699891; c=relaxed/simple;
	bh=cBlh8k0kaFL3oglMQX3DrZpNy/tyncwmYzop+ykQmLc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItU/Mu6zM2ofe6My4FivlxqEOPx82yVcJi0v1zMRVa0Ka2oUTyWJt2qPGJyxn9DaXcbgzNQ+TR6Cs3j7hwBdfovPRHmEQn0Sk4A1cg/oQsEL7Nv1XVTYHjLE89vI9yZIOCi4S8UY5K/Y6EQNHqYJqTtKFvFccgB8MCnebhRSTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7a0rLbc; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7a0rLbc"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d21c4eec2dso2727211b6e.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 01:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718699889; x=1719304689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=N1oucDH2sxzlFXDjTzj9rMb4Ea63B7v3wsZxG7Z++wE=;
        b=Z7a0rLbcKONFUUBBZ0IF72x6t/Kg8BhI35XY17YF+S91+LzC5PW3kRQ69wMRI9GhZ0
         cbikDa93Dw/J4gTGfViDi69wAkY0eislm0pP3djRsvjnPm9QYIdiUc4To41NIylbos+l
         1royVCSVTSuHyW+m63hJhHihdXoKwEO3+xTmFPmUdU3/MqdF7enaUED28JFSkcfH2xXx
         oVhIVnU9yoQ6x2A3kFt/ZLTRYPTNQotTgTlOcLL03A3EcA9u4Cxk4H+b2v3/ZTM34vT2
         xmrpRMQkMs5t5SlV8/oQjHFO1BMjTwTaYZk9cS9+0X6cmAknoeKfeqo8YZjgYu7DWjxN
         THfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718699889; x=1719304689;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1oucDH2sxzlFXDjTzj9rMb4Ea63B7v3wsZxG7Z++wE=;
        b=sYKtcwn3lJEY8A0KCq3jiyXa8Fm3i2EVla0HE5DgrRQhH4WGBUbtSVi7aubcO1n2/x
         mwHJ26hX9l9MSeWRHt43Argfkv25aNgGFnW/7GMySSNJfYSMBJgGiCxpKifeNLdOWSzx
         lSx78sVgKpNIIeN4mCr4EuaRy73CEugBtNWK9KFc0Rq0uYGnhvJTtGRn20rPD48Yqou5
         uB/sq+uY+wa6Y3RLaTBouNWc4nUh4Im/eppWqp76cONvdNI2KX2Q+T56aeOnVf0k2Dyq
         HM5+OS28KBkmxeM10gtEaYHfRIsvDKH0wsSQ7rDZPvoGhaDgTKwuC6U4j29fKskUsqDj
         Pvvg==
X-Forwarded-Encrypted: i=1; AJvYcCU76Kmbrgv3nTmKzYuP7rSkOtwg7IE1sT59XuEf9wPjiOjtBnfXO/76cvXz7z7gvWtXEMrETpL/QjbkET+vbNWAEEta
X-Gm-Message-State: AOJu0YyGXjlldxENQkY2qL3iYnT9EadmvT5h9w7dOh6+5pKxG0b1H/AG
	u6iPYGJUL/O4cmLHz4YNpPBz4/idlyKtShrrlUHmlsfUGnSkRvh22ZE4RLk0XOD+UtaOkRpz8q6
	IY3BSTXijkVbMNlP9WInH92nV6ds=
X-Google-Smtp-Source: AGHT+IHRTiJvbU9rm6zCUbu61AwCNYzhMTOQsPfB3t0E2rGcYgjiypzfV7eVGmPEZXybLMbuG3LnbJjbdJszugLgLCM=
X-Received: by 2002:a05:6870:9589:b0:254:7f9f:3f21 with SMTP id
 586e51a60fabf-258429989dcmr13669558fac.27.1718699888891; Tue, 18 Jun 2024
 01:38:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Jun 2024 04:38:07 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZnFCEYypdAyXMMlg@ArchLinux>
References: <ZnFCEYypdAyXMMlg@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Jun 2024 04:38:07 -0400
Message-ID: <CAOLa=ZS57EsZk+7xOW9imbA4oWANKf0b+HxBZ8hGFaQQkCsvcQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3 1/7] fsck: add refs check interfaces to interface
 with fsck error levels
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="0000000000005a74fc061b260099"

--0000000000005a74fc061b260099
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

[snip]

>  struct fsck_options {
> +	/*
> +	 * Reorder the fields to allow `fsck_ref_options` to use
> +	 * the interfaces using `struct fsck_options`.
> +	 */

Why is this added? It makes sense to have it in the commit message
because it talks about the change, but why make it persistent in the
code?

[snip]

--0000000000005a74fc061b260099
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 72c82ca92bbc2714_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aeFIyNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOGVRQy85OWx3bEJPNTVqL2JSZ2dScG5PVU9KcnRLVQpCemNEcXhzbDZF
NUxNVWhySTUvV0Z5T0R5ME56VG9UTStVOEF4eGpjQi9IUlRhT2I4MXF2bHhsT25STUhlWWlUClFD
NWlZanVKVDJzRENWUUNXc2t4WmM0eUFKK3ZFT1l2d3dlOWMxNnRPZGh4U2ZodmhvbDJDVFR3L2JH
TGhDblUKQUJPaGRLM2NjU1dzNG1yZFlBemVSdEJUR0dGQ0swTGhjRW5KM0RjZ3V4MXB1RGpNbFUz
dVpYRUt2c3hIT1RFRApucXVVNHVRR3lvWFh0UC8zaEFsVVFQdkR5QVJQT3pTTTBLY1pvTW9VRlVC
L3lTMXgrUVJ2UERpMXlvbU44OUZjCnNUbXRvallQM2RUWWdOSTQ1WmRxaFJmci83TXc1RFFOYmtk
Wk5hWGJkTzdRTjZyMi9Vd25iY0Fna0VGZW5rcU4KU0tmaW9WZlo0SDBWVzJnejkzaE1qbFA2YkQx
OEtmR0lQSGQ2RFBVekczVEl0Z2pLT0FTM0RHQ3pTUkVXZnF6bAorUU15SlZzRFRnS1Z5TlBHMkVJ
TktLM05BRHVGSi9JcjBJT3NLc1lLcDV0YStrUFNkSEFTQ1ZyeVZraU9OcTZECnNQYUJEdU5FMkF4
ZWlST0RUQlJYQTBPTVEyVjhhSTU3MW9EeDRNVT0KPTNmU0oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005a74fc061b260099--
