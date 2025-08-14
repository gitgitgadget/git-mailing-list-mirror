Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C43E202990
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206929; cv=none; b=iF+B6Kr33SjmGZJBHCZ8uDaT+z0NPfe4FnivJaRz4d3gGmmtuUGnSkxPF2IMvkve6FaZD2M3coMpBZvkLgH5QJqA9n98NR1uf+e8qavsgcQ5rpaYqe12UZSS04kZpPu007oTjC9PLZiWjyKXopp2gs7HaDPhAAy0MbLTEJuAqjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206929; c=relaxed/simple;
	bh=U+n4uIs/BglwnSRc9pOOSnHapcqe3OheLk1h2jsD+DA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J5gsTViPO7d52eukQxqR+wOLt8jOCCdODqMPpJOdH9Vzdxa1d504XW871llvCAAxnPtNqNRP56DtShCzEjFVb0CNMWvIwZi9DEE4X4R+6f2j+sVkHf77lDd5FwZ5wjjB5IDDaHG0ACO2jvjzh97/OEWWwObzSiwINA6JOjV1U60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fdNoFPVL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uj8juseb; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fdNoFPVL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uj8juseb"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 356B7EC021F;
	Thu, 14 Aug 2025 17:28:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 14 Aug 2025 17:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755206927; x=1755293327; bh=lMPpIKbcIa
	AK4pxbGlqsbeLhq5JMQbSLXppJqU54U8I=; b=fdNoFPVLwcrCPkbHKHGDKd2iDW
	ltMCu1lkrdAoogIH/sDNpD261jUH0ZkX8MmexaM/nTgwbK899sH5dfqMkHsAqFRj
	5nXSw/dqRlOlCqllvsWuQQP5eW4Pa8tDwDH5cDRKUfSIjCcaknyw/6EzkAhOZkb0
	B2O/RgqJg7D5en2JmKsdigYJkFZLjav/b1UHThCII3AMMZsKQP8PIlaEsZsRavqm
	9ugi2GQ9g7dnWfdyAhVqk9uq3jEQebIfuHT32W2SIAcdCoYsgz4Z6JUv7VS7ZkF1
	RBjAN6JXdmbwRcHeW+qjUC3yVQdstalwqrdJPlb8EybF3gug6X4w9CDAvRDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755206927; x=1755293327; bh=lMPpIKbcIaAK4pxbGlqsbeLhq5JMQbSLXpp
	JqU54U8I=; b=Uj8jusebOWA8IGuzgyNyIqUnPdb6D5EVIwTsgfebuiMJSP5rzyx
	SjBtcbcd04/wNWHi+1Uh/xZUBBze0uhMN+fUFff8aUTnilTKW3hysjdd52ySmN0K
	ZhUmaMiNoycziQw5cxoFBjSMonLXcp+w6+9UkMYI68XdHwWuXDV2XlyLdcHxOhAd
	klWHrRl2trUWkaedRfWbl7uiivoqoRZ0u6gITLSf/60AdwfW/g5OjTYbGX285Riv
	Ww+JCZwQOMPdq2jFU/SrgxHd7dNR91mTvoaD0bEF6tX7iebxWmDBa4Kdrg37RfAH
	vtpct/qMzBFumg+gzs/3SK76zWjWjbyNAKw==
X-ME-Sender: <xms:DlWeaAPvTh1dFFZ05QHRptU7-NAxx3JPvtuXaxV84VDeA2tx6PRBlw>
    <xme:DlWeaD40qekVcDxZp4F0zp8-SrCYExhilcbVojXAZ5SR9PTtMYu5L2_CgxzH_bB1Z
    ce3LUXq6fQ8p7wS1Q>
X-ME-Received: <xmr:DlWeaC4QDOScUmVRf6wbAAp-GHfEhdcDB1RxJB9Xpi7IC1TxjhB8rNphywY1APpX7g1snckIlScNEcoFEMIk7GBA_NGHz2UDWb5NNB4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:DlWeaBHGUuZ92SCeJtuOJhii0VVXV4UX_uZ6FdZCRjQmknA3SgCe4w>
    <xmx:DlWeaCWZlaXKpnk707y5YsCF0z_EyIGEM0s0u4J8Ih09TPge3Qxu1g>
    <xmx:DlWeaFXDKK-KIXu5ySYGM-e1YFgHuMXvTsrLLR25ObmhPUwK3W4BEA>
    <xmx:DlWeaIJp6S4u2fz92f6DGwoaJsV_9v8aLY1HSEVyRyjB_Q4UMot0gQ>
    <xmx:D1WeaOeyqBhqOyoGO_YV4Z12Nj3jY7pdwix3dQv4jCOJpoZy9pAmlOnC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 17:28:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Karthik Nayak <karthik.188@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v7 5/5] doc: git-rebase: update discussion of internals
In-Reply-To: <79f29ad1e683f312cd3bbe71909fe5d552b4ae15.1755006568.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Tue, 12 Aug 2025 13:49:28
	+0000")
References: <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
	<pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
	<79f29ad1e683f312cd3bbe71909fe5d552b4ae15.1755006568.git.gitgitgadget@gmail.com>
Date: Thu, 14 Aug 2025 14:28:45 -0700
Message-ID: <xmqq1ppdzj76.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +Here is a simplified description of what `git rebase <upstream>` does:
> +
> +1. Make a list of all new commits on your current branch since it branched
> +   off from `<upstream>`. This is the same set of commits that would be shown
> +   by `git log  <upstream>..HEAD`. You can use `--fork-point` or  `--root` to
> +   change how this list of commits is constructed.
> +2. Check whether any of those commits contain the same changes (according to
> +   `git patch-id`) as a commit already in `<upstream>` and remove them from
> +   the list.

I'd suggest three things

 * Rewrite the introductory text to

    Here is what "git rebase <upstream> [<branch>]" conceptually does:

 * Add step 0. to make "your current branch" in the next step valid.

    0. When <branch> is given, check it out and make it your current
    branch.

 * Combine the steps 1 & 2. and stop talking about "git log" whose
   invocation cannot be precisely described here anyway.

Other than that, the remainder of the series (v7 [1-4/5]) looked
good.

THanks.
