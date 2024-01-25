Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAA950A93
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187941; cv=none; b=a2peSDkAKWW/WU9cYOsoSGaJcIK5R+8uLaE0/dCPVSKm/mMs842HHDG7KvV6n4WMhnWvwa5PoKDY8LYcL+ETZmi5ikGUEdDvxdqXwsqA5mbUUtE0YG7EKwCisdQAdy9P9Fkxn1NJDn9xE3R54N7igma1UkqTHOqofYN7j3REUvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187941; c=relaxed/simple;
	bh=hSCk0NkhSe3AMXqIWwPKb/0c3KSPk2uQfX9hS193qG4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=gCjvbepcoguRVpHqpvYMNSJTTtZXuUA5TB11IWoOlpSy+nEIc2LmdIPhYcDgc2fiOF1NxZkXHqa9pR0QDqtq+Kj91QrXCDyYRdFuuW33lKpRmvPO/w2XYtcyrCq3RcicAkM8MafITjdYSSt4OzI2agY7RB7YIxEQJPa5kBbM8kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGhYkC3w; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGhYkC3w"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-210dec2442eso2657795fac.2
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 05:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706187939; x=1706792739; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hSCk0NkhSe3AMXqIWwPKb/0c3KSPk2uQfX9hS193qG4=;
        b=LGhYkC3w9bNrZHIpawyee65IG2IvGtbqL7krUbfcNtB+LyKu+sWge6re2Vk+fFutCK
         uaOpY/efp1GQRKfnERuN3j4VdpNK1zXnkhtNudIaVDdiciLwZIIc+LtChDfiVC1JTTOb
         7SmJlRYc55rqiXQlu7i4qtGjgC3MGdMVCNKAUxE12rcCoRF518StVZDi0mT0M+Uujdnb
         2GJveEu7OuHBkxDh7kYxM78xuOJD9kdn6NPJsJbUEVkOH8nMh6CiXmADWOvDsJp1CXuf
         O6Tl+WV6OX7C3zI0fvU+63mD7QzQVYUDHh13KxDt1kG9ku0QQUfXh1WIoGORlo/4KIHG
         6uiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706187939; x=1706792739;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSCk0NkhSe3AMXqIWwPKb/0c3KSPk2uQfX9hS193qG4=;
        b=e04U/pslLhKphgD/SEp/Axs3IigjB/aLnfkLcWA7ZODSbGmWr3gw9ivLb1yTRal5Sj
         p7VT3Y1EZLo0gy+0SqOL5isfKCE2+wEd85c5L9lte84JEWEOqph/wOYO5D5Zi+2FmvZa
         VyQoTmG3XrIgjgPtV4wRkJTcnuLWLzQuPnoHOPcl9dt1l9B7ux3KNbnKy73amcaOB/tL
         NEZZgLLVuasQx4UvO7OpNUmzVzjglKxBTXmDWsPnlN8PKEzSlZPokmoNInxa6e1pIMgB
         J64QLT/GkGVQJSuzdHMg5MwkWMF3arVwXqZaRSQrIMZVoGqT+zNDG9MuLPRNGk0FazKa
         /5Uw==
X-Gm-Message-State: AOJu0YwhqmHdMWyCc1p26Ho/0xfQDJqLx+mLFeYzJjIZzNm2Euclsr4W
	jpmPSJ7U7Tu6kInkmbl1H+saAy5jarbD2104SaXvUHa3QkC+0vNM/knkgjveVCkRNsCX9LVs8ez
	uryDwbuFOmXNIKnA2Kyu/m+lR7PSw0rWj
X-Google-Smtp-Source: AGHT+IGevB3N+cLNXSGJhE03yyg/vhiPHP8qXBNAx+gpPddYUMMtiXukDxFzef1UHI6bIM6f+/32DivcxBf1cEOvsmU=
X-Received: by 2002:a05:6870:9a0b:b0:210:9985:786d with SMTP id
 fo11-20020a0568709a0b00b002109985786dmr843333oab.34.1706187938681; Thu, 25
 Jan 2024 05:05:38 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 Jan 2024 13:05:37 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <b2fb6f5ad0c558527341bd8040544d6b0ae5d8a2.1706100744.git.ps@pks.im>
References: <cover.1706099090.git.ps@pks.im> <b2fb6f5ad0c558527341bd8040544d6b0ae5d8a2.1706100744.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 25 Jan 2024 13:05:37 +0000
Message-ID: <CAOLa=ZSDRr8v0uo2aCtdnbv0F=cFMQymnNLMTzpUt-OCdh5NMA@mail.gmail.com>
Subject: Re: [PATCH v2] reftable/stack: adjust permissions of compacted tables
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000016fbc060fc4d638"

--000000000000016fbc060fc4d638
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When creating a new compacted table from a range of preexisting ones we
> don't set the default permissions on the resulting table when specified
> by the user. This has the effect that the "core.sharedRepository" config
> will not be honored correctly.
>
> Fix this bug and add a test to catch this issue.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>
> Ugh, I totally forgot about the fact that fchmod(3P) isn't actually
> available on Windows. I've thus evicted the first patch and changed the
> second patch to use chmod(3P) instead. Too bad.
>

Good catch. This version looks good to me! Nothing to add :)

--000000000000016fbc060fc4d638
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4bf6f53d5bbc78a2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1XeVhKOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md2JQQy85M1l4N0ZlZkpFV1JyQ1dvTDZqVE95Z1kxTAovMGVsS2IvNVNp
YWNRUzRJQWlQbEttQVh0NVNGUWQyVGg0K3Z5YWZOeEMxZ0trdmMvTlFBV0xvWkhWdW5POU0wCnVh
M2hFWDdOL2JhN0hGaVRFWUF4b0kvUm1KaTNmbTJ4dUlLZ2c1djdNVC9tdHhpYWhNNjR2MG8zeFhF
cVZmVWgKWEZlU05KWGpZOFBhWE45K0tZK0wwby90d2l4Q3dveUZrdnEzMTNmU0JtL2cvcWlocUxP
eVBnQXk2eTFCa2JTeQpRWXFqWTg0dExtSmM5S3hNeDhNSVNzQzZ1ZUY5cjV6bjN1TEpZWTJobklR
R1h6clIxbklwa3ZMUzZUcWZ1NGowCkFaVzVUejZUNzdIZUFSK3lFRnd6YXU2M0V0M3dCRmwyOTQv
RHQ0NUorRGpTKy9JMHRUcnJYVUZOdEJmRXd2bHEKY3hpQVE2Yk1pM3VIMmpOS3dHcC9ScVkzRCs1
WnIvdDR5UEppRTRUWnJNZG5xSU1CSHNJUmpjMkNwa0Nrb1JtRApMTGRPanVDSnpJVkJCSTg2dGpv
QzBPOFh3cVFrQWFoVHp3aWlnSHBVem45bnd6T0JIQldZVE42aUJaMlgzV2ZHCitxZW9LSlFoQ2pN
by9ZTXVDeUJIMzN3ZEJnVUxLc1J1OW5jYi9tST0KPTFvYWwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000016fbc060fc4d638--
