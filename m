Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5102F3815FA
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658603; cv=none; b=LrDW7m2BfGEeDBTGjKyZJ2r3ia/hEkczkmFsRSlrtLtj8+crPBsTh6kDTClTW/X4ea9Hp13CUDq2WaEO5581nmbMKYCmg3HqnBPV98JSBHZD4Dh4+OnUa+LEusWln4v6AsJ3sdANFqL4Og5j8Rf2xQS39W7EzCvp8hL4fXOBkpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658603; c=relaxed/simple;
	bh=xN72koI6bpg0Ps4OnTSi944YwMEJ4IYeo1TRvTNVH+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlJH4i9pTmojt+TRqcyeDs4veXxzqK6dc1AHYLH6A7JvRVu2h2153bzJCvBQn8dAZ4G8cBCoZYD6kZau+pmxpY0rlkq2XZVT3uVrXXNC88/7yPZq7IL2R7rMa+VXJlHKTZM4UOB1xy1E6zOi8MQkqC+C+M9XwAWzLa1GmcOwwzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Kh0/d/+t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PWYQF1Pj; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Kh0/d/+t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PWYQF1Pj"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C7E51400195;
	Mon,  9 Feb 2026 12:36:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 09 Feb 2026 12:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770658602;
	 x=1770745002; bh=VQI1fUpNH4F9EQhzUNkPfWscedZpDFo0SjB7jJv9O7U=; b=
	Kh0/d/+t7iXyxlogC/VK1zlPSv1ILyed4BQ1QXRsYxM+wGDWoM+20ER0ye77myc3
	fQ5jiXv7jvxgo09DE85QHlD3xpL5fTb3uOsUJXpsEwCwNHTlRkGUQtRYjHldQ9Fw
	T6f2Bycs6COjzFWYKICzaplRUnK/oBKmnHfg4mcfkaRH8dI2i2xRWBOV30kw2Ncd
	YyM21xO0H14Um54I1Nby2MnXcXYS6ysLH9luSVGr/6sQkChYVaiQtayTnJ1X7m1R
	62tlLHRyeVb96N8SOBR0t/mIQk9CXR5t/reTv674NMIg7lQkSp9LDK2ktpQ24ZE4
	ZXO9pEQ373KYjTwSSaCW4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770658602; x=
	1770745002; bh=VQI1fUpNH4F9EQhzUNkPfWscedZpDFo0SjB7jJv9O7U=; b=P
	WYQF1Pj0NCxALgGvLICRdZM26B9CthnUSdtfxAshjjfE4DHIAxoJh0BVw2MsBCTx
	8cYqqChD4cXyV3Xpkkmdotn4OmLq1p/RwkI7sJV/KZLDrGYqDcRd5Aun5eARZlPv
	H6RLurxp2ynHANFVSLjh/0Hvatk/BWku4eWvnqanV7ev4/PDjxgZkzq6wcgt36ja
	8E8dc71MJOo70G88fqouDT9xI0DEwyMYEXrotnCWn1kEnRJgLTvts+qUW9g50j2k
	Wr/gtu3FogBFSk0SYngKEcohlD4HUs/OJjke4TLAVNzal3nZP3AREFTT4XZsFxG5
	JrBLNGWp1xOPA1B09dh0w==
X-ME-Sender: <xms:KhuKaX5bHZyP3BFYk_GHc_1X-R7sS4ytGT7s94j1DVYYlcSD_N1n8tM>
    <xme:KhuKaS7Ibk1jr3VozQyFBeo6W1p6Sor9BaTUvWchL26hEmlwBeexn72DKHom3nmEP
    ewvKvoQMlRknaNnHi6DuAB0nejJ4DUqqWGPuz5DcS8FlTCbOkGmaCo>
X-ME-Received: <xmr:KhuKacGFtSL5WA5yD8OijJn9sUesxn31yE4Zc0NV9Ju61j5gqACgRJfhXl6BH63nzlw-MGrugp_f6uXaQeCDKakKkOgLd9U9LYFEEdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepudelgf
    euieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffgnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:KhuKaTSiO7G__XNCdU8VKrU758R6_eXJZdXtDBm1zHyXCs09iRwR_g>
    <xmx:KhuKadtF1ZOquCZFjXxFaE-yVUKMTjRytRYpEoTXhDxfpCTL5YUirQ>
    <xmx:KhuKaaxrDXzQ-1ymHZIOHEdeCDCEcig3mRkpC7kO41kOgv3HXH4pRQ>
    <xmx:KhuKaf4SmCYYTK6iJRmy6_SpAddaNo7iHzuVwfgU-7opUOpWvGQZkQ>
    <xmx:KhuKabQA7LtsA-A8FlzO_AmZd98II8g6SIixz1K9F6L0PvMLjPNBOd2T>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 12:36:41 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 4/4] doc: am: fill out hook discussion
Date: Mon,  9 Feb 2026 18:34:37 +0100
Message-ID: <am_hooks.325@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <doc_am_gitlinks_and_am.messageId.321@msgid.xyz>
References: <doc_am_gitlinks_and_am.messageId.321@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Document `--verify` and rephrase the `--[no-]verify` section to lead
with the default, in imperative mood.[1]

Historically it makes sense that only the negated forms are documented;
they are all run by default and thus you only need to use hook options
if you want to turn some of them off. But, beyond just desiring uniform
documentation,[2] it’s very much possible to have, say, a Git alias with
`--no-verify` that you might sometimes want to turn back on with
the *positive* form.

Also mention the options in the “Hooks” section and mention that
`post-applypatch` cannot be skipped.

† 1: See e.g. acffc5e9 (doc: convert git-remote to synopsis style,
     2025-12-20)
† 2: https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Does not need an update to the usage in `builtin/am.c` because it is
    excluded in `t/t0450/adoc-help-mismatches`.

 Documentation/git-am.adoc | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
index 5e0d6e6fe02..84ec9fee8df 100644
--- a/Documentation/git-am.adoc
+++ b/Documentation/git-am.adoc
@@ -9,7 +9,7 @@ git-am - Apply a series of patches from a mailbox
 SYNOPSIS
 --------
 [verse]
-'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8] [--no-verify]
+'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8] [--[no-]verify]
 	 [--[no-]3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<action>] [-C<n>] [-p<n>] [--directory=<dir>]
@@ -150,11 +150,14 @@ Valid <action> for the `--whitespace` option are:
 --interactive::
 	Run interactively.
 
+--verify::
 -n::
 --no-verify::
-	By default, the pre-applypatch and applypatch-msg hooks are run.
-	When any of `--no-verify` or `-n` is given, these are bypassed.
-	See also linkgit:githooks[5].
+	Run the `pre-applypatch` and `applypatch-msg` hooks. This is the
+	default. Skip these hooks with `-n` or `--no-verify`. See also
+	linkgit:githooks[5].
++
+Note that `post-applypatch` cannot be skipped.
 
 --committer-date-is-author-date::
 	By default the command records the date from the e-mail
@@ -290,6 +293,8 @@ This command can run `applypatch-msg`, `pre-applypatch`,
 and `post-applypatch` hooks.  See linkgit:githooks[5] for more
 information.
 
+See the `--verify`/`-n`/`--no-verify` options.
+
 CONFIGURATION
 -------------
 
-- 
2.53.0.26.g2afa8602a26

