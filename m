Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF9F20281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934126AbdIYIU7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:20:59 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36494 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932617AbdIYIUv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 04:20:51 -0400
Received: by mail-pg0-f66.google.com with SMTP id d8so4495568pgt.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O3pdoodcYgkII6MQ3UuT+Fz+wTyVGZ9wET8TNOZ6dBI=;
        b=aW2HI3x0rOafqfv3ub11zJwziEOdpW96/E9M0eGjXk7xbG/NQEv+6BVYpg0YlC3duD
         /auV/cKT1Lv1tmAZobaj1SVQsXa7SO7l+B45IpAvHO0Dgjw2PpHJG9HbNf+335uJc/gE
         fFMf1kDTRI1t/+iwkb+LmBez8fbD8tAZcQpWJuQZraVeV9Xf/qkbN8RrVvzx2iOfjI60
         USoQjEgjNbwUYq+1lEQy4ijM/+lASLOVGK8VsB6sRv1RKflQStjD753BJXO1PZyYeNYP
         J4dZCHuXJt8UpR2r2y4pERxK0nXirZ0CXmcbRZCG2PASl2K2c0gmfsJSwx9Elr+4C1s0
         2IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O3pdoodcYgkII6MQ3UuT+Fz+wTyVGZ9wET8TNOZ6dBI=;
        b=KK3oG4+jqI1Ip540HPgjyEbhQjxMbNStT3ICWmRVBifENqTKyM/KyUmLieW1PEIo9t
         j5JY0O9gdM+V5+IiLDhyHHBKLm5ogK3okL3LFY+E4spv2JpQqDtrWCvGEXhHCuyLX8CH
         DdVfZ6vwFoU8cTcahjNaAvEGHWNbB1nv59DnT8i842kO0odGw84B4HhDIVGzHOvN2/9f
         17SgxNujVix8nxV1XYwYb70jTnAdWd+bzbsU2rS7w1RwYU5H0JsFCotXXtObd8pH6Wa8
         pMduvkYCbXIsNHSEoBq5JCMGoEV+GZlABPcgF8lpPlTOBvQPH/KcrbUbfu/SIerlebOn
         09yQ==
X-Gm-Message-State: AHPjjUh0lI67LgW0Xve+BvQApT4hAfqHxWEdCLxyAG7R2PdI7gdmnkRp
        rw9QRZkHOFAtAEQde0HBAFI=
X-Google-Smtp-Source: AOwi7QCvYU+wM5yKevUi6DngC3FZZMqYutS5LfQYyoY/kvEvc0mkN/JAA+Jz726Wsmvu6iY/iPuEDg==
X-Received: by 10.98.74.4 with SMTP id x4mr6776927pfa.222.1506327650613;
        Mon, 25 Sep 2017 01:20:50 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:700a:bb87:18d5:bb83:9cfe:b5d3])
        by smtp.gmail.com with ESMTPSA id g16sm11469444pfd.6.2017.09.25.01.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Sep 2017 01:20:49 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Google-Original-From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [RFC PATCH v2 4/5] branch: introduce dont_fail parameter for create validation
Date:   Mon, 25 Sep 2017 13:50:23 +0530
Message-Id: <20170925082024.2691-5-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.935.ge2b2bcd8a
In-Reply-To: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
References: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This parameter allows the branch create validation function to
optionally return a flag specifying the reason for failure, when
requested. This allows the caller to know why it was about to die.
This allows more useful error messages to be given to the user when
trying to rename a branch.

The flags are specified in the form of an enum and values for success
flags have been assigned explicitly to clearly express that certain
callers rely those values and they cannot be arbitrary.

Only the logic has been added but no caller has been made to use it, yet.
So, no functional changes.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 branch.c           | 32 ++++++++++++++++++++++----------
 branch.h           | 23 +++++++++++++++++++++--
 builtin/branch.c   |  2 +-
 builtin/checkout.c |  2 +-
 4 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/branch.c b/branch.c
index db2abeb7e..83305ded6 100644
--- a/branch.c
+++ b/branch.c
@@ -179,27 +179,39 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 }
 
 int validate_branch_creation(const char *name, struct strbuf *ref,
-			     int shouldnt_exist, int clobber_head_ok)
+			     int shouldnt_exist, int clobber_head_ok, unsigned dont_fail)
 {
-	if (strbuf_check_branch_ref(ref, name))
-		die(_("'%s' is not a valid branch name."), name);
+	if (strbuf_check_branch_ref(ref, name)) {
+		if (dont_fail)
+			return INVALID_BRANCH_NAME;
+		else
+			die(_("'%s' is not a valid branch name."), name);
+	}
 
 	if (!ref_exists(ref->buf))
-		return 0;
+		return VALID_BRANCH_NAME;
 
-	if (shouldnt_exist)
-		die(_("A branch named '%s' already exists."), ref->buf + strlen("refs/heads/"));
+	if (shouldnt_exist) {
+		if (dont_fail)
+			return BRANCH_EXISTS;
+		else
+			die(_("A branch named '%s' already exists."), ref->buf + strlen("refs/heads/"));
+	}
 
 	if (!clobber_head_ok) {
 		const char *head;
 		struct object_id oid;
 
 		head = resolve_ref_unsafe("HEAD", 0, oid.hash, NULL);
-		if (!is_bare_repository() && head && !strcmp(head, ref->buf))
-			die(_("Cannot force update the current branch."));
+		if (!is_bare_repository() && head && !strcmp(head, ref->buf)) {
+			if (dont_fail)
+				return CANNOT_FORCE_UPDATE_CURRENT_BRANCH;
+			else
+				die(_("Cannot force update the current branch."));
+		}
 	}
 
-	return 1;
+	return FORCE_UPDATING_BRANCH;
 }
 
 /*
@@ -268,7 +280,7 @@ void create_branch(const char *name, const char *start_name,
 		validate_existing_branch(name, &ref);
 		dont_change_ref = 1;
 	} else {
-		forcing = validate_branch_creation(name, &ref, !force, clobber_head_ok);
+		forcing = validate_branch_creation(name, &ref, !force, clobber_head_ok, 0);
 	}
 
 	real_ref = NULL;
diff --git a/branch.h b/branch.h
index a6dde552c..4b68a789d 100644
--- a/branch.h
+++ b/branch.h
@@ -27,6 +27,16 @@ void create_branch(const char *name, const char *start_name,
 		   int force, int clobber_head_ok,
 		   int reflog, int quiet, enum branch_track track);
 
+enum branch_validation_result {
+	/* Flags that say it's NOT OK to update */
+	BRANCH_EXISTS = -3,
+	CANNOT_FORCE_UPDATE_CURRENT_BRANCH,
+	INVALID_BRANCH_NAME,
+	/* Flags that say it's OK to update */
+	VALID_BRANCH_NAME = 0,
+	FORCE_UPDATING_BRANCH = 1
+};
+
 /*
  * Validates whether the branch with the given name may be updated (created, renamed etc.,)
  * with respect to the given conditions.
@@ -41,10 +51,19 @@ void create_branch(const char *name, const char *start_name,
  *   - clobber_head_ok allows another branch with given branch name to be
  *     the currently checkout branch; with 'shouldnt_exist', it has no effect.
  *
- * A non-zero return value indicates that a branch already exists and can be force updated.
+ * The return values have the following meaning,
+ *
+ *   - If dont_fail is 0, the function dies in case of failure and returns flags of
+ *     'validate_result' that indicate that it's OK to update the branch. The positive
+ *     non-zero flag implies that the branch can be force updated.
+ *
+ *   - If dont_fail is 1, the function doesn't die in case of failure but returns flags
+ *     of 'validate_result' that specify the reason for failure. The behaviour in case of
+ *     success is same as above.
  *
  */
-int validate_branch_creation(const char *name, struct strbuf *ref, int shouldnt_exist, int clobber_head_ok);
+int validate_branch_creation(const char *name, struct strbuf *ref,
+			     int shouldnt_exist, int clobber_head_ok, unsigned dont_fail);
 
 /*
  * Remove information about the state of working on the current
diff --git a/builtin/branch.c b/builtin/branch.c
index aa2f36519..25e3a2f29 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -483,7 +483,7 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	 */
 	clobber_head_ok = !strcmp(oldname, newname);
 
-	validate_branch_creation(newname, &newref, !force, clobber_head_ok);
+	validate_branch_creation(newname, &newref, !force, clobber_head_ok, 0);
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index fcbbbb1fa..e9d636c66 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1285,7 +1285,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		opts.branch_exists =
 			validate_branch_creation(opts.new_branch, &buf,
 						!opts.new_branch_force,
-						!!opts.new_branch_force);
+						!!opts.new_branch_force, 0);
 
 		strbuf_release(&buf);
 	}
-- 
2.14.1.935.ge2b2bcd8a

