Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 503E520357
	for <e@80x24.org>; Mon, 10 Jul 2017 22:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755064AbdGJWyk (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 18:54:40 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35501 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755055AbdGJWyh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 18:54:37 -0400
Received: by mail-pf0-f196.google.com with SMTP id q85so16305289pfq.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 15:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s3C79nNPEuYK6yZu6u6pSBLxcsU3Ishh6NZlyFv1dyg=;
        b=tyCYL9aRMID2IrGhVLZ3HS9ktECWcnAJb8A9sqdsswfUcHu5P6IoSSdco8HM985FQb
         5caTy59dQcFrjy1rhDRJiJx4s4/7i0Wbvo/JoevNCZLFj3UVO+ekuM7q6vLHM19n29jZ
         n8P+b/7reQZPwLsayJ5DqJwN/9Y8Ct+KNH9PyyZSAMEcAXIGguudhFgV5fe//loL1BnX
         GJhTFtb2jB6iFDFrujVKIm1Mu4qFRofFOFoQdXbxgbpIVVpmd7agCOvT3Rs4QCKEV7PA
         YJjr7Oq/KMO5PUZ6vwQpyGXcT2XJt0viFjeqKCy08y5fTfmFYLc6Nao0ssjDVT5oCAe9
         psTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s3C79nNPEuYK6yZu6u6pSBLxcsU3Ishh6NZlyFv1dyg=;
        b=iKt0xeJVRdHRSQutIPCBbleNaL3ffuQY2ZGIsFbE8boRigu9gGKT6qdtxnn3N6YFq6
         3Ye4Mj11Ceye2P29SCGm9XaTtheAP/sIbnA6wEQI4bx4n/fxkuGZ8dvLEfVIfDaO7VNA
         x44uEmhkChtkuyE9p6vPH7E776GQiOntv1HGiqTTaWMD5Rr31Jqu19ET9SnK7BdHUj5b
         mCQJKXaywIEPctdNaFrZaE8pzgA3GXtU2FCeKnKLRH9eKzJvP/expAWajfU8jMlQIY1o
         FPudTMNiBESedmg84B6TNofdK5HlNu2ArOZFhgRG88riqetzVrJHKdBIOd79ZHE/hndY
         Qp0Q==
X-Gm-Message-State: AIVw110h8QEnLJCNQqZRHW9eoKv7gVm66tJ0UIhp2aEdAUya4mWd+dIg
        btRA00FQokJPVnhI
X-Received: by 10.101.69.135 with SMTP id o7mr16562475pgq.242.1499727277104;
        Mon, 10 Jul 2017 15:54:37 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id o6sm20586774pgs.43.2017.07.10.15.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 15:54:36 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 7/8] diff: change scope of the function count_lines()
Date:   Tue, 11 Jul 2017 04:24:06 +0530
Message-Id: <20170710225407.29344-7-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170710225407.29344-1-pc44800@gmail.com>
References: <CAME+mvU_8-S4AhTtMYm1L6PK81v23wu4EuB+EnOgkDhi=jo9Rg@mail.gmail.com>
 <20170710225407.29344-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the scope of function count_lines for allowing the function
to be reused in other parts of the code as well.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 diff.c | 2 +-
 diff.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 00b4c8669..3240f8283 100644
--- a/diff.c
+++ b/diff.c
@@ -425,7 +425,7 @@ struct emit_callback {
 	struct strbuf *header;
 };
 
-static int count_lines(const char *data, int size)
+int count_lines(const char *data, int size)
 {
 	int count, ch, completely_empty = 1, nl_just_seen = 0;
 	count = 0;
diff --git a/diff.h b/diff.h
index 2d442e296..8522514e9 100644
--- a/diff.h
+++ b/diff.h
@@ -273,6 +273,7 @@ extern struct diff_filepair *diff_unmerge(struct diff_options *, const char *pat
 extern int parse_long_opt(const char *opt, const char **argv,
 			 const char **optarg);
 
+extern int count_lines(const char *data, int size);
 extern int git_diff_basic_config(const char *var, const char *value, void *cb);
 extern int git_diff_heuristic_config(const char *var, const char *value, void *cb);
 extern void init_diff_ui_defaults(void);
-- 
2.13.0

