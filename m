Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D7B329370
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762351918; cv=none; b=MKxkIyASBqOG5mgM2Nfi0nXEzYMkuo8OEW2J5WeTGmlM4gqyULMQM+Tfs3tAKHqNlTaNJ3WhMfPnL5gCacpxrbgzIoH/1OZmWi9EbA1kihO3/G8yDwnRC5FZ6xiz8aq0728YkyBsbYQY4NjJoAMUQulXcQksMWF67h2YgBTQUSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762351918; c=relaxed/simple;
	bh=FJzNsjVY1gMbXiriQYwdvWOZDm8ABqOEm1TTpNW0V6w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8LBxzfqV69eVOCrZaIroJ299IT25Yi+6xcRVdJ7c7xDrrr+kSH3JpsOvr3kr+PkMNfNz/+XD42pBOe5qFpUE2Zn5/5wYj61O0DmAFy3LrDEW2B9Eb2OISbhhP6x95WUm+c+DX8Iwdko64zNsws5IEa/Hk7fyj2sDgGMPQyx4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM2xLaco; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM2xLaco"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-93539c5e2b5so549845241.0
        for <git@vger.kernel.org>; Wed, 05 Nov 2025 06:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762351915; x=1762956715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qWBEHWGWAWEdl/CaDtJ/lwM7PDY5J7QPQUMob4fIhO0=;
        b=VM2xLacoVO0ff2xvX5i4CFYlcl5n5/01a7VO1JtJLBTMtULgiSJJFA0YCZHUgGlqQE
         vntWZUDQFvW0WLGlKHnjQPcwrZlxzJnPHkuMzQztmBDBEP+w3DP2O1kVUaHTfLt2WN3Q
         YJqc0XAy4bZXQjzHeFQz4qlGAs75PHAjYPc2cx3GYkL2I1lNsl/uxbnNzbix/3jOMbL/
         ctS1QQPxo6wU7N/dSTN0wMwWBHIEP+r0jQlxvvwZrcs52eVVeBxx14FysShvzs4xBMGH
         CYoA8Opi2ZkuMSEHaam8bS2+UX7cXzveEhoqm4JfupckR0uRIWvs2DbkPejAkDGzTQqX
         qtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762351915; x=1762956715;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWBEHWGWAWEdl/CaDtJ/lwM7PDY5J7QPQUMob4fIhO0=;
        b=ur0DS91t9oRQZkVd5GpH01iFNZSeTbx947MEq2tCsc1fQUiO9XYILDgjGjU0jOSGeG
         7Q0LyXwWCuSbA9UOxpwARYbslYoRu5Eh+3HpSJ4cqoEpGs6ViaL4T02jOfr8kMzsrd/q
         BuCVMZ+6SemDmjVghHn+4rYRtsjfjDllI9wtJ/HKqXDX+UVt9+uYkVfgfRbcD4/P5crK
         xL3TAQmzCkZAjD6UZiZuQv6+jaMflOm0HhIZe5FV0tq+TOVxS4EW+7a/6DXjC2m+0F1+
         XHi1jGxMTY2LdJ87kjmAVTBHqggLKap5WC62pooqR9dnWgB9uuoVCwGuboalcJPJbgnl
         5hcQ==
X-Gm-Message-State: AOJu0YydyoGAvHs8OIMr1lPggcmFgpWHzIOAd39G/F46X2hD235ybDc7
	yQjYVeKrd9+cGtwBo58OcdwzZUSOXeWKoSQTki8NskHS+SFf/aQmrLfGdxmb6M9LCr8VBanSOSV
	Z4cvNqOy7blaD2XyiiFn5E6jWeObK6vkA1+sB
X-Gm-Gg: ASbGncsysIikZLttQr+KBNNaROPjUcJXjgScADUlyLb0nZfr30Q4O/N/fT4zbqcPZY+
	kC+bRgnvqpfEnIhZkAObhqoVQ6fzDpmIPSEIq1p8ciN6a50pIEZXF4JazGPEr7xM0wzeUOz1gP5
	Tb0ZACRo9tXUoDi05vmhqJL6lNSETfVny6Q67b7R9CcR1cpCD3cs204YDVr6Nq6YcomTuK3qkgY
	tWzOd91/5/no43YRhZf3E+ZFdC97FH+EG1vdib2kKMuAzbSLddheIvgYxyeTMKNtV9J2YHnDweV
	Fu4asRlmslYL4+jz
X-Google-Smtp-Source: AGHT+IFCTHgjGDdmuXSo8FcPW8qervePKsU3FpWj5wYAtE616a1t8Me+bg/qlD4FkNRoXcv9NpSxf3YHDe06SKTFWVo=
X-Received: by 2002:a05:6102:44c4:20b0:5dd:8953:4c39 with SMTP id
 ada2fe7eead31-5dd89534ca0mr915598137.4.1762351915276; Wed, 05 Nov 2025
 06:11:55 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Nov 2025 09:11:53 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Nov 2025 09:11:53 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqcy5xpmrw.fsf@gitster.g>
References: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
 <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-2-303462a9e4ed@gmail.com>
 <xmqqcy5xpmrw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 5 Nov 2025 09:11:53 -0500
X-Gm-Features: AWmQ_bmmPGLk4Yip6P939in624yvxnZFTTQsDlOGP3f8D4HRg6OzphJi0hAx0_Y
Message-ID: <CAOLa=ZRD_zNCnGf3ibU=X04vC8WjxzRVAyg+OwPr1Hf12kSGgA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] reftable/stack: add function to check if
 optimization is required
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="000000000000e134f00642d987ae"

--000000000000e134f00642d987ae
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The reftable backend performs auto-compaction as part of its regular
>> flow, which is required to keep the number of tables part of a stack at
>> bay. This allows it to stay optimized.
>
> Sounds very sensible.
>
>> Compaction can also be triggered voluntarily by the user via the 'git
>> pack-refs' or the 'git refs optimize' command. However, currently there
>> is no way for the user to check if optimization is required without
>> actually performing it.
>
> Sounds very sensible goal.
>
> But where is the existing logic to decide when it needs to
> auto-compact, performed as part of its regular flow?
>
> After reading "the reftable machinery already decides when it needs
> to compact and does so" plus "but the logic to decide is not made
> available to users", I would have expected for this patch to extract
> such an existing logic or otherwise make it available to new callers
> so that things like "gc --auto" can call it, but the diffstat shows
> mostly additions, which does not give readers any confidence in the
> new function that answers "do we need compaction?".  It would give
> _an_ answer, but there is no clue if the answer it gives is the same
> answer as the existing logic that decides when to compact as part of
> the regular operation.
>
> I am puzzled.
>
>> +int reftable_stack_compaction_required(struct reftable_stack *st,
>> +				       bool use_heuristics,
>> +				       bool *required)
>> +{
>> +	struct segment seg;
>> +	int err = 0;
>> +
>> +	if (st->merged->tables_len < 2) {
>> +		*required = false;
>> +		return 0;
>> +	}
>> +
>> +	if (!use_heuristics) {
>> +		*required = true;
>> +		return 0;
>> +	}
>> +
>> +	err = stack_segments_for_compaction(st, &seg);
>> +	if (err)
>> +		return err;
>> +
>> +	*required = segment_size(&seg) > 0;
>> +	return 0;
>> +}
>
> Specifically, where is the above logic come from?  Is it duplicating
> an existing logic but that code is hard to separate out into this
> helper?
>

Good question.

Most of this logic is already part of 'reftable_stack_auto_compact()'.
We also have another similar function 'reftable_stack_compact_all()'.
The former is used for compaction based on heuristics and the latter is
for compacting all tables into one. In the refs subsystem usage of
heuristics is denoted by the usage of the 'REFS_OPTIMIZE_AUTO' flag.

The function we're introducing allows users to explicitly mention if
they want to use heuristics or not. This allows us to differentiate
between the two modes. The result of which is that this uses intertwined
logic of the two existing functions. Hence we can't extract any code out.

I'll add this information in the commit message.

Karthik

--000000000000e134f00642d987ae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c90fc98cd988a384_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rTFd5Y1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK1Q2Qy80MTR6K3pGRzY4Y2ZkTWVsS3A4bTN5M2ZxTQpLYUUvdVRORld6
U3VCMzhKa2c2cDFqTkx5cXk2eitZOE10Q2djb3dTcDRZcXk3RDNtM2d2TmQxK25CN0pNSHltCmNF
M09hZjNGVU9CR1poNE8yNXVrcW9nN2NQOUVGb2oxcU5sZzIxZUp3NGxIMkhMNEVRRFd5a3B1VFBj
ejYzOWoKaWJCZzZxM3ZzWG5Cc0R3UGNYYVhiV1hHY2c1V0s5K2pMTlpkbFpsQXJpVXMwSThteWJ0
aWpIdzVOZU1DdWYxbgpyMy9QQnNoeDhVR1MrTWtqcHdOdXNsMmI1K3ovYkxvZVhIZno5NzFMR0p3
TmtGTzlBVFE0UGhqMmk4NCtuZ0NpCk5kOW9YcTYycVlTU1Fza2NHSWt4RkxJblZDRGRjRDE5d0NT
d3I0U3g2bit0c3BEcEFWdFowdmZ4VjJhWk5TckoKN1lnY2k5TkhkZkp5aDhNRks5SE5mRkVYTU5E
bU5ONkFSOWZqSldrdURSYVZYWXlCRGJWWkdmR2NkMWVNcUxtMQpMTGwrUU5TemhJbXcweTVySGJK
UHJlQmJwS1ZGMUF1YmNxVWZNMk5zbEZhRVJYYk5WNE1uU3J6TVUxayswTjZxCjBEY1hQN2FZQUw1
TTBJU08xUHN6YXFLcXZnRWc5MTJwKzZRMnVmZz0KPTdQcFoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e134f00642d987ae--
