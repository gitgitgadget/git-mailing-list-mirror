Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C32E302CBE
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759398898; cv=none; b=aInGJ73Mcrtn8vnGXLQ4hnxroxCcgA9rBPbQ9QdS3FFOvtoeTfldwn+JB/We0slMVne1LgLqDLRO2z5UR/D8e5L3P1IiIdbYxZKIiUGdmXjd87Sbu+8RZQholf8aJGx9mUrAANOcLk3TafnYx+906UbrJBSJTa699kW3lPulxk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759398898; c=relaxed/simple;
	bh=BLW7HxB6/CrCVljiD2cVBOHw2wPduSYQ5LKo2rUBPyQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cO5xCH7bXDMpBgIPsLWGmDnTFxSY8961a8I+XTI0hx2vqh+FHtyfrVtgBhm6Q0UMT7U5ug4eQPXRQ6zx9lvLZXfkL2zKz+XGDosmF15EjOMcCo8/WPQ0KzFKLvJ7P7ucCf15ufzS7JuALVKbRXHJF/oOFP1/6tt9DJL+1CynI3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+QX3PU5; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+QX3PU5"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5d4018cb45fso370535137.2
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 02:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759398895; x=1760003695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uJ0Dg7YU+VdwjnY4HTl0wvnP00dAyE7oDQbi7JesCVc=;
        b=B+QX3PU5JUyJC8hZ0UAwAkxddbxS5IXpfRzU6OgrHYzYsIwQDxu3S66AB5ux3arSmg
         hOyprctp84nqdWKu+nnr5t0xf78lruPkxbAbHnBN83H1Rzgb2YGNMW25uj0+0BQtoW2O
         QcBjdIulk+7s0SY7j85q7eiGU1fYkSL08YPQKSftMjocn37jhO3xCYobPtYOhu2Zn1Vz
         tG5xZGWFA2GJldwVmnNnPn3QE+GMQgCnME3g8/7DY3ZMwjWUukm48aa4w1uvnwMbO78L
         FderxDEILt4BE3rPWKpA4RXJZtQK8iHH5QN8B5clqebcwIQIoF64gnF81RPK50aXOrjI
         8xSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759398895; x=1760003695;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJ0Dg7YU+VdwjnY4HTl0wvnP00dAyE7oDQbi7JesCVc=;
        b=BPbKSwBxG+HWS9eX3/9KIBZ0U0cQQeirlIjGK1C1PK0/RTf6uVw47aWvNR/CGyE5K0
         3loXEN0fIob6q7yQhBPQ2YYSBEPJPbJV7fRLB7FASIZL/Tu0FEJlJrxrFi+x+DP/mNhJ
         abuSXX8aDIMXHQ1/ZV1OSR4EZjQ6wqVRRPr8l0HREBl81AvwV9A29WBXkB8zE6rZUA5J
         jOmj221XggAMYMGVyvZ/emX6T0KEVr1yLGCFbEl/G5GTqByojZ9FKemrQ9Rj1j4M2Yhq
         FYg9KxIYIJV1apBAjH1mI93AZo+I2vpERMSk9G7joHLv/G7Ri4Bny2NmtQ3ZqJ1qxa1Y
         fdYQ==
X-Gm-Message-State: AOJu0Yxq8DJm9cSQzO9kk9WjpyUoAIlC8l2EJsiwjTI7i3x3W1PEl2Xh
	8LHNEg8gQ4NzXJ7gKW4I4V6Y7NyZgD2+JDM1FMhpYBXEwG6qhc8D08j0k4VMuDIUH1GabAEVMEr
	CyCJp5RKisjC86YoaiZxQ5w4bj0NajBw=
X-Gm-Gg: ASbGncvc275Im5SFVgBLPc6Tf8dwLkvnmr/0snwx4TQgi9bE6abAe17MAVNMj6VPyCa
	+EveuK3AFxZ8Y57ZncNeAjztZKkJXAeSsf0Cuj4XunKZbsLxysZoAutf3w3RH7XI8gF+302sBvB
	AYWNUOkmfp2FPQtJmpDw60gvaof67HARC2qL0kV/eDF8/HXSpoVnUVc6ZflhNtbV8+C66Q05cBn
	IrZ5lLvkO8AEJh3J1L0tHg93G8cAg81jJM534PdynwWCbIem0L3nUoLuGlwwD5aDg==
X-Google-Smtp-Source: AGHT+IGq6sW1GwokbVTIa1KApewlGRIUAiVP+oe7YKZjfX9CLGaKLTvENfP8VzbHN0TLKifa2AliYjkeiNxxU19uYXc=
X-Received: by 2002:a05:6102:44ca:10b0:5d4:e01:169 with SMTP id
 ada2fe7eead31-5d40e0105d1mr494533137.13.1759398895308; Thu, 02 Oct 2025
 02:54:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Oct 2025 02:54:54 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Oct 2025 02:54:54 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqv7ky1l70.fsf@gitster.g>
References: <20251001150805.9652-1-hanyang.tony@bytedance.com>
 <20251001150805.9652-2-hanyang.tony@bytedance.com> <xmqqv7ky1l70.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 2 Oct 2025 02:54:54 -0700
X-Gm-Features: AS18NWAdDddRB84nIP7I7R57eIXM2s6C3YBi5kbA_M4xaSAGKh5O1xLNfHRmKFk
Message-ID: <CAOLa=ZTnHQbg9ocdA1omqER6CJH-w30G14-F2JAQMtueXENWew@mail.gmail.com>
Subject: Re: [PATCH 1/1] files-backend: check symref name before update
To: Junio C Hamano <gitster@pobox.com>, Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org, Han Young <hanyoung@protonmail.com>, Sigma <git@sigma-star.io>
Content-Type: multipart/mixed; boundary="0000000000002dda1f064029faec"

--0000000000002dda1f064029faec
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Han Young <hanyang.tony@bytedance.com> writes:
>
>> From: Han Young <hanyoung@protonmail.com>
>>
>> In the ref files backend, the symbolic reference name is not checked
>> before an update. This could cause reference and lock files to be created
>> outside the refs/ directory. Validate the reference before adding it to
>> the ref update transaction.
>>
>> Reported-by: Sigma <git@sigma-star.io>
>> Signed-off-by: Han Young <hanyoung@protonmail.com>
>> ---
>>  refs/files-backend.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index bc3347d18..d47a8c392 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -2516,6 +2516,16 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
>>  	struct ref_update *new_update;
>>  	unsigned int new_flags;
>>
>> +	/*
>> +	 * Check the referent is valid before adding it to the transaction.
>> +	 */
>> +	if (!refname_is_safe(referent)) {
>
> Shouldn't this new condition share the logic with what is done by
> fsck?  IOW, after doing this
>
>   $ echo ref: refs/../HEAD > .git/HEAD
>
> "git fsck" or "git refs verify" should barf (if not, we should make
> them barf), and this code should use the same logic to notice that
> the target of the symbolic ref is bogus.
>

Good point. I see that 'git fsck' does complain about this:

  $ git fsck
  Checking ref database: 100% (1/1), done.
  Checking object directories: 100% (256/256), done.
  error: invalid HEAD
  dangling commit ccd1771e44a18887197d3ee26ca37c2e892b9fb6
  dangling commit f99d68ea2c378218e2360dee4e24115c404f6a66

However 'git refs verify' doesn't...

  $ git refs verify --verbose
  Checking references consistency
  Checking refs/heads/master
  Checking packed-refs file .git/packed-refs

Okay, so this seems like because fsck also parses all references to mark
reachability and also parses 'HEAD' via `refs_resolve_ref_unsafe()`
which fails.

This symref checks and checking root refs is definitely something we
should consider adding to 'git refs verify'.

[snip]

--0000000000002dda1f064029faec
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: acb07138addfdb6d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qZVMrd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVVLQy85SkMzUHhEUCtWNHpCSFZvZ3dmYTg3eHRPVwpKVVlQSVl1cFQz
V1Y3UGZwUUs2T2FCT0hWejhOUS9pSm55SUVkdkd2M094ZGFzWWJGOXcwNGlVVHJmVXJNN2FiCkcv
Zm9OT0IvUzJFYjJsY0ZhNkNSNXVzYVlndkVTVTQxOE9hZ0N4NHdPelZLMFA2RGQrTVZUemFLWGVN
bkFCTFAKelZOMTdtdEtiTUJyaWVaWkx1VnZXTTdLdUNJd1pxbktUeVFEWVRxSkp0SEJXbmVCQ2h2
UzB5K0ZrQVYrNEhYaAp5T2drdmZSTFROVW9icDN6T2g0THlmTTdsekltVHdyZGRpYmRIQzliUDhl
akIyb2NzUlpGSWd4SzZBVkxPZHkrCk9RdzBMb3VyRXBWeVpTMjJYWGcxcFd4VWJERTdOVTZ4NlZD
cFJwa3VDdnRIcDdQN29jY1pXSHphWWY1ZjdsWWkKQjBkRFdQaUkrUWtIdDlDcVJkWEE1RWh6d0Rp
SDkwWGQyUi80T2Y3dWhobTB0M0dobG1kUVRSWm9JL2tWQ0MySApydW9PV2tvNGVuaTlpbVJsSUwv
MC9ZZzRqUmNHeCs3bjNSMTNzcG1BTzNOV3lGNlpraEYzQ242dnJiWmRHb1czCjg2WmNVd0NxM3ZM
WGlIMmc4QU9ZdUVZZitYNTloR1R4NW1QVDVMYz0KPVBMbFkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002dda1f064029faec--
