Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890D2D24A7
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404104; cv=none; b=l3xJzQuS8J6hi6/SW4+dVQRDPqTpUGatb3liwE4NyjRPqrXiYBF37rsOODnRNgDxQHDW6lVUPky9kwnsVWBvM7pMbxOaDcH24v1NHNAuzuSb7pPLRt2GwAVCjEWftEW414da5uufaTK4m/mIe1B07W1ym073gN7crvcdMoj/4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404104; c=relaxed/simple;
	bh=6ywzK5aT9GJvfNVfIMDp7iswD1S/tjQfqr4Dg5KkonY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SLm1anWNiHevLqKNfVgJhopq74XXADczGlTlvHmi0RvOGT+ugX/Ttui4HPZVLEWezLRpJ0pQlzIvnBDIu8s8PNirTTPgfH/KGvjq31Ewto9rlEiSgv5Q3UlKMTo1sgcVOqW7I57xH6r762tQ6s28rQ1JepNHLHRj+PMToZeyg24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eQt0R8oh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fLGAdkhP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eQt0R8oh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fLGAdkhP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 98F11EC01B1;
	Mon, 17 Nov 2025 13:28:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 17 Nov 2025 13:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763404098; x=1763490498; bh=m2LkOwXbOO
	6dpxI6+CvNyGZ3to8td4CtZSVf545dCRM=; b=eQt0R8ohe8BPAvpQGjDiUpjzh5
	ImgMIGCD6mcuWR77JCkFz5GZbowo+QwImCDD1BHBHeilZLQXDzImIx3+NZEybstN
	1YvVL4ZEKYOiaf/Ta6mURLxTYnA3Dm/hSONSg4+iQ4Oedr0EVSC4BopITHGwBbzO
	KUPOC5fWxdBSmN2Uq6AjkV2iJyhB6tAy9UfPPY502Dtp0wMal0Qb4xBH7fp+UB+s
	/voS8U5YuxxpbQzPXC/ARwOZXm+qID9roJudh9JtSLivHHZKleMpN7Ok9uUdBELq
	BG8awLsNOp2rjRTBgBhFvhtNj8lBJow3vSgKYybzLSNWm2bz8jMzqNL7R7Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763404098; x=1763490498; bh=m2LkOwXbOO6dpxI6+CvNyGZ3to8td4CtZSV
	f545dCRM=; b=fLGAdkhP8knhJXxZBOb+WXkNKQ7tEA5WLXCTkd/G4+H+J4LVKQ0
	AIfMo8GdZXmmqdHWX3nojkfvDVdfDY0DCT5sZdQJpXnw3D5U8ga8lMuUH8OGYruI
	ky33NcCaH1I/UeeL2ZzKRJXpjx3QOH6up6pUiMVz8PuWKBC3UXxY12rfEE+vBrdB
	atqLbMeZrVl7Aj4wbn06Ouuv9DQ7UrNURK2UGs7Bgo99ttJO2wGTZig1W86r40Mu
	ktEvOYHsiCKcBoaHZajq/iSI95PGyN3DVXEdHxu58m45SCFrqINJfSO2j3gp2p9N
	IcME2m3aRqNpnCCnLuzAiy33dQQXAOFwcyA==
X-ME-Sender: <xms:QmkbaWNs-yTDWPLip4vGPc_6CtEIOwuJJVx8xwEGlSKKzp19mBUGlg>
    <xme:Qmkbab_Y4MoEvqqEn8oMhlohu99eZhnqACWArez_CTkGMh5PPCmhnYfRvvgEX9XPj
    MHXK_4UJ1TAdPp2FlYTQ9FR6fYze6p2ukbA1Y0hyo2ViekVkv8Yvw>
X-ME-Received: <xmr:QmkbaSTxdUSqZrHhm9g60BsiD3U6C7kXELl7dcfu3HeCOtu1tuaY1HpWgE00LpDWG2Pa3688rkcZxwb57OqMUON1jso27nFschbz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeludekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnug
    gvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:QmkbaVkSLns3XApOag9MRte2-bEv4Td2-q9pUtwaHNL1REYOgplNEA>
    <xmx:QmkbaaT7ZpxkiJiw7yCI3-zjoWlpOKw1gx5KZ1LsTW7RzGVrxE2Gug>
    <xmx:QmkbabPKtJ_DlqGZ3NkXraJ1dtwGXbFx7X1D0K_posUCSy7ZIYwT4A>
    <xmx:QmkbabUzBg2t_eUCCRhh3eh8oveON3UrGaIIdLURezFxy2dvXLBNWw>
    <xmx:QmkbafrVTIJpcZ7qiWEc4Q3kwHTqfEQp5Jk7HD1kKOiDRgavjnv5s9Od>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 13:28:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(dockerized): do show the result of failing tests again
In-Reply-To: <pull.2003.git.1763399064983.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 17 Nov 2025 17:04:24
	+0000")
References: <pull.2003.git.1763399064983.gitgitgadget@gmail.com>
Date: Mon, 17 Nov 2025 10:28:17 -0800
Message-ID: <xmqqpl9gike6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The quality of tests/test suites does not show as much when there are no
> breakages as in the amount of time required after bugs trigger test
> failures before the bugs can be identified, analyzed and resolved.
>
> As such, it is an unfortunate side effect of 2a21098b98a (github: adapt
> containerized jobs to be rootless, 2025-01-10) that the output of failed
> test cases, which was shown before that change directly in the build
> logs, is now no longer shown at all.
>
> The reason is a side effect of trying to run the build and the tests
> with permissions other than the `root` user, but without providing the
> prerequisite permissions to signal what tests failed and whose output
> hence needs to be included in the logs.
>
> The way this signaling works is for the workflow to write into
> special-purpose files whose path is specific to the current workflow
> step and which can be accessed via the `$GITHUB_ENV` environment
> variable, which differs between workflow steps. It is this file that is
> missing write permission for the `builder` user that was introduced in
> above-mentioned commit.
>
> The solution is simple: make the file world-writable.

I expected to see a+w not o+w from this statement; as long as it
works I have no strong objections, but if I saw o+w without the
above explanation I would probably have wondered who are in the
group that we do not want this file touched by.

> Technically, this write permission should be removed after the step has
> completed, if proper security practices were to be upheld, but since
> nothing uses that file again, it does not matter, and the fix is more
> succinct this way.
>
> This commit is best viewed with `--color-words`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2003%2Fdscho%2Ffix-failure-reporting-in-dockerized-ci-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2003/dscho/fix-failure-reporting-in-dockerized-ci-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2003
>
>  .github/workflows/main.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 816d5a34c4..ca7cc2984f 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -433,7 +433,7 @@ jobs:
>      - run: ci/install-dependencies.sh
>      - run: useradd builder --create-home
>      - run: chown -R builder .
> -    - run: sudo --preserve-env --set-home --user=builder ci/run-build-and-tests.sh
> +    - run: chmod o+w $GITHUB_ENV && sudo --preserve-env --set-home --user=builder ci/run-build-and-tests.sh
>      - name: print test failures
>        if: failure() && env.FAILED_TEST_ARTIFACTS != ''
>        run: sudo --preserve-env --set-home --user=builder ci/print-test-failures.sh

Thanks.  Will apply.
