Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EA3B20248
	for <e@80x24.org>; Mon, 15 Apr 2019 21:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfDOVFh (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 17:05:37 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:37230 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfDOVFg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 17:05:36 -0400
Received: by mail-wr1-f45.google.com with SMTP id w10so23833131wrm.4
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 14:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ypvqa3UQZBS//i4XIbQ2gZUhG1dnuH/NJm3eD6SFyTo=;
        b=rfC15n9wX1hU8r4wm8kVZVsI77hIsoY91K4fUtgDRBfAUh1SID389clMSD1akLxrRH
         QYEQ/k7gt/KYx3ZR8/fMk3DoH91CNqrMGrlzUb3l/bOJlsx+/RZyzjb1ha5WDTwKdjKw
         kl6tO5IeCkuKXawqG5f3+7nlqpsFBX7k8nfjsFQTRFNhrKDT2GYK1Ieg/Ic2TKKuBtp+
         TnIIp1dMjSDHXV11kt/doQNXCsGNYmdcMc012171BE6ceRVu8CCcP2xy/FEIFa3oqTpD
         5muc2yEaXwu23xiQR/fAbBeEbMHRxfKTwxLP3RVoTz9IVK+mp+sUe4yEUzawyQrDHDxz
         1+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ypvqa3UQZBS//i4XIbQ2gZUhG1dnuH/NJm3eD6SFyTo=;
        b=IvzCTh4c7biQ9neSfev67Z8iLsZCmnqH0ETSorMgZ20W4KvWlKqnpHVHw+jKRraJVE
         kctDC+1KefiQxBDRmXOtzWEl0fDp91oFvWmwVdmVUhevHTs0y1t3YiCMP0oHbMg9iv2W
         EXqEZesXQjc20R8/h/nkoE+CkNRX1HBIVn+YknsKzb6q8KjbtuBU48sxcjAIgSowEhX3
         NVfgoqKIXFlsejcVrTCGpN425xRnM97Y9OPAxVam16NGpt5NrC7IQm1vV+2X89RUAulq
         ZhwmgtNJ5kXNvBDwTVsg4kpsAzGf3SxS1J8Ocsl/8aYZ8/NGEVQ1ZelYHQXRpvLsZzr8
         t6Sw==
X-Gm-Message-State: APjAAAUzzFrONlE0p/d8f0l8t2fE0dH8QAdCaCQJRAsvAePQev5dWnST
        dF1yGEUAqioQo5ik0taqnLXb4coYF0U=
X-Google-Smtp-Source: APXvYqyGjawWMiBZN0lgkadYa8fIY8kw+I3DjuEmCDu0bAFQp/VPK3D7xaMtSW6aW+6tUf+npeBW2Q==
X-Received: by 2002:a5d:6050:: with SMTP id j16mr44059496wrt.253.1555362334206;
        Mon, 15 Apr 2019 14:05:34 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id t15sm50976899wrx.22.2019.04.15.14.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 14:05:33 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/1] Fix %(push:track) in ref-filter
Date:   Mon, 15 Apr 2019 23:04:16 +0200
Message-Id: <20190415210416.7525-2-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415210416.7525-1-damien.olivier.robert+git@gmail.com>
References: <20190415210416.7525-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In ref-filter.c, when processing the atom %(push:track), the
ahead/behind values are computed using `stat_tracking_info` which refers
to the upstream branch.

Fix that by introducing a new function `stat_push_info` in remote.c
(exported in remote.h), which does the same thing but for the push
branch. Factorise the ahead/behind computation of `stat_tracking_info` into
`stat_compare_info` so that it can be reused for `stat_push_info`.

This bug was not detected in t/t6300-for-each-ref.sh because in the test
for push:track, both the upstream and the push branch were ahead by 1.
Change the test so that the upstream branch is ahead by 2 while the push
branch is ahead by 1, this allow us to test that %(push:track) refer to
the correct branch.

This change the expected value of some following tests, so update them
too.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 ref-filter.c            |  7 ++--
 remote.c                | 79 +++++++++++++++++++++++++++++++----------
 remote.h                |  2 ++
 t/t6300-for-each-ref.sh | 13 ++++++-
 4 files changed, 80 insertions(+), 21 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3aca105307..82e277222b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1391,8 +1391,11 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 	if (atom->u.remote_ref.option == RR_REF)
 		*s = show_ref(&atom->u.remote_ref.refname, refname);
 	else if (atom->u.remote_ref.option == RR_TRACK) {
-		if (stat_tracking_info(branch, &num_ours, &num_theirs,
-				       NULL, AHEAD_BEHIND_FULL) < 0) {
+		if ((atom->u.remote_ref.push ?
+		     stat_push_info(branch, &num_ours, &num_theirs,
+				    NULL, AHEAD_BEHIND_FULL) :
+		     stat_tracking_info(branch, &num_ours, &num_theirs,
+					NULL, AHEAD_BEHIND_FULL)) < 0) {
 			*s = xstrdup(msgs.gone);
 		} else if (!num_ours && !num_theirs)
 			*s = xstrdup("");
diff --git a/remote.c b/remote.c
index 9cc3b07d21..b2b37d1e8d 100644
--- a/remote.c
+++ b/remote.c
@@ -1880,8 +1880,7 @@ int resolve_remote_symref(struct ref *ref, struct ref *list)
 }
 
 /*
- * Lookup the upstream branch for the given branch and if present, optionally
- * compute the commit ahead/behind values for the pair.
+ * Compute the commit ahead/behind values for the pair branch_name, base.
  *
  * If abf is AHEAD_BEHIND_FULL, compute the full ahead/behind and return the
  * counts in *num_ours and *num_theirs.  If abf is AHEAD_BEHIND_QUICK, skip
@@ -1891,34 +1890,28 @@ int resolve_remote_symref(struct ref *ref, struct ref *list)
  * The name of the upstream branch (or NULL if no upstream is defined) is
  * returned via *upstream_name, if it is not itself NULL.
  *
- * Returns -1 if num_ours and num_theirs could not be filled in (e.g., no
- * upstream defined, or ref does not exist).  Returns 0 if the commits are
- * identical.  Returns 1 if commits are different.
+ * Returns -1 if num_ours and num_theirs could not be filled in (e.g., ref
+ * does not exist).  Returns 0 if the commits are identical.  Returns 1 if
+ * commits are different.
  */
-int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
-		       const char **upstream_name, enum ahead_behind_flags abf)
+
+int stat_compare_info(const char **branch_name, const char **base,
+		      int *num_ours, int *num_theirs,
+		      enum ahead_behind_flags abf)
 {
 	struct object_id oid;
 	struct commit *ours, *theirs;
 	struct rev_info revs;
-	const char *base;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
-	/* Cannot stat unless we are marked to build on top of somebody else. */
-	base = branch_get_upstream(branch, NULL);
-	if (upstream_name)
-		*upstream_name = base;
-	if (!base)
-		return -1;
-
 	/* Cannot stat if what we used to build on no longer exists */
-	if (read_ref(base, &oid))
+	if (read_ref(*base, &oid))
 		return -1;
 	theirs = lookup_commit_reference(the_repository, &oid);
 	if (!theirs)
 		return -1;
 
-	if (read_ref(branch->refname, &oid))
+	if (read_ref(*branch_name, &oid))
 		return -1;
 	ours = lookup_commit_reference(the_repository, &oid);
 	if (!ours)
@@ -1932,7 +1925,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	if (abf == AHEAD_BEHIND_QUICK)
 		return 1;
 	if (abf != AHEAD_BEHIND_FULL)
-		BUG("stat_tracking_info: invalid abf '%d'", abf);
+		BUG("stat_compare_info: invalid abf '%d'", abf);
 
 	/* Run "rev-list --left-right ours...theirs" internally... */
 	argv_array_push(&argv, ""); /* ignored */
@@ -1966,6 +1959,56 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return 1;
 }
 
+/*
+ * Lookup the upstream branch for the given branch and if present, optionally
+ * compute the commit ahead/behind values for the pair.
+ *
+ * If abf is AHEAD_BEHIND_FULL, compute the full ahead/behind and return the
+ * counts in *num_ours and *num_theirs.  If abf is AHEAD_BEHIND_QUICK, skip
+ * the (potentially expensive) a/b computation (*num_ours and *num_theirs are
+ * set to zero).
+ *
+ * The name of the upstream branch (or NULL if no upstream is defined) is
+ * returned via *upstream_name, if it is not itself NULL.
+ *
+ * Returns -1 if num_ours and num_theirs could not be filled in (e.g., no
+ * upstream defined, or ref does not exist).  Returns 0 if the commits are
+ * identical.  Returns 1 if commits are different.
+ */
+int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
+		       const char **upstream_name, enum ahead_behind_flags abf)
+{
+	const char *base;
+
+	/* Cannot stat unless we are marked to build on top of somebody else. */
+	base = branch_get_upstream(branch, NULL);
+	if (upstream_name)
+		*upstream_name = base;
+	if (!base)
+		return -1;
+
+	return stat_compare_info(&(branch->refname), &base, num_ours, num_theirs, abf);
+}
+
+/*
+ * Same as above for the push branch for the given branch and if present,
+ * optionally compute the commit ahead/behind values for the pair.
+ */
+
+int stat_push_info(struct branch *branch, int *num_ours, int *num_theirs,
+		   const char **push_name, enum ahead_behind_flags abf)
+{
+	const char *base;
+
+	base = branch_get_push(branch, NULL);
+	if (push_name)
+		*push_name = base;
+	if (!base)
+		return -1;
+
+	return stat_compare_info(&(branch->refname), &base, num_ours, num_theirs, abf);
+}
+
 /*
  * Return true when there is anything to report, otherwise false.
  */
diff --git a/remote.h b/remote.h
index da53ad570b..0a179f8ded 100644
--- a/remote.h
+++ b/remote.h
@@ -254,6 +254,8 @@ enum ahead_behind_flags {
 /* Reporting of tracking info */
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 		       const char **upstream_name, enum ahead_behind_flags abf);
+int stat_push_info(struct branch *branch, int *num_ours, int *num_theirs,
+		   const char **push_name, enum ahead_behind_flags abf);
 int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			 enum ahead_behind_flags abf);
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 0ffd630713..1ec747bd32 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -392,6 +392,14 @@ test_atom head upstream:track '[ahead 1]'
 test_atom head upstream:trackshort '>'
 test_atom head upstream:track,nobracket 'ahead 1'
 test_atom head upstream:nobracket,track 'ahead 1'
+
+test_expect_success 'setup for push:track[short]' '
+	git update-ref refs/remotes/myfork/master master &&
+	test_commit third
+'
+
+test_atom head upstream:track '[ahead 2]'
+test_atom head upstream:trackshort '>'
 test_atom head push:track '[ahead 1]'
 test_atom head push:trackshort '>'
 
@@ -420,8 +428,10 @@ test_expect_success 'Check for invalid refname format' '
 test_expect_success 'set up color tests' '
 	cat >expected.color <<-EOF &&
 	$(git rev-parse --short refs/heads/master) <GREEN>master<RESET>
+	$(git rev-parse --short refs/remotes/myfork/master) <GREEN>myfork/master<RESET>
 	$(git rev-parse --short refs/remotes/origin/master) <GREEN>origin/master<RESET>
 	$(git rev-parse --short refs/tags/testtag) <GREEN>testtag<RESET>
+	$(git rev-parse --short refs/tags/third) <GREEN>third<RESET>
 	$(git rev-parse --short refs/tags/two) <GREEN>two<RESET>
 	EOF
 	sed "s/<[^>]*>//g" <expected.color >expected.bare &&
@@ -590,10 +600,11 @@ body contents
 $sig"
 
 cat >expected <<EOF
-$(git rev-parse refs/tags/bogo) <committer@example.com> refs/tags/bogo
 $(git rev-parse refs/tags/master) <committer@example.com> refs/tags/master
+$(git rev-parse refs/tags/bogo) <committer@example.com> refs/tags/bogo
 EOF
 
+
 test_expect_success 'Verify sort with multiple keys' '
 	git for-each-ref --format="%(objectname) %(taggeremail) %(refname)" --sort=objectname --sort=taggeremail \
 		refs/tags/bogo refs/tags/master > actual &&
-- 
Patched on top of v2.21.0-196-g041f5ea1cf (git version 2.21.0)

