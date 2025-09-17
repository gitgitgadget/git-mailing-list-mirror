Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2E2F3C05
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125913; cv=none; b=XXh03Yn6RE3BeZiXdpAknL9mpqFgE0AvqHySXtjoZFzdHefZYiAje10dpNGqeI+xISwI2p6VnkMZXGkSvKxPdDKv4j0BqNFOlXONqY7RsYxUdvEceZhEDyuClzxvvqG9Yg7WA3Lwqd3XjXDRt0RNOm8+cfDf77IP6nwJVwOWQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125913; c=relaxed/simple;
	bh=WuXB5hPIACenAaQoRZ+BOE4FkU2Ppzikb8+NeiAiovw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mER+grSbLiW12u0RmDYWXQBdBFW4pDM6oqPinHHXPjaXrptTHcVSip9UCGQND58NFy2VSgD7hHTkibH2ssxUPFJkfvWWOMS641QOY1kdg+FiLMXIDxTTGX1OtHJv2wl4EWnooaGmKrRdxLdRNbW6h5Uq45eiTvcTnfpVrnlZaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hLvQzgem; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hbRZQCHg; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hLvQzgem";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hbRZQCHg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7988514001CA;
	Wed, 17 Sep 2025 12:18:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 17 Sep 2025 12:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758125910; x=1758212310; bh=Y2HcaVK/7b
	69SeuEMmgsfpFAj0A4VBTouHX7YpCFUvM=; b=hLvQzgem6tpGyLcwGx/hu0Z+yO
	Oac29ZRA4jJnkNQSKB0f7r9JWxNyHOzH8biebECDl0FU5c2gZWzT+3DGGVSE5RYV
	28M30JUpGnmAJYoYZmrycnMV/+IDq3T9XtfyjCo2VP5pvEL8M7Vv7SCJMoz1kv5E
	SWhITGqX02KFZdvaaWFkRJ0kEHbB+M47/HKE0A8KVFJPPucgSpTrME1LvSfgSHvH
	/8Z8tCwdaO5BQ7P8UaRXYRaQF300jG56zKQUVf/H1G7d2gCoCT3jqUXw0lFSudBd
	vf4EINaNIdBPjVUN2oKipNJLOVJTHbCEL/hzD49hlRkphBWAzeCFcJI1i4vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758125910; x=1758212310; bh=Y2HcaVK/7b69SeuEMmgsfpFAj0A4VBTouHX
	7YpCFUvM=; b=hbRZQCHgg6qAmje0oXo0DRmEjfVULFSkVRsXP3d9LOQmjJMuIQA
	l7qjpvQCeUfDf7ruTD2yl1RCrErzJhFnyA9RyGfaOy57ZnOezuHDF8ai6NmoSo/3
	vnOgjZjBVnaNvSMQmC/q57ucCPll0a/EGvyKgtHEP2kY7bkBHrtVHy6NULxmk3x3
	b5lVhqX2noxZFJxr0lXSYMSPj7cP1fspxE0uvutyKXzxctZOSM67UCEAapbMJRaU
	e4IC6WbMp7qkONjpMzvTmXn2CKD2CC0Fv6OehJH0VJeEwCSU6bBRF3j/tRPjNGaK
	f+JBl5p8k0gCVO8rYjqecKf5aDZ0pSkxyog==
X-ME-Sender: <xms:Vt_KaL8CGC2J-sLBQsMjHVKu89hEuaxAHW1vc1PObXD1UTj3YGgBdg>
    <xme:Vt_KaAIgiDjfLaz8aUQyu3IGD6YmMcaWugmM3T9tB9OI87vMpjatlgL4iYbZSvcZY
    yCxDIbFX5_V-ieAkQ>
X-ME-Received: <xmr:Vt_KaJfcfIC9wJUQ0bt554FTIz9jY6UhfUiyNErJDG6n8R0ylyPGiDfCS9RNGzxX2QBNeq7F_cjJxuc21XWJEEdfG1yZeITOe8nTzdc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehhuhgrnhhgshgvnhefieehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Vt_KaH9lA5cjQe9GLyKADkAJv4VyBKbVdY3nee513R8d60oFTFUSuQ>
    <xmx:Vt_KaOpv5psgSD-ETLuCIiTNfFEIeoXhon2SskfJAo0lu2oJfoS13Q>
    <xmx:Vt_KaEBZao91kOS97VhC7lDSP8JSIEBICFyPsJBY5ae9V6sDPlxjPA>
    <xmx:Vt_KaIyERWJQH89YS1FmqUw2B96jzvTmQLTpqn6o8SrShX2Ba0tLiA>
    <xmx:Vt_KaEeTQbWNIz20Wu_NclPesgWl7A-JFq44mYJJYOrKfL4atL_yTdpo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 12:18:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Wing Huang <huangsen365@gmail.com>,
  Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 5/4] initial branch: give hints after switching the
 default name
In-Reply-To: <cover.1757518141.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Wed, 10 Sep 2025 16:28:59 +0100")
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
	<cover.1757518141.git.phillip.wood@dunelm.org.uk>
Date: Wed, 17 Sep 2025 09:18:28 -0700
Message-ID: <xmqqikhhdpd7.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

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

It also needs to be noted that the advise token to squelch the
message is the same advice.defaultBranchName as before, which is
also very much deliberate.  The users who do have that configured
are those who _have_ been using Git since before 3.0, and they are
not the target audience for the new advice message.  Reusing the
same advise token ensures that they do not have to turn the message
off.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * With simplified tests, thanks to Phillip's help.

 advice.c      |  2 --
 advice.h      |  4 +---
 refs.c        | 12 ++++++++++--
 t/test-lib.sh | 10 +++++++---
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/advice.c b/advice.c
index 48c49ee414..e5f0ff8449 100644
--- a/advice.c
+++ b/advice.c
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
diff --git a/advice.h b/advice.h
index fc1dc87204..8def280688 100644
--- a/advice.h
+++ b/advice.h
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
diff --git a/refs.c b/refs.c
index 149a8d1cec..f15366bfce 100644
--- a/refs.c
+++ b/refs.c
@@ -641,9 +641,17 @@ static const char default_branch_name_advice[] = N_(
 "\n"
 "\tgit branch -m <name>\n"
 );
+#else
+static const char default_branch_name_advice[] = N_(
+"Using '%s' as the name for the initial branch since Git 3.0.\n"
+"If you expected Git to create 'master', the just-created\n"
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
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b191954c3c..562f950fb0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -127,13 +127,17 @@ then
 	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
 fi
 
+# Explicitly set the default branch name for testing, to squelch hints
+# from "git init" during the transition period.  Should be removed
+# after we decide to remove ADVICE_DEFAULT_BRANCH_NAME
 if test -z "$WITH_BREAKING_CHANGES"
 then
-	# Explicitly set the default branch name for testing, to avoid the
-	# transitory "git init" warning under --verbose.
 	: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=master}
-	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+else
+	: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=main}
 fi
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 
 ################################################################
 # It appears that people try to run tests without building...
-- 
2.51.0-382-g6e76cf14a4

