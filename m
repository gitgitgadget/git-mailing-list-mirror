Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A32201270
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738596019; cv=none; b=AkPZJKGi7A858XWGmbtjXrjG/IBphZTh8sn5mY9FVVdOYKggs2YIrbEF88qNfPwyBNrJKU54gtUfanOq93apd9/B4i+O3KrVi4cHuEKPyXxMVLhx1wRoYsv1AcyT9bgK9/EPJvgjdwwm4M3PFkW+VL0tElsa53XEK+sWj4seMjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738596019; c=relaxed/simple;
	bh=RukQFdbqDn41omPBGcMdsDToVo4TKcMt/YzUAbwgjj8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4nd/NE2qEFrwwATzFzIT77RbkWBeNEeZ1aG6NTCGf3FIDxYW2IaQT9s4VjerK05qSP9mGLbhjicvcH4CoAt7EEMivj+9w/mgRMqk4elxkTQfYl0wBO+63TgtFNuRW+ZxElKgbz5IGobDm+pdgUtgBGFQyO+mZZ4/0vw870M7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mO5hPsvK; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mO5hPsvK"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5187cd9b8e5so1421907e0c.1
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 07:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738596017; x=1739200817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sfij0MuUHCGEhzx64yWP2B+qSgSshdaDHsrufYnIMpU=;
        b=mO5hPsvKTqlcsEebWBss9x2dW9cywiUnPsnNsW5RIDBnGjwws2nBLlpgVU87FUkPS6
         tShmPGuEsCoDGBrSGWN0aW2NfXvexwygHpdBK5+yIyKULjzQe0uDcsCWWkFh7QTSGeF4
         B2yDhQjRJoK1BkGH0+22A/mVKSlT1n6Vy0G02I0t/2m9z4aJK4GNvzn+IwYgRBxrVLGg
         p0bKEixVHOCn+htC+Sx4d5A6+GvnjIizlfPMKl937g4K9SIrS6bHyRq8tWOKFt6GYvrx
         AnpaAf/8P5nexDMwOI7qc0qX5KB1MC5jcMpRtQ9quaQHkNLXP6p8zcSI5IAcys5Mm7sb
         jaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738596017; x=1739200817;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sfij0MuUHCGEhzx64yWP2B+qSgSshdaDHsrufYnIMpU=;
        b=wxim/9hlLCyTydvE9PJqBe1JwXLRD0MAZKTCRQTM7Y5kz/wIPXV12fSHe5iELxYdKl
         YG//Hq/rrTteMa2orOUYK78hnMHxLrYaAKUkPATetNTOlI/uvwNa9AOtAwfUv/vZFciE
         faIYZ9mkWsW+5mjJCRzbO6SJnV05Bhbv29BzKGCq3Y4V014Eft4d8ZsY0cNFkElce4jz
         USoQnjmcc0ef6fCTQUPhe5M3CX41XGSm9GnZtqM7K944R68CqyQSKriPulfgKPA2zCA7
         n6zqLXrTOgTJJOwO3BYoOFykMMCdoYtbPwjdlIbqrLoXd1KkvuhfxNcqxP6JhzlbvGnd
         t9hA==
X-Gm-Message-State: AOJu0Yz/B4zYQ/E43p7u1XlzXmMjVMfY9BLqeYhguC/GItKnTIfntqYE
	ySgKsIa8yiI9ypatxUav7FRsHxBzl5abrVjmx6bbx9PXVzI6zJSoyMbsFVVtFfIzn22GO2V/7el
	MGtpIzK2AywaXL8RLniL61+cEKgZR4g==
X-Gm-Gg: ASbGncsHzNNP1BnTVNIcucIatTzqZV3daIZuyoGk7HUNvYWUw6G1HPtLuhxWSyx29t+
	1IAoXjtGFmP2lGhA5zgqjWj+oqvhsUL7x/QhJc29qi9sUkGXRqQXrQAEBt6Vjuzy2si6lbQHZEJ
	y0n8mPiWxHEt3ybsW9LmEuzwBPIa/sSUQ=
X-Google-Smtp-Source: AGHT+IGTV3fRhhx8uEDsgCA/mX9SBMQPDhRy26aJa4RjG7HGPgw4Kabq+FQLoQLmvkmJYMS5N4tqp4Gk1y854g9EkiA=
X-Received: by 2002:a05:6122:240c:b0:51d:e6f6:deba with SMTP id
 71dfb90a1353d-51e9e42ff16mr16095077e0c.5.1738596016922; Mon, 03 Feb 2025
 07:20:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Feb 2025 07:20:16 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250201022409.GA4082344@coredump.intra.peff.net>
References: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
 <20250122-461-corrupted-reftable-followup-v3-3-ae5f88bf04fa@gmail.com> <20250201022409.GA4082344@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Feb 2025 07:20:16 -0800
X-Gm-Features: AWEUYZl-HQ8D1BbqDmXS-cBNoFa5QX1QtNhddsJlZDiO8zMwCJEvrT8SUD7sFbM
Message-ID: <CAOLa=ZRCb4KHKNkW=kuGhiR7B-aV73KV32DqjX4RM0fDP1gMww@mail.gmail.com>
Subject: Re: undefined behavior in unit tests, was Re: [PATCH v3 3/3]
 reftable: prevent 'update_index' changes after adding records
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="000000000000ff5ceb062d3e6d77"

--000000000000ff5ceb062d3e6d77
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Wed, Jan 22, 2025 at 06:35:49AM +0100, Karthik Nayak wrote:
>
>> +static void t_reftable_invalid_limit_updates(void)
>> +{
>> +	struct reftable_ref_record ref = {
>> +		.refname = (char *) "HEAD",
>> +		.update_index = 1,
>> +		.value_type = REFTABLE_REF_SYMREF,
>> +		.value.symref = (char *) "master",
>> +	};
>> +	struct reftable_write_options opts = {
>> +		.default_permissions = 0660,
>> +	};
>> +	struct reftable_addition *add = NULL;
>> +	char *dir = get_tmp_dir(__LINE__);
>> +	struct reftable_stack *st = NULL;
>> +	int err;
>> +
>> +	err = reftable_new_stack(&st, dir, &opts);
>> +	check(!err);
>> +
>> +	reftable_addition_destroy(add);
>> +
>> +	err = reftable_stack_new_addition(&add, st, 0);
>> +	check(!err);
>
> Coverity complains that this function may have undefined behavior. It's
> an issue we have in a lot of other tests that have moved to the
> unit-test framework. I've mostly been ignoring it, but this is a pretty
> straight-forward example, so I thought I'd write a note.
>
> The issue is that reftable_new_stack() might fail, leaving "st" as NULL.
> And then we feed it to reftable_stack_new_addition(), which dereferences
> it.
>
> In normal production code, we'd expect something like:
>
>   if (err)
> 	return -1;
>
> to avoid running the rest of the function after the first error. But the
> test harness check() function doesn't return. It just complains to
> stdout and keeps running!  So you'll get something like[1]:
>
>   $ t/unit-tests/bin/t-reftable-stack
>   ok 1 - empty addition to stack
>   ok 2 - read_lines works
>   ok 3 - expire reflog entries
>   # check "!err" failed at t/unit-tests/t-reftable-stack.c:1404
>   Segmentation fault
>
> So...yes, we will probably notice that the test failed from the exit
> code. But it's not great when the harness itself barfs so had. Plus a
> compiler may be free to reorder things in a confusing way if it can see
> that "st" must never be NULL.
>
> It feels like we probably ought to return as soon as a check() fails.
> That does create other headaches, though. E.g., we'd potentially leak
> from an early return (which our LSan builds will complain about),
> meaning that test code needs to start doing the usual "goto out" type of
> cleanup.
>
> So I dunno. Maybe we just live with it. But it feels pretty ugly.
>

Thanks for pointing it out, I didn't notice this, mostly as I was
copying from existing test cases and it does seem like this (wrong)
pattern exists in a lot of the tests.

Like Phillip and Patrick mentioned, this should go away since we're
moving to using the clar test framework. I think it makes sense to keep
this as is to stay consistent with the rest of code in this file for
now. It is ugly, but seems like that would be simpler while migrating.

> -Peff
>
> [1] This would happen in practice if malloc() failed, but you can
>     simulate it yourself like this, which is what I used to create the
>     output above:
>
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 026a9f9742..fe77132102 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -861,6 +861,11 @@ int reftable_stack_new_addition(struct reftable_addition **dest,
>  	int err = 0;
>  	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
>
> +	if (flags & (1 << 16)) {
> +		*dest = NULL;
> +		return REFTABLE_OUT_OF_MEMORY_ERROR;
> +	}
> +
>  	REFTABLE_CALLOC_ARRAY(*dest, 1);
>  	if (!*dest)
>  		return REFTABLE_OUT_OF_MEMORY_ERROR;
> diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
> index c3f0059c34..73ed9792a5 100644
> --- a/t/unit-tests/t-reftable-stack.c
> +++ b/t/unit-tests/t-reftable-stack.c
> @@ -1400,7 +1400,7 @@ static void t_reftable_invalid_limit_updates(void)
>
>  	reftable_addition_destroy(add);
>
> -	err = reftable_stack_new_addition(&add, st, 0);
> +	err = reftable_stack_new_addition(&add, st, (1 << 16));
>  	check(!err);
>
>  	/*

--000000000000ff5ceb062d3e6d77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 53b3272f53fd01c1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lZzNxMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNzl5REFDa28yZTdGUmpFb0FYSFVXOXRjeThaQTRjVQpoYTF2Y083SFJC
aHJVVWdXOTQ1S1ZOUEduaVZZVVh3LzF1RnB0M3NCUDJYYXRITnFMNHN1Qjl1MkRKTDZ4SFBhCmY4
OWtnRUoxV3RFTFRJcTJWYndDdlBXdE9FdjhoditwaUlkREZDMnV3TmtGbjhPdkpEYnNuQmdLdytl
WTlvR3oKSUVlQy8yWEhNcDRHeEhPNEtZWUJOamVJQnQ1TU1HRHp4VVVRN2szOTFOd1QwYmdiVkc1
LzhrN0lKbzBmNkYwRgpIREdEUm9nRUlUZEJOQWNsazdZVG8vTkVVNUdudmJvWjBvM2gxM0Q1RFhp
TDgwN2ZTUXQ1M0J6cFh5dGp4SjJQCnVkSlRTWjRvUWdYYUVLV3puMFVPWER3QjJWY0lEVTRIVnJ2
UWhhTGRoazRIUXdHZit4SDVuM0xWK0dzZWFxYk0KaGJwS3RrM0dlaVdvNmt4VE1iYXpTRWExcXFL
aFFqd2VDK0tuTXhiTjlTckduMFNjd0hsU25tZ2pSa3JBdk5DVQpiRHFYaXhwOFltTDFDQ0ExQ09w
TkdGVkMwWk5TbWZRZzdJUXRuZm82bndDQzQ5K3F0WlZvNDVxNFBnWGZkTTRWCnVQOVBDcm1pLzNT
QXFrMC9DZ1pmM1BURCtwOUtxdUZvUGV3S1FyUT0KPW11SjAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ff5ceb062d3e6d77--
