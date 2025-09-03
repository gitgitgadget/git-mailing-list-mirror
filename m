Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867232DEA87
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885251; cv=none; b=XIKmKRxubYREBLS8OUZv3ZqyNkPQjG1wrQR7800Lc++EEU58taAHAdtslc7tOJ0Fu1RjldE5PJfrhfBGplvlNbqG837xge58xFLpa7El80AzYwmSzyMUjL1sGdtnB5etLOCo+kL/a1L8oOZdp3Q+ShkPdxPR93A0ln8kmMrXIQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885251; c=relaxed/simple;
	bh=725IqzuuhgA+xsQSCtWM7tbyH5qjFh7w50dKb1uUmmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riCOV8IZ6Oxz9yMR635n+i423BF/0tnb16XL6SIP2+Ab7HTreeaRJ50q0exGxQdeWmdqk81wdNNage4WO4hp4v80rfJLqgGQYn0UWqUNPIABuesimBYWBD763G52J0WiGWGjmvykk88Asiroiw0wMKccLoxz6E5AToM6RoEzcHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sc7K5ZjQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sbn2pAQ7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sc7K5ZjQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sbn2pAQ7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 775BF14003FD;
	Wed,  3 Sep 2025 03:40:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 03 Sep 2025 03:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756885247; x=1756971647; bh=9SD7r1RQig
	oK+XPLQutbf6gZ35CAUePGL5+IAYXkVv8=; b=Sc7K5ZjQQhZrJfOutpcsjZQPLU
	+d4qAE+QhmH7+mjr9/ZgMkP63hZPpwkOc1Xhv9PVrVrpo/fiLcX139IyzkznghkI
	wSX4WqdP7DzcJSzZPT7j1wu1cVY0KCuQ4sD19her6nWg/TW7CuRTTrxhF9rl9DDb
	YM1AWTUzvNCEmcjhpTDtDcWQ7Jbxyem7tRdjiFJRt4RMgLaXAPHmMOZRt9Nk0Z3q
	+EMcCvSWFfciJpesGpsMnLQsvUWJBNb6vaCeqza58v5SQgmMBHvUKL69jtvKSaaG
	GXA64EcE51WyyMvGUJmjXvXHTo3+SanJjVwHVXP+FnHSnW7B+2fbG3l2JHNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756885247; x=1756971647; bh=9SD7r1RQigoK+XPLQutbf6gZ35CAUePGL5+
	IAYXkVv8=; b=Sbn2pAQ7AqdEz9n7MkzdDHcmLlIRdvL+F9JORWDPjMZr9DaVHC5
	Lxxep43OZVPo8/g3TZ2dMzJ35YOHhmp+4NHDFihaEm6CJgzkLy4o7hnOfLc39Z1P
	vnJfAZEPt5OEnZD4cgqYkSN8F5Y4m/DdHM/18791GoYseGm9bI6geaK+LZ002C61
	CNDhz1QWCKbcni+rLJiQTEeQJo2U9HcqmVfRPMcSP5b8JLMP23cIbFjT9eG4DZWg
	WU9gLt1sH2GokgMOR9hiyrlK++2de35BXkDQ5aNXOdujl6TPS7WNJTWsb7sHKrcV
	oHYOQKF2eq/RgeAgqjUhu6bYbsy853ayKwA==
X-ME-Sender: <xms:__C3aIYXYO8TK7ZEUad53xKVLMrAcOcHyfkZiZLRiOzAGED6Z3um8g>
    <xme:__C3aO76psfTFJuNVNxqyJO-NDs8uE9skQ54qgHAlaHHUH38_zbpgfqQI1pNFpg1c
    Rbq5A15mqXyVRf03Q>
X-ME-Received: <xmr:__C3aJbVk0SHnNYP6syyFH_4UFc1PSQEg9d6n7kCaOfxdPK3OdvH2R0MUnxJRoFutd2yUvYlTDyGUEnr1FlpApkcmlRCgBB5A4IhR3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovgdrughrvgifsehinhguvgig
    vgigtghhrghnghgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:__C3aNhxNDRyEsnshpEHMa4cYPrsod-WxnddMd0LfuvDqyimS_EG2A>
    <xmx:__C3aK_iuJ_Q6tyhCceQdiD7YTtf41mUM9BZWhZiHa1fHK1Aby7-QQ>
    <xmx:__C3aIoG7y74udvmRshnBNcW10aUzQGJAFkicr-dUhXrUlVoj_vYNg>
    <xmx:__C3aCUGT2YO6u6NH4pAAs3r7rNup2gTVRzDCJVJgcBqr2MWVxYjhQ>
    <xmx:__C3aK0uUrfuR19KYHyoBt1gq7YiJmPlumhn40b9YesX6nR9WqsjxUP4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 03:40:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1543ca7c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 07:40:46 +0000 (UTC)
Date: Wed, 3 Sep 2025 09:40:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net,
	gitster@pobox.com
Subject: Re: [PATCH 2/2] refs/files: handle F/D conflicts in case-insensitive
 FS
Message-ID: <aLfw-peLY8NEKSZd@pks.im>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
 <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-2-35e69bbb507d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-2-35e69bbb507d@gmail.com>

On Tue, Sep 02, 2025 at 10:34:26AM +0200, Karthik Nayak wrote:
> Similar to the previous commit, when using the files-backend on
> case-insensitive filesystems, there is possibility of hitting F/D
> conflicts when creating references within a single transaction, such as:
> 
>   - 'refs/heads/foo'
>   - 'refs/heads/Foo/bar'

Great, I wanted to ask about this scenario.

> Ideally such conflicts are caught in `refs_verify_refnames_available()`
> which is responsible for checking F/D conflicts within a given
> transaction. This utility function is shared across the reference
> backends. As such, it doesn't consider the issues of using a
> case-insensitive, which only affects the files-backend.
> 
> While one solution would be to make the function aware of such issues.
> This feels like leaking implementation details of file-backend specific
> issues into the utility function. So opt for the more simpler option, of
> lowercasing all references sent to this function when on a
> case-insensitive filesystem and operating on the files-backend.
> 
> To do this, simply use a `struct strbuf` to convert the refname to a
> lower case and append it to the list of refnames to be checked. Since we
> use a `struct strbuf` and the memory is cleared right after, make sure
> that the string list duplicates all provided string.
> 
> Without this change, the user would simply be left with a repository
> with '.lock' files which were created in the 'prepare' phase of the
> transaction, as the 'commit' phase would simply abort and not do the
> necessary cleanup.

Oh, that's a clever hack. Does this also work for the case where we have
preexisting refs already that differ only in casing? I guess it should
given that the lookups we perform should yield those refs regardless of
their casing.

In any case, if we don't already have such a test it would be great to
also verify that this works as expected.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 9f58ea4858..466cdfe121 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -869,8 +869,23 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>  		 * If the ref did not exist and we are creating it, we have to
>  		 * make sure there is no existing packed ref that conflicts
>  		 * with refname. This check is deferred so that we can batch it.
> +		 *
> +		 * For case-insensitive filesystems, we should also check for F/D
> +		 * conflicts between 'foo' and 'Foo/bar'. So let's lowercase
> +		 * the refname.
>  		 */
> -		item = string_list_append(refnames_to_check, refname);
> +		if (ignore_case) {
> +			struct strbuf lower = STRBUF_INIT;
> +
> +			strbuf_addstr(&lower, refname);
> +			strbuf_tolower(&lower);
> +
> +			item = string_list_append(refnames_to_check, lower.buf);
> +			strbuf_release(&lower);

Can we use `string_list_append_nodup()` together with `strbuf_detach()`
here to avoid one memory allocation?

> +		} else {
> +			item = string_list_append(refnames_to_check, refname);
> +		}
> +
>  		item->util = xmalloc(sizeof(update_idx));
>  		memcpy(item->util, &update_idx, sizeof(update_idx));
>  	}
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 57f60da81b..84dc68e5f3 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -53,6 +53,12 @@ test_expect_success "clone and setup child repos" '
>  		cd case_sensitive &&
>  		git branch branch1 &&
>  		git branch bRanch1
> +	) &&
> +	git clone --ref-format=reftable . case_sensitive_fd &&
> +	(
> +		cd case_sensitive_fd &&
> +		git branch foo/bar &&
> +		git branch Foo
>  	)
>  '
>  

Nice idea to use the reftable format here.

> @@ -1546,6 +1552,20 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'existing references in a case
>  	)
>  '
>  
> +test_expect_success CASE_INSENSITIVE_FS,REFFILES 'F/D conflict on case insensitive filesystem' '
> +	test_when_finished rm -rf case_insensitive &&
> +	(
> +		git init --bare case_insensitive &&
> +		cd case_insensitive &&
> +		git remote add origin -- ../case_sensitive_fd &&
> +		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
> +		test_grep "failed: refname conflict" err &&
> +		git rev-parse refs/heads/main >expect &&
> +		git rev-parse refs/heads/foo/bar >actual &&
> +		test_cmp expect actual
> +	)
> +'

Okay, so we again only end up with one of these references, which is the
best we can do.

atrick
