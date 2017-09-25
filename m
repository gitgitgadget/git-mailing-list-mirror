Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB8820281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934123AbdIYIUw (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:20:52 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33187 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933996AbdIYIUr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 04:20:47 -0400
Received: by mail-pf0-f196.google.com with SMTP id h4so3329135pfk.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 01:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zhqud3owsBNBDAVXiaPveB9sS2sjpj/ONekiSmzxJJo=;
        b=ARJsECX9USZVMCm1RWDBLJjJQPbgY+bAsFbMXBkpRAXt3Ecid3n/VumfBK5wEQdalK
         WkIqrm/WVA8mxGn+tmXOKX+rVczpMKRYbqtRRKCi944mDR7PzDWGdA7Kzse8H8BGcWZZ
         +wewRUIsDwvohcvo8HZ88TuvfjjWMi+MQu5dTRKCZi7BGosgvoHwJWZVZx6r1/xswzQ3
         pq16i4dhml+Q9DZG/uJ1SSfNzqgYvQGB/jnt3oETAUocGin3nlIeSrVF2PpGPChyXomd
         CVgmTPZun2UdS519LRJW3jg+ZG7vSQJEWoucyylPxkyNobChwRH4V54oyKvXGjMfa+yL
         Js4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zhqud3owsBNBDAVXiaPveB9sS2sjpj/ONekiSmzxJJo=;
        b=G2j5wHCmXWD9QBrdeyngS2svLPcreGSh2TX74oLp0J0RgJ5YYgL5iuRK8BNGRVi6W3
         3HKSGy8pqaaq+iHIfgpXDvaunuCeUO9dyplGfjsybOxMSuh11zJIzu8ia4rXbqF1C+ke
         IRk8OoSKQRD3GfXwSCZoscZXpot2TAHXpVN8Ce+6yAI6oCRKIyrqdmZa+w7vtnpz+/oe
         BVLpFncdS//Jd8rmlnb1Z7LhnkVmU/hWAoZVjwqgX5yAeiaDTRnlwgip4HUJ4i4T5gYI
         c2Pdkv3WPxcY/FERz8eEQI3Wg8vPgaU7eUnXmmDZ0eihzbKAlHMVADzEyFuDPHmLNGfL
         RHiQ==
X-Gm-Message-State: AHPjjUiP005rNUekG3tkANWSYsvu0oXXr0iknZ3gP6OFlCifaBCm4SAX
        MAqsE3ALdjtmLyk8aNeDGUI=
X-Google-Smtp-Source: AOwi7QC9ll+2o71UIMgEykdt56h3+u35XOgbNxXaOsR9qxjMeK7LdDO3JwYWmsUgtUE12Zz0O1SwYw==
X-Received: by 10.99.99.197 with SMTP id x188mr7011912pgb.49.1506327647351;
        Mon, 25 Sep 2017 01:20:47 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:700a:bb87:18d5:bb83:9cfe:b5d3])
        by smtp.gmail.com with ESMTPSA id g16sm11469444pfd.6.2017.09.25.01.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Sep 2017 01:20:46 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Google-Original-From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [RFC PATCH v2 3/5] branch: cleanup branch name validation
Date:   Mon, 25 Sep 2017 13:50:22 +0530
Message-Id: <20170925082024.2691-4-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.935.ge2b2bcd8a
In-Reply-To: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
References: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function that validates a new branch name was clumsy because,

  1. It did more than just validating the branch name.

  2. Despite it's name, it is more often than not used to validate
     existing branch names through the 'force' and 'attr_only'
     parameters (whose names by the way weren't communicative).

  3. The 'attr_only' parameter should have been "true" only when
     callers like to update some attribute of the branch and "false"
     when they were updating where the branch points to. It was misused
     by callers by setting it to "true" (to skip tests) even though they
     were force updating where the current branch was pointing to!

     This is an example of spoiling code clarity by making the caller
     rely on how the function is implemented thus making it hard to
     modify/maintain.

This makes it unclear what the function does at all and would confuse
the people who would ever want to it for the first time.

So, refactor it into a function that validates whether the branch could
be created. This doesn't bear the uncommunicative 'new'. Further replace
the 'force' parameter with a 'shouldnt_exist' parameter which specifies
that a another branch with the given branch name should not (IOW, it's
just the opposite of 'force') Also replace  the 'attr_only' with
'clobber_head_ok' which is a more communicative way of saying "If
another branch could exist, it's OK if it is the current branch".

Separate the validation of an existing branch (partly) into another function.
This (at last!) addresses the NEEDSWORK that was added in fa7993767
(branch --set-upstream: regression fix, 2011-09-16)

This refactor has only one functional change. It enforces strictly that
an existing branch should be updated only with the 'force' switch. So,
it's no more possible to do,

        $ git branch -m master master

(which doesn't seem that useful). This strongly enforces the following
statement of the 'git branch' documentation,

        "If <newbranch> exists, -M must be used to force the
         rename to happen."

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 branch.c           | 41 ++++++++++++++++++++++++++++++-----------
 branch.h           | 25 +++++++++++++------------
 builtin/branch.c   |  2 +-
 builtin/checkout.c |  4 ++--
 t/t3200-branch.sh  |  4 ++++
 5 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/branch.c b/branch.c
index 0ea105b55..db2abeb7e 100644
--- a/branch.c
+++ b/branch.c
@@ -178,18 +178,19 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 	return 0;
 }
 
-int validate_new_branchname(const char *name, struct strbuf *ref,
-			    int force, int attr_only)
+int validate_branch_creation(const char *name, struct strbuf *ref,
+			     int shouldnt_exist, int clobber_head_ok)
 {
 	if (strbuf_check_branch_ref(ref, name))
 		die(_("'%s' is not a valid branch name."), name);
 
 	if (!ref_exists(ref->buf))
 		return 0;
-	else if (!force && !attr_only)
+
+	if (shouldnt_exist)
 		die(_("A branch named '%s' already exists."), ref->buf + strlen("refs/heads/"));
 
-	if (!attr_only) {
+	if (!clobber_head_ok) {
 		const char *head;
 		struct object_id oid;
 
@@ -197,9 +198,29 @@ int validate_new_branchname(const char *name, struct strbuf *ref,
 		if (!is_bare_repository() && head && !strcmp(head, ref->buf))
 			die(_("Cannot force update the current branch."));
 	}
+
 	return 1;
 }
 
+/*
+ * Validates whether the branch with the given name exists, returning the
+ * interpreted ref in ref.
+ *
+ * This method is invoked if the caller merely wants to know if it is OK
+ * to change some attribute for the named branch (e.g. tracking upstream).
+ *
+ */
+static void validate_existing_branch(const char *name, struct strbuf *ref)
+{
+	if (strbuf_check_branch_ref(ref, name))
+		die(_("'%s' is not a valid branch name."), name);
+
+	if (ref_exists(ref->buf))
+		return;
+	else
+		die(_("branch '%s' doesn't exist"), name);
+}
+
 static int check_tracking_branch(struct remote *remote, void *cb_data)
 {
 	char *tracking_branch = cb_data;
@@ -243,13 +264,11 @@ void create_branch(const char *name, const char *start_name,
 	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
 		explicit_tracking = 1;
 
-	if (validate_new_branchname(name, &ref, force,
-				    track == BRANCH_TRACK_OVERRIDE ||
-				    clobber_head_ok)) {
-		if (!force)
-			dont_change_ref = 1;
-		else
-			forcing = 1;
+	if (track == BRANCH_TRACK_OVERRIDE) {
+		validate_existing_branch(name, &ref);
+		dont_change_ref = 1;
+	} else {
+		forcing = validate_branch_creation(name, &ref, !force, clobber_head_ok);
 	}
 
 	real_ref = NULL;
diff --git a/branch.h b/branch.h
index a6740bb9f..a6dde552c 100644
--- a/branch.h
+++ b/branch.h
@@ -28,22 +28,23 @@ void create_branch(const char *name, const char *start_name,
 		   int reflog, int quiet, enum branch_track track);
 
 /*
- * Validates that the requested branch may be created, returning the
- * interpreted ref in ref, force indicates whether (non-head) branches
- * may be overwritten. A non-zero return value indicates that the force
- * parameter was non-zero and the branch already exists.
+ * Validates whether the branch with the given name may be updated (created, renamed etc.,)
+ * with respect to the given conditions.
  *
- * Contrary to all of the above, when attr_only is 1, the caller is
- * not interested in verifying if it is Ok to update the named
- * branch to point at a potentially different commit. It is merely
- * asking if it is OK to change some attribute for the named branch
- * (e.g. tracking upstream).
+ *   - name is the new branch name
  *
- * NEEDSWORK: This needs to be split into two separate functions in the
- * longer run for sanity.
+ *   - ref contains the interpreted ref for the given name
+ *
+ *   - shouldnt_exist indicates that another branch with the given name
+ *     should not exist
+ *
+ *   - clobber_head_ok allows another branch with given branch name to be
+ *     the currently checkout branch; with 'shouldnt_exist', it has no effect.
+ *
+ * A non-zero return value indicates that a branch already exists and can be force updated.
  *
  */
-int validate_new_branchname(const char *name, struct strbuf *ref, int force, int attr_only);
+int validate_branch_creation(const char *name, struct strbuf *ref, int shouldnt_exist, int clobber_head_ok);
 
 /*
  * Remove information about the state of working on the current
diff --git a/builtin/branch.c b/builtin/branch.c
index 62c311478..aa2f36519 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -483,7 +483,7 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	 */
 	clobber_head_ok = !strcmp(oldname, newname);
 
-	validate_new_branchname(newname, &newref, force, clobber_head_ok);
+	validate_branch_creation(newname, &newref, !force, clobber_head_ok);
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4ef7a47e1..fcbbbb1fa 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1283,8 +1283,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		struct strbuf buf = STRBUF_INIT;
 
 		opts.branch_exists =
-			validate_new_branchname(opts.new_branch, &buf,
-						!!opts.new_branch_force,
+			validate_branch_creation(opts.new_branch, &buf,
+						!opts.new_branch_force,
 						!!opts.new_branch_force);
 
 		strbuf_release(&buf);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index d97164997..ec85cd959 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -137,6 +137,10 @@ test_expect_success 'git branch -m -f o/q o/p should work when o/p exists' '
 	git branch -m -f o/q o/p
 '
 
+test_expect_success 'git branch -m o/o o/o should fail when o/o exists' '
+	test_must_fail git branch -m o/o o/o
+'
+
 test_expect_success 'git branch -m q r/q should fail when r exists' '
 	git branch q &&
 	git branch r &&
-- 
2.14.1.935.ge2b2bcd8a

