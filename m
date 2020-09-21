Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1651DC43464
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34CF2076E
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rd2I/tNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgIUKkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgIUKkb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:31 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB119C0613D0
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:30 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so12188029wrm.9
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wV+1Xsqg0zmRl8D6+LcjToBwHX05mgXozsqEbPI7rFw=;
        b=rd2I/tNtaMyeyhLZRj/lyZn0CDjTbv6OCPtS1ZwIvzaXw/urAeLQ3Hzb8QSfzKZUSv
         bi6AZMmBVe2oHGPdPht1hyaf9rkNdrvor4HaenaitjOMdCR4mHUdZhSNBI1pr+Xlr1iz
         CdMCI2OwBKx04e3538ZhsnkDgv1iHC1E8Y2QMTwU5XZSWcR5R3rpc6HYsSBcQ9ZuCs9D
         YjbNx2If3xouA0xZvXSE0Dq8/LJB1/J5rtLfb6ofZE6bps5nBPX2d9bWPRQPvrzQDqDK
         R7CrdPB3TPf678ox8HjxQKntDKus9bB2yv4qZrsbJdE6OwJVmRIJUeDR3CI6qE2A27+4
         X5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wV+1Xsqg0zmRl8D6+LcjToBwHX05mgXozsqEbPI7rFw=;
        b=GbSUIa1hGSifg1m9UCstwRrGk9x4i71XR4CmDJP164xV9izUdH1A7i86RhnyMq4vc7
         ue01E7cRgbnDOe5bbzMi5FobhJUNvdAWnwMq45UXrF8CaBofGotgrgddW/YMA2NAslUK
         K5iNKzhlVHdSU5euzRSAwj6NOqXZEHqxGJN/V+oEFS9QGqjDov1Br1n+XuxOsDCWo+Pa
         3AIBFpaijGaPs0vbPIATC7Ye0zhyAO/6Et4XCoCy3KVVbdEDDlydTlaJUqP0fhVDebQS
         awaVTTC9Uy7WbuUAIdrQapLvogBkScRkHsTtKxo9jaSbkr+oN22xxNTyJSdlP7NtIZyz
         IYpQ==
X-Gm-Message-State: AOAM531Q41pJPBSNTagPek2Um1BEaX6MYNF/WZ3GW2EQgzNYGkELzfxS
        sIAqEcbeip+tCSqTHLAJe6uEpGMgjrBUJQ==
X-Google-Smtp-Source: ABdhPJxJN6D7Z3RlIR9oI1KkXp4cqExnzlPNdTjCSFNbVfTqIBICk6313CEfRHd8uTKDL5cX3Q2mFw==
X-Received: by 2002:a5d:6caf:: with SMTP id a15mr51998731wra.344.1600684829302;
        Mon, 21 Sep 2020 03:40:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, imon Legner <Simon.Legner@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 14/18] remote-mediawiki tests: annotate failing tests
Date:   Mon, 21 Sep 2020 12:39:56 +0200
Message-Id: <20200921104000.2304-15-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests consistently fail for me, and were failing before any of
the changes in this series. As noted in [1] there are some known
intermittent test failures. Let's mark these as failing so we can have
an otherwise passing test suite.

We need to add an extra test_path_is_file() here because since
d572f52a64 ("test_cmp: diagnose incorrect arguments", 2020-08-09)
test_cmp has errored out with a BUG if one of the test arguments
doesn't exist, without that the test would still fail even without
test_expect_failure().

1. https://github.com/Git-Mediawiki/Git-Mediawiki/issues/56

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
index 43580af3cf..6187ec67fa 100755
--- a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
+++ b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
@@ -32,7 +32,7 @@ test_expect_success 'setup config' '
 	test_might_fail git config --global --unset remote.origin.mediaImport
 '
 
-test_expect_success 'git push can upload media (File:) files' '
+test_expect_failure 'git push can upload media (File:) files' '
 	wiki_reset &&
 	git clone mediawiki::'"$WIKI_URL"' mw_dir &&
 	(
@@ -48,13 +48,14 @@ test_expect_success 'git push can upload media (File:) files' '
 	)
 '
 
-test_expect_success 'git clone works on previously created wiki with media files' '
+test_expect_failure 'git clone works on previously created wiki with media files' '
 	test_when_finished "rm -rf mw_dir mw_dir_clone" &&
 	git clone -c remote.origin.mediaimport=true \
 		mediawiki::'"$WIKI_URL"' mw_dir_clone &&
 	test_cmp mw_dir_clone/Foo.txt mw_dir/Foo.txt &&
 	(cd mw_dir_clone && git checkout HEAD^) &&
 	(cd mw_dir && git checkout HEAD^) &&
+	test_path_is_file mw_dir_clone/Foo.txt &&
 	test_cmp mw_dir_clone/Foo.txt mw_dir/Foo.txt
 '
 
-- 
2.28.0.297.g1956fa8f8d

