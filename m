Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AADA0200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932771AbcL0QYA (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:24:00 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36211 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755530AbcL0QXu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:50 -0500
Received: by mail-pg0-f68.google.com with SMTP id n5so12847929pgh.3
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h1bOARc1XCvisR4nJWO/v+vgqJRkWBxDKscMU/d4nAI=;
        b=HQR1wN3+6+4e0NxlSakbrLO2HP+AHU5bW/nHe7nphTxyCNc16DINLdxa9Hbrf79B9Y
         oDFnuv0oEIO5mFmuhWR/Ootc+3ya/MkMMQ0gtZ/GK0tYQC6cXEdvOr4p1yqliwYO4Ky7
         mjv8tWZp7w2S6tzDFdeDa4G3+KnfekevzNoZ0rgqYVfBblJ6NmNwxUImDgyMW19+u40+
         HyyiJnpqy5ZW84SeBh1pfQuuH7OZjK/KeJzym3IWziqdFBQNjfZNkebzW8RV98IE0pxX
         K4RcyP5p4DArUtsZMrY0QM7dMdOxsrirMsy1MhwqcSnDu4DYndwUZ5RYWKqTBOPHSiez
         H/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h1bOARc1XCvisR4nJWO/v+vgqJRkWBxDKscMU/d4nAI=;
        b=DjyPAFuKBEbygEDwrHvyGVu0i7EpjjhAaWvHnRgeDZOYl8WOKcI+hPpKNp72smaG+x
         o0/+1YfQKvF+7hm59Kt6ZDgggAUZzy2JKYyLoPkqfyCRZ5DZU1xYapuS4Kd0B93TiHsv
         XvCsx22hHsj7jS7xe7gxNfipi2T4ifpSapj/hp/3QW7UlNsDtJ37bGqE5+rJcYiXrZQj
         4MsNgq4by1sT3BqLIIbHm+XdJArY/1zmYLIta1tVY+JzGXV8UsBcQcO6flq8HcOhzRq+
         q2ZgEdWXDxTqgdOjSNZRuxMuYHU0qIk0QVjw+dPW/FK9/trJI7Zc27dI+NvvpfnsTLXM
         QfiQ==
X-Gm-Message-State: AIkVDXIZ6crmU39TphCkcnLfJZimRSvI3b8Z9bqL4ZEDx+SRnsiw2AJNSSC8afvpnfbcxQ==
X-Received: by 10.99.250.69 with SMTP id g5mr59433484pgk.15.1482855830128;
        Tue, 27 Dec 2016 08:23:50 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:49 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v9 15/20] ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
Date:   Tue, 27 Dec 2016 21:53:52 +0530
Message-Id: <20161227162357.28212-16-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the 'lstrip=<N>' option only takes a positive value '<N>'
and strips '<N>' slash-separated path components from the left. Modify
the 'lstrip' option to also take a negative number '<N>' which would
only _leave_ behind 'N' slash-separated path components from the left.

Add documentation and tests for the same.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  3 ++-
 ref-filter.c                       | 27 ++++++++++++++++++++++-----
 t/t6300-for-each-ref.sh            | 12 ++++++------
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 82c202a..9055ba0 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -98,7 +98,8 @@ refname::
 	abbreviation mode. If `lstrip=<N>` is appended, strips `<N>`
 	slash-separated path components from the front of the refname
 	(e.g., `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo`.
-	`<N>` must be a positive integer.
+	if `<N>` is a negative number, then only `<N>` path components
+	are left behind.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
diff --git a/ref-filter.c b/ref-filter.c
index 76553eb..1cd92ea 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -34,7 +34,7 @@ struct if_then_else {
 
 struct refname_atom {
 	enum { R_NORMAL, R_SHORT, R_LSTRIP } option;
-	unsigned int lstrip;
+	int lstrip;
 };
 
 /*
@@ -93,8 +93,8 @@ static void refname_atom_parser_internal(struct refname_atom *atom,
 		atom->option = R_SHORT;
 	else if (skip_prefix(arg, "lstrip=", &arg)) {
 		atom->option = R_LSTRIP;
-		if (strtoul_ui(arg, 10, &atom->lstrip) || atom->lstrip <= 0)
-			die(_("positive value expected refname:lstrip=%s"), arg);
+		if (strtol_i(arg, 10, &atom->lstrip))
+			die(_("Integer value expected refname:lstrip=%s"), arg);
 	} else
 		die(_("unrecognized %%(%s) argument: %s"), name, arg);
 }
@@ -1091,12 +1091,28 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
-static const char *lstrip_ref_components(const char *refname, unsigned int len)
+static const char *lstrip_ref_components(const char *refname, int len)
 {
 	long remaining = len;
 	const char *start = refname;
 
-	while (remaining) {
+	if (len < 0) {
+		int i;
+		const char *p = refname;
+
+		/* Find total no of '/' separated path-components */
+		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++)
+			;
+		/*
+		 * The number of components we need to strip is now
+		 * the total minus the components to be left (Plus one
+		 * because we count the number of '/', but the number
+		 * of components is one more than the no of '/').
+		 */
+		remaining = i + len + 1;
+	}
+
+	while (remaining > 0) {
 		switch (*start++) {
 		case '\0':
 			return "";
@@ -1105,6 +1121,7 @@ static const char *lstrip_ref_components(const char *refname, unsigned int len)
 			break;
 		}
 	}
+
 	return start;
 }
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index d3d1a97..203cfaa 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -53,12 +53,16 @@ test_atom head refname refs/heads/master
 test_atom head refname:short master
 test_atom head refname:lstrip=1 heads/master
 test_atom head refname:lstrip=2 master
+test_atom head refname:lstrip=-1 master
+test_atom head refname:lstrip=-2 heads/master
 test_atom head upstream refs/remotes/origin/master
 test_atom head upstream:short origin/master
 test_atom head upstream:lstrip=2 origin/master
+test_atom head upstream:lstrip=-2 origin/master
 test_atom head push refs/remotes/myfork/master
 test_atom head push:short myfork/master
 test_atom head push:lstrip=1 remotes/myfork/master
+test_atom head push:lstrip=-1 master
 test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname $(git rev-parse refs/heads/master)
@@ -141,12 +145,6 @@ test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
 '
 
-test_expect_success 'arguments to :lstrip must be positive integers' '
-	test_must_fail git for-each-ref --format="%(refname:lstrip=0)" &&
-	test_must_fail git for-each-ref --format="%(refname:lstrip=-1)" &&
-	test_must_fail git for-each-ref --format="%(refname:lstrip=foo)"
-'
-
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
 	git for-each-ref --format="%(authordate)" refs/heads &&
 	git for-each-ref --format="%(authordate:default) %(authordate)" refs/heads &&
@@ -624,10 +622,12 @@ test_expect_success 'Verify usage of %(symref:short) atom' '
 
 cat >expected <<EOF
 master
+heads/master
 EOF
 
 test_expect_success 'Verify usage of %(symref:lstrip) atom' '
 	git for-each-ref --format="%(symref:lstrip=2)" refs/heads/sym > actual &&
+	git for-each-ref --format="%(symref:lstrip=-2)" refs/heads/sym >> actual &&
 	test_cmp expected actual
 '
 
-- 
2.10.2

