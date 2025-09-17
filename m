Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5680E303C83
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100979; cv=none; b=png9pgSgwPB/ksT1ugFYxiomm+SsOjHwl0dly4wHlHoaUin/zbj4V/HCMnrX/1nbXVOSRCCtfRkj71vZH6Q8/cggLXECBeKUpjYuOTAtruiZ6nvl2Slb/sBfK/t8EwlrYE3ZeGqNWcc+93vVDoQnQALf1vbWAvm3GY2JuyUJw6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100979; c=relaxed/simple;
	bh=0ZDgO7JMRSSuQ1N4x1CnQAgtneLTliZ/RfFkZR7xLhI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LdHyx4iEfUuDkQ0jqt6SfE+IkDML9JKC1iyK3+UKcbV4sTpq/YB3D5EVtnEHw676arZjo4Vu73SLQmbjKfZwpMkpw3GSnTS82Bkow3HIFtrIwgrkRu5cAm5FiJX7n6gzEzcNyZsANs/MkAE8e8TBudFCf5+ivCrll2TvvgvtZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IfwssmbH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TfCcDFtG; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IfwssmbH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TfCcDFtG"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id F21061D0005A;
	Wed, 17 Sep 2025 05:22:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 17 Sep 2025 05:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758100974; x=1758187374; bh=BdkPh02BzQ
	NMEFHOekMpRgv/9y/Mo87vpyb8B4ZycLs=; b=IfwssmbHLqcsZXrXQg9BzmV9I6
	TvBsB9qAB95eTDHk1dB/gJprulsuyBHajH4+weg4IlxMvmt6Tgr7eDp33fyhAfsz
	aZIl4AaGX7gsEXyS4JXPmcH8Umq5mEsa+ssuDnyt8g08QAKDM5HWePg4D5WGAX3/
	AP6J6VbOB9KsqJgUBISdviemS5rSixbpYCllG+zHI27KvgyCbsHcbH3iGzxYECKa
	4zgkiwEzv3EnSFW1KIMZ81TcL5ANVHZow9UCw1kL8ASuerwfcMOw2Y4fmARQbvRf
	Fe4IMQh1zFDjHpgHqbMjHUAWJE6ruTYZ8TsDQW6IelvvGY8G7q8amjIWphKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758100974; x=1758187374; bh=BdkPh02BzQNMEFHOekMpRgv/9y/Mo87vpyb
	8B4ZycLs=; b=TfCcDFtGL4nq0keFL+DdFKmix3bBWO9CwuzgbWn+zBWK84uloTd
	dlrOpIHba8Ju+cS46z4cWaAHiQTvjMXUSyKDw4BZZ55fOjkSmLTS6mXw0MNnBRKP
	qTgjYLOIcWNP/aPdyS0lPHBSdXyJW3RDDkENCK0JhWbWs22acYyN/xsxMN0tz/IL
	EhHUJKW1h7piMNLMgJru5esqcHqlTeBb/QfvW8uVEq6AYuzKQjC2krvZTmTMOi8v
	ie7nBG7BhWOGUTcmpeujdaR7BrIC5nzK8wA9PLBQEeBCbVhsNiNtGn8psIUJhgC4
	RQlPlNp2OyxQ+cl9AyRFfIiYCgAxxuT8W2g==
X-ME-Sender: <xms:7n3KaCYbV318baBv0M4c2VdJa7ClJw4PxmVAPIwVjmwKuEN5rWMaYA>
    <xme:7n3KaN0NRuQKpdtYA1SSgSGRQV_o5PHdiFhVORLwsJfGtDVyJu-5dITnukfVDzmN4
    Tw4Uy7rwhp05j6SHQ>
X-ME-Received: <xmr:7n3KaNbk8XPhbRkUnSiEgHD2-17U82293tS8bCwihIdHEooPJLKimtSUvmVWCtGwt_cnl8rqXL14oMVY0NxaCfd0JEaUQT_vJ_42lKo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeekhfefieelueevgefhveegieegleeiffelgffghfduieefieffteekheejudfg
    ieenucffohhmrghinheprgguvhhitggvrdgtfidprhgvfhhsrdgtfienucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehhuhgrnhhgshgv
    nhefieehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7n3KaFKCVKFRWTmzI78CP4KcZPx9KHMyT46pwMFVbE9KP9iBErOfwg>
    <xmx:7n3KaMFH2Wyfw-dWvZRjb-3WD9d3Mh-Yey8pNrbvQjFvhFJ_eWK8Qw>
    <xmx:7n3KaMtp7yBjnTux3JS338QwrylphWizNaChdzOt9HclHZi8dGGsdw>
    <xmx:7n3KaLtx7q5km8XdRnu0ik9bCRSUPj4DGSwLK6OtJiapxqNqtf9MJw>
    <xmx:7n3KaJ7RJIJ_q-OrVjAATYnQr_u0Hpm1F-IkhXULPHJXBrUW1TNZiFCQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 05:22:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Wing Huang <huangsen365@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/4] breaking changes: switch default initial branch
 name to "main"
In-Reply-To: <xmqq4itarqfd.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	10 Sep 2025 13:41:26 -0700")
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
	<cover.1757518141.git.phillip.wood@dunelm.org.uk>
	<xmqq4itarqfd.fsf@gitster.g>
Date: Wed, 17 Sep 2025 02:22:52 -0700
Message-ID: <xmqqv7lhigb7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> Changes since V2:
>> Patch 1: reworded documentation
>> Patch 3: fixed typo in commit message
>> Patch 4: added helper function to initialise repository
>
> Everything I saw in the patch looked good.
>
>> I'm still on the fence about the suggestion to add some advice on how
>> to rename the branch after it is created in order to help users who
>> are following tutorials using "master" rather than "main". One the
>> one hand I can see that would be helpful, on the other it is pretty
>> annoying to everyone else.
>
> Hmph.  I do not see why we want to be quiet and do not want to give
> "Now we created 'main', which may not match an existing tutorial you
> are trying to follow.  Here is a way to use a different name to let
> you continue with the tutorial." after annoying everybody with
> "Sorry but we created 'master', which may not match your taste.
> Here is how you arrange it to be different" for more than a few
> releases already.
>
> IOW, I do not see annoyance is a valid argument against or for a
> corresponding message to help the users across behaviour change
> boundary.

I do not want to see a viable topic left for too long without
getting completed, so here is my attempt.

Earlier I thought we should use a separate advice.* variable to
squelch, but after thinking it again for a while, I think reusing
the one we have been using gives exactly what we want, so this just
changes the contents of the message after the switchover.  We would
need to retire the message after a while.

--- >8 ---
Subject: [PATCH 5/4] initial branch: give hints after switching the default name

It is likely that those who came to Git after 3.0 switched the
default initial branch name to 'main' would still try to follow
tutorials that were written before 3.0 happened and with the
assumption that the tool would call the initial branch 'master'.

To help these new users after 3.0 boundary, let's retain one part of
the hint we will be giving before the default changes, namely, how
to rename the branch an unconfigured Git has created just once.

We do this without telling them how to permanently configure the
default name of the initial branch, and that design choice is very
much deliberate.  The whole point of switching the default name was
because we did not want to force individual users to configure their
default branch name but while the hard wired default was 'master',
they _had_ to configure it away from 'master' in order to conform to
the recent norm, and a hint that tells them how to do so is useful.

But once the default is renamed to 'main', that no longer is true.
A narrower audience who are new users that follow an instruction
that assumes the initial branch name is 'master' would only need to
learn "here is how to change the branch name to match the tutorial
you are following in the repository you created for practice", and
"here is how you keep creating repositories with the first branch
with a name everybody hates" is unnecessary.

It also needs to be noted thta the advise token to squelch the
message is the same advice.defaultBranchName as before, which is
also very much deliberate.  The users who do have that configured
are those who _have_ been using Git since before 3.0, and they are
not the target audience for the new advice message.  Reusing the
same advise token ensures that they do not have to turn the message
off.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 advice.c         |  2 --
 advice.h         |  4 +---
 refs.c           | 12 ++++++++++--
 t/t0000-basic.sh |  3 ++-
 t/t0001-init.sh  | 14 +++++++-------
 5 files changed, 20 insertions(+), 15 deletions(-)

diff --git c/advice.c w/advice.c
index 48c49ee414..e5f0ff8449 100644
--- c/advice.c
+++ w/advice.c
@@ -51,9 +51,7 @@ static struct {
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
-#ifndef WITH_BREAKING_CHANGES
 	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName" },
-#endif /* WITH_BREAKING_CHANGES */
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
 	[ADVICE_DIVERGING]				= { "diverging" },
 	[ADVICE_FETCH_SET_HEAD_WARN]			= { "fetchRemoteHEADWarn" },
diff --git c/advice.h w/advice.h
index fc1dc87204..8def280688 100644
--- c/advice.h
+++ w/advice.h
@@ -18,9 +18,7 @@ enum advice_type {
 	ADVICE_AM_WORK_DIR,
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
-#ifndef WITH_BREAKING_CHANGES
-	ADVICE_DEFAULT_BRANCH_NAME,
-#endif /* WITH_BREAKING_CHANGES */
+	ADVICE_DEFAULT_BRANCH_NAME, /* To be retired sometime after Git 3.0 */
 	ADVICE_DETACHED_HEAD,
 	ADVICE_DIVERGING,
 	ADVICE_FETCH_SET_HEAD_WARN,
diff --git c/refs.c w/refs.c
index 149a8d1cec..5e5a41ec01 100644
--- c/refs.c
+++ w/refs.c
@@ -641,9 +641,17 @@ static const char default_branch_name_advice[] = N_(
 "\n"
 "\tgit branch -m <name>\n"
 );
+#else
+static const char default_branch_name_advice[] = N_(
+"Using '%s' as the name for the initial branch since Git 3.0.\n"
+"If you expected Git to create 'master', you can rename the just-created\n"
+"branch can be renamed via this command:\n"
+"\n"
+"\tgit branch -m master\n"
+);
 #endif /* WITH_BREAKING_CHANGES */
 
-char *repo_default_branch_name(struct repository *r, MAYBE_UNUSED int quiet)
+char *repo_default_branch_name(struct repository *r, int quiet)
 {
 	const char *config_key = "init.defaultbranch";
 	const char *config_display_key = "init.defaultBranch";
@@ -660,10 +668,10 @@ char *repo_default_branch_name(struct repository *r, MAYBE_UNUSED int quiet)
 		ret = xstrdup("main");
 #else
 		ret = xstrdup("master");
+#endif /* WITH_BREAKING_CHANGES */
 		if (!quiet)
 			advise_if_enabled(ADVICE_DEFAULT_BRANCH_NAME,
 					  _(default_branch_name_advice), ret);
-#endif /* WITH_BREAKING_CHANGES */
 	}
 
 	full_ref = xstrfmt("refs/heads/%s", ret);
diff --git c/t/t0000-basic.sh w/t/t0000-basic.sh
index 2b63e1c86c..54ed80ebd4 100755
--- c/t/t0000-basic.sh
+++ w/t/t0000-basic.sh
@@ -220,7 +220,8 @@ test_expect_success 'subtest: --verbose option' '
 	test_done
 	EOF
 	mv t1234-verbose/err t1234-verbose/err+ &&
-	grep -v "^Initialized empty" t1234-verbose/err+ >t1234-verbose/err &&
+	grep -v -e "^Initialized empty" -e "^hint:" t1234-verbose/err+ \
+		>t1234-verbose/err &&
 	check_sub_test_lib_test_err t1234-verbose \
 		<<-\EOF_OUT 3<<-\EOF_ERR
 	> ok 1 - passing test
diff --git c/t/t0001-init.sh w/t/t0001-init.sh
index df0040b9ac..5fe7b8c674 100755
--- c/t/t0001-init.sh
+++ w/t/t0001-init.sh
@@ -562,9 +562,9 @@ test_expect_success 'init warns about invalid init.defaultObjectFormat' '
 	test_when_finished "rm -rf repo" &&
 	test_config_global init.defaultObjectFormat garbage &&
 
-	echo "warning: unknown hash algorithm ${SQ}garbage${SQ}" >expect &&
+	expect="warning: unknown hash algorithm ${SQ}garbage${SQ}" &&
 	git init repo 2>err &&
-	test_cmp expect err &&
+	test_grep "$expect" err &&
 
 	git -C repo rev-parse --show-object-format >actual &&
 	echo $GIT_DEFAULT_HASH >expected &&
@@ -649,9 +649,9 @@ test_expect_success 'init warns about invalid init.defaultRefFormat' '
 	test_when_finished "rm -rf repo" &&
 	test_config_global init.defaultRefFormat garbage &&
 
-	echo "warning: unknown ref storage format ${SQ}garbage${SQ}" >expect &&
+	expect="warning: unknown ref storage format ${SQ}garbage${SQ}" &&
 	git init repo 2>err &&
-	test_cmp expect err &&
+	test_grep "$expect" err &&
 
 	git -C repo rev-parse --show-ref-format >actual &&
 	echo $GIT_DEFAULT_REF_FORMAT >expected &&
@@ -868,18 +868,18 @@ test_expect_success 'overridden default initial branch name (config)' '
 	grep nmb actual
 '
 
-test_expect_success !WITH_BREAKING_CHANGES 'advice on unconfigured init.defaultBranch' '
+test_expect_success 'advice on unconfigured init.defaultBranch' '
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= git -c color.advice=always \
 		init unconfigured-default-branch-name 2>err &&
 	test_decode_color <err >decoded &&
 	test_grep "<YELLOW>hint: " decoded
 '
 
-test_expect_success 'advice on unconfigured init.defaultBranch disabled' '
+test_expect_success 'advice on unconfigured init.defaultBranch can be disabled' '
 	test_when_finished "rm -rf no-advice" &&
 
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
-		git -c advice.defaultBranchName=false init no-advice 2>err &&
+	git -c advice.defaultBranchName=false init no-advice 2>err &&
 	test_grep ! "hint: " err
 '
 
