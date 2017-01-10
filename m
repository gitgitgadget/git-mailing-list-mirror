Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C3C7205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 08:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031292AbdAJIte (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 03:49:34 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35653 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031252AbdAJItb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 03:49:31 -0500
Received: by mail-pf0-f193.google.com with SMTP id f144so9039436pfa.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 00:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lr2yq4N2wEEZojq2fZkP9kiIX3i8UY39pm8SNv4hd48=;
        b=JLnvIRoLePL33nk6BwCLOza7cLMT3XaVJY09wX3BR5IIp8SgTKtOKkfuLGek/qpplw
         Zm1DRHVKJG+FUqP6ZtoGbUFl9d4sPgtjK8YZuD7IKbXLT2xr6FKk1c6h9qynu+5+i5AW
         3BR7IG9+XCfXgn1Bkgd7DQf6uOIx3nuBreS2UF8Luba2igicOe3y3t5uomQii8TlOPGx
         b4fz0FCmgPy6S2TyvdRzUV2xJ8GzLZQkYdkrWa4ikZh0vWyfN7ZihPDDHWc7bD/RwUnt
         cSrAdqDUIbHj9BbutjTaqYUO0m/o//DM4Y6HCXlX/UpLUEtf+xqaUL6epw1Rv7ZjIFUA
         SoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lr2yq4N2wEEZojq2fZkP9kiIX3i8UY39pm8SNv4hd48=;
        b=V2oyXQO2ignnfi7fpLqhZDYLdORGxRuSLosBK2xzHskEcapSn4uCwBLZq9+nBPjRS8
         PZ4Q2KCmkVVNnagF+/+8ci782QVGOT1hx1BaSUUVd/bI19FtY45eAuVYlI5sX+DAl3fb
         +ZYygBX7tij9dGn/RzGgCIEvvCmxGnnMw1X+PNv1MI1JM3P6k4lBfx/kZzE/rO6enqGS
         On+O6oKfa1BGjIcf+U825WE09Zkn+1/iWsZqg9WmeZmBzSBJVW/a4qmNWPRFeLVUf54q
         G4XlucQDEm7fupTePNZjGg9fWOMaZ637HGWSBo7WTUbsNXo3pbG0v43GARYk3IFpNY3Y
         xEuQ==
X-Gm-Message-State: AIkVDXLjkIuBuhDffD0WoTn3wjacyFwXrat333vLQN8PH/Jr3DvEAmxi4MvL/a701gr3yQ==
X-Received: by 10.84.237.22 with SMTP id s22mr3293582plk.163.1484038170373;
        Tue, 10 Jan 2017 00:49:30 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id m12sm3411983pfg.92.2017.01.10.00.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 00:49:29 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v10 16/20] ref-filter: add an 'rstrip=<N>' option to atoms which deal with refnames
Date:   Tue, 10 Jan 2017 14:19:49 +0530
Message-Id: <20170110084953.15890-17-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170110084953.15890-1-Karthik.188@gmail.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com>
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
 Documentation/git-for-each-ref.txt | 38 +++++++++++++++++++----------------
 ref-filter.c                       | 41 ++++++++++++++++++++++++++++++++++++--
 t/t6300-for-each-ref.sh            | 19 ++++++++++++++++++
 3 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 331e1fef8..08be8462c 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -97,11 +97,13 @@ refname::
 	The option core.warnAmbiguousRefs is used to select the strict
 	abbreviation mode. If `lstrip=<N>` is appended, strips `<N>`
 	slash-separated path components from the front of the refname
-	(e.g., `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo`.
+	(e.g., `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo` and
+	`%(refname:rstrip=2)` turns `refs/tags/foo` into `refs`).
 	if `<N>` is a negative number, then only `<N>` path components
 	are left behind. (e.g., `%(refname:lstrip=-2)` turns
-	`refs/tags/foo` into `tags/foo`). When the ref does not have
-	enough components, the result becomes an empty string if
+	`refs/tags/foo` into `tags/foo` and `%(refname:rstrip=-1)`
+	turns `refs/tags/foo` into `refs`). When the ref does not
+	have enough components, the result becomes an empty string if
 	stripping with positive <N>, or it becomes the full refname if
 	stripping with negative <N>.  Neither is an error.
 
@@ -120,22 +122,23 @@ objectname::
 
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
 
@@ -177,8 +180,9 @@ if::
 
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
index 1cd92ea4e..dd7e751f2 100644
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
index 203cfaa15..25a9973ce 100755
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
2.11.0

