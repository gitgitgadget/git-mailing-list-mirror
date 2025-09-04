Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C81B3090DC
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996073; cv=none; b=EwwpINDD32pp2ppeBhVGMjZex4gNVnyUgMcwaEV54/SjcsYhvglJemrC/515LHnxbyTAO0GIInle4aSi1TpFSDoiLf84dPvnsemW7UxxA5B0P2Oqs+Y6tVY9D3OUuNvFV2rUuNZCQma/YTqbNME1pZKqWth3YIkVLwtThh2mHvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996073; c=relaxed/simple;
	bh=/dYBbsUADUT69tOPHVVb/GueFyxFqdYnyhfDMfEobzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H7mzM/Q1KDE+ovv7fw+Th+znCiC0dYMSNN4vBz+0WDWVdhJiJqx5SHZtc9u6RR8TBAztTfMCRvjtfP2SO8LdfEW2FAvgxqc9EhFIlvhe+vDDGDrTsTsDZ2Cj/2kar2DIAxVDfW1u/sa5YO0YZ6+Oj/SCyKBPLhXOBxSTSkT7a90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MYLZXKkl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O4GOlKr3; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MYLZXKkl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O4GOlKr3"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E1A8A1D00289;
	Thu,  4 Sep 2025 10:27:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 04 Sep 2025 10:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996070;
	 x=1757082470; bh=Da4e63drEG+q8EDlq/f+hTTVXJEC5UIBfyBRMVfBeUI=; b=
	MYLZXKklCAZosbG7fW8E9C63oIZVJ0g821lWyUDWEgAymXRVItpP1geuhvjCbYUR
	9orNgJD5UmkFrBTD3rrGjowjShnAo2Li0emrQcrzFE2ug0YrQN2wewe5HMenOw9b
	8Ew7vP+fugYmxRo8tOijOBAt4JDEhkPTwIJap9ZU5vdXogvJ9joAAqbgcXnK2/ql
	7NoNANrQY4ohfpzh63lDgJ/cY3TzCJsj60e+T2lS9qp1m6sl47a2a5/MB+3N/qDn
	MH5Uu8TnkJooO9edafl/m/1sY+5rYvVEZ9oXqmQ85PA0hxC3liHkgtVPF6WadmJO
	lO8M/JsV40rUcFsP3/zBAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996070; x=
	1757082470; bh=Da4e63drEG+q8EDlq/f+hTTVXJEC5UIBfyBRMVfBeUI=; b=O
	4GOlKr3BwT65x4QL5DG9fx0mvQKv4zU6okABqOXET6VbndHAWJOs2aUY6X9j0Lx/
	1Deqf+e0H0b9H4svcqC0tpZ84amNaAA3NfBdxkj+S/w8ZPRXhJQSuB8IOLUwY7bg
	/G+SFM3RnEmy3SvQy+hIeAIWvHOuINUnfDItyuKffk3beS0KOBwuGS36SY+5Bz0J
	A4xqGpEEZEQMTG3xwhs9uypy2zZ7jbJfYhZkO8LAYnXHNx5mDbo04TwEqGwbARkS
	AdDgTnJEV5AbpbKZm2wh6RP4OIeYl5263RZP1vFaIZZEVPHCXGTcYLX8tOMlCP37
	yKo0OtJBJfVykQWTCVD6A==
X-ME-Sender: <xms:5qG5aH6FJ09I02TjfsKiZgOty-5mBYMywPPuicTG3WhbIGqk1piywg>
    <xme:5qG5aKfmLnW4pu03rHu7vSWTPx28LBarXdLmu5O4UCSW9O3YLuLs-VoEPzoNE0vtj
    bUAhSENaxsnqGVbpw>
X-ME-Received: <xmr:5qG5aE6t1QrLxkv7zt9mwl2jNArOJEu7nINdhGbh_ITw--k2P_hEwX8vLDi9G532nSUYEWVOZnawXr1Bm8jixhvlntKAtJwiO6zERzMioEsi9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshho
    rhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhope
    hjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:5qG5aJuyS0bsLr5_CokOYRykcs9mBZsbyfsUsIMuhc3lz2TiG8g4WQ>
    <xmx:5qG5aMit41MCH_yE4DDgmTlLmpUWKeaydfFGDvvrA5nHyzyRx6c78g>
    <xmx:5qG5aMoJTV7VoqsTDPsEocQQMYPtzpogFkKfibRGFFUlOWTJ8sYCsA>
    <xmx:5qG5aBuiOR5Ig2zHyY9PwRWeT6BOOt13KgpbIh2Denueh7BIXfA_5A>
    <xmx:5qG5aAVKtXnXBDUFb05KF-64GWReU3JOJApQrzHByo4n55_qo8_0u0W5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:27:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d9757353 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:27:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:27:34 +0200
Subject: [PATCH RFC v3 04/18] sequencer: stop using `the_repository` in
 `sequencer_remove_state()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-history-builtin-v3-4-509053514755@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
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
index 9a66e7d128..36e4db8526 100644
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
@@ -3595,7 +3595,7 @@ int sequencer_rollback(struct repository *r, struct replay_opts *opts)
 	if (reset_merge(&oid))
 		goto fail;
 	strbuf_release(&buf);
-	return sequencer_remove_state(opts);
+	return sequencer_remove_state(the_repository, opts);
 fail:
 	strbuf_release(&buf);
 	return -1;
@@ -4897,7 +4897,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 	};
 	if (reset_head(r, &ropts)) {
 		apply_autostash(rebase_path_autostash());
-		sequencer_remove_state(opts);
+		sequencer_remove_state(the_repository, opts);
 		return error(_("could not detach HEAD"));
 	}
 
@@ -5262,7 +5262,7 @@ static int pick_commits(struct repository *r,
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
 	 */
-	return sequencer_remove_state(opts);
+	return sequencer_remove_state(the_repository, opts);
 }
 
 static int continue_single_pick(struct repository *r, struct replay_opts *opts)
@@ -6593,7 +6593,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 	if (count_commands(todo_list) == 0) {
 		apply_autostash(rebase_path_autostash());
-		sequencer_remove_state(opts);
+		sequencer_remove_state(the_repository, opts);
 
 		return error(_("nothing to do"));
 	}
@@ -6604,12 +6604,12 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
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
2.51.0.417.g1ba7204a04.dirty

