Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186C4C2BB1D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E489B2087E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Paes4l0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgDJRSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:18:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33928 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgDJRSa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:18:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id l14so1242473pgb.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sqyGoNd6vKMDymYnCsPPlXj+sY4+ST795M7cOeTa6VI=;
        b=Paes4l0OlXHGLmp8aS5vVa8pj6bMzmrNtreIVO60gfKUmJ0ZqmC81FCO/x8LqHQyv3
         WK9FKewr5vA9KISwm8HkT1zDXLWsN5ddgj2dwjVMcp9Gl2KRpDnsGRbKWjhSAgYhjt1+
         wWPhq1LIXYWS5+Vxko2kwggTrm0DUFJITt90Xum2oB8vuAO8XVqqiA8ka7yJzQbFrvfO
         cXJqHZ5TDvV6bHGPBnt5478F8cFlQF2avaCDUXwDFG6iAn2nZ5oJ0SA4ftxlz9CZSRDY
         FyGnvTbIYa5rnYF3QDZVja0keBbJWDzpffkLtGjBo3E6bpyonomcadeoxaHRanCyxkvM
         H8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sqyGoNd6vKMDymYnCsPPlXj+sY4+ST795M7cOeTa6VI=;
        b=qzIVGZeaQWj/sdwWY0oNdBKL95lu6Z5AIDBHX/VJCfyrCFejd6fEMt0V1+Yn6sbiyR
         jsC2XQBJP4tgJKmEu41TP0V8wv5AquGiV1pHUK3uZRoNBCI8bDyw6TmK/34Ib2eME0uw
         WsyF4wi2Q0o3lUp6uGu5itHZ3UyJul+T7MXegw0SmKJ0vmdd/bzPJ4MtTvlpx2gQ6I8u
         AVHkBeKkPtXkPS0aFQPMUDjfF2f8uFabc2GX/VI4jQe58rYKYrTcJeQZdXbI3gDlbaIC
         B7rB7Sd5wrAi6ItPFKs9J5IZA1YjTeseH3rkWKadkX75wpbBzAIafVzYM2aYiY/6eCFu
         rdbw==
X-Gm-Message-State: AGi0PubnT0pXoOmG6tIO211spRQnSyIOKZQS/Jw+dmbLHLgDqcsE/5+i
        GqFlQEkFm8jycwPShpmCKvewJ+xe
X-Google-Smtp-Source: APiQypJz9Em6YSii8hXKbLOj3KoglTGeFP+MvCexysBwPLpFKGwGePTV8dLIsJkM7JkeYQxhxSUR8w==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr5242194pgh.53.1586539109675;
        Fri, 10 Apr 2020 10:18:29 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s125sm1972897pgc.12.2020.04.10.10.18.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 10:18:29 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v5 05/12] ci: explicit install all required packages
Date:   Sat, 11 Apr 2020 00:18:07 +0700
Message-Id: <ac7e247bb3a7d0e639dd91f1a8a3ccc1980b913e.1586538752.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586538752.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586538752.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch, we will support GitHub Action.

Explicitly install all of our build dependencies on Linux.
Since GitHub Action's Linux VM hasn't installed our build dependencies.
And there're no harm to reinstall them (in Travis)

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/install-dependencies.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 497fd32ca8..3633a60a1c 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -7,12 +7,16 @@
 
 P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
 LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
+UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
+ tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
+ libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
 
 case "$jobname" in
 linux-clang|linux-gcc)
 	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
 	sudo apt-get -q update
-	sudo apt-get -q -y install language-pack-is libsvn-perl apache2
+	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
+		$UBUNTU_COMMON_PKGS
 	case "$jobname" in
 	linux-gcc)
 		sudo apt-get -q -y install gcc-8
@@ -59,15 +63,19 @@ osx-clang|osx-gcc)
 StaticAnalysis)
 	sudo apt-get -q update
 	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
-		libexpat-dev gettext
+		libexpat-dev gettext make
 	;;
 Documentation)
 	sudo apt-get -q update
-	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns
+	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make
 
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 	gem install --version 1.5.8 asciidoctor
 	;;
+linux-gcc-4.8|GETTEXT_POISON)
+	sudo apt-get -q update
+	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS
+	;;
 esac
 
 if type p4d >/dev/null && type p4 >/dev/null
-- 
2.26.0.334.g6536db25bb

