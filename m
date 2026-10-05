Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C4C48B374
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206781; cv=none; b=N6Y5cm0Q5maRGOfDbAZ2G17moS5YqXR0MUSJ/ktTdbMyT/1lAtOEzwUknGmVzYPU6THw11/DLAm3jOfzwnY/FXtvttJU2EMCNsJUWGO7bTBLE3vW4yVzHaYTB8W1MbtgUaQVSTUnOBq87pa2GegnvfOdnI/QBccPN+bJERqKegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206781; c=relaxed/simple;
	bh=JNi9O/G873ZdorLoR0Kq1mkwlrxJlVuRhx0YKblxmnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvVR6N4T4DCNdyiC1x4qDL80uQPABdWQnjBvc+Cn+V+NPYlGYGWcZPAA6gHYv78pMT5nJpYruEwXJq69XXRE1l3YGImuNn6IiBRIY9bdYHZ9gHO6yS3kGsuAjSMa/rSRPQIid54140B659CbieE72Y52DSAOwYmpGnyYopgPjZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUAQ7QHR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUAQ7QHR"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49ff680331aso17755715e9.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791206702; x=1791811502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=utd/Nf3k+OrpRR2oXkxSjpCtjrbSZ0s3AerQyUQWqX0=;
        b=WUAQ7QHRyExLGembvoa0OFuMdsHTt5qAZDqDVNYycP+ffpSS58+2HGSlz/9sX6dDnq
         Y5G5IrwQcdCXEdVZM84H0/4TxAuTddhKI4ONJLnYLAHqr1pd2z+om2lemf4q9pJ7RZJ/
         dULuzBnQKWyCwhiBZ+d6IHqjxb9+lbHrHiwFwmebiKkOl1IME1Er5UKs1t4qAe7tFfR6
         MjHi45Nm6zDhzBNHuC+UjtyqtH75A2isGSKR3RfTOIsjJhwIFdPjtMYm2pPvQE1FC7CD
         bSxRTDzyvkWvUi0qZeVvHtoRXXwNPyPxlPc9HUYpzFYEOdf5oVdKUbA2km4LvIDpOOeZ
         SG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791206702; x=1791811502;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=utd/Nf3k+OrpRR2oXkxSjpCtjrbSZ0s3AerQyUQWqX0=;
        b=fK5Isz3H991rQVLT+beWtoujYueSbzNPLdmfTkIh+h6axzluplLlWiiZr6cJKqaElr
         uqZMUKECs70JQyb46xfjtZjImC3YcvG0gBNzcyMV1YsPa7LtRuqeGuZPOA3hGbrLAYeO
         Qbj/lE9RdeFTGvVzVYGQ+nLPa6484AzpgMj3PiJxi4FXD/PQoijzo0gqyVk9k4S3lf6z
         ohsby063sXL6QvM8mHYkzfdW6HinHpCeGQaE1P4ugBpeVuA5vsJD/Yp91bke7RV7lVW5
         Pr/AFYDfhi7G2I11JtTKpxjshWBi1gM8lOgQH8gIN5ShQvbv2X/Bp+DFn/opHXIyoNTJ
         VrDw==
X-Gm-Message-State: AFuF++m5m3+JuTlpvR1XAV36HKHPlUWtGq3E9L9QnqEVU7yg446Lgg3S
	U4R59eLvvgbp7IUkDzOWZXZN52b58vva1RzXoOs1SLMTibWBeH1VsqTSg7m8VqVY
X-Gm-Gg: AYBFou2YojGj+sBAyJ7Rx/IUmSQNz+EaRHMOu0pyOUvgkvyTd6mQ2bMxqzoQTm3Rjct
	XQW6dPD0O+Pm09sKldRFJikHPW3c9KoIeX8Ng/Uw/zR3bRVJbecML/zh6pJvGx8hKMgrVjkiPoY
	LMuetXG29xIGwFUIYg53PlmBEAsrdW7Mlg9Bzry4IbkCrxskq+kb5tO6ZpfFQq5gC9S74fYx6cl
	lB7Liwgo0fC/a/C2VLUmv2Bj0+DLbH6EpeDeOb1zboLJ9WY4+AzzpqzuDSuRMRTB0Jq61KJm5WV
	Z1z7Uq7oSkgDdxBh77QFzpWj9ecjxieaMN9LHmuWVRSj3vQc+SzirUO7oROJnFrv6HScev577Jo
	n9V4pcPxNM62lVMLQ7v86zxVSj4CdOJHdddgKK+IzJhO5HkHBdstJAszClr2/qRyuvyXU44ffuW
	NaCDRvjSC2LvecZJX+aLl8qLB0/2T9eSexGh4/aAKNoOH2i64PEGEckigy0jqVSOCYKK9kqpqND
	w==
X-Received: by 2002:a05:600c:348a:b0:4a1:746e:5898 with SMTP id 5b1f17b1804b1-4a1746e5ba6mr25980495e9.13.1791206702063;
        Mon, 05 Oct 2026 06:25:02 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280b2e3csm398123325e9.5.2026.10.05.06.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 06:25:01 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/2] remove_branch_state: convert boolean argument to flags
Date: Mon,  5 Oct 2026 14:24:48 +0100
Message-ID: <86ef0f848a35c66b2d68f96c5f307a6c80f74c78.1791206658.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1791206658.git.phillip.wood@dunelm.org.uk>
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk> <cover.1791206658.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Convert the "verbose" boolean argument to a flag so that we can add
more flags in a future commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 branch.c           | 4 ++--
 branch.h           | 3 ++-
 builtin/checkout.c | 6 +++++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/branch.c b/branch.c
index 22f4f46b96..8bc7a395a7 100644
--- a/branch.c
+++ b/branch.c
@@ -871,9 +871,9 @@ void remove_merge_branch_state(struct repository *r)
 	save_autostash_ref(r, "MERGE_AUTOSTASH");
 }
 
-void remove_branch_state(struct repository *r, int verbose)
+void remove_branch_state(struct repository *r, unsigned flags)
 {
-	sequencer_post_commit_cleanup(r, verbose);
+	sequencer_post_commit_cleanup(r, flags & REMOVE_BRANCH_STATE_VERBOSE);
 	unlink(git_path_squash_msg(r));
 	remove_merge_branch_state(r);
 }
diff --git a/branch.h b/branch.h
index e9b1f7b37d..42d1b12918 100644
--- a/branch.h
+++ b/branch.h
@@ -127,6 +127,7 @@ int validate_branchname(const char *name, struct strbuf *ref);
  */
 int validate_new_branchname(const char *name, struct strbuf *ref, int force);
 
+#define REMOVE_BRANCH_STATE_VERBOSE (1u << 0)
 /*
  * Remove information about the merge state on the current
  * branch. (E.g., MERGE_HEAD)
@@ -137,7 +138,7 @@ void remove_merge_branch_state(struct repository *r);
  * Remove information about the state of working on the current
  * branch. (E.g., MERGE_HEAD)
  */
-void remove_branch_state(struct repository *r, int verbose);
+void remove_branch_state(struct repository *r, unsigned flags);
 
 /*
  * Configure local branch "local" as downstream to branch "remote"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c0f0d2c700..bdd2d816b6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -950,6 +950,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 {
 	struct strbuf msg = STRBUF_INIT;
 	const char *old_desc, *reflog_msg;
+	unsigned flags = 0;
+
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
 			enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
@@ -1044,7 +1046,9 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 						   old_branch_info->path);
 		}
 	}
-	remove_branch_state(the_repository, !opts->quiet);
+	if (!opts->quiet)
+		flags |= REMOVE_BRANCH_STATE_VERBOSE;
+	remove_branch_state(the_repository, flags);
 	strbuf_release(&msg);
 	if (!opts->quiet &&
 	    !opts->force_detach &&
-- 
2.56.0.134.g299a3c16181

