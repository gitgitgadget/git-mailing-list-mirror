Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369441D5170
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737016434; cv=none; b=JRR9XbHn2dn205OfshDAPbF5d2DmoUNDqwvU1rVweqEyeTluHvrJeYmEg5t7fz33/ZEspR4+i7Dam7uxcB+pRePAFL/Ana+KQH6uLLj3iwQEtqn7mI1xjNspXHtFyK2FSxZwkIDmbgC+oo8Z0gF44UQOyVP8Wz+YWq3Mi4R7Ths=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737016434; c=relaxed/simple;
	bh=iXFkgGYMSYM7FmBlpoW+x5og+bJFihMkcMGPQmpTDU4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9PgGT5cZ23+P1A8qVi0j3tu0OUOu1eu0NOSWAt30OuNA92VU1WueKKuytIQPsFKXC8rMykF5qtGseKRCLqIgWnP/Y8vc9mldvwg4pCuLH6QlZ2AVfOsf6YNFeA/fhDoQDsfrrTq8CY3buKMpfIaP5hVZs+UW3oLtZwM6nE+wzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAuNkyl/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAuNkyl/"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so944356a91.2
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 00:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737016432; x=1737621232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BNXNaJPrLaVh71U6ZAS/ut5kjwWZUhZNvVFUdu4VP/0=;
        b=cAuNkyl/YP/eG2/1bkTBF/mOcdL0UGLZNy1rMkqyEYhghvkzMkV403O/r30yUPnboP
         ZmlQwE1t1w4Yx5fR7RaqWkVNuLcxLO1+L3P9MSvBY+nyAzgLDet6FaDqBVwcW3kC+fZ3
         PJc6zYr0hC2sh/yEpeQknXyb7e35XPQfbZplZxarn9FY00r3c02u0YOcolsjYPScz/fx
         /wBmDDDYZvWjy5zhA4sf5jzmGnoFhLHoT3zXGecNNvyH6FImqaSAh1ytoTvUeznW3HqC
         BmDdskRZkmwLhrhMCraiXyRf+QcUkMK67QcwEjXwzzS5Ow7UX/IZ2f/BWkHm79Xd0guX
         2ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737016432; x=1737621232;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BNXNaJPrLaVh71U6ZAS/ut5kjwWZUhZNvVFUdu4VP/0=;
        b=nKLXUe42G3RaSzHQ6RfWM/7v3sZsf3HXmtQurDHYRuecZWEdtshRWUrZ4Zxph56kPo
         gxPvYoxZZb09TUuHyYc5gX67ikb82fkrN9YW/2KPGBrTGBzjkBzcXCE87DJZHt+JC6Rd
         0NGZPMQNgl3G2MHqozhFOZWtbRTrrlLFgUhjPWnBZQt+RVJB7exXPLU+Xk3lR3XDv3LB
         CAHjJ5/rd387RtrMFG2I14xJKefZpcKgQxFOE5+zqsQBq7chXe3ARekp3y6iNSil4APu
         DW2U7Oqn6XMncADnOIMT2p75qcNSIjB98G5j2QJdJpRVIagKkl7NajgQshpTFYIUpVJ5
         JjSg==
X-Gm-Message-State: AOJu0Yy3u+vc4rw2mNCd7yc7ogLfHbnizdnY2dUsfgN+4DUrZy0kBsql
	zKd8WZJT4KS0mlopTMclR4P1jtJw2NYdadabm41AfYcnUlp0Z7lJmuCO3qZTQKA6N2n+pF3tz8U
	+SOOvVMKx8ENfiMVDa3UPjXkPuD2DvhW0
X-Gm-Gg: ASbGncuV37A8NFNTOjjS/5fcJhUlM70yDBpYc65eL0uiXNnfHtpKiVWkrJBqdgJLYMK
	/5sSLVRaFh7lQNzt1E3dCX5H947/hA4a0SZeDVLs=
X-Google-Smtp-Source: AGHT+IF/nPiAb1wMEpET/LqZeuF8J5erNMVR92wUk9S3MYan2LL+UpR+ijs2yWmKgsXIVQbTOjwhACEQCO8r1cBn0P8=
X-Received: by 2002:a17:90b:270c:b0:2ee:6e22:bfd0 with SMTP id
 98e67ed59e1d1-2f548ee48demr41516720a91.21.1737016432525; Thu, 16 Jan 2025
 00:33:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jan 2025 03:33:51 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z4fn_cTzEl_vZ_Rw@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
 <20250114-b4-pks-compat-drop-uncompress2-v2-9-614a2158e34e@pks.im>
 <CAOLa=ZRiRWubZJHvzgag8Ypaeye_xzZ9e5bdZxRBQFL_qhzb1Q@mail.gmail.com> <Z4fn_cTzEl_vZ_Rw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 Jan 2025 03:33:51 -0500
X-Gm-Features: AbW1kvYfWkVOjKHQ2ex8UFRy-6NEAnHn-ePudBrJBU5WOeUhXvTAkApmgjnmvtw
Message-ID: <CAOLa=ZTVPVzy1SXvzsnMvCPNF_UtmyG5TXb2yijvzUF3XtiZ=w@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] ci: switch linux-musl to use Meson
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="0000000000006e2622062bcea784"

--0000000000006e2622062bcea784
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jan 15, 2025 at 04:25:58PM +0000, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> [snip]
>>
>> > diff --git a/ci/lib.sh b/ci/lib.sh
>> > index 8885ee3c3f86c62e8783d27756b8779bd491e7e6..71d85ae85a02e5a4389e133ed53f45a5042af36e 100755
>> > --- a/ci/lib.sh
>> > +++ b/ci/lib.sh
>> > @@ -378,10 +378,7 @@ linux32)
>> >  	CC=gcc
>> >  	;;
>> >  linux-musl)
>> > -	CC=gcc
>>
>> Question: isn't this still needed? I thought there was no way to specify
>> the default compiler in meson and as such it is better to be explicit
>> about which compiler we want to use.
>
> We already default to GCC anyway in "ci/lib.sh", as we have equivalents
> to the following for all CI systems:
>
> 	CC="${CC_PACKAGE:-${CC:-gcc}}"
>
> I'll mention this in the commit message.
>

That would be useful. Thanks!

> Patrick

--0000000000006e2622062bcea784
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a23fbf3bc60a8405_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lSXhHd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMCs3REFDSW1EampWY2pDYkROYXVnRGZIU290SEowMAoraDVQTXRPdmVK
Q1VneGFZODdLcXQyOGVhMjN2RlFrVUF2QWJnNFc0bHh4K3FrTHJiaHEwTlNubGIrcENQOWw3CnBD
d0lielpicllzM2Y4NHdiOVg0RVhKc1dJQ3RlT08vcWN2OUUzSzR6Z0NJMnhJdGZiSUF2UmQrb3d3
a2gvQmIKZE83THlGVjU1RzdsZkVab1ZQOWVyMW5ZT2xDYVpnbDBwOURGN1dQcjhzazk0ZDUrMXdy
cTM1aGxuVFg4aWFlQwo5Zm5FZUp0ckJWRWdhWHhMSFhIUzFVVXJwdW8rcUV5ZXh6OVVSNUdUNHVP
cFVYNURiVlJRczhtRG4wVzBPTEJ0Cmt3aklENHJ1S3pEWS83cGNqanRpaHIyVGRiZHkzdjlWTGdB
WkN1OXN4b3dDL2tPNlhBai9WMFNabEdlaThKVlUKQWMzUHZHVEMrZU5BT0Vla21sQTFjb1J6QnVj
MlphSElZYUlBc2NmeXIwQ2NHTEdHbEU1MGtrM0ZqWmRJSW16SgpzWllEL3lEcXNMWUdKengxd3BW
MHArTUd6eUQzNVc0SGxSdXdNaE01djdKUEtGUWNMZGhVUUV4M3g0RDlCL0pkClZaMDAwcEpkM3VG
TDNUNTlWMWJaakJJZEZNOWtlZjVCc0FnbE9rYz0KPXo4b3oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006e2622062bcea784--
