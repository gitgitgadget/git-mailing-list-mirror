Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF91042065
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755638356; cv=none; b=Zp7OYuPvNLKHILmhsg2HC/7rm+EvQ2Uw7tUtGxbCp1AwEsOQEIsB+hkefVcJHmoUR0F15Y7Z5Hs9sDSFYquGtDLnBnqktMOk1fadCaDmo8kAdObAbdZB+qGJJbjtyXw0TyWoPA82vG/DYac7M/nGim/wotX/l4cmJ9QzuD8uRrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755638356; c=relaxed/simple;
	bh=TCIOJQ3goYwScj+EDyqoYurUpNaoZ/lrUdQZO+q5tJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WGHMhP7A/+oynEQSafkNUPbNqRItootX6VOEYC6qBARbhBw5eRC7A5wlkYjSkYKNhhh6XtqkWqE3OVFKXPEgItNNJ7BgF2qh5Ah0S2xOQdv3nmvCuM/xO7CF3GpR5p9m0KtjTpwa/5FhNaskaxxqQFkGWOfnGsjKSUgMjg6D7HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l/ZNmQa6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l17OJK61; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l/ZNmQa6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l17OJK61"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 01F8A140012E;
	Tue, 19 Aug 2025 17:19:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 19 Aug 2025 17:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755638352; x=1755724752; bh=1Vgxwj4E+8
	KanYfaF1AXBLHA+PmxpUz010BWLlO7DgI=; b=l/ZNmQa6lqFn/w7CZu7e5vSxlX
	nZRy+XYAiojLw1cLJtUWn/Mc3KVKpkrk+uh75+zIEnnphuvZL6k15thhiVwaF8p7
	LvG/7I/2wHV5TTBMNBsyS3AMhQNrPLg7BIze+S+gthT2HbtfbqEKCiGtyAT+/IiW
	B+vKM6HClZwGyVidyHm+QBq8vN/uOK9H3BEZonVuLtfjt5Rfpbb9wVk8cvmdpcos
	dAgxM8S32WJrFHYVT1E6RSu2vONreTYGSyr57Qsead9s4kOLYI6m0N+odthmrUoQ
	9JhDG14XTkBt1HRpBuq/mMF4e2Sw+m+ywgw3KPYd90nXROUlRX6XaOq+MKaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755638352; x=1755724752; bh=1Vgxwj4E+8KanYfaF1AXBLHA+PmxpUz010B
	WLlO7DgI=; b=l17OJK61OnNqigk+yAUnL79K1mACH0S7kGWf/TAgmTXNPPRQjtq
	5CBXY79yzEtsvpeAyT9R4/4hj/D24yp6aCm0wAt1L6UJJWhpBOYZloOIfUtLzVqZ
	Sk89os8W3jj2hlkU6APg2MFMMVW6OCryo18nKOU/m9RcN1MhA7B9WfTFvVkYttW+
	gcajwXMNM/xJfukp8ZSJAJjQEAC8+3wh6xlmRiy2+ZR5kGtV0HCp43kIVQwPRgti
	ZCKY8yWhSeMWkoNIA3umj4aIjb6vi3gwxs699Omq/3ZAeIZgKXioqzkkrw5SmzST
	ID9EfuvpuHLWh2H/kuSZjv+WHx+XJEgYmVw==
X-ME-Sender: <xms:UOqkaNV65fwKiuVk3YXp0_A9bRHFmw_EPCqoOy9uB6cXEoxG7rKl2g>
    <xme:UOqkaIK4Vjql9EkE787eJ38QI92lKTGCQToo6Vb51tfs05I73C7-e0596hfgMr0Jj
    F6lkweFeO3urmKLvQ>
X-ME-Received: <xmr:UOqkaF9pqW3nsYi3EmD-e4sYdQSLZFaYB5OJDg-_bO1_62Ipm5mqhSim-_k66AtTvqqfLOoFugx-WDWScBZZZp3-aylQXh-s0qAz_-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeiheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hushhpvggtthffohhmrghinhculdegledmnecujfgurhephffvvefujghffffkfgggtges
    thdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsth
    gvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepgfevvdefjeehtedtgfff
    fefhtdfgheettdekheejieekgefgteejgfekieefkeffnecuffhomhgrihhnpehgihhthh
    husgdrtghomhdpghhithhhuhgsrdhiohenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlvghsrghsshholhhisehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UOqkaDJtohiZs-jxhsIPLkROTuH710ey6apF9kaatns55HO3SUg0cQ>
    <xmx:UOqkaCm48b_pTdiBRvBdf4XJ0IW3IRszOvnveyMwBslgNv_N0eeytA>
    <xmx:UOqkaPNSF8He9-3KRophZSZ6-QA1eQ7BJPo2gEwacECw9-zG909jFw>
    <xmx:UOqkaA2KpXiVfa2-NDlX7JMhWXQ1x13eH_lO2FEjt5jNMsfz9hCx6A>
    <xmx:UOqkaOljl2fknNG7M8mJtCh1gr7bzv3jJ2HPL9pfyZOdOH_RXisq4Ns9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 17:19:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Daniele Sassoli <danielesassoli@gmail.com>
Subject: Re: [PATCH] doc:clarify which remotes can be used when contributing
In-Reply-To: <pull.2034.git.git.1755630882418.gitgitgadget@gmail.com> (Daniele
	Sassoli via GitGitGadget's message of "Tue, 19 Aug 2025 19:14:42
	+0000")
References: <pull.2034.git.git.1755630882418.gitgitgadget@gmail.com>
Date: Tue, 19 Aug 2025 14:19:11 -0700
Message-ID: <xmqqms7vc8mo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com> writes:
>  https://github.com/gitgitgadget/git and open a PR either with the "New pull
>  request" button or the convenient "Compare & pull request" button that may
>  appear with the name of your newly pushed branch.
> +If you're using https://github.com/git/git as your remote, you will need to
> +open the pull-request from your fork, selecting `git/git` as base.
> +
> +The differences between using `gitgitgadget/git` and `git/git` as your base can
> +be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)

Looking at the table, there is no advantage to use git/git at all.

Instead of telling them that they can use either (with reduced
capabilities if you pick one of them instead of the other), wouldn't
it be easier for the user if this section taught them how to switch
their fork that they originally created out of git/git to be based
on gitgitgadget/git instead?  Something along the lines of

    ... If you originally forked from https://github.com/git/git/,
    you can easily correct it by running (you only need to do this
    once):

    $ git remote set-url origin https://github.com/gitgitgadget/git/
    $ git fetch --prune origin

    A pull request at https://github.com/gitgitgadget/git/ can be
    opened once you do so.

but you'd need to validate the procedure, as I didn't try it myself.

Thanks.
