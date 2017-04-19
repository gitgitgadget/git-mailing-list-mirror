Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31271FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 11:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762510AbdDSLCn (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 07:02:43 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35349 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762570AbdDSLCm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 07:02:42 -0400
Received: by mail-pg0-f66.google.com with SMTP id g2so3587819pge.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 04:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S+D6hT6jHQLXEo6IdBFGgBEtQrS+6Vmop+JeGpFmcu4=;
        b=J0F5BizdaotWfqcpYqt7/mZN1OlHF9AY3LLDLHkkyPl9LMJ+UCwSHFMsWNnYUFKh4A
         QHeRTI+cMgnjckPLoPpMH8Jg6Rr8cZ3VHm2QvyQStGf6lSwDjFgkdhEFLIFVDRZ08kRt
         G2Gjh3nCioENowOsHsgUKX2SFwzv4vu6m8mEuXDSjhI+HN5mD37hcpD9zMM8hU0WV3pC
         uyOpM8Qt3/zAR1PxsU9vmoNX9suuS3gllKy+xem23mSdlyVT708wu2lNyCgwkqhhHplD
         LuZFXMJeelx+Vv7Lpix4RPuCED5Kxd1ndZAf/xKU6ngIbdjaySscrSk9sryiCylwJ7KC
         8fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S+D6hT6jHQLXEo6IdBFGgBEtQrS+6Vmop+JeGpFmcu4=;
        b=q54zRNpSuSnDr8OHSEbXiKT72Ia0Tn1ukgsnxPEshku90Oyydym5JT5PkJgFXOR5Qq
         6l8OHxPpq3yxypmy4QIF6nSpfAc+7317KeyechUm/m3MzfPDSogNw+kmGgRN/6c2plma
         PQHB9QwTzjB9/15/csVr/Mn6j45dhtM9laplWQC51ZrJbu5pi2jOPI/U38zed7AzU01M
         oZUM8yMCW8krksP3a4JID89YNUbCuihphxjbPy5VsrpX7bSgJSppidWJwjYcttM6ncY7
         /RDEsikavNbQxjdDKTpXngClfFficl8/uQ/fbHginoxHq6TvZvOPSCk0/iYyKQDEzTxo
         5OAg==
X-Gm-Message-State: AN3rC/5fJIuTQ1XTSRGo2haQ4dQ2i4A7TuRFfCNetUYWJ3cG9lh0kZgM
        z6qusAgnO63Bdw==
X-Received: by 10.84.192.37 with SMTP id b34mr3304142pld.30.1492599761275;
        Wed, 19 Apr 2017 04:02:41 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id c28sm4004737pfj.19.2017.04.19.04.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 04:02:40 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Apr 2017 18:02:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 07/12] revision.c: use refs_for_each*() instead of for_each_*_submodule()
Date:   Wed, 19 Apr 2017 18:01:40 +0700
Message-Id: <20170419110145.5086-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170419110145.5086-1-pclouds@gmail.com>
References: <20170419110145.5086-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/revision.c b/revision.c
index 295d4f8205..c329070c89 100644
--- a/revision.c
+++ b/revision.c
@@ -1189,12 +1189,19 @@ void add_ref_exclusion(struct string_list **ref_excludes_p, const char *exclude)
 	string_list_append(*ref_excludes_p, exclude);
 }
 
-static void handle_refs(const char *submodule, struct rev_info *revs, unsigned flags,
-		int (*for_each)(const char *, each_ref_fn, void *))
+static void handle_refs(struct ref_store *refs,
+			struct rev_info *revs, unsigned flags,
+			int (*for_each)(struct ref_store *, each_ref_fn, void *))
 {
 	struct all_refs_cb cb;
+
+	if (!refs) {
+		/* this could happen with uninitialized submodules */
+		return;
+	}
+
 	init_all_refs_cb(&cb, revs, flags);
-	for_each(submodule, handle_one_ref, &cb);
+	for_each(refs, handle_one_ref, &cb);
 }
 
 static void handle_one_reflog_commit(struct object_id *oid, void *cb_data)
@@ -2067,23 +2074,25 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 	ctx->argc -= n;
 }
 
-static int for_each_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data, const char *term) {
+static int for_each_bisect_ref(struct ref_store *refs, each_ref_fn fn,
+			       void *cb_data, const char *term)
+{
 	struct strbuf bisect_refs = STRBUF_INIT;
 	int status;
 	strbuf_addf(&bisect_refs, "refs/bisect/%s", term);
-	status = for_each_ref_in_submodule(submodule, bisect_refs.buf, fn, cb_data);
+	status = refs_for_each_ref_in(refs, bisect_refs.buf, fn, cb_data);
 	strbuf_release(&bisect_refs);
 	return status;
 }
 
-static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
+static int for_each_bad_bisect_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return for_each_bisect_ref(submodule, fn, cb_data, term_bad);
+	return for_each_bisect_ref(refs, fn, cb_data, term_bad);
 }
 
-static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
+static int for_each_good_bisect_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return for_each_bisect_ref(submodule, fn, cb_data, term_good);
+	return for_each_bisect_ref(refs, fn, cb_data, term_good);
 }
 
 static int handle_revision_pseudo_opt(const char *submodule,
@@ -2092,8 +2101,14 @@ static int handle_revision_pseudo_opt(const char *submodule,
 {
 	const char *arg = argv[0];
 	const char *optarg;
+	struct ref_store *refs;
 	int argcount;
 
+	if (submodule) {
+		refs = get_submodule_ref_store(submodule);
+	} else
+		refs = get_main_ref_store();
+
 	/*
 	 * NOTE!
 	 *
@@ -2105,22 +2120,23 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	 * register it in the list at the top of handle_revision_opt.
 	 */
 	if (!strcmp(arg, "--all")) {
-		handle_refs(submodule, revs, *flags, for_each_ref_submodule);
-		handle_refs(submodule, revs, *flags, head_ref_submodule);
+		handle_refs(refs, revs, *flags, refs_for_each_ref);
+		handle_refs(refs, revs, *flags, refs_head_ref);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--branches")) {
-		handle_refs(submodule, revs, *flags, for_each_branch_ref_submodule);
+		handle_refs(refs, revs, *flags, refs_for_each_branch_ref);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--bisect")) {
 		read_bisect_terms(&term_bad, &term_good);
-		handle_refs(submodule, revs, *flags, for_each_bad_bisect_ref);
-		handle_refs(submodule, revs, *flags ^ (UNINTERESTING | BOTTOM), for_each_good_bisect_ref);
+		handle_refs(refs, revs, *flags, for_each_bad_bisect_ref);
+		handle_refs(refs, revs, *flags ^ (UNINTERESTING | BOTTOM),
+			    for_each_good_bisect_ref);
 		revs->bisect = 1;
 	} else if (!strcmp(arg, "--tags")) {
-		handle_refs(submodule, revs, *flags, for_each_tag_ref_submodule);
+		handle_refs(refs, revs, *flags, refs_for_each_tag_ref);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--remotes")) {
-		handle_refs(submodule, revs, *flags, for_each_remote_ref_submodule);
+		handle_refs(refs, revs, *flags, refs_for_each_remote_ref);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
 		struct all_refs_cb cb;
-- 
2.11.0.157.gd943d85

