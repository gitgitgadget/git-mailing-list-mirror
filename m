Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70542022A
	for <e@80x24.org>; Tue,  8 Nov 2016 20:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933282AbcKHUMr (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 15:12:47 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33591 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933193AbcKHUMn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 15:12:43 -0500
Received: by mail-pf0-f195.google.com with SMTP id 144so12331756pfv.0
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 12:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X51cf7sDphgYHw55IgvehDXRiTKpo5s28LD53gUh1is=;
        b=Viag/8S/Krz6CipKbKfzvilRM7Oomj33r5zhxgJivhP19lS4M6u5LDZF8IOPB6w/co
         ji0rOVyouEnKleNTPDoDKFzhOeL+IlKBWGO7sLPEhlQ3YIUVrQriEFoxfEttebeIawN9
         UG69LtHULp8MI3+b57k+2sUxN/up1TRlsl4LxbkB9sAsPFsG9OSLqK+lnziRZ0c9DGse
         27zcgrC4PYHyC5qLIqNUGMkQZpWYDoyMuzdWIK6eLTFUtFn5sPMSr6IQwkK+iOFD+CJE
         gHk/nwmEesqvMe3Ls/3jtcH/ZKyEoJkFp4/S6gRh2FNx5+xcjOdxwKLNEgY7dmV8VEY+
         9Mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X51cf7sDphgYHw55IgvehDXRiTKpo5s28LD53gUh1is=;
        b=DjnP7kcKLcE6Tcc+gN8p7EI9vzlasEaPLULAGxOKrut3VQmIoWaKoXmWZ3JhVNs1DA
         ocMgkeaNbuKkvIjq77jhLZVuF5g/0GjVVFqkhjw/SLBP75ScjGwaXvMVF0E8HijizDcY
         mmOyBjRSzapz7vGkBNzM1IcvDFrCkQuN/1FhYlA1NoNmI4WOYPAez6SB1aMMKOBh2SX9
         rJCWWmy03vRZXp3AjRqd3r84dFfGhser42BiFAKYE1KvKgjR/0VaHySfqPxWTF8EKRjQ
         y79f8RzcrWqCGQOknWY1qp6ZBTfYUD5YEMsshO55iUQy+bna5nyF1CSCLY0/0YNn8Bbc
         WzpA==
X-Gm-Message-State: ABUngvdiiXUEYnyEa8N65oW6OoI306/yjc8W7A7Cu0mTiCzuFaqt5c8mha0HEOT84hT12g==
X-Received: by 10.98.50.5 with SMTP id y5mr26189624pfy.141.1478635962947;
        Tue, 08 Nov 2016 12:12:42 -0800 (PST)
Received: from localhost.localdomain ([27.5.65.216])
        by smtp.gmail.com with ESMTPSA id hv3sm50239466pad.30.2016.11.08.12.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2016 12:12:42 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 14/17] ref-filter: allow porcelain to translate messages in the output
Date:   Wed,  9 Nov 2016 01:42:08 +0530
Message-Id: <20161108201211.25213-15-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161108201211.25213-1-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Introduce setup_ref_filter_porcelain_msg() so that the messages used in
the atom %(upstream:track) can be translated if needed. This is needed
as we port branch.c to use ref-filter's printing API's.

Written-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 28 ++++++++++++++++++++++++----
 ref-filter.h |  2 ++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index b47b900..944671a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -15,6 +15,26 @@
 #include "version.h"
 #include "wt-status.h"
 
+static struct ref_msg {
+	const char *gone;
+	const char *ahead;
+	const char *behind;
+	const char *ahead_behind;
+} msgs = {
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
 
 struct align {
@@ -1130,15 +1150,15 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
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
index 0014b92..da17145 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -111,5 +111,7 @@ struct ref_sorting *ref_default_sorting(void);
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
 /*  Get the current HEAD's description */
 char *get_head_description(void);
+/*  Set up translated strings in the output. */
+void setup_ref_filter_porcelain_msg(void);
 
 #endif /*  REF_FILTER_H  */
-- 
2.10.2

