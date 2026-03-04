Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448833C6A46
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646106; cv=none; b=RkRx5KDW/2/VntG++FkK8SVYVTlF+T7dpqxfvmNfoYu9w5DFoY9hlE3B645xdZdDIqsUD+Rrea97Pc6/2lYbinrW5rtA0fOPR8/E9DjrNokTblz96IxjCzTaYBDHpEVvbD4pWm4yITMWO78Qip+fL+yj3GYT/CcDwDaP8wpa4MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646106; c=relaxed/simple;
	bh=0wKRf04B0oDEjJMxS4UdSpsTW3FZu39TAw4eZLsK8E8=;
	h=From:MIME-Version:Content-Type:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID; b=OQha/+bXtbJqoELWbDz7/hg5Kah3/HONSgqtmjTw9q51g5balNv4+y0NVTzOf81veHYx8+fOEBid9S0XmLr5Ou7ErG5WIClu8Js3SbAgWEIpjXd90bF0aoYRLjyRwTNdDkq/XeTBNndETZzJ/RtYRpyacS3YV6bQ7ld5vae7qh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=few0PlOI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j1kck9g6; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="few0PlOI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j1kck9g6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 563351D00061;
	Wed,  4 Mar 2026 12:41:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 04 Mar 2026 12:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772646104;
	 x=1772732504; bh=agfMCm7zZplSqpaihMIxqk74+/zLeIAU2kAh4fuVzzc=; b=
	few0PlOIBt2X185wD/0v38lDRoY9HQqD53f+QLlOWPoh2/Ow6DaT/kOOL9hWpWVx
	1fkt/jpgvTb3TDwg1ujljUN8aAN3Wr+0MBFs91BOMb2Kc9K/4Wvu8f5GDy02AB96
	hvWHSMZso2poncCZ/+Zsxu8bFDlajuTyrWdQuGrZfZ776TSAuS6+cDGyAnyzvact
	0PCcIBp1Vgcm++XMN9EYakDQzrsFSc1Sr1YSU5lNsKbO+Ht07aAF6ZaZ/t0vVCz9
	LCOUHVJr6SGFmhp1Ha4GhKQPmX3pCdO5VQOtsE4Jx3t+pWtH3i53EjDlO+TYT4kM
	Asibo/0esHQuqA3mf1DWbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772646104; x=
	1772732504; bh=agfMCm7zZplSqpaihMIxqk74+/zLeIAU2kAh4fuVzzc=; b=j
	1kck9g6xTgAmmklqrDeDS6ZBH26yOjDSf0CHp4MXcRSSK5SAx1bFgbSMdrp9UhmB
	hUbLkGq0MhUAxrOx4y+pZ9JYPEJhr/Qy+G3xg4CU0UuWZNWKxoNvwbfQ0MW+kcyl
	WjObnaY39FcRMvKo1QybqkpKx6QN53DusZ7nLQZTHHT1ZRUUpOLfD2CZ9cbbkie0
	V50sYtuh2WbaSHObA0QoSMF5YtgZlW7UVvjiOxAwD+rsYHySYswf7lMRwHcagS4v
	ulNVoD8lLDd8O3LEssd5b9y9Kjf/LexzQ1oRRg7EMJlYvz+4jlHMd9fEauYSTVD/
	0A5fWdsQCePnFpISP3vvQ==
X-ME-Sender: <xms:126oaWKU_6lEhVzI32DanSQ7DYvxxkiTG2gmTnU8BK6Wzi-sf_YqnA>
    <xme:126oaQY-SMaih0NCQr-uGjkJpGiurpd9_7fTQB79a-G7T1P3ai3iriBHtZ9mPdZSH
    Xtj1crou2SeNOVDkTcBP95mTzLEHkw9erO2UFJLmj1VT-wCdkwR>
X-ME-Received: <xmr:126oaY-oR6H5vxfH9Z3myX2IgkexBD1j3tr8hTqVidoeEyLFmhbGowldQueTSwDJz9q0x9DL3yn_fhOR6RCPKw3kw4SBBjnTTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfggtgfgvfevufgjfhffkfgfsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeetuddulefhgfeludefieduudehleeihedtffefkeehheetvdetffelkedu
    hfeikeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhthhhusgesphgruhhlihhsrg
    hgvggvkhdrtghomhdprhgtphhtthhopehhrghngihinhdrhhigsegshihtvggurghntggv
    rdgtohhmpdhrtghpthhtohepjhgvfhhfhhhoshhtvghtlhgvrhesghhithhhuhgsrdgtoh
    hmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:126oaRatdgE8WBbc-7ZcDrF3gwCblL0AU85zaDSa0U9jPsWRgQXh9w>
    <xmx:126oacNKBitmRTQNPWhjmh7Q-apC6pRggyXh29V7qx0Ltb_qACFbVQ>
    <xmx:126oadBm6lCcxm06JM0PXi6-djkRwDqhcFbz5AvfCl1UKpuIs6aJUw>
    <xmx:126oaTICx6fbg5g0RcHOG-s3XLjCeHCCTeoMWdUsZ1ka7fOFwFsavQ>
    <xmx:2G6oaU-iQWFM2gnDQbDWyA1JT4MbIS06O6Vlptz2KtER-pWw-pf-rOvp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 12:41:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Paul Tarjan <github@paulisageek.com>,
    Han Xin <hanxin.hx@bytedance.com>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] promisor-remote: prevent lazy-fetch recursion in child
 fetch
In-Reply-To: <pull.2224.git.git.1772643468305.gitgitgadget@gmail.com> (Paul
	Tarjan via GitGitGadget's message of "Wed, 04 Mar 2026 16:57:48
	+0000")
References: <pull.2224.git.git.1772643468305.gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 09:41:42 -0800
Message-ID: <xmqqikbb8pbd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)

"Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Paul Tarjan <github@paulisageek.com>
>
> fetch_objects() spawns a child `git fetch` to lazily fill in missing
> objects. That child's index-pack, when it receives a thin pack
> containing a REF_DELTA against a still-missing base, explicitly
> calls promisor_remote_get_direct() — which is fetch_objects() again.
> If the base is truly unavailable (e.g. because many refs in the
> local store point at objects that have been garbage-collected on the
> server), each recursive lazy-fetch can trigger another, leading to
> unbounded recursion with runaway disk and process consumption.
>
> The GIT_NO_LAZY_FETCH guard (introduced by e6d5479e7a (git: add
> --no-lazy-fetch option, 2021-08-31)) already exists at the top of
> fetch_objects(); the missing piece is propagating it into the child
> fetch's environment. Add that propagation so the child's
> index-pack, if it encounters a REF_DELTA against a missing base,
> hits the guard and fails fast instead of recursing.
>
> Depth-1 lazy fetch (the whole point of fetch_objects()) is
> unaffected: only the child and its descendants see the variable.
> With negotiationAlgorithm=noop the client advertises no "have"
> lines, so a well-behaved server sends requested objects
> un-deltified or deltified only against objects in the same pack;
> the child's index-pack should never need a depth-2 fetch. If it
> does, the server response was broken or the local store is already
> corrupt, and further fetching would not help.
>
> This is the same bug shape that 3a1ea94a49 (commit-graph.c: no lazy
> fetch in lookup_commit_in_graph(), 2022-07-01) addressed at a
> different entry point.
>
> Add a test that verifies the child fetch environment contains
> GIT_NO_LAZY_FETCH=1 via a reference-transaction hook, and that
> only one fetch subprocess is spawned.
>
> Cc: Jonathan Tan <jonathantanmy@google.com>
> Cc: Han Xin <hanxin.hx@bytedance.com>
> Cc: Jeff Hostetler <jeffhostetler@github.com>
> Cc: Christian Couder <christian.couder@gmail.com>

I would suggest dropping these CC: lines from the proposed log
message.  As far as I can see, they do not have their intended
effect; [*1*] does not show any of these folks listed on Cc:

*1* https://lore.kernel.org/git/pull.2224.git.git.1772643468305.gitgitgadget@gmail.com/

I am not a GitGitGadget user, but I think ...

> Signed-off-by: Paul Tarjan <github@paulisageek.com>
> ---
>     promisor-remote: prevent recursive lazy-fetch during index-pack
>     
>     fetch_objects() in promisor-remote.c spawns a child git fetch to lazily
>     fill missing objects. That child's index-pack --fix-thin, when it hits a
>     REF_DELTA against a still-missing base, calls
>     promisor_remote_get_direct() — which is fetch_objects() again. Unbounded
>     recursion.
>     
>     We hit this in production: 276 GB of promisor packs written in 90
>     minutes against a 100 GB monorepo with ~61K stale prefetch refs pointing
>     at GC'd commits. Every thin pack picked a bad delta base, and the
>     recursion fanned out until the mount filled.
>     
>     The fix is one line: propagate GIT_NO_LAZY_FETCH=1 into the child
>     fetch's environment. The guard already exists at the top of
>     fetch_objects() (added by e6d5479e7a, 2021); nothing was setting it in
>     the child. This is the same bug shape that Han Xin's 3a1ea94a49 (2022)
>     closed at lookup_commit_in_graph().
>     
>     Depth-1 lazy fetch (the whole point of fetch_objects()) is unaffected —
>     only the child and its descendants see the variable. With
>     negotiationAlgorithm=noop the client advertises no "have" lines, so a
>     well-behaved server sends objects un-deltified or deltified only against
>     objects in the same pack. A depth-2 fetch would not help; if the server
>     sends broken thin packs, recursing just makes it worse.

... once I heard that the tool expects list of folks to CC: on this
side, i.e., not in the proposed commit log message, but in the pull
request description.  I also do not see much point in duplicating
most of what appears in the proposed log message here after the
three dash line, but that is a separate story.

This is totally an unrelated tangent, but perhaps we'd need a
best-practice document/guide for GitGitGadget users, that covers at
least the following two things?

 * The pull-request message appear under three-dash in the e-mailed
   patch, where additional information that are not meant to become
   part of the log message goes.  You do not want to duplicate your
   commit log message there.

 * Do not write Cc: trailers in your commit log message, as
   GitGitGadget does not pay attention to them.  If you want to
   specify whom to Cc: your patches, write these in your
   pull-request message instead, which GitGitGadget does pay
   attention to.

> diff --git a/promisor-remote.c b/promisor-remote.c
> index 96fa215b06..35c7aab93d 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -42,6 +42,13 @@ static int fetch_objects(struct repository *repo,
>  	child.in = -1;
>  	if (repo != the_repository)
>  		prepare_other_repo_env(&child.env, repo->gitdir);
> +	/*
> +	 * Prevent the child's index-pack from recursing back into
> +	 * fetch_objects() when resolving REF_DELTA bases it does not
> +	 * have.  With noop negotiation the server should never need
> +	 * to send such deltas, so a depth-2 fetch would not help.
> +	 */
> +	strvec_pushf(&child.env, "%s=1", NO_LAZY_FETCH_ENVIRONMENT);
>  	strvec_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=noop",
>  		     "fetch", remote_name, "--no-tags",
>  		     "--no-write-fetch-head", "--recurse-submodules=no",

Looks good.

> diff --git a/t/meson.build b/t/meson.build
> index e5174ee575..0499533dff 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -141,6 +141,7 @@ integration_tests = [
>    't0303-credential-external.sh',
>    't0410-partial-clone.sh',
>    't0411-clone-from-partial.sh',
> +  't0412-promisor-no-lazy-fetch-recursion.sh',

Hmph, do we really need an entirely new test script file dedicated
for this single liner change, instead of adding to some existing
test script that already covers related topics (like promisors and
lazy fetches from them)?

>    't0450-txt-doc-vs-help.sh',
>    't0500-progress-display.sh',
>    't0600-reffiles-backend.sh',
> diff --git a/t/t0412-promisor-no-lazy-fetch-recursion.sh b/t/t0412-promisor-no-lazy-fetch-recursion.sh
> new file mode 100755
> index 0000000000..ec203543d4
> --- /dev/null
> +++ b/t/t0412-promisor-no-lazy-fetch-recursion.sh
> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +
> +test_description='promisor-remote: no recursive lazy-fetch
> +
> +Verify that fetch_objects() sets GIT_NO_LAZY_FETCH=1 in the child
> +fetch environment, so that index-pack cannot recurse back into
> +fetch_objects() when resolving REF_DELTA bases.
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_create_repo server &&
> +	test_commit -C server foo &&
> +	git -C server repack -a -d --write-bitmap-index &&
> +
> +	git clone "file://$(pwd)/server" client &&
> +	HASH=$(git -C client rev-parse foo) &&
> +	rm -rf client/.git/objects/* &&
> +
> +	git -C client config core.repositoryformatversion 1 &&
> +	git -C client config extensions.partialclone "origin"
> +'
> +
> +test_expect_success 'lazy-fetch spawns only one fetch subprocess' '
> +	GIT_TRACE="$(pwd)/trace" git -C client cat-file -p "$HASH" &&
> +
> +	grep "git fetch" trace >fetches &&
> +	test_line_count = 1 fetches
> +'
> +
> +test_expect_success 'child of lazy-fetch has GIT_NO_LAZY_FETCH=1' '
> +	rm -rf client/.git/objects/* &&
> +
> +	# Install a reference-transaction hook to record the env var
> +	# as seen by processes inside the child fetch.
> +	test_hook -C client reference-transaction <<-\EOF &&
> +	echo "$GIT_NO_LAZY_FETCH" >>../env-in-child
> +	EOF
> +
> +	rm -f env-in-child &&
> +	git -C client cat-file -p "$HASH" &&
> +
> +	# The hook runs inside the child fetch, which should have
> +	# GIT_NO_LAZY_FETCH=1 in its environment.
> +	grep "^1$" env-in-child
> +'
> +
> +test_done
>
> base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
