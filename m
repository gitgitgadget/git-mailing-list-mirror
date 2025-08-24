Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8432DA767
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756057365; cv=none; b=XtNnaf7FviXDa/ts9Qe3C+CCdGcbzmZ94NuN1tc47GAwGP1I+tZI0ij1wp1XNn3g5s8CJsHjU0KPbH9GbK2n0Ke08iXp3tAZGsqo4UamhMaU2hH1a6B671eESFGpugA3mhIzNw2qiWajoB2F4gbRkM+4g2NRvDVfXmA9qQn2ASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756057365; c=relaxed/simple;
	bh=WdEebybiYgE9tOeRACWSta8mNmbzUnibF1GfG9lOyQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=thjsjWFHVlCloE6DX094aEjrTzES5bQJthACXNz+Svh5oBGrsw7DcDJCRsWhkyJvs310/+rTDpP7aHxmNsa1v4TaYW5zd+ok91YadrKM3goJizY6QJV7/y/S4THN2HdyfD2U0Sn30RKQ8GfmddnVJKfI7dLLVWVlRa+4bj2CUg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JflOyDjz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MqUREnoW; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JflOyDjz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MqUREnoW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E98AB7A0092;
	Sun, 24 Aug 2025 13:42:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 24 Aug 2025 13:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756057361;
	 x=1756143761; bh=BAVsGpqOm6veKHS4Rt5+pxyKtC8+0S5pxPRNWeq67AU=; b=
	JflOyDjzpZMNoZxiK8GLMFvkaMb4fVay5tsdQGdNxVbQBQINMRVkMnjPAari7Pe3
	NEJSSBD5eYd5kxlqq6v1P5aqodwY7/VYzrY3z1Vu0e6LgEjeBxlTNNKJ0mc/CRHP
	e26JW989CY0odhS00m1nzybvjQj3aqc9i4A5Axh/TBh79w8WZk5aN6wczbyux9g3
	VDS+PDftK+I3sTFdV5tDEKLgnPWzRFzZwaysdC2uznYTIhQShnSOjOIoHSi7eU37
	MDpMSey80TbgVghzc2mffgQNm6tuXnEtfsWFQi3XzecD04ptaW7e8lxfO+shJ6UT
	WP+9CjSAV0YCbj2EjW7Abw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756057361; x=
	1756143761; bh=BAVsGpqOm6veKHS4Rt5+pxyKtC8+0S5pxPRNWeq67AU=; b=M
	qUREnoWj/F0trgIctR1zf+bgwchxJCJ6Z3Tu/UFZHxsnF0hCroRis75/8aFXgKas
	mRz4+eQc5+yJrgzr0QRJ3N0gQ2FM64Rno2hBRQVAoz1kFDlndJIP/VuDIISZbGq/
	hHFTc2turvkUeeQYyeK09XfvTYnbkCVGucMOun+YQQvYCTFBY97aHMDPKdKUbfVc
	/dgmu6tLKknZ5PEmEfdsWVoB8dEg9KpQqCvzzqTIUelIzzxQiYoWltRmKmfcwnuD
	uUE2Nm2qFFlPSG7uWsmxxHiH+OGbPxwEy0E6i4v+GcYUQw6AHMXzkOU2eYl54YEx
	q7q5aRA6+BnPeEZKBSvAQ==
X-ME-Sender: <xms:EU-raGKg7QGzZrOjZ8vhso0ctXSMek5pPTke4uypjQBy2fMMs61Umw>
    <xme:EU-raLsx4RELF14eEU9uQLafjkRT1hhZo9ipxxTIdh0Vtuy51PhgZ1q4AAj_kxXMV
    VRdJve9qmlSYAs2Dw>
X-ME-Received: <xmr:EU-raNKco4BhCn7cTFSkDAmhGo3Eud56_dMTlH4ELDH8h9R4x9yHSGKKIBVTaZXTTVU1zfd2d1YTadHxYGXuduQhs4xyL0PMnK5nw1uT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshho
    rhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:EU-raM9F27knkm8sdGhNJ8oF-XVj5muiXZrxVSqH-kg2AI6X5pWK0Q>
    <xmx:EU-raOwSNlLdjxDDnyM0FBLBji9MwInbYjzhRfkDEeeN4loW5VYMyQ>
    <xmx:EU-raB5ycCMijc4og6wOKftgFhfVWiVx8W1Su_2l6oYrhnlnbnqiQg>
    <xmx:EU-raN-FeOMfju457jIZMWn_1Tf7Eq6hg7ViPaLfNVd-1XERyDTNyQ>
    <xmx:EU-raBnjO-Hbftq93gF2pqnHn9HJLbvkyONvw4cANjCdb168FJ1Ah1qs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:42:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 09cc1e6c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:42:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 24 Aug 2025 19:42:14 +0200
Subject: [PATCH RFC v2 01/16] sequencer: optionally skip printing commit
 summary
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-b4-pks-history-builtin-v2-1-964ac12f65bd@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
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
2.51.0.308.g032396e0da.dirty

