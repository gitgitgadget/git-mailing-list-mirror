Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6F9120401
	for <e@80x24.org>; Sun, 18 Jun 2017 13:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbdFRNkA (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 09:40:00 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:60926 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753145AbdFRNj6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Jun 2017 09:39:58 -0400
X-AuditID: 12074413-d7bff7000000742e-73-594682abcb0b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 1E.91.29742.BA286495; Sun, 18 Jun 2017 09:39:55 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE99B.dip0.t-ipconnect.de [84.170.233.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5IDdj8h017544
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 18 Jun 2017 09:39:51 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98yvind=20Holm?= <sunny@sunbase.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/2] for_each_bisect_ref(): don't trim refnames
Date:   Sun, 18 Jun 2017 15:39:41 +0200
Message-Id: <dc91209f6e11a00a8d9fa70a74cf4b25528a67d1.1497792827.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497792827.git.mhagger@alum.mit.edu>
References: <cover.1497792827.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLu6yS3SoG2vksXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8WTuXeZLW6vmM9sseTha2aL7ilvGS1+tPQwW2ze3M5iMeHIChaLR31v2R14
        PP6+/8DksXPWXXaPBZtKPR6+6mL3ODHjN4tHV/sRNo9nvXsYPS5eUva4O6GHxePzJrkArigu
        m5TUnMyy1CJ9uwSujCPrzrIWXJKruNS2g7mB8ZNEFyMnh4SAicT3tg1sXYxcHEICO5gk/ry4
        yw7hnGKSaPo9hw2kik1AV2JRTzMTiC0ioCYxse0QC0gRs8AyFomuM78YQRLCAk4S9/89Ygax
        WQRUJWZ8vwDWwCsQJXFt0QZGiHXyErvaLrKC2JwCFhLvT14DqxcSMJe41NbOPIGRZwEjwypG
        ucSc0lzd3MTMnOLUZN3i5MS8vNQiXXO93MwSvdSU0k2MkJAV3sG466TcIUYBDkYlHt4X7a6R
        QqyJZcWVuYcYJTmYlER5P8m6RQrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4e32BMrxpiRWVqUW
        5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4tzQCNQoWpaanVqRl5pQgpJk4OEGG
        8wANl64FGV5ckJhbnJkOkT/FqCglznu1ASghAJLIKM2D64WllFeM4kCvCPMeAlnBA0xHcN2v
        gAYzAQ1mPuMCMrgkESEl1cC4XaA5b6ut1vbfZxO/b9K23RO8NefSqqWKpdv4jeataPpx13HS
        afbWTZV5hxZXvfasXrS90ETtily27I0+vpVLH+2rZjoQELjka9OL2r/zpH0W98d/NTq8/vms
        +aY/rsY2/J0gfE503a73MQLXjhfcraxtWcBUKVV65qjU6bXrJlUVfj3CcmyejBJLcUaioRZz
        UXEiAOnphMgEAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`for_each_bisect_ref()` is called by `for_each_bad_bisect_ref()` with
a term "bad". This used to make it call `for_each_ref_in_submodule()`
with a prefix "refs/bisect/bad". But the latter is the name of the
reference that is being sought, so the empty string was being passed
to the callback as the trimmed refname. Moreover, this questionable
practice was turned into an error by

    b9c8e7f2fb prefix_ref_iterator: don't trim too much, 2017-05-22

It makes more sense (and agrees better with the documentation of
`--bisect`) for the callers to receive the full reference names. So

* Add a new function, `for_each_fullref_in_submodule()`, to the refs
  API. This plugs a gap in the existing functionality, analogous to
  `for_each_fullref_in()` but accepting a `submodule` argument.

* Change `for_each_bad_bisect_ref()` to call the new function rather
  than `for_each_ref_in_submodule()`.

* Add a test.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c                     | 12 ++++++++++++
 refs.h                     |  5 ++++-
 revision.c                 |  2 +-
 t/t6002-rev-list-bisect.sh | 14 ++++++++++++++
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index f0685c9251..32177969f0 100644
--- a/refs.c
+++ b/refs.c
@@ -1341,6 +1341,18 @@ int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 				    prefix, fn, cb_data);
 }
 
+int for_each_fullref_in_submodule(const char *submodule, const char *prefix,
+				  each_ref_fn fn, void *cb_data,
+				  unsigned int broken)
+{
+	unsigned int flag = 0;
+
+	if (broken)
+		flag = DO_FOR_EACH_INCLUDE_BROKEN;
+	return do_for_each_ref(get_submodule_ref_store(submodule),
+			       prefix, fn, 0, flag, cb_data);
+}
+
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(get_main_ref_store(),
diff --git a/refs.h b/refs.h
index 4be14c4b3c..aa4ecc83d0 100644
--- a/refs.h
+++ b/refs.h
@@ -303,7 +303,10 @@ int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
 int for_each_ref_submodule(const char *submodule,
 			   each_ref_fn fn, void *cb_data);
 int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-		each_ref_fn fn, void *cb_data);
+			      each_ref_fn fn, void *cb_data);
+int for_each_fullref_in_submodule(const char *submodule, const char *prefix,
+				  each_ref_fn fn, void *cb_data,
+				  unsigned int broken);
 int for_each_tag_ref_submodule(const char *submodule,
 			       each_ref_fn fn, void *cb_data);
 int for_each_branch_ref_submodule(const char *submodule,
diff --git a/revision.c b/revision.c
index 9c67cb6026..50039c92d6 100644
--- a/revision.c
+++ b/revision.c
@@ -2044,7 +2044,7 @@ static int for_each_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_d
 	struct strbuf bisect_refs = STRBUF_INIT;
 	int status;
 	strbuf_addf(&bisect_refs, "refs/bisect/%s", term);
-	status = for_each_ref_in_submodule(submodule, bisect_refs.buf, fn, cb_data);
+	status = for_each_fullref_in_submodule(submodule, bisect_refs.buf, fn, cb_data, 0);
 	strbuf_release(&bisect_refs);
 	return status;
 }
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index 3bf2759eae..534903bbd2 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -235,4 +235,18 @@ test_sequence "--bisect"
 
 #
 #
+
+test_expect_success '--bisect can default to good/bad refs' '
+	git update-ref refs/bisect/bad c3 &&
+	good=$(git rev-parse b1) &&
+	git update-ref refs/bisect/good-$good $good &&
+	good=$(git rev-parse c1) &&
+	git update-ref refs/bisect/good-$good $good &&
+
+	# the only thing between c3 and c1 is c2
+	git rev-parse c2 >expect &&
+	git rev-list --bisect >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.11.0

