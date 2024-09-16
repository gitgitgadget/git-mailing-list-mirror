Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173F6156250
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487160; cv=none; b=SeA4OGJcFez8UHjvejU7mPYVGjt2DCe9FA+HikeKAqiENWfEYvJobS2vlotidRQzFL7mtT7IqvZe7w5SsA3ZkIKOCOCSx3e5oLYdJo4X8iAwnh/rYeqOH/hgaXUPuKj9TZc+z90NNKQLt/xq+tMtYB3XV2lJze8X+MYjyGCR2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487160; c=relaxed/simple;
	bh=GeSU4ZXtpv1wE7aP0bu80NfK5GtkljPO7rmvLXvo6A4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3vjWEz+tokHHFCEPyf2qFDIQCRnq5Q5RGG8yx/pb78YM37L8mx0et9LG4HQOhVxi0ssnqFPJe+vP4JZkrRsvAwdlyA7nCN2Z3JcGitni67SP2cX5fCV2oaClFaHPjK+eelKScyPGThH2n3GmJxXaU22Gc5GOJXoRBTmxB7XKRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RjvX76/f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lM+5ku6f; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RjvX76/f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lM+5ku6f"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 276471380258
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 16 Sep 2024 07:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487158; x=1726573558; bh=pblU4lesaa
	WgHNcH9w96hXIDioD0VC5WLspgVWRhBOY=; b=RjvX76/fXrERMW29u8F6hB9TXc
	ptb8GQdHnw3EuA51j8YwMATO5t4ZHfkxl0Q4ih/9oiYxuEzO1+wPV9c1iwK/U/sb
	mCE7Z0bzcQMr5m6hYgdH2mS7PfX7KdqjHVst9K0be3ynKzS4iDhx5Y5xiXRLlZbM
	iZGS97fs/Qymml5DZ3pzjc2Ia/5h9RRy4EmlI0mcWsiEnB5epxAmpXpvNOQlLfs2
	bgeF8gNTln+/yMBNGaetL7qWSIwaPZTzgnD9wxYjRRzm2s+1bgc4WdcZpYYAx76u
	FJqqR3XESWqvyN2I6S31jzjmE+7bvMR9l0zYG1p4XDExFd/AbIr5QkKBp4+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487158; x=1726573558; bh=pblU4lesaaWgHNcH9w96hXIDioD0
	VC5WLspgVWRhBOY=; b=lM+5ku6fENGLg8hFok5ICCEFhJUCMJnEX3lhryulnjts
	P06TpmgUu3s6gXpcuMPwRgEoybiIcLatHBxv+KvgohlDfvIiAhOwpXLFt6hWgp6b
	63h0xS3yAJFD/N+xieRwpJpIj+HYFicqo+F16Q2hDEj+vUiFRCLb11n7sVQWj/o4
	bF40wjSnkX8xEYcqEaZcw5GxFQ2gAwoAP0baYOq3CDlbo5s9JeZa/4YL2mcnSF7o
	BBcbN5Amawz3EbdWRMd6D/QfjrWXQS9pZ6rJWDGl0uutAolUTjn72rZmx7Icia+P
	mD37+YlBmhqkaUnPPCnuTE3FD6PzIYA7Nav45qxc7A==
X-ME-Sender: <xms:dhroZthVwJ8yL7rJm-EvRoINP_RSBK66IVI0h3Xeu23tco6w6Ug3pQ>
    <xme:dhroZiC5Go1SPa5l0gBRiP2MWtHUrI2w_Pe6PQmXmRWxeZiXE1iSY2kOTLPL_UHn0
    8VW3G4WO1TTs_J9bw>
X-ME-Received: <xmr:dhroZtHqk3fvt_6NhlGeC0GqibIazLM-B-qdLpjpcvzamvrW1DF9IHYnMYXjwGE-rh-V633YXT-oBtgdwdLZSXalvf3wMMBXrT9_dtoEkfzUhM88>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dhroZiQtgsqEoP4KO07qlQXHabbjA6stpGkbHj1ITOGnWZQA-hg71A>
    <xmx:dhroZqxUbz-NvjJ2zO8XyQdnuAs6VPrqzOtOAIi1r5_74yBzPmR6fw>
    <xmx:dhroZo4x8L-BYMe586gWjMY3mrzYvIzsfEfl9J49CDn8FTzaN6P_EA>
    <xmx:dhroZvw-UMv2cuTYIo8iDiNOwUF3m3gxYa16BeNo-zuzAkEJ9gEU0w>
    <xmx:dhroZvo4XPK4E86fjjpzRT3X8n6Sedb-NyIMRYeUp3d1gGCQ87j6aPE->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1902229b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:40 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:45:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 11/23] diff: fix leaking orderfile option
Message-ID: <85c0f9e5f598cc65d1c03f6622900bb950a31159.1726484308.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726484308.git.ps@pks.im>

The `orderfile` diff option is being assigned via `OPT_FILENAME()`,
which assigns an allocated string to the variable. We never free it
though, causing a memory leak.

Change the type of the string to `char *` and free it to plug the leak.
This also requires us to use `xstrdup()` to assign the global config to
it in case it is set.

This leak is being hit in t7621, but plugging it alone does not make the
test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 combine-diff.c | 3 +--
 diff.c         | 7 +++++--
 diff.h         | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 829a44e4167..f6b624dc288 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1393,9 +1393,8 @@ static struct combine_diff_path *find_paths_generic(const struct object_id *oid,
 {
 	struct combine_diff_path *paths = NULL;
 	int i, num_parent = parents->nr;
-
 	int output_format = opt->output_format;
-	const char *orderfile = opt->orderfile;
+	char *orderfile = opt->orderfile;
 
 	opt->output_format = DIFF_FORMAT_NO_OUTPUT;
 	/* tell diff_tree to emit paths in sorted (=tree) order */
diff --git a/diff.c b/diff.c
index 472479eb101..6555b8a32c1 100644
--- a/diff.c
+++ b/diff.c
@@ -441,8 +441,10 @@ int git_diff_ui_config(const char *var, const char *value,
 	}
 	if (!strcmp(var, "diff.wordregex"))
 		return git_config_string(&diff_word_regex_cfg, var, value);
-	if (!strcmp(var, "diff.orderfile"))
+	if (!strcmp(var, "diff.orderfile")) {
+		FREE_AND_NULL(diff_order_file_cfg);
 		return git_config_pathname(&diff_order_file_cfg, var, value);
+	}
 
 	if (!strcmp(var, "diff.ignoresubmodules")) {
 		if (!value)
@@ -4775,7 +4777,7 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 	if (diff_indent_heuristic)
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 
-	options->orderfile = diff_order_file_cfg;
+	options->orderfile = xstrdup_or_null(diff_order_file_cfg);
 
 	if (!options->flags.ignore_submodule_set)
 		options->flags.ignore_untracked_in_submodules = 1;
@@ -6727,6 +6729,7 @@ void diff_free(struct diff_options *options)
 		FREE_AND_NULL(options->objfind);
 	}
 
+	FREE_AND_NULL(options->orderfile);
 	for (size_t i = 0; i < options->anchors_nr; i++)
 		free(options->anchors[i]);
 	FREE_AND_NULL(options->anchors);
diff --git a/diff.h b/diff.h
index 9901c8ca8c8..b95d3c1e830 100644
--- a/diff.h
+++ b/diff.h
@@ -235,7 +235,7 @@ enum diff_submodule_format {
  * diffcore library with.
  */
 struct diff_options {
-	const char *orderfile;
+	char *orderfile;
 
 	/*
 	 * "--rotate-to=<file>" would start showing at <file> and when
-- 
2.46.0.551.gc5ee8f2d1c.dirty

