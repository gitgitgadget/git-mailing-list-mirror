Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91771B0F0C
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194628; cv=none; b=DBaebc4L/4X5KIPzpIzCyN5h89acTK4YZhnILHvWK2R2L2IjRwSLRPA/pTS0l4UVLyqQU3mG4zvYpPJOpMzSmX6pe0Vfg4UAZVw/AtHxBmdHPe09cRbEkyoQIw81kJJ4fdPezWSLpFRf7HIu1wdptNSDcVe1paRg6xG8k4F8prc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194628; c=relaxed/simple;
	bh=yWYyO5CiHFHM8Wxm4hqsKxPBwuRQ+dDiIYuVFjXSx14=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5rs+Un0DCjp0NDEWoUuI3S/YrH5n145+6zRRjLDcyhmfApFqB9C5GgSmfGwUHIbnFmzFUt6MK8gRCvfIfuxkt+vf84Qa7R72XfLQ62VMgxW4r4fRZNd2Cc+F85wkjQV3+d20TxoFkHVzpdlx6jKxt2o1yuZEuK3AAG5ecSzhnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHAx17vI; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHAx17vI"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e6089a1d39so481078b6e.0
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 05:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732194625; x=1732799425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CUMFp/smlg/e9/plb0MB0xVtUsnoQScj2IYyh21oNOo=;
        b=gHAx17vIOJtDtC9dYZX8I9NQl6ZYrhhq8Eb6xbtrvbjTzV8dK4zTs27YQvkturO1/D
         o6qoJ1BkxUU1DLQkE466anzvqU8E8A2rBVVEq4b7rP8rfmrJW3CKmieIfYaqzl+fdXxP
         /A9ZVzyi7YzW68WB3iC0h6+BAs3SptABWomQICU3NFmH4xr2u/4oGiowS3LUNekwp5N2
         4rsa2iqmu/xR6nc2+FNM/3kgdH8yP3ASGmum6IyhcAYTn4obGjVePxIuhVehk+Yy+OSI
         PdPwzne5n+1ldvqGo1jlWgapUmqznZTzJ56wnydFh5oe/qzlexcvb0S0nmMaGI+pu4ow
         Bv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732194625; x=1732799425;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUMFp/smlg/e9/plb0MB0xVtUsnoQScj2IYyh21oNOo=;
        b=eNc/l2RZxFxRWs7WKeBQPgDcLBbcWV/s81RlEi800v/7EoC7Vsz9t2zi+DiNSB1pNQ
         hym1+XJUr1T7GA9EF8ULlWRR9OEejomjJHAaPBCnT1vQ5dbXiP62dg8gRAxu9AldzHgj
         tU281qv5swYPZTP1oGhxX54NsgRr/6a3RB4PQywNgi4FLc+ZOHEdycodp0cvbkDzj5aR
         sLqCGyF2ZYlI7gWwOXMevX7iga8MBbIq4ASHBeDkH64pQlZnTVdGGLaVrXNrGh1es8o7
         m1kjbMVr23q9p4bwdVesALmQ4BhccQHz9Rh7pJ8myH9jC0hAI75epDgwlRcZHWahyXjB
         hPbw==
X-Gm-Message-State: AOJu0YzcoPcBvF34OoMuOJoLoAWoFMhcyPBkW86av2Cq8eu6VXsruSFA
	W8/Ti3SoM82s0jGe35pzPsns6CtJK4u2XH7GCdUNN2MmS//m7Jzov+ok4ad8dzShM7YvIr3TAEO
	Ss2VdGus2GMjBhxah0nNCz65t32w=
X-Gm-Gg: ASbGncu/+b+OYxdMUNLjfx3zSNEVWX1rS42YuHwu3kCjkd4WvvkqLXe1vfVmgvLSA7y
	Y9ofTFgN4J1I0Os+dLinZ7xnP2aBksJpaXDY3gE+HIMZ15xemYBdWGEoc9lGJboPkrQ==
X-Google-Smtp-Source: AGHT+IGSxDSzm3zZiYdnmPByFnE6GqnCimrvpRYpoCdqrO3bHJTlhZtGtquvVBaPGm1Ta6euRwdxDq7p99hIvnaD5NU=
X-Received: by 2002:a05:6808:1496:b0:3e7:aab4:db62 with SMTP id
 5614622812f47-3e7eb7c62a3mr7773082b6e.36.1732194625467; Thu, 21 Nov 2024
 05:10:25 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Nov 2024 07:10:24 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Zz5oSqu8IlWbZHvr@nand.local>
References: <cover.1731323350.git.karthik.188@gmail.com> <1bdc34f4d8161a3b70f21124cb857908e4fac53c.1731323350.git.karthik.188@gmail.com>
 <Zz5oSqu8IlWbZHvr@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 07:10:24 -0600
Message-ID: <CAOLa=ZRRD1XSeUfQfZD-nmhm2gnf=5f_AcnfDaYovvGnvbv3Tg@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] config: make `delta_base_cache_limit` a non-global variable
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000055e48e06276bfdd8"

--00000000000055e48e06276bfdd8
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Nov 11, 2024 at 12:14:07PM +0100, Karthik Nayak wrote:
>> @@ -1697,6 +1701,9 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
>>  	struct unpack_entry_stack_ent *delta_stack = small_delta_stack;
>>  	int delta_stack_nr = 0, delta_stack_alloc = UNPACK_ENTRY_STACK_PREALLOC;
>>  	int base_from_cache = 0;
>> +	unsigned long delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT;
>> +
>> +	repo_config_get_ulong(r, "core.deltabasecachelimit", &delta_base_cache_limit);
>>
>>  	write_pack_access_log(p, obj_offset);
>>
>
> Hmm. This repo_config_get_ulong() call will look for the configset entry
> in a hashmap which is faster than parsing the configuration file from
> scratch every time, but still expensive for my taste in a function as
> hot as unpack_entry().
>

Thanks for pointing out, I do have not much idea about the object
database code, so any input here is appreciated.

> Should this also go in the_repository->settings instead? That way we
> have a single field access instead of a hashmap lookup (with multiple
> layers of function calls between us and the actual lookup).
>

I think that is the best way, though we'll have to still add the config
to the gc config struct. Since there is no repository available there,
but I think it still gets us one step closer towards cleaner config.

> Thanks,
> Taylor

--00000000000055e48e06276bfdd8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 74be0c1bcc2d0760_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jL01UOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOVJBQy80dHBHbjc1cEd6SENKMzBBR1FXUmIyaXZYbQpmdnN1NFJtV1ZT
cnJzUHNnMkpOa2NPRWRjYzE3WnUyYllHSW5wM3BIRzlCKzBrN084cDR2bTdHeTFrWGw0bEJzCnNG
TXFFb2I2YnUwanZKYmphTzBYZWtTOERGbEtMTGRlNUE3dWpBL2NDdWxseGFDT3lXUU1hcGJRY2xu
ZzF6NTkKWURDVU8rdDM1YS9TL2JLLytDd0cyZ2dWUnpIaUV6TVk4Y3RNRkI0dytrZmtuaHRQMko5
QWxXQ2paS2V2TldwVworM2JHU2xRdFl4RmZrZVlWQXpjNXdwSDA3MlplWDJzaU5yd0NGaXAyT0Q2
cVhxei9INlA5QXk5ZWxUa3NUYnJ4CmpzWVpXVU0wY1Q4T3BMMEJRcXpPWk5sRmRacXc0S1hvSG1M
Y1luQTJaQU04OU9WQjhRelVmakZ4SVJaWGpjeXoKMnJ5K1VjVjBtMG1EUmtHYnhJQnZJOWFycEQ2
MDArTlJ6bXd3N29QcElGWU1xbnhGK1p4VVdBVTBWbm0vV0dneQpQTktsRXpjN1lIdlFLcGpoQms4
TVdvM0JBZlY3UDU2ZTY1UUM4dzN3OTlqWjVRaExVL1lwUGxVRkloQmVBV01kCmcvcW9idm9SemFa
L1hPbWtZVWNkTWJFOWtUTWVDb2g4K2JPRVpYTT0KPXJsZFMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000055e48e06276bfdd8--
