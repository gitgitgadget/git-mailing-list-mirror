Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8E530DE1
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074348; cv=none; b=CXihCl8ibivEMJGO9Cyd7kfh4r44rOhS5hyHCQVBDtTDWtf4bTeUqL6hR+PVI10cKk288KbyGjuESR7BxGUNU/ym5MBXemBFoBlSw5t32tjLaZZrqtNifTYMYyUwtMbFawEyAcJ+XLnCZ1vmbstU3LtyEp1Nn9EDDT78LYo+GpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074348; c=relaxed/simple;
	bh=pQDSf3F8de3zNwQ8fGiiJjdIrnDRXZzlZYk+TL2snrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUNMNQ21pxPKyyeVrHkZYWh2Wzovhwy2l6VxSrXqHgs4KT3HxYl+mBf37kerGAXVvBsJ+3jWdvVDp7dG3sycL2mxTIgHcc2pqCUrNiWPdPxV2uzUBjGAKNa4NI2HHKJnL40UTTcqRYCcvRC2paB+HbuKHoqMSiokOgL85Rf3XEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGlsl7sW; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGlsl7sW"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2e69aa07c3so333147866b.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074341; x=1792679141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y1ZwdeUh226bSuX/lFH8esK1j0ZdyZnvfyMT/XS0LTY=;
        b=GGlsl7sWS3RobzytkGOlkTMTxbaMaZAFQf9a9rHM9v1ekXKmxvU9qtGaDdJye892Hy
         xRDocT5bIZ8NlYTNgYPnQx0mYkMjKdFZrRc0wf+mUxLoWHvd+zM6AlNN6A4rfTWF7tHZ
         45U/C/2QNsipx28Qtk7NWfMxRsPjCfktdJRcFIR3V7U5YtfY/FgI8e98VxXCWR+WWJbH
         OklergaSN1gJaNV+KL6/QwD7v9oA+0+NJ1D00mOP0dGSuAtFVBmuOlXtVY6MBWF+E0JB
         lnl/n2tvtrXInL5QRHrTbMwTDe80oz7KCJyS2gljwqNP4lU1Pw/fBaxwxSRDKPBlKa49
         NEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074341; x=1792679141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y1ZwdeUh226bSuX/lFH8esK1j0ZdyZnvfyMT/XS0LTY=;
        b=DEWeaVUTrl4TulyL1VVMXpPpEIHci9/lvvrNFGg5aY4gqmVl5GV/ImTtObGHhmh7es
         0eDG53w8qyQ2v2xbdzXFUTOUPlCs8cWiPxZkwM7riJAe9FJolhzt8FK6B1NiT9mqARAG
         3bzvh3qlV6pIaZfQP7hWOI663bcFyYPLTOy5nwLvC8Q7LxUkNpw5yNxvssZKKqlvLMYm
         KaLbZDZrlmB7jBJsZBlLJpHX857eimRlRas9XbAoFRDbEME9QZ+HmRcBPT9/8sfABbt/
         HHGgixQzE2zbEeMnfmuLbLrQmVQR9QWhb++8HATWuiXzO/UcocsaZLzN5zKa0XSCKbbe
         vV5Q==
X-Gm-Message-State: AFq9FYLaosF8e0QRDhdnodD5z1SW0uvob3yZJftcOWbvnOJe7WCae8oK
	Spsnx3JuSZWNX/4+Nu4TM/1WBVaFc9xP+oPmsDvuxk6c4v1HkvfuD8z5
X-Gm-Gg: AYBFou2JPxwJWQ9hELeWZxmN4EHJeXl9lA68dnR03YZaz6/1RtIuDR3QynTr6BIuMsV
	vuplOTtJgbqtmvSyfd5xkRG/KUsLoseounGMoOnS+OaFFN83cCG4qLw/LL8eFe8QioS/BUa3y/x
	JBJ++cwLomeWl7EwajGdWrsGIoa/EV3SRZoW39Hf6C2gAYs8ymKJRlOYfMKh8jfA7BMWcy8Z37p
	BGIYWwwnKQ0rU3stw50ntzl9DSgxiHhNbm1dpwGarVWjMwwLIcPmm5pjvkQ0JP0dR1YiC+OI0rF
	61g7FtUoqrQOPE9rb/TOeo0PbBApkovFt6eKAr6OdUqrpOi2Fu00wdtf9bgXE3vWiD9o6tcL4q2
	TS4WdOG7K2o7l1Y93Td2+8W8h/XaZtrKh9+MRiEqVEOQ4lYE/MougdD09FWpg2cPp2OFPfNnLq1
	0Ni9Sm1sIAY6aPJFtVa3A5fYGRUKVdSNQu1c3NUxQf7RsqONjtG0XB4uC229UtpI0aM2io2DQI8
	8UNYhXafgUaKMUfSQzEyFzOviqadD6S9vJvulnTzLpIHbBLud/3olx2sCJ2AWWHEd9FrczG9F2E
	2eFJs6/Hjd8YX24lwYNrjyHSeguf5BD3N/6HF9z3odQS0CiTidzT4IOkXXFc/qLlvPx8hmQbrff
	EyPcSXEDFfg==
X-Received: by 2002:a17:906:dc8e:b0:c29:4513:f6fd with SMTP id a640c23a62f3a-c31aa081b78mr1852813766b.35.1792074341175;
        Thu, 15 Oct 2026 07:25:41 -0700 (PDT)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3f8557c767sm68631766b.50.2026.10.15.07.25.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 07:25:40 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH] merge: stop using the_repository
Date: Thu, 15 Oct 2026 15:25:32 +0100
Message-ID: <20261015142532.48175-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

try_merge_command() and checkout_fast_forward() already receive a
repository, so use it instead of relying on global variables.

Add a repository parameter to merge_argument() and pass it
from try_merge_command(). Use the repository in
checkout_fast_forward() when parsing trees.

Remove the now-unnecessary USE_THE_REPOSITORY_VARIABLE
definition.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 merge.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/merge.c b/merge.c
index 0f5e823e63..85dad63a94 100644
--- a/merge.c
+++ b/merge.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hash.h"
@@ -14,9 +12,9 @@
 #include "tree-walk.h"
 #include "unpack-trees.h"
 
-static const char *merge_argument(struct commit *commit)
+static const char *merge_argument(struct repository *r, struct commit *commit)
 {
-	return oid_to_hex(commit ? &commit->object.oid : the_hash_algo->empty_tree);
+	return oid_to_hex(commit ? &commit->object.oid : r->hash_algo->empty_tree);
 }
 
 int try_merge_command(struct repository *r,
@@ -32,11 +30,11 @@ int try_merge_command(struct repository *r,
 	for (size_t i = 0; i < xopts_nr; i++)
 		strvec_pushf(&cmd.args, "--%s", xopts[i]);
 	for (j = common; j; j = j->next)
-		strvec_push(&cmd.args, merge_argument(j->item));
+		strvec_push(&cmd.args, merge_argument(r, j->item));
 	strvec_push(&cmd.args, "--");
 	strvec_push(&cmd.args, head_arg);
 	for (j = remotes; j; j = j->next)
-		strvec_push(&cmd.args, merge_argument(j->item));
+		strvec_push(&cmd.args, merge_argument(r, j->item));
 
 	cmd.git_cmd = 1;
 	ret = run_command(&cmd);
@@ -68,18 +66,18 @@ int checkout_fast_forward(struct repository *r,
 	memset(&trees, 0, sizeof(trees));
 	memset(&t, 0, sizeof(t));
 
-	trees[nr_trees] = repo_parse_tree_indirect(the_repository, head);
+	trees[nr_trees] = repo_parse_tree_indirect(r, head);
 	if (!trees[nr_trees++]) {
 		rollback_lock_file(&lock_file);
 		return -1;
 	}
-	trees[nr_trees] = repo_parse_tree_indirect(the_repository, remote);
+	trees[nr_trees] = repo_parse_tree_indirect(r, remote);
 	if (!trees[nr_trees++]) {
 		rollback_lock_file(&lock_file);
 		return -1;
 	}
 	for (i = 0; i < nr_trees; i++) {
-		if (repo_parse_tree(the_repository, trees[i]) < 0) {
+		if (repo_parse_tree(r, trees[i]) < 0) {
 			rollback_lock_file(&lock_file);
 			return -1;
 		}
-- 
2.54.0

