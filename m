Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A31B201A0
	for <e@80x24.org>; Sat,  1 Jul 2017 00:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbdGAA2t (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 20:28:49 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34245 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbdGAA2q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 20:28:46 -0400
Received: by mail-pg0-f50.google.com with SMTP id t186so70726181pgb.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 17:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wrN7TD5OA6shnks9SByRAXOC1Gx9isHnuTK4+4JPgQQ=;
        b=qyQ6S3PM0eZrvHiOhLXTMoGLO6L3M9xOYOPltbuGsoqFOAHdfXFKG/vZU3QmIk+VkD
         /xieBo8WNZhfmcl16cOdc42X4QXbG3Ge7rFS/qJHoFy/XYhAloJA6y1x5xC2s5zWQ3/c
         QgUGwcT+FNVDBEOQUIewK+GAlKLDpvSWtWrTZ3gFJ+gh4DNoTX4QQ4ifiOzMR/N4ohwO
         lsfBdC7MpGIexkx1gJMNoc4PE/Q/+KwcHh19y97NTe4jmQ6jsGNqc5ilPS/RcQXxBg1x
         nCqI41n9+ePeGuFJ/v4gXN1+kco0LvgeqMYaUl4ZcFDMcelW5gUJci+7hi6s1/ISx5Qf
         PeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wrN7TD5OA6shnks9SByRAXOC1Gx9isHnuTK4+4JPgQQ=;
        b=Us50SqU+JiTVmT8rF1m1n6xjywcPmGT1nlIBIO4c+SLOB4NA21WWW2l+d66EX5EM/E
         InhTEUtFAJzR9XqJdoQ533I8MZKyYaXoxuhNJTjFQ8W5a2+VtBHccOfWSe7gT6a6/a5K
         TTJx3xrPUHuP7c6sM7/5HH33f+YBln+HwDig+bSRKrdyy3V4L7oSaQVFDXuKFZAHIde9
         kvOl27GtcPIjzido4oS8FUrDdPJzOo8Vn4lFSgIepwZfLMhUBYd/h0CI4M12BPRvKzem
         8q30GEuTVloQ7u0/q5iyLPRWoluDOThG5FJ1EMe5zqaiZT7QOqDxcTAdBulxQ8K5+39f
         giPw==
X-Gm-Message-State: AKS2vOw/v0rYq/2VBNpHXgbimDX46i0n7kJUnNp6bpJKGhdGCkMy6BAE
        o1FUfcE9Ss01wU5Pyz8vOA==
X-Received: by 10.99.143.94 with SMTP id r30mr23460608pgn.102.1498868925512;
        Fri, 30 Jun 2017 17:28:45 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:cc8b:7c8c:8e14:f9b5])
        by smtp.gmail.com with ESMTPSA id x85sm20528722pff.92.2017.06.30.17.28.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 17:28:44 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/10] builtin/describe: drop hashmap_cmp_fn cast
Date:   Fri, 30 Jun 2017 17:28:31 -0700
Message-Id: <20170701002838.22785-4-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170701002838.22785-1-sbeller@google.com>
References: <20170701002838.22785-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/describe.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 8868f00ed0..f2f2edf935 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -55,10 +55,13 @@ static const char *prio_names[] = {
 };
 
 static int commit_name_cmp(const void *unused_cmp_data,
-			   const struct commit_name *cn1,
-			   const struct commit_name *cn2,
+			   const void *entry,
+			   const void *entry_or_key,
 			   const void *peeled)
 {
+	const struct commit_name *cn1 = entry;
+	const struct commit_name *cn2 = entry_or_key;
+
 	return oidcmp(&cn1->peeled, peeled ? peeled : &cn2->peeled);
 }
 
@@ -503,7 +506,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		return cmd_name_rev(args.argc, args.argv, prefix);
 	}
 
-	hashmap_init(&names, (hashmap_cmp_fn) commit_name_cmp, NULL, 0);
+	hashmap_init(&names, commit_name_cmp, NULL, 0);
 	for_each_rawref(get_name, NULL);
 	if (!names.size && !always)
 		die(_("No names found, cannot describe anything."));
-- 
2.13.0.31.g9b732c453e

