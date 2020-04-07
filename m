Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6534DC2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD3720747
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLWw8hkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgDGOLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:11:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35611 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbgDGOLz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:11:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so4101550wrx.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=xG4nh5mXcb6/Z6+FslKrsXcp11yIYS4YPcEDTfNtXZQ=;
        b=gLWw8hkrXtU/lnD6xclYjrw2H5NoImtzk6m18/q2mo9iOwL0NjX88K9JxV4Bito5E1
         jcmYNWbr3a2Qoy0NNfeskSYXiaM1SMvHTHeRAiBVdvpzsirqslm00zU9LH0xvPxjqtJ/
         OOWci5lQ169TrjmloAktoIpOKYStaI13oz3YH/4Xb3FInqo+g8AB3YUF6kt6nXBFlFNw
         oPOcKp3ELcgsHf7n0bIc3/AkYFAvovvCbanj5XpBBGWC69LxkrW1H5fyapjAEqWmmXfg
         1STdjvaN4At83qoOA6wcBpcP1RbI8Zv56nDuGk0qHxrQl8SvyGtraYWq5740X53CrElO
         u41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=xG4nh5mXcb6/Z6+FslKrsXcp11yIYS4YPcEDTfNtXZQ=;
        b=TBD1zxp1roem27EEuWkl3BpEesKPMXAef7qIr6IiIRDYGMHQ0KruqZ+RCpQKYN4BgV
         eKxv9J5FSD7RuIXuGauOJ5zL7Z3W5SE4MrxB7/SpRZva2aRP/PRGm8K0qI96TehVmAgI
         jQrJoamNdRU1VtCj0R9nYa7CHIGbnBHgwOS4tl3Ykb/vy7PSfnvc9maZAi2cpwM4GMT6
         hnXD+6qFw4Uyl2Woxs4D6shTq9i7fdaQ3LEOD854O7DNJ/fW1WRlqbBMSHpob3v2AMoS
         Th/w1RVseqUWhUGFY4W4aztLHjBNUmy6u3zdhvxZAzNMp7dtuA1UQ215xLpxoaFKVAHG
         4Ohg==
X-Gm-Message-State: AGi0Puab7Ob5dPdtR5NFlONijJuObLWXhrq+IfBP52Y4Bz6WMuaUYnEH
        wO++AULvMsJJCwvKrLTpikPl9inC
X-Google-Smtp-Source: APiQypL2Ee3LUpnF7BZcFPI3Pmh11yWB3yAKl2RDgYUpLxQpul2CgaseI8OdZKrTkNyMA+oUOc72GA==
X-Received: by 2002:a5d:464a:: with SMTP id j10mr2929724wrs.3.1586268711413;
        Tue, 07 Apr 2020 07:11:51 -0700 (PDT)
Received: from localhost.localdomain (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id v16sm2492693wml.30.2020.04.07.07.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:11:50 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/6] t3433: only compare commit dates
Date:   Tue,  7 Apr 2020 15:11:22 +0100
Message-Id: <20200407141125.30872-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407141125.30872-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

`git show` shows the diff by default so these tests which are about
checking dates were also comparing the diffs. Fix that by switching to
`git log -1`

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3433-rebase-options-compatibility.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
index 2b4d75f1ef..132f577fc9 100755
--- a/t/t3433-rebase-options-compatibility.sh
+++ b/t/t3433-rebase-options-compatibility.sh
@@ -73,16 +73,16 @@ test_expect_success '--ignore-whitespace works with interactive backend' '
 test_expect_success '--committer-date-is-author-date works with am backend' '
 	git commit --amend &&
 	git rebase --committer-date-is-author-date HEAD^ &&
-	git show HEAD --pretty="format:%ai" >authortime &&
-	git show HEAD --pretty="format:%ci" >committertime &&
+	git log -1 --pretty="format:%ai" >authortime &&
+	git log -1 --pretty="format:%ci" >committertime &&
 	test_cmp authortime committertime
 '
 
 test_expect_success '--committer-date-is-author-date works with interactive backend' '
 	git commit --amend &&
 	git rebase -i --committer-date-is-author-date HEAD^ &&
-	git show HEAD --pretty="format:%ai" >authortime &&
-	git show HEAD --pretty="format:%ci" >committertime &&
+	git log -1 --pretty="format:%ai" >authortime &&
+	git log -1 --pretty="format:%ci" >committertime &&
 	test_cmp authortime committertime
 '
 
@@ -101,14 +101,14 @@ test_expect_success '--committer-date-is-author-date works with rebase -r' '
 test_expect_success '--ignore-date works with am backend' '
 	git commit --amend --date="$GIT_AUTHOR_DATE" &&
 	git rebase --ignore-date HEAD^ &&
-	git show HEAD --pretty="format:%ai" >authortime &&
+	git log -1 --pretty="format:%ai" >authortime &&
 	grep "+0000" authortime
 '
 
 test_expect_success '--ignore-date works with interactive backend' '
 	git commit --amend --date="$GIT_AUTHOR_DATE" &&
 	git rebase --ignore-date -i HEAD^ &&
-	git show HEAD --pretty="format:%ai" >authortime &&
+	git log -1 --pretty="format:%ai" >authortime &&
 	grep "+0000" authortime
 '
 
-- 
2.26.0

