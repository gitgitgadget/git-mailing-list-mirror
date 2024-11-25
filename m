Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4641C3023
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732565620; cv=none; b=BW8v6QgPK6uxU8aIzMjI4/KEjt/6bEd+yvaoVvIN0qzvDKIZ/53xYxoGUkU1z5/SMtGQtgl6LFQyCqdnqf0ePNkB5cXuCVvdivcTIwS3FJGGaH2Uf1q0emXyd+14hHayopSgQmtF3UzkwNha2YxlQd3me/0F/wODugnPjTFWfQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732565620; c=relaxed/simple;
	bh=8tzgDUQUXY+Np0STE25N1qKFQwItTWFGKFuEKtF0e6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDsB2Bb9YkLNbtDFsOyAcUcFFoFr2ekRUNblRfkZs4q1qRDl8utNZrtJFMi7OEkKF89U6UloSNHrGqHHDek9Cf8XwQ8BqBkNJagfFKjyCJaA08WXI2HpPGMu4op/5juzm05rmlM7Vxjzusl808Rz0KGCfBI9NCwA8Qs1tsuN3wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HEZ+AoXb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EM6wHPit; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HEZ+AoXb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EM6wHPit"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0C1511140198;
	Mon, 25 Nov 2024 15:13:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 25 Nov 2024 15:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732565618;
	 x=1732652018; bh=bT4IGTWa07Vi2swz/u2NZDtA0NUZiI1QTnp4oxHUYwI=; b=
	HEZ+AoXb8edAZeTflOH1Bb5OJ2BYeVDUc3tlTKOcMo1Ps78sAwoy/yTIMgd3fSUk
	zPkDZSO0LGkNNMK60kYXSgvc77QAtSPN61dGi+be3APWxC5rHC6huG5jVMlQS9Zz
	nMlzMDr7XcOhOZ1Qc5lQTt9CN8wnFu8uaH349dj8wKqc0biFKdMdvp4HuWsIpPIW
	VvcfDvbNQ1dSI/uvzBciMdTLQh1l5g/wFRTXQZBVos++gnF1hQ4rcaWYNspG22R7
	Y2pB+KE7amUmyVu9MVD/6JQKv90Z2/iW/rD8XZ3G5nEPvnDLGKG7zYoNPbMipYtR
	hez/CpW27O8PfPgY5chkzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732565618; x=
	1732652018; bh=bT4IGTWa07Vi2swz/u2NZDtA0NUZiI1QTnp4oxHUYwI=; b=E
	M6wHPitutUeChRY6mOWd4Yv8AVUKDUPN3mK7RqvhYopCrv86JG7TC/9Wdpvjvu68
	Or9PUIa1T7u2BtqcOH2d8ZujXbe2xRRWqE92HjLabEWMG411kXZLgFFmi4/LKSLx
	F8nlsN6sbBxPSnI1rDt4qJ74BX4BfeXIHZGYz+pXYxTA/Z3y63QiED3GRe4S/Mm5
	fB3M827Ad+hU0wamaR3VYPas2/apz1iATk8Yo7Ab5mbbQXTmA0tZVPLUBGMcHq5g
	m/j7iWXmoyEYTmn4u1ZmNY9ztr5AoEfJErPVqvNvpRbEeoKjlwuetxJYXfHqM8Rs
	etXkMrrWaz93EYwXY8YWg==
X-ME-Sender: <xms:cdpEZ6gl-MVEDGDucAXdu_38SuZNRCl2O_gTjzcEPK-PgMiUkbpClhA>
    <xme:cdpEZ7AUU-uu3LrkPNnrV7Ip14RXs-w6ia2WSMu_fEGkJxxEZHI2YXi_U2y66OxvT
    05EktV8WLQxxHQHUQ>
X-ME-Received: <xmr:cdpEZyFHloBOyN41is3ddb4AeQAeC71QF1knsAV0cQrWLZ7yM-_8mL5vsSckJTqi52vLoOCgyFGx9IxjFPQ3FN_BQ8w_R7eQ0al8c-J8_k97-354dcoSeR4POQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepudelgf
    euieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffgnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:cdpEZzRbMznoJ5BxO8LHIxZYZFvkBWPgvB9XfKrvquGCBInefysXIw>
    <xmx:cdpEZ3xRAufbKA6llwzimkCqvGmNPp_Gb4_rI6r5jw3oOfEChPpHIQ>
    <xmx:cdpEZx62aJixvK1jEda-tJxQR8vBmdcUobtzxmhVa_CmQXY0JOkogw>
    <xmx:cdpEZ0wQelLAaAMPLHiiEBUxDxoxtS52u8-kwh8gDgNwYfpRthaASQ>
    <xmx:ctpEZ-lE2u8gOKEomPrhC7CeQTx0xdcAcLvSUfKCIQeKAbwytNh_UwRI>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 15:13:35 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: gitster@pobox.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	stolee@gmail.com,
	phillip.wood123@gmail.com,
	me@ttaylorr.com
Subject: [PATCH v4 1/3] sequencer: comment checked-out branch properly
Date: Mon, 25 Nov 2024 21:13:11 +0100
Message-ID: <a8813b5f14c8af8fce478ea2fe5b5adcb72f9028.1732565412.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732565412.git.code@khaugsbakk.name>
References: <cover.1732481200.git.code@khaugsbakk.name> <cover.1732565412.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

`git rebase --update-ref` does not insert commands for dependent/sub-
branches which are checked out.[1]  Instead it leaves a comment about
that fact.  The comment char is hardcoded (#).  In turn the comment
line gets interpreted as an invalid command when `core.commentChar`/
`core.commentString` is in use.

† 1: See 900b50c242 (rebase: add --update-refs option, 2022-07-19)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4
    • Use `test_grep`
    
      Link: https://lore.kernel.org/git/5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name/T/#me80519debcd013aa8c8a5e5003c58cff7281fac9
    v3:
    • Review feedback: check more in the test by inspecting the
      sequence editor
    
      Link: https://lore.kernel.org/git/5ed77fab-678d-4a06-bbd0-ea25462a7562@gmail.com/
    • Message: consistency with the other two messages:
      • Mention both commentChar and commentString
      • Commit footnote style: See <commit>
    v2:
    • Message: “hardcoded” (more common according to `git grep`)

 sequencer.c       |  5 +++--
 t/t3400-rebase.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 353d804999b..1b6fd86f70b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6382,8 +6382,9 @@ static int add_decorations_to_list(const struct commit *commit,
 		/* If the branch is checked out, then leave a comment instead. */
 		if ((path = branch_checked_out(decoration->name))) {
 			item->command = TODO_COMMENT;
-			strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
-				    decoration->name, path);
+			strbuf_commented_addf(ctx->buf, comment_line_str,
+					      "Ref %s checked out at '%s'\n",
+					      decoration->name, path);
 		} else {
 			struct string_list_item *sti;
 			item->command = TODO_UPDATE_REF;
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 09f230eefb2..7c47af6dcd9 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -456,4 +456,23 @@ test_expect_success 'rebase when inside worktree subdirectory' '
 	)
 '
 
+test_expect_success 'git rebase --update-ref with core.commentChar and branch on worktree' '
+	test_when_finished git branch -D base topic2 &&
+	test_when_finished git checkout main &&
+	test_when_finished git branch -D wt-topic &&
+	test_when_finished git worktree remove wt-topic &&
+	git checkout main &&
+	git checkout -b base &&
+	git checkout -b topic2 &&
+	test_commit msg2 &&
+	git worktree add wt-topic &&
+	git checkout base &&
+	test_commit msg3 &&
+	git checkout topic2 &&
+	GIT_SEQUENCE_EDITOR="cat >actual" git -c core.commentChar=% \
+		 rebase -i --update-refs base &&
+	test_grep "% Ref refs/heads/wt-topic checked out at" actual &&
+	test_grep "% Ref refs/heads/topic2 checked out at" actual
+'
+
 test_done
-- 
2.47.0

