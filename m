Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0391F250C18
	for <git@vger.kernel.org>; Thu,  1 May 2025 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135300; cv=none; b=FDgD61rKMWUo9D5jLjW38sLdQmB3qFuXR2KestMVt5YJbxSzZDD6ZNf3R+9HaQAvQfgx6MZ2/KIb6bmK64w4hv0LqJA9BSpfzieVxez7758WvFRf1HNMW4Fm3EmjWxRQ31tiNOjSxsTeX6DdjcqDkISx8yZF0irCQ+R3k0iyCO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135300; c=relaxed/simple;
	bh=WmXs1wabU+HCbkrNVt/8r4mVvZvJcmN71Cs9K5T102A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4c+vw9th8JlCTqV9FAZpY285cmg5zTt/srzCVtdThtd5RrpKIve3VGpm4mlgGlrUHZkWXlR6WJKZkfuHmls+eTkr2onvtdOCtrFs0BHZpm6FEltqJh4Csl2D2p8v6Wya9XZ5/j0oiexvk/U7lNM69ZDAvKGYN5E29wmZb6XO4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QCfOYWZ6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YqMD9wZ6; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QCfOYWZ6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YqMD9wZ6"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0BC061380F96;
	Thu,  1 May 2025 17:34:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 01 May 2025 17:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746135297; x=
	1746221697; bh=U0dCZRDrFkvyjE4nny7l18JaLXNAHB9rIiZLGeKykp4=; b=Q
	CfOYWZ6MWm08stEpkCBFy6KcVfhPtmMfsfufplpma2Psp3ERSNvEOhLVcv16BT6q
	cdYJJrSucQxlJto6I8J5GZivcvTHXgi4t7mUnAJ9AP8IoQ5DtbEdIpwb5VrDQ5Ms
	AX+/da/J23+RVU/MC3svd7soxVVenlGsBWtW8dZ/fAOx15+bj99Mc72z+8Nl3A53
	yYnh1ybap2xChM/oYejwxFgDA/3sC8OFbzv/DwZKQch2cT6l4iX2CQ0LYV3h3Gn5
	koQOQEg7XT5oxOdmrcqUz9B2DzJRefKaxXxFFAQzmoQu9HRB68TUmvJwK8/lN9I5
	wtv7Qrk1G8KfjX5f+AWuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746135297; x=1746221697; bh=U0dCZRDrFkvyjE4nny7l18JaLXNA
	HB9rIiZLGeKykp4=; b=YqMD9wZ6NbAuhOAJ83RoM4asbWFYFgMg+GLu/eJnHvVh
	OQvrBPgNvNoWIJRkHG0HIxcVAgr8XStrJDV6Y1MKNBcnJxQzL89upnbg4L0/Uyr7
	Cl7VLHoJ0bG6Dw+3DDhv/XKGk2Rni8jcZLPxFhqFchM0cr6TsLEwYzt4C9u4ShPP
	1YwF2D/HzOsCi9GsOrHeVNi7vF0IAm750UNClrGOacGYmSKbXW9ucERoBaMYL0aD
	KpTScA7hoxMk0sVcigWKeLuSDEHfvGqxkOTttfhROXlCjxj7BET5BLH8Ib/TEA3p
	yafrCmR2ACO+YoCtVbmla5dZ8+Sl6+nqnN3QAlE2iQ==
X-ME-Sender: <xms:AOkTaEhzEOKgywXudDM2g3POnns9ScoP5YGW2erqXW9xoIrLm3cCDQ>
    <xme:AOkTaNDh6QabipzTpF2ldqB3l53urWkU2phtpuukPqlCqSx4r7y21l5s9fF0C8gz2
    c9vM8jS6wKlzoZYHQ>
X-ME-Received: <xmr:AOkTaMFdlpVBVKZDRdiodwdmuKw-uOe-uLs1BZqclzRaCzWXfuRAliScx42peaqwxZdFHzVWvoYq5MSwtphG-KQuaBRjiCPNikgT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AOkTaFS9ENqqJnMoaDRCXqFBfcjV-0GpE92IoSsWxNR8gB_SSRMBQw>
    <xmx:AOkTaBzZ7YAPcaMHLD3f1MInEko1rCvOeKdzGlnDuyMLBLTSLWF9xw>
    <xmx:AOkTaD41C4VJqQ_i7YXo3AbAv7RCs5HhRO26yd44qlpGvPuuHapvtw>
    <xmx:AOkTaOzwYAM9pbUelic5uORrDXGJhiKaonw2G74PURy5OPMLFZAq6g>
    <xmx:AekTaIjR6EhQNhll_bVE4K7gPtVtd5SXmH51iY9z7A4XZ0pXAX5SkXJ6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 17:34:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/2] whatchanged: require --i-still-use-this
Date: Thu,  1 May 2025 14:34:52 -0700
Message-ID: <20250501213452.370729-3-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-599-gc9a5c860a0
In-Reply-To: <20250501213452.370729-1-gitster@pobox.com>
References: <20250501213452.370729-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation of "git whatchanged" is pretty explicit that this
has retained for historical reasons to help those whose fingers
cannot be retrained.  Let's see if they still are finding it hard to
type "git log --raw" instead of "git whatchanged" by marking the
command as "nominated for removal", and require "--i-still-use-this"
on the command line.

While at it, update the documentation page to use the new [synopsis]
facility to mark-up the SYNOPSIS part.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-whatchanged.adoc | 10 ++++++++--
 builtin/log.c                      | 13 +++++++++++++
 t/t4013-diff-various.sh            | 17 +++++++++++++++--
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-whatchanged.adoc b/Documentation/git-whatchanged.adoc
index 8e55e0bb1e..d21484026f 100644
--- a/Documentation/git-whatchanged.adoc
+++ b/Documentation/git-whatchanged.adoc
@@ -8,8 +8,14 @@ git-whatchanged - Show logs with differences each commit introduces
 
 SYNOPSIS
 --------
-[verse]
-'git whatchanged' <option>...
+[synopsis]
+git whatchanged <option>...
+
+WARNING
+-------
+`git whatchanged` has been deprecated and is scheduled for removal in
+a future version of Git, as it is merely `git log` with different
+default; `whatchanged` is not even shorter to type than `log --raw`.
 
 DESCRIPTION
 -----------
diff --git a/builtin/log.c b/builtin/log.c
index 04a6ef97bc..0f98ac8a34 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -113,6 +113,13 @@ struct log_config {
 	int fmt_patch_name_max;
 	char *fmt_pretty;
 	char *default_date_mode;
+
+	/*
+	 * Note: git_log_config() does not touch this member and that
+	 * is very deliberate.  This member is only to be used to
+	 * resurrect whatchanged that is deprecated.
+	 */
+	int i_still_use_this;
 };
 
 static void log_config_init(struct log_config *cfg)
@@ -267,6 +274,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		OPT__QUIET(&quiet, N_("suppress diff output")),
 		OPT_BOOL(0, "source", &source, N_("show source")),
 		OPT_BOOL(0, "use-mailmap", &mailmap, N_("use mail map file")),
+		OPT_HIDDEN_BOOL(0, "i-still-use-this", &cfg->i_still_use_this,
+				"<use this deprecated command>"),
 		OPT_ALIAS(0, "mailmap", "use-mailmap"),
 		OPT_CALLBACK_F(0, "clear-decorations", NULL, NULL,
 			       N_("clear all previously-defined decoration filters"),
@@ -656,6 +665,10 @@ int cmd_whatchanged(int argc,
 	opt.def = "HEAD";
 	opt.revarg_opt = REVARG_COMMITTISH;
 	cmd_log_init(argc, argv, prefix, &rev, &opt, &cfg);
+
+	if (!cfg.i_still_use_this)
+		you_still_use_that("git whatchanged");
+
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 3855d68dbc..8caab2ee38 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -203,11 +203,19 @@ do
 	test_expect_success "git $cmd # magic is ${magic:-(not used)}" '
 		{
 			echo "$ git $cmd"
+
+			case "$cmd" in
+			whatchanged | whatchanged" "*)
+				run="whatchanged --i-still-use-this"
+				run="$run ${cmd#whatchanged}" ;;
+			*)
+				run=$cmd ;;
+			esac &&
 			case "$magic" in
 			"")
-				GIT_PRINT_SHA1_ELLIPSIS=yes git $cmd ;;
+				GIT_PRINT_SHA1_ELLIPSIS=yes git $run ;;
 			noellipses)
-				git $cmd ;;
+				git $run ;;
 			esac |
 			sed -e "s/^\\(-*\\)$V\\(-*\\)\$/\\1g-i-t--v-e-r-s-i-o-n\2/" \
 			    -e "s/^\\(.*mixed; boundary=\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--v-e-r-s-i-o-n\2\"/"
@@ -454,6 +462,11 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
+test_expect_success 'whatchanged needs --i-still-use-this' '
+	test_must_fail git whatchanged >message 2>&1 &&
+	test_grep "nominated for removal" message
+'
+
 test_expect_success 'log -m matches pure log' '
 	git log master >result &&
 	process_diffs result >expected &&
-- 
2.49.0-599-g90c2cffacf

