Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8A81D014F
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704496; cv=none; b=goQsoyQDCIGEDd3ZlC2PIkKEu8Dp7tGKESet+ngfLx6rn0IcWuVkekeBV2v5SnX/DYTaX+Er3szZ1HRSkJEFhHwEvi+PONEiVQH+HkB0szXJY+FHjUJ4OTInZBBbt5RMfo3GlpKAj1M+tItPseBKMtUM0H0R60CNrI1kRhilVQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704496; c=relaxed/simple;
	bh=nqodCJ8XvbkiNOzs+O9UI2/BR/p4+GOx6SEodwORp9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D8wq5WMhvTl70waNcpO1D36ZCkN2JSLCk+LEgmeQUR8lV2JEUWWh/PJxv/3jMvt2I/mvCGjxo/4FGDS0YMKhyHWzJmk30FClgFmdkLL8yl21tu9tpiFTVNGjrCCt5XU63JyjzijdMXsO37EUK1WDIF6Gk+JPi+rfvQk41dOtvVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fxbKexoG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TgIZsgAY; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fxbKexoG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TgIZsgAY"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 77F941140071;
	Wed, 23 Oct 2024 13:28:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 23 Oct 2024 13:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1729704493; x=1729790893; bh=fV
	I71kmsk+Wj69cGeZBPq+gDMeolsgpS23Lb2zoFhWU=; b=fxbKexoGtjsFVSQXjR
	9bKlpvJ3ubvVcUntfnOaTpCbbp+6FSpPip5+/l9g7jWKVzK9ELHSVdwGZdH8VRwt
	glhJGN8hgtsWtcSMkZwMBAEGopzcJXXpUDMIz4OG/asOEtXnWLK/e0NEuB1b3AAm
	MNAV9X2yNezdN7AqBo35bFOEhtl8Ain8/Csgvd/mJfZ4+hZ7EZF2S72SvhNW75Wl
	enr/MIJan0BP3Ax81MKiWChi6YvwWlrv2lbJgLhzFUISKnZFl/ypT55Pevq3hNcN
	CHEleidaWkPt13zFXoj3uqkBWd/ZWw5grjG77jH1t0V5uNch42Nq7nbKOWkWpvvp
	QwLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1729704493; x=1729790893; bh=fVI71kmsk+Wj6
	9cGeZBPq+gDMeolsgpS23Lb2zoFhWU=; b=TgIZsgAYypgNbhf4LpdNyM46Zi2V6
	2VRIDKXEFdm9MM7BLc5IkOOaq5zXfeTK1oa+AxFejwbCBwAfkLw73/pq2eqt3KQ4
	S28RF79qP5oSYujLgJmnx/MKLFvsCFxBoghLWHWK7yg8pnj7NfIjK6W/+6AatY8y
	DrqWssu5qOXXW4Twa8tmRP48iuymdoCUQRb7P2cr/77CmvmGOi9UmEnYKE76h8Cz
	X6IRtySv9qaiktov/jbyLN4HRdzWolOYiBCt6RZzSB+ctQUc7k8oSy2wxsyk2tvS
	mdBPBYQtv/waQFNnhYm6j7Dhr7yOYJeWiQr65EsShe5f5ScP3gQaAMz9w==
X-ME-Sender: <xms:LTIZZ2fNQpc4Et76NC5J63tSgYdWVLPA01Z3eN3A-lm98VKRUDwrfbk>
    <xme:LTIZZwMb5mB6QkIoLnByur9pMA_nvpf28i0JCv8Blrdu_DLaALyeSkm9dm2OKqMFJ
    7C3hqT8xyb6O2r4ug>
X-ME-Received: <xmr:LTIZZ3iKYnaqm2mQ9SXihaou0eDzuLcrDCNi97ARyWRXUwiF5qr2K8OBaFWyjpw6047Aiq1kTmfP2d6Xld4jtlwfePwSWWc5dAiOVOKWdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeetgfekje
    ffudeffeffgeekvefgvedvgeffueejjeelgeduhfdtffeikeelfefhgfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:LTIZZz8x4OuEgpB1VeBJt9uAAGG6Nj7XPHm8_2weiwavWx66D8mDHg>
    <xmx:LTIZZytWCx8kg8onCqB8fAEXkhflAPRjJBacmWWMempbr7C5tLE5ww>
    <xmx:LTIZZ6HuyKHghIz8wELRbSjexo3yj_iv4BwSlwIIUcDydj7PCSy_AA>
    <xmx:LTIZZxPS-3WOhxcA7OWRSkLX49Ib3pktoZvSjQPZ9FanP9fxQ3Ze9A>
    <xmx:LTIZZ2InCglYVA8Y5hw6-WnYnIisHhoNQ9yhgcZOsRh-L_rtV31TqIb7>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 13:28:11 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com
Subject: [PATCH] sequencer: comment checked-out branch properly
Date: Wed, 23 Oct 2024 19:27:58 +0200
Message-ID: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

`git rebase --update-ref` does not insert commands for dependent/sub-
branches which are checked out.[1]  Instead it leaves a comment about
that fact.  The comment char is hard-coded (#).  In turn the comment
line gets interpreted as an invalid command when `core.commentChar`
is in use.

† 1: 900b50c242 (rebase: add --update-refs option, 2022-07-19)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 sequencer.c       |  5 +++--
 t/t3400-rebase.sh | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

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
index 09f230eefb2..f61a717b190 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -456,4 +456,20 @@ test_expect_success 'rebase when inside worktree subdirectory' '
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
+	git -c core.commentChar=% rebase --update-refs base
+'
+
 test_done

base-commit: 34b6ce9b30747131b6e781ff718a45328aa887d0
-- 
2.46.1.641.g54e7913fcb6

