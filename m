Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA58310F4
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 01:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710464603; cv=none; b=bkDD6PYCIx1ZIg/Pl4NP556Tb9ePYleFJhDV0DF4kJnP9XhQuhjo9m7CwDWi7SZiJL76QBEi7RuuRrGFYPncaBjGNezJAKpu5P+uvkb/sxUTw3AKZg3q2fC4QFWRYGY8/ToD2uwpOyCA/N07C5fVcUEqwA8Tey1RJ+m1I7ZWQYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710464603; c=relaxed/simple;
	bh=ri8Of+9b0cK5ZwVaGFk5ReUlT48aNtlw4kiFXfQVwVI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RIMwHYOMk0Bz+JzGM5HZGkqMQy6UEJkJItyPwxHX1VrsX/gpWQXneDbwypg0m7AcqPjhCOpCASTnFz2tRiuia5ZsMh24wodpjm9mgnh3mJWQTUJBCR6WtJs5/m3YSl9hr0LWMQJxeR+QcstORkMW2bG9P7UEGzctIZig+f2/gMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=MSNvmcXc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qMJ7hOHq; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="MSNvmcXc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qMJ7hOHq"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id DC4D55C006D;
	Thu, 14 Mar 2024 21:03:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 14 Mar 2024 21:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1710464599; x=1710550999; bh=pX7CMPLvivV/U9q3r01c8
	poj0rDCDCpg4vfIlf1Z39s=; b=MSNvmcXck0VwuVvV1XTO4fFyfQDfhaQgYbnLS
	2PfaHV9/8Sj+HQvN67jOPQ232xCok7XYLQ4GVsn4eqGjF3LLIvYKNnuJhIN3glFg
	jqWUsLgfCdXV2znzgVyDuu+JkHk5ni/c7zLTc5jCsJfRXGsQljfWi3nYzbXPmUNz
	lxLdnPP/IHpj04qk9rvmWkH+AwXmneLqHUIGnx84rbu7MoDF5fxOdzN61ee6NN67
	xA8wJef2ygRgDuNl7NcpwKOS/vbGIVj2KC68SqNqGe8UMng7SPv/fbgiO1FQPpD5
	ST23V/EXGvyfMnfkoCei8N/8s8MvAsLYu2btr0Ue6p/SmDFPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710464599; x=1710550999; bh=pX7CMPLvivV/U9q3r01c8poj0rDC
	DCpg4vfIlf1Z39s=; b=qMJ7hOHqwacBlqnMx+Vqoro6OPR/nU+vWy/ET/+rjjNS
	SNsDZ1V+b7EEYdsoAfEMWPD/Jcms0VS5W5sJEN0hxp4hRfljecTdKPU5WEeeTVBe
	0iBIOo3Htr+LJxUqoEi2GBb61zXoxi8UQkcmv+WWM6mwXYM+E3go2PpT4aUCYZjU
	EZy46xSnMfXnibvQ85QJXpaiP+L7t/SeooRwY9E1mAV9AXYYw83H9wAuH8BgVHEk
	y5BkMFtxAgFu3W5kOcvkSArAeaaPs/W4n41zviQkdw9MJb3lWefg3D34J90I10cM
	uQnBQmRlzuk1ioycq4TBJsmJRQ1J9ZY4afbfnDgZVw==
X-ME-Sender: <xms:V57zZYkezcg04v00lHFhA3J2MxMi7lLiQofbXmCK6R0pp1-jByZy9g>
    <xme:V57zZX0yBwVsMFcC4ymjC0Hlc-BZZ8GWwMLmdX9s-vGc1RvA1Ht9Y_IJ9lprDhF8q
    bkpKAGiLfoiOMVSvew>
X-ME-Received: <xmr:V57zZWolCYREe9WJP6nWj4Ri5AZ56VACA1y0HVLHVNyIR30Tgi00j12YUyaMOJmxF7BLLqj3IL4pMv2k8PpJaxUOx3Zgjjkeyudi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeekgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgvrhcu
    jfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvghtqe
    enucggtffrrghtthgvrhhnpeefleehgffhgffgieduveejjeejveetfeelhfdttdevueek
    ieeltefhudeufeeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:V57zZUmWHR7Ow_dIUvJQ3japzO926S8OVoH6ETKPmrvYuAK3y9B3GA>
    <xmx:V57zZW1XLn2hgzNSy-4kf1KuTluJ0JgmlFDklRk3ufzXUbpM8PKviA>
    <xmx:V57zZbvDqY5Hxdcp_RyNOQ2ftCythOxLhWH4Skf5NA7x5NsDUIK9yQ>
    <xmx:V57zZSXqI1EY6ZmtvRbWHKMzmsKkCbyIE-p9MLNmdXQNfK0QYQVrOQ>
    <xmx:V57zZS-FVJ9gkToKjLlVAS4aTpTzscWluctqAeYZ9uELUksD51pmrA>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Mar 2024 21:03:16 -0400 (EDT)
Date: Fri, 15 Mar 2024 11:03:10 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, David Heidelberg <david@ixit.cz>,
	Dragan Simic <dsimic@manjaro.org>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4] diff: add diff.srcPrefix and diff.dstPrefix configuration
 variables
Message-ID: <20240315010310.GA1901653@quokka>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312231559.GA116605@quokka>

Allow the default prefixes "a/" and "b/" to be tweaked by the
diff.srcPrefix and diff.dstPrefix configuration variables.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
Changes to v3:
- fix capitalization in the commit message
- quotes changed to " in the diff.txt hunk (for consistency with
  diff.mnemonicPrefix)
- reword the diff-options.txt entry to be more explicit/definitive

Dragan: I used the lowercase `noprefix` spelling here to be consistent
with the current state of the tree, can you please include the fix for
this in your pending patch? Thanks.

 Documentation/config/diff.txt  |  6 ++++++
 Documentation/diff-options.txt |  5 +++--
 diff.c                         | 14 ++++++++++++--
 t/t4013-diff-various.sh        | 35 ++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 6c7e09a1ef5e..afc23d7723b6 100644
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

