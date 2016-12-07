Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6B7B20259
	for <e@80x24.org>; Wed,  7 Dec 2016 15:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbcLGPhD (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 10:37:03 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36504 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752635AbcLGPgz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 10:36:55 -0500
Received: by mail-pf0-f196.google.com with SMTP id c4so20788104pfb.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RyUYcEakC1cSW/LJLUc+mcog8SRwDuUtTD6w8XOAY10=;
        b=YAjNYtNEjlJraWzEuyhtmbZSvs5L/UfO6C+g9rksjyVJiZoXOge+E5SGRC71uR2Ep+
         uxnySLVMlJaZysWpmLocM3D9iY+98ofSNFiSSFxZArPfbWL8xq3TG9JJicwKQN85Qoz1
         TKq6k9c9tS6Y4/Feuu/5qmWFDGYnE4cDQ2Qpd1G2+H5N0eXGrRx0WsS+Tmd4pTMRoe0x
         c9Oc9kt29RtfHPkTAdwMXXmYdoTOXz9Wikzic5L02rRD1SCVhjcJ6U+inV4DFWaNUW+w
         nRf/qp/9k+T6ntZESyuoqUT93M5chrrjFR1xhjoEs2s/YTJ40j424z+81328lOM3gbUD
         5IXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RyUYcEakC1cSW/LJLUc+mcog8SRwDuUtTD6w8XOAY10=;
        b=d7aKaLO7YIGyUDSyY8YSAuJeef9x1WX8VAk3cfzxMxZS4hkJn6Rhl/RDFojC510M2D
         59KenTFSFadzs0seW4obGCHeq2et6pzJwVi87FEDXIDe/qZ95TJtj+Ag54v07ZyDtxhk
         3EFhZ/81pkf6op2HVlykYFnTNwCcoSYSBQheqfJ4383iliZWVp/8nDp3AiPcLXH4BqVy
         pE+38lObZoeL71p0CFDMaMOAGQnvTic1j8NwVQigJyLryE34IPgNrvjrqwiO8vbObBk2
         ffs9O7gvuva8t8TKBjbsSAvqDxn0otJZWsaClyyvoueRl+xV0DwrMKPHg7Dyp6qFiCvV
         Z4Sw==
X-Gm-Message-State: AKaTC00gEksF27Sbbx3rUDPiGMGAcBSXRW+f8XjpafV+t1iEf8n9TvNquCqLV74kU49Frg==
X-Received: by 10.98.54.68 with SMTP id d65mr68958260pfa.61.1481125014676;
        Wed, 07 Dec 2016 07:36:54 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([122.15.255.69])
        by smtp.gmail.com with ESMTPSA id l7sm43584459pfg.35.2016.12.07.07.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:36:54 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com, jnareb@gmail.com,
        Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 16/19] ref-filter: allow porcelain to translate messages in the output
Date:   Wed,  7 Dec 2016 21:06:24 +0530
Message-Id: <20161207153627.1468-17-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161207153627.1468-1-Karthik.188@gmail.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
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
index 9fce5bb..a68ed7b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -15,6 +15,27 @@
 #include "version.h"
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
 
@@ -1161,15 +1182,15 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
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

