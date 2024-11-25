Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CC11C3F00
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732565629; cv=none; b=afpnMptXKXp5c9KfG3OXuKU9liNHdOFNCM+ixmX4XshTR5kqBIsEEbddTevWoQ7Z7Vc71uF/TG2JwzkPKYXBvvFXYdytGgP4NcT3mxPuwYpqal9g0BrNTWM23N1qo1v1KIBJuJoBb3/AMzOyDim9S5J9qyT1quk0bjbYiSHDp94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732565629; c=relaxed/simple;
	bh=Ayucz9bpC5JkMHI20YXd54jwXTnu+Zjp1OXNfNp1y2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3qSvHEu027D5tQY1imW9C73NJdonICRAbcDWxPMggxLEGnMqm9oaXkP6MyZe/52vloRRkSrXSyzbGVwAbH+7hf773XXuGSgWHVvw3R18kFQbBjX8zdtuE8JUapwgHaARjIhDUyTWSgdqtdgmnUH0fGy901pYXZOAe3/FYaCyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kr29un/9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QCLVGGSI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kr29un/9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QCLVGGSI"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 151AD11400D4;
	Mon, 25 Nov 2024 15:13:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 25 Nov 2024 15:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732565626;
	 x=1732652026; bh=KiGvlpjRrnl/rIhlB6tBP6qvuknIfKPDzj+NjZFBKNY=; b=
	kr29un/9eki7Dgtidc58/yKZJs7EclWsO5+pBJMDtH7O/PNZYa/V0cePdk2aHxwb
	I7niMvYnkzKkgreZFTWS4HYvaW5RFy2ivY0CAO1RR8zQ0sxSK5f9c+WNKEUCfYBE
	BQlJ4gRAo0Uyok7SSfywB88GqyiPn2sg1EuBiMJwhAZPyXv590TC3Y4MRaPKmrG/
	i153ZnfzZcde85zKD3U6byEDrGsYJQmFedEGSeYKU3lZz8KfbJ1PSKY8g0jiHcdG
	HRVhY581h28pdq5N157vZX/Fn6CY+J8UvVDOAgJKtdkpUygjYOVSLNemCflSRHpT
	qztnPOB6DyOy4nUDevLwJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732565626; x=
	1732652026; bh=KiGvlpjRrnl/rIhlB6tBP6qvuknIfKPDzj+NjZFBKNY=; b=Q
	CLVGGSIqXm1FnP1ridraaxQoRiEOOpCoYEp0fuYEKmr/H2qJ+rP4gFepZ9szSeuM
	U0TTlCNnqTIvEr5A11x+dlrtqykKQ7uavt01rGsvigIiZKkJi5FXD+HHJJiUXRqT
	2fVT1ddL/3wWuuIJtJb1+no9TmssJpg33U+0ICG2iQ91hH3AEpj5jGOemdVYghz2
	mmI3/iWdloNtNG/YKPpMGCFUFDPvIqCqUStm+1qdRDoNhBBR60806Ic/jtRZQ60O
	HWv/XPa+zrJ9lMgcM0w91ji1sUGZGb1+5RW/2YaSf3SolRgMmKnV+rYJfokc+ncY
	gn3ptTe8ZyrYV4cuiE7uA==
X-ME-Sender: <xms:edpEZz8t2tndD3Hd_DJlPg1ZQF5YpoyBJO9WFTO7O-Q9isq_U6cB_8U>
    <xme:edpEZ_v5lWZAUXIprvISlzc2zXMcPWH2v3bb0Uavt9Er4Idvxto4bDxe_HikR-rlo
    6PKvummvMSTLXxDlQ>
X-ME-Received: <xmr:edpEZxBKN4ED9OCXcE2iuPZQHYPQJcb5bp3tS_YgXGap0su3vzmyGfWZndVW1QLzmOwvllRyePY7sLH1t_UmpVIDvzIkj1zejo07n05WsxQG6dYuH9b3_87Wlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpedulefgueeiueetkeelieefgedufeehteekhfej
    ffekvdeuhedtvefhkeeikefhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtth
    hopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    thholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:edpEZ_dUuBzPZmliv6MB_v_tY3_bydutu4sCq7AQ7I99x0pzI8ZjUA>
    <xmx:edpEZ4PbyZhQoGssiVtNPkN32Ei6IvQ-SClbUhQXHD0exwURjwOBEA>
    <xmx:edpEZxnF1OBn8-aJXIYYfeVLp2vVX30DNdJZvA-3ghfp9G4Mty72YA>
    <xmx:edpEZyvzVbfp48pxKg3-FHHkxjjLg57bGcvcMjQ7QuSyPedMdHo3xA>
    <xmx:etpEZ_f4LZCJBJjEH3j1MTJuBuEiCQsEAb7ykU8VVHcfJHkq8WMHiJoK>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 15:13:43 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: gitster@pobox.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	stolee@gmail.com,
	phillip.wood123@gmail.com,
	me@ttaylorr.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 3/3] sequencer: comment commit messages properly
Date: Mon, 25 Nov 2024 21:13:13 +0100
Message-ID: <42b9fbd12d6710248dfc9810c00d63078a0b8428.1732565412.git.code@khaugsbakk.name>
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

The rebase todo editor has commands like `fixup -c` which affects
the commit messages of the rebased commits.[1]  For example:

    pick hash1 <msg>
    fixup hash2 <msg>
    fixup -c hash3 <msg>

This says that hash2 and hash3 should be squashed into hash1 and
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
    v4:
    • Fix commit message (`)
    
      Link: https://lore.kernel.org/git/5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name/T/#me80519debcd013aa8c8a5e5003c58cff7281fac9
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

