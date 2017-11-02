Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ABBC20281
	for <e@80x24.org>; Thu,  2 Nov 2017 19:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964827AbdKBTmR (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 15:42:17 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45129 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934365AbdKBTmD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 15:42:03 -0400
Received: by mail-io0-f196.google.com with SMTP id i38so1503850iod.2
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 12:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UiyrVcLte/6vAe1AKUxEp/zQE26WKZheF0Q1KnGrHVs=;
        b=Zgjgk+FHP+zDhINk2xhkKFWPSWAVXcDip/fEu3ty1dnYQbDC9DfZPfWh7dVJ9R45V7
         qflBjXUvLLSzM93T1Cw4tiuu+CMfAFBnO4FV4jpFW78QKKjY+4nCfm1Dd2f1kpsC+C8C
         JsoKxpbNU8iF/v3JQmGeTY4gGw3cXJ07V0DQKzVEj/e7trsinNqSXN3p4tCSAKnhrldw
         sDJZlt9ztzGy352fSngpdy0bKJDMKWDyUS2GA05D6UUSxgPtIX0rPLPeOLTcnb4IMM56
         LZ6qtunN8PWLp/eHy9w7xtkXJR1QMriA0JG9aYOXkhdhPSvO+rv/vkOGw5TWgz+aYyRt
         tlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UiyrVcLte/6vAe1AKUxEp/zQE26WKZheF0Q1KnGrHVs=;
        b=EjRfEZ9+xG2+iHg0cY5TKrrLU7ztQsiE4inEsb2d8Hkr0i4J7RzrLcySOIxsUtMgBJ
         Yn2lXxYVa2x5jSdeVZXhJ8Mlpr0FkT2T8nPASW67DtT4XCS4zwG01XUVphq5RtdbQ0q+
         VZHr97MtDGdsIOjiY/ljvaPsnnDrql1El3aJfz4YgxHWO3pUadT3HXsfqGAHW3rEpU5p
         UEZF5uZQNAV7WlNhMRMgQDIo1DIQB6OO8o1vQ85muhDyhjmmc6No3Gu4y57gD6XEEIKU
         jpctZgg0o18jfAOvPbHIoZ3RDUqWc2+OfQcwkxIaR9xnKHBBMPbh4jvXVdX7UgdaRM7e
         UPjA==
X-Gm-Message-State: AMCzsaWsUD9cJ5Y6UoSchiTxuTdOtjAqq5vdR9akcRnQj3XjRlGidsbn
        3F6ovp3+fhJpt9J914TIin4npw==
X-Google-Smtp-Source: ABhQp+SIFMsEL+F8ziAR+W7U1k98EJ5yFKSqCbN8AMVbOwaAfmHHGu8GfJec0YT3gc6A1dpsXO3JtQ==
X-Received: by 10.107.104.11 with SMTP id d11mr5775863ioc.240.1509651722220;
        Thu, 02 Nov 2017 12:42:02 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1093:e9fc:3ec5:201d])
        by smtp.gmail.com with ESMTPSA id u140sm179582itc.41.2017.11.02.12.42.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Nov 2017 12:42:01 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info, schwab@linux-m68k.org
Subject: [PATCHv3 4/7] builtin/describe.c: rename `oid` to avoid variable shadowing
Date:   Thu,  2 Nov 2017 12:41:45 -0700
Message-Id: <20171102194148.2124-5-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.7.g980e40477f
In-Reply-To: <20171102194148.2124-1-sbeller@google.com>
References: <20171031211852.13001-1-sbeller@google.com>
 <20171102194148.2124-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function `describe` has already a variable named `oid` declared at
the beginning of the function for an object id.  Do not shadow that
variable with a pointer to an object id.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/describe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 29075dbd0f..fd61f463cf 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -381,9 +381,9 @@ static void describe(const char *arg, int last_one)
 	}
 
 	if (!match_cnt) {
-		struct object_id *oid = &cmit->object.oid;
+		struct object_id *cmit_oid = &cmit->object.oid;
 		if (always) {
-			printf("%s", find_unique_abbrev(oid->hash, abbrev));
+			printf("%s", find_unique_abbrev(cmit_oid->hash, abbrev));
 			if (suffix)
 				printf("%s", suffix);
 			printf("\n");
@@ -392,11 +392,11 @@ static void describe(const char *arg, int last_one)
 		if (unannotated_cnt)
 			die(_("No annotated tags can describe '%s'.\n"
 			    "However, there were unannotated tags: try --tags."),
-			    oid_to_hex(oid));
+			    oid_to_hex(cmit_oid));
 		else
 			die(_("No tags can describe '%s'.\n"
 			    "Try --always, or create some tags."),
-			    oid_to_hex(oid));
+			    oid_to_hex(cmit_oid));
 	}
 
 	QSORT(all_matches, match_cnt, compare_pt);
-- 
2.15.0.7.g980e40477f

