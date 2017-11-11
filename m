Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 202F51F42B
	for <e@80x24.org>; Sat, 11 Nov 2017 00:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754680AbdKKAEr (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 19:04:47 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:39793 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754022AbdKKAEq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 19:04:46 -0500
Received: by mail-it0-f67.google.com with SMTP id y15so3550347ita.4
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 16:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nugQAIKW/10f2gbsIT7i+7GigiYsNB8BVJqfhk6E+mY=;
        b=RyjGSfA0vuOAYM+es9K1AaBG1n9NK0inFp94A2ku4lm4UyjbbCiB5T1gBLut5UVZxi
         5Vyae2x2CV+0UOUszA32579VHDqrnVH/5LqfLO4DM611NxRsL5GLzMZoyCpWc+7WXZ8+
         wAQcnrG2gve9oMtvSzOpNl4jAOtq8tAmsry47zdZy91rGQzoj8VzK0/1TPZyIDz5GyJZ
         EoxtUs0J4dFClEanEs144DFVK67TOh2n37SxKlTt/exSqs9ibCZvMsTEbuKH5Rqm/ZSc
         SDfo5ilLC+3P5aPZHMgEmdUvJpr6j0BCA72pdVzNd1wUmwXj/Ln72pzkQntpr7Wd9Y59
         VvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nugQAIKW/10f2gbsIT7i+7GigiYsNB8BVJqfhk6E+mY=;
        b=krl48HzzK2sJwTOTEE0BaNQLmOoloeeDZop3LjSD09lWCkBfUB8eTK14o+Snmer4bP
         JoJbqLZssKoxCJkdu45J4i5B3r2lPDXMxlIfOlxUq64mqcAljxR6ize6f67XmbRZGQU8
         6b/xQGCmoZxZOofpmPGvcmpXEBGfOcU9x5ndCtEuFtnV3bqdkNwQp+ou1du4uuVEHya5
         +5VzrhIdAcLvbcrFEWJ3oKoXfDzBMLOBgrclgaIRe6qHnqPltvmlH49+BH42yPheWIcI
         x2wN2hmmmfv0V3d7yISADz00Issgqm8HEeYhIQFWmemhEOk54L1DIlWRTHDVaS1LPGh6
         UYzA==
X-Gm-Message-State: AJaThX5A7IAii4t1VZSzbenk9k7WpS3dWsiyPsECblOSJsOGSJIwwBPG
        VrneOQ+LpufVsj8nz84voqGlBQ==
X-Google-Smtp-Source: AGs4zMZlCqfqhqGzZXdsWnYIi1xzM1xG6E3yGCyRfG7iz6ppE+B0qxdJQxPS8jl1EqbHVN/8KHpbyg==
X-Received: by 10.36.91.138 with SMTP id g132mr2463669itb.33.1510358686063;
        Fri, 10 Nov 2017 16:04:46 -0800 (PST)
Received: from localhost ([2620:0:100e:422:a54c:b483:d939:9a91])
        by smtp.gmail.com with ESMTPSA id j41sm5255839ioi.80.2017.11.10.16.04.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Nov 2017 16:04:45 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     real@ispras.ru
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] t/3512: demonstrate unrelated submodule/file conflict as cherry-pick failure
Date:   Fri, 10 Nov 2017 16:04:43 -0800
Message-Id: <20171111000443.16675-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <743acc29-85bb-3773-b6a0-68d4a0b8fd63@ispras.ru>
References: <743acc29-85bb-3773-b6a0-68d4a0b8fd63@ispras.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

I rewrote your script to integrate with our test suite, potentially acting as
a regression test once we solve the Directory/File conflict issue.

Thanks,
Stefan

 t/t3512-cherry-pick-submodule.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodule.sh
index 6863b7bb6f..17a6773247 100755
--- a/t/t3512-cherry-pick-submodule.sh
+++ b/t/t3512-cherry-pick-submodule.sh
@@ -10,4 +10,40 @@ KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
 test_submodule_switch "git cherry-pick"
 
+test_expect_failure 'unrelated submodule/file conflict is ignored' '
+	test_create_repo sub &&
+
+	touch sub/file &&
+	git -C sub add file &&
+	git -C sub commit -m "add a file in a submodule" &&
+
+	test_create_repo a_repo &&
+	(
+		cd a_repo &&
+		touch a_file &&
+		git add a_file &&
+		git commit -m "add a file" &&
+
+		git branch test &&
+		git checkout test &&
+
+		mkdir sub &&
+		touch sub/content &&
+		git add sub/content &&
+		git commit -m "add a regular folder with name sub" &&
+
+		echo "123" >a_file &&
+		git add a_file &&
+		git commit -m "modify a file" &&
+
+		git checkout master &&
+
+		git submodule add ../sub sub &&
+		git submodule update sub &&
+		git commit -m "add a submodule info folder with name sub" &&
+
+		git cherry-pick test
+	)
+'
+
 test_done
-- 
2.15.0.128.gcadd42da22

