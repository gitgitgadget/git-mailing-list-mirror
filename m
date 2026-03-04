Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2C35F182
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643961; cv=none; b=U1QIIJXDx7lMUx3AOlpEli0xpyDMMKRXjYldzn49a6zTKle7RBa6mVv1+n9ooZH6FIeVrkdsskSn/F99VCVZrx4xiZ6gylmb7pxwn+RfQXFQ8q+JncdYLHSWWZ//z2mZMGhlQVZhrBaWA9IrD/sdymGsfCGGpRxxDAvQks3KZr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643961; c=relaxed/simple;
	bh=CwHWv47e+tuLT8LXqZAt4BddHt1HSbABh7PV1LG5mys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AtOWVlTwfH9F0LTk7L3ilXW8B6RRZ9C35PQGNNUZVfFS9MA7F58NStzy6i9mmM17102jdEedPq516eReFY8wfk+bK7HreDHeCKZfOl7eYi1/zeKrueG6COjY9oy9t7ogaB1docw0Zzfavz/31rbjhfToZHFxUvn3Rw3txIvohOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BIlrTZrb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wVcxuist; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BIlrTZrb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wVcxuist"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CD531D0017D;
	Wed,  4 Mar 2026 12:05:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 04 Mar 2026 12:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772643958; x=1772730358; bh=BUHIQ6ciEw
	0d7fvu7Fn+WNW+YiJA4HJUqG77umq3H8o=; b=BIlrTZrbjjx1TeZzYZE6ZZ1En4
	wU7vmys5UVbxk/FnC8ChBhysb7B60LLMCch8CUBhHpQgiJHdwfnf+Q5bqi6eO6+p
	49oqnfEcpZ/Xit5S2AP9mOzYY66MrYessPP7YeIRT46/15T3lc2aKyINsusondRZ
	8KmEJeD768aGlDwZRGnD620hs7O5oOTTwIurn2+BitECDF6XYj8T2Z4HYLar7Nmt
	GqiWNwNQEpO5VdZ0GAi2NYJQM+iixBLIFJ2OloykwPG2cyytY2ikN0IMtMckQdL3
	tbi6mljbCllkfpyVFc80a25nrI16xXc5bxi/DawvHud4IgR24jTVwYpccL5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772643958; x=1772730358; bh=BUHIQ6ciEw0d7fvu7Fn+WNW+YiJA4HJUqG7
	7umq3H8o=; b=wVcxuistlzA479spy+sCFebDd69SepFFa3hgEnxApi1qQbtfwi2
	24UCurCS+DnlP3VZVtjZ2MlcpkuPFLE0KSyPuvIOPl2wYCizBU+/Au9U7/HdVHNo
	l2lf7MbAnn+0x0ArvzJbaah6DedTg1e2wW2Kjoi8WFF1zoSytk9Osti8iB5BPUZN
	q9WgWZ2GiaC6uVZ6BmtEn1l2VdrG8Dv2oNjlJbG+vUwzG2pzY8y+GBLDrJaCVDHA
	mxFRzACixC5Wmoz/xqivjro2dJNjm2gRAwX+IhfiMQO5xbtbyK5hyhQ9PsrWzK7t
	0kWOwCs1NpERy3UOY9RqmvuaxClaOu7dzgA==
X-ME-Sender: <xms:dmaoado1Zt8_rD8cfjQNLkSJa9RbxvIOTOlARIgcsyNgBCJcQdrWjw>
    <xme:dmaoaWqKDQfR1-dTgcgMYi3zLVs3Wd5xVJCTDkIvriKDYtAInWeUoPQiYgMktMgcJ
    PwWxzjFSmgsQth_jmupl8xpSB-G7uUXqx_P9mKjU8wKQmdarqiLxQY>
X-ME-Received: <xmr:dmaoafM4wR6V96gXTHPPUiRJKBhxlNbm5g7mxp5ge4wnJV-pdTev2EwAfyAPZ2NVMzp-zYajdEZB4evQahh1kHKJZL_a050Z9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dmaoaXyfk8QrcU96NNVxEPq1cSTvXssmaE1NriSbzbJ9BSC7IIzqVA>
    <xmx:dmaoaYuFtY-Ovvf8FwcMPdLmrut6HeiIrhU9jyr9dw0Y78Xq6MhdJg>
    <xmx:dmaoaQ4M_zrNwfhRtWXTvoKH7Ucc8R91IkhGq9scIySBUTWdnzqrgA>
    <xmx:dmaoaXTJPwzwhDHWh12WwqxprWpKcU40rbK4_PkcfXtJ8vC2fzWiww>
    <xmx:dmaoaevs9ioftodNAmlnuIpfrNbUGyNndnsPf6uPmp8Utr9lUXku5Bk6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 12:05:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v31 0/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <pull.2138.v31.git.git.1772627131.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Wed, 04 Mar 2026 12:25:29
	+0000")
References: <pull.2138.v30.git.git.1772102022.gitgitgadget@gmail.com>
	<pull.2138.v31.git.git.1772627131.gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 09:05:56 -0800
Message-ID: <xmqq5x7ba5jf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Harald Nordgren (2):
>   refactor format_branch_comparison in preparation
>   status: add status.compareBranches config for multiple branch
>     comparisons
>
>  Documentation/config/status.adoc |  25 +++
>  remote.c                         | 178 ++++++++++++----
>  t/t6040-tracking-info.sh         | 354 +++++++++++++++++++++++++++++++
>  3 files changed, 520 insertions(+), 37 deletions(-)
>
>
> base-commit: 50d063e335afd5828fbb9de2f2b2fb44fd884d2b
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v31
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v31
> Pull-Request: https://github.com/git/git/pull/2138
> ...
> Range-diff vs v30:
>
>  1:  7f517b8c7f = 1:  320c1ce55a refactor format_branch_comparison in preparation
>  2:  501bd40294 ! 2:  f07ccb278c status: add status.compareBranches config for multiple branch comparisons
>      @@ Documentation/config/status.adoc: status.aheadBehind::
>       +If not set, the default behavior is equivalent to `@{upstream}`, which
>       +compares against the configured upstream tracking branch.
>       ++
>      ++The entries are shown in the order they appear in the configuration.
>      ++Duplicate entries that resolve to the same ref are suppressed after
>      ++their first occurrence, so `@{push} @{upstream} @{push}` shows at
>      ++most two comparisons.  When `@{upstream}` and `@{push}` resolve to
>      ++the same remote-tracking branch, only one comparison is shown.


As the previous iteration of this series is already in 'next', we'd
need to turn this into an incremental.  Luckily, as the difference
is fairly clear and only in [2/2], let me try to do so myself to
potentially save one roundtrip.

Thanks.

----- >8 -----
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 04 Mar 2026 12:25:31 +0000
Subject: [PATCH 3/2] status: clarify how status.compareBranches deduplicates

The order of output when multiple branches are specified on the
configuration variable was not clearly spelled out in the
documentation.

Add a paragraph to describe the order and also how the branches are
deduplicated.  Update t6040 with additional tests to illustrate how
multiple branches are shown and deduplicated.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
[jc: made a whole replacement into incremental; wrote log message.]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/status.adoc |   6 ++
 t/t6040-tracking-info.sh         | 120 ++++++++++++++++++++++++++-------------
 2 files changed, 88 insertions(+), 38 deletions(-)

diff --git c/Documentation/config/status.adoc w/Documentation/config/status.adoc
index 15ccd0116b..b5dd85b761 100644
--- c/Documentation/config/status.adoc
+++ w/Documentation/config/status.adoc
@@ -26,6 +26,12 @@ status.compareBranches::
 If not set, the default behavior is equivalent to `@{upstream}`, which
 compares against the configured upstream tracking branch.
 +
+The entries are shown in the order they appear in the configuration.
+Duplicate entries that resolve to the same ref are suppressed after
+their first occurrence, so `@{push} @{upstream} @{push}` shows at
+most two comparisons.  When `@{upstream}` and `@{push}` resolve to
+the same remote-tracking branch, only one comparison is shown.
++
 Example:
 +
 ----
diff --git c/t/t6040-tracking-info.sh w/t/t6040-tracking-info.sh
index c24f545036..0242b5bf7a 100755
--- c/t/t6040-tracking-info.sh
+++ w/t/t6040-tracking-info.sh
@@ -293,11 +293,8 @@ test_expect_success '--set-upstream-to @{-1}' '
 '
 
 test_expect_success 'status tracking origin/main shows only main' '
-	(
-		cd test &&
-		git checkout b4 &&
-		git status >../actual
-	) &&
+	git -C test checkout b4 &&
+	git -C test status >actual &&
 	cat >expect <<-EOF &&
 	On branch b4
 	Your branch is ahead of ${SQ}origin/main${SQ} by 2 commits.
@@ -309,11 +306,8 @@ test_expect_success 'status tracking origin/main shows only main' '
 '
 
 test_expect_success 'status --no-ahead-behind tracking origin/main shows only main' '
-	(
-		cd test &&
-		git checkout b4 &&
-		git status --no-ahead-behind >../actual
-	) &&
+	git -C test checkout b4 &&
+	git -C test status --no-ahead-behind >actual &&
 	cat >expect <<-EOF &&
 	On branch b4
 	Your branch and ${SQ}origin/main${SQ} refer to different commits.
@@ -324,7 +318,7 @@ test_expect_success 'status --no-ahead-behind tracking origin/main shows only ma
 	test_cmp expect actual
 '
 
-test_expect_success 'status.compareBranches from upstream has no duplicates' '
+test_expect_success 'status.compareBranches deduplicates when upstream and push are the same' '
 	test_config -C test status.compareBranches "@{upstream} @{push}" &&
 	git -C test checkout main &&
 	git -C test status >actual &&
@@ -337,18 +331,48 @@ test_expect_success 'status.compareBranches from upstream has no duplicates' '
 	test_cmp expect actual
 '
 
-test_expect_success 'status.compareBranches shows ahead of both upstream and push branch' '
+test_expect_success 'status.compareBranches with only upstream shows only upstream' '
+	test_config -C test status.compareBranches "@{upstream}" &&
+	git -C test checkout main &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch main
+	Your branch is up to date with ${SQ}origin/main${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches with only push shows only push' '
 	test_config -C test push.default current &&
-	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	test_config -C test status.compareBranches "@{push}" &&
 	git -C test checkout -b feature2 origin/main &&
 	git -C test push origin HEAD &&
 	(cd test && advance work) &&
 	git -C test status >actual &&
 	cat >expect <<-EOF &&
 	On branch feature2
+	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches shows ahead of both upstream and push branch' '
+	test_config -C test push.default current &&
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	git -C test checkout -b feature3 origin/main &&
+	git -C test push origin HEAD &&
+	(cd test && advance work) &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature3
 	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
 
-	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
+	Your branch is ahead of ${SQ}origin/feature3${SQ} by 1 commit.
 	  (use "git push" to publish your local commits)
 
 	nothing to commit, working tree clean
@@ -359,11 +383,11 @@ test_expect_success 'status.compareBranches shows ahead of both upstream and pus
 test_expect_success 'checkout with status.compareBranches shows both branches' '
 	test_config -C test push.default current &&
 	test_config -C test status.compareBranches "@{upstream} @{push}" &&
-	git -C test checkout feature2 >actual &&
+	git -C test checkout feature3 >actual &&
 	cat >expect <<-EOF &&
 	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
 
-	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
+	Your branch is ahead of ${SQ}origin/feature3${SQ} by 1 commit.
 	  (use "git push" to publish your local commits)
 	EOF
 	test_cmp expect actual
@@ -469,21 +493,41 @@ test_expect_success 'status.compareBranches supports ordered upstream/push entri
 	test_cmp expect actual
 '
 
+test_expect_success 'status.compareBranches deduplicates repeated specifiers' '
+	test_config -C test push.default current &&
+	test_config -C test remote.pushDefault origin &&
+	test_config -C test status.compareBranches "@{push} @{upstream} @{push}" &&
+	git -C test checkout -b feature7 upstream/main &&
+	git -C test push origin &&
+	(cd test && advance work) &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature7
+	Your branch is ahead of ${SQ}origin/feature7${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'status.compareBranches with diverged push branch' '
 	test_config -C test push.default current &&
 	test_config -C test remote.pushDefault origin &&
 	test_config -C test status.compareBranches "@{upstream} @{push}" &&
-	git -C test checkout -b feature7 upstream/main &&
-	(cd test && advance work71) &&
+	git -C test checkout -b feature8 upstream/main &&
+	(cd test && advance work81) &&
 	git -C test push origin &&
 	git -C test reset --hard upstream/main &&
-	(cd test && advance work72) &&
+	(cd test && advance work82) &&
 	git -C test status >actual &&
 	cat >expect <<-EOF &&
-	On branch feature7
+	On branch feature8
 	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
 
-	Your branch and ${SQ}origin/feature7${SQ} have diverged,
+	Your branch and ${SQ}origin/feature8${SQ} have diverged,
 	and have 1 and 1 different commits each, respectively.
 
 	nothing to commit, working tree clean
@@ -495,14 +539,14 @@ test_expect_success 'status.compareBranches shows up to date branches' '
 	test_config -C test push.default current &&
 	test_config -C test remote.pushDefault origin &&
 	test_config -C test status.compareBranches "@{upstream} @{push}" &&
-	git -C test checkout -b feature8 upstream/main &&
+	git -C test checkout -b feature9 upstream/main &&
 	git -C test push origin &&
 	git -C test status >actual &&
 	cat >expect <<-EOF &&
-	On branch feature8
+	On branch feature9
 	Your branch is up to date with ${SQ}upstream/main${SQ}.
 
-	Your branch is up to date with ${SQ}origin/feature8${SQ}.
+	Your branch is up to date with ${SQ}origin/feature9${SQ}.
 
 	nothing to commit, working tree clean
 	EOF
@@ -513,14 +557,14 @@ test_expect_success 'status --no-ahead-behind with status.compareBranches up to
 	test_config -C test push.default current &&
 	test_config -C test remote.pushDefault origin &&
 	test_config -C test status.compareBranches "@{upstream} @{push}" &&
-	git -C test checkout feature8 >actual &&
+	git -C test checkout feature9 >actual &&
 	git -C test push origin &&
 	git -C test status --no-ahead-behind >actual &&
 	cat >expect <<-EOF &&
-	On branch feature8
+	On branch feature9
 	Your branch is up to date with ${SQ}upstream/main${SQ}.
 
-	Your branch is up to date with ${SQ}origin/feature8${SQ}.
+	Your branch is up to date with ${SQ}origin/feature9${SQ}.
 
 	nothing to commit, working tree clean
 	EOF
@@ -531,11 +575,11 @@ test_expect_success 'checkout with status.compareBranches shows up to date' '
 	test_config -C test push.default current &&
 	test_config -C test remote.pushDefault origin &&
 	test_config -C test status.compareBranches "@{upstream} @{push}" &&
-	git -C test checkout feature8 >actual &&
+	git -C test checkout feature9 >actual &&
 	cat >expect <<-EOF &&
 	Your branch is up to date with ${SQ}upstream/main${SQ}.
 
-	Your branch is up to date with ${SQ}origin/feature8${SQ}.
+	Your branch is up to date with ${SQ}origin/feature9${SQ}.
 	EOF
 	test_cmp expect actual
 '
@@ -547,16 +591,16 @@ test_expect_success 'status.compareBranches with upstream behind and push up to
 	git -C test checkout -b ahead upstream/main &&
 	(cd test && advance work) &&
 	git -C test push upstream HEAD &&
-	git -C test checkout -b feature9 upstream/main &&
+	git -C test checkout -b feature10 upstream/main &&
 	git -C test push origin &&
 	git -C test branch --set-upstream-to upstream/ahead &&
 	git -C test status >actual &&
 	cat >expect <<-EOF &&
-	On branch feature9
+	On branch feature10
 	Your branch is behind ${SQ}upstream/ahead${SQ} by 1 commit, and can be fast-forwarded.
 	  (use "git pull" to update your local branch)
 
-	Your branch is up to date with ${SQ}origin/feature9${SQ}.
+	Your branch is up to date with ${SQ}origin/feature10${SQ}.
 
 	nothing to commit, working tree clean
 	EOF
@@ -564,14 +608,14 @@ test_expect_success 'status.compareBranches with upstream behind and push up to
 '
 
 test_expect_success 'status.compareBranches with remapped push refspec' '
-	test_config -C test remote.origin.push refs/heads/feature10:refs/heads/remapped &&
+	test_config -C test remote.origin.push refs/heads/feature11:refs/heads/remapped &&
 	test_config -C test status.compareBranches "@{upstream} @{push}" &&
-	git -C test checkout -b feature10 origin/main &&
+	git -C test checkout -b feature11 origin/main &&
 	git -C test push &&
 	(cd test && advance work) &&
 	git -C test status >actual &&
 	cat >expect <<-EOF &&
-	On branch feature10
+	On branch feature11
 	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
 
 	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.
@@ -584,14 +628,14 @@ test_expect_success 'status.compareBranches with remapped push refspec' '
 
 test_expect_success 'status.compareBranches with remapped push and upstream remote' '
 	test_config -C test remote.pushDefault origin &&
-	test_config -C test remote.origin.push refs/heads/feature11:refs/heads/remapped &&
+	test_config -C test remote.origin.push refs/heads/feature12:refs/heads/remapped &&
 	test_config -C test status.compareBranches "@{upstream} @{push}" &&
-	git -C test checkout -b feature11 upstream/main &&
+	git -C test checkout -b feature12 upstream/main &&
 	git -C test push origin &&
 	(cd test && advance work) &&
 	git -C test status >actual &&
 	cat >expect <<-EOF &&
-	On branch feature11
+	On branch feature12
 	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
 
 	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.


