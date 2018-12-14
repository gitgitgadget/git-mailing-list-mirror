Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC20220A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeLOAAK (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:00:10 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:56892 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbeLOAAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:00:09 -0500
Received: by mail-qk1-f201.google.com with SMTP id a199so6541228qkb.23
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bGA5JhhxJTxS0ciEl3O+WnPTg0gGWkpdDqUPP5su+z4=;
        b=qiVo+e728c3qySJauRpScfL4IyJdkY+RDsGkGfTwuqkslPdo0AljRM4rKznCujY1/R
         xdjZxJ+pCe+p+RTQoYFAC67mpIDbTUSXhDBcOhxHO80DPcUSsW2xwofJi/ZAbWlBtImt
         2E5WHpveZc4l/KLexcg9Y91y8uw/0px4+1Pbw31D7KlhKhKkrro8gxUcv+sQEzrFJvAv
         qAR47fu+x+AYj11d549nqGaGbOtw0TXhpkwh89luvw+BYb7dwELJwS8q+bTDgFTiMT3n
         Ec6NOjNNKbxPNT88zGZrH6aDb+MI4YTWLp6466tnlg8xqieeKyOaV8VIfGqKzez3VhFt
         2/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bGA5JhhxJTxS0ciEl3O+WnPTg0gGWkpdDqUPP5su+z4=;
        b=nSDt4oLX/jg3dCC4wFM5DXNwAnQYVu8wPMnAJHeItjE48efyJo6csF765wtkGLy49L
         6KucQf6gsXVQqXpD70/iRSIFtrPXBsgb1y11mlyO2GoGxR9yNFlZ7OoZFs5FXSDeHAZO
         4lTqdCs+X0bvcwFt/MJFVr0m9gyZLXg8KpQTpRIDDSyxv31zaG4bE/1j/knStG9rLrxG
         D0JpwwfSUJViLsZ4+OsQyDQ8eD1vv5dpNxhUUZWeFCoznZZGlVzDEFIObqgwfmziQzVs
         ocm/dB3Qfusj2U66krcBUQC9KNFrcB5EbGj3aRQyYTxJzXXCQWz+2liocraOon/iFEdd
         r31A==
X-Gm-Message-State: AA+aEWZSG1K0kxVIAXASaMkHl9zlGMAfh3GbythVME3nWC8/XAAlLquU
        U2u+1b5MJI2zXlASvVQa85r/TNMI1tg0
X-Google-Smtp-Source: AFSGD/Uc/hNuiqurDuWGjadFt69ySukuxvXKUz2Qpi7s16JFJgfX4neR9g5VFApZo1g4DKCoxZHVuFcD77Yz
X-Received: by 2002:a37:2b0d:: with SMTP id r13mr4887637qkh.38.1544832008641;
 Fri, 14 Dec 2018 16:00:08 -0800 (PST)
Date:   Fri, 14 Dec 2018 15:59:42 -0800
In-Reply-To: <20181214235945.41191-1-sbeller@google.com>
Message-Id: <20181214235945.41191-2-sbeller@google.com>
Mime-Version: 1.0
References: <xmqqefas8ss4.fsf@gitster-ct.c.googlers.com> <20181214235945.41191-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 1/4] submodule update: add regression test with old style setups
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As f178c13fda (Revert "Merge branch 'sb/submodule-core-worktree'",
2018-09-07) was produced shortly before a release, nobody asked for
a regression test to be included. Add a regression test that makes sure
that the invocation of `git submodule update` on old setups doesn't
produce errors as pointed out in f178c13fda.

The place to add such a regression test may look odd in t7412, but
that is the best place as there we setup old style submodule setups
explicitly.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7412-submodule-absorbgitdirs.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index ce74c12da2..1cfa150768 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -75,7 +75,12 @@ test_expect_success 're-setup nested submodule' '
 	GIT_WORK_TREE=../../../nested git -C sub1/.git/modules/nested config \
 		core.worktree "../../../nested" &&
 	# make sure this re-setup is correct
-	git status --ignore-submodules=none
+	git status --ignore-submodules=none &&
+
+	# also make sure this old setup does not regress
+	git submodule update --init --recursive >out 2>err &&
+	test_must_be_empty out &&
+	test_must_be_empty err
 '
 
 test_expect_success 'absorb the git dir in a nested submodule' '
-- 
2.20.0.405.gbc1bbc6f85-goog

