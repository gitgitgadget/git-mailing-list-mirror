Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76181F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfEHLNq (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:13:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38635 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEHLNp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:13:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so10335349pfo.5
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bRKhZKJX3ffNxWFbuSrIAW/UVEPmGGIpkgTg75W4sRM=;
        b=QG5KOSxBmCRE3VLZ72HVdgu6k/mHv2mSOvYLrEnKffO0Aa4PHVujF8rlsoocfI1SYs
         Oj8ShHbhoCVcDXDv4A4qQnFrYfi5MsKCHgc03gaKk0hBEldwVam7UOOoRUcKo0tKbzxT
         OwYCZaQ6FhUvJdil/PkKHa1bAp7FbjV7c+j0J1WHuowPRmNHjEuUiZim5eVPzetr4RW0
         waKvxhPesf2Ayip0iDvmkUT7xtRZxh/UmgxBUdSrYFivpxjf8Gczpbs1TcKXVVDGTQze
         T+9WHTh/bCsWZoS2rpOXwizJWp2YnhyYfrG4U+zv6RPIaaQcHs57aVeVMnjlYBEigs9M
         p64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bRKhZKJX3ffNxWFbuSrIAW/UVEPmGGIpkgTg75W4sRM=;
        b=HQnASG3qPy/c83m7DL+9QNWwp6aio7FCVRLWEq7SJB9eUl7wowzkQrZCjkktaexOJL
         Eykk68cu6GriP34ZK07KgP3fF9BXbLiyJ00tUbMthB/Q93/OsBX7aAXvuJgFXkgA4ow0
         R8wmb+BprzYZihLG3BTXjxGs/ASuYAnsSWWSjZT29C7FQWC31iEGpXkvF6o3Bsh4H/71
         VtH9w0v+aiJJKy/iGBNqcT1iEbGz9laBhtyTyv5CI+OMJYOtOL4vsQDBfxCZ6EojkRgb
         MrT+ttSXkjfp7iY4s9tGtszucdpXXWPB/zaS+cDpkM3+dJ7jXRdVWp28TGICrPbfBF+4
         kSvw==
X-Gm-Message-State: APjAAAX4XhSvyPSmmPqpXdVxXLAYFNkAqG2dh1J/pT+khZtwao2Sj+/v
        5xEI1R0tZrm5CWh/sf7GVQ7+VRrS
X-Google-Smtp-Source: APXvYqzVxgvfwJRcYanx0chkEPuhwUOTVwMdImCbbSr88UgwBe0YHclT1KIKXPECkNUmFKzXEsTRFg==
X-Received: by 2002:a63:170a:: with SMTP id x10mr44718146pgl.355.1557314025040;
        Wed, 08 May 2019 04:13:45 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id f15sm19216928pgf.18.2019.05.08.04.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:13:44 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:13:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/19] rev-parseopt: convert --branches
Date:   Wed,  8 May 2019 18:12:35 +0700
Message-Id: <20190508111249.15262-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
In-Reply-To: <20190508111249.15262-1-pclouds@gmail.com>
References: <20190508111249.15262-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/revision.c b/revision.c
index 9a346577f6..7db1109b57 100644
--- a/revision.c
+++ b/revision.c
@@ -34,6 +34,10 @@
 	OPT_CALLBACK_F(s, l, revs, NULL, h, \
 		       PARSE_OPT_NONEG | PARSE_OPT_NOARG, cb)
 
+#define OPT_REV_OPTARG(s, l, a, h, cb) \
+	OPT_CALLBACK_F(s, l, revs, a, h, \
+		       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, cb)
+
 volatile show_early_output_fn_t show_early_output;
 
 static const char *term_bad;
@@ -2383,6 +2387,27 @@ static int rev_opt_all(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int rev_opt_branches(const struct option *opt,
+			    const char *arg, int unset)
+{
+	struct rev_info		*revs  = opt->value;
+	int			 flags = *revs->pseudo_flags;
+	struct ref_store	*refs  = revs->pseudo_refs;
+
+	BUG_ON_OPT_NEG(unset);
+	if (arg) {
+		struct all_refs_cb cb;
+
+		init_all_refs_cb(&cb, revs, flags);
+		for_each_glob_ref_in(handle_one_ref, arg, "refs/heads/", &cb);
+		clear_ref_exclusion(&revs->ref_excludes);
+	} else {
+		handle_refs(refs, revs, flags, refs_for_each_branch_ref);
+		clear_ref_exclusion(&revs->ref_excludes);
+	}
+	return 0;
+}
+
 static void make_pseudo_options(struct rev_info *revs)
 {
 	/*
@@ -2399,6 +2424,9 @@ static void make_pseudo_options(struct rev_info *revs)
 		OPT_REV_NOARG(0, "all",
 			      N_("include all refs in refs/ and HEAD"),
 			      rev_opt_all),
+		OPT_REV_OPTARG(0, "branches", N_("<pattern>"),
+			       N_("include all refs in refs/heads (optionally matches pattern)"),
+			       rev_opt_branches),
 		OPT_END()
 	};
 	ALLOC_ARRAY(revs->pseudo_options, ARRAY_SIZE(options));
@@ -2439,10 +2467,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	if (argc)
 		return argc;
 
-	if (!strcmp(arg, "--branches")) {
-		handle_refs(refs, revs, *flags, refs_for_each_branch_ref);
-		clear_ref_exclusion(&revs->ref_excludes);
-	} else if (!strcmp(arg, "--bisect")) {
+	if (!strcmp(arg, "--bisect")) {
 		read_bisect_terms(&term_bad, &term_good);
 		handle_refs(refs, revs, *flags, for_each_bad_bisect_ref);
 		handle_refs(refs, revs, *flags ^ (UNINTERESTING | BOTTOM),
@@ -2463,11 +2488,6 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
 		add_ref_exclusion(&revs->ref_excludes, optarg);
 		return argcount;
-	} else if (skip_prefix(arg, "--branches=", &optarg)) {
-		struct all_refs_cb cb;
-		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, optarg, "refs/heads/", &cb);
-		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (skip_prefix(arg, "--tags=", &optarg)) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-- 
2.21.0.1141.gd54ac2cb17

