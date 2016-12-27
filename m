Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C863E200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbcL0QYD (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:24:03 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33322 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755411AbcL0QXx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:53 -0500
Received: by mail-pg0-f68.google.com with SMTP id g1so12848799pgn.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z9H0U91OGMypfFeQjNths6vl/fCwb592HBwW20dg6so=;
        b=lfsyaeABDCzY+eQ/XGE8PMSYQHPFXNFvDAM7JZKBxj4QCLXoVrkSZlK+fCckjVsZ7F
         udmNR2Cdx+ZOw9skhDnFf/LPGVMxUyoa3YkFTdpdsDGWwEgB4Ad4GuIbP/UoCTJjsdA5
         7Q2mbcyBciyg5zQXo1HZ/53DRMKTofElJMwVgKNHNsRH/McdtXWS8Ic7xCqt5qtf80Br
         1fzEXHj4Eo5RAazhT8sVXiubmxyAtPUOSjCMRuriRTvOx9+MbEhMsbvvRgSqoe8eW/v9
         etjPdjvIIsQ79llURtRPZckGqnK53vpPxfLk4mcAxdgwnwydCpBwv1PAOXMZEY2/hcK+
         SyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z9H0U91OGMypfFeQjNths6vl/fCwb592HBwW20dg6so=;
        b=QNR2D8aFpHQI+Mir1iSGSs1TTPim/F9oauicQqyn2irAJPqG5QSUKdhT1ukleN2G4B
         OagvB786mRE5hBnn53W2OLrOer1ZUcVpnT7AhDfjliuRL1gEM7vRex/bpPNhTs3rQmlx
         bzGHKIyzsrMuvUC8Fn36CChZ950sHf66tq2vfMLRaZTVjLJPAHsyK+oa9FB30m3giR6Z
         Ny8vJAdhj9C6hQXpZ+SkEtZxgom/oEwQhtCwEf4BtDdyj4JJtEqGQK0opgFvL+JqQ6d0
         ntPoxoCGkte8HT+4DM4zwzeWP22ifaGIGTmedbP4hRYfbZGr34JB4K/0NKiwR/CLD/JH
         RuZQ==
X-Gm-Message-State: AIkVDXKcSGZveJ+2hgpba/5iXXkYClbyMdDmlQuVmfiaOX6jnfN3NJA+dmWcSXPFV6PzeA==
X-Received: by 10.99.126.6 with SMTP id z6mr59526831pgc.182.1482855832571;
        Tue, 27 Dec 2016 08:23:52 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:52 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v9 16/20] ref-filter: add an 'rstrip=<N>' option to atoms which deal with refnames
Date:   Tue, 27 Dec 2016 21:53:53 +0530
Message-Id: <20161227162357.28212-17-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Complimenting the existing 'lstrip=<N>' option, add an 'rstrip=<N>'
option which strips `<N>` slash-separated path components from the end
of the refname (e.g., `%(refname:rstrip=2)` turns `refs/tags/foo` into
`refs`).

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 40 ++++++++++++++++++++-----------------
 ref-filter.c                       | 41 ++++++++++++++++++++++++++++++++++++--
 t/t6300-for-each-ref.sh            | 19 ++++++++++++++++++
 3 files changed, 80 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 9055ba0..81db67d 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -95,10 +95,12 @@ refname::
 	The name of the ref (the part after $GIT_DIR/).
 	For a non-ambiguous short name of the ref append `:short`.
 	The option core.warnAmbiguousRefs is used to select the strict
-	abbreviation mode. If `lstrip=<N>` is appended, strips `<N>`
-	slash-separated path components from the front of the refname
-	(e.g., `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo`.
-	if `<N>` is a negative number, then only `<N>` path components
+	abbreviation mode. The `lstrip=<N>` or `rstrip=<N>` option can
+	be appended to strip `<N>` slash-separated path components
+	from the left or right of the refname respectively (e.g.,
+	`%(refname:lstrip=2)` turns `refs/tags/foo` into `foo` and
+	`%(refname:rstrip=2)` turns `refs/tags/foo` into `refs`).  if
+	`<N>` is a negative number, then only `<N>` path components
 	are left behind.
 
 objecttype::
@@ -116,22 +118,23 @@ objectname::
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
-	from the displayed ref. Respects `:short` and `:lstrip` in the
-	same way as `refname` above.  Additionally respects `:track`
-	to show "[ahead N, behind M]" and `:trackshort` to show the
-	terse version: ">" (ahead), "<" (behind), "<>" (ahead and
-	behind), or "=" (in sync). `:track` also prints "[gone]"
-	whenever unknown upstream ref is encountered. Append
-	`:track,nobracket` to show tracking information without
-	brackets (i.e "ahead N, behind M").  Has no effect if the ref
-	does not have tracking information associated with it.  All
-	the options apart from `nobracket` are mutually exclusive, but
-	if used together the last option is selected.
+	from the displayed ref. Respects `:short`, `:lstrip` and
+	`:rstrip` in the same way as `refname` above.  Additionally
+	respects `:track` to show "[ahead N, behind M]" and
+	`:trackshort` to show the terse version: ">" (ahead), "<"
+	(behind), "<>" (ahead and behind), or "=" (in sync). `:track`
+	also prints "[gone]" whenever unknown upstream ref is
+	encountered. Append `:track,nobracket` to show tracking
+	information without brackets (i.e "ahead N, behind M").  Has
+	no effect if the ref does not have tracking information
+	associated with it.  All the options apart from `nobracket`
+	are mutually exclusive, but if used together the last option
+	is selected.
 
 push::
 	The name of a local ref which represents the `@{push}`
 	location for the displayed ref. Respects `:short`, `:lstrip`,
-	`:track`, and `:trackshort` options as `upstream`
+	`:rstrip`, `:track`, and `:trackshort` options as `upstream`
 	does. Produces an empty string if no `@{push}` ref is
 	configured.
 
@@ -173,8 +176,9 @@ if::
 
 symref::
 	The ref which the given symbolic ref refers to. If not a
-	symbolic ref, nothing is printed. Respects the `:short` and
-	`:lstrip` options in the same way as `refname` above.
+	symbolic ref, nothing is printed. Respects the `:short`,
+	`:lstrip` and `:rstrip` options in the same way as `refname`
+	above.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/ref-filter.c b/ref-filter.c
index 1cd92ea..dd7e751 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -33,8 +33,8 @@ struct if_then_else {
 };
 
 struct refname_atom {
-	enum { R_NORMAL, R_SHORT, R_LSTRIP } option;
-	int lstrip;
+	enum { R_NORMAL, R_SHORT, R_LSTRIP, R_RSTRIP } option;
+	int lstrip, rstrip;
 };
 
 /*
@@ -95,6 +95,10 @@ static void refname_atom_parser_internal(struct refname_atom *atom,
 		atom->option = R_LSTRIP;
 		if (strtol_i(arg, 10, &atom->lstrip))
 			die(_("Integer value expected refname:lstrip=%s"), arg);
+	} else if (skip_prefix(arg, "rstrip=", &arg)) {
+		atom->option = R_RSTRIP;
+		if (strtol_i(arg, 10, &atom->rstrip))
+			die(_("Integer value expected refname:rstrip=%s"), arg);
 	} else
 		die(_("unrecognized %%(%s) argument: %s"), name, arg);
 }
@@ -1125,12 +1129,45 @@ static const char *lstrip_ref_components(const char *refname, int len)
 	return start;
 }
 
+static const char *rstrip_ref_components(const char *refname, int len)
+{
+	long remaining = len;
+	char *start = xstrdup(refname);
+
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
+	while (remaining-- > 0) {
+		char *p = strrchr(start, '/');
+		if (p == NULL)
+			return "";
+		else
+			p[0] = '\0';
+	}
+	return start;
+}
+
 static const char *show_ref(struct refname_atom *atom, const char *refname)
 {
 	if (atom->option == R_SHORT)
 		return shorten_unambiguous_ref(refname, warn_ambiguous_refs);
 	else if (atom->option == R_LSTRIP)
 		return lstrip_ref_components(refname, atom->lstrip);
+	else if (atom->option == R_RSTRIP)
+		return rstrip_ref_components(refname, atom->rstrip);
 	else
 		return refname;
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 203cfaa..25a9973 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -55,14 +55,22 @@ test_atom head refname:lstrip=1 heads/master
 test_atom head refname:lstrip=2 master
 test_atom head refname:lstrip=-1 master
 test_atom head refname:lstrip=-2 heads/master
+test_atom head refname:rstrip=1 refs/heads
+test_atom head refname:rstrip=2 refs
+test_atom head refname:rstrip=-1 refs
+test_atom head refname:rstrip=-2 refs/heads
 test_atom head upstream refs/remotes/origin/master
 test_atom head upstream:short origin/master
 test_atom head upstream:lstrip=2 origin/master
 test_atom head upstream:lstrip=-2 origin/master
+test_atom head upstream:rstrip=2 refs/remotes
+test_atom head upstream:rstrip=-2 refs/remotes
 test_atom head push refs/remotes/myfork/master
 test_atom head push:short myfork/master
 test_atom head push:lstrip=1 remotes/myfork/master
 test_atom head push:lstrip=-1 master
+test_atom head push:rstrip=1 refs/remotes/myfork
+test_atom head push:rstrip=-1 refs
 test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname $(git rev-parse refs/heads/master)
@@ -631,4 +639,15 @@ test_expect_success 'Verify usage of %(symref:lstrip) atom' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+refs
+refs/heads
+EOF
+
+test_expect_success 'Verify usage of %(symref:rstrip) atom' '
+	git for-each-ref --format="%(symref:rstrip=2)" refs/heads/sym > actual &&
+	git for-each-ref --format="%(symref:rstrip=-2)" refs/heads/sym >> actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.10.2

