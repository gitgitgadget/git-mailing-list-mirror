Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B2FB1FF76
	for <e@80x24.org>; Wed, 14 Dec 2016 08:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755102AbcLNIii (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 03:38:38 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32822 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755090AbcLNIig (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 03:38:36 -0500
Received: by mail-pf0-f196.google.com with SMTP id 144so824209pfv.0
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 00:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lqzRtGuZEAD2gyPZ7HAojYDJ1jcY2Mw3BGlSlj7zOok=;
        b=ILkIxNIE/UPxa4YhaZdCRzIkhAmwVwZuaJM3v66IVxJlCp368K5t5Fe1tZQRut1eyF
         Wq9d+bJBfUi8rjByV1aDGge15JfO0FWQwEVXpWpENzn2TbYkeYpnEg1BSGmmIkemivyx
         0P/NvLnvNbrKXSsFjFYOZL2P9pBE0MuJgfvBr55+bfa03xeaS08ylztrxBM1SpcaD57T
         R3DF4yiwhHWwoGbLoWWYzrXPSGQX8u9GeIVzZkOKkVJyi2ir+2Zs2oKdYaTLIOSCDV0+
         5S1M0gZ6FtM62W9HURF6K/slHW2StMzG5NT7qlAtnTOW/Fw3AmuNzXSFj0kTvMDl9rWq
         gsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lqzRtGuZEAD2gyPZ7HAojYDJ1jcY2Mw3BGlSlj7zOok=;
        b=DVOBWO58nh1c6kzX8+bA/74EjsiWJsBDKNNjz8bObuOFwgE9UEkLQXPpnDTbC1GPd0
         T/KmiUbuBvTinTmhBBZTAqxdbVIvonFbNwMd5Gx71wlXMNdagDrULzeht0lBLgUk1yMr
         48ouZVmQkkvCxhoDhGHphiAsH90emwymKJsH+MJeNjqby9ms7kRkbdAMnSK87DQkSOnm
         7B0avYr/1/XqqEAG8aoYelb/Ch4cOf5+CCu4XHZ5S0sySPMmkxBLOTyiKzLIDyZuspkD
         tOnF46gTxSugt2s9mNQaNAhxGxj8DBcUaTMGrcdMGmvk8oFzeeKOzU1RtVZm8k8r3wba
         UaYA==
X-Gm-Message-State: AKaTC00+a0c7002Er+TcdWw86ZCY5Fd3aF8olDw1Qr78qIv1n7+/Gk3JoD/VelM8w77pBA==
X-Received: by 10.84.217.70 with SMTP id e6mr204013988plj.161.1481704715873;
        Wed, 14 Dec 2016 00:38:35 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:50cb:a0f2:6faa:ea3b])
        by smtp.gmail.com with ESMTPSA id g63sm85225192pfd.60.2016.12.14.00.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 00:38:35 -0800 (PST)
From:   Chris Packham <judge.packham@gmail.com>
To:     git@vger.kernel.org
Cc:     mah@jump-ing.de, peff@peff.net, jacob.keller@gmail.com,
        gitster@pobox.com, Chris Packham <judge.packham@gmail.com>
Subject: [PATCH 3/3] merge: Ensure '--abort' option takes no arguments
Date:   Wed, 14 Dec 2016 21:37:57 +1300
Message-Id: <20161214083757.26412-3-judge.packham@gmail.com>
X-Mailer: git-send-email 2.11.0.24.ge6920cf
In-Reply-To: <20161214083757.26412-1-judge.packham@gmail.com>
References: <20161213084859.13426-1-judge.packham@gmail.com>
 <20161214083757.26412-1-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like '--continue', the '--abort' option doesn't make any sense with
other options or arguments to 'git merge' so ensure that none are
present.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
Changes in v3:
- new

 builtin/merge.c  | 4 ++++
 t/t7600-merge.sh | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 836ec281b..668aaffb8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1163,6 +1163,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		int nargc = 2;
 		const char *nargv[] = {"reset", "--merge", NULL};
 
+		if (orig_argc != 2)
+			usage_msg_opt("--abort expects no arguments",
+			      builtin_merge_usage, builtin_merge_options);
+
 		if (!file_exists(git_path_merge_head()))
 			die(_("There is no merge to abort (MERGE_HEAD missing)."));
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 682139c4e..2ebda509a 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -154,6 +154,8 @@ test_expect_success 'test option parsing' '
 	test_must_fail git merge -s foobar c1 &&
 	test_must_fail git merge -s=foobar c1 &&
 	test_must_fail git merge -m &&
+	test_must_fail git merge --abort foobar &&
+	test_must_fail git merge --abort --quiet &&
 	test_must_fail git merge --continue foobar &&
 	test_must_fail git merge --continue --quiet &&
 	test_must_fail git merge
-- 
2.11.0.24.ge6920cf

