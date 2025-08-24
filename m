Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C823D297
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756057385; cv=none; b=MWppBQiwTnZUITEwfW8NsXaeC2AgcvTwOz2JpYQFQwC+icV8do/AybKre9Hc32tMR8Eze1MGKdKi5Ju1Zs+tOiBuxwsraY1Jng7rdOVI/5ZbWB1ydsnxgWtP0wNWHxSIEc2GJ494ioAkdxj7ULvxM4P1WghY78gbSdti0TXWN0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756057385; c=relaxed/simple;
	bh=X68koLaKGaF47uYryUF5wxQFwlTdySWW0WIzdzIWSew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DuaYy/GDqjuaYxCnJLOYQkjs1WpP6KZQntg6wrASo7GAaN4YFuK9e18Po5TZDT4DOOLiL0gFtBI0F0q5mJA4qw7ASuILZrFtfC8eLKTFhBrvspVEVkfDlDNbPR3zLjMd3EtiVKuetO7GR+294EwUR5BRVJQ/oKJ4+pOn3qRlr9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CTRdYBGE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ilaIk0O6; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CTRdYBGE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ilaIk0O6"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 728CA1D00026;
	Sun, 24 Aug 2025 13:43:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 24 Aug 2025 13:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756057382;
	 x=1756143782; bh=/ySGua80L7wSQjo86/7wnlQTser9iRLCOf/HjCXmuoQ=; b=
	CTRdYBGEam5m/jSaQSJARwdcUSFuI+/ri89Sz1o9dF6ZG6C/ZHeKstdkuEhzzeMO
	aSBdMCu1xfz6VGa5V5H2sojyvc+ngvtUoYxF4A28EFt1E7nd9+88d7+tpLiCrb54
	sx6wINu1QC+c2b+rTkVFOJOCjNxSThTArbulVu3aldbnf/LyY5uYxelVHe4Va7ky
	QSqUUjFacibxDaUgdYbZ3oTh8FqR+ePqVb+we/T/EfOlbccT68zGUHg8avXOrBxq
	b5Um5pmHz+x+mBcGoN8TYcFYGfsX+C399hvRnO35Qf1EFbwU+VMYCndlYzUeCiYA
	z518MwIygj7DltkO1kTe0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756057382; x=
	1756143782; bh=/ySGua80L7wSQjo86/7wnlQTser9iRLCOf/HjCXmuoQ=; b=i
	laIk0O68AK6nMZ48jLydZ9CXEWOorwXLy+XaOwS8fSx2MoiXGH4UsXh5Wea73Xsv
	r0VUXQr3QJqXPvnrkl34YHRPqwxo3D2Yb7B1LwA9zKJd6LndUtYnoJsMG9E5zKbj
	QmsBdSaASCW26kSVpnGnYUwVEYdpJMBzBTjW17qAG/zRa7m3BFBWwvnM25Rvt3b7
	/EaOkuPBMd7A5nKpvPgykKSDfglYBcBsgqfhaMp7mnXWhSNC6DlASCLrhgjED4Wa
	GBKhwQj6swKHASFUd44/fe6cTkVRXhtDnJRwG/hISh0gARPFMjb2c47ROxJ4NkYT
	sj8atF8CaB+pTaiSevkNw==
X-ME-Sender: <xms:Jk-raLGUN49nGkOTPUpTS6aRQRQeMBoJDKPWonbGOy5vYP9AH6l6og>
    <xme:Jk-raF4xsWbmuwubbooHyysqO83SS85X8wYGdE7vxP4yIkQM2CbpOQTKFeh4JXgsL
    LV9M47I5GKRpBpVHQ>
X-ME-Received: <xmr:Jk-raDnnI4FAG9W08JsE34y4XINz2zHU4Guah_KiWvyNDQBqrRr9Qdvs-DivE5P_4CYPhGVTjVNF5X-bvEfU8CyfLHQ6s7bnyQU8m5nT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgr
    rhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Jk-raKp9RxylaKTOUgi6C5byMPCRoAwGO3M9_3Hawmg4TdHtZhFSOg>
    <xmx:Jk-raCudXNx5YyiCxkTj-aYPkA90fiPcNDe1XXCV4EyF8Fh1kmUBZA>
    <xmx:Jk-raPHoIaq1OZSIFZz4Uh7OlD1ofuwb99K9IrhaV2a7Ti2o9FypEg>
    <xmx:Jk-raLavTTK8-afLJoTIayF2L3HLdb7qOESvak5DXrEkBCQUxLkdBQ>
    <xmx:Jk-raDzLCMI2THgvSG9rHaeyitvwTy0bF64VN2hnBbcWOg87ygw71Krr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:43:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f725c067 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:42:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 24 Aug 2025 19:42:17 +0200
Subject: [PATCH RFC v2 04/16] sequencer: stop using `the_repository` in
 `sequencer_remove_state()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-b4-pks-history-builtin-v2-4-964ac12f65bd@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

Refactor `sequencer_remove_state()` to stop using `the_repository` in
favor of a passed-in repository.

A lot of the other code in our sequencer infrastructure still uses
`the_repository`, but this bigger refactoring is left for another day.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c |  4 ++--
 builtin/revert.c |  2 +-
 sequencer.c      | 18 +++++++++---------
 sequencer.h      |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 3c85768d29..66824ae136 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -568,7 +568,7 @@ static int finish_rebase(struct rebase_options *opts)
 		struct replay_opts replay = REPLAY_OPTS_INIT;
 
 		replay.action = REPLAY_INTERACTIVE_REBASE;
-		ret = sequencer_remove_state(&replay);
+		ret = sequencer_remove_state(the_repository, &replay);
 		replay_opts_release(&replay);
 	} else {
 		strbuf_addstr(&dir, opts->state_dir);
@@ -1405,7 +1405,7 @@ int cmd_rebase(int argc,
 			struct replay_opts replay = REPLAY_OPTS_INIT;
 
 			replay.action = REPLAY_INTERACTIVE_REBASE;
-			ret = sequencer_remove_state(&replay);
+			ret = sequencer_remove_state(the_repository, &replay);
 			replay_opts_release(&replay);
 		} else {
 			strbuf_reset(&buf);
diff --git a/builtin/revert.c b/builtin/revert.c
index c3f92b585d..6456cf2171 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -263,7 +263,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	free(options);
 
 	if (cmd == 'q') {
-		int ret = sequencer_remove_state(opts);
+		int ret = sequencer_remove_state(the_repository, opts);
 		if (!ret)
 			remove_branch_state(the_repository, 0);
 		return ret;
diff --git a/sequencer.c b/sequencer.c
index 898ac1a2a8..749e30c2e6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -425,7 +425,7 @@ void replay_opts_release(struct replay_opts *opts)
 	free(opts->ctx);
 }
 
-int sequencer_remove_state(struct replay_opts *opts)
+int sequencer_remove_state(struct repository *repo, struct replay_opts *opts)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret = 0;
@@ -437,7 +437,7 @@ int sequencer_remove_state(struct replay_opts *opts)
 			char *eol = strchr(p, '\n');
 			if (eol)
 				*eol = '\0';
-			if (refs_delete_ref(get_main_ref_store(the_repository), "(rebase) cleanup", p, NULL, 0) < 0) {
+			if (refs_delete_ref(get_main_ref_store(repo), "(rebase) cleanup", p, NULL, 0) < 0) {
 				warning(_("could not delete '%s'"), p);
 				ret = -1;
 			}
@@ -3048,7 +3048,7 @@ void sequencer_post_commit_cleanup(struct repository *r, int verbose)
 	if (!have_finished_the_last_pick())
 		goto out;
 
-	sequencer_remove_state(&opts);
+	sequencer_remove_state(the_repository, &opts);
 out:
 	replay_opts_release(&opts);
 }
@@ -3601,7 +3601,7 @@ int sequencer_rollback(struct repository *r, struct replay_opts *opts)
 	if (reset_merge(&oid))
 		goto fail;
 	strbuf_release(&buf);
-	return sequencer_remove_state(opts);
+	return sequencer_remove_state(the_repository, opts);
 fail:
 	strbuf_release(&buf);
 	return -1;
@@ -4903,7 +4903,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 	};
 	if (reset_head(r, &ropts)) {
 		apply_autostash(rebase_path_autostash());
-		sequencer_remove_state(opts);
+		sequencer_remove_state(the_repository, opts);
 		return error(_("could not detach HEAD"));
 	}
 
@@ -5268,7 +5268,7 @@ static int pick_commits(struct repository *r,
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
 	 */
-	return sequencer_remove_state(opts);
+	return sequencer_remove_state(the_repository, opts);
 }
 
 static int continue_single_pick(struct repository *r, struct replay_opts *opts)
@@ -6607,7 +6607,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 	if (count_commands(todo_list) == 0) {
 		apply_autostash(rebase_path_autostash());
-		sequencer_remove_state(opts);
+		sequencer_remove_state(the_repository, opts);
 
 		return error(_("nothing to do"));
 	}
@@ -6618,12 +6618,12 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return -1;
 	else if (res == -2) {
 		apply_autostash(rebase_path_autostash());
-		sequencer_remove_state(opts);
+		sequencer_remove_state(the_repository, opts);
 
 		return -1;
 	} else if (res == -3) {
 		apply_autostash(rebase_path_autostash());
-		sequencer_remove_state(opts);
+		sequencer_remove_state(the_repository, opts);
 		todo_list_release(&new_todo);
 
 		return error(_("nothing to do"));
diff --git a/sequencer.h b/sequencer.h
index 082fbe3e35..0e0e7301b8 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -170,7 +170,7 @@ int sequencer_continue(struct repository *repo, struct replay_opts *opts);
 int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
 int sequencer_skip(struct repository *repo, struct replay_opts *opts);
 void replay_opts_release(struct replay_opts *opts);
-int sequencer_remove_state(struct replay_opts *opts);
+int sequencer_remove_state(struct repository *repo, struct replay_opts *opts);
 
 #define TODO_LIST_KEEP_EMPTY (1U << 0)
 #define TODO_LIST_SHORTEN_IDS (1U << 1)

-- 
2.51.0.308.g032396e0da.dirty

