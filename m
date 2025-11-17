Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A3B315D23
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763366680; cv=none; b=IAraDqm6kfYYpWKhHyybjMhczXTuUWpqAOP7D5E6L/FOPRLn2N0z4nbJdFRK81jPyHHt3UW/TOPpEpxZHbG3gPBt2bBjYEtBztm+CNSdJztiRHKM8n6MKrF4qYqf469mLFKdp1E399yKS/IxWqMuLK8nUy8axdAscERCmH95mio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763366680; c=relaxed/simple;
	bh=0h2vocTUSs91oVxhTbqZVzBDhEOCD/WoiC3Tx/w7usQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XWCCUcXctFcd17gN/3n3MIWf8Ll9MCIoADGQpflXWq3WBTxZEx5qsfeMvE6JAUVje+Wa45DhHIfEprf+vynotZf5gF4z/nUm1dfu5Jdq9BrrNHhQfd0r1DoCZh7i9/DNpg+7BLY7AUQPVlqyK07PgFjLoMJ71AYvWjsMPxYKRxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPCC5be7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPCC5be7"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so3715371b3a.0
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 00:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763366677; x=1763971477; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjleNkSrNhE+NDoV0mrxqPo9JCtGVW1D+Kth9SgBnJ4=;
        b=hPCC5be7+Vk2NMGYKEijdyBt7pCZ0/59sltrMY3tol59h38cerSGqy9Iwl+txOmS4Z
         kFgze5KnlRRD2GWHnzPtPHF+vYfKlq/xidstSEwFhnWDjeqxScZW6Mpt7NCrj93RBmfv
         VudIUKYbUWVPOr+EMamCOohlFbAgW2Po8veLlGq1ig4/JfXPiZZRXZQjw1AFs54zFDC+
         cmCdF+GBKGBOHE4CadOx54bu6MhvTu+s2/yU30em6q6qg4tWaZngBtPwg9RGlKFfqfbT
         68iZ39SWsTWV+TdS5DXFcfS2AoIZkGmol24rcJmaRaxb4SklSU1LdoSCke9UHy96e59W
         ssdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763366677; x=1763971477;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vjleNkSrNhE+NDoV0mrxqPo9JCtGVW1D+Kth9SgBnJ4=;
        b=qfrRlFTfB6gWWU/SZg5g/FQFPDLTAQkrGuRORymtwD8c/V3YJbp7jwP2udxT24j+Fx
         zJERCxIcVk9oMskV7w2dkubIMyTtiZWO0sBLfXwdKckWkCvpmKCUwSK/VXw+//IDAhBe
         NjWMt2OQZeRR2PWYqZsgJ/L+2LMT1umq6bJUqTBDmciDzH7MMT/cNmzF2qY0I8SvhhnD
         s7ig6KwAdLnHBpZwv1WV/fQjtGoGBTMIo3veHUNGXaOZ8rtE6zCZhlEism74SJCLUDlc
         LhNKWFpds983UaU6jJREtsPCiYumC+fp8vFaDMxrgELyitucOKkhnLLU38n5Qhw0x/5Y
         pLuQ==
X-Gm-Message-State: AOJu0Yx7N27NDokplTSJpPaW71PwkdpaXC55AiuHgTf4A0ZANYhCEXdU
	m5+7sFomPWke/TE6hk5g2uLyw4x+opmF6ujlqDPmOql1PBIDdTqfcpDv8/gHvAf7
X-Gm-Gg: ASbGncvWBMShvBD0Ed8SAUSN7ti0xU/rt1cuRk4IvzCDSAR+ImxuN8ETr4wEINaB4wT
	OmoD9uzXUClXDy/hwqYMb7TUSQVgjoYZB5vYInNijgW4L32tUN/V8v/lTMKHHl7ZS0YIfCFc5gp
	lVedCVbLVr89zhzG0pnl2U389DQUnLvjPOwYrKhT0UhCA6EvxTVb/dtKafvkuKwj3f2G5UjFqOc
	1ewkhov0mphUuPq4vy/3YWA2BjGidWWB+eM44QY2ip/z7EvIaxNK5BaaahpeuJtrot7hJZAHCaA
	SukVJ7YXjcBQmSmMQLY0Ln+ifxB0DcRKg/CSnCspVkGy/9eTXPLVRE6GgCZBwikzO+AUuJAvlRN
	tch+OXl+ycKJha1DEGDhnOORJwzhIx+IPaelfuleIvcDHEeNUruUsN2PaW+bDDtHnUqn+I0SlYi
	5OkQUIxIRZoRPg
X-Google-Smtp-Source: AGHT+IEUqs0i0MU5m8sm4/MIZMOTPHtw/H31L6pO06WB3wStiLHOnf/+L0RWPumfdXba9es21MmeAA==
X-Received: by 2002:a05:7022:69a5:b0:119:e56b:957e with SMTP id a92af1059eb24-11b40e7cae6mr4737325c88.3.1763366676929;
        Mon, 17 Nov 2025 00:04:36 -0800 (PST)
Received: from [127.0.0.1] ([52.161.74.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885eesm46865378c88.1.2025.11.17.00.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 00:04:36 -0800 (PST)
Message-Id: <c477b87cc617f5302db40fc9a1a480f3392179b0.1763366672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2075.v6.git.git.1763366672.gitgitgadget@gmail.com>
References: <pull.2075.v5.git.git.1762468914.gitgitgadget@gmail.com>
	<pull.2075.v6.git.git.1763366672.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Nov 2025 08:04:32 +0000
Subject: [PATCH v6 2/2] blame: make diff algorithm configurable
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Antonin Delpeuch <antonin@delpeuch.eu>,
    Antonin Delpeuch <antonin@delpeuch.eu>

From: Antonin Delpeuch <antonin@delpeuch.eu>

The diff algorithm used in 'git-blame(1)' is set to 'myers',
without the possibility to change it aside from the `--minimal` option.

There has been long-standing interest in changing the default diff
algorithm to "histogram", and Git 3.0 was floated as a possible occasion
for taking some steps towards that:

https://lore.kernel.org/git/xmqqed873vgn.fsf@gitster.g/

As a preparation for this move, it is worth making sure that the diff
algorithm is configurable where useful.

Make it configurable in the `git-blame(1)` command by introducing the
`--diff-algorithm` option and make honor the `diff.algorithm` config
variable. Keep Myers diff as the default.

Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
---
 Documentation/diff-algorithm-option.adoc |  20 +++
 Documentation/diff-options.adoc          |  21 +--
 Documentation/git-blame.adoc             |   2 +
 builtin/blame.c                          |  52 +++++-
 t/meson.build                            |   1 +
 t/t8015-blame-diff-algorithm.sh          | 203 +++++++++++++++++++++++
 6 files changed, 278 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/diff-algorithm-option.adoc
 create mode 100755 t/t8015-blame-diff-algorithm.sh

diff --git a/Documentation/diff-algorithm-option.adoc b/Documentation/diff-algorithm-option.adoc
new file mode 100644
index 0000000000..8e3a0b63d7
--- /dev/null
+++ b/Documentation/diff-algorithm-option.adoc
@@ -0,0 +1,20 @@
+`--diff-algorithm=(patience|minimal|histogram|myers)`::
+	Choose a diff algorithm. The variants are as follows:
++
+--
+   `default`;;
+   `myers`;;
+	The basic greedy diff algorithm. Currently, this is the default.
+   `minimal`;;
+	Spend extra time to make sure the smallest possible diff is
+	produced.
+   `patience`;;
+	Use "patience diff" algorithm when generating patches.
+   `histogram`;;
+	This algorithm extends the patience algorithm to "support
+	low-occurrence common elements".
+--
++
+For instance, if you configured the `diff.algorithm` variable to a
+non-default value and want to use the default one, then you
+have to use `--diff-algorithm=default` option.
diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index ae31520f7f..9cdad6f72a 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -197,26 +197,7 @@ and starts with _<text>_, this algorithm attempts to prevent it from
 appearing as a deletion or addition in the output. It uses the "patience
 diff" algorithm internally.
 
-`--diff-algorithm=(patience|minimal|histogram|myers)`::
-	Choose a diff algorithm. The variants are as follows:
-+
---
-   `default`;;
-   `myers`;;
-	The basic greedy diff algorithm. Currently, this is the default.
-   `minimal`;;
-	Spend extra time to make sure the smallest possible diff is
-	produced.
-   `patience`;;
-	Use "patience diff" algorithm when generating patches.
-   `histogram`;;
-	This algorithm extends the patience algorithm to "support
-	low-occurrence common elements".
---
-+
-For instance, if you configured the `diff.algorithm` variable to a
-non-default value and want to use the default one, then you
-have to use `--diff-algorithm=default` option.
+include::diff-algorithm-option.adoc[]
 
 `--stat[=<width>[,<name-width>[,<count>]]]`::
 	Generate a diffstat. By default, as much space as necessary
diff --git a/Documentation/git-blame.adoc b/Documentation/git-blame.adoc
index e438d28625..adcbb6f5dc 100644
--- a/Documentation/git-blame.adoc
+++ b/Documentation/git-blame.adoc
@@ -85,6 +85,8 @@ include::blame-options.adoc[]
 	Ignore whitespace when comparing the parent's version and
 	the child's to find where the lines came from.
 
+include::diff-algorithm-option.adoc[]
+
 --abbrev=<n>::
 	Instead of using the default 7+1 hexadecimal digits as the
 	abbreviated object name, use <m>+1 digits, where <m> is at
diff --git a/builtin/blame.c b/builtin/blame.c
index 2703820258..27b513d27f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -779,6 +779,19 @@ static int git_blame_config(const char *var, const char *value,
 		}
 	}
 
+	if (!strcmp(var, "diff.algorithm")) {
+		long diff_algorithm;
+		if (!value)
+			return config_error_nonbool(var);
+		diff_algorithm = parse_algorithm_value(value);
+		if (diff_algorithm < 0)
+			return error(_("unknown value for config '%s': %s"),
+				     var, value);
+		xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
+		xdl_opts |= diff_algorithm;
+		return 0;
+	}
+
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
 	if (userdiff_config(var, value) < 0)
@@ -824,6 +837,38 @@ static int blame_move_callback(const struct option *option, const char *arg, int
 	return 0;
 }
 
+static int blame_diff_algorithm_minimal(const struct option *option,
+					const char *arg, int unset)
+{
+	int *opt = option->value;
+
+	BUG_ON_OPT_ARG(arg);
+
+	*opt &= ~XDF_DIFF_ALGORITHM_MASK;
+	if (!unset)
+		*opt |= XDF_NEED_MINIMAL;
+
+	return 0;
+}
+
+static int blame_diff_algorithm_callback(const struct option *option,
+					 const char *arg, int unset)
+{
+	int *opt = option->value;
+	long value = parse_algorithm_value(arg);
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (value < 0)
+		return error(_("option diff-algorithm accepts \"myers\", "
+			       "\"minimal\", \"patience\" and \"histogram\""));
+
+	*opt &= ~XDF_DIFF_ALGORITHM_MASK;
+	*opt |= value;
+
+	return 0;
+}
+
 static int is_a_rev(const char *name)
 {
 	struct object_id oid;
@@ -915,11 +960,16 @@ int cmd_blame(int argc,
 		OPT_BIT('s', NULL, &output_option, N_("suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
 		OPT_BIT('e', "show-email", &output_option, N_("show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
+		OPT_CALLBACK_F(0, "diff-algorithm", &xdl_opts, N_("<algorithm>"),
+			       N_("choose a diff algorithm"),
+			       PARSE_OPT_NONEG, blame_diff_algorithm_callback),
 		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("ignore <rev> when blaming")),
 		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list, N_("file"), N_("ignore revisions from <file>")),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
 		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
-		OPT_BIT(0, "minimal", &xdl_opts, N_("spend extra cycles to find better match"), XDF_NEED_MINIMAL),
+		OPT_CALLBACK_F(0, "minimal", &xdl_opts, NULL,
+			       N_("spend extra cycles to find a better match"),
+			       PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, blame_diff_algorithm_minimal),
 		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("use revisions from <file> instead of calling git-rev-list")),
 		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("use <file>'s contents as the final image")),
 		OPT_CALLBACK_F('C', NULL, &opt, N_("score"), N_("find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback),
diff --git a/t/meson.build b/t/meson.build
index 401b24e50e..9f2fe7af8b 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -955,6 +955,7 @@ integration_tests = [
   't8012-blame-colors.sh',
   't8013-blame-ignore-revs.sh',
   't8014-blame-ignore-fuzzy.sh',
+  't8015-blame-diff-algorithm.sh',
   't8020-last-modified.sh',
   't9001-send-email.sh',
   't9002-column.sh',
diff --git a/t/t8015-blame-diff-algorithm.sh b/t/t8015-blame-diff-algorithm.sh
new file mode 100755
index 0000000000..cd709536c6
--- /dev/null
+++ b/t/t8015-blame-diff-algorithm.sh
@@ -0,0 +1,203 @@
+#!/bin/sh
+
+test_description='git blame with specific diff algorithm'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	cat >file.c <<-\EOF &&
+	int f(int x, int y)
+	{
+	  if (x == 0)
+	  {
+	    return y;
+	  }
+	  return x;
+	}
+
+	int g(size_t u)
+	{
+	  while (u < 30)
+	  {
+	    u++;
+	  }
+	  return u;
+	}
+	EOF
+	test_write_lines x x x x >file.txt &&
+	git add file.c file.txt &&
+	GIT_AUTHOR_NAME=Commit_1 git commit -m Commit_1 &&
+
+	cat >file.c <<-\EOF &&
+	int g(size_t u)
+	{
+	  while (u < 30)
+	  {
+	    u++;
+	  }
+	  return u;
+	}
+
+	int h(int x, int y, int z)
+	{
+	  if (z == 0)
+	  {
+	    return x;
+	  }
+	  return y;
+	}
+	EOF
+	test_write_lines x x x A B C D x E F G >file.txt &&
+	git add file.c file.txt &&
+	GIT_AUTHOR_NAME=Commit_2 git commit -m Commit_2
+'
+
+test_expect_success 'blame uses Myers diff algorithm by default' '
+	cat >expected <<-\EOF &&
+	Commit_2 int g(size_t u)
+	Commit_1 {
+	Commit_2   while (u < 30)
+	Commit_1   {
+	Commit_2     u++;
+	Commit_1   }
+	Commit_2   return u;
+	Commit_1 }
+	Commit_1
+	Commit_2 int h(int x, int y, int z)
+	Commit_1 {
+	Commit_2   if (z == 0)
+	Commit_1   {
+	Commit_2     return x;
+	Commit_1   }
+	Commit_2   return y;
+	Commit_1 }
+	EOF
+
+	git blame file.c >output &&
+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output >without_varying_parts &&
+	sed -e "s/ *$//g" without_varying_parts >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'blame honors --diff-algorithm option' '
+	cat >expected <<-\EOF &&
+	Commit_1 int g(size_t u)
+	Commit_1 {
+	Commit_1   while (u < 30)
+	Commit_1   {
+	Commit_1     u++;
+	Commit_1   }
+	Commit_1   return u;
+	Commit_1 }
+	Commit_2
+	Commit_2 int h(int x, int y, int z)
+	Commit_2 {
+	Commit_2   if (z == 0)
+	Commit_2   {
+	Commit_2     return x;
+	Commit_2   }
+	Commit_2   return y;
+	Commit_2 }
+	EOF
+
+	git blame file.c --diff-algorithm histogram >output &&
+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output >without_varying_parts &&
+	sed -e "s/ *$//g" without_varying_parts >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'blame honors diff.algorithm config variable' '
+	cat >expected <<-\EOF &&
+	Commit_1 int g(size_t u)
+	Commit_1 {
+	Commit_1   while (u < 30)
+	Commit_1   {
+	Commit_1     u++;
+	Commit_1   }
+	Commit_1   return u;
+	Commit_1 }
+	Commit_2
+	Commit_2 int h(int x, int y, int z)
+	Commit_2 {
+	Commit_2   if (z == 0)
+	Commit_2   {
+	Commit_2     return x;
+	Commit_2   }
+	Commit_2   return y;
+	Commit_2 }
+	EOF
+
+	git -c diff.algorithm=histogram blame file.c >output &&
+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" \
+	    -e "s/ *$//g" output >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'blame gives priority to --diff-algorithm over diff.algorithm' '
+	cat >expected <<-\EOF &&
+	Commit_1 int g(size_t u)
+	Commit_1 {
+	Commit_1   while (u < 30)
+	Commit_1   {
+	Commit_1     u++;
+	Commit_1   }
+	Commit_1   return u;
+	Commit_1 }
+	Commit_2
+	Commit_2 int h(int x, int y, int z)
+	Commit_2 {
+	Commit_2   if (z == 0)
+	Commit_2   {
+	Commit_2     return x;
+	Commit_2   }
+	Commit_2   return y;
+	Commit_2 }
+	EOF
+
+	git -c diff.algorithm=myers blame file.c --diff-algorithm histogram >output &&
+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" \
+	    -e "s/ *$//g" output >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'blame honors --minimal option' '
+	cat >expected <<-\EOF &&
+	Commit_1 x
+	Commit_1 x
+	Commit_1 x
+	Commit_2 A
+	Commit_2 B
+	Commit_2 C
+	Commit_2 D
+	Commit_1 x
+	Commit_2 E
+	Commit_2 F
+	Commit_2 G
+	EOF
+
+	git blame file.txt --minimal >output &&
+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'blame respects the order of diff options' '
+	cat >expected <<-\EOF &&
+	Commit_1 x
+	Commit_1 x
+	Commit_1 x
+	Commit_2 A
+	Commit_2 B
+	Commit_2 C
+	Commit_2 D
+	Commit_2 x
+	Commit_2 E
+	Commit_2 F
+	Commit_2 G
+	EOF
+
+	git blame file.txt --minimal --diff-algorithm myers >output &&
+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
gitgitgadget
