Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3A592022A
	for <e@80x24.org>; Tue,  8 Nov 2016 20:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933145AbcKHUMh (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 15:12:37 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33506 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933193AbcKHUMd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 15:12:33 -0500
Received: by mail-pf0-f194.google.com with SMTP id 144so12331349pfv.0
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 12:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+EPfWJiSlR7Gov2GSbk1MLIgDNAC/iGYDvTmL32/qHU=;
        b=TSjxVgvSOa08Kzof3kXZzY1J/BDsS+L8zxZp9P0BjmWc5oAeHJnNGplSG/Y0Ysdxns
         BCLBJISpTGLFcgi/rECcbA47DICimkacT7zCA+ORtUWAbvT0c9rAsHKbI3LPYj0dlFZ0
         x01/gFfUkIkkA0WuWOBv8PtpEQNtYdqMMfooFBfhIiJCR8hwRgbome2CVV0T0HMhjcS6
         ef6SyictBp8TO9f8zj9hcrtqE4UY+fhEgoTyK0qV2KdEVZC1vAYGzL7+/5Noj4Xmkrga
         qx7xb8cwrLH8yQdu/wzIqEJHEGYK8wSa04Aw4UzNAJUThJX0AFXrL5gg69OBqOqMN2cQ
         /mFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+EPfWJiSlR7Gov2GSbk1MLIgDNAC/iGYDvTmL32/qHU=;
        b=aovnuHbbU7aiujFGY5D5x/bw89CFdLuE6xM9BWDgoNJnGpAlDpd8uq005/pq/gUD7o
         pLBQWlp7eGRqd/wq9+ewbtuKT+gdcOwTMYQDyZLstLzORs2y75S8jEkwQAUzajFe5mMD
         84jinnqHoeDWXZj02DFG7DFjQ6FphlAoPoab3zK5Uo/VbfvwAbSBi2fpb/3PMsOTbx9K
         zVkdgPWBRT1+fluzN00NHKa5R7Bj6QJ4fhNDJvTSA6U7/fpLEKcg6an8I0e1f85WIE7W
         mS0O0SQglSf62N8JXOorG2hDxPjn2A8YwzeFym21bm1qdBFcabQyQNAe4mQShOp0VzSS
         9adA==
X-Gm-Message-State: ABUngvfC5KWCLmDFaKwnX8ckXrZOFVtIukBgZ43Y8t0/oPwsB3zSOWOUP7X9P6Zx9kohzQ==
X-Received: by 10.98.51.134 with SMTP id z128mr26659853pfz.163.1478635952584;
        Tue, 08 Nov 2016 12:12:32 -0800 (PST)
Received: from localhost.localdomain ([27.5.65.216])
        by smtp.gmail.com with ESMTPSA id hv3sm50239466pad.30.2016.11.08.12.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2016 12:12:32 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, Karthik Nayak <karthik.188@gmail.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v7 10/17] ref-filter: introduce refname_atom_parser_internal()
Date:   Wed,  9 Nov 2016 01:42:04 +0530
Message-Id: <20161108201211.25213-11-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161108201211.25213-1-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Since there are multiple atoms which print refs ('%(refname)',
'%(symref)', '%(push)', '%upstream'), it makes sense to have a common
ground for parsing them. This would allow us to share implementations of
the atom modifiers between these atoms.

Introduce refname_atom_parser_internal() to act as a common parsing
function for ref printing atoms. This would eventually be used to
introduce refname_atom_parser() and symref_atom_parser() and also be
internally used in remote_ref_atom_parser().

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 5666814..aad537d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -30,6 +30,11 @@ struct if_then_else {
 		condition_satisfied : 1;
 };
 
+struct refname_atom {
+	enum { R_NORMAL, R_SHORT, R_STRIP } option;
+	unsigned int strip;
+};
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -62,6 +67,7 @@ static struct used_atom {
 			enum { O_FULL, O_LENGTH, O_SHORT } option;
 			unsigned int length;
 		} objectname;
+		struct refname_atom refname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -75,6 +81,21 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
 		die(_("unrecognized color: %%(color:%s)"), color_value);
 }
 
+static void refname_atom_parser_internal(struct refname_atom *atom,
+					 const char *arg, const char *name)
+{
+	if (!arg)
+		atom->option = R_NORMAL;
+	else if (!strcmp(arg, "short"))
+		atom->option = R_SHORT;
+	else if (skip_prefix(arg, "strip=", &arg)) {
+		atom->option = R_STRIP;
+		if (strtoul_ui(arg, 10, &atom->strip) || atom->strip <= 0)
+			die(_("positive value expected refname:strip=%s"), arg);
+	} 	else
+		die(_("unrecognized %%(%s) argument: %s"), name, arg);
+}
+
 static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 {
 	struct string_list params = STRING_LIST_INIT_DUP;
-- 
2.10.2

