Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7486C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBDB22241
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fnk+Q2f7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgIPMWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 08:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgIPKcf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 06:32:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1638C061356
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so2247994wmi.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k7Y9sPiZ1Y8YmAdku6q80S+Hjg5mNS1POXOalY8tmXM=;
        b=Fnk+Q2f7Iub+oGuha+WbOREJ+p463sQ3eRzkyOjZB7r6vvZJJWNaerF4Y/MVIn0ND3
         cg3mkEfsvPukNHjzyWiEWqHYUgDL5AbUzPvmb/8SSWKZkQfiZgQHQt+S3rnuBoXuHwfK
         BTmALF0rEmAoB5ubloUNke8+K0b6vmIrJwFKc/DndkXczP192hggfJvAgbBoTWkGoUY3
         7XJUMvpS8u7pqC+I3VLnWoWZiExp2/DeDIo15BZbYTG99m0BH4lq9pbDmcoLaAlOie2C
         qGvvDmq+czFRQ1O5JJWKl7ngxOTdIKqLFCtNinDk1tTzGfATlqxzdWy0iKbbityAQrwY
         SFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k7Y9sPiZ1Y8YmAdku6q80S+Hjg5mNS1POXOalY8tmXM=;
        b=AR9bBtp3rH0lnSaDn/4K6kVthkqgEShpnBzJpmQJewclsBmba3FwMxy/jisP2cu+zl
         JVSmW+zi+xqxfxrlVS7G6iq/JCoJCmv0KkuBFaEQ07cIGLySApHuUMnbu1feRMBtoocJ
         Nn2dmEJmGobyKK0c5DGJdoAC8FmfSPGwq4uXEBcvAsB8ovqLpYJsPpvwbHUuVf3/A0c4
         3D3rBCXhAbeLplnghS7lPjjmKqtReQl/2y83Hf1KtXU2CMOvCISiF1kB1ooS78Gu2jlh
         xo5/AYH4Wmd8YSa3NsIA55r2Ta3ZOnqoliqfllwD3V7+YgHxUdM/6fPFZXvA2BpGkatW
         3xvw==
X-Gm-Message-State: AOAM531Pz/7EU5BjqxhpQlOJk8aJuf8aJYn7qnNDaQOsGFxVw1ZM8Q4G
        EqAEOTA/Hb1KmbGVR+sdjKkxuQXowMw4EyBe
X-Google-Smtp-Source: ABdhPJzq3UI0zTf0birCnM7gyo5Tm8N0wIcW/tN7qs/a7YGGcUeoB3KnaUo0GzSame9B9jLlvBN0Lg==
X-Received: by 2002:a1c:bdd4:: with SMTP id n203mr3912650wmf.119.1600252208344;
        Wed, 16 Sep 2020 03:30:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm32172916wrx.91.2020.09.16.03.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 03:30:07 -0700 (PDT)
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
Subject: [PATCH 09/15] remote-mediawiki tests: use "$dir/" instead of "$dir."
Date:   Wed, 16 Sep 2020 12:29:12 +0200
Message-Id: <20200916102918.29805-10-avarab@gmail.com>
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

Change UI messages to use "$dir/" instead of "$dir.". I think this is
less confusing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/test-gitmw-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/t/test-gitmw-lib.sh
index a466be8f3f..aa04ebfd0f 100755
--- a/contrib/mw-to-git/t/test-gitmw-lib.sh
+++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
@@ -343,10 +343,10 @@ wiki_install () {
 			"http://download.wikimedia.org/mediawiki/$MW_VERSION_MAJOR/"\
 			"$MW_FILENAME. "\
 			"Please fix your connection and launch the script again."
-		echo "$MW_FILENAME downloaded in $(pwd). "\
+		echo "$MW_FILENAME downloaded in $(pwd)/ "\
 			"You can delete it later if you want."
 	else
-		echo "Reusing existing $MW_FILENAME downloaded in $(pwd)."
+		echo "Reusing existing $MW_FILENAME downloaded in $(pwd)/"
 	fi
 	archive_abs_path=$(pwd)/$MW_FILENAME
 	cd "$WIKI_DIR_INST/$WIKI_DIR_NAME/" ||
-- 
2.28.0.297.g1956fa8f8d

