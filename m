Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1A43D667C
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770201262; cv=pass; b=YjnbZnLcAozhRl2w95ipXDfR09kzekLe79pc3k7h2Hqrp8REp3/nkiw6gnaIe3x2WHO0MFz3iKG51a9Mbddt+okfLhs4PRodHwYACixZVBgckxltbd1/+7on5Iww40U18YEeLnG2OSq8i8KJM3MghbXkNx0qczz4s5ftQ4dW8l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770201262; c=relaxed/simple;
	bh=tqAFQZFnfdaA/BQFnMIPIYaDY6QMyQJAv18g4NOnVSA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiO6RtIqHxz8lEynM5bxrnjjKPXKmF/cD+gcl3zxnxnYPP9NVIKSHVACg0arXSC4FbK5na5b05IK02MfZxmB/bGrZhn4stUjy5zHFSAE5wlPH6upZCHDVZ/DtkhuSYKSt3TbBEs/Sc3CsuiL4gxeyiyl+edNTJhHDhgUpumnifI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9hMyJ8D; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9hMyJ8D"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5f53021703aso1871510137.3
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 02:34:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770201261; cv=none;
        d=google.com; s=arc-20240605;
        b=JqaOJEi7M97336GmkV3UDuMIwj/eVc6gatm8uzCYrZQXagsfl1XWBB+lVusFpYRMvb
         m3A2MXcF1PSAgL/BCju6Wx8S16ra8sZrafpIt2cReuN1Qm9rwOcDCCBd4hJOU5NHJjKp
         m95g6Gz0+VXRoy0YSNuMV/PVtWw/1gk8dRJWf43lTps/0AMGErxU76d9hff321kzgw8p
         4Ea/udX5m/a0jdFeuE8lmvtVk12JAvE0l9zh1GhwcFB9FYc+/D/8VWFgapwW0ZP5C1bE
         uINQ1Sf0pMWuuXUlrY9b89kJZAhxYzsGHy5fVxnPIAqQXgN4z8DiIfLomznqARHxz1j1
         r5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=tqAFQZFnfdaA/BQFnMIPIYaDY6QMyQJAv18g4NOnVSA=;
        fh=UCqNHyw2zIWfL3yiAsEumD6ryI4RAvhWp11uuxAE5Sc=;
        b=Bx6vVysz/Xo4jWHwHpVpF4dQKaqT8lnb4T79aJr/4JcLrEPxmKPBuUUspjYa3w2xCx
         lpNX2LrppFiGqXqHi4EZhD3X0FWCSQRsVRt9XgnWMl6bz+QveKLbQ9dHejg0uRF52QpJ
         ETXPbMkTS+pauC3TazNIntV1i9EbsXcoR9cbN7bbfvwblZG6Wnn462hPLmgeBP5Wn7we
         d0s3EwCrSJJWhFexgp9EQoWBGWOfsum/qCJRpPXek5FdMACiUneVUe13hDH1+xQoZ37/
         XI6pQSgXCsp8gmSEvG68q7vOgcn4X/PhYardEzR3eA8DkNCsO/c0Hw5d2id6GEsO5s7b
         yZiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770201261; x=1770806061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tqAFQZFnfdaA/BQFnMIPIYaDY6QMyQJAv18g4NOnVSA=;
        b=a9hMyJ8DSpQhgrEkaG57AlUlbal0cn8I0Pb+pzKyDgFC1YFKMwC1Gbdz8jGfkmNZmZ
         TqBt20NZUVp+5MxfRAJObCV2E2tAgjy1GxE+lTPvvU5ueVYUY470HkCro1JskiDEw/y3
         QBLuXkFx9GHREuk61WZwvj5tyOi/KXbrbpgf0StiLEVdP2J8gemBOs+5uRO6R6QykeAC
         z9CvPdBVWWL80he3kue5rup1d5/qpHI87HYgErjIM+VL7lekluYL5J+KktwaZ0Corm02
         aduo4deJm8MbnYjS2YwW6Qz52/I5tGgY8QTgbPZ50q1gHHPgt8W8+DQS6DtLcS+Xeu6a
         VZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770201261; x=1770806061;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqAFQZFnfdaA/BQFnMIPIYaDY6QMyQJAv18g4NOnVSA=;
        b=vmEnooWE9h8zED7XQ/zbEYBxEyNI8cazNLCit9x3qcmDSogGkBeb+tY8Q1QkzYs+V4
         vyIr/v37epwKSK3JjIMB+dS7BxWYrWd00B5jGvkqaR9r3esoWWgHQRkHz5FNrIshAGnX
         mvZTfQWma4gj2jw04japspKBZtjC5PIiYqjuGVFlm6xzTbQ5uhr8jdc+7cOk3KLV6Yuo
         SYU+s5PmdLOhPgA3yJAGGnBnW+84QI67CkVXDOatzJPfSfM4mE7Z91uo7I8vlhn3NV/y
         BVf239uomBcLFzDUpZ+wcjREZgDn3EgF4lkPXGTG3K1UfgAxBlzRbZ+R55pss9wRc23C
         i2PA==
X-Forwarded-Encrypted: i=1; AJvYcCUyldYfUukkqA+azyEM4WS/2PjDnxNiOqHFLlmWkzhuB4v4Rb/um7HXPCdbf5MUu+12RGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMJqN4pBF+W/lSY72aU0NSPrEF+sqJksSV69F9EAiAb/NIzKlF
	oPk8MWwtn6cN2AJOFv3Yhj5srHC8+S+F0Ez9NVkAtKRiUjXPkad0Nv0Fvvp9NbooZt1rqpFt6QJ
	jNz/TrpQTFCEwHYbgHybEXLOUWx5Jos8=
X-Gm-Gg: AZuq6aKlwBQYCQhFG1uxtSA3ZCjgyvVu0G8XP1t3EHUnVbT+fiokM2oP++pT2Axfzzj
	OFFgfqY8FJrrB9peZui2ImAM9o+75bqltfUPb5HtguffyvLqdK/DC0WTLQb4KVzJL7HDXb25eJO
	Yl9+O7tB9/lkZlsZgW8xENmG8oyBfa1s0iTanc1wDeKC1JYMu0t5ewzFyiDFpQuK67XgTKQ18Db
	RjGAK+XLtbrAkKpjDZknpIjesvOMpLtGjGzhERpC72h9ivFXl9bb7egx5c1HgbIxf1CzRJyZK9H
	L7kyas67WGsxJbKlTZIiIER+5GzG2w==
X-Received: by 2002:a05:6102:3746:b0:5f5:3a9a:7db0 with SMTP id
 ada2fe7eead31-5f9395fab01mr755457137.41.1770201261093; Wed, 04 Feb 2026
 02:34:21 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Feb 2026 10:34:20 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Feb 2026 10:34:20 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260203001002.2500198-5-jltobler@gmail.com>
References: <20260128234519.2721179-1-jltobler@gmail.com> <20260203001002.2500198-1-jltobler@gmail.com>
 <20260203001002.2500198-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 4 Feb 2026 10:34:20 +0000
X-Gm-Features: AZwV_QjdTw1ILbMgZ9i_HxjkZFwv6e_nDcAOqxQ9ek7qodJkJSqGP8taYR5QFOE
Message-ID: <CAOLa=ZT_7o_YquQ_mAg6sn=gq0Rx4Tga4vNsVsPt3jCUh=3tzw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] odb: transparently handle common transaction behavior
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000005953e30649fd19af"

--0000000000005953e30649fd19af
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> A new ODB transaction is created and returned via
> `odb_transaction_begin()` and stored in the ODB. Only a single
> transaction may be pending at a time. If the ODB already has a
> transaction, the function is expected to return NULL. Similarly, when
> committing a transaction via `odb_transaction_commit()` the transaction
> being committed must match the pending transaction and upon commit reset
> the ODB transaction to NULL.
>

But isn't this merely a limitation of the current implementation of the
files transactions? Couldn't a potential ODB source support parallel
transactions where this might no longer hold?

> These behaviors apply regardless of the ODB transaction implementation.
> Move the corresponding logic into `odb_transaction_{begin,commit}()`
> accordingly.
>

[snip]

--0000000000005953e30649fd19af
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: be386654e3d4ef4a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tRElLb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL3EzQy8wUm0rUkpvSERJVyswTSt2N0V1bTZKa3VlTwp3RDJwQ3VvYkdI
Yzk1Vmw2NDdqQ1I3WjNBWVRpUlJQS1loZGZ6bzB6bExjTG5yaElmSVZJNU5EWTNyNi83dzQ3CmtH
MDM4VVlQa25GMWh0U0I1SE9OdkVROXZXWTlqeXRzbW1KY1NWS3pPVGVvbDFnVWV3VGVpaFgwUDJ5
MFZVYngKM2RqTzQwblhtT04yTWVzVmxQaGJZekpmTk9JTVNjOXZUbFRJWmpTVVI3RXR1T09FeFZN
NjhyemYvcnBBOTEvWgpxaE1kOXBKNWw1amJFRDBOMUpFVkpmM0srMlhQdmd0UE9JQldSWVZXaHgz
QnZRNUhDbVlnaU5HcjZYYjNULzlYCmZheFM4cVNJWVFWb1RBWnk4Mll5TmRpRGhkS3g5bXo4b3Bn
MGZ2TCtnb1VLRk9vK0JPZVB4K2gyb04vOUk5c0wKbzM1b25XV2tUYno1MjFubEZWYWdzSDhiQmZh
dnJGK3FRNURRS2dFL1RMQUV4eFJmWG9ZRUcwUmZlbG9iUml5YQpOZTk4czRrWVgzMEd0NG1TT1Nj
bzFPN3NwZ24zRzB6aHBTcGJidXNBMEphNFErTkJrblBXSTBLVDdKUFc3OTBLCmVIRWllUVVrSHZM
RHY2emxyQnNIVkgxNXQ2aTNzOHd1U1ZpQTlPND0KPU51bG0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005953e30649fd19af--
