Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA8C187849
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231685; cv=none; b=tg7nD5m0pEHa9TBgL5ia7f/7u5EACE/8pvShi8//E1PWONAfr2PRANvxZDrt74Nm+oc3svhttQg1PDhxCkYzVbqOn3Cdy9U4hzDx4LLCJPsulImezEYS/pzqauImtZyqzIpGcXZOkwR6w9kqqYVnlNst5C60rOfAAhAHLT6gicM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231685; c=relaxed/simple;
	bh=mEzHiYzlzdsk7vin7Sz1QLs2PIgaqWZy5Vl1EkLRifU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmXmAcZUL3S2CJ6c7BduxE9JLxkUCNz7E4ubBFM3RMvnQeeBDxUIuU4ZNtL+rkZhL+WI+Gm3Jj/dn6ldPsndktzdK8YewClak/y7XGeh7cpHJFfzYRekCLTbHfy0G9AZ7RQRmdfIOtOGr6+09gbxx/WkcwgExFROvnxa1ExSlYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqglcE8Z; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqglcE8Z"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-49becc93d6aso581042137.1
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 05:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726231683; x=1726836483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=owMLQJlkJX5od8KtGi/52kztbl7jTrY3EP9U2Z8+sbM=;
        b=ZqglcE8Z2mnEnF7HZ3dJmOj3YsiBRtTbBvAy9zznMApHy2wBa9/XNl8uuYpi8ARLlc
         Dx3jfvEIS7RxBZ2PfqEA1Tq1b0Pz9vKv5CJjWi/OM5SquLuPGLAtmY1mFKqpJoiPgYCX
         TUemD8ANSAFlcTbYf4FFp1RyRUlHDsnC/1jcOrjt00pr/3UF8iWrw2jGrJaQdDheWShx
         1PagdBVVXv0H3d14D1h9qaMWnVc7LucxKjoBNMrrBc/0IAHg52lgqIXXH8oloUfj4okk
         WqNlfpVAhCZ0R1wmlFmPZPbMw/Eb/caR4qPPqPgMjUT9jd8k+L9Q9smvtvpu40NjVsFB
         q/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726231683; x=1726836483;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owMLQJlkJX5od8KtGi/52kztbl7jTrY3EP9U2Z8+sbM=;
        b=sXxGIr7A4FBnHDfyN0bU6cx8o3pm7QpPbdM+xDA5DQeyQ+VRj03qZhokzlF0nFqGUy
         cNO1icAtqY/R9WGYuIJS6oqZHxkv/m0O0o2Zp7iRat56QBsZ/zSnx08R+KsCsiE5VF83
         7jxR5gzZB4Ccje8kR5LN9jZFg8e7WN7FklaLPcD6OX1WVViheKeS3BaudyP8ay+c6HsZ
         0rPlorYCGyb1ZBbRW04v7N9t9sre3z/ysATHfbR652hSmWBnSvSEcdthCI6s4GUpD/EV
         9qFF8E0TroglNjkixNmvBUbRxglszJ5AzDfr5mBBvy5Uz8s3BSKtNPZut9YDHabygWTS
         sVew==
X-Forwarded-Encrypted: i=1; AJvYcCWg88yMechzriaiirMeA5RjAoAiajeaWrOxSKMLdyD5QYPMClLTi1A//QVsv2pj+XW7+bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6p053cIY5wWUnyVJapXr6Wunl1ZvwPeBpldDjHpZaW0dsvbk
	PzVa2iITtPJ9kRTAhRHa+ytmExvS/9g7nLhdqPU/yfdfVggQ0ZFpF//yViI1gmlsWUtGnEFlw6Q
	lvVcQt81HpbIIru+f5Oipnn83nET/RcOh
X-Google-Smtp-Source: AGHT+IH1OvStZa0oGnhEsMzgcwWXbwkRMAK13vSdO73rGm8WBEKFAkG70duuEhCaUAh/Eq+xuoO9Nd/jwuwD1IcD2qk=
X-Received: by 2002:a05:6102:2acb:b0:498:d495:2cd7 with SMTP id
 ada2fe7eead31-49d414b171amr5262678137.14.1726231682729; Fri, 13 Sep 2024
 05:48:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Sep 2024 07:48:02 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1725881266.git.ps@pks.im>
References: <cover.1725881266.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Sep 2024 07:48:02 -0500
Message-ID: <CAOLa=ZS3XBG4_=D5rCkntJuU0tzV7t=rB95rkNvWgm++Q+xukg@mail.gmail.com>
Subject: Re: [PATCH 0/6] refs/reftable: wire up exclude patterns
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="0000000000003fef5e0621ffa2ab"

--0000000000003fef5e0621ffa2ab
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series wires up exclude patterns for the reftable backend.
> Exclude patterns allow the backend to skip references internally that
> match a specific pattern. This avoids having to read references that the
> caller would discard immediately anyway.
>
> The series is structured as follows:
>
>   - Patches 1 and 2 fix two separate bugs in how we currently handle
>     exclude patterns in combination with namespaces. We didn't happen to
>     stumble over these bugs before because exclude patterns are only
>     implemented for the "packed" backend. But once you start to pack
>     refs we exclude references based on their full name instead of the
>     name with the prefixed stripped. For the reftable backend we'd
>     always hit those bugs because it always uses exclude patterns when
>     passed.
>
>   - Patches 3 to 5 wire up proper re-seeking of reftable iterators and
>     adds some tests to demonstrate that this works as expected. This is
>     a prerequisite for handling exclude patterns.
>
>   - Patch 6 wires up exclude patterns in the reftable backend by
>     re-seeking iterators once we hit an excluded reference.
>
> Thanks!
>
> Patrick
>

This was a bit more intensive so I took my time with the review. Overall
I have some questions/comments. But the series looks good. Thanks!

Karthik

--0000000000003fef5e0621ffa2ab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9bbdf5adc222e9df_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ia05JQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNTVJREFDT2VETk1VRWl1Qk55YWU2UUFrY1U5OE0wVwp3NDNobjk2aUpv
M3Z2RXR5T3lyOGhmb2dhTDY4MDhFYjZ1TGRjR3dkZW9YNDNTZ0k1QTNHT1pidklqVGxUVXJhCnpv
MzBYS1hINUs3S3lCbGU5V2lGeFgxMHU4ZnE3SitBTVpJMHFMNmt6aFAwTm9GUy9uT1UrLzR4QjZH
ZU9INDQKMjVnYWNaWG9UVTJwNVY1N3RoQU43ejl5QXVHbzZKdkdnTVp5enJVQkFsakRvQ2MwODJE
SlJhaTB5aDJBQXhpeQo3Qys0K0FhMHhKNHVQckJnbEE3SHA2OVRCTmc3RDdvSTRDUUw2VUxmeDdC
RnRyK1plM01udElHOVJpNVZROVFHCkIrcWpEQ2w4ZnF6cjVkSmduNThWd1dMQ2JjVVhOMHF3SDQ5
Mno4Rm5XTjZZWjlmeVFINldUQXM1dm4wKzdHd3IKbFkzanF3T0E0ZjFTTWNScE03czdmY3MyQVgz
V3pWc2VPYXUwNFVSWGRabnJqQ2p0TnorMW5DeWJVRzBoakFaSwprcnFaUDZkTElYWlJrWmp0d2Jn
Y2lSY0JQeVFpeUpzYWZDTFZoTzdsZXZ2M1FJVjk2MzVnK1g0QUx2eGhSUGtkCkN1Zkc1VTVmUEtk
V3ZxRVJ0UFQzR1JubkRpeWlYaXUyWFg5QmZnRT0KPVU5TXoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003fef5e0621ffa2ab--
