Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8C5628
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 02:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710124348; cv=none; b=VcwUeyzLvBZvxTFxiprAfP3lLLAHqrd/gT/au1ANJ0nwfjTl6TJis3KvIjOI3fOKFTCG1OAWPyB+SJJUdSB5lVLR7Gwh0SlAZJd/Gnbhx5hQej6mBuAsbcqeYATofEbfvhTLAw1TqQ+irRwH0m2BlVBdQZqNDbOUE/8Zjs2fYnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710124348; c=relaxed/simple;
	bh=knyyyXpqeCFbO9NGoFJ1kYmtxJrXLs2zB2iqtpzFpuU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jTWZ9xO5xmermtV8XzpNdLpnTanH0O9g6ZQrh0pU68L+M7h9FWVDdXNa3R2oTHG1zOSw7D+EMe7UClfzVZ/x4ZpfmpA3OfslKU12+AN3TdwKK9DWFGSphoKqtUNT/WFLHk0VLgHS00hq7/Ye9UmLAwpIdXZryaKq1TH6nqot2Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=dZ/sJCZF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HfcMRD5T; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="dZ/sJCZF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HfcMRD5T"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 277D1114008C;
	Sun, 10 Mar 2024 22:32:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 10 Mar 2024 22:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1710124345; x=1710210745; bh=T2GAG895754ybzvIyXbZQbLaZ8TPrp3g
	opy8LwSYeLs=; b=dZ/sJCZFPCADbSZpR0uhDeztNbro23HpSpBP7cx2WHMH6PR6
	LKqLacFG0a7u3lUOSkjFdrDL4ORapHnbIMeEr9cnRzBHsAAoCIrDZR9Pl4+am93F
	QOX8btaFEFvmMh7m3ID6G7UVafbyCBDrEydIHhWjYTWnatzK/diHss77/E8OfOp+
	VtlV1nlvBDvL0JgYYGIx7H3FFbJoFVBcH4OgNd5O9wp9t/t5NuDMZ9hULuz/8+w5
	ktcMCzyVbF2HKq58QjD2WK/Liy5nwXpm3+yChsw3KmuOGUNDMAuKqAknwgbskpzp
	Pp1VM0I4ehE6KBtvA5JI2ab0mu9zTHY8Rfi43Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1710124345; x=1710210745; bh=T2GAG895754ybzvIyXbZQbLaZ8TPrp3gopy
	8LwSYeLs=; b=HfcMRD5Tb/aX6yDpq7GUXNKHQCikx8kV3ivlkLgcJi+07HIevGh
	uJU2q0Fnd5DfGQ+kRbhO8IQW7EpHIz7xDcfRO76fPJutQcSXTwXeV+GZbGUSVFg3
	uMzK584bsZRNsKiwStAM2l/obbEPgkPlHxd6S7F38+VBXsR3x6DsVzVInFXTdEH5
	jrFo1LMIxbZgy1TuQGlb7OwC+dOQZnyJh+H7A4puzmU3v4BKOqUueNUjAmLojSJi
	LJrdqwLdy+fRGcg2cMCY72Wf8ge5Q9bA3FFabuSPIXjrTgH8S77qCkmlcYjW5aAC
	rzswLdYLubjjpzfUbaWdB5Q4NgDdmkCkISg==
X-ME-Sender: <xms:OG3uZZUOneRagqtSMhAvbDzup-VVT-hgj08TgXYZ-23pn2YddqrfsQ>
    <xme:OG3uZZkvS2HGxhIFDjn7_lLRZwijV-8pbJP3Y1K_oVetoZFfdVpvAQB0xwXf-FwXM
    A_kFfr3lgMMHFlajYc>
X-ME-Received: <xmr:OG3uZVYSM4AXCk0CApCjrRUoNjMGqGE3U8sjw5ByMLcmgVLa3ZrvnGIxoim0wuo4hnDJcb1KGCUL0cmfrUaJL-ab6rjIayoykSpi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedtgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfggtggusehttdertddttddvnecuhfhrohhmpefrvghtvghrucfj
    uhhtthgvrhgvrhcuoehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvtheqne
    cuggftrfgrthhtvghrnhephfeggefhleejheeltdfgkeehudejfeefleeuvdfgfedvteet
    ieegteevjeefffelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpvghtvghrrdhhuhhtthgv
    rhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:OG3uZcV-YzhZeY665u0q14Jm_nFh_pZorfJGdxD5f9aLejMkP6o8Ug>
    <xmx:OG3uZTm8IVYezC6gaJNv78ONnZAVSpYYk4u-Mwfd8aM4D1ZbSua9_Q>
    <xmx:OG3uZZf26m7jsbs57XlV7BLW3D0ffsathqDmkJeYrgjl3vVfJaDCKg>
    <xmx:OW3uZYy3SGayL9H6XwQCfw7VRPqkO-7uJ4mITvtTqzU5vrV5S9szsA>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Mar 2024 22:32:23 -0400 (EDT)
Date: Mon, 11 Mar 2024 12:32:17 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: git@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>
Subject: [PATCH] diff: add diff.srcprefix and diff.dstprefix option support
Message-ID: <20240311023217.GA2345739@quokka>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The git option equivalent to --src-prefix and --dst-prefix.
Both of these are of lower precedence than the diff.noprefix and
diff.mnemonicprefix option.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
As David already mentioned [1] my main motivation here is to use
a prefix of "./" because that is patch -p1 compatible *and* supports
double-click highlighting of the file path in most terminals.

The current approach of a/ and b/ fail at the latter and diff.noprefix
fails at the former.

[1] https://lore.kernel.org/git/f80aaf4a-ffea-48e6-b279-c3b7a6a53996@ixit.cz/

 Documentation/config/diff.txt |  6 ++++++
 diff.c                        | 18 ++++++++++++++++++
 diff.h                        |  1 +
 t/t4013-diff-various.sh       | 20 ++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 6c7e09a1ef5e..888632955b30 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -111,6 +111,12 @@ diff.mnemonicPrefix::
 diff.noprefix::
 	If set, 'git diff' does not show any source or destination prefix.
 
+diff.srcprefix::
+	If set, 'git diff' uses this source prefix.
+
+diff.dstprefix::
+	If set, 'git diff' uses this destination prefix.
+
 diff.relative::
 	If set to 'true', 'git diff' does not show changes outside of the directory
 	and show pathnames relative to the current directory.
diff --git a/diff.c b/diff.c
index e50def45383e..52a476737def 100644
--- a/diff.c
+++ b/diff.c
@@ -62,6 +62,8 @@ static const char *diff_order_file_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
+static const char *diff_src_prefix;
+static const char *diff_dst_prefix;
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
@@ -3429,6 +3437,14 @@ void diff_set_default_prefix(struct diff_options *options)
 	options->b_prefix = "b/";
 }
 
+void diff_set_custom_prefix(struct diff_options *options, const char *src_prefix, const char *dst_prefix)
+{
+	if (src_prefix)
+		options->a_prefix = src_prefix;
+	if (dst_prefix)
+		options->b_prefix = dst_prefix;
+}
+
 struct userdiff_driver *get_textconv(struct repository *r,
 				     struct diff_filespec *one)
 {
@@ -4736,6 +4752,8 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 		diff_set_noprefix(options);
 	} else if (!diff_mnemonic_prefix) {
 		diff_set_default_prefix(options);
+		if (diff_src_prefix || diff_dst_prefix)
+			diff_set_custom_prefix(options, diff_src_prefix, diff_dst_prefix);
 	}
 
 	options->color_moved = diff_color_moved_default;
diff --git a/diff.h b/diff.h
index 66bd8aeb2936..ab4dd5ec70f3 100644
--- a/diff.h
+++ b/diff.h
@@ -499,6 +499,7 @@ void diff_tree_combined_merge(const struct commit *commit, struct rev_info *rev)
 void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const char *b);
 void diff_set_noprefix(struct diff_options *options);
 void diff_set_default_prefix(struct diff_options *options);
+void diff_set_custom_prefix(struct diff_options *options, const char *src_prefix, const char *dst_prefix);
 
 int diff_can_quit_early(struct diff_options *);
 
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 1e3b2dbea484..86834186fdba 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -663,6 +663,26 @@ test_expect_success 'diff --default-prefix overrides diff.mnemonicprefix' '
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
 test_expect_success 'diff --no-renames cannot be abbreviated' '
 	test_expect_code 129 git diff --no-rename >actual 2>error &&
 	test_must_be_empty actual &&
-- 
2.44.0

