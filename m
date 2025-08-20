Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B762D3EC2
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674864; cv=none; b=Cona5dIVAx95UH1+D6Du7qUiC3mZLJH5lRNXkIqBbLhYLq4RpHdQP3mzgUPs3wp78fYlkO+NUxUETSkUco8ZFKH+HielmiGsjRD44gKS42z8Nc1gPHKzlAamc0wvrvoogRa/tI0tegV3kUR2bGajqg2y3o3zI8TltLdOFI4WGKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674864; c=relaxed/simple;
	bh=2z39VSpWIPCaE3AucftoAa7lvDEkvaVSH2TD0/jErhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM87LAKVbR4YtN/4FDFwbLi+AP1iEM4tvEDzsPXAXP7rwakgzxiWsKRu/+J7D2qEPna5jjAxy6fSVDX/KucWDWI+bXH9Wd2aQ1Wt73iCrDQi+fIZE9j1QEE70RjfPqYX/ZhkfniuZ7ZNZHCOsif6PPEty2g7vuUqdPQcWVQcl6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B5AxN+R1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TSMlBMUQ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B5AxN+R1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TSMlBMUQ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 607B37A018B;
	Wed, 20 Aug 2025 03:27:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 20 Aug 2025 03:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755674860; x=1755761260; bh=+qxmaqIvcp
	BqS2+0GOsIS3P19xLn95eBGYSl+K2d5uw=; b=B5AxN+R1oDcy0ml9hyKmLB/krN
	c+NGZgyF1Izc8KD4ng+RTTOVwt+jks189D5NRRmdT8qKkb+G6ov8QFtvOEjNkYCl
	LjkpGkXaQ3zWoj1P5r/s5ip2KNx0rHD3kJxViIdJ0/UbkqxktzY7KqENpF+gWda4
	eWFUIrBS4k2OTyNGPSxqHp2C9n+eKRS0JKR4AEdyTiu9/9Wx9DQkA+VV34QN4IWE
	W1vRP/2LiRlWfQQ4Zh6Jma04pbEsl3Wh5sEpBIIdU+7DTm7KCEaZ5/9AP5hKZQc0
	c0dt0etSh2NNfJDhPPYd/KvgoK3s8c4PGp8p6Q5DtzVt72ZxjV4A6wc96TFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755674860; x=1755761260; bh=+qxmaqIvcpBqS2+0GOsIS3P19xLn95eBGYS
	l+K2d5uw=; b=TSMlBMUQKbTjgm61t/NpV1mF5RLe2VVBXnLfzstF+mRPOlVSGpF
	HIwL7yQGa9lZfM4VZMgkAHt46FNqEarXtW1Suu+FN4BJWH2FgQ83ps/RnxRVE2Ol
	8/7CQnmcsAM6L62OMK3JqTyN+jiiqhx19sKK9a66CnDfwxFw8SRw2ZjKvHoSvGih
	vyzlGN1L1rY7UaoMu24tvHHL+D7IK8jey11xMgehKgwMjek+bwqWtsbnotzoS9U8
	mXIhNBy0A/QSm2o7iJ0+IQRTc0TFoQ6ZrzVXW36NGwHbki2dz9mLmvwLxzaHwsvv
	sy7Dqx4UFDUApjv/34z4ukZPjdxbyCN9o/Q==
X-ME-Sender: <xms:63ilaP5UR2XJoY_O1SxkkyhZASJfj2ealOTGpbbSIq9VjzsXWu0HDA>
    <xme:63ilaFFaLAiGScok55W7u77J__85i7psAwXdotz0JyzAQbkUER1veZsLL7aZ3U-jg
    LclyRh5d9SmqM621A>
X-ME-Received: <xmr:63ilaISDjfz-SNL7sd9rSmk7Hs83FDLS8BJjt1g9bmbI_cKWLjw-kGlSuWK2uqBX-xczpUQ3LGqu_49rpKlpltFLNSV-CY1uknThRpx0xWSb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheejjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:7HilaOsU4EvZsbsqbPSVjGgfBN0iF5Vgt7r6M0UaJSbcPZnmSV-_Hw>
    <xmx:7HilaHz1b1HAjjFHjQ1uWij0ekNVkKTMGJJDEtH4mTj0IqCzECMJmg>
    <xmx:7HilaI6gHfXSqDgv8dVy72dAIgeYR_n3w3Xu4bHNkxSwbeG9O71N9A>
    <xmx:7HilaBXoltTLrFCRvQe_Bb4qwZFQNPlLi23HzyacA4aw8bVa1NqjgQ>
    <xmx:7HilaNUtj2qzsf0MI1CP7GDrhYCm0KSMs1CY2iDvLhQbNF8VG7YEdfVe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 03:27:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9d3e9840 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 20 Aug 2025 07:27:37 +0000 (UTC)
Date: Wed, 20 Aug 2025 09:27:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] refs: do not clobber dangling symrefs
Message-ID: <aKV44BDyIMyarinZ@pks.im>
References: <20250819192004.GA1058857@coredump.intra.peff.net>
 <20250819192934.GD1059295@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819192934.GD1059295@coredump.intra.peff.net>

On Tue, Aug 19, 2025 at 03:29:34PM -0400, Jeff King wrote:
> The code for the fix is relatively straight-forward given the discussion
> above. But note that we have to implement it independently for the files
> and reftable backends. The "old oid" checks happen as part of the
> locking process, which is implemented separately for each system. We may
> want to factor this out somehow, but it's beyond the scope of this
> patch.

Yeah, there's a bunch of duplication here in general. I originally
wanted to refactor this at some point in time, but I never got around to
it. Also because I kind of shied away from it: the logic to lock and
check refs is quite intertwined with one another in both backends, so I
was afraid that this would ulmitately lead to splitting hairs.

> (Another curiosity is that the messages in the reftable code are
> marked for translation, but the ones in the files backend are not. I
> followed local convention in each case, but we may want to harmonize
> this at some point).

Oh, interesting. I guess translating these messages is the right thing
to do, as the messages are user facing. But this definitely does not
have to be part of this patch series.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 905555365b..a4419ef62d 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2512,13 +2512,37 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
>   */
>  static enum ref_transaction_error check_old_oid(struct ref_update *update,
>  						struct object_id *oid,
> +						struct strbuf *referent,
>  						struct strbuf *err)
>  {
>  	if (update->flags & REF_LOG_ONLY ||
> -	    !(update->flags & REF_HAVE_OLD) ||
> -	    oideq(oid, &update->old_oid))
> +	    !(update->flags & REF_HAVE_OLD))
>  		return 0;
>  
> +	if (oideq(oid, &update->old_oid)) {
> +		/*
> +		 * Normally matching the expected old oid is enough. Either we
> +		 * found the ref at the expected state, or we are creating and
> +		 * expect the null oid (and likewise found nothing).
> +		 *
> +		 * But there is one exception for the null oid: if we found a
> +		 * symref pointing to nothing we'll also get the null oid. In
> +		 * regular recursive mode, that's good (we'll write to what the
> +		 * symref points to, which doesn't exist). But in no-deref
> +		 * mode, it means we'll clobber the symref, even though the
> +		 * caller asked for this to be a creation event. So flag
> +		 * that case to preserve the dangling symref.
> +		 */
> +		if ((update->flags & REF_NO_DEREF) && referent->len &&
> +		    is_null_oid(oid)) {
> +			strbuf_addf(err, "cannot lock ref '%s': "
> +				    "dangling symref already exists",
> +				    ref_update_original_update_refname(update));
> +			return REF_TRANSACTION_ERROR_CREATE_EXISTS;
> +		}
> +		return 0;
> +	}
> +
>  	if (is_null_oid(&update->old_oid)) {
>  		strbuf_addf(err, "cannot lock ref '%s': "
>  			    "reference already exists",

Makes sense. If we've got an all-zero old object ID _but_ the locked
reference points to a nonexistet ref we refuse the update.

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 99fafd75eb..ef98584bf9 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1272,9 +1272,33 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
>  		ret = ref_update_check_old_target(referent->buf, u, err);
>  		if (ret)
>  			return ret;
> -	} else if ((u->flags & (REF_LOG_ONLY | REF_HAVE_OLD)) == REF_HAVE_OLD &&
> -		   !oideq(&current_oid, &u->old_oid)) {
> -		if (is_null_oid(&u->old_oid)) {
> +	} else if ((u->flags & (REF_LOG_ONLY | REF_HAVE_OLD)) == REF_HAVE_OLD) {
> +		if (oideq(&current_oid, &u->old_oid)) {
> +			/*
> +			 * Normally matching the expected old oid is enough. Either we
> +			 * found the ref at the expected state, or we are creating and
> +			 * expect the null oid (and likewise found nothing).
> +			 *
> +			 * But there is one exception for the null oid: if we found a
> +			 * symref pointing to nothing we'll also get the null oid. In
> +			 * regular recursive mode, that's good (we'll write to what the
> +			 * symref points to, which doesn't exist). But in no-deref
> +			 * mode, it means we'll clobber the symref, even though the
> +			 * caller asked for this to be a creation event. So flag
> +			 * that case to preserve the dangling symref.
> +			 *
> +			 * Everything else is OK and we can fall through to the
> +			 * end of the conditional chain.
> +			 */
> +			if ((u->flags & REF_NO_DEREF) &&
> +			    referent->len &&
> +			    is_null_oid(&u->old_oid)) {
> +				strbuf_addf(err, _("cannot lock ref '%s': "
> +					    "dangling symref already exists"),
> +					    ref_update_original_update_refname(u));
> +				return REF_TRANSACTION_ERROR_CREATE_EXISTS;
> +			}
> +		} else if (is_null_oid(&u->old_oid)) {

Wouldn't it be more natural to put the new check into this `if
(is_null_oid(&u->old_oid))` branch? Makes it a bit more explicit that we
really only care about the case where we expect the ref to not exist.

Ah, no. I missed that you also change the original condition and move
the `oideq()` call into the whole thing. Makes sense.

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index d29d23cb89..29b31e3b9b 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -2310,4 +2310,25 @@ test_expect_success 'update-ref should also create reflog for HEAD' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'dangling symref not overwritten by creation' '
> +	test_when_finished "git update-ref -d refs/heads/dangling" &&
> +	git symbolic-ref refs/heads/dangling refs/heads/does-not-exist &&
> +	test_must_fail git update-ref --no-deref --stdin 2>err <<-\EOF &&
> +	create refs/heads/dangling HEAD
> +	EOF
> +	test_grep "cannot lock.*dangling symref already exists" err &&
> +	test_must_fail git rev-parse --verify refs/heads/dangling &&
> +	test_must_fail git rev-parse --verify refs/heads/does-not-exist
> +'
> +
> +test_expect_success 'dangling symref overwritten without old oid' '
> +	test_when_finished "git update-ref -d refs/heads/dangling" &&
> +	git symbolic-ref refs/heads/dangling refs/heads/does-not-exist &&
> +	git update-ref --no-deref --stdin <<-\EOF &&
> +	update refs/heads/dangling HEAD
> +	EOF
> +	git rev-parse --verify refs/heads/dangling &&
> +	test_must_fail git rev-parse --verify refs/heads/does-not-exist

Do we also want to verify that the dangling symref got converted into a
normal ref? Or do we already have other tests that do so?

Patrick
