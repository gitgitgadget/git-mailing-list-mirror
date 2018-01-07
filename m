Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605091F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754460AbeAGSP2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:28 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35420 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754445AbeAGSP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:26 -0500
Received: by mail-qk0-f194.google.com with SMTP id w184so3536876qka.2
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=phfobg5p0BLSnYxYBg3IBdl+jChOT+213YVUmaUZ41Q=;
        b=lunT9GpokCvyOyt2DE+YUf/9aI/2270+5d5cdYy7cQyC91Ej86f2zIjqgkLRjvXUK/
         VubiWsnHKDloAazo07zU1hvTRqiMd4gqBVm39xjdqDN3ReSphOFvnRULoGSGAPcKJ4BA
         Hc51/Q2OE9GH3vaKQTgxzKt5bNTPkqx3R4Hgx9Vdrbrgkqe3s2BycpPmIalWU4X+IGRR
         mV7WiMj9cKRhVV6Z0l/XVrQ+zBO9TQapanwbJyOWB6qjQLZ6S8pZ9j0a4B19kdIQGWqD
         hOxPxTl219x66vV0BTYqBMhZ+ZgjNEBEA89vM3himcyxxCdRvrUIRHM4n08fCx/Fd4kU
         vhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=phfobg5p0BLSnYxYBg3IBdl+jChOT+213YVUmaUZ41Q=;
        b=sMBhd9/9Sj6DQrnC1McEJKhJ0QKFo5/2aHmQ0MLB5KCLlep6vHf9L6pyIDRQBvH1do
         aC2p3j8kkVGRPi0DT9PacfNNYFYDY2jzOh9vBg6MSwZbiX3Wgwq2OHTtzSo23fbCtovp
         h4xs5VfL2m4ZsUBk8wA4Hf72P+NAx3GrlpiDsWVjdpeEhE/sPcuURx68IB2c98PZ73Nc
         /hONr9HjSzqy7+lBUSnUjiCOU0wSYdj/ALcaprBVVdaVbE75KVd4ToOnbULKpGTibOm4
         YlJM+Q8Er65jlYzm1Wf03Bjif19sbSmwEXz7wy+DWcuUQsZGRELCpb8HR6TQv2FUUTxD
         gAlA==
X-Gm-Message-State: AKwxytf8mmAKfCnekYIGfIP8GTUN8KsOJqIBD1emStRP7hLdkv4fOd2d
        c+o7zlhurHQUhRk7SkQhFR2FjApD/iE=
X-Google-Smtp-Source: ACJfBosOm793zdIbDU085cJrwWg3+7q9L82MeJXU1hp4ViL3LyKZ4FHroCn8juTPFc4Tyxhru7u/IQ==
X-Received: by 10.55.176.132 with SMTP id z126mr12409154qke.162.1515348925380;
        Sun, 07 Jan 2018 10:15:25 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:23 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 13/18] t5318-midx.h: confirm git actions are stable
Date:   Sun,  7 Jan 2018 13:14:54 -0500
Message-Id: <20180107181459.222909-14-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Perform some basic read-only operations that load objects and find
abbreviations. As this functionality begins to reference MIDX files,
ensure the output matches when using MIDX files and when not using them.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5318-midx.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t5318-midx.sh b/t/t5318-midx.sh
index 42d103c879..00be852ed3 100755
--- a/t/t5318-midx.sh
+++ b/t/t5318-midx.sh
@@ -37,6 +37,19 @@ _midx_read_expect() {
 	EOF
 }
 
+_midx_git_two_modes() {
+	git -c core.midx=true $1 >output
+	git -c core.midx=false $1 >expect
+}
+
+_midx_git_behavior() {
+	test_expect_success 'check normal git operations' \
+	    '_midx_git_two_modes "log --patch master" &&
+	     cmp output expect &&
+	     _midx_git_two_modes "rev-list --all --objects" &&
+	     cmp output expect'
+}
+
 test_expect_success 'write-midx from index version 1' \
     'pack1=$(git rev-list --all --objects | git pack-objects --index-version=1 ${packdir}/test-1) &&
      midx1=$(git midx --write) &&
@@ -48,6 +61,8 @@ test_expect_success 'write-midx from index version 1' \
      git midx --read --midx-id=${midx1} >output &&
      cmp output expect'
 
+_midx_git_behavior
+
 test_expect_success 'write-midx from index version 2' \
     'rm "${packdir}/test-1-${pack1}.pack" &&
      pack2=$(git rev-list --all --objects | git pack-objects --index-version=2 ${packdir}/test-2) &&
@@ -61,6 +76,8 @@ test_expect_success 'write-midx from index version 2' \
      git midx --read> output &&
      cmp output expect'
 
+_midx_git_behavior
+
 test_expect_success 'Create more objects' \
     'for i in $(test_seq 100)
      do
@@ -71,6 +88,8 @@ test_expect_success 'Create more objects' \
      git commit -m "test data 2" &&
      git branch commit2 HEAD'
 
+_midx_git_behavior
+
 test_expect_success 'write-midx with two packs' \
     'pack3=$(git rev-list --objects commit2 ^commit1 | git pack-objects --index-version=2 ${packdir}/test-3) &&
      midx3=$(git midx --write --update-head) &&
@@ -84,6 +103,8 @@ test_expect_success 'write-midx with two packs' \
      git midx --read >output &&
      cmp output expect'
 
+_midx_git_behavior
+
 test_expect_success 'Add more packs' \
     'for i in $(test_seq 10)
      do
@@ -107,6 +128,8 @@ test_expect_success 'Add more packs' \
          git pack-objects --index-version=2 ${packdir}/test-pack <obj-list
      done'
 
+_midx_git_behavior
+
 test_expect_success 'write-midx with twelve packs' \
     'midx4=$(git midx --write --update-head --delete-expired) &&
      test_path_is_file ${packdir}/midx-${midx4}.midx &&
@@ -120,6 +143,8 @@ test_expect_success 'write-midx with twelve packs' \
      git midx --read >output &&
      cmp output expect'
 
+_midx_git_behavior
+
 test_expect_success 'write-midx with no new packs' \
     'midx5=$(git midx --write --update-head --delete-expired) &&
      test_path_is_file ${packdir}/midx-${midx5}.midx &&
@@ -127,6 +152,8 @@ test_expect_success 'write-midx with no new packs' \
      test_path_is_file ${packdir}/midx-head &&
      test $(cat ${packdir}/midx-head) = "$midx4"'
 
+_midx_git_behavior
+
 test_expect_success 'create bare repo' \
     'cd .. &&
      git clone --bare full bare &&
@@ -146,6 +173,8 @@ test_expect_success 'write-midx in bare repo' \
      git midx --read >output &&
      cmp output expect'
 
+_midx_git_behavior
+
 test_expect_success 'midx --clear' \
     'git midx --clear &&
      test_path_is_missing "${baredir}/midx-${midx4}.midx" &&
@@ -155,4 +184,6 @@ test_expect_success 'midx --clear' \
      test_path_is_missing "${packdir}/midx-${midx4}.midx" &&
      test_path_is_missing "${packdir}/midx-head"'
 
+_midx_git_behavior
+
 test_done
-- 
2.15.0

