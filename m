Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A923200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755569AbcL0QXt (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:23:49 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36414 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755530AbcL0QXn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:43 -0500
Received: by mail-pf0-f196.google.com with SMTP id c4so18371773pfb.3
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rVwYAT8/XG+dpx6WYjyHy2o+XJgcp+7Qh26GjY5DkxU=;
        b=bItg/oNBpo+MZU4irlKq9XlrfbOWGghSan2uRjFSMCpoDhcle/icGktvpHA+Je/s7O
         C0Z48cFkzkKkRIkj8nI8+d4iBT+FZQtVSyEbsOB1NA/n+gSbAcDUXkIHjq9eE199nbA7
         uGg8U/qyi6rtMb4Tu+H4XsJr+53VvFyuJ8feJuRZ5p2UmFNZCmaYImhOP/zaIn+2ygAX
         mFgqd4sZZU4I3O7D0Ai/vNyTbv8IeEjkS2W2dFPtJH8aLwMgWiW89qdRTwQ8Riei7k1L
         1wRZ0celYkLaJ6+aqQPzWtcCyXcegsaJsS1G1ajIWPSlAq1erh33YsGa1KxkH6iv8/Vy
         aQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rVwYAT8/XG+dpx6WYjyHy2o+XJgcp+7Qh26GjY5DkxU=;
        b=GD5yqiBEL7AKaXxvbRES6F4x08vAnz/cHbzoN1qxOfhtFu6VKyoc/4WBtgtukZIjl2
         ul/xg9viHh71xgxtTrQlIiOaUb9ST0+8MNwrYDR/GK3v36O06S4WvNDHLBxnoTd6GL0v
         MYbhoO9JjfnlmSPiy6LvF83qvuaplibIBS0URrs+ubUHM3D3NkKpz54I03yNbd24sTYy
         lXnLEVkwDqOMVm8UjMCpPVo57iMNjhNg+GkxmA4ejNnkS1hkRBioLN38SEzBhE15O3FC
         VX4bHA29+tv/5V51zinzVRRy88PWjOUdTZUV/t8qM57hW2FUgiSMTXWay/95Kzul7u5e
         nK2A==
X-Gm-Message-State: AIkVDXK2D5lbG/YcCbPOTaU3+n9DLQdQTKf/QLzXt12ucJY4+e58KDFQW/K56SgjvRTi3Q==
X-Received: by 10.99.178.89 with SMTP id t25mr59170096pgo.131.1482855822697;
        Tue, 27 Dec 2016 08:23:42 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:42 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <karthik.188@gmail.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v9 12/20] ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
Date:   Tue, 27 Dec 2016 21:53:49 +0530
Message-Id: <20161227162357.28212-13-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
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
index 0fa5818..e7cdff6 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -116,23 +116,24 @@ objectname::
 
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
index 7bfd656..9140539 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -54,7 +54,8 @@ static struct used_atom {
 		char color[COLOR_MAXLEN];
 		struct align align;
 		struct {
-			enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT } option;
+			enum { RR_REF, RR_TRACK, RR_TRACKSHORT } option;
+			struct refname_atom refname;
 			unsigned int nobracket : 1;
 		} remote_ref;
 		struct {
@@ -104,7 +105,9 @@ static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 	int i;
 
 	if (!arg) {
-		atom->u.remote_ref.option = RR_NORMAL;
+		atom->u.remote_ref.option = RR_REF;
+		refname_atom_parser_internal(&atom->u.remote_ref.refname,
+					     arg, atom->name);
 		return;
 	}
 
@@ -114,16 +117,17 @@ static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
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
@@ -1119,8 +1123,8 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
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
@@ -1152,8 +1156,8 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
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
index 18a9e25..c538084 100755
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

