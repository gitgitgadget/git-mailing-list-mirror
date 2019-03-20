Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8524D20248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfCTLsr (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:48:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44658 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfCTLsr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:48:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so1613508pgj.11
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8MnQAgwz1pETAj1BbOdXqyA1Mttd/Yiu1lyBHoMlD6Q=;
        b=R66oilwN/7wnb5npzhOXVZ62hmO63/7CX1UeOOv88gbAJqzVc5hI9KbKN8IAcsUkjo
         /kAEMIKsGTJH91FZ2itUke4zotWSfqh2FE7u+TFX1C1/rjCGNrJs8DFNt7LHPeedrDXk
         4TP7bj0LKrIXEQ/34Z8ISTtkWpcOxXnBiTF0L5VE6cP1cFlqwUwdDZ94FW6j5RxbR6SC
         KNYdc+Ou7m79KTrsHzE2mkxv9XNZXCNfmkUPXmYl+DmbO1S2iu0cr8NJdmZiJb2xkrFq
         Aiaaw5fQcqwwQu0f1LqTsPzeo6GLJPFcGje8ZmIQIQxw3yVH1488iVZLlFHxOuAXAAoJ
         p5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8MnQAgwz1pETAj1BbOdXqyA1Mttd/Yiu1lyBHoMlD6Q=;
        b=PPJ/I3N4ClvvyMqa8leDDlMOvwigRTvhkVJPBOgkTHe6ij2679S7Hlgw8Vz2cD/CAT
         1+h064TSw3j3UdEXiHpzPXxXWWCb7OG003KoFikaQPwVrrcqfTdnlurF8FvoxTLzm2ob
         123gCOdH+60uxXklkr5K5r1FTGWz7i02xUv3BPZJtvoc/zJRmMpsbIAwVhdibnGdn9yJ
         pu8qN7ISMCoLklPbPApZcVDOteUG3n9yrwoB+xX1U/5oo8drZsQTfRlbDFBh35R4WPUU
         pg70gbM+ieA4WuUyt0WL+WKC6c8Z4cm0jwnjVpdJ5fT8PbeTq2bt211eIdffLOrrH019
         Hpqw==
X-Gm-Message-State: APjAAAV2DgMC5MXZBW6ed0VZ9+jzQe4neLUUVKZrZ5EIPgBM5agcbWKp
        GXK1ERDkaudo5gfoRjMu6KOor1P5
X-Google-Smtp-Source: APXvYqyj9Jppj2pxQT7Z1mQPV9g35I9H0LJ31+64vVyyR4I5A3IkrZ0mmW8ZqRU88tuN3ucQCqYZAA==
X-Received: by 2002:aa7:9090:: with SMTP id i16mr7464523pfa.85.1553082526691;
        Wed, 20 Mar 2019 04:48:46 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id i21sm2600842pfa.14.2019.03.20.04.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:48:45 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:48:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 20/20] am: avoid diff_opt_parse()
Date:   Wed, 20 Mar 2019 18:47:03 +0700
Message-Id: <20190320114703.18659-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190320114703.18659-1-pclouds@gmail.com>
References: <20190320114703.18659-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff_opt_parse() is a heavy hammer to just set diff filter. But it's
the only way because of the diff_status_letters[] mapping. Add a new
API to set diff filter and use it in git-am. diff_opt_parse()'s only
remaining call site in revision.c will be gone soon and having it here
just because of git-am does not make sense.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/am.c | 4 ++--
 diff.c       | 6 ++++++
 diff.h       | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 95370313b6..0cbf285459 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1515,11 +1515,11 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		 * review them with extra care to spot mismerges.
 		 */
 		struct rev_info rev_info;
-		const char *diff_filter_str = "--diff-filter=AM";
 
 		repo_init_revisions(the_repository, &rev_info, NULL);
 		rev_info.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
-		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1, rev_info.prefix);
+		rev_info.diffopt.filter |= diff_filter_bit('A');
+		rev_info.diffopt.filter |= diff_filter_bit('M');
 		add_pending_oid(&rev_info, "HEAD", &our_tree, 0);
 		diff_setup_done(&rev_info.diffopt);
 		run_diff_index(&rev_info, 1);
diff --git a/diff.c b/diff.c
index 6ce59d0621..b94befd494 100644
--- a/diff.c
+++ b/diff.c
@@ -4692,6 +4692,12 @@ static unsigned filter_bit_tst(char status, const struct diff_options *opt)
 	return opt->filter & filter_bit[(int) status];
 }
 
+unsigned diff_filter_bit(char status)
+{
+	prepare_filter_bits();
+	return filter_bit[(int) status];
+}
+
 static int diff_opt_diff_filter(const struct option *option,
 				const char *optarg, int unset)
 {
diff --git a/diff.h b/diff.h
index 03c6afda22..f88482705c 100644
--- a/diff.h
+++ b/diff.h
@@ -233,6 +233,8 @@ struct diff_options {
 	struct option *parseopts;
 };
 
+unsigned diff_filter_bit(char status);
+
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
 void diff_emit_submodule_add(struct diff_options *o, const char *line);
 void diff_emit_submodule_untracked(struct diff_options *o, const char *path);
-- 
2.21.0.548.gd3c7d92dc2

