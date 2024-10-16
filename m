Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0FB4879B
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 05:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056774; cv=none; b=V8IHIVHqm83LF6Dl3WWeydqYl5HscuMqXP7zWVUpufGRBaL/T67Ru+wZwo1oW2FQponjK2ArlEtArqCBDcP4Xyg+ADFwdkA4XrPNN7edW/pSNZ8Bdvi2umAVi92XXJwkMW141z+H+F2U1QTSe9g+ZDElRKiB8JfZE0uUzBZBJE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056774; c=relaxed/simple;
	bh=pfPwfGWcqv+Zf3PsUXYqCXNCeboVvqtivwFm8ctTMKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1VdtE+evfQDdBXZEvLLEH0UweDwfYNCghkmexYADfxEzGBc31U21sGZhe6oavqIGXgatqxDLUmasctVt6KdVy0KsBpp8BOEoK6jJdAZlC846vcxdVm/XGBkOvP5vzebH6UcOn84q7un48sezru8p1f/g0lTRWzAEBigZX9+Sc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gyjvoYKi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o3kdDF8j; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gyjvoYKi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o3kdDF8j"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D9B1254008D;
	Wed, 16 Oct 2024 01:32:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 16 Oct 2024 01:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729056770;
	 x=1729143170; bh=QIY2CWhVN2im3qsP3oLHWR/k4NEkrA9/UhNoxc2QFFo=; b=
	gyjvoYKiQ7QxmnTh0PW/oJlpQzHZKftyVkiXK0iOCykTLxM9J+oPS3E5kwNgN3zY
	TAR/FTB2zk02iM9dNjkJQBJEsuQniLQjXmok6aqD1xHTJ8IPeRngsUvUBBNzN2Vd
	/NjZ1PA+Lig/dUH1wwpe+fOhhQ6kUu2XL7AOEJsj4jVScPt8goT/tOuHV5xn1Mmb
	rKHYvLcvN5yjmymN4E44kyb1hsknodf5RVqWYQ8afBHxoV40ofPO18s2JIgduH5k
	mF/+TjzH5bMaN6a/FyTlZaAbwYg4QaOyLDXgPYnA3Vvm/0+RB6uunr1vD/saoc8s
	sW3lmcomxaAWP9qxD6Jb6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729056770; x=
	1729143170; bh=QIY2CWhVN2im3qsP3oLHWR/k4NEkrA9/UhNoxc2QFFo=; b=o
	3kdDF8jZPQQ6yoSAj+VahIguEUk5FkhgqANw9f71JCxH7+jObg0g8eZdFq7NoPwb
	W6jzbElQgJCbSOjLtz/5vOpgC6vjRlLD5ytox5NWQpA7sFzv61tL1d4rAw1RdeHA
	ZgX4/oG9p5DF7HXSbsQqwxbCqKEzX0yasT41mRYHynjpLIJVQMXU/2PYs/mt0n/J
	JScXuVDzHTFAntOp5uNkLZj/3wJoywdNnYXd5BATRQoLJVvREe0kL+yE5BMhFqOC
	eKjtOALyLvpvBSr03IzEVhp37+SU2WB2cOS2F2R2/UtuMqDQItZT0Ti+/uQ2jsxk
	iIjkNlMOMyYNVoohKzRdA==
X-ME-Sender: <xms:AlAPZ-D_LdJ148YfAOgIfzUsJqULkd7Qb98Pm0wz9LduFNBUX0x-JQ>
    <xme:AlAPZ4hO7zs3k9vnNkYTkE1WH28cydv1Wl3cKY_YRogt_PSaWvzzR8_aEjhkPA0py
    1Ze22CUInwiViXlNw>
X-ME-Received: <xmr:AlAPZxn4MtKUV6-rvO0JmYtGNiKD69jXkSzeav9pqvLRrOANPdp6uUinY1vqt6-eZU3W07d1UEIRTdk9xn-LGFQubp17B3v1g3tvcOd2oiF72Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeifohhlfhesohhrihholhgvrdhshihsthgvmhhspd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AlAPZ8yEifQNLN4mcBqixVhju_re5F5S_aLs1dOsA75hvB2uLu5xjQ>
    <xmx:AlAPZzSXMDxpPcaE58bs48ndJ2Mpv0x3ZgAT_Hnh3IvbdKccbsRDcw>
    <xmx:AlAPZ3a1X0WaLNk1pCdciKBEReS5fYdSAFqHW798hzKEg6iljHnxXw>
    <xmx:AlAPZ8TYLZZemttimf2ESzdHqz8qUXcIG-mMqQctgPwOfklCCY3ypA>
    <xmx:AlAPZ-fWe9OPuo-8rY99d8l6AWNRR042f2l_76xGmcDHHVHSu26SzBgR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 01:32:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9035937e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 05:31:30 +0000 (UTC)
Date: Wed, 16 Oct 2024 07:32:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH v2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <Zw9P90_QtiAAH3yz@pks.im>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241015114826.715158-1-wolf@oriole.systems>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241015114826.715158-1-wolf@oriole.systems>

On Tue, Oct 15, 2024 at 01:48:26PM +0200, Wolfgang Müller wrote:
> +	/*
> +	 * NEEDSWORK: Later on we'll call parse_revision_opt which relies on
> +	 * the hash algorithm being set but since we are operating outside of a
> +	 * Git repository we cannot determine one. This is only needed because
> +	 * parse_revision_opt expects hexsz for --abbrev which is irrelevant
> +	 * for shortlog outside of a git repository. For now explicitly set
> +	 * SHA1, but ideally the parsing machinery would be split between
> +	 * git/nongit so that we do not have to do this.
> +	 */
> +	if (nongit && !the_hash_algo)
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +

Makes sense. As you say, git-shortlog(1) should ideally recognize the
hash function used by the input. The next-best thing would be to provide
a command line option to switch it. But punting on that should be fine
for now.

>  	const struct option options[] = {
>  		OPT_BIT('c', "committer", &log.groups,
>  			N_("group by committer rather than author"),
> diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> index c20c885724..ed39c67ba1 100755
> --- a/t/t4201-shortlog.sh
> +++ b/t/t4201-shortlog.sh
> @@ -143,6 +143,11 @@ fuzz()
>  	test_grep "too many arguments" out
>  '
>  
> +test_expect_success 'shortlog --author from non-git directory does not segfault' '
> +	git log --no-expand-tabs HEAD >log &&
> +	env GIT_DIR=non-existing git shortlog --author=author <log 2>out
> +'
> +

I'd like to see another testcase added that exercises behaviour when
git-shortlog(1) is passed SHA256 output outside of a repo, as I'm
curious how it'll behave in that scenario.

Thanks!

Patrick
