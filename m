Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0232F1C36
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 00:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752019764; cv=none; b=H5fqsT+pXXuc2GvAUnK6UAZeJkTiHPVtrgv+F9Bp5W1Zm/FnBdsON4GyOaVPq7tfkx/uCeqarL/r0bhYX7yx3QlFP7ub4lbzGyLModdWTXo8cn8zwdyNuvCcnqx8yXyjEPYRu/lYcyJ32XjSOcqWzB056bgETQgcHYVjTUIFrRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752019764; c=relaxed/simple;
	bh=OZyVXldGIoiRv/ohk9gD9QCfu5viUNxVcfbxUWBwCxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FpWOd/zT9TC/ELTUeBOuSA+puj4+sJNnTUH2qO36cxk4LCZSiVQSwXMY+Hj86O/Ipq3EbC37bdQEjVZMf6MosGHFyKrDgQFZJ+oKy50WMjXliwZf+5J58M6J0RLwSRaUVW5RvRSAsUCKsi3CdVdZmNVYE84+MMA9G/rgUPzxWlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ITXvvidw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fer3aOA8; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ITXvvidw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fer3aOA8"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id F05E91D0026B;
	Tue,  8 Jul 2025 20:09:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 08 Jul 2025 20:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752019761; x=1752106161; bh=9RzFmnocO/
	0S7JIU73F4cODCaoii9gtAYyBruJoORg4=; b=ITXvvidwmUoMb3aFILcsnrfs7I
	qDW1R+DfyLx1LfcxomXU4d1XvnSXZLXjVQJnASN+ghrWSLbMXX/y78LRn5heXhcB
	hsZ2KADL7Q6mlWc5cDv5wRVUurY/HvOQki4ahayusJypInfCB2BNRX95gkldMYLM
	qm4GeLo8lo9EiU3loxOXpNP+2gZQRiWdQZQAkMT6vgL2qBmDoFz7VEww0uaJGHX0
	S8FxM3BCdjQI0th4dJ05+LlESWrg2NiEA3bdWOuVHaQOhJCcqHtzGJ0ufLWPn3v2
	bn3ee3/W1Ugp9GIPVGqbE5meiHwxaKcCEWmOdTsvU9SpCfBKypo4rlWihg0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752019761; x=1752106161; bh=9RzFmnocO/0S7JIU73F4cODCaoii9gtAYyB
	ruJoORg4=; b=Fer3aOA8z0OAHZ59ERF0Ytz3Kn1NcJkwYW7Op/xA4p/s6855NTx
	O0jMBpwYxvfjJmbsW05txpSwHtOD7+v4rtiAhKYNbMyGiel6QXpUyhwrWva3RSAx
	rZ8g1DMjDNjnVuA0kIan9iAMbdhuVvsdojov4B87i9aJNo7kMNoOg7ceLqZxgdR8
	MWCtXTHUtxiGJl2/qVy3Y4wy+tamuMmvkkglL31OtQ2ec9jNpqosOEiM7MIRwCio
	KNSw6HJbJZndL/wHoLRIHNNl6XGzHgLszTWriWB3pG4fNtNJJFW5JGCCPIexcUx3
	guXTQjkqz4lDCnRGzbO6sAle9P/IY5Hflsg==
X-ME-Sender: <xms:MbNtaEFRw05PiGejeaFdphSM2NfwW89yXDuFAOsa2QLaPH7mSr2p_g>
    <xme:MbNtaKS8ot12NRqBV-PAfgIajycL3544KKzZI4fIpXEOB01X5oU54D_xLqa5zpbDz
    jWja_bRBMASbX08lQ>
X-ME-Received: <xmr:MbNtaJzH3ifT1oDg3BZRTdc7XITcDfue1vtnqca9VphVfizXnR7uL0JgckW3jcjQEqKVpAc51myeFSm8E5YPlMSA0nLaJxXOEWHetbM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefiedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehlvghonhhmihgthhgrlhgrkheisehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MbNtaOezP5WLM621acL3s5PYQzXErIZneGjtC2xfYEhe1DPmy2ufrA>
    <xmx:MbNtaEMhbdNtvVyC2WUh_XlRKWSxNkadHKGdLGI8FTkRvRnzZWcyNA>
    <xmx:MbNtaBus4FegWhwlwNwlZe_ddGzqrZQ2JuZtNWNCGDzGFvwvFKmQXw>
    <xmx:MbNtaNBp4YqkFvxziKGH6tbREqv32leIVO-0yjKnNnvL8jluvHVx9g>
    <xmx:MbNtaGmCppQQRqw2jg9pP3fMMEVX9L4VPqG-PMfmMTCbJIAu5JqMYVvx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 20:09:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <christian.couder@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Leon Michalak
 <leonmichalak6@gmail.com>
Subject: Re: [PATCH v3 0/4] Better support for customising context lines in
 --patch commands
In-Reply-To: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com> (Leon
	Michalak via GitGitGadget's message of "Sat, 28 Jun 2025 16:34:42
	+0000")
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
	<pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
Date: Tue, 08 Jul 2025 17:09:20 -0700
Message-ID: <xmqqms9eql73.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series of patches attempt to give --interactive/--patch compatible
> builtins ("add", "commit", "checkout", "reset", "restore" and "stash")
> better support and nicer experience for configuring how many context lines
> are shown in diffs through a variety of ways.
>
> Prior to these patches, the user could not choose how many context lines
> they saw in --patch commands (apart from one workaround by using
> GIT_DIFF_OPTS=-u<number> ..., however this isn't a good user experience or a
> persistent solution). Additionally, the behaviour around reading from the
> diff.context and diff.interHunkContext configs was also inconsistent with
> other diff generating commands such as "log -p".
>
> The summarised changes below hopefully make this experience better and fix
> some inconsistencies:
>
>  * diff.context and diff.interHunkContext configs are now respected by
>    --patch compatible commands
>  * --unified and --inter-hunk-context command line options have been added
>    to --patch compatible commands (which take prescendence over file
>    configs)
>  * "add" and "commit" in --interactive mode now expose a new "context"
>    subcommand which configures the amount of context lines you wish to see
>    in subsequent diffs generated from other subcommands such as "patch" or
>    "diff"
>
> The original discussion for this can be read at:
>
>  * https://lore.kernel.org/git/CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com/
>
> Changes since v1:
>
>  * Update commit descriptions
>  * Update tests to use the more modern and robust test_grep and test_config
>    utils
>  * Reword some documentation / user messages
>  * Ensure each commit is atomic and builds/passes tests on it's own
>  * Make new command line options DRY
>  * Add tests for interhunk context interaction
>  * Error if context config/command line options are negative
>  * Drop previous last commit to do with new subcommand for --interactive
>    add/commit. My motivations behind this patch series originally where
>    quite simple, just for add-patch commands to respect context configs.
>    This subcommand, after the discussion in v1, will require more thought
>    and a larger implementation that what I had anticipated. I would prefer
>    to leave this for another time as it's the least impactful but the most
>    time intensive and complicated idea.
>
> Changes since v2:
>
>  * Update tests to only test single command (following Philip's suggestion)
>  * Add negative option checks
>  * Minor commit re-wording

This iteration seems to have attracted a few review comments that
are left ananswered.  Will we see responses to them, and/or, a
hopefully small and final update sometime soon?

Thanks.
