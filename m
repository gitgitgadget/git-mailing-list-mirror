Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE36C20259
	for <e@80x24.org>; Wed,  7 Dec 2016 15:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753403AbcLGPg5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 10:36:57 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33073 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753169AbcLGPgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 10:36:51 -0500
Received: by mail-pg0-f66.google.com with SMTP id 3so23838949pgd.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 07:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zsd8HrkuJSUC22f8nkPgADqQEEHR4QyG8Mj6d8LSXWE=;
        b=sLrhDNknFJ0lSOjeF2lIagD3AZ1QKkE/LLbA6PVUk+xB4LeWJ19si8BtlEZl85PXji
         86rEYhuyN5lI4rNV8kNPL/0C9YJ7d4PzNgOfrQXRfAUlrtYZjF6iPGErrSvxFO0MD0Kr
         R2/UJv5svlaVuaLd5Ydbs4mBcBlk9XrEIb2rE6LxgSwJL9T4+tBY4QHVerVUVALwiXVM
         bsUhWCXytf4MUlBrJVgyveqRjM0wd0hSNjx38dFozfrM1vq8UINreEHVBFzYCZtV/rxY
         kaxMDTfFy/I6W38KIU7KuX4fHR7NlV3ATO3htowoBWy8nw8UFUPJonpqdL/CMfJmQy9S
         IeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zsd8HrkuJSUC22f8nkPgADqQEEHR4QyG8Mj6d8LSXWE=;
        b=hVy8SfYqzlleqVUu1AA04EUmHieOv9Ky5RmnvVVsfFl+PMr8LqgZZAo9IXhYVl+iGq
         LEYha/Kpd8dBKb8GEu2duR4muu9dh3pvpmY6ObODhhHQIjO3uzDE/EXUwo77wERELov2
         NOdFna3F1iJ+WDnv6f1yQO3AuHSNcN0Z9OKHUQd5a2ia+KU2gEEVVpYbMeYo5A7U2ZqA
         zgxHZcBnO6qSt/IcCDo76uF+eNAQhIsFQ+mqlLVEDVGMzUVDfkO7SYfV2e8SKplxlPVh
         YFzhWknL21Y7RGS9M5QHxNc77QjN0PvyfYxIhMkoZTicNoPUlB8+zPqK3CycV3AY1+e7
         2m3g==
X-Gm-Message-State: AKaTC00xiAcZnFB0B7hNfdktwCX/6Flfle87sH2CmJ/k7HVTRfZeUaI+jy1k2nmxnTHniQ==
X-Received: by 10.98.59.82 with SMTP id i79mr68706148pfa.147.1481125001574;
        Wed, 07 Dec 2016 07:36:41 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([122.15.255.69])
        by smtp.gmail.com with ESMTPSA id l7sm43584459pfg.35.2016.12.07.07.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:36:41 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com, jnareb@gmail.com,
        Karthik Nayak <karthik.188@gmail.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v8 12/19] ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
Date:   Wed,  7 Dec 2016 21:06:20 +0530
Message-Id: <20161207153627.1468-13-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161207153627.1468-1-Karthik.188@gmail.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Use the recently introduced refname_atom_parser_internal() within
remote_ref_atom_parser(), this provides a common base for all the ref
printing atoms, allowing %(upstream) and %(push) to also use the
':strip' option.

The atoms '%(push)' and '%(upstream)' will retain the ':track' and
':trackshort' atom modifiers to themselves as they have no meaning in
context to the '%(refname)' and '%(symref)' atoms.

Update the documentation and tests to reflect the same.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 31 ++++++++++++++++---------------
 ref-filter.c                       | 26 +++++++++++++++-----------
 t/t6300-for-each-ref.sh            |  2 ++
 3 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 8224f37..6a1e747 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -113,23 +113,24 @@ objectname::
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
-	from the displayed ref. Respects `:short` in the same way as
-	`refname` above.  Additionally respects `:track` to show
-	"[ahead N, behind M]" and `:trackshort` to show the terse
-	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
-	or "=" (in sync). `:track` also prints "[gone]" whenever
-	unknown upstream ref is encountered. Append `:track,nobracket`
-	to show tracking information without brackets (i.e "ahead N,
-	behind M").  Has no effect if the ref does not have tracking
-	information associated with it.  All the options apart from
-	`nobracket` are mutually exclusive, but if used together the
-	last option is selected.
+	from the displayed ref. Respects `:short` and `:strip` in the
+	same way as `refname` above.  Additionally respects `:track`
+	to show "[ahead N, behind M]" and `:trackshort` to show the
+	terse version: ">" (ahead), "<" (behind), "<>" (ahead and
+	behind), or "=" (in sync). `:track` also prints "[gone]"
+	whenever unknown upstream ref is encountered. Append
+	`:track,nobracket` to show tracking information without
+	brackets (i.e "ahead N, behind M").  Has no effect if the ref
+	does not have tracking information associated with it.  All
+	the options apart from `nobracket` are mutually exclusive, but
+	if used together the last option is selected.
 
 push::
-	The name of a local ref which represents the `@{push}` location
-	for the displayed ref. Respects `:short`, `:track`, and
-	`:trackshort` options as `upstream` does. Produces an empty
-	string if no `@{push}` ref is configured.
+	The name of a local ref which represents the `@{push}`
+	location for the displayed ref. Respects `:short`, `:strip`,
+	`:track`, and `:trackshort` options as `upstream`
+	does. Produces an empty string if no `@{push}` ref is
+	configured.
 
 HEAD::
 	'*' if HEAD matches current ref (the checked out branch), ' '
diff --git a/ref-filter.c b/ref-filter.c
index 9f5522d..be535a6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -53,7 +53,8 @@ static struct used_atom {
 		char color[COLOR_MAXLEN];
 		struct align align;
 		struct {
-			enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT } option;
+			enum { RR_REF, RR_TRACK, RR_TRACKSHORT } option;
+			struct refname_atom refname;
 			unsigned int nobracket: 1;
 		} remote_ref;
 		struct {
@@ -103,7 +104,9 @@ static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 	int i;
 
 	if (!arg) {
-		atom->u.remote_ref.option = RR_NORMAL;
+		atom->u.remote_ref.option = RR_REF;
+		refname_atom_parser_internal(&atom->u.remote_ref.refname,
+					     arg, atom->name);
 		return;
 	}
 
@@ -113,16 +116,17 @@ static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 	for (i = 0; i < params.nr; i++) {
 		const char *s = params.items[i].string;
 
-		if (!strcmp(s, "short"))
-			atom->u.remote_ref.option = RR_SHORTEN;
-		else if (!strcmp(s, "track"))
+		if (!strcmp(s, "track"))
 			atom->u.remote_ref.option = RR_TRACK;
 		else if (!strcmp(s, "trackshort"))
 			atom->u.remote_ref.option = RR_TRACKSHORT;
 		else if (!strcmp(s, "nobracket"))
 			atom->u.remote_ref.nobracket = 1;
-		else
-			die(_("unrecognized format: %%(%s)"), atom->name);
+		else {
+			atom->u.remote_ref.option = RR_REF;
+			refname_atom_parser_internal(&atom->u.remote_ref.refname,
+						     arg, atom->name);
+		}
 	}
 
 	string_list_clear(&params, 0);
@@ -1099,8 +1103,8 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 				    struct branch *branch, const char **s)
 {
 	int num_ours, num_theirs;
-	if (atom->u.remote_ref.option == RR_SHORTEN)
-		*s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
+	if (atom->u.remote_ref.option == RR_REF)
+		*s = show_ref(&atom->u.remote_ref.refname, refname);
 	else if (atom->u.remote_ref.option == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours,
 				       &num_theirs, NULL)) {
@@ -1132,8 +1136,8 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 			*s = ">";
 		else
 			*s = "<>";
-	} else /* RR_NORMAL */
-		*s = refname;
+	} else
+		die("BUG: unhandled RR_* enum");
 }
 
 char *get_head_description(void)
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index b32ab79..2facfaf 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -55,8 +55,10 @@ test_atom head refname:strip=1 heads/master
 test_atom head refname:strip=2 master
 test_atom head upstream refs/remotes/origin/master
 test_atom head upstream:short origin/master
+test_atom head upstream:strip=2 origin/master
 test_atom head push refs/remotes/myfork/master
 test_atom head push:short myfork/master
+test_atom head push:strip=1 remotes/myfork/master
 test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname $(git rev-parse refs/heads/master)
-- 
2.10.2

