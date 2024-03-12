Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C308814293
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 23:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710285371; cv=none; b=q8ViZrTkmaiy1bdJQVNXfBlbltqvnZe+prsv/DyIHnAqOFz5DdHcR2b1Q8i6c3dcEZ+a1098sLKEH4KVdJIrlJRgjaqboAy7S6aErLqNtU/yJh1TPD10tJ64PmCiVMDrQsQXhKXw4mh7sTNdKUpnjDoy6hzD7IM4NTsE+Lh5Fes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710285371; c=relaxed/simple;
	bh=TO+GScYFGrJEh0HEOLGCQvxGtl8WZ0Ja4ni70lnJatQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qKbZNrQdVJGGkQbM+0McSaQI8RNwyLdDejI90Tvz3vakc/iN1HZJ+yvKLQQW4a7LA8yifHRjvYFjcJz/05b4Ftc2mMlzM+Z2pCvOiLMlKS0p9TjFj01QWkAmyfibfBENXWqSgGq4ACVORQboNZow6deQVxTtXJmuLR0PiOWIv3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=F4bNOCsS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cMuV+h4n; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="F4bNOCsS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cMuV+h4n"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id BC20C138012A;
	Tue, 12 Mar 2024 19:16:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Mar 2024 19:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1710285367; x=1710371767; bh=VUU9n2ojC/nyuQSXa7Al1
	NE6nCCYSD31CxDz9cjnP6w=; b=F4bNOCsStXXj47GeuovlF+3b4Bhs/o4zZ7CUm
	43mwse+lANLRxisDdqIBukqj0LS0LyTlQ2V1EqdpSXGiy6cH0nmAoZVzmis2P8TL
	xsQ210Ke/7RMSv/5peyTGSgAtBrZ1FrpC61wfbL6amrRTa73bX1petAYnXWch5tl
	gs5NPWhlR79C/BGcyRx2e0Y6QGizRz66RNrgN6HH3wZZyjDwbyQSkN99yethIzRs
	+T/Q+kb4K0OBRe9i48QU2a5ThRSfFrXtZgswEIpKoBGcSXtp5Ln8khGkMd4rap8g
	7eCkYqmq8gSQvqI+Nh4LfyTB7lqWUZn9iO93FcetVudZwVIww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710285367; x=1710371767; bh=VUU9n2ojC/nyuQSXa7Al1NE6nCCY
	SD31CxDz9cjnP6w=; b=cMuV+h4nzE9WdyQwPA8t5q5EzuWG6hSxjox0bEmpqxN6
	bBmGKDF9X10ZsUlUvHjlN44OCgvRF+pO5S651Zfre8lP0GdjBEd8mT6zPRyVTq0q
	AigpF36WunEdx8yfNcpCcHKOaPF45VLVpSGFtxLXQOed3TQ5BBjrQ9RVVAl+KfQT
	1raQpKSOFng/5TWwIMHfN0e0ZHhfYnF/pQf0s8Oj5YPR4BJ0bsAWmfOm4jtIEe+n
	u4vPWBM6LMeIeEr6+c776j3uFT1kOMdwgw/fyfa+VxlXTEDSDfFtDOwE+2pHiObr
	2+xCIOTtxUPzIr5Lh0YYDCucmeK8onRoCST13Onrow==
X-ME-Sender: <xms:N-LwZYUjpcVxTSR8VbSk3-hoEO2Dk_jnk_YxeO0xvKtmSoyE0tzhBA>
    <xme:N-LwZcm5y-Fs-LEsEpyrg3pE68rYulEkGYM1xUYHwLhTY45kbOIgEoV0mKCP4xhag
    hdeRKTueTWLiqWgtcs>
X-ME-Received: <xmr:N-LwZcYIVbeiyoNvUsUj6-GXFCyDASIVIWZODpxSWdj5waIJXSgfmDx_nUB3pdEng5GYAlHkWhaOxIf3s2sUG3wfF3ZA3_YKOTy->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeeggddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgvrhcu
    jfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvghtqe
    enucggtffrrghtthgvrhhnpeefleehgffhgffgieduveejjeejveetfeelhfdttdevueek
    ieeltefhudeufeeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:N-LwZXUMgoQZV5FatXQopHhhRjTSX9CdKr3qDbkl2iXPiU-8FRSL7g>
    <xmx:N-LwZSkwsHBYS-LQMU2nJFNDg0IgmfrMr5ZeEraOgWXEpuLvWxmTPA>
    <xmx:N-LwZcfz-7qvcp0BvxIoqyp5pvVzGkS-cH0vA3f_Wi2u8afKQT_nvg>
    <xmx:N-LwZUEnXbqySoiS-Gi8hhat9V7YVVSseOoCH3fSLTA1dEKKr2-j8Q>
    <xmx:N-LwZZvjMlLOTUnEhb7baEtcP-anPyMYovnXveUU5UnjemJozAp03Q>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 19:16:04 -0400 (EDT)
Date: Wed, 13 Mar 2024 09:15:59 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, David Heidelberg <david@ixit.cz>,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v3] diff: add diff.srcPrefix and diff.dstPrefix configuration
 variables
Message-ID: <20240312231559.GA116605@quokka>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312005756.GA3029606@quokka>

Allow the default prefixes "a/" and "b/" to be tweaked by the
diff.srcprefix and diff.dstprefix configuration variables.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
Changes to v2;
- doc: change to camelcase diff.srcPrefix/diff.dstPrefix for
  consistency with diff.mnemonicPrefix and most other options
- git diff --default-prefix forces a/ and b/ regardless of configured
  prefix, see the 'diff_opt_default_prefix' hunk in the patch below.

The latter may be slightly controversial but: there are scripts out
there that rely on the a/ and b/ prefix (came across one last night).
With a custom prefix those scripts will break, having an option that
forces the a/ and b/ prefix helps. Plus the man page explicitly says:
  Use the default source and destination prefixes ("a/" and "b/").
So let's stick with that behaviour then.

 Documentation/config/diff.txt |  6 ++++++
 diff.c                        | 14 ++++++++++++--
 t/t4013-diff-various.sh       | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 6c7e09a1ef5e..afc23d7723b6 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -111,6 +111,12 @@ diff.mnemonicPrefix::
 diff.noprefix::
 	If set, 'git diff' does not show any source or destination prefix.
 
+diff.srcPrefix::
+	If set, 'git diff' uses this source prefix. Defaults to 'a/'.
+
+diff.dstPrefix::
+	If set, 'git diff' uses this destination prefix. Defaults to 'b/'.
+
 diff.relative::
 	If set to 'true', 'git diff' does not show changes outside of the directory
 	and show pathnames relative to the current directory.
diff --git a/diff.c b/diff.c
index e50def45383e..108c1875775d 100644
--- a/diff.c
+++ b/diff.c
@@ -62,6 +62,8 @@ static const char *diff_order_file_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
+static const char *diff_src_prefix = "a/";
+static const char *diff_dst_prefix = "b/";
 static int diff_relative;
 static int diff_stat_name_width;
 static int diff_stat_graph_width;
@@ -408,6 +410,12 @@ int git_diff_ui_config(const char *var, const char *value,
 		diff_no_prefix = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.srcprefix")) {
+		return git_config_string(&diff_src_prefix, var, value);
+	}
+	if (!strcmp(var, "diff.dstprefix")) {
+		return git_config_string(&diff_dst_prefix, var, value);
+	}
 	if (!strcmp(var, "diff.relative")) {
 		diff_relative = git_config_bool(var, value);
 		return 0;
@@ -3425,8 +3433,8 @@ void diff_set_noprefix(struct diff_options *options)
 
 void diff_set_default_prefix(struct diff_options *options)
 {
-	options->a_prefix = "a/";
-	options->b_prefix = "b/";
+	options->a_prefix = diff_src_prefix;
+	options->b_prefix = diff_dst_prefix;
 }
 
 struct userdiff_driver *get_textconv(struct repository *r,
@@ -5362,6 +5370,8 @@ static int diff_opt_default_prefix(const struct option *opt,
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(optarg);
+	diff_src_prefix = "a/";
+	diff_dst_prefix = "b/";
 	diff_set_default_prefix(options);
 	return 0;
 }
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 1e3b2dbea484..e75f9f7d4cb2 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -663,6 +663,41 @@ test_expect_success 'diff --default-prefix overrides diff.mnemonicprefix' '
 	check_prefix actual a/file0 b/file0
 '
 
+test_expect_success 'diff respects diff.srcprefix' '
+	git -c diff.srcprefix=x/ diff >actual &&
+	check_prefix actual x/file0 b/file0
+'
+
+test_expect_success 'diff respects diff.dstprefix' '
+	git -c diff.dstprefix=y/ diff >actual &&
+	check_prefix actual a/file0 y/file0
+'
+
+test_expect_success 'diff --src-prefix overrides diff.srcprefix' '
+	git -c diff.srcprefix=z/ diff --src-prefix=z/ >actual &&
+	check_prefix actual z/file0 b/file0
+'
+
+test_expect_success 'diff --dst-prefix overrides diff.dstprefix' '
+	git -c diff.dstprefix=y/ diff --dst-prefix=z/ >actual &&
+	check_prefix actual a/file0 z/file0
+'
+
+test_expect_success 'diff src/dstprefix ignored with diff.noprefix' '
+	git -c diff.dstprefix=y/ -c diff.srcprefix=x/ -c diff.noprefix diff >actual &&
+	check_prefix actual file0 file0
+'
+
+test_expect_success 'diff src/dstprefix ignored with diff.mnemonicprefix' '
+	git -c diff.dstprefix=x/ -c diff.srcprefix=y/ -c diff.mnemonicprefix diff >actual &&
+	check_prefix actual i/file0 w/file0
+'
+
+test_expect_success 'diff src/dstprefix ignored with --default-prefix' '
+	git -c diff.dstprefix=x/ -c diff.srcprefix=y/ diff --default-prefix >actual &&
+	check_prefix actual a/file0 b/file0
+'
+
 test_expect_success 'diff --no-renames cannot be abbreviated' '
 	test_expect_code 129 git diff --no-rename >actual 2>error &&
 	test_must_be_empty actual &&
-- 
2.44.0

