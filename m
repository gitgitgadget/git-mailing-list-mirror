Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41EC1547CA
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732481822; cv=none; b=Kar86lmoUfb2RIYDr2WOyqJY9jhRH0rDxiOQX/6kl4APrw1ogmnrrAQqFSoChbr0bfKak6mgez/+6SZNMb0pg2VB2Gm+hGadZYz34oqJzhbOkTkVQJg1bbPc7bTt0xVP2Zc+HPApI2DOYOCdvrMKf1IgC/gS8hCZ6Ga3BSBGn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732481822; c=relaxed/simple;
	bh=5IGcTd6uwVaVvOJgZN1dJYINORWP9PC8dIVvvKK1cQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLNhIYCb7KiOHIDi0wZqvaSNPrWF2YGVjrybZ6MrHproiLm3fiO8u6FEoDHWuPWII4mWheX5HUKH+xw9GzfbFggGBk1Pi80U92UXeG9BsAjAVE3qH62u7eXzvY4gb9qDO9JwCCNfHvZgDbFtxetZ+KiomR2tZJClqAKMQyI1/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=R8GroSXw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ACMpEQrO; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="R8GroSXw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ACMpEQrO"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C0A8E1140137;
	Sun, 24 Nov 2024 15:56:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 24 Nov 2024 15:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732481819;
	 x=1732568219; bh=Hyi0OTEATGcEHyArqOIJ2nFIbsVYKel1tYL32tfPrNs=; b=
	R8GroSXwqOOhNEq6PpeBwZ5/H6krPTvm0d0j1wDgMz8o61R1t7OwyGRmnPVgCRqy
	KTFmEWPVML/rgTj4wwNjVVkonFYfYWHzTCpSjlQdDXgE4EQ4MPTdf9gn9gGOYIJN
	5VN6WHnR5HSZxvElx0FdXK4fuidOSdiVFCrNMmdTlcF9I9S0R00/8DUpYVfE7kvW
	7m5pzC24x6S/cZfR1yVy0IwEkvjCTp55KqiDsQsLmo7KY9sHR1pHLrMCBICkmVYk
	U06PqBZWnvELyqvktso/5CRPtf2VxN5DhfnT012FMWDciN8n+DO4lFiqG3BmEwvJ
	DY4W8L6uUGB15kCDD1LJsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732481819; x=
	1732568219; bh=Hyi0OTEATGcEHyArqOIJ2nFIbsVYKel1tYL32tfPrNs=; b=A
	CMpEQrORBegy6ZNDkEgTEwioQBPbTmRuxbL+LQW0N8kRyvUZTfLJsGNtmLvzpspx
	E5any6jV5q7YUNdWKC37mF/oQCRKWbht49ZJYAe2SPCj6wNE9ELz5CcGXx03TmLT
	fCXMNEuVcvvoO3xaKXr75reZ+4UJA+VqQbQQPVQD63AbkioTkoNA29IElkLngFBx
	64KZD8gaMntMzASKHbgadz2QxZj781BNiW7oOEdIOXQYBlAyS7NO9OZcRqwxTzum
	FsX4c0kmGxaRruo3I0mSYgomQ+UIZpLALmaksC3MURnCd113VFyHXIOTAqLStX8y
	r+wbCXyh0osBtkUb2n2Xg==
X-ME-Sender: <xms:G5NDZ0FEXOZM2S2kkdcuI_JvE0X80qjJKMl-Rgfp4BOBSmfSmiEzqMk>
    <xme:G5NDZ9WRfYyC12Qa8e6ArWft0pZ0WbjQEGe5l9_yKHk13fdfsIM5Y7WaB7O0No00f
    UchShjiotTEhCa2FA>
X-ME-Received: <xmr:G5NDZ-LNOMAU24fOWZAtRA9K94idgTxeIP3kZvfXt3IElQHyrknl0l9hGM0uW0bhFYyG-plQcbIh3nrBM9sZNOkLfHRLUCuhfe21SMJIdGXEvFJd7D8L0WLW4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeefgddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpedulefgueeiueetkeelieefgedufeehteekhfej
    ffekvdeuhedtvefhkeeikefhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtth
    hopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhn
    vghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:G5NDZ2EhZO7696zbyNNlfnZd7nHREL9gRDMucnH8NsqK3_oFr6OOCA>
    <xmx:G5NDZ6UgT5amFD-Yq0aCD717Q_2oF-i6AOlmkvUgsLdyDRrInTCSsw>
    <xmx:G5NDZ5PAB8bJBW6Zyb91s4p53QW51-FeuEKtcnwGcDxRoyifJCz2gQ>
    <xmx:G5NDZx2icrwEHc5eqinJj9rbSlzMfm1PywBOGVxlV9gZVXhQVOOYmw>
    <xmx:G5NDZ8I71y6FcbuzA0lRC41LPzvxpJOoD2PWc9ade4JMMxJiaHYcFgKL>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 15:56:57 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com,
	phillip.wood123@gmail.com,
	me@ttaylorr.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 3/3] sequencer: comment commit messages properly
Date: Sun, 24 Nov 2024 21:56:12 +0100
Message-ID: <4c342bc04225cbf1e8fe2048c9dc9e8d261891e4.1732481200.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732481200.git.code@khaugsbakk.name>
References: <cover.1731406513.git.code@khaugsbakk.name> <cover.1732481200.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The rebase todo editor has commands like `fixup -c` which affects
the commit messages of the rebased commits.[1]  For example:

    pick hash1 <msg>
    fixup hash2 <msg>
    fixup -c hash3 <msg>

This says that hash2` and hash3 should be squashed into hash1 and
that hash3’s commit message should be used for the resulting commit.
So the user is presented with an editor where the two first commit
messages are commented out and the third is not.  However this does
not work if `core.commentChar`/`core.commentString` is in use since
the comment char is hardcoded (#) in this `sequencer.c` function.
As a result the first commit message will not be commented out.

† 1: See 9e3cebd97cb (rebase -i: add fixup [-C | -c] command,
    2021-01-29)

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Co-authored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reported-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • Message: Explain to the best of my knowledge what is going on here in
      the message body
    
      Link: https://lore.kernel.org/git/711b59d7-e649-4031-8924-a16fb632b4d4@gmail.com/
    • Fixed wrong/subpar use of trailers
    
      Link: https://lore.kernel.org/git/711b59d7-e649-4031-8924-a16fb632b4d4@gmail.com/
    v2:
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

