Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBD16BE3A
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732481818; cv=none; b=ak/tyx239e9yiRt7zKamS36TAwoHke/hc6P0YEnA0iuc89V0uYyxOTCCzeF6Nes+4RAoXZOGL8n/ggcaVPcJ+qclS9J9Gt1SoXIsg57EE0RKTM5u9mAlB+o5M84ncKJi3ZeDFchnxZAjOs/xn7s+wNCExwDz/HeuE0JFzyTwgdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732481818; c=relaxed/simple;
	bh=pCf8nP7hzD6UA83EUVXueak6LMeronraoI8s9bjxigA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOM6YroilgxqhRIXg0vZp5OwKokHMKOJzr3ngh94C1K8OikrOh5rC1zXJTVxD3Jnqo++RD7v3KRq2a97BDSznElvkT25+xECgiP1/s7oyBNsBroRlmww2AlAKjyHsAHh0ZMVbxm3J7xHD/UezYutToTUafmu2p2MAJnuxBWjV4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=j1pOkkzH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ndb55TJj; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="j1pOkkzH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ndb55TJj"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E211C11400E6;
	Sun, 24 Nov 2024 15:56:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 24 Nov 2024 15:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732481814;
	 x=1732568214; bh=88LTYSW86+cyDcUUifqBnDpllE5tLPyTVwdB56P3frU=; b=
	j1pOkkzHMbRweCoFbEnPWQFP8G6dZc2l0iqZSQgr3CNIC90k+lQ53y/OF6hpYYak
	6Zj/cRpKBSEFzUAWe04VqGnWpDn7Qe29pQ/+AlNEzVVsCPxuWo1A6LlSkmKa5c2o
	wUGvtbOWk+6dWHB5U9aVEfIAKefbnMo1FqywY5+1dxeZgPeLblodgoUS++JsPEML
	b6dcW8HAyTHduu9JQchq12iNV7q729cy6Lg9iTLHiblxGn2313/wjsrIO0OxNt+2
	7GkPU/EgZ2V8OeE3ktBOwI0iXWPZxGBlZ+/f7NI7+qmL/O7DXNncdKfnWNdG1U5E
	ris8lEQ/ai2LIgNUU+5MVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732481814; x=
	1732568214; bh=88LTYSW86+cyDcUUifqBnDpllE5tLPyTVwdB56P3frU=; b=n
	db55TJjgzrw9G8VrCQkbUPhBI/nAPubw9g6n/wLo6spKISYQn7/xgVuby9l6KQyQ
	UdSeQd5vHfvQ9h7ix6OZE9XcD/c49njeD1vJ+nlxcc++mO+etKps1v9JcrOO8r9o
	tu3Me1jHrJ+4KLkN4MY0MzpunWzr38T8stmEMWlgfXFirSYUSdQ35EaO2AtwTARN
	R8dp+m+WTuTH1Wfy6bruNJJWoubWJjeLsGSmyzqi39cp0NN1zbBXGGWzsNGA/R13
	o5vJlZdfkOXrImaJALqBgMNJE46wKbifVwYKt5QpeGTSusIxgW3yREEbcOhXJagq
	Rj0Rs21WUreNwebiGYgMw==
X-ME-Sender: <xms:FpNDZ0S8flahnq1ahwewx1BAMaDTPRpRWM-WtzJb3-jCekD2pmrjx7k>
    <xme:FpNDZxxdwX9uJfpYfyiBXgYRd9MjUJvBpL8TDWXTnG5c2iZ20nuZDa9OO9VP9EpuZ
    EGX94nM5xgL3SzUcA>
X-ME-Received: <xmr:FpNDZx0lLDSWxGTrT8852QOUGKpq9WFn9x7IOLZlh1OOdtsktEB4vc_raQlEiq7w_V0sfhp-ctizydNitppeuFGafqe0frF5XKvpRjEm4RiG9dzMfDYFqkkEsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeefgddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepudelgf
    euieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffgnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehsthholhgvvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:FpNDZ4BHw4FpzRVjkX8m4Ht_-UlWpIfAH0U3bPdnNcTwlFGT3o7oJQ>
    <xmx:FpNDZ9g1ptgLs4U1vPsPIxVEF7Qf05Q8W-B6qEN3V8YHBAebyzZIiw>
    <xmx:FpNDZ0qZKwe_tiRwOsOCA8oy6WvwyubiXlcH-l8JUc3ImCwtLm7xmQ>
    <xmx:FpNDZwhSHih_SPewKCOOcQkOYq8srpeZUOpBB1SrnKz8mCpMSihB0A>
    <xmx:FpNDZ7YgEB48f0NF6U-ozCKoJD9j3hrGdXU7MUt8LTF9rWVRYZ8EwyCk>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 15:56:53 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com,
	phillip.wood123@gmail.com,
	me@ttaylorr.com
Subject: [PATCH v3 2/3] sequencer: comment `--reference` subject line properly
Date: Sun, 24 Nov 2024 21:56:11 +0100
Message-ID: <7a452142666e5ffd2f69f79532781284b5bba8fa.1732481200.git.code@khaugsbakk.name>
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
index 411027fb58c..43476236131 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -228,6 +228,20 @@ test_expect_success 'identification of reverted commit (--reference)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git revert --reference with core.commentChar' '
+	test_when_finished "git reset --hard to-ident" &&
+	git checkout --detach to-ident &&
+	GIT_EDITOR="cat | head -4 >actual" git -c core.commentChar=% revert \
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

