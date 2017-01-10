Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F639205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 08:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031267AbdAJItb (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 03:49:31 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34528 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031243AbdAJIt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 03:49:28 -0500
Received: by mail-pf0-f193.google.com with SMTP id y143so6873230pfb.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 00:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z/iYwMxH4Zp4jpYwvX8I4tC8/MU5v1j8/3KvYepCF9U=;
        b=J85roHq1ZuzZL0it0qPIguK/nSJFX4q5HYRM3ZLaN2EuXvPrHMRHye8ySxZsshOUP2
         3KrgRMugfm/evSn2esoxgsD1rYMOGREXuNVcNU+/vd+z1iqZrYuo2LomPmGgnnC5jgAx
         wCVdNpHFVZ4XVkgH/+UrasJPbJED5MG5+hHTQ7PaVRGn+gmHUA3RZU/OobL1IJSt0T+t
         KBTPniKdunGeRenUP6kkXhLqbj6aGyUpkBNCOd7/whl9XqUh+gqfjM3q9TMnIDMM9SJR
         V3Gdk7TEmrhjgGYPKK9yEuqhJSBR9iSdLeKY5JY3D1S826z4BUYmkHqwx36+GHwpJlPR
         phwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z/iYwMxH4Zp4jpYwvX8I4tC8/MU5v1j8/3KvYepCF9U=;
        b=XX3JbSpJ+6aWBojGjUxjkZhR/dKDG+o+2cQKKP+BbC4ysrn2wqplsrKv7R2XmDxYtV
         L3gMh8evtTY7Toir72A188c7UZ83uBDXBHIa34/BtXLvMOMYS+wEceXXwQnxj2TVpuGH
         /maX6EOSwmnWBKlYRjapQydi87VXZdm2TXzvmN6oXH2L8WPxtWg3/F5x7Qfy/cKSxQrt
         /Erexe+DnXlph3RxXmIcslg52lSn3DDewQPA2Lv//EzHa/bmWgxZ8czNzYiJ7qsfZpdc
         aqjhvDIwc469YBvk2bITUBFC25PFWDZ3e0y8aS0gD52rB65Lv9wSdF6uvjEttGNolJuc
         rNtA==
X-Gm-Message-State: AIkVDXIL/qw+vlhMxTazyM79JsDfOij07X/3xuKbdXvl0XXoH1IFgObqrl5fFA+Istznfw==
X-Received: by 10.98.62.153 with SMTP id y25mr2503928pfj.162.1484038167867;
        Tue, 10 Jan 2017 00:49:27 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id m12sm3411983pfg.92.2017.01.10.00.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 00:49:27 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v10 15/20] ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
Date:   Tue, 10 Jan 2017 14:19:48 +0530
Message-Id: <20170110084953.15890-16-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170110084953.15890-1-Karthik.188@gmail.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the 'lstrip=<N>' option only takes a positive value '<N>'
and strips '<N>' slash-separated path components from the left. Modify
the 'lstrip' option to also take a negative number '<N>' which would
strip from the left as necessary and _leave_ behind only 'N'
slash-separated path components from the right-most end.

For e.g. %(refname:lstrip=-1) would make 'foo/goo/abc' into 'abc'.

Add documentation and tests for the same.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  7 ++++++-
 ref-filter.c                       | 27 ++++++++++++++++++++++-----
 t/t6300-for-each-ref.sh            | 12 ++++++------
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 04ffc3552..331e1fef8 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -98,7 +98,12 @@ refname::
 	abbreviation mode. If `lstrip=<N>` is appended, strips `<N>`
 	slash-separated path components from the front of the refname
 	(e.g., `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo`.
-	`<N>` must be a positive integer.
+	if `<N>` is a negative number, then only `<N>` path components
+	are left behind. (e.g., `%(refname:lstrip=-2)` turns
+	`refs/tags/foo` into `tags/foo`). When the ref does not have
+	enough components, the result becomes an empty string if
+	stripping with positive <N>, or it becomes the full refname if
+	stripping with negative <N>.  Neither is an error.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
diff --git a/ref-filter.c b/ref-filter.c
index 76553ebc4..1cd92ea4e 100644
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
index d3d1a97db..203cfaa15 100755
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
2.11.0

