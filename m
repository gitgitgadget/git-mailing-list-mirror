Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC1612E5D
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 05:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710482099; cv=none; b=XptCDtxy0OozNkwdjnz05bVnZbQYqvmrhdqcl0HM4nbA4WM26b7rwVoySyvHfGfBKtN12O42U9D5THrZWGXj1TANxBX8tOsQSC1yrn1za5YUHE7LPIQDroRG5ZJ1IUfmNKBRqfFsQHiVx1zq2+9mw6WS1KjS79P2xrh+rEWQ+lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710482099; c=relaxed/simple;
	bh=yusPXM8CD41BrNALqm+NAHLi9f0o0A3RAd0af6UM3Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d73JduqBKsUFOLIVye87CZ+z4fBlX18dZ5ftkQ+lB3DIIUNBqeErmyL6X7Lq3UcMTSNVQk7U5uaZz4hkCNOeOSBqOdIjvKRjq1gTGg7l7f3W1lSd/uA29I9dNzRUPKiAEjvIY0FRjcaWMKvGSOlMqg1AD5WPFAlFB9yh2GXeIqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=iTj0T3zS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XAe+nJC7; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="iTj0T3zS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XAe+nJC7"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8224D13800E0;
	Fri, 15 Mar 2024 01:54:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 15 Mar 2024 01:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1710482096; x=1710568496; bh=zW1eP/caBq7KzH880BFuR
	TdXy5WAWLI22oFIVxsISFU=; b=iTj0T3zSHNEA9eNAWId1nQQ/7JG2o8nGc3FTY
	boPrGErabFsQC9ATGatc6zGWcSfbo9RRIUSZqvMRkMnlXuxXnGrp7z8jw7ksUIRg
	o/Y/EK17x2heRXsY8bkbnowyySDrHU2PZ/9jAP5k2EK6labqQ0T0TXfJWEOUEF73
	hjy/kyObL3MxFtmNQkapt/qQ0a4/agmfqofbWzpZxd5L/AmXTzwXaHqY2qrazuXt
	guh6P01f+Tt6sLTxfQMNTDeUn4Bqi/n/7zxGdKdt0tGv2E1FKbbopMUImEx1GmHg
	BqcR798zaf8tUh5G18DLK17nwaDONVUv4w3jo4Gi1ABk7Hrig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710482096; x=1710568496; bh=zW1eP/caBq7KzH880BFuRTdXy5WA
	WLI22oFIVxsISFU=; b=XAe+nJC7+DSoGWdZcQtYnxBKES2YU1PAcghK90HWls45
	8o00t/ulwoWw/cPCgNZdc+BMJvl9ph5m3wH66jiLzmtUAcFinb9GnRgQQaEJiX4e
	TiZAbEQZR4XkTINclc/IJR9psdH14HuHRSzDBLpS4tg5HbGUIf/MsCQcMyLj5PCm
	OFmDEk8Nugb2GO5qpbvzdhT64EGorNW3kDkIDPG2H0ZSbTSgVMtR/vnmpKVhe6SX
	n9GWCcaRNNomQlxP8yje3qgj20KmR0O1X6xaPki0QcMSzilEln2tNceMUdNhnH0E
	JmmA+/zoxwqQ1Um6m7mRu1jc5zBnyTJgVmkXL1JC0g==
X-ME-Sender: <xms:sOLzZYepeLCKbN8tcyYmqOvwJY3QDqReQ5K6KZSqJzHvKcBzs-xb5w>
    <xme:sOLzZaOUGS4HFoPNKHQ_rmxgdkIn3O_D9h-5M3vCXFVtmUXqq6HpSzQZS4anDhJbz
    Dovjd08gWAMe4Vh0ho>
X-ME-Received: <xmr:sOLzZZgTE_QBuVnTjaLCnGQyMzU0w2bhJgFnPb7s_8T4jrlmnxH9hFn3wblO4uTTtvVN5zWzwaDQhBfypvCZYF1NZe-G1_BVICmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeekgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgvrhcu
    jfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvghtqe
    enucggtffrrghtthgvrhhnpeefleehgffhgffgieduveejjeejveetfeelhfdttdevueek
    ieeltefhudeufeeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:sOLzZd9TvTQKa_u2P28P1WDwxtJXDJ-4xuawe_WVKXHOrLFH4cUaXw>
    <xmx:sOLzZUvUzn38NXYU0kZQfs_z0sEGEypZnugnNlOSqWMhYjGiPg1c4A>
    <xmx:sOLzZUFi1qOdlY8GVSbfAmflTz15RQHEnVAdJLZXUa05PAT5Ao-pPg>
    <xmx:sOLzZTPNF8PnfUun0ztpSPobYqgrI_HqkKsd2B_zzw0StYT9i_QMHw>
    <xmx:sOLzZYh-j9z6JTEfN4cIuI8tzsJdZshrojS0wOvcDIrWWddD8vwVkg>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Mar 2024 01:54:53 -0400 (EDT)
Date: Fri, 15 Mar 2024 15:54:48 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, David Heidelberg <david@ixit.cz>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v5] diff: add diff.srcPrefix and diff.dstPrefix configuration
 variables
Message-ID: <20240315055448.GA2253326@quokka>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2da5f5cd5956194e659c88026a12cb9e@manjaro.org>

Allow the default prefixes "a/" and "b/" to be tweaked by the
diff.srcPrefix and diff.dstPrefix configuration variables.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
Changes to v4 (as pointed out by Dragan):
- copy/paste-o fixed in the dstprefix test
- reworded the description for the tests as suggested

Dragan: good catch on the test, thanks for that. I think for the
rewording of --default-prefix it might be faster if you reword it?
Otherwise we might keep spinning this one for a quite a bit longer :)

 Documentation/config/diff.txt  |  6 ++++++
 Documentation/diff-options.txt |  5 +++--
 diff.c                         | 14 ++++++++++++--
 t/t4013-diff-various.sh        | 35 ++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 6c7e09a1ef5e..fea89291c675 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -111,6 +111,12 @@ diff.mnemonicPrefix::
 diff.noprefix::
 	If set, 'git diff' does not show any source or destination prefix.
 
+diff.srcPrefix::
+	If set, 'git diff' uses this source prefix. Defaults to "a/".
+
+diff.dstPrefix::
+	If set, 'git diff' uses this destination prefix. Defaults to "b/".
+
 diff.relative::
 	If set to 'true', 'git diff' does not show changes outside of the directory
 	and show pathnames relative to the current directory.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index aaaff0d46f0c..0e9456957e37 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -865,8 +865,9 @@ endif::git-format-patch[]
 
 --default-prefix::
 	Use the default source and destination prefixes ("a/" and "b/").
-	This is usually the default already, but may be used to override
-	config such as `diff.noprefix`.
+	This overrides configuration variables such as `diff.noprefix`,
+	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
+	(see `git-config`(1)).
 
 --line-prefix=<prefix>::
 	Prepend an additional prefix to every line of output.
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
index 1e3b2dbea484..6bf69888f258 100755
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
+	git -c diff.srcprefix=y/ diff --src-prefix=z/ >actual &&
+	check_prefix actual z/file0 b/file0
+'
+
+test_expect_success 'diff --dst-prefix overrides diff.dstprefix' '
+	git -c diff.dstprefix=y/ diff --dst-prefix=z/ >actual &&
+	check_prefix actual a/file0 z/file0
+'
+
+test_expect_success 'diff.*prefix ignored with diff.noprefix' '
+	git -c diff.dstprefix=y/ -c diff.srcprefix=x/ -c diff.noprefix diff >actual &&
+	check_prefix actual file0 file0
+'
+
+test_expect_success 'diff.*prefix ignored with diff.mnemonicprefix' '
+	git -c diff.dstprefix=x/ -c diff.srcprefix=y/ -c diff.mnemonicprefix diff >actual &&
+	check_prefix actual i/file0 w/file0
+'
+
+test_expect_success 'diff.*prefix ignored with --default-prefix' '
+	git -c diff.dstprefix=x/ -c diff.srcprefix=y/ diff --default-prefix >actual &&
+	check_prefix actual a/file0 b/file0
+'
+
 test_expect_success 'diff --no-renames cannot be abbreviated' '
 	test_expect_code 129 git diff --no-rename >actual 2>error &&
 	test_must_be_empty actual &&
-- 
2.44.0

