Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF78A200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932883AbcL0QYF (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:24:05 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33692 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755641AbcL0QX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:56 -0500
Received: by mail-pf0-f196.google.com with SMTP id 127so8393714pfg.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=97q6Q53stFZwlRoOk9PDyhOVgIJDVLUmogyNA2TI4aA=;
        b=r87iJu8uv44YrmkYabekpmoYpOOH+w6WrpVo91aepyxluSKgdD8I309PxuYEBD0rfE
         t86uVj2GLWlYF6idpHBYTMGC0CEYiRJ/MjqkBzyq3o2EFSBzJXmtUDKNOTCT4ZJ+uFXJ
         m4qiynEMinGRGVUu+/AzTLQNbwPe3hIKenQHNTyxZVdhlGC1MpzU9KKZWH7iAWCTUazU
         xPjEQGC4ytBCZwt0ki/y4kAmKhu3XF5bUiWZ+MljuFevUkzfMqnPYQkXbUOwLAd42EPb
         r8e+b+6MAkPr3ktQxQgDW4P5zNcGojaSurthANh/Y04jskSwuSr2tVXk9rXCy29X1Juz
         +Vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=97q6Q53stFZwlRoOk9PDyhOVgIJDVLUmogyNA2TI4aA=;
        b=ihtcOZ46GDmGJKxKbJlKSk8a7Dg3cjxAK5siqa50GSDW6bB7baRPk9H+kIGM1ykfUl
         RsqF1zpvG9FUfUp6y4U79em8fYIQNrcvL/m0J8Lf58GqVftPeRbqlh7/cY24kvUzxy1k
         juKXINCXEFV2ZodoM22cjZU3F55gviq6SX0L3qq0fgpI7psSX/ypqHM+RnOo+EHnt5wN
         jQwcEHewewdtdYe34y5sE/p0nz19HdKOVUsmbzgIElkqHjEyc5LWFWt8lubi6JNa7HYQ
         Aw0B1ab9ch5KV6lSYnVclTkWK7neebEr2x+a16+eUcxNJFsM0DSYTw9lVbLtmXZY+1xq
         G1RQ==
X-Gm-Message-State: AIkVDXK2Ihfqs9E88MDhZxWIysrm/sTKMZwaFpoUkDTKTrw621q3rN1BLXpMLM+lqHEvvw==
X-Received: by 10.98.20.131 with SMTP id 125mr30224644pfu.51.1482855835023;
        Tue, 27 Dec 2016 08:23:55 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:54 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 17/20] ref-filter: allow porcelain to translate messages in the output
Date:   Tue, 27 Dec 2016 21:53:54 +0530
Message-Id: <20161227162357.28212-18-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
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
index dd7e751..e478ec6 100644
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
index 630e7c2..44b36ed 100644
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
2.10.2

