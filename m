Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610038BF7C
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770234920; cv=none; b=XjXcw3KyOZhrele7kznyBf354SFXdHa5g5LDHvC+AbvK12co7JpA4UWpYoGds2DXjkX5hexbIAWZj7PNjoEgAPpgTKop3Y6wDZ3a0iF2rFFXuKNMtl8r8ityZZOR+CEBYGjKGj6iBWgFzPJY7557lr+RKibLHqVXfL2F1CLNoMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770234920; c=relaxed/simple;
	bh=lxuE/iF8m5kivIR7BIHqfFoUCISUIPml3ok4dqPm1P8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=htCq074o28xaQwComEtIBPRE9zhJj3jlTxEp9MnNGzX6y6Z0BJxDMrdRj+uO5x9NGcqLPgS3x/VlB/f4NxSp9x+mZC7KVLzRqjYz8mmB3kqzOitREuOeSleAccVKCtbZxW+tgJAvd//U2/X5AMrbBv79zCmbqPUEbuJd8K7EUeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SKllrK9Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dz/daLMB; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SKllrK9Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dz/daLMB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 08261EC0304;
	Wed,  4 Feb 2026 14:55:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 04 Feb 2026 14:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770234919; x=1770321319; bh=XQEvDDnsdk
	ZuYLYv8a3kqmi4JOSD7TJ6vupJ9DIX+Oo=; b=SKllrK9Zxs9uQfxVCXeJ0aOTT8
	/rOykvZQPc+q/3aBq+V82dyTMRVI9/eH+oaODm0FzzfVRjrIFEy5FmxS1jCXTTtn
	Q2uXmwnHWoMHLKd0H791WwA9Nt9VjsU7Sl0xO2HbVzBCOVapm9wh5bG054TH/YT1
	A0uMd2MHUd2fDXG+SYNkkLTJJPCRGnBk7by0w8CQiAoy+we62jGjCddHRcEL7lhu
	jXi0f+/oJGWeNOrYpFmDFrmfwipjQx95Boq7bhz+GV933W3nQbw/rZ41647uwEA4
	FNkUPZ0C/HWCyImlgeDvBG78to4+B8jqrRZgYn81yiRs5GU+E8JaOfHAzjmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770234919; x=1770321319; bh=XQEvDDnsdkZuYLYv8a3kqmi4JOSD7TJ6vup
	J9DIX+Oo=; b=dz/daLMBCjp7OufT63L/VBjtfFou4StL9WdEq2nwnVxF/Ls7BeM
	r0vOP4Pzs/YOVYI5c/7byR7bpch+d5vfX52oJunzhiQoKFWJmZ/MhYDvHAi/nauK
	TP7teyzxM7Pr6g6ZG39J6Weu9vt3EXM5qURmwo5ABjCyIDeELQIKcMLwIbIMPd6K
	+O8yxLJfehQRGPaE5iBLkiENMzfcs/4pYW0dlEWe09CxmxdMbRR4KhR1M9+J9bM6
	tzMev4DscnU6+INxXCRkqhBfY3YmYs8kdSXBEvLS+Z7I8oDU7exC0yZWo5gpvvC9
	7Eq26kdm3hPgaLOGCs2q18HgX/NbVK0IUpA==
X-ME-Sender: <xms:JqSDadN83rQq_JwSy3r_xYj5vkLBJZftzFcrxdmOVO2ZJtQR2XE21g>
    <xme:JqSDaTr51eqPG1tLgDokXFNnBqIMG50Q03w4xej-AnHcazWtQOdxLPByb5_V1dHYp
    Imtc3VSy55uGhDDNYEhX-D5-bwYH3Ng-wwREazfXdvuYxQYuJNw>
X-ME-Received: <xmr:JqSDaWGUQJHsf3aLVAa88FObn3Z9OF7v_DdHXRrSuQuNCMsRACG1iPlpkbjXU7DU-IuaJEVr7RbSQf0WLHkanlnrM3vMAvQgdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghskhdoghhitheshhhofiguohhirdhlrghnugdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    thhrihhksehpshhpughfkhhithdrtghomhdprhgtphhtthhopegruggrmhesughinhifoh
    houghivgdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JqSDaQrDJ6nz-x0fYCpdf4x4oSQD_nHfxT27uZVJTxeJjixOn2WTgw>
    <xmx:JqSDaXbW1p7HmScegqeVLxljnB4oJSCBfMm_qf-SCTaViuZg1N5yUA>
    <xmx:JqSDaRVzHz77PcK8cqDizpgMzD6jsKr7JeDEZJddjqTH0Al7jRFmkw>
    <xmx:JqSDaY9ULRAztpGOXDRjn2Nr38WcHH8UKmhLvZsJ8eWa1UbtqAcrAg>
    <xmx:J6SDaYk0fJi14QWNfkIDiLXjQqc0Q2oxba-WMA9lOG9wZj5ykBjNiVwa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 14:55:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Stagner <ask+git@howdoi.land>
Cc: git@vger.kernel.org,  Patrik Weiskircher <patrik@pspdfkit.com>,  Adam
 Dinwoodie <adam@dinwoodie.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: Re* [RFH] adding test coverage for contrib/ in CI jobs
In-Reply-To: <20260204043812.814884-3-ask+git@howdoi.land> (Colin Stagner's
	message of "Tue, 3 Feb 2026 22:38:11 -0600")
References: <xmqqjywtu58j.fsf_-_@gitster.g>
	<20260204043812.814884-3-ask+git@howdoi.land>
Date: Wed, 04 Feb 2026 11:55:17 -0800
Message-ID: <xmqqms1onv16.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Colin Stagner <ask+git@howdoi.land> writes:

> I'll see what I can do about any remaining failures. I'd like to
> improve the test coverage for subtree split. split has a lot of
> complicated logic that needs to be preserved across updates.

Thanks.


> Subject: contrib/subtree: fix tests with reftable backend
>
> One git-subtree test-case relies on git internals to infer the
> default branch name. This test fails with the new reftable
> backend.
>
>     GIT_TEST_DEFAULT_REF_FORMAT=reftable \
>       meson test t7900-subtree
>
> This test script already sets
>
>     GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>
> which eliminates the need to infer a branch name at runtime.
> Hardcode the branch name.

Makes sense.  

I didn't read the test script carefully enough to be certain that we
were on the initial branch when the defaultBranch computation
happened.

Thanks.  Will replace my hack with this version.

> Signed-off-by: Colin Stagner <ask+git@howdoi.land>
> ---
>  contrib/subtree/t/t7900-subtree.sh | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index 316dc5269e..e7040718f2 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -1597,7 +1597,6 @@ test_expect_success 'push split to subproj' '
>  
>  test_expect_success 'subtree descendant check' '
>  	subtree_test_create_repo "$test_count" &&
> -	defaultBranch=$(sed "s,ref: refs/heads/,," "$test_count/.git/HEAD") &&
>  	test_create_commit "$test_count" folder_subtree/a &&
>  	(
>  		cd "$test_count" &&
> @@ -1614,7 +1613,7 @@ test_expect_success 'subtree descendant check' '
>  	(
>  		cd "$test_count" &&
>  		git cherry-pick $cherry &&
> -		git checkout $defaultBranch &&
> +		git checkout main &&
>  		git merge -m "merge should be kept on subtree" branch &&
>  		git branch no_subtree_work_branch
>  	) &&
> @@ -1626,10 +1625,10 @@ test_expect_success 'subtree descendant check' '
>  	test_create_commit "$test_count" not_a_subtree_change &&
>  	(
>  		cd "$test_count" &&
> -		git checkout $defaultBranch &&
> +		git checkout main &&
>  		git merge -m "merge should be skipped on subtree" no_subtree_work_branch &&
>  
> -		git subtree split --prefix folder_subtree/ --branch subtree_tip $defaultBranch &&
> +		git subtree split --prefix folder_subtree/ --branch subtree_tip main &&
>  		git subtree split --prefix folder_subtree/ --branch subtree_branch branch &&
>  		test $(git rev-list --count subtree_tip..subtree_branch) = 0
>  	)
