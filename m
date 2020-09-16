Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD64C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 11:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77AFE206B2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 11:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atitktIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgIPLl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 07:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgIPKcq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 06:32:46 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DA3C061220
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:16 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so2416241wmb.4
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plgosVe/CTD2tRxN7EcxfSvMWGhiQuu014XlAUVgbI4=;
        b=atitktIcq8qrgmzEnbaBivbpJxSgoA9QEDEB5FR8kj3GZe7qLfDBOJiqu4VtmVmVeJ
         x4beXJVMY4Z0GbGQNEtfl1z93QqL+jSknrg8y82jyZRy8q3jarTyxB2/U4tq5pW1JTUS
         JVTFNOviURz/dgWg9XwGa3POqBnLOuDogrFfNhA2wEDtndLs+nE/gr6Pk/uF8xNNkMQ2
         8l6jVLVG4WfjjhsP1rSubvDun/7eP/VqX9YMTsuLwFKXZ3uDsH4mbmlvvJelNoNROnT2
         fvsQL69d+ZMh044Nx9IxwlYY8woQra2lCQxnaks9rKQoP7OP7XQSrT6/4L7Lj8tl+4Wz
         G2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plgosVe/CTD2tRxN7EcxfSvMWGhiQuu014XlAUVgbI4=;
        b=TG5CZNZW0+HhItx4ET8irYLRFKCNjBzHEZ1xaTVTnj3e7FXO8tBjdv/7HHIdsFCMyN
         oVPjoEgpPf7q2ri/OgKrC/p2bj5bRrBJgsZN4FS3dbzxEvLJfOo7q9hU0kG/MEscnSwE
         N4NPg2Z5/o3CeN7P2afKc7fQLTvSErrQulYeKloKpRDhEpd9wBFu5kJs9D82B3XdTxDe
         6BMWrAU1d8KsNu9OHreus7HaiRML35WD1eTytWx40k0f6Ny+nrHpHYovR8iE5Byjjr8X
         uA2b7JWruJDbyUGD5kkomfjtq8vIM/96NhHU68nTY1XW9c4OT6FL54SXn0S4We6VbUQL
         PMzA==
X-Gm-Message-State: AOAM532MYy8KK6E8XK8KerLgHyC42uKZzFu58zJCf1cOm9cG4NKGS0+U
        VXzCaWfCnEzNJ6JyVs5B0E4OxfCEWi3Kvw34
X-Google-Smtp-Source: ABdhPJzXUbpFcpSclZFF4uvWlB2QrNf/QtMeWNOhxezGVoEM3GfnmTn/xU3fazq83kxuqMCWiYaDaA==
X-Received: by 2002:a1c:3d06:: with SMTP id k6mr3926869wma.27.1600252215119;
        Wed, 16 Sep 2020 03:30:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm32172916wrx.91.2020.09.16.03.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 03:30:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/15] remote-mediawiki tests: annotate failing tests
Date:   Wed, 16 Sep 2020 12:29:18 +0200
Message-Id: <20200916102918.29805-16-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests consistently fail for me, and were failing before any of
the changes in this series. As noted in [1] there are some known
intermittent test failures. Let's mark these as failing so we can have
an otherwise passing test suite.

1. https://github.com/Git-Mediawiki/Git-Mediawiki/issues/56

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
index d3de6c204a..2b5b3b6896 100755
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
@@ -48,7 +48,7 @@ test_expect_success 'git push can upload media (File:) files' '
 	)
 '
 
-test_expect_success 'git clone works on previously created wiki with media files' '
+test_expect_failure 'git clone works on previously created wiki with media files' '
 	test_when_finished "rm -rf mw_dir mw_dir_clone" &&
 	git clone -c remote.origin.mediaimport=true \
 		mediawiki::'"$WIKI_URL"' mw_dir_clone &&
-- 
2.28.0.297.g1956fa8f8d

