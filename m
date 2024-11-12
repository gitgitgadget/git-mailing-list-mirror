Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7D21314C
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 10:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406858; cv=none; b=aJWipaQxq/U05w3gYdPNln62l1H404Vh4fwH2z3GVIMtevqohZFuS7fI1Xd1O1kCtCQVx8hQPn0EnPlqolf7bn+qmZ0JYgVXv+GUBSnLTcO24sZZq/kmszmfapWrW4ZTFO1FWW3GRcuH28QySSGVWEwX3/Bk0ZzrZ3L3BWRiUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406858; c=relaxed/simple;
	bh=qHLiP+knBNPaN1drWVdEi1W/qbY5+cyofShyqNX5KSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAYYx0iA9kHIVvooxIuo388QSkt9G7Tlix8fPaPKKzPbnC+ku7zBCvRYhIIWk6RnyNz89XH0/WXJkS80qrXwIAbZoJd4doI7npVYLJmeIYituG5VyKvyXYKv3gRx6uMnCKhUk0g7JmIirupD4BlIBVRCrqa1nXTTEsyiBgOY8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Y1mYwNp1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B6mImMdX; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Y1mYwNp1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B6mImMdX"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id A5F66138070D;
	Tue, 12 Nov 2024 05:20:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 12 Nov 2024 05:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731406855;
	 x=1731493255; bh=O6oossJOwLP6T9KJH69WX5f5c56aBT8NyjsrbZ4FYko=; b=
	Y1mYwNp1ath/w7HR+ATrONERyPu8uZdPrJ91zNZFuMe67Y4h9xAS7MKjNAPRFdCY
	Jxs4kuCdXsbi8cklZQU31A7gx9iBA6N/DLXytIDkzR29HFkSKTMb9bstDEAnMeaA
	Mjeb5NpbBUcRGugrSMXnRfujdMN60ai1ouzLJygE7FAhicLp3YaEYEiEfJmx/hT1
	mdPZnV6LvfWQD5Pp+gy96r7a/rITPI53yTVNYOwwW8ZvGu7aRTBtpRxhc1PY5Wyg
	Vx8YT3moIyKyQQX6Jb4lbr9Sm/PtgtuOF31L1lpBy+RahQydtxw+tKsVqMXtFdaj
	cFih3TRJBBYDiaNJ0vOiOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731406855; x=
	1731493255; bh=O6oossJOwLP6T9KJH69WX5f5c56aBT8NyjsrbZ4FYko=; b=B
	6mImMdXdmCK7DkCc0oRLWOlAqXoBJY0+85zKDAyxiMHB51BzERLYw3urAb6nI86p
	y22GIgTkgNQU3FcA/8O4NGIthycLMsJzkV3sr5Z5X16xACTzzFRsOBrmR0l1Ks0Y
	DxPkywqApyegiwUHqjm17dA8SmjRpct03QO2zWlpN87hkQgXkkR9+g8XSed9OHSp
	ehVKid7zm7cUpGBEvVI7MK/nJ3Gw73x0FbOYebVyA6VV3ZQiUF8BL1tx/wQvcqol
	Aohi9E/g+OEsPK+dZBHPn/ZTlyp7dX3lzH7PhkV0XOSOAzSM04SX4Zf+IqbgqK9c
	sCeG7bWtAbecJP2AIc8Jw==
X-ME-Sender: <xms:BywzZ8ARnG3uLwwZsW_BBIcPvRENLsKURSp14L1QaiKttX0af9G75iA>
    <xme:BywzZ-gqXAhbmY1N9ATNB3kIDxfhriAQg1ausJ5bE0USWNjp6AJ9Ax8IFnJHhJJcZ
    pKxpMFTvWOMYlk7Kg>
X-ME-Received: <xmr:BywzZ_kMCxPs7s8ANbVWgRNSto9TCT7TiKnjLHx9512f0Bi5vk82wdwDDwg3Ms_6p5UTYuaFm5vCTwtBjnFhk9LwVqMhE6drYnPEDtE_gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeen
    ucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmnecuggftrfgrthhtvghrnhepudelgfeuieeuteekleeifeegudefheetkefhjeff
    kedvueehtdevhfekieekhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtoh
    epiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
    dprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:BywzZyyoyzFipPDWYUxbvdfKJk0NZnuW1v736ZrM71W2j532rN3Q0Q>
    <xmx:BywzZxTnoZlQG9CMYcQ16HILpsMhCDY-_ho-rx52giDsmzq4QVRbGQ>
    <xmx:BywzZ9b34b4p4OkeYwgODbHp9exkcyBaBR4fDwqQ0xhrMS6UacWCrA>
    <xmx:BywzZ6Rbxsr8PsbIH7koFGf_iTl-tNoseYmIj-0i1KSHE1Q2JcJQ4Q>
    <xmx:BywzZwFnMcOIllWgYCYsDZ8pJcHjYxJBFXLfsWzz-hGS8P2ki7Wl6pbo>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 05:20:53 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com,
	phillip.wood123@gmail.com,
	me@ttaylorr.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 3/3] sequencer: comment commit messages properly
Date: Tue, 12 Nov 2024 11:20:13 +0100
Message-ID: <86b4b485e0b3ef023a5d559f437eae22f2fd458f.1731406513.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.47.0.317.g7d2562b9734
In-Reply-To: <cover.1731406513.git.code@khaugsbakk.name>
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name> <cover.1731406513.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Co-authored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2
    • Phillip contributed the test and the `strbuf_setlen` changes

Notes (meta-trailers):
    Co-authored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
        Link: https://lore.kernel.org/git/cfa466b8-a87d-4b5d-b330-6c660897de48@gmail.com/#t

 sequencer.c                     | 12 ++++++++----
 t/t3437-rebase-fixup-options.sh | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d26299cdea2..42a6f257cbb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1941,10 +1941,10 @@ static int seen_squash(struct replay_ctx *ctx)
 
 static void update_comment_bufs(struct strbuf *buf1, struct strbuf *buf2, int n)
 {
-	strbuf_setlen(buf1, 2);
+	strbuf_setlen(buf1, strlen(comment_line_str) + 1);
 	strbuf_addf(buf1, _(nth_commit_msg_fmt), n);
 	strbuf_addch(buf1, '\n');
-	strbuf_setlen(buf2, 2);
+	strbuf_setlen(buf2, strlen(comment_line_str) + 1);
 	strbuf_addf(buf2, _(skip_nth_commit_msg_fmt), n);
 	strbuf_addch(buf2, '\n');
 }
@@ -1963,8 +1963,12 @@ static void update_squash_message_for_fixup(struct strbuf *msg)
 	size_t orig_msg_len;
 	int i = 1;
 
-	strbuf_addf(&buf1, "# %s\n", _(first_commit_msg_str));
-	strbuf_addf(&buf2, "# %s\n", _(skip_first_commit_msg_str));
+	strbuf_add_commented_lines(&buf1, _(first_commit_msg_str),
+				   strlen(_(first_commit_msg_str)),
+				   comment_line_str);
+	strbuf_add_commented_lines(&buf2, _(skip_first_commit_msg_str),
+				   strlen(_(skip_first_commit_msg_str)),
+				   comment_line_str);
 	s = start = orig_msg = strbuf_detach(msg, &orig_msg_len);
 	while (s) {
 		const char *next;
diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 7929e2e2e3a..a4b90e881e3 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -127,6 +127,21 @@ test_expect_success 'fixup -C with conflicts gives correct message' '
 	test_cmp expected-author actual-author
 '
 
+test_expect_success 'conflicting fixup -C after fixup with custom comment string' '
+	test_config core.commentString COMMENT &&
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout --detach A3 &&
+	test_must_fail env FAKE_LINES="1 fixup 2 fixup_-C 4" git rebase -i A &&
+	echo resolved >A &&
+	git add A &&
+	FAKE_COMMIT_AMEND=edited git rebase --continue &&
+	test_commit_message HEAD <<-\EOF
+	A3
+
+	edited
+	EOF
+'
+
 test_expect_success 'skipping fixup -C after fixup gives correct message' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout --detach A3 &&
-- 
2.47.0

