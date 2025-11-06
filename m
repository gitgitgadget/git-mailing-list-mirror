Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D7C3451D6
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 22:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468921; cv=none; b=kNja4d3uT1iZTPs/hjMrT5Bf4W29PbsDPEAZZ42xsqwLrTmXwjjd9N4whrpVvCYcQu5Q86b2bRe+yaft2hfcyi4qtUkW5DPTiS3Qof//cO1e5YQSh5IwLWwvQZnttOSbD7ZAb7ak9OF1VD9eNw7315dgOtzu3etkiPUNWxI60WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468921; c=relaxed/simple;
	bh=gRZdaW0qrVtui1tzHl+8ZrpmQjM7N77D2JqmTv+ikY4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HduOwHPZ14APXPwAICERCEIe7M2Ws5Jp0DcwOL7QQM/ZHzwCRKAr7IxoEQaxw0wtIyejc9S1U2/LJUcDnwTK8ZyoI2gyyNP3cxaqf1BAHR11SkaM3BcKYNdpHTnD+Zhmvoc4cxhEe4aMH0TuZ5lJK3ZRI95OtK0oPebbsRE1ZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nITBy++J; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nITBy++J"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b0c3451272so223555b3a.0
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 14:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762468918; x=1763073718; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSWHasNKUfKttlOr2fR04nGz1xGZs9zHwOeGxayA1+M=;
        b=nITBy++JggtsHU4OyFfzS64ivN1uTFtXkKos4OERErpp9qs+BHrQnTLmsgGER20iA7
         Z25rbr624vyzSrn60RAqmx+Zafnv5yPbLZYjVXFDs8gJcvwrAxJEN1dIa7uxqcMtQ8ze
         tLhNjUw32R/7NWcCmqjtI/30brwCGiix39/ZPXgc54lDpBgniXbTAgVQMRSZGuWhNKs0
         R2LVRUMl9SSSxiEwRQR0/QHuXlRfnkQbw9cI+2XXp4UxYThDtGTtMvHO86fZWsKEPS6k
         c1LD0vIuNkqMx1699r0Ygt03SKIW6JviAoet0DVnNnfkYi/Iz+uExYGTXg0QVhJtdPki
         VzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762468918; x=1763073718;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CSWHasNKUfKttlOr2fR04nGz1xGZs9zHwOeGxayA1+M=;
        b=fwg5wJz9ErdlnwUroe9VZCng3Tu90MBT8txQ+s1NEOKfr6hgnOEPwMpWdDZQw9dPg1
         EAW8jGimWoJLrJY/X5ZvyqaXUx8iOZDS1Ffyxs3vkgNJFAjxL+pWg0cl5wafGHb4RdYS
         /13UZYW8Qd4QFnKlvH3r0jUC1K1/vyVcgktpZqmCjLWpdKuGHrbH3EVWIx/8JCN8Tfh1
         8nWIWA1G6BiYB+LApHgpTGMjPlzts1r6e6reYyG6KF8SHrg27nbHIRNZpZTU+q6AUG31
         qHP2b6dnLWZusumIUWyoIhB5a3o9yfWGawgsU3P9tJtk2reoQRqKl/h80MqfXyBrwb6Y
         PXbQ==
X-Gm-Message-State: AOJu0YyP6LyfryG2yrAYOF9DEdIz4Nt45BQDwRh9hSSoxw+/1bqgq0Pk
	9G6gT1Wx+Do7nF4o9kVQ7PBYhUGYHFbR4YvNDEKto8F3WJwSsys41luqgOP0yg==
X-Gm-Gg: ASbGncv+8ETQznY4jcvhd99ImN73t7EjXFQmdtUfiBX6nmY3WJSzPfIG+Pk6Y0e1/wQ
	115Qg/jI15IZ7bfU9aaO5kxjFflLZhSX9T4mlUmCqELaxC810AT5xs3sBPzFIHn/B1ZsVMD9oya
	5+aAIZtcg64sgmPfTiiQR/DEuVZuiyd6xLGpK2wTbulmxD3i0qSjJJ4Y9ISBJso+WkLSAm7lmHI
	gD2+JvIJ5rFiBo3xZ1p1NA4BeSiQMlFZloVWO0+TzQ9fv3VmYxiw39wBjJWQZVpzsPVQQ2hQRH8
	BLGMXkqAAG+fa1/HXocmNTuxFNFdq8gv53EVsmAWxejmNbYWHmucAnkL+iEq/Jenkw8Zy9LFcAL
	vRsQEbIc5pqEqXspG+kW8zG+SEOyeYll5u5eU1LfP/Cy2PplsCj4fAR8ja0S7GkSRRHyrmrtXuE
	2y
X-Google-Smtp-Source: AGHT+IE9U7zFGdsSuvgA9SdnoLewsuIB34kJy2/gwgX0GcnA53lpV6OMCis7s9RnAPnZml7SaXf1fg==
X-Received: by 2002:a17:90b:578c:b0:340:c151:2d6c with SMTP id 98e67ed59e1d1-3434c576561mr875516a91.29.1762468918282;
        Thu, 06 Nov 2025 14:41:58 -0800 (PST)
Received: from [127.0.0.1] ([68.220.59.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c332f1csm509169a91.11.2025.11.06.14.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 14:41:57 -0800 (PST)
Message-Id: <60015bbadaf90f40b3b56d2e32b9f48818cb8675.1762468914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2075.v5.git.git.1762468914.gitgitgadget@gmail.com>
References: <pull.2075.v4.git.git.1762034252.gitgitgadget@gmail.com>
	<pull.2075.v5.git.git.1762468914.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Nov 2025 22:41:54 +0000
Subject: [PATCH v5 2/2] blame: make diff algorithm configurable
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
index 0000000000..55e1d540dc
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
+	git blame file.c > output &&
+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
+	sed -e "s/ *$//g" without_varying_parts > actual &&
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
+	git blame file.c --diff-algorithm histogram > output &&
+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > without_varying_parts &&
+	sed -e "s/ *$//g" without_varying_parts > actual &&
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
+	git -c diff.algorithm=histogram blame file.c > output &&
+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" \
+	    -e "s/ *$//g" output > actual &&
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
+	git -c diff.algorithm=myers blame file.c --diff-algorithm histogram > output &&
+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" \
+	    -e "s/ *$//g" output > actual &&
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
+	git blame file.txt --minimal > output &&
+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > actual &&
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
+	git blame file.txt --minimal --diff-algorithm myers > output &&
+	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
gitgitgadget
