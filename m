Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E73C1F4288
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513254; cv=none; b=BsrUeSttLNySmHS0/NjomKzDcIokefik+5RnLfG5yQU0x//Yo0FvcgKqkFjOcLbX7ejVwGRCUBNzRVnR8olS6EiSw47RhXhAZ6UYuqY5oRj3ABaw2ccZ55PUeX/yXmApTraXYxKcmj1+BxNkSIahh4dOGt8DJO4HMiGHELqyarA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513254; c=relaxed/simple;
	bh=BrAQQAgNhqfHaShJ+98kcMbJ4CxSI3bdaYnZi+Bgw3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePVeng885XcwPTmxQ9BZDKrOwdfoAbdspv9QKO+PXN1KBQ+1N2i1h6q9Cgle6iCI2ThgodUbTTAeV1gHnHAeiqHMmg4zHIF7/Zq51P3CZpWLcqCAb4gS8KxUqfpkuAhEnGRma7q0LqqCI85vWWgEEIU2QfUgGOGwp5NfkE1UNAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rNb2HoWb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fmwveLJN; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rNb2HoWb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fmwveLJN"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B4C1D114024B;
	Mon, 21 Oct 2024 08:20:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 21 Oct 2024 08:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729513251; x=1729599651; bh=d6Sbm4aXNb
	4W7IhOl1NI6e2jr/ZV4rI4jfLPc5muJDs=; b=rNb2HoWbTfFFl9OCMckQjVLqxg
	8sz+zu0n/8RxvrbKwvrEtQ4r59OU6OmdFYNRdqdidbd4iyIVt/g7bXpM2uHuuNLY
	M4Nlqm2FF83MbRDpfNtGt11gYrkh1ouY1rpABSHnOtzdM3WdUEDbYTKwJtZTWaUj
	sjtKC09dTLBxiUObdHE7ibIKuAvxgg7aWmv/X0cFovVBILpQ6i1NcEpmXKXTZAVf
	h5CTRxDxHy5LwK5vEe/2j2BQlk6z2OfkfdunW1v+R9XvC3EnYN9yZ7ntEc5Y3zGH
	E2izzcYYGIeKyIw9o0g1MpmuJ6Vtxt20zKmSUALBxR4V0pxis7asRKbL+2Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729513251; x=1729599651; bh=d6Sbm4aXNb4W7IhOl1NI6e2jr/ZV
	4rI4jfLPc5muJDs=; b=fmwveLJNeY8LdNTFTBmpbhW/tQYsRrRzcEj6/dUMt0yk
	adxZxPA/KEZhylhfrHvzHO7Emahv5Tg9OQ70dlWZlcrfnk1edUNfMC5b5sAXItb0
	uPgZ3Gnt1mMi7APQgS4d9iT0d4jPGc7kROGqqK7StvUfy3SEAovzo6NyZ0bX8i2+
	uU4RA8dxRra+hbaivtnNCPOiT86fX6oS+mlMtFd95jsmiGs0w1StwsnlFIWkKhNO
	5cthNwMVM6Bto/4mt5Bz95apW8kaChGWe1W+Uw5sNAyKb7bmzmwi/vFi/Lbf0ti4
	OIDkwffBoFteEsaoxnFFEEtJYCEta13xV6qaa+95fg==
X-ME-Sender: <xms:I0cWZ6ha0OAYPTJoOtJmord8480VOREH7ZpDIBsGwiPPjFyD3NWmXQ>
    <xme:I0cWZ7Cl_3SmpVXSQ6MG4y8XpsJLF378JNFcOOdw05I0spuizJx5z1DJDkD1Rvvab
    C4yHQh2-LaaZ-5h4w>
X-ME-Received: <xmr:I0cWZyEEVtWRXwN8XqjkUsoPXL_YOb3YOIwvYoQnGpOWt7qYIE6r6u9XhV-m6SyhfaMikRNi2LdiaEamS6OHAsjjJcaNuWsEsFwRgtrQ8Dle>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:I0cWZzTUpM600-krDW5g_-HNR3nnV6IZSjoJv6L1fmekQrB2-b26Fg>
    <xmx:I0cWZ3zWCAdUZMI8Rt7LP9_BH7ce2-W1qIw13M4-KE0MoPMnb8kkDQ>
    <xmx:I0cWZx5XrbJ5sHoLN9BdNUyaiW3RVea969osdbSfcvqbWFJdmpIyfQ>
    <xmx:I0cWZ0ydWJYcCA3iBT9B5fTwfjMZa-u0_7vbH_xp9wKhqMhk_hN6zA>
    <xmx:I0cWZ5sJDLCnkFIxLLs8nFdFB1u59SnFGesR_ixCF5CETQhuR7TS594c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 08:20:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 76ce5bf5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 12:19:22 +0000 (UTC)
Date: Mon, 21 Oct 2024 14:20:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v2 2/3] merge: replace atoi() with strtol_i() for marker
 size validation
Message-ID: <ZxZHH-oHE7g09xIR@pks.im>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
 <5d58c150efbed1a10e90dba10e18f8641d11a70f.1729259580.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d58c150efbed1a10e90dba10e18f8641d11a70f.1729259580.git.gitgitgadget@gmail.com>

On Fri, Oct 18, 2024 at 01:52:59PM +0000, Usman Akinyemi via GitGitGadget wrote:
> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> 
> Replaced atoi() with strtol_i() for parsing conflict-marker-size to
> improve error handling. Invalid values, such as those containing letters
> now trigger a clear error message.
> Updated the test to verify invalid input handling.

When starting a new paragraph we typically have an empty line between
the paragraphs. We also tend to write commit messages as if instructing
the code to change. So instead of "Replaced atoi() with..." you'd say
"Replace atoi() with", and instead of "Updated the test...", you'd say
"Update the test ...".

The same applies to your other commits, as well.

> 
> diff --git a/merge-ll.c b/merge-ll.c
> index 8e63071922b..52870226816 100644
> --- a/merge-ll.c
> +++ b/merge-ll.c
> @@ -427,7 +427,8 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
>  	git_check_attr(istate, path, check);
>  	ll_driver_name = check->items[0].value;
>  	if (check->items[1].value) {
> -		marker_size = atoi(check->items[1].value);
> +		if (strtol_i(check->items[1].value, 10, &marker_size))
> +			die("invalid marker-size '%s', expecting an integer", check->items[1].value);
>  		if (marker_size <= 0)
>  			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
>  	}
> @@ -454,7 +455,8 @@ int ll_merge_marker_size(struct index_state *istate, const char *path)
>  		check = attr_check_initl("conflict-marker-size", NULL);
>  	git_check_attr(istate, path, check);
>  	if (check->items[0].value) {
> -		marker_size = atoi(check->items[0].value);
> +		if (strtol_i(check->items[0].value, 10, &marker_size))
> +			die("invalid marker-size '%s', expecting an integer", check->items[0].value);
>  		if (marker_size <= 0)
>  			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
>  	}

These are a bit curious. As your test demonstrates, we retrieve the
values from the "gitattributes" file. And given that the file tends to be
checked into the repository, you can now basically break somebody elses
commands by having an invalid value in there.

That makes me think that we likely shouldn't die here. We may print a
warning, but other than that we should likely continue and use the
DEFAULT_CONFLICT_MARKER_SIZE.

Patrick
