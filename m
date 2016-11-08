Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A2072022A
	for <e@80x24.org>; Tue,  8 Nov 2016 20:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933330AbcKHUMt (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 15:12:49 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35377 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933244AbcKHUMl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 15:12:41 -0500
Received: by mail-pf0-f196.google.com with SMTP id i88so20685714pfk.2
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 12:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IUooC3Ixf3ehCZ40kFarG2YINw62fRAHLjqCdAQLcSs=;
        b=YAKu4apyWm2+KLw8dILQUbnwfgAK/iNzEsPrMusecmek63AI8toPAymuzRoOvG8uWQ
         vn6Lfqryi9HSwTns3BE3u1r56T+JXgPF4utAlJJk7cV1UuBMN7gdGb6g1L1KPvKypKNT
         JASACj8NdUJcE/KipUwQt2FOBi05E6Hokv6h7jRY/k1v2Oj3/ak4fUx/kkOxE+5SaKgJ
         oZVaU/Nvjs9+0vFxE38tLAMKW/llyOfWju7TSqe5QD6mmamN2WanmO80VXI88JxRJhiG
         JlXgzbDsO+lUZnaNqT1lVuCa6alE3GKHDwu0SARmzYYJ7lrU4C7eTQ1P2EGyLKy4KpQr
         grlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IUooC3Ixf3ehCZ40kFarG2YINw62fRAHLjqCdAQLcSs=;
        b=AnIWlHQJkNmXrYa7clhr4kxwG8q+vrJ8YcqrXpvOB7G6XFW0vfXCgrwmljOPX5oSHk
         bw1pNezPnGryxCV67JoZdNowErRtcRQaeG+VMDLQ79riV+vJqnRiP3NruzJi3oGbizrw
         XpjxbMbWrPh/Fdy+mCQoCTxUj8I5Mv1wDsXOPywJoNl3ANvvVfUztkDScdC+fXa51q1w
         flP7StoXqaVBqZgU6Nbfc121E3HtH0zAV7eC2I+axYopkLKHQUxl6dvpYekWYB167tvS
         mYFeGjmH0nw4AUkbdiEddH/X57uWN53wbyWYb8HhSy96O0ju0ghicbzc+KoN/QoK3tQZ
         80pg==
X-Gm-Message-State: ABUngvdrtoQE+I3OFAEeSO0x74khI8lxEwgJXv7a5+qnLqw2HLPuZvMMCs6+axTjtlNq3g==
X-Received: by 10.99.39.132 with SMTP id n126mr21334109pgn.85.1478635960566;
        Tue, 08 Nov 2016 12:12:40 -0800 (PST)
Received: from localhost.localdomain ([27.5.65.216])
        by smtp.gmail.com with ESMTPSA id hv3sm50239466pad.30.2016.11.08.12.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2016 12:12:40 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, Karthik Nayak <karthik.188@gmail.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for ref printing atoms
Date:   Wed,  9 Nov 2016 01:42:07 +0530
Message-Id: <20161108201211.25213-14-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161108201211.25213-1-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Add the options `:dir` and `:base` to all ref printing ('%(refname)',
'%(symref)', '%(push)' and '%(upstream)') atoms. The `:dir` option gives
the directory (the part after $GIT_DIR/) of the ref without the
refname. The `:base` option gives the base directory of the given
ref (i.e. the directory following $GIT_DIR/refs/).

Add tests and documentation for the same.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 34 +++++++++++++++++++---------------
 ref-filter.c                       | 29 +++++++++++++++++++++++++----
 t/t6300-for-each-ref.sh            | 24 ++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 600b703..f4ad297 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -96,7 +96,9 @@ refname::
 	slash-separated path components from the front of the refname
 	(e.g., `%(refname:strip=2)` turns `refs/tags/foo` into `foo`.
 	`<N>` must be a positive integer.  If a displayed ref has fewer
-	components than `<N>`, the command aborts with an error.
+	components than `<N>`, the command aborts with an error. For the base
+	directory of the ref (i.e. foo in refs/foo/bar/boz) append
+	`:base`. For the entire directory path append `:dir`.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
@@ -114,22 +116,23 @@ objectname::
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
-	from the displayed ref. Respects `:short` and `:strip` in the
-	same way as `refname` above.  Additionally respects `:track`
-	to show "[ahead N, behind M]" and `:trackshort` to show the
-	terse version: ">" (ahead), "<" (behind), "<>" (ahead and
-	behind), or "=" (in sync). `:track` also prints "[gone]"
-	whenever unknown upstream ref is encountered. Append
-	`:track,nobracket` to show tracking information without
-	brackets (i.e "ahead N, behind M").  Has no effect if the ref
-	does not have tracking information associated with it.
+	from the displayed ref. Respects `:short`, `:strip`, `:base`
+	and `:dir` in the same way as `refname` above.  Additionally
+	respects `:track` to show "[ahead N, behind M]" and
+	`:trackshort` to show the terse version: ">" (ahead), "<"
+	(behind), "<>" (ahead and behind), or "=" (in sync). `:track`
+	also prints "[gone]" whenever unknown upstream ref is
+	encountered. Append `:track,nobracket` to show tracking
+	information without brackets (i.e "ahead N, behind M").  Has
+	no effect if the ref does not have tracking information
+	associated with it.
 
 push::
 	The name of a local ref which represents the `@{push}`
 	location for the displayed ref. Respects `:short`, `:strip`,
-	`:track`, and `:trackshort` options as `upstream`
-	does. Produces an empty string if no `@{push}` ref is
-	configured.
+	`:track`, `:trackshort`, `:base` and `:dir` options as
+	`upstream` does. Produces an empty string if no `@{push}` ref
+	is configured.
 
 HEAD::
 	'*' if HEAD matches current ref (the checked out branch), ' '
@@ -169,8 +172,9 @@ if::
 
 symref::
 	The ref which the given symbolic ref refers to. If not a
-	symbolic ref, nothing is printed. Respects the `:short` and
-	`:strip` options in the same way as `refname` above.
+	symbolic ref, nothing is printed. Respects the `:short`,
+	`:strip`, `:base` and `:dir` options in the same way as
+	`refname` above.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/ref-filter.c b/ref-filter.c
index 7d3d3a6..b47b900 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -31,7 +31,7 @@ struct if_then_else {
 };
 
 struct refname_atom {
-	enum { R_NORMAL, R_SHORT, R_STRIP } option;
+	enum { R_BASE, R_DIR, R_NORMAL, R_SHORT, R_STRIP } option;
 	unsigned int strip;
 };
 
@@ -93,7 +93,11 @@ static void refname_atom_parser_internal(struct refname_atom *atom,
 		atom->option = R_STRIP;
 		if (strtoul_ui(arg, 10, &atom->strip) || atom->strip <= 0)
 			die(_("positive value expected refname:strip=%s"), arg);
-	} 	else
+	} else if (!strcmp(arg, "dir"))
+		atom->option = R_DIR;
+	else if (!strcmp(arg, "base"))
+		atom->option = R_BASE;
+	else
 		die(_("unrecognized %%(%s) argument: %s"), name, arg);
 }
 
@@ -252,7 +256,6 @@ static void if_atom_parser(struct used_atom *atom, const char *arg)
 		die(_("unrecognized %%(if) argument: %s"), arg);
 }
 
-
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -1096,7 +1099,25 @@ static const char *show_ref(struct refname_atom *atom, const char *refname)
 		return shorten_unambiguous_ref(refname, warn_ambiguous_refs);
 	else if (atom->option == R_STRIP)
 		return strip_ref_components(refname, atom->strip);
-	else
+	else if (atom->option == R_BASE) {
+		const char *sp, *ep;
+
+		if (skip_prefix(refname, "refs/", &sp)) {
+			ep = strchr(sp, '/');
+			if (!ep)
+				return "";
+			return xstrndup(sp, ep - sp);
+		}
+		return "";
+	} else if (atom->option == R_DIR) {
+		const char *sp, *ep;
+
+		sp = refname;
+		ep = strrchr(sp, '/');
+		if (!ep)
+			return "";
+		return xstrndup(sp, ep - sp);
+	} else
 		return refname;
 }
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 7ca0a12..8ff6568 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -53,12 +53,18 @@ test_atom head refname refs/heads/master
 test_atom head refname:short master
 test_atom head refname:strip=1 heads/master
 test_atom head refname:strip=2 master
+test_atom head refname:dir refs/heads
+test_atom head refname:base heads
 test_atom head upstream refs/remotes/origin/master
 test_atom head upstream:short origin/master
 test_atom head upstream:strip=2 origin/master
+test_atom head upstream:dir refs/remotes/origin
+test_atom head upstream:base remotes
 test_atom head push refs/remotes/myfork/master
 test_atom head push:short myfork/master
 test_atom head push:strip=1 remotes/myfork/master
+test_atom head push:dir refs/remotes/myfork
+test_atom head push:base remotes
 test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname $(git rev-parse refs/heads/master)
@@ -600,4 +606,22 @@ test_expect_success 'Verify usage of %(symref:strip) atom' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+refs/heads
+EOF
+
+test_expect_success 'Verify usage of %(symref:dir) atom' '
+	git for-each-ref --format="%(symref:dir)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+heads
+EOF
+
+test_expect_success 'Verify usage of %(symref:base) atom' '
+	git for-each-ref --format="%(symref:base)" refs/heads/sym > actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.10.2

