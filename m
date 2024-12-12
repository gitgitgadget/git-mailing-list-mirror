Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544B72101A3
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999358; cv=none; b=hVdf3FyUbqIusHyzOd8OwQN0f2QvrqnSMHQLvkY1sc+XxKUrtVii2iNkhaI/qgFJVN3D0Py8pBZkOomcQuld1pfPrlVhrmR+yDlApMVTsuiFrzpJMNyCFBI37rGcic5JhUIKTIKxHHR0XTg4FvBonntgf75Hogb3DHoiFaUxuf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999358; c=relaxed/simple;
	bh=dgA0+SFCIxEtap21VTdlvkkUddl6S6YprXVs4deag1c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KlDNToyk1HkwKtOeBKuDnjJhP4pN5AljkpOSy3NTcglURCovqhZBysJbJtt3KrdhF5h9xnyJa5BN69M89Fd+PYTiOe4QBRonQy+wYFdm3flFhbk9XJedcL0yrTxXmfsZeVez0Tx0BmpXsrIubrKiv0an/zgpuefTLnvMkqLCjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca4mtDm1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca4mtDm1"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-386329da1d9so184302f8f.1
        for <git@vger.kernel.org>; Thu, 12 Dec 2024 02:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733999354; x=1734604154; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjcIAEkazCknbAZoSv2UmC8EFAZyAoBl3ROZVa0b/8c=;
        b=Ca4mtDm1fuZE1dNbuYd5Cauu+wmrJri4IZJXGreKUCk+QLC0AzijW9IDPksA78ox25
         ua/da9hmyxvbUT/Sz9eEBv+EBkqdXb3nj+U6zrgWX9bLwo3u+SPggW/1aj6Z/DLYA82v
         /vR2jkGfEvNLuiaro+EBfngJ+FNd4DFIFrH9VlHOcIFBcBWIl+mDdhMx/ksGwmtJ44uI
         aQyMtPjEUL09KHpTcThBBhzWcAF7Ahzsi/3bU9FtAC0t9MJXLQbbgbUuocm9VK4IFyrV
         xbqnvfp9+QlQRN1Q2SsIaxoSmuWPoIVXFzaqAZpF8D11TLN+EsD+yNd6JOVB+OcA9lUn
         S6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733999354; x=1734604154;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjcIAEkazCknbAZoSv2UmC8EFAZyAoBl3ROZVa0b/8c=;
        b=OsUinFU8gh7n/eEfEdjmWmvISPPJ9j3GtdRNkH7wtUajCuUxN15d4td4rYHg9LXzVe
         waHx64YSgn1Ci4Ep4VlgdFIHdee+YNY4J9R1SL7jZX5JznvxYrl6sQ5PTu49l6/Jy5II
         YTX1aQTlz7tksCs94EGosFoulyx06ott2tBC+ul0JO+q7jXVgDR3z5wxDZzbgg6iXWiZ
         SNLQ7nmf7FbkbVzCSNvyKmKFxmw9uQPpumxMB2MvB79MW3jFBT4PD4dm3xzBVfyTpRSj
         Mo1+8qapc2WFGnBypGsSnTZgIimyKoqwIfyc6oNlLtS/gdkphbxIWa6jIJQrZkRB+tYM
         PrCA==
X-Gm-Message-State: AOJu0YwaB9y+xM5WVUNsuxqmowAzelRVt87lNEl3+RIZLTQslxfCqC+3
	ZS9hYpzTd7frcDxEy/TpxcD/fKMn7UO5iMS0Gc8IdVKeHLVVs5eYZ+jJOQ==
X-Gm-Gg: ASbGncs5Qas54Oube24mwBf7ntLARzP/xo24GOshaYizd7G+mZJAuKBccnrPszhwKkw
	PG2VYjWMsq+HQXFzjNqmHfEeaKsVHbC8W7QG4Ro87KUhr+UuSbQzt9+EpcrWuiIX87sHrpBqyDH
	vD+OpNfOmqgHQHDZyP4Ln6qRYWryf55BuGrMk9iSr2jR9i4tbGUuil6VdfaeN8mbuTatmFGV4hc
	KIn/6dwHgfLCr9hDlA4E0do4C0Cu19/ZSu3Q6o4P/FD320fpcvbMoCdvw==
X-Google-Smtp-Source: AGHT+IEr9YAWD3dadH59A/f0dtyMypoaciuRCWgnXkGuzHxFIiM5vubQyXnjy9ecAZJ5JcrAw7MeTQ==
X-Received: by 2002:a05:6000:4804:b0:385:e429:e59a with SMTP id ffacd0b85a97d-3864ce5ff30mr5108706f8f.25.1733999353916;
        Thu, 12 Dec 2024 02:29:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878251c1d7sm3577343f8f.91.2024.12.12.02.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:29:13 -0800 (PST)
Message-Id: <pull.1825.v3.git.1733999352289.gitgitgadget@gmail.com>
In-Reply-To: <pull.1825.v2.git.1731350009491.gitgitgadget@gmail.com>
References: <pull.1825.v2.git.1731350009491.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 12 Dec 2024 10:29:12 +0000
Subject: [PATCH v3] log: --remerge-diff needs to keep around commit parents
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

However, one optimization that hails all the way back to cb115748ec0d
(Some more memory leak avoidance, 2006-06-17) is to release the commit's
list of parents immediately after showing it _and to set that parent
list to `NULL`_. This can break the merge base computation.

This problem is most obvious when traversing the commits in reverse: In
that instance, if a parent of a merge commit has been shown as part of
the `git log` command, by the time the merge commit's diff needs to be
computed, that parent commit's list of parent commits will have been set
to `NULL` and as a result no merge base will be found (even if one
should be found).

Traversing commits in reverse is far from the only circumstance in which
this problem occurs, though. There are many avenues to traversing at
least one commit in the revision walk that will later be part of a merge
base computation, for example when not even walking any revisions in
`git show <merge1> <merge2>` where `<merge1>` is part of the commit
graph between the parents of `<merge2>`.

Another way to force a scenario where a commit is traversed before it
has to be traversed again as part of a merge base computation is to
start with two revisions (where the first one is reachable from the
second but not in a first-parent ancestry) and show the commit log with
`--topo-order` and `--first-parent`.

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
    
    Changes since v2:
    
     * Amended the commit message to illustrate why reverse walks are not
       the only instances where this fix is relevant.
    
    Changes since v1:
    
     * Amended the code comment of the affected conditional code block in
       harmony with the newly-added condition.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1825%2Fdscho%2Flog-remerge-diff-needs-commit-parents-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1825/dscho/log-remerge-diff-needs-commit-parents-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1825

Range-diff vs v2:

 1:  afff27f8222 ! 1:  ab75a565b4c log: --remerge-diff needs to keep around commit parents
     @@ Commit message
          work, the merge base(s) need to be found, which means that the commits'
          parents have to be traversed until common ancestors are found (if any).
      
     -    However, one optimization that hails all the way back to
     -    cb115748ec0d (Some more memory leak avoidance, 2006-06-17) is to release
     -    the commit's list of parents immediately after showing it. This can break
     -    the merge base computation.
     -
     -    Note that it matters more clearly when traversing the commits in
     -    reverse: In that instance, if a parent of a merge commit has been shown
     -    as part of the `git log` command, by the time the merge commit's diff
     -    needs to be computed, that parent commit's list of parent commits will
     -    have been set to `NULL` and as a result no merge base will be found.
     +    However, one optimization that hails all the way back to cb115748ec0d
     +    (Some more memory leak avoidance, 2006-06-17) is to release the commit's
     +    list of parents immediately after showing it _and to set that parent
     +    list to `NULL`_. This can break the merge base computation.
     +
     +    This problem is most obvious when traversing the commits in reverse: In
     +    that instance, if a parent of a merge commit has been shown as part of
     +    the `git log` command, by the time the merge commit's diff needs to be
     +    computed, that parent commit's list of parent commits will have been set
     +    to `NULL` and as a result no merge base will be found (even if one
     +    should be found).
     +
     +    Traversing commits in reverse is far from the only circumstance in which
     +    this problem occurs, though. There are many avenues to traversing at
     +    least one commit in the revision walk that will later be part of a merge
     +    base computation, for example when not even walking any revisions in
     +    `git show <merge1> <merge2>` where `<merge1>` is part of the commit
     +    graph between the parents of `<merge2>`.
     +
     +    Another way to force a scenario where a commit is traversed before it
     +    has to be traversed again as part of a merge base computation is to
     +    start with two revisions (where the first one is reachable from the
     +    second but not in a first-parent ancestry) and show the commit log with
     +    `--topo-order` and `--first-parent`.
      
          Let's fix this by special-casing the `remerge_diff` mode, similar to
          what we did with reflogs in f35650dff6a4 (log: do not free parents when


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
