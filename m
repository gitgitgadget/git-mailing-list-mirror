Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89F5420A99
	for <e@80x24.org>; Tue, 10 Jan 2017 20:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbdAJUnM (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:43:12 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:34899 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbdAJUmp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:42:45 -0500
Received: by mail-qt0-f174.google.com with SMTP id x49so111085287qtc.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=upJqDKOasEci2/UGypvg8gZjU1z23qgUwTL48+D6PU0=;
        b=coiNtcTgZelYVeMxL0eWGaXJJFXnNFMW+/I87uw9ox4gf/1v/bT2Z3agKHcdM9sKMz
         xCE7FfXTh0OENejcBIaNnXsrskHj9yMxjlkAa28Vu7kn4dVAyHNTiRGlFgrwiR/LenFR
         P7RC3gX9kqzOw2UYHeA+H4Dc4NqQRoGKkZIF38pv4HhQgwW/c1IE96xlio1Eob2JtYua
         diduyGFIBogzA5GYW1uNfvOT1TfYrkch5TTj5LiMRseEH5ZdMEiQ/JcVMA6RgzKXrv5F
         R5WmrU29ZXA5D5pO5crRw9tX7V8bObs3+0WhCeC6btVu7jy+bKxc+EnHYefx6sTA1/dq
         PRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=upJqDKOasEci2/UGypvg8gZjU1z23qgUwTL48+D6PU0=;
        b=WC6S69MAOZCxmkV8ixa/fSfztvuRhfPPQTyVKqSPA6f9M3q9Bej1bV4ntYXOOwIvRp
         T7dxpZwT1VlNAfGasR2msbmVRulmUiEgp31weMlNlV+yHRrO1+FQKtAkSC4qlumPrHL2
         Niuda0A7353+LA8lt19hob9j+kjbb2t4T7G+z7gYi11BN6P5irNrdQowLrpXBs6tzG5j
         6kK9ll1AHQ43WxF+JrfrxrpByzEMhxtTmr8QRNkk2blGCnslqgttSZ6d8ZVzNZVKhS76
         m5I94aJRBG4X03Ab9LSrq4kYWZml/DJxnMnajZ48azULllx3TiqeuDmtMffM+j9Or05y
         OVHg==
X-Gm-Message-State: AIkVDXLvQjNTsTX4g1z7maF3uwKd6iY2AHxeE/U4wM3RvgrxSZ2dDfee10kSZVw8raRg/smH
X-Received: by 10.200.40.113 with SMTP id 46mr4394977qtr.167.1484080964851;
        Tue, 10 Jan 2017 12:42:44 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id z189sm2238137qkb.42.2017.01.10.12.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 12:42:44 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org, gitster@pobox.com
Subject: [PATCH v5 08/14] t7610: delete some now-unnecessary 'git reset --hard' lines
Date:   Tue, 10 Jan 2017 15:41:56 -0500
Message-Id: <20170110204202.21779-9-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170110204202.21779-1-hansenr@google.com>
References: <20170109232941.43637-1-hansenr@google.com>
 <20170110204202.21779-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests now always run 'git reset --hard' at the end (even if they
fail), so it's no longer necessary to run 'git reset --hard' at the
beginning of a test.

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 t/t7610-mergetool.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 55587504e..7d5e1df88 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -184,7 +184,6 @@ test_expect_success 'mergetool in subdir' '
 
 test_expect_success 'mergetool on file in parent dir' '
 	test_when_finished "git reset --hard" &&
-	git reset --hard &&
 	git submodule update -N &&
 	(
 		cd subdir &&
@@ -277,7 +276,6 @@ test_expect_success 'conflicted stash sets up rerere'  '
 
 test_expect_success 'mergetool takes partial path' '
 	test_when_finished "git reset --hard" &&
-	git reset --hard &&
 	test_config rerere.enabled false &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
-- 
2.11.0.390.gc69c2f50cf-goog

