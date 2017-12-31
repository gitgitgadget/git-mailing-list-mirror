Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 534C71F406
	for <e@80x24.org>; Sun, 31 Dec 2017 16:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751111AbdLaQCb (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 11:02:31 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33693 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbdLaQC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 11:02:29 -0500
Received: by mail-wr0-f193.google.com with SMTP id v21so34490068wrc.0
        for <git@vger.kernel.org>; Sun, 31 Dec 2017 08:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fzIIPVPaRDmN5SfEHda2p4tmC/ghsvZjpigZDPuHBeo=;
        b=sC2A/IIz2flrZWWNoZeb8psUDzkiMjOSpmgaK9kz5k8fJ4MBpQLne+6zdwSUTUx1kx
         Z8CueEHd/a3gNC5aA+4bYbziE3HzTARx3HC1Ldg+Iri3RNod+HUeze3XdEEE3CgMFHGK
         +J6A8Z5qSiFjPMnEmqSWkJexYDKFmams1cnQUWSdG5o3YPxlOaefKYBRI6D5a0dt1yH8
         iidYlbrg4K0HlpfEyxn1hrBq7ngmVVAqfSsCP/A5KdnbTmkWtm1q2CBEM/ZbFT0Rulge
         vFXMIoJ6EUqI5k+hCoSOO+9j+jvPoMfUHjd2vSOIWiFXDyWYeZDil1Z6Hwj1zQXmh9bF
         +ySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fzIIPVPaRDmN5SfEHda2p4tmC/ghsvZjpigZDPuHBeo=;
        b=oLvUwp7+2s+B4a7CtDhmDWcXF645iBnSL8DVm/q4IgD5qGmzIa7300O9CDEEfie8wF
         H2KIYyyScZKpS6qnMNyGQXRqdfudKqP6WFtxOQHo+Orl7Y1vZyJjctAHoc7PQbn1ZImz
         pmBazpJ7J5i4PydGpBRX4XKYHoJBkOv422KQiLWBALvc0zgQmvl1Avnm6WOXTjRqigN6
         VXFiQknDvjfJF9Gm/o4bQKmylKI7H0p3tFsfzoZ2K+SDoir4eVPtPBWU0hMJVvn49YyR
         ZGVdNcfPnWnaLNSu8Nwq4WlGbyzQi0NMvBuaqeU/ZSdAtozS6/4hXlAdrocSzX/GO9G+
         kOZw==
X-Gm-Message-State: AKGB3mJC/ryxIroAvCGT5q8fPlfuVqWVOmytMfu6c5DVDCe2g4VAH/FM
        PHXqAkoO+czrs6VILkkAFlYe4A==
X-Google-Smtp-Source: ACJfBovv3bPDX+3STlopmPkOUptuk/aXtbGoCSr48e1PznsTPDWFmGkk3iReOT02vX5wF9GTEVsJGA==
X-Received: by 10.223.176.141 with SMTP id i13mr37817316wra.257.1514736148503;
        Sun, 31 Dec 2017 08:02:28 -0800 (PST)
Received: from localhost.localdomain (94-21-23-100.pool.digikabel.hu. [94.21.23.100])
        by smtp.gmail.com with ESMTPSA id x88sm12906174wrb.4.2017.12.31.08.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Dec 2017 08:02:28 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] travis-ci: don't store P4 and Git LFS in the working tree
Date:   Sun, 31 Dec 2017 17:02:05 +0100
Message-Id: <20171231160206.19481-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.67.g3a46dbca7
In-Reply-To: <20171231160206.19481-1-szeder.dev@gmail.com>
References: <20171231160206.19481-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Clang and GCC 64 bit Linux build jobs download and store the P4
and Git LFS executables under the current directory, which is the
working tree that we are about to build and test.  This means that Git
commands like 'status' or 'ls-files' would list these files as
untracked.  The next commit is about to make sure that there are no
untracked files present after the build, and the downloaded
executables in the working tree are interfering with those upcoming
checks.

Therefore, let's download P4 and Git LFS in the home directory,
outside of the working tree.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib-travisci.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index bade71617..1543b7959 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -99,8 +99,8 @@ linux-clang|linux-gcc)
 	export LINUX_P4_VERSION="16.2"
 	export LINUX_GIT_LFS_VERSION="1.5.2"
 
-	P4_PATH="$(pwd)/custom/p4"
-	GIT_LFS_PATH="$(pwd)/custom/git-lfs"
+	P4_PATH="$HOME/custom/p4"
+	GIT_LFS_PATH="$HOME/custom/git-lfs"
 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
 	;;
 osx-clang|osx-gcc)
-- 
2.16.0.rc0.67.g3a46dbca7

