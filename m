Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D11311969
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775072704; cv=none; b=YrJS0DaNjNF8XPND54IjPghqknKGSfpgdsdH4QkMzEd0vcJIjCftyDlfhzHBP48YF35ROSvOd1cKjZ8mkuHANPKzxJlblKXXNFFhd2k3SeP5ySpRJxyjb+xd8ivqX8agkO/l1pYxE+h9dNuNW5bhWWxlHbfFiX7oVEDYM9wiUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775072704; c=relaxed/simple;
	bh=Tti+wrjDpP2g4Bz0AEW6Cf9QaBDHiL4j4ZVPmX4t1do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JduY0DyB+/WerSSrRHrk9ka9WLjPtCDkz/UM5FmTbWkYA2fwe7pqYsDiHEmopAD/fSow6yagG7aPEQJWlXee0WCrrd7BgnNMH+oWaBsYLLU30vqA1yynOzOJSHGtazjY8kPmJF/00e3GXZwMJ27BGXixYiGhJttVBC6qedVh1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7AcODry; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7AcODry"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c76b9efc299so35931a12.0
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775072703; x=1775677503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZg0uuJvU6DXW/MbkZDnSTTTgaB4HYaIOHDR/cL2GYQ=;
        b=T7AcODryIfIvc+DllSH/MBmCvXu0Tmqmmx4HkhbH4UdTE4ceJXX5+rTPj/+z3zbTdn
         wJshC1d66NLR1WpsheBJJ4r6b7N6qEEA1QV7OXBN9xY2b0tUGIruymo6qEiJ93Ylzgp7
         yfVumxv51oQiApJT0zGpNTI3JE6ZX+HOqBDvEOEt84KekAq0RmNo6Yw1luqcFJloUane
         rw7FR/uM6FaXB0QaAb+sYN2SCwM+ZOguDTVf6oM2W9650pLcOH5kdj3WNykaL50EwsxR
         apkJxauPRiZnZiHWnMPMHGzynUMBhpc6XVeaS7KHu60bvDV/t5lNIhzBf8lOWkxqujbE
         eqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775072703; x=1775677503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZg0uuJvU6DXW/MbkZDnSTTTgaB4HYaIOHDR/cL2GYQ=;
        b=HvToTeL8KYVb2jvIW8e5cdeCL+RlQYu3tKd/ZcDH1n+nRly7ZlNgHnodouClW4hGOv
         0zNpEUnLy5xMh6NR5LK8qGXcQ5/uoZdSf4MepCToKrbD/N4KTFkMOY3lZX9uXTtPXTal
         1n8tlJdqMe2zuXguZ8ADtnxcXykMWxj+WfHh5HKpEf248xQKiUfAhDcI3XXXGjHTwlqa
         x+IY62/l7plfbmrcuisf1jFVU9vNNhykSOse3/TOY+LVB8BduOWpt4GeTfjUFwGjuQ15
         73AiXYysQZPNg9SbjBGBEC4qKqSgVlFuuFpQVna/tfohurNfA2rj+BMaim6iafx1oE8F
         0TgA==
X-Gm-Message-State: AOJu0YypNnkAQiF75dIhR3R+8mmxxfy1mzW5JM9MQzaThO6PAvP8GcuA
	O2xlcHamBQPYXkZ7u7kqP6fRr/6Q+hjr92KmqPcUS30lYkGgZOOx1pQ/b4EbDnNQnzc=
X-Gm-Gg: ATEYQzzWaoPaZEUqMpI2I3KSQfbUJ9vW7vT7yTyeEEo3KGaMPMaxHW0CWS9I83ET5Pf
	pTqsZFVpTyUwiCd+yhkH/kpQascRbaU6F0jx4caHZ694mNqb1Lp0ZDVG35EGQQKBfIDOSKYK3rF
	VpyazX4cpBQfPevL4pwZEKPHOvmx/ONIc7clErTiEXZLZqRMuQnKmg9DTQvr7Y7uHu+DzdGxerP
	5QupXAVMtoqyZVmNlefU/Ovya1ulB01xuTDF3OtUsk2+s4p4XeWZaMaDNgBYcihALmqd1gETw8Q
	MB7sCNIl6pbqDWKuT6HZQggfWxNAr8MBBzBigtEylBUcTAHHO48hkXKjGe4VeUKgRf6JGnivlut
	VmS58xc4uz9GJRMwbTRntWtIxeLru/pWsYv/f/5Api/o0+84TsEJKLxikHIMTW+inmzLZgaZqeq
	/NBUPA6uEnpyKRuDRH/tgzFgReiv8BsLQ=
X-Received: by 2002:a05:6a20:394f:b0:39b:ce4a:f397 with SMTP id adf61e73a8af0-39ef73957d3mr5381753637.18.1775072702701;
        Wed, 01 Apr 2026 12:45:02 -0700 (PDT)
Received: from localhost ([42.118.191.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6563aacsm635052a12.19.2026.04.01.12.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 12:45:02 -0700 (PDT)
Date: Thu, 2 Apr 2026 02:44:57 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [RFC GSoC PATCH] backfill: skip downloading for empty batches
Message-ID: <lwsskrhd2prb577xrpcse3f7oureuztmp4kyegn4gziu63zvcj@h4pqpympiava>
References: <20260331121204.787826-1-vikingtc4@gmail.com>
 <ac0GnzQgZMfu8aGL@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac0GnzQgZMfu8aGL@pks.im>

On Wed, Apr 01, 2026 at 01:50:55PM +0200, Patrick Steinhardt wrote:
> On Tue, Mar 31, 2026 at 09:12:04PM +0900, Trieu Huynh wrote:
> > When git backfill finishes its object walk, it unconditionally calls
> > download_batch to process any remaining objects. If the repository
> > is already up-to-date (no missing objects found), this call still
> > performs an unnecessary directory scan via odb_reprepare.
> > 
> > Fix it by adding a check in do_backfill to ensure download_batch is only
> > called if the current batch actually contains objects (nr > 0).
> > 
> > To facilitate testing and provide better telemetry, add a trace2 data
> > event for batches_requested. This allows us to verify that no batches
> > are processed when the command is run on an up-to-date repository.
> > 
> > Add a test case in t5620-backfill.sh to ensure silence and efficiency
> > when no objects are missing.
> > 
> > Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> > ---
> > Need discussion:
> > 1. Is adding trace2_data_intmax() the preferred way to verify this 
> >    behavior in our test suite, or should we rely on redirection of 
> >    stderr to check for progress messages when the progress option
> >    is supported?
> 
> I think adding a call to trace2 only for the test itself doesn't make a
> lot of sense if we already have another way to verify. But would we
> actually see any progress messages? `promisor_remote_get_direct()` knows
> to bail out early in case there is nothing to be downloaded, so the only
> difference really is the call to `odb_reprepare()`.
> 
> Or is it? This part here...
> 
currently, I have no idea to verify the change, so I'm adding a trace2 here.
> > diff --git a/builtin/backfill.c b/builtin/backfill.c
> > index 0f31844ce7..67f9f28daf 100644
> > --- a/builtin/backfill.c
> > +++ b/builtin/backfill.c
> > @@ -58,6 +58,7 @@ static void download_batch(struct backfill_context *ctx)
> >  	 */
> >  	odb_reprepare(ctx->repo->objects);
> >  	display_progress(ctx->progress, ++ctx->batches_requested);
> > +	trace2_data_intmax("backfill", ctx->repo, "batches_requested", ctx->batches_requested);
> >  }
> >  
> >  static int fill_missing_blobs(const char *path UNUSED,
> 
> ... looks different. What commit is this patch based on? There is no
> call to `display_progress()` on "master", and you didn't mention any
> other dependency in your cover letter. Please note such dependencies
> when you post a patch that has any requirements.
> 
I was submit another patch to support --[no-]progress option.
https://lore.kernel.org/git/20260329152443.525493-1-vikingtc4@gmail.com/
it should be based on master's latest rather than this change, sorry for
the confusion, will rebase on v2.
> But in any case, this here would cause us to print "batches_requested"
> events repeatedly, which doesn't make a lot of sense.
> 
ack, but I wonder if it should be defined method to verify if it can skip
when no objects are missing or not here.
> > @@ -109,7 +110,7 @@ static int do_backfill(struct backfill_context *ctx)
> >  	ret = walk_objects_by_path(&info);
> >  
> >  	/* Download the objects that did not fill a batch. */
> > -	if (!ret)
> > +	if ( (!ret) && (ctx->current_batch.nr > 0) )
> >  		download_batch(ctx);
> >  
> >  	path_walk_info_clear(&info);
> 
> Please pay attention to our coding guidlines, see
> "Documentation/CodingGuidelines".
> 
ack, I got it.
> I guess a more robust fix would add the check in `download_batch()`
> itself, but I guess both alternatives work. But overall, it's sensible
> to avoid repreparing the ODB in case we know nothing has changed.
> 
ack, waiting for other reviews.
> > diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
> > index a1a8d736db..d3cc4022bf 100755
> > --- a/t/t5620-backfill.sh
> > +++ b/t/t5620-backfill.sh
> > @@ -221,6 +221,22 @@ test_expect_success 'backfill --sparse without cone mode (negative)' '
> >  	test_line_count = 12 missing
> >  '
> >  
> > +test_expect_success 'backfill does not request batches when up-to-date' '
> > +	git clone --no-checkout --filter=blob:none \
> > +		--single-branch --branch=main \
> > +		"file://$(pwd)/srv.bare" backfill-up-to-date &&
> > +
> > +	# First trigger to have a full download
> > +	git -C backfill-up-to-date backfill &&
> > +
> > +	# Second trigger to verify when already have a full download previously
> > +	GIT_TRACE2_EVENT="$(pwd)/up-to-date-trace" git \
> > +		-C backfill-up-to-date backfill &&
> > +
> > +	# Verify no  batches_request occurr
> > +	test_grep ! "batches_requested" up-to-date-trace
> > +'
> 
> I'm ultimately not sure whether this change even needs a test. We're not
> changing any user-visible behaviour, we're simply skipping some
> pointless busywork that doesn't do much, but that shouldn't really hurt
> much, either.
> 
ack, can provide steps to verify in commit msg instead of adding a test.
> Patrick
