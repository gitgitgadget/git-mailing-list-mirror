Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2C33E350
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763724066; cv=none; b=j01gm+4tjm+wk49O+dZjwvdRmOkQw5IKIhqeJliFfrZQpbeDCfF0HcVQS3/y2hHe/oFqRPBuDFfQ2QGJ85l0ZGF2XBaW3NetXE71uYG3eVu+5UyPXXiF8BXZqyJ4Rn2msTaNJPugjycsbjPVJ8EbqGQ8S0vJ7qAfQMW5TjptLy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763724066; c=relaxed/simple;
	bh=5Q69GXF/fSMDGejuvEUhZwXqJC4AhSBj3toMCtwlr2M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=knrth8MwtPD3eDf0SI/dBAdAd49FXhpvZ+y0NqfSU1ODqO3E2NmfXYKvJC/vyjDD+WWqg1oAe9cwl26igQ0wk1zgUS013Vw0bcYvQgjmmRGi7xAE5Jk8S9owQzzX33GC/GuuuCp4kiyIPmi71BJNnUfdrhS8Emr0df3PgXJ1FIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSkUfbvN; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSkUfbvN"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-9372310418bso535032241.3
        for <git@vger.kernel.org>; Fri, 21 Nov 2025 03:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763724064; x=1764328864; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZwUDHC6ybFBbHVjq0E4160acuIbdGVwzcyzN4CbtIQ=;
        b=QSkUfbvNrkxsJ7I8MK6Ird6aZUsi8L7DtRF+rSSjaSilCm3L7xCYg+D3GsxTEObbUT
         dgFWZd36yaEPoBsCFB3GVyQb+qEQnhmOndkKzuth4hW7wFwx6NEX6cZWJqjBWB+U9YcF
         mkZqqI5GUG+Y5krlK6HwzwRHwqFjqeFt0YISEjSCTyk9VDpIKFNiPJ5s2e0xyn6DYfCY
         NvkR4RIOV1jUYIW40Y3/YbZGjYKYShnl1NwuhOqmnKCneeLk4/0E1wSeprVaUr1KGaTD
         HYeX8xwWfJAhGe/jKiThYWIq/9z73zxV1t31cwR1XvcL0Brrvw+6v2VM0jJAYNcMTZZf
         tNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763724064; x=1764328864;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZwUDHC6ybFBbHVjq0E4160acuIbdGVwzcyzN4CbtIQ=;
        b=Pl4JFNgyU8dJssyaqU0PUMOVlyYXaZFFOlWqQi6638BrO1bCcxADTgJopVIRj17bZJ
         2Y/W0JcS7fQiSksHV4M8wKxONEtdSRwgFZld03ivwQhw2j9xGw7bISpTZGxAyST9M+1y
         fLOiHSIx1v4fEH+rCUPRaTL84a93hjPjHavBWUl7NMTz6yPeosG/BZRH7qSO00rSuJXN
         vsK499U8A6QatXKstxA94q61+Pi24nDpTpkuH56WErmgFwD2hJQpruV4xItUcXJVY+tV
         wXJ02e+Hwo7aYL0bVZLqrasVhLGCCTWHimlIfuOaB6DnMzGSUiB2/b8dw1+3nxP5g3ia
         zCzA==
X-Forwarded-Encrypted: i=1; AJvYcCUiafBCKkHugFRQ+OEGBfuVGGuT+zLmsVusphePExvHNJS1IwO9pqG1od7nCAHKuA5hKxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSCM9k1CFWOvJia2LakAvrYXXkBEeikUXhxZcJFvsUjtj2ep4k
	440zDYv1m7SOjcH5/4eJkUttaQc0+Gv+Dn9lRldwEv71P+0kn9c6H3zW7lnF5qshQrJU7mPg+7U
	UeSdCJo8US2AaIaMrRcky8/4LwYw9bNY=
X-Gm-Gg: ASbGncvNqenQABkqRhqcihoGe1HRQXEAoGAko2ngJaCWXw7fNOtssP0kPRlDg6NS/13
	bLrvTewlJRRn5BV5eSK8QnM6YNcoXV88e8T6PqIV10QMc5bocaBiKG+QDIgeXmEUh9CQXOy2F4O
	wevBiU3d/I1EhWBn49Rgji4V9IaXBjD8mefS9LMVeFSbe/8OKr0wqQOD/xWZM/OQWXyj/4MDd1Q
	dALExHRvXC7uRN5cSev+MZLN6JNxK3bDK3+9XOEaCw2SHFcYlXgZ2ZP7GTNl2z4OjPYlBMkJDxt
	StMz5g6G20dQzB7zJRdet5IK5kGrun8J3RnGAPZz
X-Google-Smtp-Source: AGHT+IHfT9RUpmBZZWmmcCt4eE8UAcQ00nX6wFfkUpMqhrhxCYbkLc0TNHmNbydc7hz3HGW29Ey1nyaMa1gR46BElfQ=
X-Received: by 2002:a05:6102:c86:b0:5d5:f6ae:38ca with SMTP id
 ada2fe7eead31-5e1de40c32emr400914137.41.1763724063658; Fri, 21 Nov 2025
 03:21:03 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Nov 2025 03:21:02 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Nov 2025 03:21:02 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <46f9d35e-60f2-488c-a0b4-89855f27cc66@free.fr>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com> <46f9d35e-60f2-488c-a0b4-89855f27cc66@free.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Nov 2025 03:21:02 -0800
X-Gm-Features: AWmQ_blBxlU4PZdXv3Tjt6SDXTBeQz4DD6UWgohKz-4QWfrb-fvuPc3WX98zbvY
Message-ID: <CAOLa=ZTSqUr-2EHTYkbtukObgeHPZ5BwEc98_xx_UXJX9+Q2dQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs: add GIT_REF_URI to specify reference backend
 and directory
To: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004bf399064419022d"

--0000000000004bf399064419022d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:

> On 19/11/2025 at 22:48, Karthik Nayak wrote:
>> ---
>>  Documentation/git.adoc |   8 ++++
>>  environment.h          |   1 +
>>  refs.c                 |  53 +++++++++++++++++++++++-
>>  t/meson.build          |   1 +
>>  t/t1423-ref-backend.sh | 109 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  5 files changed, 171 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git.adoc b/Documentation/git.adoc
>> index ce099e78b8..a1d1078f42 100644
>> --- a/Documentation/git.adoc
>> +++ b/Documentation/git.adoc
>> @@ -584,6 +584,14 @@ double-quotes and respecting backslash escapes. E.g=
., the value
>>  	repositories will be set to this value. The default is "files".
>>  	See `--ref-format` in linkgit:git-init[1].
>>
>> +`GIT_REF_URI`::
>> +    Specify which reference backend and path to be used, if not specifi=
ed the
>> +    backend is inferred from the configuration and $GIT_DIR is used as =
the
>> +    path.
>
> Please use backquotes for environment variables: `$GIT_DIR`
>

Will do.

>> ++
>> +Expects the format '<ref_backend>://<path>', where the 'backend' specif=
ies the
>> +reference backend and the 'path' specifies the directory used by the ba=
ckend.
>
> Constant strings and keywords are back-quoted too but placeholders are
> underscored:
>
> Expects the format `<ref_backend>://<path>`, where the _<ref_backend>_
> specifies the reference backend and the _<path>_ specifies the directory
> used by the backend.
>
> I'm only focusing on documentation.
>
> Thanks

Thanks for your review, will modify accordingly.

--0000000000004bf399064419022d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 517a3a17aee13dfd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rZ1N4d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOG53Qy80LzcvWUNVVnJUUTJ4Yk01ZzZFMVV5ZElKUQpSeWVESTBmNXpo
U0VNdzZEUVRmWS83Ri91UzE4WVBTRERXVWJaRWtwTnMvTWZUd3ZMajVyNWZLK3JXNndMYk5UCkFp
U2J0NVp6QThPSzJmb3V3OXhVRnQzQ2F2RUQ4UElQSGtxbGd0Tms5bFJKd1VLNFJ1U3FPd20rWU5O
VjR1SjQKVXVPNnFyaEs2akljUDZqN0VhWC9mRmxMdU1Ea1ZNMlcvcWNqN3dxbE8wMXh5a2lBYzJh
R0lVdTFUczZyTXFKRgo4RHFEZmJIVmk0QzNwY3BHMmZlL3gxSE9VYjNwZERkRzRmQmdTV1hMQWo0
aXZXRWllUndOWEdTRjZ2UFBDVjluCkJDSjlOakd5Z0pub2lpWFJFQXIvZzZROEhBWlhyWERNdTVI
bzhBdWc4bWZKU1ZGZmpyMHVUUUdvUmd1L0pLdXQKdml3ak95Tk95WjZtMjVZN3RRUzlyN1BlSGdC
b28zKzgzclhaRW8wL3kxYjF0ZC9xYTZPLzhmQ0NhZEMyOG85Sgo4TWNQQ1N5enFPbTdJRHEzaVFl
cWNaUWNqVzhrMTR5ZXpNU0c4U1Jia3BpbGhZaGtFMytYVUxUYkE4M0NxaEhsCjlYa3daNU56cUxj
VUo2QkI3T1JtTWRXM3UrUGVBbTNIeS90akhCVT0KPTFKeisKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004bf399064419022d--
