Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847B829405
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067402; cv=none; b=qqa9Z3cfuSTlcIvLVNe1TwXXdmf3e4gECcE36vns1uYCwPkS45KqiD0dl1jSxV6FQcuQ3EdKP81VgKe6SLDkZry9gpsKvJFW4lTBEvh94XZmvkIt9ofeMqfm3eIBGvDXW8T29t99rrtDjxmbq52l4GFEZQtuJT29Ocf3dCHtO+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067402; c=relaxed/simple;
	bh=amg3JgE+UdzWoEmiHiZEh4yX8l2DHMCuFSstwCHeTeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lA6oIzMHhRdKe6zzfM0e0pRMrtVO8g0I368zRZMGLNmNMThRUCwpe6ljdzVbA+TYcoleKXDwUZoBNBm3QyFrc3MoIRlitPl64rtSkp1Aqw5uEgEd+0Cw0p1xq+IFuNszBN1Kh1Llj8RrD0AlkoZMx6L55w8duahr+c7Ibom8Zrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y/9gzSyk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YfkteTdV; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y/9gzSyk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YfkteTdV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9E6807A002D;
	Wed,  1 Apr 2026 14:16:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 01 Apr 2026 14:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775067399; x=1775153799; bh=59/8BYBN8x
	NZOXYGmiL9WUPLVVg/7EGKKq/hO6pQblU=; b=Y/9gzSykiYBCHTWYDKCP37Bjab
	J/XLkt981GuLeJSmQdVnPJ1Iewo24FKODPf7PjAE1r61Zva0FpS/VL/EVXlxxWmU
	fA7Xua12yNTSvZqHcB7GQ4bxdaqe91Q9ebJCCn4HHeOxthwE5Amh9IUG4ONB3Ejr
	96WDLFNuYF3XdJZCOQAX7RKV+FCrTOCaCr57Q4eE5SCw4bNcfS5Nh1p3pOjlGpYQ
	SwWUvJmhB5Pu7iKa3rk3rdvVl6hxlF/nCRz343wlVdt3ss0IvmzUEhn5HIYzUZq1
	e10KnvJUgSL+EYRRrLtfSpJZAVcZNfEqcDS8ZDppnEdvI01Fe+SnTSoyc2vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775067399; x=1775153799; bh=59/8BYBN8xNZOXYGmiL9WUPLVVg/7EGKKq/
	hO6pQblU=; b=YfkteTdVB9BcIf2A990mDWFmrZ2z24JDWeV8Jo7IeTs9ZN7Jar3
	K7GDSdSb0tz8zBZYOJeQJ+PanN5rJ2SR5+TIJmYQoLrjahhirHShGkESXwahHmaR
	eazkJ+ZQiZRrw2vQb/bD6hS00TtdmkOFdcy09JRqT5I0zlMWWLx25YQUgSJpHVM0
	+UMZyMMVVvj4ytFJf3CIvW7WB0llRSjqhYhLQF3GW65jHugDM3Q7rl5zXoMjUEKq
	SHHhwWt3NpHguja963xmh9bwNarua9e0tyw2rdHUlyxmMsk9o3M84Y+Ibyt/JbmP
	/RfBknBAdjgKecIFKf78eyvzDYSybBLri/A==
X-ME-Sender: <xms:B2HNad0BRtuHNgslkhDAIiUQSIfZ-bYM2jl9EFzTtFecYcATp2QeaA>
    <xme:B2HNabhQCVLH3RN3x8lqUKXIZAelpUrAblukYeWtVTCEaaVt02G8pAnzmtbSh5Kt7
    w70LfXqwcEEtymwcbmzQU_UebPVd-cKayZ63CsNvFVaKNWbelKdYg>
X-ME-Received: <xmr:B2HNabS2mnoV7FQ-nLGDHiVQihrhqfpSSVhQP1T64PEEk1yVE2ENo8LSnNmx7k_GCMGOPKC_uzbnzmFohpQArhep3pFo1IJYVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffue
    efjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegslhhinhgumhgr
    nhhsihhonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:B2HNaUgGwKLIdy1uan-RUDcFscX8SElo8jPRqqhY_GuRdpOKd_QvHg>
    <xmx:B2HNaT7YKHYuMgP-8kWQQ6an7U6ILVx-BpHijJQSLOVEwPH4uO3Ggw>
    <xmx:B2HNaZBHZSlO8fct9dqydFD37gTVo8OfqDAonOjafXwGPjm15xrBfA>
    <xmx:B2HNaSbi_eQLoGRTvqPpUXwaMKooaUBK1GKpz6W7YLO1sJNfbyWWVg>
    <xmx:B2HNafgQBlt5plefWchqTrbJg--CsIICa05wXGmfBZ8JrfwgR4qg15vB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 14:16:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: blindmansion <blindmansion@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] read-cache: disable renames in add_files_to_cache
In-Reply-To: <20260401170502.35877-1-blindmansion@gmail.com>
	(blindmansion@gmail.com's message of "Wed, 1 Apr 2026 13:05:02 -0400")
References: <CAF6hZH5TyFBm5H_fcVyaf1aw-mPsVbAmNvkUGCMoQYYCX1+HRQ@mail.gmail.com>
	<20260401170502.35877-1-blindmansion@gmail.com>
Date: Wed, 01 Apr 2026 11:16:37 -0700
Message-ID: <xmqqy0j6v94q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

blindmansion <blindmansion@gmail.com> writes:

> add_files_to_cache() refreshes the index from worktree changes and does
> not need rename detection. When unmerged entries and a deleted stage-0
> path are present together, rename detection can pair them and rewrite an
> unmerged diff pair to point at the deleted path.
>
> That later makes "git commit -a" and "git add -u" try to stat the
> deleted path and die with "unable to stat". Disable rename detection in
> this callback-driven staging path and add a regression test covering the
> crash.
> ---

Thanks for trying to help.

 * Documentation/SubmittingPatches::[[sign-off]]
 * Documentation/SubmittingPatches::[[real-name]]

Other than that, the contents of the proposed log message looks
perfect, which is rarely seen in a patch from somebody whose patch
we haven't seen around here yet.

> diff --git a/read-cache.c b/read-cache.c
> index 5049f9b..d938abc 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -4049,6 +4049,7 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
>  	rev.diffopt.format_callback = update_callback;
>  	rev.diffopt.format_callback_data = &data;
>  	rev.diffopt.flags.override_submodule_config = 1;
> +	rev.diffopt.detect_rename = 0; /* staging worktree changes does not need renames */
>  	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
>  

The change itself looks sensible, but it makes me wonder if there
are other very similar glitches lying around.

> diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
> index 06e83d3..56c7e55 100755
> --- a/t/t2200-add-update.sh
> +++ b/t/t2200-add-update.sh
> @@ -200,6 +200,45 @@ test_expect_success 'add -u resolves unmerged paths' '
>  	test_cmp expect actual
>  '

I didn't see too many questionable steps in the new test, other than
the mixed use of "perl" plus "sed".

 - Can't we do this without relying on "perl"?  Also, why does those
   invocations of Perl insist on using single quotes, which is more
   awkward to write in our test framework, where double quotes should
   work equally well?

 - Can't the sample line be shortened so that patch fits comfortably
   on 80-column terminals?

 - Insisting on "add -u" showing nothing on its standard error
   stream makes the test more fragile than it is necessary.  We
   cannot dictate that nobody in the future will add progress
   eye-candy to the codepath and some folks run the test on overly
   loaded machine.  Checking that the command exits with status 0 is
   a good thing to do (which is already done here) and should be
   sufficient in this case.

 - Wouldn't running a single "git ls-files" with pathspec and
   comparing it with expected list of contents in the index make it
   more clear what is being tested and expected in the last part of
   the test where we see no bystander.txt is mentioned and
   conflict.txt is mentioned there?  I.e., something like

		git ls-files bystander.txt conflict.txt >actual &&
		cat >expect <<\-EOF &&
		conflict.txt
		EOF
		test_cmp expect actual

> +test_expect_success 'add -u avoids rename pairing on unmerged paths' '
> +	test_create_repo rename-crash &&
> +	(
> +		cd rename-crash &&
> +		test_seq 1 100 |
> +		sed "s/.*/line &: shared content that is identical across both files/" >conflict.txt &&
> +		cp conflict.txt bystander.txt &&
> +		git add conflict.txt bystander.txt &&
> +		git commit -m "initial: two files with identical content" &&
> +		main_branch=$(git symbolic-ref --short HEAD) &&
> +		git checkout -b feature &&
> +		perl -pe '\''s/^line 50:.*/line 50: FEATURE BRANCH CHANGE/'\'' \
> +			conflict.txt >conflict.txt.tmp &&
> +		mv conflict.txt.tmp conflict.txt &&
> +		git add conflict.txt &&
> +		git commit -m "feature: modify line 50" &&
> +		git checkout "$main_branch" &&
> +		perl -pe '\''s/^line 50:.*/line 50: MAIN BRANCH CHANGE/'\'' \
> +			conflict.txt >conflict.txt.tmp &&
> +		mv conflict.txt.tmp conflict.txt &&
> +		git add conflict.txt &&
> +		git commit -m "main: modify line 50 differently" &&
> +		test_must_fail git merge feature &&
> +		rm bystander.txt &&
> +		git add -u >out 2>err &&
> +		test_must_be_empty out &&
> +		test_must_be_empty err &&
> +		git ls-files -u >actual &&
> +		test_must_be_empty actual &&
> +		git ls-files bystander.txt >actual &&
> +		test_must_be_empty actual &&
> +		echo conflict.txt >expect &&
> +		git ls-files conflict.txt >actual &&
> +		test_cmp expect actual &&
> +		git diff-files --name-only >actual &&
> +		test_must_be_empty actual
> +	)
> +'
> +
>  test_expect_success '"add -u non-existent" should fail' '
>  	test_must_fail git add -u non-existent &&
>  	git ls-files >actual &&
