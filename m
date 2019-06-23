Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC0461F461
	for <e@80x24.org>; Sun, 23 Jun 2019 20:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfFWUGO (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 16:06:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46988 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFWUGO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 16:06:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so5623311pls.13
        for <git@vger.kernel.org>; Sun, 23 Jun 2019 13:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sjxQC9ExWqlfRwxfY1lcZGsCIZu7g+wklshVn6nyRpc=;
        b=T9AWf9QIoczWH0mESNuzzInPqBCMzLIVUhyw+LiuGFicVgECxpeU3BGklVEbbd95lp
         q/vOiH2GpmQcpLAIAhdLmyNno/lCw8sKmcvvj+k9xe8UFdokKHHilNLAROX8vCPa8Cq4
         4HQkSBafHYneh5v1u4s+QQ0lecxrAKhMrLyENv/Kik4PKkk16eONbp0JRKHTZ6yRZ+yt
         NYycy0KOE2iRcgBNBwcT4MvAiDBBQdAaNBeVpuz/ByGjetCHR7YR8J7NsegVMvUrEgEk
         eMUzF7MBPhAjc3640ZVGU53dtjbcJEM8rYVpL/3DPjGuh+H1ZScAqQd73rdga3ruKElp
         vUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sjxQC9ExWqlfRwxfY1lcZGsCIZu7g+wklshVn6nyRpc=;
        b=h9hEnyKuyjPiROBLxepEMqxxbVCPrLXcJqMlOptI8CgDEvZTpnOtMsdN6N+O1V7WlW
         yS/HU1HYMOdAIclW6CQ/Nphmhl15fvAr8hpRAS3xQ4O3QRj2U83eSebOMyjH6uL+PQs3
         R32aAfPi+7yTSy5bZxdlmwVR1zy7/kw9vSUNwX6ACYs2ls2KcDmxG6PDW29pA6qoWl9C
         Yk65l4+JjfXwGYE//v3Lr2mWMX8OD4YAUlI4fvgeZEPMRS8ReHVUj/iAzdWIH8Gvpd93
         UuzLB4HxIR0w7QuKFBJzTILZmgkYYLEZVIEEUD6x5w0lrZmTseYe+qW+Gdr2BKzQ/7k1
         UF6g==
X-Gm-Message-State: APjAAAUcVoF3FVzB5zpx8PqkZXo5B3d5QZ8DH5hZ63vzcYXJtD5do9Jt
        su6HAqGeqjiDuB3MOAZjil73ossVn2k=
X-Google-Smtp-Source: APXvYqxBypN1w81s1wRTTbzq6kr7mtA8p7gILrRsapvNOKz2JJmHN5mk6gWntLLTDlZGMjxEIimu6g==
X-Received: by 2002:a17:902:aa83:: with SMTP id d3mr119114150plr.74.1561320373321;
        Sun, 23 Jun 2019 13:06:13 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.213])
        by smtp.gmail.com with ESMTPSA id 27sm8621882pgt.6.2019.06.23.13.06.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 13:06:12 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [GSoC][PATCH v7 4/6] sequencer: use argv_array in reset_merge
Date:   Mon, 24 Jun 2019 01:33:36 +0530
Message-Id: <20190623200338.17144-5-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190623200338.17144-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190623200338.17144-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid using magic numbers for array size and index under `reset_merge`
function. Use `argv_array` instead. This will make code shorter and
easier to extend.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cb856bcfc3..70efe36ee8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2734,13 +2734,18 @@ static int rollback_is_safe(void)
 
 static int reset_merge(const struct object_id *oid)
 {
-	const char *argv[4];	/* reset --merge <arg> + NULL */
+	int ret;
+	struct argv_array argv = ARGV_ARRAY_INIT;
 
-	argv[0] = "reset";
-	argv[1] = "--merge";
-	argv[2] = oid_to_hex(oid);
-	argv[3] = NULL;
-	return run_command_v_opt(argv, RUN_GIT_CMD);
+	argv_array_pushl(&argv, "reset", "--merge", NULL);
+
+	if (!is_null_oid(oid))
+		argv_array_push(&argv, oid_to_hex(oid));
+
+	ret = run_command_v_opt(argv.argv, RUN_GIT_CMD);
+	argv_array_clear(&argv);
+
+	return ret;
 }
 
 static int rollback_single_pick(struct repository *r)
-- 
2.21.0

