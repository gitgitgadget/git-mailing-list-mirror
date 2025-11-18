Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943242D7DC6
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489003; cv=none; b=R9TBL6qR/dcLNZMPo5t0TKCPEvfxiZo/0kgzMGJX8CAqG03E3o5mNO5FzwKh14NIKl6MBg2AssPsMSVor1aYnySy8MrYgV8aoZkuS8Gr//VPldg3cM7xro150tlayl1NZqlsWlPSSuhMR0OKUPb5ThH17iaD0kX9n3Z5EpJN+OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489003; c=relaxed/simple;
	bh=7S0t64ALHmjmaEFmHeeQ69AYHF8+CfoI4H7XEZw7nHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DOMAN+UaYwIMexwkKIXb+n49vKOYJ1fcUCqd+pCVf6M7o007jSfGM79s/U+P4/auQpwTWOaf9OXX19InxDpvE4YPcDO2TV3mhW8gYYEv0iWegwSKOMXoGWlcBG2Jol3gfnzgc3IcnHrv7C0ESFjxuGRF2ykhdGV07SSTyyuD1bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Czkm+251; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V5AXusAY; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Czkm+251";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V5AXusAY"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 972AFEC040A;
	Tue, 18 Nov 2025 13:03:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 18 Nov 2025 13:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763488999; x=1763575399; bh=eK2X7riYSI
	vzwCYKLnFgDSO0bnipctNgF6iI9IP4v6A=; b=Czkm+251S41qbN5aR535M5NeQf
	oE69v2cpYvDN/JvJ813iImYU4RByPVX2qLCyEOuBdqxS6ZYFQVlQhtctMAX/Ubc8
	ev284xfMtt6CLj/dNnpHyszBI/XNkfBHJLWLdpvlKw6yIt85pXMgPu32VAH0Ytw6
	Kit0gCGgPGko2jEljL3o9YYwyJwY8Y8fPlxmatmyd7FeZq0wSm+UeekFdwX8gDKK
	CJ7I3imkfJ1gF57S4xETHAhXRAFIrsjx5yMPeUkBu3Nwo0Fe9kiPklRVYZYQSQeS
	Z9SLCwD8399eIrrCXIZ7TQb0sSa+b1AZsc3PtNz+bwjCu58hVtc2F92yMMrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763488999; x=1763575399; bh=eK2X7riYSIvzwCYKLnFgDSO0bnipctNgF6i
	I9IP4v6A=; b=V5AXusAYRA2Q6eZWqroomfb0fOdJyT6K9MdopUicYhBpvKeMEGF
	NbaEBgQp+Y9HL134D9n+cGpjtou/v/I55DaJntewm5qbXXD9doAkgOouQQqdh2Hn
	IF8Qsye5/sSGcaH3aas/+fsXJFhDpvU7updQQccYNs12u2J7wmmTb5hMlJQCsRpN
	CiawT14wHyoXbCJGyH2HE0i81Xiqa225/g6ry+sUQp2TJhMOr4VqGUlhhpTEZNrr
	FDDecj9wnvwqo0ymv9ADKhJo2faI/x0OWFohpjXdO9jLshWIS+clnc786nauo2yY
	RfwfZBsK9wX8IaZmQT0sDzunFSRm6oTSqdA==
X-ME-Sender: <xms:57QcaUrxXGCv-2--liiN8urhW7kxbMyllLuC8yLT_D-FgqqEzaJQcA>
    <xme:57QcaRgfwD8XuA_OHHRKBjR0SfWudQ9g1ARfFjBtOWwCy6hLsrNchdrtwQf8yzn_B
    sU-aV5oaBjWsB6XR0S2mQk9cnIUjMmGzMPM01DBEwob5iTSBjnreg>
X-ME-Received: <xmr:57QcaRhg790B0Lue7X1rYBOFTFeKYv3ydNLAvH9u1VSsn9dd1-gPpZolRGizWQiZ-1EQQbkH5CFDGDHseL5iJNE1B37dRqxxrjJm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdduleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepueeifffhjeefvdfhffekheeuteefkeeuffegiedtkeeguddvueejfeeuvddt
    vefhnecuffhomhgrihhnpehhthhtphgurdhshhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:57QcaXikAnvf_HDzZEcTnXkf42GpcnmVXYoluOCuJtStePEyTkKEwA>
    <xmx:57QcaRKUmaO6wh7Bk5YJ1k-yHykuNUuHQJaoMjOso-jo8JzH130vjg>
    <xmx:57QcaWGRAMQgT8CvOret-tnciB_ztpFJAFoG3b98z5oVGF5HV2Nt8w>
    <xmx:57QcaVRUgHAl9ZWrLeXNVxXrGg4_JZzUhlB_RsE_eHNuM88E5EoJlw>
    <xmx:57QcaaxMtrZ9N6J72PStAIXK6pK9t71h3o4SpG_iLIBFBDw4UmG9mI-1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 13:03:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  ps@pks.im
Subject: Re: [PATCH v6 3/3] fetch: fix failed batched updates skipping
 operations
In-Reply-To: <20251118-fix-tags-not-fetching-v6-3-2a2f15fc137e@gmail.com>
	(Karthik Nayak's message of "Tue, 18 Nov 2025 12:27:57 +0100")
References: <20251118-fix-tags-not-fetching-v6-0-2a2f15fc137e@gmail.com>
	<20251118-fix-tags-not-fetching-v6-3-2a2f15fc137e@gmail.com>
Date: Tue, 18 Nov 2025 10:03:17 -0800
Message-ID: <xmqqv7j7dxqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Fix a regression introduced with batched updates in 0e358de64a (fetch:
> use batched reference updates, 2025-05-19) when fetching references. In
> the `do_fetch()` function, we jump to cleanup if committing the
> transaction fails, regardless of whether using batched or atomic
> updates. This skips three subsequent operations:
>
>   - Update 'FETCH_HEAD' as part of `commit_fetch_head()`.
>
>   - Add upstream tracking information via `set_upstream()`.
>
>   - Setting remote 'HEAD' values when `do_set_head` is true.
>
> For atomic updates, this is expected behavior. For batched updates,
> we want to continue with these operations even if some refs fail to
> update.
>
> Skipping `commit_fetch_head()` isn't actually a regression because
> 'FETCH_HEAD' is already updated via `append_fetch_head()` when not
> using '--atomic'. However, we add a test to validate this behavior.
>
> Skipping the other two operations (upstream tracking and remote HEAD)
> is a regression. Fix this by only jumping to cleanup when using
> '--atomic', allowing batched updates to continue with post-fetch
> operations. Add tests to prevent future regressions.

Other than the usual "unless you care about timestamps, do not use
'touch' only to create a file" applies, but other than that the
added tests look quite sensible.

About the second new test piece, it is a bit surprising that we
didn't have test for --set-upstream on successful fetch.  It does
not need REFFILES prerequisite, does it?

Thanks.

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 4b113d7c27..f5c87d81fe 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -1639,6 +1639,93 @@ test_expect_success "backfill tags when providing a refspec" '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
> +	test_when_finished rm -rf base repo &&
> +
> +	git init base &&
> +	(
> +		cd base &&
> +		test_commit "updated" &&
> +
> +		git update-ref refs/heads/foo @ &&
> +		git update-ref refs/heads/branch @
> +	) &&
> +
> +	git init --bare repo &&
> +	(
> +		cd repo &&
> +		! test -f FETCH_HEAD &&
> +		git remote add origin ../base &&
> +		touch refs/heads/foo.lock &&
> +		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
> +		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
> +		test -f FETCH_HEAD
> +	)
> +'
> +
> +test_expect_success REFFILES "upstream tracking info is added with --set-upstream" '
> +	test_when_finished rm -rf base repo &&
> +
> +	git init --initial-branch=main base &&
> +	test_commit -C base "updated" &&
> +
> +	git init --bare --initial-branch=main repo &&
> +	(
> +		cd repo &&
> +		git remote add origin ../base &&
> +		git fetch origin --set-upstream main &&
> +		git config get branch.main.remote >actual &&
> +		echo "origin" >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success REFFILES "upstream tracking info is added even with conflicts" '
> +	test_when_finished rm -rf base repo &&
> +
> +	git init --initial-branch=main base &&
> +	test_commit -C base "updated" &&
> +
> +	git init --bare --initial-branch=main repo &&
> +	(
> +		cd repo &&
> +		git remote add origin ../base &&
> +		test_must_fail git config get branch.main.remote &&
> +
> +		mkdir -p refs/remotes/origin &&
> +		touch refs/remotes/origin/main.lock &&
> +		test_must_fail git fetch origin --set-upstream main &&
> +		git config get branch.main.remote >actual &&
> +		echo "origin" >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success REFFILES "HEAD is updated even with conflicts" '
> +	test_when_finished rm -rf base repo &&
> +
> +	git init base &&
> +	(
> +		cd base &&
> +		test_commit "updated" &&
> +
> +		git update-ref refs/heads/foo @ &&
> +		git update-ref refs/heads/branch @
> +	) &&
> +
> +	git init --bare repo &&
> +	(
> +		cd repo &&
> +		git remote add origin ../base &&
> +
> +		! test -f refs/remotes/origin/HEAD &&
> +		mkdir -p refs/remotes/origin &&
> +		touch refs/remotes/origin/branch.lock &&
> +		test_must_fail git fetch origin &&
> +		test -f refs/remotes/origin/HEAD
> +	)
> +'
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
