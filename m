Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D46C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 11:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiKDLkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 07:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKDLk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 07:40:27 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E498912760
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 04:40:26 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d20so3561990plr.10
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3L8X6l6CU52qxImv/HP6JCs+2BmNeXDrnptnDdmUdE=;
        b=Cu4AKaypcsl+QI3WYfJxIcCYlNcC3Lh/CThYzHyAGNAkhun8Re5sXS/HXaMKLLSJRl
         MeM9EhF3vV9NEYwKh9EdTL8LmZkz7nAZ/SHNP5X66QPJdYmEWqIYVoj5B7Ao3/7DgpUx
         6/XNJOiBZTkiMY36YuProGUrfTxJwYXSlNxRk8E4pa0ZmIqDGLWT8X2tIiwBZrFx8Raw
         fGE3m/TsNNCv6uVPcjC4P7ODi5K6CYM6IL3vg6LU4nxqOP6yZSoVq4SXzPPgk8/+u5yx
         6CaCK9V2WRclkECAHFJQNj8UjgV3hxwig9BSnTqx+NEbvcHwvoamXpcG1AOiJgDBzl/S
         SYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3L8X6l6CU52qxImv/HP6JCs+2BmNeXDrnptnDdmUdE=;
        b=2W8FuJamd92MSLuibGoV5Kyj+ZLuy4FMRy+QRajJ85IUmoSRTdc7km+Yt1Ah9ffBm/
         eC1oK0cRqvqjtV+XSeEtWq2mw75Kl8BWkQ2Dgz/eA4ySLhEvSSKyBwvFfchuM7tI4U1h
         d8OqvYvqkO+xu6BgsRIhI6uwVKXpmR+FoFmrFHFMPnNsh6xDQU/pq7Sy4/WzVshza/9O
         VO60rCU+sp7tCs8PHgSVMLNJOIxqzUhQGH7QiACkpl3gLy8ZJl1l5aG+AD+qXjEpRibK
         oFkwYS/zB3rPBuHBkE73O2+1PBY/wy0iwoc7dNU+4Mn5pa1Esu2vPTyYI+Cv0ty+/Gi7
         NfcA==
X-Gm-Message-State: ACrzQf2IWM3byId4CKTrlZu1oKXTKAvvukNPdgUBoYAWFzwKTYge2LfS
        6d8JhZcdcKgpb7PpBegJVVHAvkv8VtA=
X-Google-Smtp-Source: AMsMyM7CtqAYqRb2Jqpokozsxc9eTiZMIhbonpSVUiggWgH/nS01WOphI17C57AamiEKZn+GdDhjYQ==
X-Received: by 2002:a17:902:f7d3:b0:187:ecb:20d5 with SMTP id h19-20020a170902f7d300b001870ecb20d5mr31579440plw.101.1667562026065;
        Fri, 04 Nov 2022 04:40:26 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id l24-20020a63ea58000000b0043c22e926f8sm2203133pgk.84.2022.11.04.04.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:40:25 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] bisect--helper: remove unused options
Date:   Fri,  4 Nov 2022 18:40:10 +0700
Message-Id: <489785ca45a84cffb4a2c16da15a09034829b7c6.1667561761.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667561761.git.congdanhqx@gmail.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com> <cover.1667561761.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1d2ce8a0e1..5ec2e67f59 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1283,7 +1283,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
 		BISECT_START,
 		BISECT_AUTOSTART,
@@ -1295,12 +1294,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_VISUALIZE,
 		BISECT_RUN,
 	} cmdmode = 0;
-	int res = 0, nolog = 0;
+	int res = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
-			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
 			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-start", &cmdmode,
@@ -1319,8 +1316,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
 		OPT_CMDMODE(0, "bisect-run", &cmdmode,
 			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
-		OPT_BOOL(0, "no-log", &nolog,
-			 N_("no log for BISECT_WRITE")),
 		OPT_END()
 	};
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
-- 
2.38.1.157.gedabe22e0a

