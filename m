Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE3D1BFDF6
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228207; cv=none; b=gvYyDIYJmpp92ScRtkVfh/kuwrEdqYFnhGAb5mgbwe4wQwoGVcE1RIeBCq+cSwIVNHYi7pdv83yXZNx9eiVTiotUsz79hKfXsvZJ1T1GHtK9pAGoxBKLVUN3UWDl5wKLMbxpw2avD37ZWFko8dp2KdgKwvSZcVQP4mHOeIjrU3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228207; c=relaxed/simple;
	bh=MjFYcM2+qTEa4xMysyod/+Vo3IBwqXgxzYGCAI05g+A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlwzqFYkACZf5WV3JPwQRWMBm4HmZn/fZXNlqtLPXhnFgWETMtgt+phEjWiqs00qaFH8AUm6CdijbtLqpYzpCwyFPeVF7t/QeSj6Ux6DE83xUyfDoQB3PQDOwc2AEWC0i/kA9DW4jlOoodyd8SvnusdtuaDrH4xejM5nVwAxPY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HK31hm9+; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK31hm9+"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-846bec788f0so245918241.1
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 04:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726228205; x=1726833005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qSkRDnLOgIrATLhG9Rzv2kHQy1rBzjSIJNFcMbR1ni0=;
        b=HK31hm9+5bvM1sTCDmhUKqR4HiCBRZONh8J12Ih1jtH8BHvGlXakSRacL9w2FZ1Ea3
         p1ZgjI9I0jrWFjFLFvnzGCRmdSirF78VftnYikYmWY9PwL2VZ9JcKl7iMyIRYQc3jxAP
         qMcsQFBQmpwXbcUF0mafSkQpXR7kMkk/fMlsZeT4fuuRNDtBTnnUNk9djbSZPec+LMSS
         ahT1oyf6n72NRQBWjZ5JbF4B35n/7oo7XVJoJ+TzTBXxjnjnm9paNyabQzFzWnxtz6WR
         o/abvfc6KSggratP4F7OIRzFIZZKzpVevJpvMet5FeZ85PZKrf0l58iauJYMiA5oJ4nr
         H2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228205; x=1726833005;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qSkRDnLOgIrATLhG9Rzv2kHQy1rBzjSIJNFcMbR1ni0=;
        b=OH0HkBcmA4zIccDzkHhT5gNO2THScY9WNgTB7NQ7Ums2i+M0soHLQM3o6Z78uY5WpX
         1mxxY2OIupp6MX819I8/a6f9vjL80Db4WXfUaAgnminYqqXeE+6/6jc2mVTVe0VOKlKc
         7yTihrxlnvu5bhndbrMUiPDSs0DRyqEQtY8BNSqcY1lkhVDzhcpGh3K2JJXIR5PdulIm
         lBJ/k47bpqzfCK+/598/5/seJen9rTmrwytaOTTzYYw+L/uT65uJ33ke1j+P+iF6KRIk
         jJ1OWIlnOG3bw8ZEpGml4fuj01b/VCtyzs4s9LzhqCs/QjQEnqSzSIppIrjPjt71Saty
         +/1A==
X-Forwarded-Encrypted: i=1; AJvYcCWIgUFOWVWF+W1wZGWx/ksBsEJdYq4ebAIIq/dIfQhFm921tKmo8yCoB3wmRHA+4nK/FCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxltY3VFlBhJw/bQ5Xy6zWWsRygf9j9WiGw0GqwzmhzSRmyCZv4
	SoN4hDJECkDmuS7+SVB9y+CWL/AlB6TVXDRdmX2sTBAUK2a5/cXq4oL75dMzqdXDmb/G9DrWBI4
	sCzacoRPs7RqOu+kRwEMcRYJFXGA=
X-Google-Smtp-Source: AGHT+IEmJPCljbvQSNGbD3FjkMBfwfZQnJBvgELMvAI5a4AXSOjMqITYDHLLIgF5XSX7X2V3o3veCu0XzljYU6qAk70=
X-Received: by 2002:a05:6102:f0f:b0:49d:433b:a601 with SMTP id
 ada2fe7eead31-49d4f5ef238mr1737833137.10.1726228205263; Fri, 13 Sep 2024
 04:50:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Sep 2024 06:50:04 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <0317a5a7edeab29b7cad31d11140bd99f459144f.1725881266.git.ps@pks.im>
References: <cover.1725881266.git.ps@pks.im> <0317a5a7edeab29b7cad31d11140bd99f459144f.1725881266.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Sep 2024 06:50:04 -0500
Message-ID: <CAOLa=ZSf01hsh+jX_ubRfKLAomQr4_Ub7U5Mvht-CZ9=kj-nNQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] builtin/receive-pack: fix exclude patterns when
 announcing refs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="000000000000fa19920621fed22f"

--000000000000fa19920621fed22f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 3f35140e489..478c62ca836 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -339,12 +339,26 @@ static void show_one_alternate_ref(const struct object_id *oid,
>  static void write_head_info(void)
>  {
>  	static struct oidset seen = OIDSET_INIT;
> +	struct strvec excludes_vector = STRVEC_INIT;
> +	const char **exclude_patterns;
> +
> +	/*
> +	 * We need access to the reference names both with and without their
> +	 * namespace and thus cannot use `refs_for_each_namespaced_ref()`. We
> +	 * thus have to adapt exclude patterns to carry the namespace prefix
> +	 * ourselves.
> +	 */
> +	exclude_patterns = get_namespaced_exclude_patterns(
> +		hidden_refs_to_excludes(&hidden_refs),
> +		get_git_namespace(), &excludes_vector);
>

Nit: So we do use it here, might be worth pointing out in the previous commit.

[snip]

--000000000000fa19920621fed22f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7f8c5b9e8342d7f9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ia0p1Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0xpQy85MTlGeHJYQkNhelNSTDVXZkhtQ1BnVWNrbApwNndPdWhOWit1
dk1tVnRTVVFOaXBEaGhZTVFRTlowdWJGcEg1a3gwWjhDdkNMZXBDcjcxTUtZbDJDQjZuQlIrCmd0
OUdZcjZURFlha1RzOTFKOE45ZFhRWjJoZWJQalZQR2RVUkdIWlBUQ1drOTJDNzNRN0hhOW43L09C
dVFoenoKdGh6V05lR2U5TDNqYk9Qd1JVR1U3MEduNkJFRW8rNDBZejlUSnVFVllCdHZkYzhkVEc3
YTlYZHo2enN1UHE2cQptNEszdWtLYy83eERzNE9tT1VFbzAzQmI2bzVNbTZQUFhoUzZkdTBGeFhQ
TjZlZFp0VWl6T2JOSUhJUTZjbXY2CklDTGhhWlh2Z1dISDJrNGhoVVdjV3YyN0Z1WWZkM2sxbVoz
eHBQdEh4WndaSTRCRHVuZTZaM0V2cGVZVENleHIKWGJ1ZWZNYWRUbXlwSjk5MmFPTWdmVTA2TzBs
cTY2a0dmVkFGL3VFY1liUmFvSFVrZWhUc2FVQ2gwMWNOOVcrcQpyV0xiMU1ST0NnQS9LT3JYMTBq
ek1xYjZOMDFyU0Z5U3hmZkxyQ2JXOFBlWEZiNXBDS0lSc25GYlppaGFyQUlVClo4V3owdkhLQzNM
NHF1Y2V3Wmg1M3M4YmM2MDdkTlEyc2pYS3YyQT0KPUN5Y2IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fa19920621fed22f--
