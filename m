Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58DC1F7558
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406844; cv=none; b=IXFH9S9VZ0KrcG4xCHFoTiP2otUk/bXcIWMLs4s7Qo+5+wCcEXGbJMZGI3XMsnTIdTufdiAcgLg0SE2jfeKgg5H3q7CbfNHF+rp7nJe2dGL1bnqd/5J7a5m37cTkFemtuwSptYGi6l1C/MuojIhwT/fowNTKO1Av7fRMY29PiSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406844; c=relaxed/simple;
	bh=R+JMQX8AT4QKBmk4gvyCKGY9vq/vH0NvrnuTB3eT8D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBGMaC3R7rRctniVTMgexTC6CX4t4+6bTNErk97DcyKyH+CqWukDuKTX7qX5Q4eRP5onzbR+zOETvLdiQvz8QluOugeumncl4UOaRjiZtgvRCd2rwWjc5I6Yp3ZDBJs2d3pThFMa9QJPvXOwrToCPBq3Bb6xuNeQU8YOg1J3oKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BOzbgn2x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aW0YfnAH; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BOzbgn2x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aW0YfnAH"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DD1A813804CE;
	Tue, 12 Nov 2024 05:20:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 12 Nov 2024 05:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731406841;
	 x=1731493241; bh=n5wHIGDMXrv01qe41SC9YUV2e/SAP9bN9EGn/vuLeMM=; b=
	BOzbgn2x0LxEmhqX8C8qH+x2C4A8POq5f773iMMcntzkuuSTf6BYkjM0aQ3Wipdq
	+1sS1x1F6Lt8hvVjXtRK8zIwjdQKtV03+QmrxveChhgxHwWnzJxVe9kyyel+qvtq
	N6nrPScaHLlMldRTQdZnxMkDybEtmhqLu6pXed1b8zkwR+4aWekzPWaboD655mzn
	ulgjltZcrBw0ij5QxjjUPUMYPncCYD8JB+iaxSNpjEux15qtqsGYk4RNG9QlINBZ
	0lUGW+Q648pMFEEKYj9bvnZFEt09PCbeHNHb6qK9GerWJLDgjyZmnqvr11C38WS2
	6MNfnkwpCnfng5BruIR0ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731406841; x=
	1731493241; bh=n5wHIGDMXrv01qe41SC9YUV2e/SAP9bN9EGn/vuLeMM=; b=a
	W0YfnAHOtze3pT+Cd0QLurD1J7ao54/GTPNtZoJUn1f6j2ovYsKQSTROYrREolP6
	6+XDCTZRHtdnojzQqyhmBjq37PMhpVgQN8mCoIDGzRFdcpf7bvfFLR9gut1yqDke
	3RFGZEbOfYHUuBx68Orn/vcbtS1mJqB8DVj4OYkuvmE4alIq5EPvmXCOYLFBMdnA
	1O0cCN8KSxJGpA5bpXo6RpiezX+bkVmHGjb5Goi/cvJat2NZvn4/EYa/3EfMB5JE
	XVBhrjugSjRB3GFwv00hF8YI7fv0lQf0uErwtVrHtHaCLW5kINaHH9frY7nEa/i4
	375aacIrNppEHlXqykZUg==
X-ME-Sender: <xms:-SszZ1UxfY1FLw_arYTGnFroE4_1sHxhL3yx776EXy2M4YMM1ivLHG8>
    <xme:-SszZ1l78jA6kDTlQQuO2mIOXHVwcOu46FgKSgyDSO7uQfTF6L2qc1ipEtrNvVmZh
    aq5nD1JcodGUa1t2A>
X-ME-Received: <xmr:-SszZxbTfI0FNKjn6ip5YLlBXqI5sZGC8jYR6NvQEOoLOqO0vVtp99ORtblOMu8X1I3ZpqHxJtK3KfZ_ZJn1NFNculMHmrcUaAdHmSth2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgfegle
    fhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomh
X-ME-Proxy: <xmx:-SszZ4UQ91SeD4AJX7w43WVepE3OYNeh4LFJVUM6oS7z_CWWgZEF7g>
    <xmx:-SszZ_lK6fK5ORqyHAhHDB4RKuQ7NAOTOhcJOYJVN06UjVjuGaqfSA>
    <xmx:-SszZ1c-I5Nveh5gphDgIEGtBC1jBIII4J6wQsZvasknBmJrDb2tBQ>
    <xmx:-SszZ5FG1awBuS2Bj_ZzfhPqkt0RI-9DmZtj-nU4zg03dTpVEKcQRg>
    <xmx:-SszZ6uqZa_Vs6TKkykppeTedUkTak5kFzKzjVfo3ltnbuD9VY9-_GXj>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 05:20:40 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com,
	phillip.wood123@gmail.com,
	me@ttaylorr.com
Subject: [PATCH v2 1/3] sequencer: comment checked-out branch properly
Date: Tue, 12 Nov 2024 11:20:11 +0100
Message-ID: <fc3b4438845e9fafd03fb608128099ce37ecd1b9.1731406513.git.code@khaugsbakk.name>
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

`git rebase --update-ref` does not insert commands for dependent/sub-
branches which are checked out.[1]  Instead it leaves a comment about
that fact.  The comment char is hardcoded (#).  In turn the comment
line gets interpreted as an invalid command when `core.commentChar`
is in use.

† 1: 900b50c242 (rebase: add --update-refs option, 2022-07-19)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Message: “hardcoded” (more common according to `git grep`)

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
-- 
2.47.0

