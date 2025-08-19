Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7DE322C87
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600969; cv=none; b=D4qqaADC1ONE30JcK1L8gpLsHijgVek7sh5rz06VUti/+tYXsmv82Ttl/+cNHyQ8v+RSj5sdYHI4Wsd4tKVWr7+j7EuLzwyBGy5E+3AG3JuzZcVQY8OhvfBtz/OKhMa6UY97jqMmK1tkWivRtSSp7L6XxZf/PPyk4wqHm/dn+oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600969; c=relaxed/simple;
	bh=mCvyNH4Xc8xBwKJt24vv7GBkn/CufjL4mTEHyRnxoQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B6lpnFEFYwco+ctnL8aMkPpC6is0aieqat4HJA+MUzGHNHo5Kf6hVWaeZJPOhcY9PzEwjLJNzxpEDYU6+eEGHp4Oy7d1+SGh2Savk0Rx/vgyJ+5zjHqitjXA4WC6t7PWCRjp530yqX3FAukAs88C2tthOCYFAWDx/oNCn5MsvGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q99oLw8r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IMkQxNOn; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q99oLw8r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IMkQxNOn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 09D997A0224
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 19 Aug 2025 06:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755600965;
	 x=1755687365; bh=tUMeKfFb7K28Kh8QOekJVXvhUsYnAhBCF1Jc3EzfHlE=; b=
	Q99oLw8rPjxE9Fjur36zY+ZTJyH7Z1SxgcAZIl0epw8jP/WMPyb8ueZkkq/okzVr
	gLWbqgY/14rH5oJ6IvmrdObubPBb5a41fGPj2fzsrdtEQOPb8ZI34XEvf3endpY5
	AcYf90TABfwzfjaK94VJQ2xxrnSZCdytxtL77UqUHGgy+BXzsYlEvYbApjjdqjlV
	4zvF+qRJ+xEj9ht/RuCw8BIAwnSDqq6Yn7Eox1FJMOcz/EzOhnKV9zM4JiPMV6I7
	CK5dT9ArAYy+zbkm4/OKQPCnsnKMee3xozGHGBuMerH1ls9OOZbblx3TBR2oOG7U
	qP7Fb55A4GT5PfETt+bl5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755600965; x=
	1755687365; bh=tUMeKfFb7K28Kh8QOekJVXvhUsYnAhBCF1Jc3EzfHlE=; b=I
	MkQxNOnoWc7vLWdJuRoZeuVcsKWkJ5K+FRCOR1xSquFkzvK5qHG9kJNjdv+7rwto
	bZYcOoasJIebyKvsq+DYf001JE8U2DTDZAqOJudTyAR27CiMMy6sOzzamvPJ25tB
	LejDHLxj6qONln5res3MS+BwvKeZWuaOWdrpN2f2Q3JctNN55QJAh0XrzUAUGvSG
	Zc5yhu9dZV0jtLSLP20PTdn4zrD+4qp83+ameYDM57PD5BZ2lyZ6SUX315SNP0K/
	zp5Xx6eVrakud0XHm8FKwvIBglSi1qRD7p0EhFUPJSo17JHJpaNrznfEpHpGW1lu
	77RB0vjkup1ImZckk+Yjg==
X-ME-Sender: <xms:RVikaBrcEDzbkBGUPaF_RjBSvZePbbMp7roNHmo3sINq2PH9D-Z1lQ>
    <xme:RVikaFp-B6loFaIQ8E9kZTtMJ0pJvNTPBim3fn_VJmp7Re7SBq-vNA7y8qfpJ_cP-
    _E3XyYZ8H3ub059xA>
X-ME-Received: <xmr:RVikaHkpI6OA2oJ0vVWMHPBqwUoPH0eHnkyZ5Sn-vyuImuQ-XwLBoXET8IcWfl2gSDgT8B3wC63h6NIpVtMwrFKfbjuuDYiAxhGL_pcFCEvZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:RVikaPFT7NcOPjYP1Ud0Ld4Ep89JNQXscRahzh58AppsyfKan_W_5A>
    <xmx:RVikaIow4WQSGR3VfTvMOYN2ElaGZaVBFqVJZYrEx8ej577pRAYuJg>
    <xmx:RVikaD6wtL-keuhqiXVUNVibtfbDib5Gut62ug4Yia3qoHyIEDcCig>
    <xmx:RVikaO5dAgz5ZRjStMfO_hcvosw2YQg9Hi3m4YLApRXyVk-22O-k8w>
    <xmx:RVikaCBXCOd6t4ws3WEJehRFuRxnC7SPH8dNCy5X332xZGh9MIVnsPpp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f75481bf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 10:56:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 12:55:57 +0200
Subject: [PATCH RFC 01/11] sequencer: optionally skip printing commit
 summary
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-history-builtin-v1-1-9b77c32688fe@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
In-Reply-To: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When picking commits by using for example git-cherry-pick(1) we end up
printing a commit summary that gives the reader information around what
exactly we have been picking:

```
$ git cherry-pick main
[other 76c8456] bar
 Date: Tue Aug 19 08:07:26 2025 +0200
 1 file changed, 1 insertion(+)
 create mode 100644 bar
```

While useful for some commands, we're about to introduce a new command
where this output will be less so. But right now there is no way to
disable printing this commit summary.

Introduce a new `skip_commit_summary` replay option that does so.
Persist the option into the sequencer configuration so that it persists
across different processes, e.g. when we need to stop due to a merge
conflict.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c | 12 +++++++++---
 sequencer.h |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index aaf2e4df64..7066cdc939 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1742,7 +1742,7 @@ static int do_commit(struct repository *r,
 			refs_delete_ref(get_main_ref_store(r), "",
 					"CHERRY_PICK_HEAD", NULL, REF_NO_DEREF);
 			unlink(git_path_merge_msg(r));
-			if (!is_rebase_i(opts))
+			if (!is_rebase_i(opts) && !opts->skip_commit_summary)
 				print_commit_summary(r, NULL, &oid,
 						SUMMARY_SHOW_AUTHOR_DATE);
 			return res;
@@ -3139,8 +3139,12 @@ static int populate_opts_cb(const char *key, const char *value,
 	else if (!strcmp(key, "options.default-msg-cleanup")) {
 		opts->explicit_cleanup = 1;
 		opts->default_msg_cleanup = get_cleanup_mode(value, 1);
-	} else
+	} else if (!strcmp(key, "options.skip-commit-summary")) {
+		opts->skip_commit_summary =
+			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
+	} else {
 		return error(_("invalid key: %s"), key);
+	}
 
 	if (!error_flag)
 		return error(_("invalid value for '%s': '%s'"), key, value);
@@ -3698,11 +3702,13 @@ static int save_opts(struct replay_opts *opts)
 				"options.allow-rerere-auto", NULL,
 				opts->allow_rerere_auto == RERERE_AUTOUPDATE ?
 				"true" : "false");
-
 	if (opts->explicit_cleanup)
 		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 				"options.default-msg-cleanup", NULL,
 				describe_cleanup_mode(opts->default_msg_cleanup));
+	if (opts->skip_commit_summary)
+		res |= repo_config_set_in_file_gently(the_repository, opts_file,
+					"options.skip-commit-summary", NULL, "true");
 	return res;
 }
 
diff --git a/sequencer.h b/sequencer.h
index 304ba4b4d3..1767fd737e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -52,6 +52,7 @@ struct replay_opts {
 	int keep_redundant_commits;
 	int verbose;
 	int quiet;
+	int skip_commit_summary;
 	int reschedule_failed_exec;
 	int committer_date_is_author_date;
 	int ignore_date;

-- 
2.51.0.261.g7ce5a0a67e.dirty

