Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373391F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeBFAcz (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:32:55 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44185 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeBFAcy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:32:54 -0500
Received: by mail-pg0-f66.google.com with SMTP id r1so176847pgn.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dFsfVxhzsOq3ctlP1Ck1m1u1czARPiPo2Uzv5aXV2q4=;
        b=Hv9BEcA0p0JSsL5cKpeoth0LbadFcr44xo/1qoiOIiOj+e8exWVfcYzdr+EnyYChG6
         to8m+3SUSsk6RlHqaqgy8t4sTsYD0bX5S/LCe94uzLJudmjRNDw1DSUcvzE1RcDstqfm
         ztl76KG3+bBacdRpqFkenVzYl8BdZTkSRLjnuyUWOIplG9NOG8V8pmaF1R/0wikgyEIg
         oxSVaRefnf0HRRPPqrOaAm/BtPP5jDaWloY0vVcKoSe+KCp28QJawj5uCx0YFZlkl4j5
         DAMvCM5S9nQYvG+B2YRcfQ6ZBicMx03V5QG/JUbtr0x4Cgk1cVIiOs4U9g3FfA70tSEa
         +4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dFsfVxhzsOq3ctlP1Ck1m1u1czARPiPo2Uzv5aXV2q4=;
        b=ufdlljzyCPIvev/HGqupfP87usiNcsVoWpGfonFsx+yDEahl2MoOGfMZBP9ItCBHGj
         vEmurhcjZoxrn+AiPUuQhAfT6lJ6w9aLVag5I7G9zG+odgeAKhVgkxwq7xek1VBu9d5Q
         NQWvwDwXuFcvYYt3XkFHUsUOirbN2z3X4+MpyGcma641cGsYS0RARVY9fqm8PUFe/dMr
         h3PoAvYtGwDDM0KrDrZrwo87e95YqXpj60WEjO1fM+DUCRy27/nWHdL8bhfEzTBdoF9E
         M2CLakPuvi28zKqsbw0Q5hwdXbbtQ7hDtQD8QuepcvxhE1mjTUeOdnobjJdY4fuUvmo3
         pZBg==
X-Gm-Message-State: APf1xPBVHhNbOl4aaUnO1Dg8SZfxSa+aCrs0Kr8/33c4zygdznc4ijup
        b0Aofg4UjLFKcORATblxt1XGD/hTtn4=
X-Google-Smtp-Source: AH8x2274SRquWnFqjeR7Z2H1R5AUn3G2pCZnaolIRL+TGVOnrJuBwnu7dWty8MN0li7SoA2o2tRE+g==
X-Received: by 10.98.248.75 with SMTP id c11mr593763pfm.54.1517877173318;
        Mon, 05 Feb 2018 16:32:53 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 204sm18090622pfu.44.2018.02.05.16.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:32:52 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 192/194] submodule: add repository argument to print_submodule_summary
Date:   Mon,  5 Feb 2018 16:17:47 -0800
Message-Id: <20180206001749.218943-94-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6125bfbdde..022e366940 100644
--- a/submodule.c
+++ b/submodule.c
@@ -441,7 +441,8 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 	return prepare_revision_walk(rev);
 }
 
-static void print_submodule_summary(struct rev_info *rev, struct diff_options *o)
+#define print_submodule_summary(r, rev, o) print_submodule_summary_##r(rev, o)
+static void print_submodule_summary_the_repository(struct rev_info *rev, struct diff_options *o)
 {
 	static const char format[] = "  %m %s";
 	struct strbuf sb = STRBUF_INIT;
@@ -579,7 +580,7 @@ void show_submodule_summary(struct diff_options *o, const char *path,
 		goto out;
 	}
 
-	print_submodule_summary(&rev, o);
+	print_submodule_summary(the_repository, &rev, o);
 
 out:
 	if (merge_bases)
-- 
2.15.1.433.g936d1b9894.dirty

