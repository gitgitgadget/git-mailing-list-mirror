Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2DDB201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 17:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424356AbdKRR2F (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 12:28:05 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33129 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424344AbdKRR2D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 12:28:03 -0500
Received: by mail-pg0-f66.google.com with SMTP id s75so4249765pgs.0
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 09:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QCQp+aDDRJrq6tkjb3PQ/9OlR3jgN8mW/GJFo64JoGY=;
        b=KvBgGS4J48jpD+YZnnE9ZoccwNq6CgayT6Bm+N3Zg5to0T4st0vyE8E3Y3CRhSKSRG
         1YXdjDgnFBj3rIjQ0Puve3AlkVF9rV4N+FaKm53kubHQADh8brLHvNFskbfaMO121P8V
         2jWxCjUrVtqfYaTnaQ8Oi+1hrkJBdD4RgZ5nD2jMbFbNETdE+7R6Mw1g+Kk69490a3bu
         M5ApgKUaEW76YbQkhOUhFLHXxQFI3ytNOz6sMcOUZxYeyfA39UXNSEG6E7rSZeCU3gUw
         Q5ICMM5GPnv85+jqKKo9fgSQdJwhHIVrwoZmlRXEKNUcHAOOPkHlSINIwL9d6bcMi96B
         yiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QCQp+aDDRJrq6tkjb3PQ/9OlR3jgN8mW/GJFo64JoGY=;
        b=WSIKBx3eoaEMlD+kFzc3i9yB9/fvyeVWXcwg0cESRD3zwT2cxYyzIQeCMH3Hoztyfn
         uWiQRV0jPg+DymRXWJ1mMlmhIy5iLS8G5If4Kzpipnl4AqDMM8/yswnesU3pp7gBLAWM
         JLZMl6JYGCLhp7CBJqQlGDRiw2B56AbyqF3fBuLZSYDFMl6hG3k2IxKc2CNJhE+j/MaR
         zOxO5I49HeSUfTVj3sf3hdeIGhjWmfxRvFa7RQF8mbeFtK/Ub0o5vZ/nAfY6XzZUuHBv
         luITb24M9BuX7PTZQLiGG/hKiFfF05OeMyIyg8wcxHrAZZEb6hMnwez/01qCPPwe+zo1
         ZWgA==
X-Gm-Message-State: AJaThX6gLpgKq9mdUPyUNJTFOlZDbYzR9WsJDuF5NDJlpNNKzaX+2/+x
        ip67C/HFDOOCQD312KQdWuwZ/dzr
X-Google-Smtp-Source: AGs4zMaBVw69UDBm82dnrjKqtHIRQTy4bUjJYtzrDhnCJvWLdq2X97Sm2d8rFPswKCk7NnoZxf9q/w==
X-Received: by 10.84.248.68 with SMTP id e4mr8842868pln.0.1511026082622;
        Sat, 18 Nov 2017 09:28:02 -0800 (PST)
Received: from localhost.localdomain ([2405:204:72c0:fc36:f2a4:a5ab:70fc:f807])
        by smtp.gmail.com with ESMTPSA id d12sm10479749pgt.16.2017.11.18.09.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Nov 2017 09:28:01 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/4] branch: update warning message shown when copying a misnamed branch
Date:   Sat, 18 Nov 2017 22:56:47 +0530
Message-Id: <20171118172648.17918-4-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.291.g0d8980c5d
In-Reply-To: <20171118172648.17918-1-kaartic.sivaraam@gmail.com>
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20171118172648.17918-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a user tries to rename a branch that has a "bad name" (e.g.,
starts with a '-') then we warn them that the misnamed branch has
been renamed "away". A similar message is shown when trying to create
a copy of a misnamed branch even though it doesn't remove the misnamed
branch. This is not correct and may confuse the user.

So, update the warning message shown to be more precise that only a copy
of the misnamed branch has been created. It's better to show the warning
message than not showing it at all as it makes the user aware of the
presence of a misnamed branch.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4edef5baa..ca9d8abd0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -507,7 +507,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	if (recovery) {
 		if (copy)
-			warning(_("Copied a misnamed branch '%s' away"),
+			warning(_("Created a copy of a misnamed branch '%s'"),
 				oldref.buf + 11);
 		else
 			warning(_("Renamed a misnamed branch '%s' away"),
-- 
2.15.0.291.g0d8980c5d

