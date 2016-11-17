Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF0121FE4E
	for <e@80x24.org>; Thu, 17 Nov 2016 10:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbcKQKV1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 05:21:27 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35849 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932119AbcKQKV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 05:21:26 -0500
Received: by mail-pf0-f195.google.com with SMTP id c4so8922604pfb.3
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 02:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iGv6xrFSu5Stj39OC23SbMsWBiceq4T/9LG54YSDZRQ=;
        b=ftBBnhJnDp4KPxCdF6kM9pN630LmPUAuqybklhnlrJLUdt71OpKYNR5w0oCeiqCf+l
         zFGK8UdBjWxybvPbnd3x3kT4Hl3p2JCwjuw/AwsyR9uA8V9KdVy0euovdkf++53NukEi
         AXQc5a5q/vsxr6fjMGX3GWBDR2eISWZrTTuevAQ4yHDA3ZymwQdzMRgGMmEl/ME8uD1G
         wHd/WtiK20JwxjGmbzHYhiLOjl4VZEM2xscdZc430QF/Vhimz0B9iXCaK+RhoEy1kCMM
         61r1W9MRe0u9HSxB8LS2WElYBd3JQ53LxQhMulM8D0K6ejHMcbWm6rVbaoChuebdfHYq
         FTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iGv6xrFSu5Stj39OC23SbMsWBiceq4T/9LG54YSDZRQ=;
        b=IqsmBAs+KHDjQS+fOc86I0t0otUMookUI6Tsh8zgYoU/WRteUyfbnDTbjhzHmOO1sr
         tLkN/t8iwXZEAKQpzPXfdMNjUcZBjKTMo1a8Xd/7prlJKfdfPfzi1Akq6QPUPURy3mCB
         WQK+6IYxVS5Tmhr1QGQbrmxMF+dAuxNmMW6ai2IIuP0VCo1rETTMiW+jNJvU+JFf0yy9
         517itJtvGfi4LCBtFaRFR4ytCMP4sBx8iXTHG4Arw+gf5q+ZyU3M6Ram3FCsSojTBPt+
         mldBiyDBr+CYhXnLUbC+MQpZMgr3gzVT8Y01yaLV13uaV0xR3OiRkngNxnj09LgAttaw
         3DWg==
X-Gm-Message-State: ABUngvcxJQeoxFRgCvOHiSFz6ehteCd4N54GNh17AsX2kMg2DMAccd63pQuJ1MAqAt0WmQ==
X-Received: by 10.98.133.9 with SMTP id u9mr3666472pfd.137.1479378084583;
        Thu, 17 Nov 2016 02:21:24 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id 16sm5709732pfk.54.2016.11.17.02.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Nov 2016 02:21:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Nov 2016 17:21:17 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     karthik.188@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC] ref-filter: support sorting case-insensitively
Date:   Thu, 17 Nov 2016 17:21:14 +0700
Message-Id: <20161117102114.16649-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to version:refname sorting refs by versions, icase:refname
will sort by refnames are usually, but strcasecmp will be used instead
of strcmp. This may be helpful sometimes when people name their
branches <group>-<details> but somebody names it <group>-, some goes
with <Group>-, or even <GROUP>-

Syntax is a big problem. This patch does not support
icase:version:refname or version:icase:refname, for example. If
version sorting learns about this thing, I think I prefer
iversion:refname...

Or perhaps we can. I'm losing touch with for-each-ref "pretty"
formats, I'm not quite sure what's the guideline here.

Another option is just use a symbol, like '-' or '*' to mark
case-insensitivity. But that does not look very descriptive. I don't
see any symbol suggesting this case stuff.

What do you think?

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-for-each-ref.txt | 3 ++-
 ref-filter.c                       | 8 ++++++--
 ref-filter.h                       | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f57e69bc83..e41005cf0e 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -171,7 +171,8 @@ For sorting purposes, fields with numeric values sort in numeric order
 All other fields are used to sort in their byte-value order.
 
 There is also an option to sort by versions, this can be done by using
-the fieldname `version:refname` or its alias `v:refname`.
+the fieldname `version:refname` or its alias `v:refname`. Prefixing
+"icase:" (e.g. `icase:refname`) makes sorting case-insensitive.
 
 In any case, a field name that refers to a field inapplicable to
 the object referred by the ref does not cause an error.  It
diff --git a/ref-filter.c b/ref-filter.c
index d4c2931f3a..fd63b9c710 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1542,12 +1542,12 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	if (s->version)
 		cmp = versioncmp(va->s, vb->s);
 	else if (cmp_type == FIELD_STR)
-		cmp = strcmp(va->s, vb->s);
+		cmp = s->strcmp(va->s, vb->s);
 	else {
 		if (va->ul < vb->ul)
 			cmp = -1;
 		else if (va->ul == vb->ul)
-			cmp = strcmp(a->refname, b->refname);
+			cmp = s->strcmp(a->refname, b->refname);
 		else
 			cmp = 1;
 	}
@@ -1646,6 +1646,7 @@ struct ref_sorting *ref_default_sorting(void)
 
 	sorting->next = NULL;
 	sorting->atom = parse_ref_filter_atom(cstr_name, cstr_name + strlen(cstr_name));
+	sorting->strcmp = strcmp;
 	return sorting;
 }
 
@@ -1660,6 +1661,7 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
 
 	s = xcalloc(1, sizeof(*s));
 	s->next = *sorting_tail;
+	s->strcmp = strcmp;
 	*sorting_tail = s;
 
 	if (*arg == '-') {
@@ -1669,6 +1671,8 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
 	if (skip_prefix(arg, "version:", &arg) ||
 	    skip_prefix(arg, "v:", &arg))
 		s->version = 1;
+	else if (skip_prefix(arg, "icase:", &arg))
+		s->strcmp = strcasecmp;
 	len = strlen(arg);
 	s->atom = parse_ref_filter_atom(arg, arg+len);
 	return 0;
diff --git a/ref-filter.h b/ref-filter.h
index 14d435e2cc..ea2db565f1 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -30,6 +30,7 @@ struct ref_sorting {
 	int atom; /* index into used_atom array (internal) */
 	unsigned reverse : 1,
 		version : 1;
+	int (*strcmp)(const char *, const char *);
 };
 
 struct ref_array_item {
-- 
2.11.0.rc0.161.g80d5b92

