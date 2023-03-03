Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F28C678D4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 13:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjCCNrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 08:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjCCNrB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 08:47:01 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BD95A6D7
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 05:47:00 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so2317023pjz.1
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 05:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUP9l/VnRgfTpbHyFC1ulZFIyi30PvF+dP+5HiynElY=;
        b=moO1uliuByV9l1cVu3JNjZ4vU7ggPRxvkv1a9V0XqFx4+BpM7kYteqxI++Cy5pFvO5
         zGUuMI9TXlAQuYmtxFrwps7agTWi4uv+ZaPmGZL9oxqO7fkHvMg4I2I8CtSaMLmthOTj
         i1taUOt0pIOAR1Lm8MR/nx7ZFw2NSClGVb8YKBacWEOix6juPOTq/JiNMP/DCGlsuZ2n
         D5evgl7OIAABx3A96SFYfD67FoW62PI8S3F7jL/7ixw5IgLf5Pq4CbNMwQa0mKTpkIhP
         /Na4xtnNw7+adLpWk8Gh0AaFJ90CvA5aMAxCTd0I8cN87JA5fX5lXtyfOE86VyakzHNv
         ld2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUP9l/VnRgfTpbHyFC1ulZFIyi30PvF+dP+5HiynElY=;
        b=NjS4G0tdEHDktJzTVBjfcOwN8D9/Sk2gt5Vl9dKow9uKIz8InFnrbzkbO35YI3tWRV
         kDirajGYJskn26qu7DfY7OrhL7AoBdyXKUl8gjecSxn4lkOBEakVaLZSPv+uUHYv4DTC
         njyH1DgsGb3ddkttdHuKpERvQP5Khl2PphOnpdMoC7OnIk/VQ/aVK+iMtN8pnFBj3oCL
         9roTali5zv0p0QsWRjbQERF7QFqcZ+TzsWBNgXMai4895lfQo2hHbfPqbETZ1t2os6mP
         A5OeidNVyxBHT9g/d/Et/RnaIV+wVO8yZOL7mTVPzvw0yZjFq4P5m7qlnaxBpvEYupt1
         F5NA==
X-Gm-Message-State: AO0yUKVUTBldKkDEQyOlXVhEkW/TqaBpqzWyli8XtG7LBeHpXb30PlQW
        73rS936FMhzRDlzweBjN5GXD85U+lUk=
X-Google-Smtp-Source: AK7set95A/CHjWhH2JwyqXBtTdUV2M/xtik39l3H1t/sZ95yt25nRa8BL3U6LwK+Bo2oYhQq22ja/A==
X-Received: by 2002:a17:90a:184:b0:233:bc78:b47f with SMTP id 4-20020a17090a018400b00233bc78b47fmr1585502pjc.49.1677851219475;
        Fri, 03 Mar 2023 05:46:59 -0800 (PST)
Received: from localhost.localdomain ([113.172.118.59])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090aab1500b00234465cd2a7sm1536138pjq.56.2023.03.03.05.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:46:59 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 3/4] ci/install-dependencies: install git-lfs for arm64 build
Date:   Fri,  3 Mar 2023 20:46:05 +0700
Message-Id: <f8663249619f519157a19a2fa8f386dbbe23faba.1677850518.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.2.gd15644fe02
In-Reply-To: <cover.1677850517.git.congdanhqx@gmail.com>
References: <cover.1677850517.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/install-dependencies.sh | 4 ++++
 ci/lib.sh                  | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 9a32af8968..6d587ffc54 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -44,6 +44,10 @@ ubuntu-*)
 		_install_linux_git_lfs "$LFSWHENCE/v${LINUX_GIT_LFS_VERSION}" \
 			"git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
 		;;
+	aarch64)
+		_install_linux_git_lfs "$LFSWHENCE/v${LINUX_GIT_LFS_VERSION}" \
+			"git-lfs-linux-arm64-v$LINUX_GIT_LFS_VERSION.tar.gz"
+		;;
 	*)
 		echo "Not supported architecture" >&2
 		exit 1
diff --git a/ci/lib.sh b/ci/lib.sh
index 661076e70b..3c19267a56 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -242,6 +242,12 @@ ubuntu-*)
 	# image.
 	# Keep that in mind when you encounter a broken OS X build!
 	export LINUX_GIT_LFS_VERSION="1.5.2"
+	# The Linux arm64 build installs yet another recent version, since
+	# above version doesn't ship prebuilt binaries for arm64.
+	if test "$(uname -m)" = aarch64
+	then
+		LINUX_GIT_LFS_VERSION="3.3.0"
+	fi
 
 	P4_PATH="$HOME/custom/p4"
 	GIT_LFS_PATH="$HOME/custom/git-lfs"
-- 
2.40.0.rc1.2.gd15644fe02

