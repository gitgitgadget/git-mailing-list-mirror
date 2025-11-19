Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4813625C6EE
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763587676; cv=none; b=nEXsxrNqNUP7AEF2feMgpoc1dr8XnvbLZNwwGbDIJsoyyqhYWcxGlwmZagi6k88l5ra2IfrXX546ssebhv99zaVa/zOKj3Enf4u8a7Hmlnh5M9KZ4H6uk8QFuW2fg3BoJ9IratfjSgyae/nDYUPuXHAD/Lirv0jcDpnPSU80Zb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763587676; c=relaxed/simple;
	bh=pW9aueJTdVJl4ngEr4NAyW2z92L/je64MrFZxxvVslM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c+25uyaLWVAqQrhTBhWDYYZw2ur+XP6pqxM56POH5YaP0Uj2EK8s/HhPPpgOu3vYNcnXxCnxU2LhDKRxGSA6VowKMXIRgtrZRdQx4+kh843ixa3gKHJpnhYDSJCDxjDME2l6REhNPVvMfzOa2Vjl+zlLrEOsANGlEPbB6vBO41M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CGOhERa3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wc0WAoYN; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CGOhERa3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wc0WAoYN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 521DEEC01BF;
	Wed, 19 Nov 2025 16:27:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 19 Nov 2025 16:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763587673; x=1763674073; bh=q+imsgGugi
	pFSfJc5CuAVsrVPCc6QxTTEdQ5JGuVIv0=; b=CGOhERa3PPBFmvU8ycayJA9GH1
	b0C0/uzmBhbaSyI3eJUQxb0efkswU++3CV6JyCBcL1sgC+ciQRB5v/IC6SLh60GN
	Ej248eH2CxAMu5vpW1oQKWGc93NWV+kmr+w+s7KH/3sdccNS/1VyvGGdTVW3kRwH
	siLurjpid+LpKw4Ai8loPol/irIhL2IGBFRHj67r6MQqZaQ6mggclQpfJ2c+z4qL
	EE9FfRdn0UhWg+dUP5oi/AOeo+3Teo97Zbjm8qj6PwIfAualobsXybkzqc2N6T+X
	E2HJ/qf/QV0SB4aBCSKNWJ+OZLrrQS61tvNKxiSK1rX2M2qpy2NZgVr1F5fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763587673; x=1763674073; bh=q+imsgGugipFSfJc5CuAVsrVPCc6QxTTEdQ
	5JGuVIv0=; b=wc0WAoYNB385iy12F84M0VptLiweC1mzpjKCAxU6eDgPxsc6+lF
	dTheyk0DaBtl8Fg7i5VZ9X4IM8dgUnQw6iTGcE+te+9pvBuCqOWiB0zMslZxhUUQ
	mfIefqWcVb7QaiM4jiRJg7Inhkio8fquHtQr2si2xj9edpMcjQqtb7CWHA/kPzA8
	yH2Lq3B+ykW61OV1h/xMViihqSl4GqMHuZC2Nz0fLTJsHRtaKy9WmuiCyiISYK5M
	H3sZ+Q/NmMgwkqC1TZKQgwwR9OlK81jWAeQ0ZlF7nV5cb5XjOhp7psUs4FfurKQv
	CLJE3tyOyXSTiv9e7NG+rxYPSTZgXbbCTyA==
X-ME-Sender: <xms:WTYeaaPOb0lLGdEndkMK2aRU2wijVtAWFuZztL6691YEWoSPDCK5TA>
    <xme:WTYeaQZlV0KhJWYS_koJw6DZiV92ma8WPIvN5bBompL9NWA1_4piamprJ1owOPQma
    NxyvsrZrWcapTX92Sf6ShEdR2731gsQEB07BN90wYG4mPd9lTupUw>
X-ME-Received: <xmr:WTYeaepv_01FD16Jxe80QVtU0zwodv-Uo_8D4GadqHZOthoEkmoaKLilQwpe3Cjs4hXgMmXMxAF9D4KFUABeNFW2qGXwT9UJEyiK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:WTYeaUZm0bTJjm8uuzXA-EcrEXOUy12zwZaBpiAdGiYIjA8VSyedCQ>
    <xmx:WTYeaWTr9IUVCzBLXcwsvYrbXqH6O-RRehZEsqjCMQcAU7uJN0W2Pw>
    <xmx:WTYeab6ShdeIcs9J7zdswfk35Majmm7ZQGLSgenT6vjMg6PYHcymUg>
    <xmx:WTYeabw4sT6fphOv_i8q6HF4EVHuI96HsBHGoqdcgrZhFxqyPLZmhA>
    <xmx:WTYeaQjOtyhlT8Hi3TE-E_9CmPBSRHCYc6aCwZZxJDabi7AdELQuPlrB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 16:27:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/13] builtin/index-pack: fix deferred fsck outside repos
In-Reply-To: <20251119-b4-pks-odb-creation-v1-7-2b2ed2612cb6@pks.im> (Patrick
	Steinhardt's message of "Wed, 19 Nov 2025 08:50:55 +0100")
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
	<20251119-b4-pks-odb-creation-v1-7-2b2ed2612cb6@pks.im>
Date: Wed, 19 Nov 2025 13:27:51 -0800
Message-ID: <xmqq1pltbtm0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> There's another option though: instead of skipping the final object
> checks, we can die if there are any queued object checks. With this
> change we now die exactly if and only if we would have previously
> segfaulted. Like this we ensure that objects that _may_ fail the
> consistency checks won't be silently skipped, and at the same time we
> give users a much better error message.

A packfile stream may not have the blob objects these tree entries
refer to, in which case index-pack cannot work outside a repository,
but I think that is fine.

> @@ -2110,8 +2110,23 @@ int cmd_index_pack(int argc,
>  	else
>  		close(input_fd);
>  
> -	if (do_fsck_object && fsck_finish(&fsck_options))
> -		die(_("fsck error in pack objects"));
> +	if (do_fsck_object) {
> +		/*
> +		 * We cannot perform queued consistency checks when running
> +		 * outside of a repository because those require us to read
> +		 * from the object database, which is uninitialized.
> +		 *
> +		 * TODO: we may eventually set up an in-memory object database,
> +		 * which would allow us to perform these queued checks.
> +		 */
> +		if (!startup_info->have_repository &&
> +		    fsck_has_queued_checks(&fsck_options))
> +			die(_("cannot perform queued object checks outside "
> +			      "of a repository"));
> +
> +		if (fsck_finish(&fsck_options))
> +			die(_("fsck error in pack objects"));
> +	}

OK.

> +bool fsck_has_queued_checks(struct fsck_options *options)
> +{
> +	return !oidset_equal(&options->gitmodules_found, &options->gitmodules_done) ||
> +	       !oidset_equal(&options->gitattributes_found, &options->gitattributes_done);
> +}

So, if we see a tree entry for these special blobs (and remember
them in the _found oid set) before we see the blobs, fsck_blob()
would notice that it is looking at the blob that is in these _found
set, and throw it in _done set while checking the blob in-core.

A packfile we generate has trees before blobs, so a self contained
pack stream should still be validatable outside a repository with
this code, but other people's reimplementations of Git may produce
a packfile that has a blob before a tree that refers to the blob.
In other words, we can validate a self contained pack stream outside
repository on a best-effort basis.  And that is perfectly fine.

