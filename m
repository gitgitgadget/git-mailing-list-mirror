Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005C435A398
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770762; cv=none; b=rsnSAd6ODWbXRW7otcHYk85JXZVr1bUbIKTMNfEXMJsF2l0gBgEjpLyWjGlNqEp6u2bxvmEVA1TIg59Je182zSeVnMm/+oTSYbyPHk1yVqCx+l+RztcTHMJaoUi6TFjoYYJFvejSnIrzn9SwVjgRs04pqYsahsnDJDDcHvjLhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770762; c=relaxed/simple;
	bh=+P2LBjxJjy8u/to2laX71H98JuFVz3dwnJeFIEP8LNg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=E7KxqPbvYHfjH+LDH7e3KxWf/DdzOmgwsHM51SO83ENXuNwjgtywgtJuyaLLJu42j5bG5xzSRH+0cgTV6c2hAy6+6bmxZaVpgOVKeL0fdFtxWs8buuathaiDtkE1IO0NQXsBCIFP3VGFi97HViZyUSTbEgJQqFjPK09vX6gb2cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cecwMDVl; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cecwMDVl"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843796e373so3096459f8f.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790770759; x=1791375559; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PxQyyZ8sI2hbqu4Sz9ClnesIcQXS/BZjWB+bWHEo7qY=;
        b=cecwMDVl3qcmGliJ91rsH2AQZChZ74A/ixeh3ZRhGzx+UOuwkBTtSpWW+4FkjmVESK
         7dsuEgl3jCE5IGmi7baFMKIYy6873kic+B41GPcakQEIpaVAYxXHkizgrV7CrkIx4SSH
         49IBjK+cKDr6GJ9VXiNdN0GNPCNTQZV+/+iHIH7qeTqpbTmpgIW/cShQNsrJCg2ZG+s/
         yOGPsvMsfddltrCguIPqt79obXjEFsgfy7MowQ6BBZ/9wc8rwwG1o7m7MLYYVrREJScQ
         wJQvAbGEEHGhg6QpNGuLsGBJPp4bOIzjwSL8a1bHhSCoVIDTgywpnHBM9eZrroO76dsC
         oLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790770759; x=1791375559;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PxQyyZ8sI2hbqu4Sz9ClnesIcQXS/BZjWB+bWHEo7qY=;
        b=r15ebSzK4XvRE3XqAh8ty18fzZRVdeiBB+9wNmAg3jVm+ZnjiBH126BPRxqu9iCt7I
         QV/zc5Yv8lj1VWPlSziS8TzkCSQwJK4BTipxadnKydp61WopD1jD8JDBrgCUTwFLbTP2
         mGNjwJkpRCsPmd26yuukLXFBbmHNHj/8juZ82BCxUPw4enOpzIStyVcZ+iwLn0PnFvb3
         +myuxBpBkv87jp0h4AbFyt7zktAOqHPwO4LfNJq6Vn3zLdQDNnf9u+t1O7C9g+3EtFsA
         a0pIO2FftBkOEjpzrwlvTyHUKQVjnVsVyKaRdYl9b7IZMT2jp+esdnM8fAdU08ghsVPN
         n57Q==
X-Forwarded-Encrypted: i=1; AKwUvBwTOj7XItyiLZ17ypr/d+IKJNyche/nTLAHK9JMhLSIvvHArp0GzckqAST2l87JtJLw6/w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhOmlSizGLvns/Q7v8zcX0QtNl048Z0OPdKYrafjppPvbISusI
	zXeB+BvVrp5Bd/2XbwEQ9oa0SF3c95Eaexreu6cuzOe5IQ7Y1XEgEGqvZXaxbsMECXA=
X-Gm-Gg: AYBFou1+3Br43guxD0cA0oc9MpNxTQpDmopXhKWJt9epcdquaaYwLPKhBMPDy/R7HMX
	eCNZfxweglbddYl3BRvZt+G/5H25u6UdDEF7NIyweDlGTSKzKysVyGByDYWIOaEqS5xe/j3CtZD
	NJ0tieb141416miFji5zJbHQ8Zp+hISbHXoob6V+VmfATJtPq6pg9L/ijJnWFnBEP9pkVcojZsp
	Ay2OiQ16ZtRqTpF+89mu4MGV5IVkUEqH5XwZ1YmeidrHaSp3mgXRI+cVaECNOoReKRx3YbBUbUV
	+YfrjuhocbWLQmj49LI6/oXKI1X4vMOR8q6cczetgesCoPUNKf9KNMI54CSN+N8I0zbszCE6nMk
	d3nad2XvdTbGqS0b+aKNv+Lim/QAuxgL4TDmdAEL6pZAb5lbyLglo7YNXXMprrQJ1NJcAHcEbZp
	lpB/hUbxedPJhWulGbshg7qGDN+IB6zqFpFydtCmrhW5iJ5vFSJjDjBEHeiVWvNEotmuyYDfEOe
	RxgX+RLR1hZNbBEaW12eGmy37z9tFV1xvCWL/dTgRZwOym288K3qMCWfK4e+12x3+OQkeBJqHmI
	WYUk9kEq+1E4tvl3KyGvfw8KxDZ2+P6jcVnhhjH/JNKrOvRXfZiGfAMpkVpjNIal/GkEl61Fm1X
	pSS1W99NCBTuo8Q82rro53ne+
X-Received: by 2002:a05:6000:1843:b0:48a:fbd2:c2b6 with SMTP id ffacd0b85a97d-48b0258b092mr2564534f8f.55.1790770758915;
        Wed, 30 Sep 2026 05:19:18 -0700 (PDT)
Received: from localhost ([2001:818:c665:a700:4e1:afcc:bdec:a44d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b02949a4fsm3197857f8f.3.2026.09.30.05.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 05:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 13:19:17 +0100
Message-Id: <DLSN94VUFI80.15JU19PJ3RPK1@gmail.com>
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>, <git@vger.kernel.org>
Cc: "Derrick Stolee" <stolee@gmail.com>
Subject: Re: [PATCH RFC 4/5] backfill: add --dry-run option
X-Mailer: aerc 0.21.0
References: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
 <20260930-backfill-dryrun-v1-4-1128f247ee01@gmail.com>
 <CAOLa=ZR2Ka+5o8HxgZtnO98oH6vo6B_HmjVekYT8hC3HTMq-QQ@mail.gmail.com>
In-Reply-To: <CAOLa=ZR2Ka+5o8HxgZtnO98oH6vo6B_HmjVekYT8hC3HTMq-QQ@mail.gmail.com>

On Wed Sep 30, 2026 at 12:06 PM WEST, Karthik Nayak wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> Users have no way to know how many blobs git backfill is going to
>> download before running it.
>>
>> Add a new --dry-run option to the backfill command. The objects are
>> walked as usual, but instead of fetching each batch of missing blobs
>> they are only counted, and the total is printed at the end.
>>
>> A subsequent commit will also print their size when the server supports
>> the object-info capability.
>>
>> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
>> ---
>>  Documentation/git-backfill.adoc |  6 +++++-
>>  builtin/backfill.c              | 37 +++++++++++++++++++++++++++++++++-=
---
>>  t/t5620-backfill.sh             | 26 ++++++++++++++++++++++++++
>>  3 files changed, 64 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/git-backfill.adoc b/Documentation/git-backfil=
l.adoc
>> index 82d6a1969d..08f19fea17 100644
>> --- a/Documentation/git-backfill.adoc
>> +++ b/Documentation/git-backfill.adoc
>> @@ -9,7 +9,7 @@ git-backfill - Download missing objects in a partial clo=
ne
>>  SYNOPSIS
>>  --------
>>  [synopsis]
>> -git backfill [--min-batch-size=3D<n>] [--[no-]sparse] [--[no-]include-e=
dges] [<revision-range>]
>> +git backfill [--min-batch-size=3D<n>] [--[no-]sparse] [--[no-]include-e=
dges] [--dry-run] [<revision-range>]
>>
>>  DESCRIPTION
>>  -----------
>> @@ -70,6 +70,10 @@ OPTIONS
>>  	--onto TARGET A..B`, where A..B normally excludes A but you need
>>  	the blobs from A as well.  `--include-edges` is the default.
>>
>> +`--dry-run`::
>> +	Do not download any objects. Instead, print the number of
>> +	missing blobs that would be downloaded.
>> +
>>  `<revision-range>`::
>>  	Backfill only blobs reachable from commits in the specified
>>  	revision range.  When no _<revision-range>_ is specified, it
>> diff --git a/builtin/backfill.c b/builtin/backfill.c
>> index e71e0f4742..6019112966 100644
>> --- a/builtin/backfill.c
>> +++ b/builtin/backfill.c
>> @@ -26,7 +26,7 @@
>>  #include "path-walk.h"
>>
>>  static const char * const builtin_backfill_usage[] =3D {
>> -	N_("git backfill [--min-batch-size=3D<n>] [--[no-]sparse] [--[no-]incl=
ude-edges] [<revision-range>]"),
>> +	N_("git backfill [--min-batch-size=3D<n>] [--[no-]sparse] [--[no-]incl=
ude-edges] [--dry-run] [<revision-range>]"),
>>  	NULL
>>  };
>>
>> @@ -36,6 +36,8 @@ struct backfill_context {
>>  	size_t min_batch_size;
>>  	int sparse;
>>  	int include_edges;
>> +	int dry_run;
>
> Nit: This could be a bool, since `OPT__DRY_RUN` uses `OPT_BOOL` internall=
y.

Will do, didn't know that using bool was a thing ;).  Is it also prefered
for 0/1 functions?

>
>> +	size_t total_batch_nr;
>
>
>>  	struct rev_info revs;
>>  };
>>
>> @@ -58,6 +60,15 @@ static void download_batch(struct backfill_context *c=
tx)
>>  	odb_reprepare(ctx->repo->objects);
>>  }
>>
>> +static void dry_run_batch(struct backfill_context *ctx)
>> +{
>
> While it is used during dry_run, probably makes more sense to rename it
> to `count_batch()` since that's what it does.

count_batch() works for me, I think that "count" doesn't fit too well
for summing the size of the objects, might opt for another name if I
think of a better name.

Prob a comment helps.

>
>> +	if (!ctx->current_batch.nr)
>> +		return;
>> +
>> +	ctx->total_batch_nr +=3D ctx->current_batch.nr;
>> +	oid_array_clear(&ctx->current_batch);
>> +}
>> +
>>  static int fill_missing_blobs(const char *path UNUSED,
>>  			      struct oid_array *list,
>>  			      enum object_type type,
>> @@ -73,8 +84,12 @@ static int fill_missing_blobs(const char *path UNUSED=
,
>>  			oid_array_append(&ctx->current_batch, &list->oid[i]);
>>  	}
>>
>> -	if (ctx->current_batch.nr >=3D ctx->min_batch_size)
>> -		download_batch(ctx);
>> +	if (ctx->current_batch.nr >=3D ctx->min_batch_size) {
>> +		if (ctx->dry_run)
>> +			dry_run_batch(ctx);
>> +		else
>> +			download_batch(ctx);
>> +	}
>>
>>  	return 0;
>>  }
>> @@ -131,10 +146,23 @@ static int do_backfill(struct backfill_context *ct=
x)
>>
>>  	ret =3D walk_objects_by_path(&info);
>>
>> +	if (ret)
>> +		goto end;
>> +
>>  	/* Download the objects that did not fill a batch. */
>> -	if (!ret)
>> +	if (!ctx->dry_run) {
>>  		download_batch(ctx);
>> +		goto end;
>> +	}
>> +
>> +	dry_run_batch(ctx);
>> +
>> +	printf(Q_("After backfill, %" PRIuMAX " blob would be fetched.\n",
>> +		  "After backfill, %" PRIuMAX " blobs would be fetched.\n",
>> +		  (unsigned long)ctx->total_batch_nr),
>> +	       (uintmax_t)ctx->total_batch_nr);
>>
>
> Nit: Okay so we have a goto inside the first if(...), which skips this
> section. I would have found it easier to read if it was
>
> if (dry_run)
>    count()
> else
>    download()

Will change it, thanks.

>

[snip]

