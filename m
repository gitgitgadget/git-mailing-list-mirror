Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61A11F428
	for <e@80x24.org>; Wed,  3 Jan 2018 03:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeACDFx (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 22:05:53 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39166 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbeACDFh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 22:05:37 -0500
Received: by mail-pf0-f194.google.com with SMTP id l24so217780pfj.6
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 19:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=iJgYC5ZFjobD3SpqPyhF2/VhdYBoK6zOk6FpOtpsA4Q=;
        b=uE7R4xaEX+PkmIvN2lNRx+uaUsr0Pqi4bDGxl1vGJw+Cmq2dRw2rXt/oNvwu1xb0cw
         q+fNlswjhyQjAekMyHaQC/HwrgsOMX1G6L144ZbOXquBi95sMavHpqgBuN2SNq2E2T3r
         GlwOAwQGBJ3zEAOafahNSOoT2urLSUMOI7GHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=iJgYC5ZFjobD3SpqPyhF2/VhdYBoK6zOk6FpOtpsA4Q=;
        b=jb1Ghaze7VDI7jKaOORGWSp+MKTVhp+QtjL6SI8U1ON69T1n5+9r9AJlhuUZn+bPex
         C3AyQLIEQmfOW7wsI1BHRk6SgVgVGhwS6y+R33Q12yQIZFTcX+RArj4ZgIZCyBneKDSC
         Txnxn91Hag8pDVLaD6INBwiVBdCq1gpNaWcWTiylwTF/hvCOzpjorftUnVhG5RT70lG/
         zItuHRSrssSmVTEZB5HerqnocO8laiqYyExTt397YSJ5ubmqTdLBFSDw8wevABtpd013
         D4W0BcV2Y7xOjK+eEjuov/gcPSqWsA44g/lrASIOzAatvMDrBJlwuOICC2bt5Xs0aAyi
         jQnQ==
X-Gm-Message-State: AKGB3mLUcx3g8uCOF6dkYXuPM3ueuWBdS1RLEdc7u6LhOW3AYPDws4La
        ynoazX+dzWwh1MvAHd0M1zIiU3h/pFE=
X-Google-Smtp-Source: ACJfBos5HWDJVwsNC0KHtq0DGegJpa7KSmD70i0eLXxBY4N9NtKo3R+TK/oxB4VF3N0u3z+AP7QUhQ==
X-Received: by 10.101.81.199 with SMTP id i7mr110690pgq.34.1514948736170;
        Tue, 02 Jan 2018 19:05:36 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (V160-vrrp.corp.dropbox.com. [205.189.0.161])
        by smtp.gmail.com with ESMTPSA id 82sm107742pfm.136.2018.01.02.19.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 19:05:35 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH 3/6] fsmonitor: Update helper tool, now that flags are filled later
Date:   Tue,  2 Jan 2018 19:04:53 -0800
Message-Id: <fb10a998d5a8250f26d3504a1d1f5ca6723160d7.1514948078.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.1.31.gddce0adfe
In-Reply-To: <20180103030456.8181-1-alexmv@dropbox.com>
References: <20180103030456.8181-1-alexmv@dropbox.com>
In-Reply-To: <023b0090bc7dc0ff9c3bee1efce8c85fdba27de3.1514948078.git.alexmv@dropbox.com>
References: <023b0090bc7dc0ff9c3bee1efce8c85fdba27de3.1514948078.git.alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dd9005a0a ("fsmonitor: delay updating state until after split index is
merged", 2017-10-27) began deferring the setting of the
CE_FSMONITOR_VALID flag until later, such that do_read_index() does
not perform those steps.  This means that t/helper/test-dump-fsmonitor
showed all bits as always unset.

Load the index using read_index_from(), which is aware of split
indexes and later fsmonitor ewah inflation, but ensure that we do not
add or remove it, by setting the value to "keep".

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 config.c                       | 9 +++++++--
 t/helper/test-dump-fsmonitor.c | 4 +++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index e617c2018..7c6ed888e 100644
--- a/config.c
+++ b/config.c
@@ -2174,8 +2174,13 @@ int git_config_get_fsmonitor(void)
 	if (core_fsmonitor && !*core_fsmonitor)
 		core_fsmonitor = NULL;
 
-	if (core_fsmonitor)
-		return 1;
+
+	if (core_fsmonitor) {
+		if (!strcasecmp(core_fsmonitor, "keep"))
+			return -1;
+		else
+			return 1;
+	}
 
 	return 0;
 }
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index ad452707e..48c4bab0b 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -1,12 +1,14 @@
 #include "cache.h"
+#include "config.h"
 
 int cmd_main(int ac, const char **av)
 {
 	struct index_state *istate = &the_index;
 	int i;
 
+	git_config_push_parameter("core.fsmonitor=keep");
 	setup_git_directory();
-	if (do_read_index(istate, get_index_file(), 0) < 0)
+	if (read_index_from(istate, get_index_file()) < 0)
 		die("unable to read index file");
 	if (!istate->fsmonitor_last_update) {
 		printf("no fsmonitor\n");
-- 
2.15.1.31.gddce0adfe

