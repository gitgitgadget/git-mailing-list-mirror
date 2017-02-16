Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47E4D1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 17:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932492AbdBPRHX (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 12:07:23 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32956 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932410AbdBPRHW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 12:07:22 -0500
Received: by mail-lf0-f67.google.com with SMTP id x1so1964970lff.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 09:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KZNbhpGztUtUDJC/MNHzu6E7OEMMTKpxhlBqYuNW+uU=;
        b=jp0Yg84b+Z9q43zR5W+6qppAsFEEeKnrARZBsBvrkoeCjGA8HOGaoADGPgeQT0zMCQ
         1jIvVseXF/oKDSZfb7Dj1viR34KxHlNJN6r1I6FwHDx0gOzdHa8HZBKl8yPXr628/ml0
         2EJq/gp5CxwdphjMCdoJUYcufhwVO9XE18xFzz6cSHEy+C+GWH8nECoHyLFV40KH236a
         Ty3SpQgBmzrnTybxxQ7hqsfzE0xKVWw40rrQ2WrKe5PkR+fEjwsXR2fzrTD6rCv8G/pp
         rhEVZTuRPQEOtnCT1ZkZ2zkdsq7fdzjLQdydRU1pdhm3d8kKueBLyEVrKnqK4Yj/fmrK
         dGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KZNbhpGztUtUDJC/MNHzu6E7OEMMTKpxhlBqYuNW+uU=;
        b=Nue0F7La9htHZtslscGpgC+NrcGQn7+nmxb4D2nMUja/kUM0BFwaXOYV4mEp1GSFUX
         eclsFrX3HRm6MDydp8wTAkN0R17ttPaMeJ89trWRJZ5dwK3T/DVNi7NzeCTM6IaiPNQt
         zOMyCVRV/PLM0aLSuxu8QjFafolPr6OSwtPCIzacb/Tg9+7VGcKCP925OHDMRhAila07
         BbytdRpLAv9JrpNXFxqlUuBt31jKU5tRjL2tUSSH6NNhe2Tb2pInVT6pNe/qkOFwDS1Z
         IySTvQtCY6uWM3V5XD1U1Ozi/OUtT40JnedZqkStX1wXjtFLe15bGXa5R//Ata5SltWD
         YQWQ==
X-Gm-Message-State: AMke39mVN5mVrppl11Ffe8Mt9U/Po9bEFRgF/CruunA76Sn8ufiMK3VYAes3Dyrntrcmkw==
X-Received: by 10.46.21.23 with SMTP id s23mr915531ljd.54.1487264840351;
        Thu, 16 Feb 2017 09:07:20 -0800 (PST)
Received: from localhost.localdomain ([2001:470:1f0b:8fc:eda1:2dcd:3a83:adeb])
        by smtp.gmail.com with ESMTPSA id s7sm1867896lja.27.2017.02.16.09.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 09:07:19 -0800 (PST)
From:   Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com,
        Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
Subject: [PATCH V2 1/2] bisect_next_all: convert xsnprintf to xstrfmt
Date:   Thu, 16 Feb 2017 20:07:12 +0300
Message-Id: <20170216170713.10065-2-franchesko.salias.hudro.pedros@gmail.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170216170713.10065-1-franchesko.salias.hudro.pedros@gmail.com>
References: <20170216170713.10065-1-franchesko.salias.hudro.pedros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git can't run bisect between 2048+ commits if use russian translation.
Reproduce "LANG=ru_RU.UTF8 git bisect start v4.9 v4.8" on linux sources.

Dummy solution: just increase buffer size but is not safe.
Size gettext string is a runtime value.

Signed-off-by: Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
---
 bisect.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index 21bc6daa4..787543cad 100644
--- a/bisect.c
+++ b/bisect.c
@@ -940,7 +940,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	struct commit_list *tried;
 	int reaches = 0, all = 0, nr, steps;
 	const unsigned char *bisect_rev;
-	char steps_msg[32];
+	char *steps_msg;
 
 	read_bisect_terms(&term_bad, &term_good);
 	if (read_bisect_refs())
@@ -990,14 +990,15 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	nr = all - reaches - 1;
 	steps = estimate_bisect_steps(all);
-	xsnprintf(steps_msg, sizeof(steps_msg),
-		  Q_("(roughly %d step)", "(roughly %d steps)", steps),
-		  steps);
+
+	steps_msg = xstrfmt(Q_("(roughly %d step)", "(roughly %d steps)",
+		  steps), steps);
 	/* TRANSLATORS: the last %s will be replaced with
 	   "(roughly %d steps)" translation */
 	printf(Q_("Bisecting: %d revision left to test after this %s\n",
 		  "Bisecting: %d revisions left to test after this %s\n",
 		  nr), nr, steps_msg);
+	free(steps_msg);
 
 	return bisect_checkout(bisect_rev, no_checkout);
 }
-- 
2.11.1

