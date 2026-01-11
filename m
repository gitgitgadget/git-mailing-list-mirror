Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FC518FDBE
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 05:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768111157; cv=none; b=dCUwoBGy10wzIPaYyc6LPW04PtNL7JK4KYTwtjtVJUnGjBSwZljA9aZnwMAszbZ1x3y+tPW0KIba52oKEA5dRvKEF94KNEBM3/Le/y8HBCopZWRMmHCar1EgY7boj6HAQP5rtTPIUpRH1rq2ao2PsC2VIdKDmcUA0h/HNJiMKdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768111157; c=relaxed/simple;
	bh=CR2M1oqtWK9Q48UlrcpLAJCo319auauvDM84hnOJaQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gol4Yx5hMWzaWbhtNLN0wUmQ/8GV3nyzZpzpm40UmyCKxH0siD2OZ9BHIMtFzhdanZFLUIHsAtsopz5M1miGWhSw0/SgytvCS2uqAQbXATsu+s1eadyQWbTWC6qllVbE4N5F23MAMt3PgDswK6aKSr/tD2S2VMEW4FF34o+L8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMie0GKa; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMie0GKa"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b053ec7d90so4722516eec.0
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 21:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768111155; x=1768715955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57jGEuSxqV06q06+2yK1lwwyqUOWCOu9yLEByBKBBiQ=;
        b=KMie0GKaUeT1QQINjATJomrsQYsBSOJRDUEMIgMLUueTH1LhU5X7dC44v6qAD5qXo+
         tIRYl9xnDZ+Osq1/kRhRfOKtJAYX4lujOONDFpoC3lXenpvf20M2tS8BCaS2+A1kEtFN
         151rBxBNNrxgWOr5kRSD1dMoSzXy22CSuHJ+oE9gzDnT+ALyqL9bP/u3L7JXxMcOebcJ
         U2Zv9TyCODSoCWRtF5vKW3sFwhfydpmoHuL+PUXmAcEE+kydMK+xnSC36HhcRCVCLRE5
         RMqJEp+hpScpzATQfv1HzHSeh2yi6sW9tvUvyfDkQWUTpX4wBs9+2AxhmZMNUaHABrnf
         X8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768111155; x=1768715955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=57jGEuSxqV06q06+2yK1lwwyqUOWCOu9yLEByBKBBiQ=;
        b=F93ffrgGbHHMCuYpta+egbXMPviY4iYfGzExiRE0H+sP+TNLLQswLloUC8DBFkBK31
         0aaqDHMh++MWKIMo2i74pfD47/cmDyMaqQszjR9CVZvNkGihqOXsasjVTOs61S9riDlf
         gsLjq9qk+vxQDw0+nM6E1L/W0EwWOtXqNE0LMXaSRtx2Z3JxVIubb9uGv1oT007xJrfW
         iBaEGZOBir+Gm3URZmcf1KMJMpMH/ZGADDYsJWCYfjmME9xzlTwVHSqzGnzljULThECk
         SlXgEp5L5/XqZ4sv+iHJrJMJHiULGnPUp5hvcMTfgMkSjVG6gdDMjW+PyCZD7WQOaMWa
         oZJw==
X-Forwarded-Encrypted: i=1; AJvYcCWFuBx5qGu7X4TqoSAOdUWyR0AIznhU4AZFyM+LBAA1WPHxmrq5Zl+iA8bDic+ILmzl9AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUvgvIwuvmR7PQVMUQAO67dKZHkmrZB5UMWkZ/tp0S1YEcZWd7
	B0Aeg6xpBU6CcDR9ddd83ZkCYLiEfI89T7rg7Ji9QH7sIMslHl1IwOJ7hG9biA==
X-Gm-Gg: AY/fxX7h2gwiFolZXw/HidoBp/6q2iC07dEdamq8kaX4tzMKJbrozH+mtELIXY+rROh
	egunSrphXg1WYK6Us4SgRMPRqQY9KzyH+1EwNkB6CsgxPBbL0c0i6tXKjf6wiSx2uvcqjRAwBR9
	QN9v8XK3T+7BNQr6/49Cc8IQJxaVgkSfwc3zWGITjpkquou6F1xOOPi4mluVo17ZtTXwZfMiXKV
	BzD3t6JIPBE5YJb1M44WswrInGz8lBbxTLwB3SPHhA7SyEnkojrRXYPGtwtj1QX/RKLWGZcuHR6
	BwFWRdLCaeK7ji0hh83EojHik+1qHkSXf3wRsIJ1ROIdbqS6YK8eLvjJyWpqyU7hDPVs4tC73Oa
	n8eFjRCpF5hUe7eZxdUGUcqiJCa+8ujIqKNg/Uh0K7HnSGOmEwmEAKsdwqHbCCNlbxc7pL9epwn
	YI5hp+wkJh+1aoMq5Omr9BY0kGJusONk8=
X-Google-Smtp-Source: AGHT+IFVU9dneur6KIozkrdUKj0mTzdtvi9tOob36CNJePXhuE7/WmDTGRUgp//+9ivE1DWIcKi+7g==
X-Received: by 2002:a05:7300:8aa4:b0:2a4:3592:c612 with SMTP id 5a478bee46e88-2b17d2d6606mr9271892eec.35.1768111155131;
        Sat, 10 Jan 2026 21:59:15 -0800 (PST)
Received: from PW0EDBZC.hsd1.ca.comcast.net ([2601:646:9e00:ecc0:93a8:3b8e:dd1c:9340])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b13bdsm13215133eec.24.2026.01.10.21.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 21:59:14 -0800 (PST)
From: Elijah Newren <newren@gmail.com>
To: Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH v9 8/7] SQUASH ME: Fixups
Date: Sat, 10 Jan 2026 21:58:58 -0800
Message-ID: <20260111055859.408891-2-newren@gmail.com>
X-Mailer: git-send-email 2.52.0.410.g227cdbe8e36
In-Reply-To: <20260111055859.408891-1-newren@gmail.com>
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
 <20260111055859.408891-1-newren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This includes several fixes I highlighted in my review and needs to be
split up and squashed into the relevant previous patches.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-history.adoc |  2 +-
 builtin/history.c              | 16 ++++------------
 builtin/replay.c               | 10 ++--------
 replay.c                       | 10 ++++------
 replay.h                       | 21 +--------------------
 5 files changed, 12 insertions(+), 47 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 4eea317e5cb..457a1314a51 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -63,7 +63,7 @@ OPTIONS
 `--ref-action=(branches|head|print)`::
 	Control which references will be updated by the command, if any. With
 	`branches`, all local branches that point to commits which are
-	decendants of the original commit will be rewritten. With `head`, only
+	descendants of the original commit will be rewritten. With `head`, only
 	the current `HEAD` reference will be rewritten. With `print`, all
 	updates as they would be performed with `branches` are printed in a
 	format that can be consumed by linkgit:git-update-ref[1].
diff --git a/builtin/history.c b/builtin/history.c
index 28db6fc5b9e..60c5b5c5c76 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -178,9 +178,7 @@ static int handle_reference_updates(enum ref_action action,
 {
 	const struct name_decoration *decoration;
 	struct replay_revisions_options opts = { 0 };
-	struct replay_result result = {
-		.final_oid = rewritten->object.oid,
-	};
+	struct replay_result result = { 0 };
 	struct ref_transaction *transaction = NULL;
 	struct strvec args = STRVEC_INIT;
 	struct strbuf err = STRBUF_INIT;
@@ -233,7 +231,7 @@ static int handle_reference_updates(enum ref_action action,
 			goto out;
 		}
 
-		strvec_push(&args, oid_to_hex(&head->object.oid));
+		strvec_push(&args, "HEAD");
 	} else {
 		strvec_push(&args, "--branches");
 	}
@@ -244,13 +242,14 @@ static int handle_reference_updates(enum ref_action action,
 
 	opts.onto = oid_to_hex_r(hex, &rewritten->object.oid);
 
-	ret = replay_revisions(repo, &revs, &opts, &result);
+	ret = replay_revisions(&revs, &opts, &result);
 	if (ret)
 		goto out;
 
 	switch (action) {
 	case REF_ACTION_DEFAULT:
 	case REF_ACTION_BRANCHES:
+	case REF_ACTION_HEAD:
 		transaction = ref_store_transaction_begin(get_main_ref_store(repo), 0, &err);
 		if (!transaction) {
 			ret = error(_("failed to begin ref transaction: %s"), err.buf);
@@ -300,13 +299,6 @@ static int handle_reference_updates(enum ref_action action,
 		}
 
 		break;
-	case REF_ACTION_HEAD:
-		ret = refs_update_ref(get_main_ref_store(repo), reflog_msg, "HEAD",
-				      &result.final_oid, &head->object.oid, 0,
-				      UPDATE_REFS_MSG_ON_ERR);
-		if (ret)
-			goto out;
-		break;
 	case REF_ACTION_PRINT:
 		for (size_t i = 0; i < result.updates_nr; i++)
 			printf("update %s %s %s\n",
diff --git a/builtin/replay.c b/builtin/replay.c
index da8b7202f6a..f66e1a1fcd3 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -167,7 +167,7 @@ int cmd_replay(int argc,
 		revs.simplify_history = 0;
 	}
 
-	ret = replay_revisions(repo, &revs, &opts, &result);
+	ret = replay_revisions(&revs, &opts, &result);
 	if (ret)
 		goto cleanup;
 
@@ -220,11 +220,5 @@ int cmd_replay(int argc,
 	strbuf_release(&reflog_msg);
 	release_revisions(&revs);
 
-	if (ret) {
-		if (result.merge_conflict)
-			return 1;
-		return 128;
-	}
-
-	return 0;
+	return ret;
 }
diff --git a/replay.c b/replay.c
index 74e45ed27a2..ea300e3c36c 100644
--- a/replay.c
+++ b/replay.c
@@ -5,11 +5,11 @@
 #include "hex.h"
 #include "merge-ort.h"
 #include "object-name.h"
-#include "oidset.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "replay.h"
 #include "revision.h"
+#include "strmap.h"
 #include "tree.h"
 
 static const char *short_commit_name(struct repository *repo,
@@ -256,7 +256,7 @@ static void replay_result_queue_update(struct replay_result *result,
 	result->updates_nr++;
 }
 
-int replay_revisions(struct repository *repo, struct rev_info *revs,
+int replay_revisions(struct rev_info *revs,
 		     struct replay_revisions_options *opts,
 		     struct replay_result *out)
 {
@@ -265,6 +265,7 @@ int replay_revisions(struct repository *repo, struct rev_info *revs,
 	struct commit *last_commit = NULL;
 	struct commit *commit;
 	struct commit *onto = NULL;
+	struct repository *repo = revs->repo;
 	struct merge_options merge_opt;
 	struct merge_result result = {
 		.clean = 1,
@@ -328,8 +329,7 @@ int replay_revisions(struct repository *repo, struct rev_info *revs,
 	}
 
 	if (!result.clean) {
-		out->merge_conflict = true;
-		ret = -1;
+		ret = 1;
 		goto out;
 	}
 
@@ -339,8 +339,6 @@ int replay_revisions(struct repository *repo, struct rev_info *revs,
 					   &onto->object.oid,
 					   &last_commit->object.oid);
 
-	out->final_oid = last_commit->object.oid;
-
 	ret = 0;
 
 out:
diff --git a/replay.h b/replay.h
index f8f9889112e..9b31c85dd9b 100644
--- a/replay.h
+++ b/replay.h
@@ -43,25 +43,6 @@ struct replay_result {
 		struct object_id new_oid;
 	} *updates;
 	size_t updates_nr, updates_alloc;
-
-	/* Set to true in case the replay failed with a merge conflict. */
-	bool merge_conflict;
-
-	/*
-	 * The final object ID that was rewritten. Note that this field has
-	 * somewhat special semantics and may or may not be what you want:
-	 *
-	 *   - If no commits were rewritten it will remain uninitialized.
-	 *
-	 *   - If a thicket of branches is rewritten it is undefined in which
-	 *     order those branches will be rewritten, and thus the final object
-	 *     ID may point to a different commit than you'd expect.
-	 *
-	 * That being said, this field can still be useful when you know that
-	 * you only replay a single strand of commits. In that case, the final
-	 * commit will point to the tip of the rewritten strand of commits.
-	 */
-	struct object_id final_oid;
 };
 
 void replay_result_release(struct replay_result *result);
@@ -73,7 +54,7 @@ void replay_result_release(struct replay_result *result);
  *
  * Returns 0 on success, a negative error code otherwise.
  */
-int replay_revisions(struct repository *repo, struct rev_info *revs,
+int replay_revisions(struct rev_info *revs,
 		     struct replay_revisions_options *opts,
 		     struct replay_result *out);
 
-- 
2.52.0.410.g227cdbe8e36

