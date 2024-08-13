Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6F9196DA1
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541531; cv=none; b=tB8Jyb8y/RldbC2SIXvdN5IOyMuLT6V3KEa6DfD2CxN07NCp/HtivxWB3XxgSYpqNVO2IBRISgQnjMvHxgi5cdn//YI9XamTNF2d4lnpPBd0fOMUEjzQVBWVLwCSAhdkivi+Gqlu/py5uNFjd65sC49pE+iOhFnva/HDUSBOgu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541531; c=relaxed/simple;
	bh=zkdr69ZWVgse8a8Aa0KV+OS9xu+UFHizWG8N0HufK7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9JhIcyTdrOVRA28v3QZ3MaagZseSAPFGGBnFaXccuYqgVCR903ko5AaHDHrH9NEyAxgnlt8a0TUoT+FKG52YuTFaLlBR2dKC3YNvVpb+S1N4vMj6rFbWxfoeCdVE8Hdw6ClpkY+tbzfmZxB4AriOBxHklAT1G9Bv8XYwuub7sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kREm6PgN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ifV4p47B; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kREm6PgN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ifV4p47B"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id B84A4138FCF1;
	Tue, 13 Aug 2024 05:32:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Aug 2024 05:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541528; x=1723627928; bh=XAUeetf7P2
	4rfZv6N44Ib1z4mOQLc5e3yrk7AJcS3Bs=; b=kREm6PgNJ7Vlg2BrGdE1AcYoH3
	Yz2YqmUn38Njc6acC6x6PlPTZmtzPSiqPs0f0dIWl3KCY2/BZjgUhiWa9UKkUKv2
	VI2OyGbIoB5KSiLGNl9B+5BAbjAdKbQ9iupkFb4m+gZ/BoJRgR8BPVKX7czvFiPI
	ONsPxGpZLXa0uLQ1+LCZ0ZoX8lvJo+87bI9FUCQ+Mk+/9JYf7kBtIhCdnLdBAKsm
	mJ1EXurEVOHmtw/KghT7wCHSVhhYoir8TXBtNv7IMLhPuAbSi0LlFgTq1U59n0/e
	PjFWyXRg0ikszByZqXDdSCd5t8ll/vjwCVEnnYaYnvqK+Xm5yizhlL7m0efw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541528; x=1723627928; bh=XAUeetf7P24rfZv6N44Ib1z4mOQL
	c5e3yrk7AJcS3Bs=; b=ifV4p47BbgmKMZye9b/PK82pcGmOlDYHaXxXI5UUYdvb
	qRN0lqezwq7rs4rBG0wAPE6GbeaG4DvdzfNAxsYTB2VCeiNyPf4wUjvTIU3VIrMN
	HTBKA6P21o8/sTxPeV1GkxahLvn523Lf6G/AJiUldXpyDcT0wXHuprThQz+wQmVL
	h1hAxP0+Jc3TOZbCHAAEkdoC2wwvYezj6fMn9y/KjgenKU99dX2rY62nAxepKRcV
	roE3pDlaHzMsmhafTQNtcL8llOOhR5PWK+PBiOCPa+Y09vf9lJ8pKvFgbmV/JzOu
	W17OSL0U7HKG7i54A60j/NqtKmIaDE4N5LnbvtQbpw==
X-ME-Sender: <xms:GCi7ZhwwKZR85l-5Np1JRhH90GdmDBz73IksO3Yg-wDd-z0dxg9Lnw>
    <xme:GCi7ZhTAiADsXFCYg7__vF5f0yJlLhkvT8AJ-4LqvazjYk84Dpy1RIwcKJrUXzpIq
    RKUZpwA4HgMoII-2A>
X-ME-Received: <xmr:GCi7ZrUYnHjDpzlu7CZxfqO6ONGkOn30iyd7CAGJB0YWU9JWKKcVm8RfgPqtX43YurMfG14QVhMZggVVSH1BA6WJrG2iz95-LuSNkrICL-8UdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:GCi7ZjiPaJqkyW6U1stivH_wpTPCuS4VA3m8D9G7nqEgupS1a9SB7w>
    <xmx:GCi7ZjAPFYNPvPJc5CRItOdKJ3EPIbrmoino_LYs34N6fUtn34asUQ>
    <xmx:GCi7ZsIzw9wyD6CcfHEuySG2UP0PI5RRzkr4wH6PDfFakjNFceSsJQ>
    <xmx:GCi7ZiDnEsWzBGJsgaLCG4dfSvAWiYfO8sF9_ebGIwc5teh_QDHWyQ>
    <xmx:GCi7Zl3U8uiunICSg_phs0CU-1HinBAD2u3Jg1iXh5MXjtc6T_2H6gn2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:32:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f684c4a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:31:50 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:32:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 19/22] userdiff: fix leaking memory for configured diff
 drivers
Message-ID: <39b2921e3e6aeb7bc5d6d08ed9861d26b738a42c.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

The userdiff structures may be initialized either statically on the
stack or dynamically via configuration keys. In the latter case we end
up leaking memory because we didn't have any infrastructure to discern
those strings which have been allocated statically and those which have
been allocated dynamically.

Refactor the code such that we have two pointers for each of these
strings: one that holds the value as accessed by other subsystems, and
one that points to the same string in case it has been allocated. Like
this, we can safely free the second pointer and thus plug those memory
leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 range-diff.c                     |  6 +++--
 t/t4018-diff-funcname.sh         |  1 +
 t/t4042-diff-textconv-caching.sh |  2 ++
 t/t4048-diff-combined-binary.sh  |  1 +
 t/t4209-log-pickaxe.sh           |  2 ++
 userdiff.c                       | 38 ++++++++++++++++++++++++--------
 userdiff.h                       |  4 ++++
 7 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 5f01605550..bbb0952264 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -450,8 +450,10 @@ static void output_pair_header(struct diff_options *diffopt,
 }
 
 static struct userdiff_driver section_headers = {
-	.funcname = { "^ ## (.*) ##$\n"
-		      "^.?@@ (.*)$", REG_EXTENDED }
+	.funcname = {
+		.pattern = "^ ## (.*) ##$\n^.?@@ (.*)$",
+		.cflags = REG_EXTENDED,
+	},
 };
 
 static struct diff_filespec *get_filespec(const char *name, const char *p)
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index e026fac1f4..8128c30e7f 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -5,6 +5,7 @@
 
 test_description='Test custom diff function name patterns'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-caching.sh
index 8ebfa3c1be..a179205394 100755
--- a/t/t4042-diff-textconv-caching.sh
+++ b/t/t4042-diff-textconv-caching.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test textconv caching'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >helper <<'EOF'
diff --git a/t/t4048-diff-combined-binary.sh b/t/t4048-diff-combined-binary.sh
index 0260cf64f5..f399484bce 100755
--- a/t/t4048-diff-combined-binary.sh
+++ b/t/t4048-diff-combined-binary.sh
@@ -4,6 +4,7 @@ test_description='combined and merge diff handle binary files and textconv'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup binary merge conflict' '
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 64e1623733..b42fdc54fc 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='log --grep/--author/--regexp-ignore-case/-S/-G'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_log () {
diff --git a/userdiff.c b/userdiff.c
index c4ebb9ff73..989629149f 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -399,8 +399,11 @@ static struct userdiff_driver *userdiff_find_by_namelen(const char *name, size_t
 static int parse_funcname(struct userdiff_funcname *f, const char *k,
 		const char *v, int cflags)
 {
-	if (git_config_string((char **) &f->pattern, k, v) < 0)
+	f->pattern = NULL;
+	FREE_AND_NULL(f->pattern_owned);
+	if (git_config_string(&f->pattern_owned, k, v) < 0)
 		return -1;
+	f->pattern = f->pattern_owned;
 	f->cflags = cflags;
 	return 0;
 }
@@ -444,20 +447,37 @@ int userdiff_config(const char *k, const char *v)
 		return parse_funcname(&drv->funcname, k, v, REG_EXTENDED);
 	if (!strcmp(type, "binary"))
 		return parse_tristate(&drv->binary, k, v);
-	if (!strcmp(type, "command"))
-		return git_config_string((char **) &drv->external.cmd, k, v);
+	if (!strcmp(type, "command")) {
+		FREE_AND_NULL(drv->external.cmd);
+		return git_config_string(&drv->external.cmd, k, v);
+	}
 	if (!strcmp(type, "trustexitcode")) {
 		drv->external.trust_exit_code = git_config_bool(k, v);
 		return 0;
 	}
-	if (!strcmp(type, "textconv"))
-		return git_config_string((char **) &drv->textconv, k, v);
+	if (!strcmp(type, "textconv")) {
+		int ret;
+		FREE_AND_NULL(drv->textconv_owned);
+		ret = git_config_string(&drv->textconv_owned, k, v);
+		drv->textconv = drv->textconv_owned;
+		return ret;
+	}
 	if (!strcmp(type, "cachetextconv"))
 		return parse_bool(&drv->textconv_want_cache, k, v);
-	if (!strcmp(type, "wordregex"))
-		return git_config_string((char **) &drv->word_regex, k, v);
-	if (!strcmp(type, "algorithm"))
-		return git_config_string((char **) &drv->algorithm, k, v);
+	if (!strcmp(type, "wordregex")) {
+		int ret;
+		FREE_AND_NULL(drv->word_regex_owned);
+		ret = git_config_string(&drv->word_regex_owned, k, v);
+		drv->word_regex = drv->word_regex_owned;
+		return ret;
+	}
+	if (!strcmp(type, "algorithm")) {
+		int ret;
+		FREE_AND_NULL(drv->algorithm_owned);
+		ret = git_config_string(&drv->algorithm_owned, k, v);
+		drv->algorithm = drv->algorithm_owned;
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index 7565930337..827361b0bc 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -8,6 +8,7 @@ struct repository;
 
 struct userdiff_funcname {
 	const char *pattern;
+	char *pattern_owned;
 	int cflags;
 };
 
@@ -20,11 +21,14 @@ struct userdiff_driver {
 	const char *name;
 	struct external_diff external;
 	const char *algorithm;
+	char *algorithm_owned;
 	int binary;
 	struct userdiff_funcname funcname;
 	const char *word_regex;
+	char *word_regex_owned;
 	const char *word_regex_multi_byte;
 	const char *textconv;
+	char *textconv_owned;
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
 };
-- 
2.46.0.46.g406f326d27.dirty

