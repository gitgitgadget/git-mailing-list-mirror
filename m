Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF14229A5
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948668; cv=none; b=sB7er6QaMKBFH6wY307WCMvysXhGmbl4rz5/fO2ZmXGtYTPBbv+s9CsCF6sjotLs6CHBsRdpTXJbZ9bd8aVGPy8Xs1NkXr8HTDHEW+rGS24/PQ9q34qpz4nf54TnBNQJ2cT5JKMxupuLimgP9wijdUxAlydAdDKskb3sAcETkis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948668; c=relaxed/simple;
	bh=1H2qQ+u5fwE2B/VSbttGc40UBubNPA5zvAN+927IB3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMkaY/QA2lKwEWszEy0dasdXfJdjWgds60srK0DZC0Om2+dKGhk/Sfl6fSycU/6nzPNFpFbM+MtzGE0HxiuQrm+oq3nKNg9vcZwYl9pDzH/ZK8LU+dfErhhJWFK7gdze70ahsh27nStn0VBCvVQj8vVkkF9M92/JSxtP+2KgGxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UB9xuMov; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB9xuMov"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493c733f15aso30100865e9.0
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783948665; x=1784553465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=clxl7GIXrnkjs+M+W3KU9MKcckLaupJg4LBRFOhontY=;
        b=UB9xuMovoS6CPXiz6jYfNSWlWnRYsRuODV7o5SggGrAeXVLuuU80sQCVJFc/atLQtC
         etMVTGRPp8QNaKGNal2D7Epxx1ldncljQQhsuU8kYdn3AXYSjROXwxvv+JlB/O/gQGQ7
         H3vyB5oIO2FBLmtSHQSNcaF6BnwZANJcI02CxAAJJghPd+z5+asIyXT+KCMC9hoa07vJ
         /lgvYFFslWu/2veQv6aa/FQoz6qsXP/WSQy876PFHFGS2NAEf8vywIsw++lFPf94eG0U
         82Xz99INMU6eJgG96g/nm9IpV/MhNLX+wkDh1JUYOKSB8yNucERi5aNdvkv6Nx9bZG/x
         fuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948665; x=1784553465;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clxl7GIXrnkjs+M+W3KU9MKcckLaupJg4LBRFOhontY=;
        b=EKoedZnWpZ0G2+/blG7P0LZzVK7b32O75VlpsdNmpImtQ/UPVjN57v3BCjP66UOEtV
         XZemfDObHcaxBFydqUgu6CmvPyX39QwMjllV3LGImUVeS42FyOhfoDUw8mW1xcAFKzKe
         uM8hxXObmRXe8Npc2tZM4gmjQ5AXg5sB31QpDkWmhEj8oXR89dY8i+p/49SS70/vhICL
         LJzH+tHDUCZmsV0E6nw6KpvNLWG8oR8kxj9G92PLwepvXCVhhO0FGlD7qouKfL87Qev3
         9aBEEU3S2ZKmmXgcWeGQBiwU6r7LcIwgCgljblZUHGlPOzNOfe3GvhxJ3pxEP8zX1qx0
         VjCA==
X-Gm-Message-State: AOJu0YzPIlOCe7yoNMA+7OXgzIA13wyQPyPDwsRMIvqgnxQ56YkQfsrM
	59gDgB5EuQ7ndlZCwDq6Qo2wVrxPIUEvMdX/FzGKDh6moJZ/psP7obYzigX6Ug==
X-Gm-Gg: AfdE7cmEy6UcDc2x3GK8AUct+/1BWj1qKzHBunv59EIjKezi7jZsalj3NNd/ntAw1tC
	cSj4Ddh8AruH4jOD3o7TOMjwSuDDKpFagBDks7If/8ScCHHeSnd1eFfVVoA4qTaK3yi3+uvpBV2
	+L7x8pbS0MG/CZhYXsvYa3GvafmjawmPeKpubjUiEvvKfRpTJXY90fSRebyDyD4IBUj5/Sk8GQg
	PKC/XE1aCwpDbuHY3QRkxE0oA5p73hJGT+bPNqaoO6/raHKxV9n6NDcAeEy0al5mO2tIIxg293V
	Hr2UItqYMZp2/h3BV+rbZbmwQxMeYuT28vcMRuIhdnYJLs8B9/Mv8kSk4dmNXNJt7J8sqq19mVl
	CNbZNbrjp/UMzQ8yeWu79GVGbE7+Q3oW4mqL6ax/jJyv7DsKgbtzbfEW5eHe5HihblP5ll0iXP1
	Tg/9s0eZBBSH1F+UHM
X-Received: by 2002:a05:600c:464a:b0:492:7083:e5a with SMTP id 5b1f17b1804b1-493f882b117mr60851695e9.31.1783948665299;
        Mon, 13 Jul 2026 06:17:45 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4cbc620sm251653145e9.13.2026.07.13.06.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:17:44 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 03/10] sequencer: be more careful with external merge
Date: Mon, 13 Jul 2026 14:17:20 +0100
Message-ID: <3d79362332c1208eed1fb7f8b0d431ee92fe45c5.1783948637.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1783948637.git.phillip.wood@dunelm.org.uk>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk> <cover.1783948637.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If an external merge strategy cannot merge (for example because it
would overwrite an untracked file) it exits with a non-zero exit
code other than 1. This should be treated differently to a merge
with conflicts which is signalled by an exit code of 1 because as
the merge failed we need to reschedule the last pick. The caller
expects us to return -1 in this case. Also reschedule without trying
to merge if the commit message cannot be written as that prevents us
from successfully picking the commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                   | 19 +++++++++++++++----
 t/t3404-rebase-interactive.sh | 11 +++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 32a09b6e87d..21dd5ec9799 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2453,14 +2453,25 @@ static int do_pick_commit(struct repository *r,
 		struct commit_list *common = NULL;
 		struct commit_list *remotes = NULL;
 
-		res = write_message(ctx->message.buf, ctx->message.len,
-				    git_path_merge_msg(r), 0);
+		if (write_message(ctx->message.buf, ctx->message.len,
+				  git_path_merge_msg(r), 0)) {
+			res = -1;
+			goto leave;
+		}
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res |= try_merge_command(r, opts->strategy,
-					 opts->xopts.nr, opts->xopts.v,
+		res = try_merge_command(r, opts->strategy,
+					opts->xopts.nr, opts->xopts.v,
 					common, oid_to_hex(&head), remotes);
+		/*
+		 * If there were conflicts, try_merge_command() returns 1,
+		 * any other no-zero return code means that either the merge
+		 * command could not be run, or it failed to merge.
+		 */
+		if (res && res != 1)
+			res = -1;
+
 		commit_list_free(common);
 		commit_list_free(remotes);
 	}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 58b3bb0c271..297b84e60d5 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1249,6 +1249,17 @@ test_expect_success 'interrupted rebase -i with --strategy and -X' '
 	git rebase --continue &&
 	test $(git show conflict-branch:conflict) = $(cat conflict) &&
 	test $(cat file1) = Z
+'
+
+test_expect_success 'failing pick with --strategy is rescheduled' '
+	test_when_finished "rm -rf bin; test_might_fail git rebase --abort" &&
+	mkdir bin &&
+	echo exit 2 | write_script bin/git-merge-fail &&
+	git log -1 --format="pick %H # %s" HEAD >expect &&
+	test_must_fail env PATH="$PWD/bin:$PATH" \
+		git rebase --no-ff --strategy fail HEAD^ &&
+	test_cmp expect .git/rebase-merge/git-rebase-todo &&
+	test_cmp expect .git/rebase-merge/done
 '
 
 test_expect_success 'rebase -i error on commits with \ in message' '
-- 
2.54.0.200.gfd8d68259e3

