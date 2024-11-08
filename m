Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C3192B95
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073440; cv=none; b=eBaP1qI3BF28c1ImSxLdoCeYksLPXDd1Rq+KfItF8OY9ZpKyRfRZXOR/nrRvMbiktEjIvaB6Cb95DrtamrYm4fSGCY/ZsVDQ6rCgQvDArfC6/FbAVV/r0TFK89zfjAjunvX/fI17z0Z1OPR5JBbs6NmTR7d1qj/C+5kKCzIXywU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073440; c=relaxed/simple;
	bh=RbUMUwFc2qEpNrg/mNUyKyc9bbaZzs1oaJRUxGVcyNA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=jlWJwyAj6xXV9PF2tb9hJpnrXADoZzAz0GK44PLIJSMS+GR4DzDCRJupBa3nJkjJ8jXnDVjAchDrvCvPfWhTFF07GKjv+rtM4UqZ8M+5Doup95zpgM4/Qo5c9M1+o8B4eDbJJSOYtfI6kCkPGzoLPQG8RmxDgvc6X2yG7Nut8V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpmDZ+es; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpmDZ+es"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso19690665e9.0
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 05:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731073437; x=1731678237; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CnxSepK0/8WCg+0t8RC7mxHb0KK3R3ZFu7aD/0t6FnA=;
        b=NpmDZ+es3ZQmu+Hx6FrC0oESNqyT4ihSAvyeb1VnLz0R0rKeU1bGgVqDyQa0a241VI
         5TPZ2uX8ppcnQhKUxPGbyTkMyh7DgQMCl4aspBcOLl0ameFyPxBkAZ+9PHNINTp2Pgvp
         uRinC0+uTU3hVKe8AAm4+86N/ELf4B03vhbma2YVp500TPNJBGtkLUTMEghBXwS9Oit1
         Y7t9boETGdj2AxFrNNkIlZRFa3DF90QfJ6pHHzK8lIBZN5FQ8c1V2QpnHCtfe7//7TTV
         Ly03xS4Se/XYEqXeh+Z92TPoyKbOWGmgQhinz53nXv4ZxfPFlfABDb+Vpek4QV4SfKoe
         MIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731073437; x=1731678237;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnxSepK0/8WCg+0t8RC7mxHb0KK3R3ZFu7aD/0t6FnA=;
        b=Vg51ENwUOSwNvSCdJ/1NswWzd8WVvU6oyAifkM/M94AsG46g7BlPFsBV9lueyNI9P6
         T3EIHhs9ti8IuR3VJhIdWHWx3T9uOixVoFAprR+dTodgMm6GTJeJ08xsQi/kz9Hr7+mu
         +ZvqZiG28Zo/oV628UOmQn/XtFKe3Nvk3VjKbbo119NxWXSaHMZP2yGuqCseIoTmbnaF
         QCypA1Szqxs3mg5s57w7Qq6CZgKGaHiMZhKhMGiTMY6ZdEHKGD3l0YSJ4QDeWoqXA4vX
         SLaMqR/5ib86SdcwLGvAYWBPFo0M84VBOnMSPV+irRUwzndMyptXAWrDmPgI0okmzhlx
         xDJQ==
X-Gm-Message-State: AOJu0YyQjSKNNxWQB3+louZik0KaonO58PbSoMy2kAC9eipyevd+Cskn
	7SGAa/w16mmCNcRQOhTVIMLKVu+hKSBB2z2bA5AzF+oNm1vcmO10KgyCwQ==
X-Google-Smtp-Source: AGHT+IFb4Falda/hNvuVXn/FQrQE9IYEj4CnaM2fRRoRE7vPlkQoSf200dvOxb0cXea6diSIiTrT4A==
X-Received: by 2002:a05:600c:4f83:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-432b7517aa4mr22077655e9.21.1731073436909;
        Fri, 08 Nov 2024 05:43:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa70a23fsm110737345e9.33.2024.11.08.05.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:43:56 -0800 (PST)
Message-Id: <pull.1825.git.1731073435641.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Nov 2024 13:43:55 +0000
Subject: [PATCH] log: --remerge-diff needs to keep around commit parents
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1825%2Fdscho%2Flog-remerge-diff-needs-commit-parents-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1825/dscho/log-remerge-diff-needs-commit-parents-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1825

 builtin/log.c           | 2 +-
 t/t4069-remerge-diff.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index c0a8bb95e98..a297c6caf59 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -522,7 +522,7 @@ static int cmd_log_walk_no_free(struct rev_info *rev)
 			 * but we didn't actually show the commit.
 			 */
 			rev->max_count++;
-		if (!rev->reflog_info) {
+		if (!rev->reflog_info && !rev->remerge_diff) {
 			/*
 			 * We may show a given commit multiple times when
 			 * walking the reflogs.
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
