Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1D4E205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 08:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936370AbdAJItu (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 03:49:50 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35684 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936306AbdAJItn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 03:49:43 -0500
Received: by mail-pf0-f196.google.com with SMTP id f144so9039633pfa.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 00:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aL2K5/21VSWYSrkr5GdmcYGNZ2YJLiYA1DTtRNgVPcY=;
        b=eQITqeJrJnLcrmkUuMEhXvq2ztQuCgL0pHTSThDmsEUjrfkXzmxNp8hVihU2ulNjFq
         /S1kCLYjv64griktaEo2IKM8gxbFVHayLYArUHSIAoaGHgUyS/E+2UYxBi3s1v9NPXxZ
         Stsp8TvwyiMubovNcSgYAPG/kXgc/3XcErMCkpEJkFphzQuNRE3UZlSaASG9GcAHH//z
         yWoH5863lg+KtolxKXhx73iJFdAC+J7Mfe8e83Q4tnLdqupztyRcQOSYnkT4+csCRNMg
         hr/3zr2SmGw75lV9cIcF1/nZ1D5YwudOnQTWHDjyVgYrJ/uSoN/m6pBP/Oj96inBa3QE
         0nRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aL2K5/21VSWYSrkr5GdmcYGNZ2YJLiYA1DTtRNgVPcY=;
        b=fZ8AF0gmhlKKpFYnR15Ug4rWzivBWLDoyjCboMaII77Wb/dUPZES43tbCvJow1KqbP
         JzL+RNWdiIVcsyHUJVYOlhwOq+4iVUkzNqK5/bU1Ex5DadTjvjoSBiUNjjx1JqQmjudY
         XUQ2aynyjwn+mjpM39v1oNdRiQMHKXReem/GYWnjLGVVDY13ZpCB9dPEpM144UBkKX5r
         CKaOdNftmfgd5up/JLGGGeQyCFI8PgRd0833CsrOMRAN0i3o+cme42T40WL5Eo+hJ/U0
         T5KMMkoesBLy8BK9W3q6ngDR8oXG00097r0pw5C8F7nm7fkP4H7ieFaUDu5ADXUKVWmY
         mhNA==
X-Gm-Message-State: AIkVDXK5wze1ZvULbvCpIguoEe1dQYRigk/iEJwSZzVT5GPr7WSAvvhRNNOHBEetjK/CZg==
X-Received: by 10.99.96.9 with SMTP id u9mr2641672pgb.151.1484038172905;
        Tue, 10 Jan 2017 00:49:32 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id m12sm3411983pfg.92.2017.01.10.00.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 00:49:32 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 17/20] ref-filter: allow porcelain to translate messages in the output
Date:   Tue, 10 Jan 2017 14:19:50 +0530
Message-Id: <20170110084953.15890-18-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170110084953.15890-1-Karthik.188@gmail.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Introduce setup_ref_filter_porcelain_msg() so that the messages used in
the atom %(upstream:track) can be translated if needed. By default, keep
the messages untranslated, which is the right behavior for plumbing
commands. This is needed as we port branch.c to use ref-filter's
printing API's.

Written-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 29 +++++++++++++++++++++++++----
 ref-filter.h |  2 ++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index dd7e751f2..e478ec6c8 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -16,6 +16,27 @@
 #include "trailer.h"
 #include "wt-status.h"
 
+static struct ref_msg {
+	const char *gone;
+	const char *ahead;
+	const char *behind;
+	const char *ahead_behind;
+} msgs = {
+	 /* Untranslated plumbing messages: */
+	"gone",
+	"ahead %d",
+	"behind %d",
+	"ahead %d, behind %d"
+};
+
+void setup_ref_filter_porcelain_msg(void)
+{
+	msgs.gone = _("gone");
+	msgs.ahead = _("ahead %d");
+	msgs.behind = _("behind %d");
+	msgs.ahead_behind = _("ahead %d, behind %d");
+}
+
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 typedef enum { COMPARE_EQUAL, COMPARE_UNEQUAL, COMPARE_NONE } cmp_status;
 
@@ -1181,15 +1202,15 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 	else if (atom->u.remote_ref.option == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours,
 				       &num_theirs, NULL)) {
-			*s = xstrdup("gone");
+			*s = xstrdup(msgs.gone);
 		} else if (!num_ours && !num_theirs)
 			*s = "";
 		else if (!num_ours)
-			*s = xstrfmt("behind %d", num_theirs);
+			*s = xstrfmt(msgs.behind, num_theirs);
 		else if (!num_theirs)
-			*s = xstrfmt("ahead %d", num_ours);
+			*s = xstrfmt(msgs.ahead, num_ours);
 		else
-			*s = xstrfmt("ahead %d, behind %d",
+			*s = xstrfmt(msgs.ahead_behind,
 				     num_ours, num_theirs);
 		if (!atom->u.remote_ref.nobracket && *s[0]) {
 			const char *to_free = *s;
diff --git a/ref-filter.h b/ref-filter.h
index 630e7c2b9..44b36eded 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -113,5 +113,7 @@ struct ref_sorting *ref_default_sorting(void);
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
 /*  Get the current HEAD's description */
 char *get_head_description(void);
+/*  Set up translated strings in the output. */
+void setup_ref_filter_porcelain_msg(void);
 
 #endif /*  REF_FILTER_H  */
-- 
2.11.0

