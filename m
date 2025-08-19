Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD7322DC9
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600972; cv=none; b=ue4CqPCOmbUVBoYOQ5X3Kwbrsn7MS73w8nYqHRS+r3p3myz8sduz35oYiEtHAIhcjoWE3jMCY9vu/kqRMxAo8D/f4YhabJdjQdT3MThokBOwMQfSQp3xtI6BEnMP+hKYwbD2ADAPDVRIKUP68tagZkIMZUe2rl3ykVynVwJmJJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600972; c=relaxed/simple;
	bh=YPnj98meKCd8Y9HXbFOtrPYa4FilzjiWhZuoBoqmtC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YdS1WNxc3uEi8NOuCJGd6OQl3yPS8OZj/5EFmiMnRjAzSLfQJVZHN2d4CH81nuoasxie+f3TGhMUp3qYA6g7pTDArcZqgP8QSjM0Rr9UXKXOaGdj+nXT/iwB0BRa3cDrLrh1I/qpo5ZMi6xFKkgTYcJmtYrfoJbND5uakTW8fZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b3+m0xB6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RAPK0Oj2; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b3+m0xB6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RAPK0Oj2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 030867A02A3
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 19 Aug 2025 06:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755600968;
	 x=1755687368; bh=lb8tKWVmMT86Qjf6DpzZoG7afiyDANChZLYH57AVbQM=; b=
	b3+m0xB6ZuZf/zW5d9qyPycFroMAnKxyHilpk+0s72VCzhYF98zlFelQ1PBuST5U
	ZOcYpJ4amKv+7LmNPgWgxEwNWxOC+MV7TSJQemXOGZRibP//I8HBSpoG2aCHMo/y
	Sy9ubF+M3+N45WZIFil71mES1rUkdeK26duJTSQPXlL8VE/DlFtFD75Xtiam3R85
	12GXVFggvgogk19EKY77qDyYInLjIxR7cfmIBct47oaSyqCceya4lxExtP2NFWVm
	ZPs/MNJqnk9UgIHKYekMrWh0uhXMIvDHQHWB5+/8BXbMzC5D9rNOWOpBDmRTAHE+
	Pv1W1ipaJoTcr2O5+0v5mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755600968; x=
	1755687368; bh=lb8tKWVmMT86Qjf6DpzZoG7afiyDANChZLYH57AVbQM=; b=R
	APK0Oj2AFaGsC+FfMZV/u63AEu4//fuA9TT2wDbG3+uHOc6kiSiMX2VuiogkV9cC
	wIYNbkO5jy88pTjuPb8ig2h9ofIS0LR4FhoHlD+/9ZWgmKUEeWLpbK9EX6ON9cTm
	yzsyG765Zky6w7zPnHTK7+Tbw5FzL2XsQ/o3kvhFvz+vcW3Tp0fk8RpHjtuPqaY9
	wJCchrxvu+1DWGv1C9bovCDlLfG7HW9zHiz3RHWVfyH1YPwTRSK7hl7lq9Rcsi+6
	ywG6ROyY+UinygKdh2AKl90EAUaOIlDcXGB4aO2Vwvyyq2+7NHe7DTOSgBX74jV+
	TSk6/qzbnJlhGe1uRdyOQ==
X-ME-Sender: <xms:SFikaBo4tbjQMimdN2_en4Y12XqwSTfpqtzsDX-yTNFJU7EKh_bJPA>
    <xme:SFikaFqqqjWYwRWB_0Gf_mIsZjFoInLVmF_mUAI57kbElD4ZioyHaCBMKelhA9kvw
    KaClWzFZGwzWVmjIw>
X-ME-Received: <xmr:SFikaHnlJK7RvEMuFv4uF9yF3oxVpJSlCzxYR8IYe_O52JOAYK9uTuoOxtqbEPyE7P_BeJjGWG51h6ojmmmDiU7q78jhHMpbOuBaEsl4rSpI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:SFikaPFfkWYhMgdkEXzNWjkw7nHDYt6bC1c17mrG9U57NAjunny6BA>
    <xmx:SFikaIpM73mh90jDCL_quBtavsoljtSfs6dYzo8jpU4qIAH5VNOcNA>
    <xmx:SFikaD6c3jNx8xCt1VO47zlHviXdyzMBOH9IzwJxpd82_5G9Ct_lEA>
    <xmx:SFikaO7Z47uub_jAnqOu-AUzutCJ3IO063ABr0lfjc4AOng6ptaSSw>
    <xmx:SFikaCBjCNmn_ohkMzYkbqYcBPT8KoD6eLREe2D_vOo39zqQ5LYaDNCt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 40f0fb30 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 10:56:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 12:55:58 +0200
Subject: [PATCH RFC 02/11] sequencer: add option to rewind HEAD after
 picking commits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-history-builtin-v1-2-9b77c32688fe@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
In-Reply-To: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

While the sequencer infrastructure knows to rewind "HEAD" to whatever it
was pointing to before a rebase, it doesn't do the same for non-rebase
operations like cherry-picks. This is because the expectation is that
the user directly picks commits on top of whatever "HEAD" points to, and
we advance the reference pointed to by "HEAD" instead of updating it
directly.

We're about to introduce a new command though that needs to detach
"HEAD" while being more similar to git-cherry-pick(1) rathen than to
git-rebase(1). As such, we'll want to restore "HEAD" to point to the
branch that we started on while not using the more heavy-weight rebase
machinery.

Introduce a new option `restore_head_target` to do so. Persist the
option into the sequencer configuration so that it persists across
different processes, e.g. when we need to stop due to a merge conflict.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c | 24 ++++++++++++++++++++++++
 sequencer.h |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 7066cdc939..b13348ba34 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -413,6 +413,7 @@ void replay_opts_release(struct replay_opts *opts)
 	struct replay_ctx *ctx = opts->ctx;
 
 	free(opts->gpg_sign);
+	free(opts->restore_head_target);
 	free(opts->reflog_action);
 	free(opts->default_strategy);
 	free(opts->strategy);
@@ -3142,6 +3143,8 @@ static int populate_opts_cb(const char *key, const char *value,
 	} else if (!strcmp(key, "options.skip-commit-summary")) {
 		opts->skip_commit_summary =
 			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
+	} else if (!strcmp(key, "options.restore-head-target")) {
+		git_config_string_dup(&opts->restore_head_target, key, value);
 	} else {
 		return error(_("invalid key: %s"), key);
 	}
@@ -3709,6 +3712,10 @@ static int save_opts(struct replay_opts *opts)
 	if (opts->skip_commit_summary)
 		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 					"options.skip-commit-summary", NULL, "true");
+	if (opts->restore_head_target)
+		res |= repo_config_set_in_file_gently(the_repository, opts_file,
+				"options.restore-head-target", NULL, opts->restore_head_target);
+
 	return res;
 }
 
@@ -5177,6 +5184,23 @@ static int pick_commits(struct repository *r,
 			return -1;
 	}
 
+	if (opts->restore_head_target) {
+		struct reset_head_opts reset_opts = { 0 };
+		const char *msg;
+
+		msg = reflog_message(opts, "finish", "returning to %s", opts->restore_head_target);
+
+		reset_opts.branch = opts->restore_head_target;
+		reset_opts.flags = RESET_HEAD_REFS_ONLY;
+		reset_opts.branch_msg = msg;
+		reset_opts.head_msg = msg;
+
+		if (reset_head(r, &reset_opts)) {
+			error(_("could not switch HEAD back to %s"), opts->restore_head_target);
+			return -1;
+		}
+	}
+
 	/*
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
diff --git a/sequencer.h b/sequencer.h
index 1767fd737e..a905f6afc7 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -72,6 +72,9 @@ struct replay_opts {
 	/* Reflog */
 	char *reflog_action;
 
+	/* Reference to which HEAD shall be reset to after the operation. */
+	char *restore_head_target;
+
 	/* placeholder commit for -i --root */
 	struct object_id squash_onto;
 	int have_squash_onto;

-- 
2.51.0.261.g7ce5a0a67e.dirty

