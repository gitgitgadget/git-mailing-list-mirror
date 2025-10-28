Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EB826FD9A
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686067; cv=none; b=lw3pNJrsf4sTT0ITkZs5LO0Dj7xJAgBpxUezoJ9BEv7dYlX1D3erEAVUil5DjPcnAMH82e86/qfP6f35+aRYnqG3r3KFf32cmP9suleyNv4NT5ZnYnRG+IshrvokWnMiP1xr7uBAvedfH04ecJQy0zpS9sSn251QnpkkdxgHC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686067; c=relaxed/simple;
	bh=/WWx+gzHiVbBthTR8H+vbAp9tju9sJ92w91o0JFeQK8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fhsA3sY7LlrGs3tU7Qy0nn/wxzy+zvIjnWH40pPUcJ4GfPdzaECZhTnmbXEtVT2rczKC+JTTpv4KdWBFJiazn7gOwLOInEPr2qAQwUDnU6/gQ9/nOxNeWHRItUpmXJHfD9uJLSNXlSRF6Gue3a8qbnx55yvnQTqK3IeBolD6xxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L38PASMu; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L38PASMu"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-430a5fe0c5cso58185625ab.0
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 14:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761686064; x=1762290864; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kUXmmPfwlqI3u4b6z31Agw191B25cO1Mk4rcSa/MpA=;
        b=L38PASMuw+Msfq98DU9pBy83d3XB/KWK9VyUMvMrMAP+5EIHFzErPo74kQoEpMWwvy
         I9JqOwxbatMNPlGF9d7MhzXfU4kZghiKNwMvLNkEZr4WssHeb6oZoxLpoaWZpMwP7c2r
         fnD0KBVCQbJpE/gJvsALtLR06FefWOl0fBTk1STdVA0pVYjedlampUmH3/4fW3bIFQPj
         vvU0LXZ6635ND2+lVTqJtIYXlCuS4+czPe1nmfiVyYu/9RHEb5O9TzrqyTry2K6lp0Nk
         MgZANUeLMfLI6AT0KtM15u7wpMsm7dXI+20PxXsqtTu3BhesJ4wL2SA9Bf97jeYENtSt
         I0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686064; x=1762290864;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kUXmmPfwlqI3u4b6z31Agw191B25cO1Mk4rcSa/MpA=;
        b=a9LRrF4YzyW4DmW1yeCV7Hmbi4Rczm7/1SfFYnjvFgn7jMh0lDz7MG91V4T2EDa4sE
         alrUfU+r+h7036TMhPQZgpAdohyiK/nsvm00mqAjNGocOjKGM3i7uR/3/6YfLpH25Vq+
         x45kdynRqVE6mvxZ+/AmQSalIHPukPnT0aNfFfR5nRaakldYjrgjnWBl6TfuRGpOWze/
         h3XfxdoYjliThK8T8VVQMdWghs6049v9hSNYi8qHWroFqNEVWTGczvCnZatUJk4dbyGi
         R0qdy0Cr2fZLVgeSEwE7EFNAgnHDMxmb85caOI+p5AZx4VSfF5D0AaujqjZ5FZ2xm6T4
         b3xA==
X-Gm-Message-State: AOJu0YzPF0wx4XuJgTndLZnLWpqRywHQMqcvD0L3g3aTpQSsarm9ZuTb
	GSYBTuDbW9QKWa5IqlQiZIxiUqW43D/PA2SRx4hipsLeZd/I/F91OEcVui8VOA==
X-Gm-Gg: ASbGncv7DVWwjRnfj8AjjAa2s38DdErf3CYLiIB6833uv91m0av2XFyogB+9yrxEYnA
	vrCKO74en2Nx3bgZzuFwzKt9tK30FjaK1WVRaCLvmErLbXmu2lD3FpKZZtLhdgJ4bM9G4plNRIv
	XjH/onBbncPRyZUPKaNjVZxP+WTRE88SuM2ZBedqMcMx2pMo00BK1b46fBtqhnenfC+ORcwmbRZ
	v/IkG09BtfdzcDt5uwqGyd/Q9bwGaA8RfYHbMDmXnpfC1U1JMu9+h8ZQNs+0N0RQ9mC1ztMa3QC
	iaaNpl0KFnAAhHL9MD3k89APzQ3mtFm4q2YLOqcxa4ZlR5ul2i5/20uQHVIgOZUy6P8b+Ocidq7
	C4NctxCbk6+XPjbfzMMGAi9RMnisxDt4al5HdS+xR4qATtxHDVIU+Tu3PhJbTk7fPT4Zk6+Vpii
	CuoA==
X-Google-Smtp-Source: AGHT+IEc2MnkwWCTBiWga6t1rhqfMRy+bDjSUlK1Q7A3jUQgxPjzu/+adsLws3mrU4C//RT3OqN8EA==
X-Received: by 2002:a92:cd84:0:b0:430:ae8a:40ae with SMTP id e9e14a558f8ab-432f9028c5emr8948695ab.15.1761686063967;
        Tue, 28 Oct 2025 14:14:23 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.19.197])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f688b3d6sm47839075ab.24.2025.10.28.14.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:14:21 -0700 (PDT)
Message-Id: <pull.2075.v3.git.git.1761686060477.gitgitgadget@gmail.com>
In-Reply-To: <pull.2075.v2.git.git.1761658643278.gitgitgadget@gmail.com>
References: <pull.2075.v2.git.git.1761658643278.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Oct 2025 21:14:20 +0000
Subject: [PATCH v3] blame: make diff algorithm configurable
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
    blame: make diff algorithm configurable
    
    Changes since v1:
    
     * add tests
     * ignore --diff-algorithm when it is provided before --minimal
     * improve patch description
     * remove duplication of documentation sections
     * style improvements

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2075%2Fwetneb%2Fblame_respects_diff_algorithm-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2075/wetneb/blame_respects_diff_algorithm-v3
Pull-Request: https://github.com/git/git/pull/2075

Range-diff vs v2:

 1:  107f51620b ! 1:  b8bdb03516 blame: make diff algorithm configurable
     @@ builtin/blame.c: int cmd_blame(int argc,
       		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list, N_("file"), N_("ignore revisions from <file>")),
       		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
       		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
     +-		OPT_BIT(0, "minimal", &xdl_opts, N_("spend extra cycles to find better match"), XDF_NEED_MINIMAL),
      +		OPT_CALLBACK_F(0, "minimal", &xdl_opts, NULL,
      +			       N_("spend extra cycles to find better match"),
      +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
      +			       blame_diff_algorithm_minimal),
     - 		OPT_BIT(0, "minimal", &xdl_opts, N_("spend extra cycles to find better match"), XDF_NEED_MINIMAL),
       		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("use revisions from <file> instead of calling git-rev-list")),
       		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("use <file>'s contents as the final image")),
     + 		OPT_CALLBACK_F('C', NULL, &opt, N_("score"), N_("find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback),
      
       ## t/meson.build ##
      @@ t/meson.build: integration_tests = [
     @@ t/t8015-blame-diff-algorithm.sh (new)
      +	cat >file.c <<-\EOF &&
      +	int f(int x, int y)
      +	{
     -+		if (x == 0)
     -+		{
     -+			return y;
     -+		}
     -+		return x;
     ++	  if (x == 0)
     ++	  {
     ++	    return y;
     ++	  }
     ++	  return x;
      +	}
      +
      +	int g(size_t u)
      +	{
     -+		while (u < 30)
     -+		{
     -+			u++;
     -+		}
     -+		return u;
     ++	  while (u < 30)
     ++	  {
     ++	    u++;
     ++	  }
     ++	  return u;
      +	}
      +	EOF
      +	test_write_lines x x x x >file.txt &&
      +	git add file.c file.txt &&
     -+	GIT_AUTHOR_NAME=Initial git commit -m Initial &&
     ++	GIT_AUTHOR_NAME=Commit_1 git commit -m Commit_1 &&
      +
      +	cat >file.c <<-\EOF &&
      +	int g(size_t u)
      +	{
     -+		while (u < 30)
     -+		{
     -+			u++;
     -+		}
     -+		return u;
     ++	  while (u < 30)
     ++	  {
     ++	    u++;
     ++	  }
     ++	  return u;
      +	}
      +
      +	int h(int x, int y, int z)
      +	{
     -+		if (z == 0)
     -+		{
     -+			return x;
     -+		}
     -+		return y;
     ++	  if (z == 0)
     ++	  {
     ++	    return x;
     ++	  }
     ++	  return y;
      +	}
      +	EOF
      +	test_write_lines x x x A B C D x E F G >file.txt &&
      +	git add file.c file.txt &&
     -+	GIT_AUTHOR_NAME=Second git commit -m Second
     ++	GIT_AUTHOR_NAME=Commit_2 git commit -m Commit_2
      +'
      +
      +test_expect_success 'blame uses Myers diff algorithm by default for now' '
      +	cat >expected <<-\EOF &&
     -+	Second
     -+	Initial
     -+	Second
     -+	Initial
     -+	Second
     -+	Initial
     -+	Second
     -+	Initial
     -+	Initial
     -+	Second
     -+	Initial
     -+	Second
     -+	Initial
     -+	Second
     -+	Initial
     -+	Second
     -+	Initial
     ++	Commit_2 int g(size_t u)
     ++	Commit_1 {
     ++	Commit_2   while (u < 30)
     ++	Commit_1   {
     ++	Commit_2     u++;
     ++	Commit_1   }
     ++	Commit_2   return u;
     ++	Commit_1 }
     ++	Commit_1
     ++	Commit_2 int h(int x, int y, int z)
     ++	Commit_1 {
     ++	Commit_2   if (z == 0)
     ++	Commit_1   {
     ++	Commit_2     return x;
     ++	Commit_1   }
     ++	Commit_2   return y;
     ++	Commit_1 }
      +	EOF
      +
     -+	# git blame file.c | grep --only-matching -e Initial -e Second > actual &&
     -+	# test_cmp expected actual
     -+	echo goo
     ++
     ++	git blame file.c | \
     ++		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" | \
     ++		sed -e "s/ *$//g" > actual &&
     ++	test_cmp expected actual
      +'
      +
      +test_expect_success 'blame honors --diff-algorithm option' '
      +	cat >expected <<-\EOF &&
     -+	Initial
     -+	Initial
     -+	Initial
     -+	Initial
     -+	Initial
     -+	Initial
     -+	Initial
     -+	Initial
     -+	Second
     -+	Second
     -+	Second
     -+	Second
     -+	Second
     -+	Second
     -+	Second
     -+	Second
     -+	Second
     ++	Commit_1 int g(size_t u)
     ++	Commit_1 {
     ++	Commit_1   while (u < 30)
     ++	Commit_1   {
     ++	Commit_1     u++;
     ++	Commit_1   }
     ++	Commit_1   return u;
     ++	Commit_1 }
     ++	Commit_2
     ++	Commit_2 int h(int x, int y, int z)
     ++	Commit_2 {
     ++	Commit_2   if (z == 0)
     ++	Commit_2   {
     ++	Commit_2     return x;
     ++	Commit_2   }
     ++	Commit_2   return y;
     ++	Commit_2 }
      +	EOF
      +
     -+	git blame file.c --diff-algorithm=histogram | \
     -+		grep --only-matching -e Initial -e Second > actual &&
     ++	git blame file.c --diff-algorithm histogram | \
     ++		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" | \
     ++		sed -e "s/ *$//g" > actual &&
      +	test_cmp expected actual
      +'
      +
      +test_expect_success 'blame honors diff.algorithm config variable' '
      +	cat >expected <<-\EOF &&
     -+	Initial
     -+	Initial
     -+	Initial
     -+	Initial
     -+	Initial
     -+	Initial
     -+	Initial
     -+	Initial
     -+	Second
     -+	Second
     -+	Second
     -+	Second
     -+	Second
     -+	Second
     -+	Second
     -+	Second
     -+	Second
     ++	Commit_1 int g(size_t u)
     ++	Commit_1 {
     ++	Commit_1   while (u < 30)
     ++	Commit_1   {
     ++	Commit_1     u++;
     ++	Commit_1   }
     ++	Commit_1   return u;
     ++	Commit_1 }
     ++	Commit_2
     ++	Commit_2 int h(int x, int y, int z)
     ++	Commit_2 {
     ++	Commit_2   if (z == 0)
     ++	Commit_2   {
     ++	Commit_2     return x;
     ++	Commit_2   }
     ++	Commit_2   return y;
     ++	Commit_2 }
      +	EOF
      +
      +	git config diff.algorithm histogram &&
      +	git blame file.c | \
     -+		grep --only-matching -e Initial -e Second > actual &&
     ++		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" | \
     ++		sed -e "s/ *$//g" > actual &&
      +	test_cmp expected actual
      +'
      +
     ++test_expect_success 'blame gives priority to --diff-algorithm over diff.algorithm' '
     ++	cat >expected <<-\EOF &&
     ++	Commit_1 int g(size_t u)
     ++	Commit_1 {
     ++	Commit_1   while (u < 30)
     ++	Commit_1   {
     ++	Commit_1     u++;
     ++	Commit_1   }
     ++	Commit_1   return u;
     ++	Commit_1 }
     ++	Commit_2
     ++	Commit_2 int h(int x, int y, int z)
     ++	Commit_2 {
     ++	Commit_2   if (z == 0)
     ++	Commit_2   {
     ++	Commit_2     return x;
     ++	Commit_2   }
     ++	Commit_2   return y;
     ++	Commit_2 }
     ++	EOF
     ++
     ++	git config diff.algorithm myers &&
     ++	git blame file.c --diff-algorithm histogram | \
     ++		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" | \
     ++		sed -e "s/ *$//g" > actual &&
     ++	test_cmp expected actual
     ++'
      +test_expect_success 'blame honors --minimal option' '
      +	cat >expected <<-\EOF &&
     -+	Initial
     -+	Initial
     -+	Initial
     -+	Second
     -+	Second
     -+	Second
     -+	Second
     -+	Initial
     -+	Second
     -+	Second
     -+	Second
     ++	Commit_1 x
     ++	Commit_1 x
     ++	Commit_1 x
     ++	Commit_2 A
     ++	Commit_2 B
     ++	Commit_2 C
     ++	Commit_2 D
     ++	Commit_1 x
     ++	Commit_2 E
     ++	Commit_2 F
     ++	Commit_2 G
      +	EOF
      +
      +	git blame file.txt --minimal | \
     -+		grep --only-matching -e Initial -e Second > actual &&
     ++		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" > actual &&
      +	test_cmp expected actual
      +'
      +
     ++test_expect_success 'blame respects the order of diff options' '
     ++	cat >expected <<-\EOF &&
     ++	Commit_1 x
     ++	Commit_1 x
     ++	Commit_1 x
     ++	Commit_2 A
     ++	Commit_2 B
     ++	Commit_2 C
     ++	Commit_2 D
     ++	Commit_2 x
     ++	Commit_2 E
     ++	Commit_2 F
     ++	Commit_2 G
     ++	EOF
     ++
     ++	git blame file.txt --minimal --diff-algorithm myers | \
     ++		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" > actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++
      +test_done


 Documentation/diff-algorithm-option.adoc |  20 +++
 Documentation/diff-options.adoc          |  21 +--
 Documentation/git-blame.adoc             |   2 +
 builtin/blame.c                          |  53 +++++-
 t/meson.build                            |   1 +
 t/t8015-blame-diff-algorithm.sh          | 206 +++++++++++++++++++++++
 6 files changed, 282 insertions(+), 21 deletions(-)
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
index 2703820258..da4dbdf50a 100644
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
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+
+	*opt &= ~XDF_DIFF_ALGORITHM_MASK;
+	*opt |= XDF_NEED_MINIMAL;
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
+	*opt &= ~(XDF_NEED_MINIMAL | XDF_DIFF_ALGORITHM_MASK);
+	*opt |= value;
+
+	return 0;
+}
+
 static int is_a_rev(const char *name)
 {
 	struct object_id oid;
@@ -915,11 +960,17 @@ int cmd_blame(int argc,
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
+			       N_("spend extra cycles to find better match"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			       blame_diff_algorithm_minimal),
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
index 0000000000..efc4b47ce1
--- /dev/null
+++ b/t/t8015-blame-diff-algorithm.sh
@@ -0,0 +1,206 @@
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
+test_expect_success 'blame uses Myers diff algorithm by default for now' '
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
+
+	git blame file.c | \
+		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" | \
+		sed -e "s/ *$//g" > actual &&
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
+	git blame file.c --diff-algorithm histogram | \
+		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" | \
+		sed -e "s/ *$//g" > actual &&
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
+	git config diff.algorithm histogram &&
+	git blame file.c | \
+		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" | \
+		sed -e "s/ *$//g" > actual &&
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
+	git config diff.algorithm myers &&
+	git blame file.c --diff-algorithm histogram | \
+		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" | \
+		sed -e "s/ *$//g" > actual &&
+	test_cmp expected actual
+'
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
+	git blame file.txt --minimal | \
+		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" > actual &&
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
+	git blame file.txt --minimal --diff-algorithm myers | \
+		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" > actual &&
+	test_cmp expected actual
+'
+
+
+test_done

base-commit: 4253630c6f07a4bdcc9aa62a50e26a4d466219d1
-- 
gitgitgadget
