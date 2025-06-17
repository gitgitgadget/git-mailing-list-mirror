Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0C8F54
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750187892; cv=none; b=cBcCh1ZaXnTev9IrgLNFBSfHzuTgj93jWbvsos4qtw1te8whwLQgPpBjb3ub5P2RoBnZvuSuzXwDs/ippwVlo1plVdTTZ+fR4HHdznKO1EmXnR1Gh6gPpEm9QItXCgB+csREEBwp1cuK2Y6b9d1ANZfxaP96j5S1JKKIPrgbEQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750187892; c=relaxed/simple;
	bh=ebt1ExWfiw/rBksTs3JpyZalTz35yMxEmpBHW0johlU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XrvuMJT5UfDaoIXQV48TNOAsBuP6sU/uVa6pm7rSVSx3drHRzGudHzV/DoTS/zIsfU1YKgS1t1sccb05LszvZSbI9o1zVNB3aehJSzmpMMZu/rAWRiXcZ+KA+JUpbZV+u/UoXt/YwCHi/TE2x5qwOVgSmP11Ua6fDKyqGZXqFTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HSYzf639; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OlmffU+3; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HSYzf639";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OlmffU+3"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1C81911400D8;
	Tue, 17 Jun 2025 15:18:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 17 Jun 2025 15:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750187889; x=1750274289; bh=g4J9in8MEA
	tpirB9GQFVPudd+AU23Ru6/LksYB+SPNY=; b=HSYzf6395nrLN0JMGHh7rXCfHt
	uHSLfqYVDBUGpEbKeR1mr1rJnJ2LYMYiEyMN/otbXp0HEdhAd9zERZngB+Yplc7c
	T3P7gLhyeEsGNC+ob53dULQWhHaZIvxCHZTFXUJrZ+1EC0P+kLWojwJmG9Jl3dG2
	JDpiuY/L9qLu3uSh8BVqjMhYnL4K0ke3HjUk5Sv4IdCZ65WTNM8+ptu8GYIFLmOx
	/7fr01SHkidkapiFHh7mPTRJRe8BZAUcAMjo5GRspsOEFn/KDlehovh7oZaFZUaE
	EqCikPAX5QIMPwyMdF7DldQ2wmeIzJPM1ZXuSjqMytK2fX8YWfHMbg35LZYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750187889; x=1750274289; bh=g4J9in8MEAtpirB9GQFVPudd+AU23Ru6/Lk
	sYB+SPNY=; b=OlmffU+3vjV0Mvnke2BmMjgbPoTc7AgZGMB3mtn2ZXdYYLRPvWZ
	iMik2vdmbMPFjPsQslZHXKfZwEd/o9IoYjQMaV1mqdKzixxmOinueBwtGVjBobdF
	mZi07c5sZqiifb1VWCaDUGkKAJ1EO8ld8m+kPv8onnGr0o0dAxi3Dx996LqAKqKT
	bV09FrM0QVYPy8mO6SBxSqBgpReMNzS2dfypOWHi/RDjBUhPnxJVxk0AAZ1r8q/c
	918JX5K8XBMtP/ukwuD8vTGsc/PKEU2E09aeqX975i8YqkQAIzO1ACRVhX7z1kqQ
	QA/hnzDUZDbCwgqybxrFkGwjlXJaZvuh/qA==
X-ME-Sender: <xms:cL9RaG-5qUas567oMNYv9E48iAJAqXjJBfsVwbVvHRxH-1dVJatVoA>
    <xme:cL9RaGvKJw9fKU6tKN_DZvfzv-ksTk8avOFhrVcJcxjXkK_VZVdIbIdeUNQH18-Y5
    BjnYA2Fae5jctIeeQ>
X-ME-Received: <xmr:cL9RaMCp0Y8gl6lWw5V0Oo5JOvOdL5XntyVc15jVpdd1AVy9atuibXT6BTvJWC3QgixiVmApHUtrfhfNXV95Oa1GLEscbcIsFyQv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefh
    tddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrgh
    guuhhlvgihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:cL9RaOcyq9zWKOsaGm4vB2hqbhkaCtQqpz7WFoRxTjNgYeWi6Zplvw>
    <xmx:cL9RaLP61z8drcfw-kSWEBZ0XLCMlk6tILqf6-lbSkE9Ljr2phTj0Q>
    <xmx:cL9RaIksHRKWSme_vEVESpjOfJF8Cac2jrJYdefUZuDBX-JddJfKrA>
    <xmx:cL9RaNudWDszKWFFzMfXsEeOg6pPRXKwyOEjpsYZKNQvV0MI_9wepA>
    <xmx:cb9RaFNNdwPWacTEfG17E2UYy0JKNTxLgh01YqmnrTnRUHK4x4SMEGQr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 15:18:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "James Duley via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  James Duley <jagduley@gmail.com>,
    Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Ensure restore_term works correctly with DUPLEX
In-Reply-To: <pull.2000.git.git.1750186571037.gitgitgadget@gmail.com> (James
	Duley via GitGitGadget's message of "Tue, 17 Jun 2025 18:56:10 +0000")
References: <pull.2000.git.git.1750186571037.gitgitgadget@gmail.com>
Date: Tue, 17 Jun 2025 12:18:07 -0700
Message-ID: <xmqqh60euqhc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"James Duley via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: James Duley <jagduley@gmail.com>
>
> Previously, if save_term/restore_term was called with the DUPLEX flag
> and then without the flag, an assertion was hit.
>> Assertion failed: hconout != INVALID_HANDLE_VALUE,
>> file compat/terminal.c, line 283
>
> This is because save_term doesn't set cmode_out when not DUPLEX,
> so an old version of cmode_out was being used.
> Therefore, hconout is the correct thing for restore to check
> to decide whether to restore stdout console mode.
>
> I saw this on Windows with interactive.singleKey when doing `git add -p`.
> Specifically, after hitting `e` to edit in vim, once on to the prompt
> for the next hunk, pressing any key results in the assertion.
>
> Signed-off-by: James Duley <jagduley@gmail.com>
> ---
>     Ensure restore_term works correctly with DUPLEX

Ran "git log -L247,290:compat/terminal.c" to find commits that
touched this Windows specific area of the code to see who might be
capable of reviewing this change, as I am certainly not one of them.

e22b245e (terminal: teach git how to save/restore its terminal
settings, 2021-10-05) is where the assert being removed came from,
it seems.

The author of that commit should be CC'ed if we want to ask for a
quicker review.  I'll also add Git-for-Windows maintainer as well.

Thanks.


> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2000%2Fparched%2Frestore-term-windows-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2000/parched/restore-term-windows-fix-v1
> Pull-Request: https://github.com/git/git/pull/2000
>
>  compat/terminal.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/compat/terminal.c b/compat/terminal.c
> index 584f27bf7e1..72b184555ff 100644
> --- a/compat/terminal.c
> +++ b/compat/terminal.c
> @@ -279,8 +279,7 @@ void restore_term(void)
>  
>  	SetConsoleMode(hconin, cmode_in);
>  	CloseHandle(hconin);
> -	if (cmode_out) {
> -		assert(hconout != INVALID_HANDLE_VALUE);
> +	if (hconout != INVALID_HANDLE_VALUE) {
>  		SetConsoleMode(hconout, cmode_out);
>  		CloseHandle(hconout);
>  	}
>
> base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77
