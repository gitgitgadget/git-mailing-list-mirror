Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9708C43463
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7764720EDD
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmShilif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIUKk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgIUKkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1232C0613D2
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id s13so11610012wmh.4
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HY/s6btilBiHxm7XmkpDhMi8FrcgDs5f+o5rrOAdyuc=;
        b=pmShilifc9v9jUTGgLF9n+3GoSZJJ1L8PGSMu2rmHgY5m7RuJjypN1Trq3enLpD2N7
         m42CdQSfrBM6QcYXyLbWS8QUyRgvqa1nWLkzua6Jl+1HtxFautIU2++6nlM5WmzgntvS
         dvyaoAW3qDC7CskUuLnhn62hNl/sMWUKRI2Fc8pAndjtJSLaCXjDBwQWJ+M0dinHohNd
         eHiqnBqD9XkkWR+oBFEs5kG4WYQVMlRRAb/HZlHiVpUW9ndrid2bGSouaMA9xwrBf6o5
         fdKDDazq29CsK/qqL0LD7fUo1i6JYJi8DKxno+4nd68rhhyZopDdZPko/J4YUF2Pmsu1
         ncSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HY/s6btilBiHxm7XmkpDhMi8FrcgDs5f+o5rrOAdyuc=;
        b=eXpfS+1WXRR6/2VdbF6rYSGi182XHcrfuzfzA2Opvzbkz+vGNIR7smz+IBXJPSizMF
         tMm1mYf8iwy1dm5+Csw7xGyHER1QtwLp8/4ewBG9U9rbfyJLyOVdOE/W9SA9fh9WUYUx
         nX7eZItnVoj8jHoqRMZUkNWkMRJq4EAqtBN3kTmBezGL2RTwYEOoXP8kQN9LI4ZPJXww
         yPNZGKI7Yeb41wbEWHnu8w9OdGV4sMcI0YXNsq0K00FZgU8MgADHui8998f7CC7Qaf7u
         TlwChqivkol5Rk56RExiQ9SkTXRMcg5UutywHZ7R2uNDrJ2Cgd+biNHdQhwCQ//YYwXE
         AiTA==
X-Gm-Message-State: AOAM530HBnpIj9cSMPFRxpBwzDa5W8uONKSiSvdbAqxaZRRmvqONt++l
        YUwUZ9/zcrqLpV9uTKV7JEJ2ZI5aQaiIgA==
X-Google-Smtp-Source: ABdhPJxCp2tcxkBuWISB2W0rzqXlxsPI3ECcIrWJPnTY9sqw7m85SznI1wdL9hkwxLbsyY9I8bfhAg==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr28928194wmh.74.1600684823138;
        Mon, 21 Sep 2020 03:40:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:22 -0700 (PDT)
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
Subject: [PATCH v2 08/18] remote-mediawiki tests: use "$dir/" instead of "$dir."
Date:   Mon, 21 Sep 2020 12:39:50 +0200
Message-Id: <20200921104000.2304-9-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change UI messages to use "$dir/" instead of "$dir.". I think this is
less confusing when referring to an absolute directory path.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/test-gitmw-lib.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/t/test-gitmw-lib.sh
index a466be8f3f..eb45a5a641 100755
--- a/contrib/mw-to-git/t/test-gitmw-lib.sh
+++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
@@ -343,10 +343,10 @@ wiki_install () {
 			"http://download.wikimedia.org/mediawiki/$MW_VERSION_MAJOR/"\
 			"$MW_FILENAME. "\
 			"Please fix your connection and launch the script again."
-		echo "$MW_FILENAME downloaded in $(pwd). "\
-			"You can delete it later if you want."
+		echo "$MW_FILENAME downloaded in $(pwd)/;" \
+		     "you can delete it later if you want."
 	else
-		echo "Reusing existing $MW_FILENAME downloaded in $(pwd)."
+		echo "Reusing existing $MW_FILENAME downloaded in $(pwd)/"
 	fi
 	archive_abs_path=$(pwd)/$MW_FILENAME
 	cd "$WIKI_DIR_INST/$WIKI_DIR_NAME/" ||
-- 
2.28.0.297.g1956fa8f8d

