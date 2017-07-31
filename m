Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 807751F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbdGaU5K (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:57:10 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37096 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751740AbdGaU5F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:57:05 -0400
Received: by mail-pf0-f195.google.com with SMTP id 72so6976678pfl.4
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 13:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yNWbM+OGFMn+OzDqkzQE8PE/rNaVr3iHin5xYCipqAQ=;
        b=isuyB1C6Gaac2JuoA5aOuFjP1O8DjWpQ7S07hqRdlYO1Sqhjlq289CCOHepvLRbt8h
         hWH+etwhQ/UZHgvow5VCUCV25aNRdFfZ4e3zRyQQgJHZ1sVRryq21oG77S8yXqzegp6n
         dA6WHVtE10b5xLW1vD4RJa2JGkJ8UR50IeOTNenYgErDKIU1stECJXBn8MzfgL+snVjV
         WNMjyFUu31UwW75PpcaTK4t/lcp51fRyh0wx/2K7oAbwF2J6fQBP33dMaFOgqPDumRad
         KASQ8KwNpTS75ouSJpb+BV1piPLM2hNCAGb5gzTpJlvqF+0bOFujUV1Whqc/QPKUNxPD
         Jvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yNWbM+OGFMn+OzDqkzQE8PE/rNaVr3iHin5xYCipqAQ=;
        b=fS8sVed4CYHoFdgZpr2Dmfrl7avqAiJX6wSPuzopM8fgnn7ES3jrENW3u/4EBLEO6y
         CqQsRR0Y3wuk4nF7NgYI9N2j5VR+UVpMkz+CPJAXsdJPw0GO4ZqslXJHyRjJaXwNY9Xf
         3Rw8MU7ZPUnTImsCCPwAV/5N8mXXAyaX/ArbdJcBlRFUz9tgpC9g++yv/fp8GSI2zln3
         n/AhlFWm9/6BjfG618kFh7qiMiDSvYYuSC6fXUok5gfrPGHS5sgkwlQi0F9BAFCULrGu
         fwQzg7YaqwxL3O5uDUqeme8vu5nChiShqX/0h7+c4MZzPJLDUyBfyuFVL8lkiqtmleCU
         8EFw==
X-Gm-Message-State: AIVw110DIUkr2RtNr9+nbgNxBhmb6P4WRTPEn32Y0G9AdphQVlUm1HmF
        84ChIvCYy7ivThUdMcPAeA==
X-Received: by 10.99.168.65 with SMTP id i1mr16394244pgp.305.1501534624791;
        Mon, 31 Jul 2017 13:57:04 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6182:3b53:5da6:3508:cb8e:5545])
        by smtp.gmail.com with ESMTPSA id 16sm52881007pfq.151.2017.07.31.13.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 13:57:04 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 07/13] diff: change scope of the function count_lines()
Date:   Tue,  1 Aug 2017 02:26:15 +0530
Message-Id: <20170731205621.24305-8-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170731205621.24305-1-pc44800@gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com>
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
index 85e714f6c..03ed64f93 100644
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

