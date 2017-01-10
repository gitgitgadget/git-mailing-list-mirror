Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 603F4205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 08:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760509AbdAJItQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 03:49:16 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34326 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760480AbdAJItP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 03:49:15 -0500
Received: by mail-pf0-f195.google.com with SMTP id y143so6872273pfb.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 00:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SMS1Jv97QYuONnesc3Kod+7gAQ3hrApqZn6NEVrFxLE=;
        b=BWxT8BeQ9m+WkBBk2JBh0OK39irjrtQ/IBqeMQjN7UsP5XGi356uol9gWYI8T7ZD1I
         fBbGHwWkgW0Yun3t2BHfovfIVLdYGYSIefzZF3KlIUks7CjKQl7U/2H6hN71OU4HD3mj
         BhrdfecK9NujgYj6a9N0jnd+Geir9tCwCJq1Z+rRrLwtc3xt4dizHPXVIw5KmwjQyf/z
         gniBPIRal/pyjs1zm+iQl507YT5O4pdgkh4aNrmw18isI3gd0BehhvTkSv5yz/Lj1d13
         k6kIIg03c7IdkYXGIoKS/xz1Yr8dgIVgJ5TKCkgpBh6J7WcOXd2SM+8c5bfWgU/HbsPx
         pCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SMS1Jv97QYuONnesc3Kod+7gAQ3hrApqZn6NEVrFxLE=;
        b=E8PSXcKuMRERUiYzkhn0wpa6uz0KPiXamoO/1QzN7sINHGTK+pdf1AYPXwYQ+aThEb
         vFEHbv1DqAFcbHby0nrj93wVPaNA/gCiArLnYVlFf2ugsPM0BjYZLMMh7Vpp3EhRqLJ5
         sPLQh3NZwrHUrIQ4oMffcs1Zm7Qi0s0x+fc/E7uAGQuRwzs9IE5i70EigsyfZLT8d2Ln
         CZygEy1Q0QTOpUQ+oND3kOYFSqV/gubwtno9Q33dtWe9pdJMzwQSaFdhh9ClWtY4riPh
         K4nGya8JDtbA9HLOHpf6nLA7ufPyNav3kCWdqusSqTDnhcgV4UYbZ3wQTzF8fP+M/tGO
         h0gg==
X-Gm-Message-State: AIkVDXKNJXZ+Jzuz7juCn7wuw1KjGEWNSSy4I/4MQTEoKp1UGFut90FtSdoxRlLS+tkcvA==
X-Received: by 10.98.70.194 with SMTP id o63mr2517236pfi.49.1484038154615;
        Tue, 10 Jan 2017 00:49:14 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id m12sm3411983pfg.92.2017.01.10.00.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 00:49:14 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        Karthik Nayak <karthik.188@gmail.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v10 10/20] ref-filter: introduce refname_atom_parser_internal()
Date:   Tue, 10 Jan 2017 14:19:43 +0530
Message-Id: <20170110084953.15890-11-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170110084953.15890-1-Karthik.188@gmail.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Since there are multiple atoms which print refs ('%(refname)',
'%(symref)', '%(push)', '%(upstream)'), it makes sense to have a common
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
index e98ef4bb6..c1ebc406c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -32,6 +32,11 @@ struct if_then_else {
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
@@ -64,6 +69,7 @@ static struct used_atom {
 			enum { O_FULL, O_LENGTH, O_SHORT } option;
 			unsigned int length;
 		} objectname;
+		struct refname_atom refname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -77,6 +83,21 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
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
+	} else
+		die(_("unrecognized %%(%s) argument: %s"), name, arg);
+}
+
 static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 {
 	struct string_list params = STRING_LIST_INIT_DUP;
-- 
2.11.0

