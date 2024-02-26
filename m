Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC17418EA1
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 04:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708921400; cv=none; b=GXnRe5mldXuB86p+5f/7rkI/KXG0AglB26hvI7AG3FA10uXJyMdrz+HKaLDtaAK22uafkwigWnhy29YGElQgLkD3ITP8q0IJG/zoTry70V+92eqZp4it6AwxPJ406Aqj5fXjdDdeQPk1KrNlpAPlnuzs40t3iTB5dKxbgnQbXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708921400; c=relaxed/simple;
	bh=en8RDXrh5IDaMaOsxVJWPTSKOUXY/jsOCVRXBU5nxeY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q3rB4h4xMssNXDLdZTuwHQcMC2w4E6icVqTDaNi/x0GT15ZE/Md8ZAD/sw1T5vLzeNhAjIcN1vFhOYIq5tdUb1eQsACleUh9szMYYfMemMAQMWaYGiU5th0zs6Ppa6y8g1yguCgZ33x4xObDNn19bunG+4A2XSZO7Dcrz230hrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org; spf=pass smtp.mailfrom=joshtriplett.org; dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b=j7vcL7aS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rFm8PEh7; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="j7vcL7aS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rFm8PEh7"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id E3B555C0072;
	Sun, 25 Feb 2024 23:23:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 25 Feb 2024 23:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1708921397; x=1709007797; bh=Nx8Gg/ssAb
	rCGQu46ABvQ+bz+PUn1Fzn/avRSy20M8U=; b=j7vcL7aSKZOIlL/IKtievuCb7U
	b9mmQikVzeQN9/sAK/8uPXqmb5XMjdZjZ+1J11+eteHf2ZVULi1N8rvFMtj/a0A8
	Esix2LfbdfDv5p/q/j63WJIfc13FGwtblf2b+jiroVzy8lXV79UCETbHhn3LA9z4
	mxb9w595qSFdn830IBL/JhlN2A7jHFiSwndcuxi65rHriDLEHUxuV2ByJcP5r5RJ
	I9yce5FhoxC+H2b3E+Cr2eR6Z5hviti1wa3c8aXiVvCdzj1luXNkTBZrF5CLKRE2
	xamqemLszcNeLLteKtwEyaHszTnHqbCX251JX8Pjz1BlMWSngtC+KOAnK4BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708921397; x=1709007797; bh=Nx8Gg/ssAbrCGQu46ABvQ+bz+PUn1Fzn/av
	RSy20M8U=; b=rFm8PEh7zkUfz58e69PI3Z+pc9U8tOm91dhvX3flNwR5M09MMll
	IRvcRSQDr6D9l/bRKIWN3oCdflJqZlXQMph9uj7yKc5CW45daZh6ZeiX/V/qougI
	OFv55jJ4CVn8cSdMne78wcKHC4hEREVEt4EF+PDItfyuR4iiUOhIqZ9HWRSsmSqc
	w8bQcX4H708kpXM67cIGSY9M0qM6xTR0ESEkgb751Qt9QjIONg3dobU1mNxrUTul
	mQMGhhee/sJ2BjK8+RTb9p5L+PzxqGbPj5YUUEcrkG3/F5TJRyG0Zgl+NK5QJnHa
	S1lpqEACEd5qxp7foqTnPzokT8Wd4d+AhaQ==
X-ME-Sender: <xms:NRLcZVYWqsjB53TAzwbTRpLFLwgc6hCh5MFZWYz5y-wpRO-KI4gtaA>
    <xme:NRLcZcbiurNUBXDXOWbTvwce_C6PVIRRK0HXRTn7sRiIfnhdX_OR9wa67KjBeMJxW
    VzY37CMQYmOH_qf-y8>
X-ME-Received: <xmr:NRLcZX_KOCgNdhA3vuZfBRH4Y3Z4OUOXPUzj8J6_A4ZIJZ3eiCJQTnarzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedugdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesthdtredttd
    dtvdenucfhrhhomheplfhoshhhucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhr
    ihhplhgvthhtrdhorhhgqeenucggtffrrghtthgvrhhnpeduvdelheettdfgvddvleegue
    efudegudevffekjeegffefvdeikeehvdehleekhfenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhshhesjhhoshhhthhrihhplhgvthhtrd
    horhhg
X-ME-Proxy: <xmx:NRLcZTq-EzohYsJl5T8a8iaFtdhoMWx8cawi6Mg379NINl_d2EltKw>
    <xmx:NRLcZQrfC12N3tNspRZfize5wIZac42T64xgpMg-PCwkZ2nwVIz1BA>
    <xmx:NRLcZZSPjxLyztLgO7hS_cVUK13JQHn2DCO6s3QqD-m9-d8-W_Xpzw>
    <xmx:NRLcZdCWal9L3UeiycBL_6nDkFY665ja5Bwnj3BiOfwGwmUytItIDQ>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Feb 2024 23:23:17 -0500 (EST)
Date: Sun, 25 Feb 2024 20:23:16 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] commit: Avoid redundant scissor line with --cleanup=scissors
 -v
Message-ID: <9c09cea2679e14258720ee63e932e3b9459dbd8c.1708921369.git.josh@joshtriplett.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

`git commit --cleanup=scissors -v` currently prints two scissors lines:
one at the start of the comment lines, and the other right before the
diff. This is redundant, and pushes the diff further down in the user's
editor than it needs to be.

Pass the cleanup mode into wt_status, so that wt_status_print can avoid
printing the extra scissors if already printed.

This moves the enum commit_msg_cleanup_mode from sequencer.h to
wt-status.h to allow wt_status to use the type. sequencer.h already
includes wt-status.h, so this doesn't affect anything else.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 builtin/commit.c | 2 ++
 sequencer.h      | 7 -------
 wt-status.c      | 6 ++++--
 wt-status.h      | 8 ++++++++
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 6d1fa71676..6b2b412932 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -888,6 +888,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 */
 	s->hints = 0;
 
+	s->cleanup_mode = cleanup_mode;
+
 	if (clean_message_contents)
 		strbuf_stripspace(&sb, '\0');
 
diff --git a/sequencer.h b/sequencer.h
index dcef7bb99c..9f818e96f0 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -22,13 +22,6 @@ enum replay_action {
 	REPLAY_INTERACTIVE_REBASE
 };
 
-enum commit_msg_cleanup_mode {
-	COMMIT_MSG_CLEANUP_SPACE,
-	COMMIT_MSG_CLEANUP_NONE,
-	COMMIT_MSG_CLEANUP_SCISSORS,
-	COMMIT_MSG_CLEANUP_ALL
-};
-
 struct replay_opts {
 	enum replay_action action;
 
diff --git a/wt-status.c b/wt-status.c
index b5a29083df..459d399baa 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1143,11 +1143,13 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	 * file (and even the "auto" setting won't work, since it
 	 * will have checked isatty on stdout). But we then do want
 	 * to insert the scissor line here to reliably remove the
-	 * diff before committing.
+	 * diff before committing, if we didn't already include one
+	 * before.
 	 */
 	if (s->fp != stdout) {
 		rev.diffopt.use_color = 0;
-		wt_status_add_cut_line(s->fp);
+		if (s->cleanup_mode != COMMIT_MSG_CLEANUP_SCISSORS)
+			wt_status_add_cut_line(s->fp);
 	}
 	if (s->verbose > 1 && s->committable) {
 		/* print_updated() printed a header, so do we */
diff --git a/wt-status.h b/wt-status.h
index 819dcad723..5ede705e93 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -22,6 +22,13 @@ enum color_wt_status {
 	WT_STATUS_MAXSLOT
 };
 
+enum commit_msg_cleanup_mode {
+	COMMIT_MSG_CLEANUP_SPACE,
+	COMMIT_MSG_CLEANUP_NONE,
+	COMMIT_MSG_CLEANUP_SCISSORS,
+	COMMIT_MSG_CLEANUP_ALL
+};
+
 enum untracked_status_type {
 	SHOW_NO_UNTRACKED_FILES,
 	SHOW_NORMAL_UNTRACKED_FILES,
@@ -130,6 +137,7 @@ struct wt_status {
 	int rename_score;
 	int rename_limit;
 	enum wt_status_format status_format;
+	enum commit_msg_cleanup_mode cleanup_mode;
 	struct wt_status_state state;
 	struct object_id oid_commit; /* when not Initial */
 
-- 
2.43.0

