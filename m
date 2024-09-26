Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315E21741E8
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351195; cv=none; b=pAp8ipznabtEhaaU/wjJ/hCbQwoiUFZQO4uvY5vqeEXxhmvH/hcwRRAWsI13fBQMj3Eo1V4pwdL2UT6qrKnn9+ikPlVLOsZdFaRG67SbhPCCb3t2KOLF4yt4aptqFiyH6ZfUAVoUAwcXUrMPi+Vpv3uDzFKPJ6YgJC3sY/MBxNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351195; c=relaxed/simple;
	bh=dSMRU7mg7mOQOJTQF32YVILsvWJIJ6V5NcWh/f89+bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=md5MaLlXCIse2t+7T/1CMcUbbIDqQwCneP3D3BdCQtsX2Evi57ByLYLHhRqN1Hh1pRPZKacYYdpCQOY8eTw89HPL6NFnllz2LN7vGtYayIkt/NQtHU0feti+pDVm1+NcDJLY8/q+e2vhofH/+RNOXKKGA1x3KEF5Px1rrCpdhPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UhgXhE4s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TY0MbfBN; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UhgXhE4s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TY0MbfBN"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B0661140252;
	Thu, 26 Sep 2024 07:46:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 26 Sep 2024 07:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351193; x=1727437593; bh=ytSLfI7Dzm
	dkNM7KV/93JBuGuC1mitUXoqti3Q24uRw=; b=UhgXhE4sdSNGfOaXwv21DQpf6H
	I3UjOBbiyGmgBEjlOJjWJQGeAdYR/98ao8nkYIPIAmpqqNU1sTOchvaF4t/t+4kN
	1UMxkQZiDfoLaJNMN+sFmd4WNqmmdzMol6TMes7YvkIgX8RwEz2loEMz7sx+AjzD
	ECXjmIwuEFhPYYzfTAdaUUPGWDNX49JK5/4+jxNeYuPM8IdBxCRuAppdKCL7bHyB
	t3+nMuO9PZA870hL4dXSlZIs6CK9KVToZjDkMRnsDJjlho7dfKD2TUGDpYX9ZVfz
	bPG+Jqs/D40C/YdKgQUR/VaS8zu4Jsh8Vl7QHwMvALzCMMl920Lc4j4up4OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351193; x=1727437593; bh=ytSLfI7DzmdkNM7KV/93JBuGuC1m
	itUXoqti3Q24uRw=; b=TY0MbfBNZkh5L4X5uwL1l39AqW/QaRGJVBAWmdDsRF4a
	6hIxIh1qspIcS1zORDxe+5aiOH+V14n8KIS+H/k/71xsXqGZ8ETL18JXm1yfgzW9
	dzRVEPPBo/VCOjQLqndbLdNSPddl5Pl+nfD+Pj6SLuRT8IOSXvdrNHYYwr6+6Y1y
	6iVVQqGmZypV/nHJTxfJQk1taQpxlSeHGppnHBplocsxweyF3iRRPDh2UlyjwV0c
	yqNstzvgBeLCNNXgQUJp+oVlew2IqfCI2lBmWu5DmPG11OnhP3peYoDRR/u95lMv
	fmyO4lsASFGe383MyENWq8iXYaMLOcEfiTck7ZVsLg==
X-ME-Sender: <xms:mUn1ZnMU_5Cyw3Wf1Gbe2rfjxGsfAydDiU7Y0Plpm_FqmdZFZ08kag>
    <xme:mUn1Zh8j9cRcjPc7ksj1wzHaJwSDVc_0ePFYUIs64s72b68bOO5_dr3auJ7ld63ap
    eOkeOrsbv2aX2iduA>
X-ME-Received: <xmr:mUn1ZmQm4lOjBsMEiUVfz9CC1P-_PX4k6cnfrEG6aQfJsqo5YzQSS-GmE8BGmHKY30EoKHJexPfdCMBWUg8QnT3z08DYt16kXZA9m1i4mfZrgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mUn1Zruc20YzhWNPv_ya0gsGDe85hoa-jnu3RdUeW_SPq_AUfPchVQ>
    <xmx:mUn1ZveB-VwoLUkDIEweeZoyICdP0zkhVDRz8rBC8Tn24PWZ0XM78g>
    <xmx:mUn1Zn3cmkOH-NFq8eXSbDtNuU7FRHVTd_AHQavw-Jjg7bEIzgtXxA>
    <xmx:mUn1Zr_A4QZ2AT8r3AoNEMJE61WuX8lqVdGUW1ftxaJUwwvKBbCdWg>
    <xmx:mUn1Zr50oUw8li3vaxhA4kCdfZ-bfIK5I6b06nh5XKhiiBgALJENvoLG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 64c58d06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:45:55 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/23] diff: fix leaking orderfile option
Message-ID: <cb08db4d3766e1bbe96d10798be6792f8f9ee19c.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

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
index 829a44e416..f6b624dc28 100644
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
index 472479eb10..6555b8a32c 100644
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
index 9901c8ca8c..b95d3c1e83 100644
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
2.46.2.852.g229c0bf0e5.dirty

