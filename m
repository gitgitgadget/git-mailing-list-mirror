Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5771F453
	for <e@80x24.org>; Tue,  5 Feb 2019 19:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbfBETw2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 14:52:28 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42339 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbfBETw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 14:52:27 -0500
Received: by mail-wr1-f45.google.com with SMTP id q18so5009851wrx.9
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 11:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r0vCoB1UXp3t6QUqSpgkr4X28l+gFcCZOfqUbcxYVwM=;
        b=nMQQm+FmFxATZTK5Nop1PtFeHPpcZUtl7aGuNHLDSomVKBSM62eUO+DYf+Ld1Dxfrl
         zNKyioJZIpa92phBowNv7TGC1SsQVj4yUXaXrBDlXEdJdDA/ixPPf4YvcHrEdSc9cY+S
         59zK9FMwzw8afsJTwZ1mdaJwStF558ODomARH1SryPzuFC4E5VJ/1uBJwLQ9ppw7zgmT
         nosq8DQU5vWjotaPlWng7rgNjTg7bWKW+VeAPnLXkK5yoTl6o7Lp1rdqywr1N86ffGAK
         M0eUMC6ZgFya0NDvFJjpkHNYQmNaxMNT7NREaT3KG8CdR5V27Fp43zP7o6CEYNUo8J/f
         o7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0vCoB1UXp3t6QUqSpgkr4X28l+gFcCZOfqUbcxYVwM=;
        b=KN0N1LDS8jEH45Kd3tbBd8L7cuqMFLM2AF1aHlthkUjf4aerSv/ODc6l6bfDm9uNPO
         oxLaXHKRGoajsrtSC3D6YTNOaQVfw87fdDlHv3leoT4sFLmsRe+6sf7cMuRwzaXerOln
         AP+pMi7wn15ySs+QCqZjiOhlqf1ctESjAusXBfZk7GViYBbTXuLuXYUtk9tOZW899RkB
         VwXBfPpaRcFefkYf9P9fEHao2w+xj0nCYm+N3y87a345KIRAPIcSgJdBKCwO+d9qhZoQ
         2G1Qtd4gGWpuwP7GCub0S12/TGOHzjpN35Qi4VJTrogwjKSftEalTD2Vx3ryXLomJz3z
         rkWA==
X-Gm-Message-State: AHQUAuZtDjPbD2zpEJy3+nwGyPryD6oCAnGiS2Mjdk3H290FqvUE1At6
        qEi8fPsW9EXWTSo8sHBEKS7fOKMx
X-Google-Smtp-Source: AHgI3IYht67+0zCvxzjLRd0KaP9dLBHkQOUr02Rf7wTrP+9V4kBgZi8GGcvhorhWbB3GRNR5w888sw==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr3242062wrq.297.1549396345629;
        Tue, 05 Feb 2019 11:52:25 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j24sm24022240wrd.86.2019.02.05.11.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 11:52:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        William Hubbs <williamh@gentoo.org>, chutzpah@gentoo.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 1/2] ident: test how GIT_* and user.{name,email} interact
Date:   Tue,  5 Feb 2019 20:52:11 +0100
Message-Id: <20190205195212.25550-2-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1
In-Reply-To: <20190204184850.10040-1-williamh@gentoo.org>
References: <20190204184850.10040-1-williamh@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There were no explicit tests for the interaction between setting GIT_*
in the environment, and the user.{name,email} config variables. These
tests are basic, but we're about to learn
{author,committer}.{name,email} in addition to user.{name,email}, so
they'll soon become more useful.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7517-per-repo-email.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
index 231b8cc19d..84bd9e89e5 100755
--- a/t/t7517-per-repo-email.sh
+++ b/t/t7517-per-repo-email.sh
@@ -85,4 +85,38 @@ test_expect_success REBASE_P \
 	test_must_fail git rebase -p master
 '
 
+test_expect_success 'fallbacks for GIT_* and user.{name,email}' '
+	# We must have committer in the object
+	test_must_fail test_env \
+		GIT_AUTHOR_NAME=author.name \
+		GIT_AUTHOR_EMAIL=author@email \
+		GIT_COMMITTER_NAME= \
+		GIT_COMMITTER_EMAIL= \
+		test_commit A 2>stderr &&
+	test_i18ngrep "empty ident name.*not allowed" stderr &&
+
+	# With no committer E-Mail we will have an empty field
+	test_env \
+		GIT_AUTHOR_NAME=author.name \
+		GIT_AUTHOR_EMAIL=author@email \
+		GIT_COMMITTER_NAME=committer.name \
+		GIT_COMMITTER_EMAIL= \
+		test_commit B 2>stderr &&
+	echo "author.name author@email committer.name " >expected &&
+	git log --format="%an %ae %cn %ce" -1 >actual &&
+	test_cmp expected actual &&
+
+	# Environment overrides config
+	test_config user.name author.config.name &&
+	test_env \
+		GIT_AUTHOR_NAME=author.name \
+		GIT_AUTHOR_EMAIL=author@email \
+		GIT_COMMITTER_NAME=committer.name \
+		GIT_COMMITTER_EMAIL= \
+		test_commit C 2>stderr &&
+	echo "author.name author@email committer.name " >expected &&
+	git log --format="%an %ae %cn %ce" -1 >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.20.1.611.gfbb209baf1

