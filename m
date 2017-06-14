Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C033920401
	for <e@80x24.org>; Wed, 14 Jun 2017 09:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbdFNJJh (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 05:09:37 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:44858 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751866AbdFNJHr (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Jun 2017 05:07:47 -0400
X-AuditID: 12074413-d93ff7000000742e-1b-5940fcdc1d1d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 5B.FC.29742.CDCF0495; Wed, 14 Jun 2017 05:07:41 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCBFA.dip0.t-ipconnect.de [87.188.203.250])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5E97WEQ022456
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 14 Jun 2017 05:07:38 -0400
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
Subject: [PATCH 1/2] for_each_bisect_ref(): don't trim refnames
Date:   Wed, 14 Jun 2017 11:07:26 +0200
Message-Id: <3615deefe90bebe746618b04c055a466a442f85b.1497430232.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497430232.git.mhagger@alum.mit.edu>
References: <cover.1497430232.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqHv3j0OkwYZV7BZrn91hsni+/gS7
        RdeVbiaLht4rzBZP5t5ltri9Yj6zxZKHr5ktuqe8ZbT40dLDbLF5czuLxYQjK1gsHvW9ZXfg
        8fj7/gOTx85Zd9k9Fmwq9Xj4qovd48SM3yweXe1H2Dye9e5h9Lh4Sdnj7oQeFo/Pm+QCuKK4
        bFJSczLLUov07RK4MqZ8Xc5UsFi8Yu+/RsYGxm7hLkZODgkBE4ktLRNZuhi5OIQEdjBJ/L16
        iQ3COcUkseLqW3aQKjYBXYlFPc1MILaIgJrExLZDYB3MAstYJLrO/GIESQgL2Etc3TyNGcRm
        EVCVWPDrIZDNwcErECWx4XU8xDZ5iV1tF1lBbE4BC4lb11tYQGwhAXOJiZ0n2SYw8ixgZFjF
        KJeYU5qrm5uYmVOcmqxbnJyYl5dapGuul5tZopeaUrqJERKwwjsYd52UO8QowMGoxMP74L19
        pBBrYllxZe4hRkkOJiVR3vrNDpFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHglzgPleFMSK6tS
        i/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvAt/AzUKFqWmp1akZeaUIKSZODhB
        hvMADc/+CTK8uCAxtzgzHSJ/ilFRSpy3GaRZACSRUZoH1wtLKK8YxYFeEebdC1LFA0xGcN2v
        gAYzAQ0OugA2uCQRISXVwOiy/956LoWDSlZ/AitPvH5XkbHPy//3N389x4dTrpsUzSt7xL+s
        tadivZyX9IHIp9vUV1jqhbrvd67Pm5VxcFH/qq8qK0SvpRhvP/XZ3EhcsIhJ+dq/7TvkFH33
        zQu9lLz1Btu74oM1HbOVz964Vt1leuOe7w2RTZuV9ln3G9w6Lqq+T/vgf2klluKMREMt5qLi
        RABb3YJVAwMAAA==
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
  API.

* Change `for_each_bad_bisect_ref()` to call the new function rather
  than `for_each_ref_in_submodule()`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c     | 12 ++++++++++++
 refs.h     |  5 ++++-
 revision.c |  2 +-
 3 files changed, 17 insertions(+), 2 deletions(-)

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
-- 
2.11.0

