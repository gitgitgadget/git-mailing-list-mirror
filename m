Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 696521FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 19:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbcLBTRx (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 14:17:53 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34810 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbcLBTRw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 14:17:52 -0500
Received: by mail-pg0-f42.google.com with SMTP id x23so110443427pgx.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 11:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zw4kmBWpi3mlKMKB1HGq9O13oY6ECf44dlynQrDWBmE=;
        b=VumUM31tESTuzw4U2T2no7MFQ13NUEquKY6zKYVW6XgMWfSP+0fFPxCW4dApdi2f/k
         wrtjqzHHJgGz58sfnep4nQQpoW37OimKEyvP8zaVKYzdC9DVWiE30lNAph2uFiXc+n60
         CUdDTUzGKuJ0nkBGoSs97e+sYc4UvESIN+aLGDc9uHuEp9qv3YxPG18LBl9OKA0+66pm
         vwkn2377ByosBvLeV0AvWhwWBVME3UsjgvkyR8ahCGtw+rVcH1X4U58vlgJaWm1WfFhz
         7DUvOl4a8Xso/mXQ7JkKhc6HPL4qOAJPxyLkXidQqJJcEhuKfk1Tr7dMyWMGrBnpOEKY
         JaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zw4kmBWpi3mlKMKB1HGq9O13oY6ECf44dlynQrDWBmE=;
        b=ifBpCFofxnU0fG50VfzeqYWV/FVdgm4/xXvRmNwaB5DrCQsdJnxga0OFDewZziwmdU
         iiaWtGCp/sGIvGAodfXvRyal0ILXqF7IiWOhejTm68uxXY1pkgP05/3A3uAaWvnhBWkv
         p61UNm6L9Q9Kx2sSnIyJgc4vB9Ryotp5TxyL5v3f1x80L9llpH/jaDpdAFgq5jxSKDMz
         78HppxGR2zHrPtG4S93ZLPdkPtdixPZxP1mnlf0f64pEF2DGxk5pK1yPuS8fGgkIVOuk
         NBEoYl1W7mVO+Pa8jBxdE2sgJu0sTlv8GLsFhnoN4mEYh8H7EQaX7wdnR+AVbJHED8Bo
         Egwg==
X-Gm-Message-State: AKaTC00aHEpKMTzioet5YQNLZ2ksjdH4+TNCfK2U1EIUg0jldZ1RfdzZKa28p5Ag+xjbeVCs
X-Received: by 10.84.197.1 with SMTP id m1mr100141683pld.159.1480706271515;
        Fri, 02 Dec 2016 11:17:51 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id b29sm9469717pgn.48.2016.12.02.11.17.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 11:17:50 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, dturner@twosigma.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] unpack-trees: fix grammar for untracked files in directories
Date:   Fri,  2 Dec 2016 11:17:41 -0800
Message-Id: <20161202191741.12693-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.2.613.g22f2156
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Noticed-by: David Turner <dturner@twosigma.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

This was noticed by David when reviewing the submodule checkout series,
though rolling this as an independent fix is better :)

Thanks,
Stefan

 t/t7609-merge-co-error-msgs.sh | 2 +-
 unpack-trees.c                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7609-merge-co-error-msgs.sh b/t/t7609-merge-co-error-msgs.sh
index f80bdb81e1..e90413204e 100755
--- a/t/t7609-merge-co-error-msgs.sh
+++ b/t/t7609-merge-co-error-msgs.sh
@@ -105,7 +105,7 @@ test_expect_success 'not uptodate file porcelain checkout error' '
 '
 
 cat >expect <<\EOF
-error: Updating the following directories would lose untracked files in it:
+error: Updating the following directories would lose untracked files in them:
 	rep
 	rep2
 
diff --git a/unpack-trees.c b/unpack-trees.c
index ea6bdd20e0..7a6df99d10 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -78,7 +78,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		xstrfmt(msg, cmd, cmd);
 
 	msgs[ERROR_NOT_UPTODATE_DIR] =
-		_("Updating the following directories would lose untracked files in it:\n%s");
+		_("Updating the following directories would lose untracked files in them:\n%s");
 
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_commit_before_merge
-- 
2.10.2.613.g22f2156

