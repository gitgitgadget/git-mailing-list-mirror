Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A791B969
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956731; cv=none; b=PcyleYOkxF52EqPctaImeE4q4xSTZqt3Zyz8JVQc62T4APfdSb4FBBK5vhhMY7CkJ4rlNyIK9Exe7dadWd4L+7uzXsRlCeCRt5svnlqR6yF+Q1ykbiSqlSYSv5dhNYtHT/59uOmTXL+csnz+nX/OHYmuMI8ZdLgo9fm0LNb4uqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956731; c=relaxed/simple;
	bh=cSSONYwffILE9Zwm9D7dllDMUlkcRZZR4sVbgHtEVwQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PALlH3pEvcn7hltTTs0WXZBQsxKWMvOlqcsbTDFG9x0hX0PfkyudEceQGeCIGtwdl5Ak+z0ani6uvPKF0+hdHZgvkEls6I6/nK9dRNjdM4zhkkEuSSpB1e18D+NBeHLJW8S3qjVF+30Ldmzul6GzqxD1gcdbw7VTPFP0f6un6SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9Gmq4MZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9Gmq4MZ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c8af23a4fcso1085122a12.0
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 04:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727956728; x=1728561528; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+pJZ6fIL+kBWvYRwCGhv8uD94GYeNkvuaeGZxu4edg=;
        b=S9Gmq4MZjayxnmabffMzRja6J9DR03QNVVlA8UJ3rywlV9RiFHOI99IApWYV7o0xhx
         e0RX3ClxnJvm2JXNm9NoBKo9PGUw4rBKOM/79WB/mPaKRfKySHmwskVF2wRa4d4VuXBM
         KlfqwZ482qEtP6iW+BoPStGH3xMk88NwrPfK+gtU606MbRS8KauUuwsMjaavAkWf2yLA
         I9w+DQtR//yJnzQ2Nc7WTo+eGanilHU1p3K7r4p43z+c9yTKzBlnPmFopkTSOt8JeeQt
         4IPlHYPrRmKnjHPuD2YBDzynv0TIUjoT6juRwPS7fX7ojy5AU2ReIQe4QMy8LkOl2sIa
         IpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956728; x=1728561528;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+pJZ6fIL+kBWvYRwCGhv8uD94GYeNkvuaeGZxu4edg=;
        b=dxamiufNuAA3K9Hp5dWQ+QGuaW3e1hIbew9JOEBjgay1JrkPDOMHA4a0MnwmdQaInI
         QTHQ7eLSxz/seGVXGF+w9kr70ZKUXmkKk9ruAQsM5zy/ceXXkOzMT8JHVChyXclNyeso
         JSqT1p4xRYOi5e60k2yQKB0I1tjS5/NuVXVBrStEd2lBz3ZmbyuxmGwULmW1NiFnnXrN
         4JDVQpPvQw/s9y5ZZAYSr5PtRV8jYc+DjLaX8CQ7p3XrxwCMtGxUbJIxYs0qQg7pWYK1
         bjKmXrvT6NP7hK8+dBK0sjcysc+JurrkQi/J4HtSngxh/ajpQYZGHrB/WHg/uKNFCAkk
         1VUg==
X-Gm-Message-State: AOJu0YyZtMlsc1HtSa9a/77+IzCJW5jF2MM5jvNQNQed+deoK40aiT0l
	HgGesWaYLU/wcSxRI/iBs7YwFu1xht8GH2fncEc4xxDPyYHxMtf82p5xMg==
X-Google-Smtp-Source: AGHT+IGju7rO/prclquGNqzoIMjo9rMV1jcAWpCzV9mU99ckJl7Yy3ODFkbUuhPqqProgDw2lCHSvA==
X-Received: by 2002:a05:6402:40d4:b0:5c8:8bde:a1d3 with SMTP id 4fb4d7f45d1cf-5c8b1b727bdmr4982317a12.22.1727956727913;
        Thu, 03 Oct 2024 04:58:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ca4d6dcdsm629200a12.70.2024.10.03.04.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:58:46 -0700 (PDT)
Message-Id: <05c21616c350b5141c17fde1aa5d3aea881c6031.1727956724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1806.v2.git.1727956724.gitgitgadget@gmail.com>
References: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
	<pull.1806.v2.git.1727956724.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Oct 2024 11:58:42 +0000
Subject: [PATCH v2 1/3] line-log: protect inner strbuf from free
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
Cc: gitster@pobox.com,
    ps@pks.im,
    Jeff King <peff@peff.net>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The output_prefix() method in line-log.c may call a function pointer via
the diff_options struct. This function pointer returns a strbuf struct
and then its buffer is passed back. However, that implies that the
consumer is responsible to free the string. This is especially true
because the default behavior is to duplicate the empty string.

The existing functions used in the output_prefix pointer include:

 1. idiff_prefix_cb() in diff-lib.c. This returns the data pointer, so
    the value exists across multiple calls.

 2. diff_output_prefix_callback() in graph.c. This uses a static strbuf
    struct, so it reuses buffers across calls. These should not be
    freed.

 3. output_prefix_cb() in range-diff.c. This is similar to the
    diff-lib.c case.

In each case, we should not be freeing this buffer. We can convert the
output_prefix() function to return a const char pointer and stop freeing
the result.

This choice is essentially the opposite of what was done in 394affd46d
(line-log: always allocate the output prefix, 2024-06-07).

This was discovered via 'valgrind' while investigating a public report
of a bug in 'git log --graph -L' [1].

[1] https://github.com/git-for-windows/git/issues/5185

This issue would have been caught by the new test, when Git is compiled
with ASan to catch these double frees.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 line-log.c          | 10 ++++------
 t/t4211-line-log.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/line-log.c b/line-log.c
index 67c80b39a0d..29cf66bdd10 100644
--- a/line-log.c
+++ b/line-log.c
@@ -897,13 +897,13 @@ static void print_line(const char *prefix, char first,
 		fputs("\\ No newline at end of file\n", file);
 }
 
-static char *output_prefix(struct diff_options *opt)
+static const char *output_prefix(struct diff_options *opt)
 {
 	if (opt->output_prefix) {
 		struct strbuf *sb = opt->output_prefix(opt, opt->output_prefix_data);
 		return sb->buf;
 	} else {
-		return xstrdup("");
+		return "";
 	}
 }
 
@@ -916,7 +916,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 	struct diff_ranges *diff = &range->diff;
 
 	struct diff_options *opt = &rev->diffopt;
-	char *prefix = output_prefix(opt);
+	const char *prefix = output_prefix(opt);
 	const char *c_reset = diff_get_color(opt->use_color, DIFF_RESET);
 	const char *c_frag = diff_get_color(opt->use_color, DIFF_FRAGINFO);
 	const char *c_meta = diff_get_color(opt->use_color, DIFF_METAINFO);
@@ -1003,7 +1003,6 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 out:
 	free(p_ends);
 	free(t_ends);
-	free(prefix);
 }
 
 /*
@@ -1012,10 +1011,9 @@ out:
  */
 static void dump_diff_hacky(struct rev_info *rev, struct line_log_data *range)
 {
-	char *prefix = output_prefix(&rev->diffopt);
+	const char *prefix = output_prefix(&rev->diffopt);
 
 	fprintf(rev->diffopt.file, "%s\n", prefix);
-	free(prefix);
 
 	while (range) {
 		dump_diff_hacky_one(rev, range);
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 02d76dca284..950451cf6a6 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -337,4 +337,32 @@ test_expect_success 'zero-width regex .* matches any function name' '
 	test_cmp expect actual
 '
 
+test_expect_success 'show line-log with graph' '
+	qz_to_tab_space >expect <<-EOF &&
+	* $head_oid Modify func2() in file.c
+	|Z
+	| diff --git a/file.c b/file.c
+	| --- a/file.c
+	| +++ b/file.c
+	| @@ -6,4 +6,4 @@
+	|  int func2()
+	|  {
+	| -    return F2;
+	| +    return F2 + 2;
+	|  }
+	* $root_oid Add func1() and func2() in file.c
+	ZZ
+	  diff --git a/file.c b/file.c
+	  --- /dev/null
+	  +++ b/file.c
+	  @@ -0,0 +6,4 @@
+	  +int func2()
+	  +{
+	  +    return F2;
+	  +}
+	EOF
+	git log --graph --oneline -L:func2:file.c >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

