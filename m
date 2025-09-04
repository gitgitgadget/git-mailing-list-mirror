Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAA2308F25
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996064; cv=none; b=LuIenEDEs6RPL5O1EjGkX/BIh9z/GCQz1wY8fDxH1U5NKf1RrsoSBf7kJsQyAgDbB/RNDqCibcrYASdz5CAn0LTNBFYOZTDrb4hTKV2vA1/Qja+fzdCVa2t2cIOEsThdUMuYFDAZjb8cMPgGWqy3KCaHDWIk1ZS93CZVS0U8z6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996064; c=relaxed/simple;
	bh=r2/LbT9giR8dl5drwGgO/20BKniZv/Yg0vNiWYcPq/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PzBsWoxoim5kdOEYmx665dG7OGNxrN/nq90+m71TiP5VHg39zSb9ACzjkTf9MJ3cnhChWFWt22Lulr2GUBNJjbzG4PL5kroByyRvlSewBsYOH4QZfu5NJuUuS9KXqJQG9JbXIFlptyyrE/BQ/SXr7PVKwPDr2vpY7mrwHO45jlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IqzNXCk3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dYWtx8HS; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IqzNXCk3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dYWtx8HS"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 7BC191D00291;
	Thu,  4 Sep 2025 10:27:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 04 Sep 2025 10:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996061;
	 x=1757082461; bh=SBUm+WwHha1zVooYDilxZmAw7jEv2t5uvpv6ppWRxC4=; b=
	IqzNXCk3P51igvoaWq0zu18wDcgMddC+AuvhSfpSFu8gGGlwSeqGtpV6xI8L1eYZ
	kyXra6LdE2h0Zv0Mg5Vk1Q3xmbiNYGij5m6LGU/xaWg3FosKEaQytq87vsDANNTr
	KwvBVmPDT6qI7vzRvQd4okGLzBK8H2+jb6pB3AzTApP+qyhTvheF2Q7MwhY/SQ+k
	gF2Y+dvcLT0bzblRhxcr/6fB0qgamQs0vGEMPc7n4hWxdGT9721UdsUgfKrSIvzH
	Aty25T4alVcUL5wg9ANszYInbqP+aQaZBXbExvPLvJEoblu/ofUB3DkJ0k2OnVUr
	xw8CiQSmMCSw3ENq7dMmLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996061; x=
	1757082461; bh=SBUm+WwHha1zVooYDilxZmAw7jEv2t5uvpv6ppWRxC4=; b=d
	YWtx8HSjfvov8LK/d+zURLryDJKpe0iwwVcbZz+nkhUHHq4mvhmeC1ngjQHARqFP
	zZnO0mFmKTo72WpOrx8jWRkF+ep1L3XK6hSjRwowVkZwvfe776oo/jQ5248aQVq+
	fK+Ki0rxBMG3fpuOcTERo7hrXSvQ20j2KuaPaQT4nFj42AdAbn1ErAluahuPZW2u
	DAf6e86Ji1MSJRnKA8jNBcbQSrGiHNVYgWeFuvmfgOzo/+bIQsJ3Nt/gOq3hBokD
	fOzMsydRhw0wCSLT2RWrQdG8jqmzHz0r1v9IPS5AdZ5DnZxHxIoD+ZF8NVc+Dz2g
	xSbWFCRUs8qHUK1Te3GMw==
X-ME-Sender: <xms:3aG5aBTZSNVq-LQ_keJpLDokBNFHq7VRU5akEbP1beb--_IYRVJjAA>
    <xme:3aG5aIVBwKT4oJ1doSzPXCxH64Kg17zuT4TvvA-cv98FTEDGig4z37yZ_uLlWosOu
    gMiH-9txeT6aqjTPQ>
X-ME-Received: <xmr:3aG5aNTRBCzaXlJqfXSlOXGqDBOrDyL7INsUeK58QJFv8q9FEs8RquWrRvfUbwyvilvza85EdBssOtPv8z0ypcloUrn1ivu9l9KyMZlOF5PuZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnvh
    honhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhope
    hsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghl
    vgesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:3aG5aKmjtqHUGVW_idQ7uh5Lzop_DqMPPvr60KNl7XYHlBpO9GTGvA>
    <xmx:3aG5aL7k5rGrKTL74MASYAqYq2av9wRgOu26A-DszyooCj-67-9tsA>
    <xmx:3aG5aIh01EdxFg8bqVjRoQxcsuWzwFxPDWXHMl5xcOTRvEAVtqNYHw>
    <xmx:3aG5aAHJ8GEO4rvULsK6HQhmXfc5V8yCc3vjYeOe9PbzeSGZVod9cQ>
    <xmx:3aG5aON5u0fZzCqaaabX7hDs3esk4wABUIvuav8Q7Pd8fATZjt9BnZBx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:27:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ff0ca998 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:27:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:27:31 +0200
Subject: [PATCH RFC v3 01/18] sequencer: optionally skip printing commit
 summary
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-history-builtin-v3-1-509053514755@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
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
2.51.0.417.g1ba7204a04.dirty

