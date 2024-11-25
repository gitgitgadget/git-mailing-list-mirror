Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF791C3023
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732565625; cv=none; b=dNwavQQouZOvoMrqVL9WlRPvkZwCEF9tFYPaHIZ/PQLxL5Xntizfp90bUENNjP0WSYxvdmuOGoy+8JOGeg4La7MOLAXcStm2uTp6YGP9fILh+sHO5eSKh8BLa2kF/Z6TDr9JSFggt//PfWI2OwV4yc1Srz7uCeUNRBbbSoa7x0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732565625; c=relaxed/simple;
	bh=R+eqDlqC1cT3ODlE/b91bNwuHTIgK9VZSw5OF42gy6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTgh9vn1YgHpj4us9C/SkvyVrbRkY4k3onliccBvJwDkz/TzemS5sAn7/idG35irHt5f70uxWj6asirVVcW+no0njUgS111aTPwvR519kJm+VkM0MVWhEc1i7/yE6vldj8DmQIkynQKm03N0omOi2tIL2v+vfdiAcKi6jF9mZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lIauOYPn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yc9rRekz; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lIauOYPn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yc9rRekz"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23A0A11401B6;
	Mon, 25 Nov 2024 15:13:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 25 Nov 2024 15:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732565622;
	 x=1732652022; bh=u1RnMH2o0V0CjLAP3CpWYO2oFXg7Nug0dPGCDomC6IA=; b=
	lIauOYPnbxdOHuNMTZbkggp6uJonfaXDU6VQiB5BZPPo4rlN46lsgk1G6Q54Wlld
	gjVZp12MzTJL8KqcrzH2O3P5h9joJ0MFrdGAHRy/hzcwewl/FdwvZvUlZBHm0fCy
	xeejhxM/iqJCv2VIOsA8nSfakOr0fHOipwwmi4LyNOzEY5hE+31y8krs5Ty9aZbj
	JvYa+yle1T2UUyGEBF9VnBzV2o4wEYwBI1lcJAcxq3XC+6yobd36lXp4OOng1ecA
	bxiSbvn7CLdR9b6Hui1gRJPJWR8ugPLa4rExMg7Rte4BYSa1N11JaZcoPnwPyU+J
	iAmIoDlG7C+M/2PJHu25fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732565622; x=
	1732652022; bh=u1RnMH2o0V0CjLAP3CpWYO2oFXg7Nug0dPGCDomC6IA=; b=Y
	c9rRekzbFx8ZA45WCFAmGYyB20E1zE2wXvoS8L4diKHfk24sfiV2lMThFlA1qqmJ
	vP2+IEePsyCxJ3yxL2lVISAwF34huEbc22vwsbYgtOe0/DLvAs8yF2H5NWeYQzI7
	7cYge4zpmTjA93JqHSREvBcnTwkD5U015L+p/ZmKviiM6MnQb96wrhCx2k5ZfgVW
	QeK1w43sK+1k6e9gC3YyIqvxDHAUBqHA2STjvXasUBN7hjMxu5A9cZKLzWy8rlPY
	OJ6Aus7lCknpbu44JCVl1ulqRAmEu+XFeg5PIQmNOn+0nosmuum+MH0UCgpu97j1
	OxwZDOEPQTwS0xLtv99sg==
X-ME-Sender: <xms:ddpEZ5YAmgrgqXbgX5BpASJAL9cs2hExeUJHRRggfqGpj6Qc3nhzlNg>
    <xme:ddpEZwYgV8a5XdLUi-KZ4GHo5-BHjkzi2qOd-wMucBL7hseouPZ8qQBisIVgmxg4z
    TTGagwgl12hukvfbA>
X-ME-Received: <xmr:ddpEZ79exmr766ipBHpsWTuWW7sgSazNnL1izwUiduncIDtA-ipxMR82x177jwvhYC9aAqhPnYR3k0FLoeSg0-X7E9cKyJoBITpyixhbZu_CnITcMOoFm9f0mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepudelgf
    euieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffgnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:dtpEZ3pdje5BJxr-KO5jPHEFHYxUsZ7tRy2rXwL9JvQfXd7YzQneUA>
    <xmx:dtpEZ0ot6MjlCYFxMsnPLVCkcUFQG7N6iLWu6Uyh7oRLRKTV6inqTA>
    <xmx:dtpEZ9RgqpA_C-vLWAenYF_1YzHKsqoAv6Yj1ScXmiYBy2YMFoZ0Qw>
    <xmx:dtpEZ8pDlzktKqO58zwZ4Kq-5S7GMXaTlqkrnTAkR47n5IlxZPY7aw>
    <xmx:dtpEZ1e3gBSd491xS6ogIfuckTziNqqNhUKM5GCMhLtpfGKkA_Ha74hO>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 15:13:39 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: gitster@pobox.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	stolee@gmail.com,
	phillip.wood123@gmail.com,
	me@ttaylorr.com
Subject: [PATCH v4 2/3] sequencer: comment `--reference` subject line properly
Date: Mon, 25 Nov 2024 21:13:12 +0100
Message-ID: <4d10ad4ab5591ac727a26def00db29fc332c9c95.1732565412.git.code@khaugsbakk.name>
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

`git revert --reference <commit>` leaves behind a comment in the
first line:[1]

    # *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***

Meaning that the commit will just consist of the next line if the user
exits the editor directly:

    This reverts commit <--format=reference commit>

But the comment char here is hardcoded (#).  Which means that the
comment line will inadvertently be included in the commit message if
`core.commentChar`/`core.commentString` is in use.

† 1: See 43966ab3156 (revert: optionally refer to commit in the
    "reference" format, 2022-05-26)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    • Don’t need to cat(1)
      • Also use `-n4` in case `-4` is not widely supported
    
      Link: https://lore.kernel.org/git/7739a6e2-8758-4d0f-b1d6-f0879a89590f@gmail.com/
    v3:
    • Review feedback: check more in the test by inspecting the
      proposed commit message.
    
      Link: https://lore.kernel.org/git/4c623fcf-01dd-4056-80c1-b3c860ab7f87@gmail.com/
    • Message:
      • Rewrite message now that we are testing something different
      • consistency with the other two messages (see previous)
    v2:
    • `strbuf_commented_addf` adds a newline, unlike the previous function.
       We need to remove a newline from the final `strbuf_addstr` with `This
       reverts commits` and add a newline to each of the other
       branches (`else if` and `else`).

 sequencer.c                   |  9 +++++----
 t/t3501-revert-cherry-pick.sh | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1b6fd86f70b..d26299cdea2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2341,8 +2341,8 @@ static int do_pick_commit(struct repository *r,
 		next = parent;
 		next_label = msg.parent_label;
 		if (opts->commit_use_reference) {
-			strbuf_addstr(&ctx->message,
-				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
+			strbuf_commented_addf(&ctx->message, comment_line_str,
+				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
 		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
 			   /*
 			    * We don't touch pre-existing repeated reverts, because
@@ -2352,12 +2352,13 @@ static int do_pick_commit(struct repository *r,
 			   !starts_with(orig_subject, "Revert \"")) {
 			strbuf_addstr(&ctx->message, "Reapply \"");
 			strbuf_addstr(&ctx->message, orig_subject);
+			strbuf_addstr(&ctx->message, "\n");
 		} else {
 			strbuf_addstr(&ctx->message, "Revert \"");
 			strbuf_addstr(&ctx->message, msg.subject);
-			strbuf_addstr(&ctx->message, "\"");
+			strbuf_addstr(&ctx->message, "\"\n");
 		}
-		strbuf_addstr(&ctx->message, "\n\nThis reverts commit ");
+		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
 		refer_to_commit(opts, &ctx->message, commit);
 
 		if (commit->parents && commit->parents->next) {
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 411027fb58c..b84fdfe8a32 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -228,6 +228,20 @@ test_expect_success 'identification of reverted commit (--reference)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git revert --reference with core.commentChar' '
+	test_when_finished "git reset --hard to-ident" &&
+	git checkout --detach to-ident &&
+	GIT_EDITOR="head -n4 >actual" git -c core.commentChar=% revert \
+		--edit --reference HEAD &&
+	cat <<-EOF >expect &&
+	% *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***
+
+	This reverts commit $(git show -s --pretty=reference HEAD^).
+
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'identification of reverted commit (revert.reference)' '
 	git checkout --detach to-ident &&
 	git -c revert.reference=true revert --no-edit HEAD &&
-- 
2.47.0

