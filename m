Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F31145B16
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350015; cv=none; b=ir5dpbNw9l9u1Badxffu2U43qhRjgbs7Od+BfWx60i/EErys3M/GgSIdQsYk1xMYTPe1MrnjtW8K60fsCx2NHW96N0vIhhCmZ1eEP7kjLS0KyeiHJ4JtMLCXQ86Xk1nuF/+Rbgla58cLR0Tttge/16wb/tnsW437xIOu3EdXbLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350015; c=relaxed/simple;
	bh=HVZzUzQOshiE4UYnWSlLYrMmSFkeMcxgCbPTrOUFBgI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fDCD9QIwlZ8FdlViyS4NTk6IczfG2OuVn4+d3U14CvLwnCo5AP11QKTioJmWUKGTrDCJiKuCvo88FOzgyGgvKwa7uU0OoaWPnwuTpCOaKN9HwWPa9rwK3hL0aSub0J98XrJAbBtwsRAV4Vuf9xHtB9MWzFJp8qrvHn8VCxbJmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EteBp/hU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EteBp/hU"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43161c0068bso40712435e9.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731350011; x=1731954811; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=720Mg7m1a+RjGcuIYqC52rrHAjb5n0HVzgzpHe2bB9c=;
        b=EteBp/hUHdnbpiHuKHayg27gM24TpPkcmko0+pH11hro93ZBwy04WDuy79y2tqjf99
         abLfD/cfhEVMi9VaygxflnDI2/8VrBq6PFCOMhScJjPJ0sK4gqOIul86MrdJenapW9LN
         btqOVofW4dkMKAAj3T7xjebkhpqrhETs2Ip0hG0tT5whyN3U+0jzmcM7V1CNPY62JtdK
         S39UxcH48WLxe9PoJSaC7AoP50/6PRNxbPMovXavel5KG5dQt42vgDcr3xJg61hiHVwC
         o1PaBbMzVyxDrkoSW1G/JF2k3FFsK9lPCQZQ03JCUgF4ANfkFC4+vTWOgO0FGfFwK9PU
         Yx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731350011; x=1731954811;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=720Mg7m1a+RjGcuIYqC52rrHAjb5n0HVzgzpHe2bB9c=;
        b=TcxWJUBqI5vYCC+8ZCZ7NS+O5uY81L2YGpNZ00YI+I0QDVef7K6lLUs2hC/AGReg+W
         gSqPtCfWEJnrSOtS5/hjvt3mujVhz4B5RfxSF+XYdu31gylvS8NJvyAPbXxwfXH9uyMb
         EJlWvrSJfXhX4IlrZ390ceBRLkvzRGLf/FBgatkR28Z738hduQAi8mRp4rKeagUBPj9/
         vs4i59yBE34fIaF1RGAMXa3vLWlMKirDoC8O8A7ARteSclZwzOhE13U3MdjXIsFdtGoj
         BEy5bUd0DS1wzJcncXzIEYSwBSIGU0NPHhyFwhLyzb7txZ5iDv6TKiDMpzDyrmunpH2s
         sCvw==
X-Gm-Message-State: AOJu0YwPiaUsB8KRtnQHc5CVWAq2DKymcCMMOtIpXr2NxuG4fKZxhoHQ
	LVHJKoDXvJIv1o06XZb/YSu/2qVLK4rQXF4Ck/3ZiaFy2nyGR07WDJ2SCw==
X-Google-Smtp-Source: AGHT+IFh4s3SRsM3oQi1HTl16YUCbQXlBCKpR/9bU+RW2om2KLutOKfhqtNDnnLwmFlYzmpGps8Y2A==
X-Received: by 2002:a05:600c:3c8f:b0:431:52f5:f48d with SMTP id 5b1f17b1804b1-432b751f42fmr115451365e9.31.1731350010850;
        Mon, 11 Nov 2024 10:33:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c2161sm184170305e9.31.2024.11.11.10.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:33:30 -0800 (PST)
Message-Id: <pull.1825.v2.git.1731350009491.gitgitgadget@gmail.com>
In-Reply-To: <pull.1825.git.1731073435641.gitgitgadget@gmail.com>
References: <pull.1825.git.1731073435641.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Nov 2024 18:33:29 +0000
Subject: [PATCH v2] log: --remerge-diff needs to keep around commit parents
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Elijah Newren <newren@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To show a remerge diff, the merge needs to be recreated. For that to
work, the merge base(s) need to be found, which means that the commits'
parents have to be traversed until common ancestors are found (if any).

However, one optimization that hails all the way back to
cb115748ec0d (Some more memory leak avoidance, 2006-06-17) is to release
the commit's list of parents immediately after showing it. This can break
the merge base computation.

Note that it matters more clearly when traversing the commits in
reverse: In that instance, if a parent of a merge commit has been shown
as part of the `git log` command, by the time the merge commit's diff
needs to be computed, that parent commit's list of parent commits will
have been set to `NULL` and as a result no merge base will be found.

Let's fix this by special-casing the `remerge_diff` mode, similar to
what we did with reflogs in f35650dff6a4 (log: do not free parents when
walking reflog, 2017-07-07).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    log: --remerge-diff needs to keep around commit parents
    
    This fixes a bug that is pretty much as old as the remerge-diff
    machinery itself. I noticed it while writing my reply to Hannes Sixt's
    concerns about my range-diff --diff-merges=<mode> patch
    (https://lore.kernel.org/git/af576487-5de2-fba3-b341-3c082322c9ec@gmx.de/).
    
    Changes since v1:
    
     * Amended the code comment of the affected conditional code block in
       harmony with the newly-added condition.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1825%2Fdscho%2Flog-remerge-diff-needs-commit-parents-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1825/dscho/log-remerge-diff-needs-commit-parents-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1825

Range-diff vs v1:

 1:  68238315c14 ! 1:  afff27f8222 log: --remerge-diff needs to keep around commit parents
     @@ builtin/log.c: static int cmd_log_walk_no_free(struct rev_info *rev)
      +		if (!rev->reflog_info && !rev->remerge_diff) {
       			/*
       			 * We may show a given commit multiple times when
     - 			 * walking the reflogs.
     +-			 * walking the reflogs.
     ++			 * walking the reflogs. Therefore we still need it.
     ++			 *
     ++			 * Likewise, we potentially still need the parents
     ++			 * of * already shown commits to determine merge
     ++			 * bases when showing remerge diffs.
     + 			 */
     + 			free_commit_buffer(the_repository->parsed_objects,
     + 					   commit);
      
       ## t/t4069-remerge-diff.sh ##
      @@ t/t4069-remerge-diff.sh: test_expect_success 'remerge-diff turns off history simplification' '


 builtin/log.c           | 8 ++++++--
 t/t4069-remerge-diff.sh | 7 +++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c0a8bb95e98..2f88a3e607d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -522,10 +522,14 @@ static int cmd_log_walk_no_free(struct rev_info *rev)
 			 * but we didn't actually show the commit.
 			 */
 			rev->max_count++;
-		if (!rev->reflog_info) {
+		if (!rev->reflog_info && !rev->remerge_diff) {
 			/*
 			 * We may show a given commit multiple times when
-			 * walking the reflogs.
+			 * walking the reflogs. Therefore we still need it.
+			 *
+			 * Likewise, we potentially still need the parents
+			 * of * already shown commits to determine merge
+			 * bases when showing remerge diffs.
 			 */
 			free_commit_buffer(the_repository->parsed_objects,
 					   commit);
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 07323ebafe0..a68c6bfa036 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -317,4 +317,11 @@ test_expect_success 'remerge-diff turns off history simplification' '
 	test_cmp expect actual
 '
 
+test_expect_success 'remerge-diff with --reverse' '
+	git log -1 --remerge-diff --oneline ab_resolution^ >expect &&
+	git log -1 --remerge-diff --oneline ab_resolution >>expect &&
+	git log -2 --remerge-diff --oneline ab_resolution --reverse >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: bea9ecd24b0c3bf06cab4a851694fe09e7e51408
-- 
gitgitgadget
