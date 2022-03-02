Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25587C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbiCBR3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243831AbiCBR2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:28:30 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C93DF9B
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:27:34 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so3266162wmj.2
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZxKgkV3DVbuKgapAZ1Rbuk7060U/0rZJjX6KXsUJmGo=;
        b=P9JZpuMgyIJ+RtXNexs1MWbrIuJ2bD96w4bTPOZgkw1LF+ipOsn7DqwP+rhzTPf9dZ
         zj4UX2lurxmnYFQvc3qRt39GGnA28QVB8744FGSHlcOGbbCXyTVx5HcyEYL0M6x4FhIB
         4DaoICQHXbgFWCLdVw4FU6+W8ydWxkr2rvi1HgFxUVMZ3ExW3EtnDDbruuEtQGWmD3gG
         0vWBXp81tc2n0JCbXdVtoTY4oncOUzyRiNheVyOVDM7ogOJgKpsZ+k3Q4H2zEsFFLLxc
         02nggMytbgUzqFRnbim72QHcOtC2OblBJqzXdmPEPI1Usx6R2iHD7d4ctluH3pWOWEz7
         e5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZxKgkV3DVbuKgapAZ1Rbuk7060U/0rZJjX6KXsUJmGo=;
        b=TS4cljHGVUDZ89Ysie49OV89FgjEJUcx+6AxwRF/VEfv237A+g4EIO+LoY0Wjo/L3K
         b8z9M8wXHQNNBmyGZOVeWLI7cQ5lE2zYIVmjL6bcEe7U2G0PQmzJ2JiqHCAA1RQjph8U
         F1/N0YLG7TQYO/2MqMl6uOEsAHwqSP3OBnbkJWP+njfuJjaqWuXJV1DuLORbP3YMNjLC
         wIhFCYHfAgtFRTa6ZRLk6xFya+04LEVTIZUGwOl3d+rSDwom6HnYip3bt8lA06EyqTRt
         KGIrwIV3/+2PSS5yb6FG6Imr4D6UjNSBxC2dmM1fCRLmYnvvtnrhvb2wIDpiMg35PXWE
         KuBA==
X-Gm-Message-State: AOAM532c7BxSIw4mnLPFSu9GrS+lM7PikSUcDbxhEqdT9QPvfssr4k0E
        LHCXIroV3NyOkpRpxh4BbVMXXi2R3FKU4Q==
X-Google-Smtp-Source: ABdhPJzTkdsqdjscPN7hA+ZN1hFDVVnIT84v6dbqHBRW//VSwvxTsicN0KpibcRdUbWvFZQ8paySNA==
X-Received: by 2002:a7b:ce83:0:b0:37b:f1f1:3a0c with SMTP id q3-20020a7bce83000000b0037bf1f13a0cmr698273wmj.10.1646242052660;
        Wed, 02 Mar 2022 09:27:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm2537377wrr.88.2022.03.02.09.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:27:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/15] read-tree tests: check "diff-files" exit code on failure
Date:   Wed,  2 Mar 2022 18:27:12 +0100
Message-Id: <patch-03.15-5f02e30d1ab-20220302T171755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1226.g8b497615d32
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an issue with the exit code of "diff-files" being ignored, which
has been ignored ever since these tests were originally added in
c859600954d ([PATCH] read-tree: save more user hassles during
fast-forward., 2005-06-07).

Since the exit code was ignored we'd hide errors here under
SANITIZE=leak, which resulted in me mistakenly marking these tests as
passing under SANITIZE=leak in e5a917fcf42 (unpack-trees: don't leak
memory in verify_clean_subdirectory(), 2021-10-07) and
4ea08416b8e (leak tests: mark a read-tree test as passing
SANITIZE=leak, 2021-10-31).

As it would be non-trivial to fix these tests (the leak is in
revision.c) let's un-mark them as passing under SANITIZE=leak in
addition to fixing the issue of ignoring the exit code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1001-read-tree-m-2way.sh   | 6 +++---
 t/t1002-read-tree-m-u-2way.sh | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index d1115528cb9..0710b1fb1e9 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -21,7 +21,6 @@ In the test, these paths are used:
 	yomin   - not in H or M
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
@@ -38,11 +37,12 @@ compare_change () {
 }
 
 check_cache_at () {
-	clean_if_empty=$(git diff-files -- "$1")
+	git diff-files -- "$1" >out &&
+	clean_if_empty=$(cat out) &&
 	case "$clean_if_empty" in
 	'')  echo "$1: clean" ;;
 	?*)  echo "$1: dirty" ;;
-	esac
+	esac &&
 	case "$2,$clean_if_empty" in
 	clean,)		:     ;;
 	clean,?*)	false ;;
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index ca5c5510c73..46cbd5514a6 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -9,7 +9,6 @@ This is identical to t1001, but uses -u to update the work tree as well.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
@@ -23,11 +22,12 @@ compare_change () {
 }
 
 check_cache_at () {
-	clean_if_empty=$(git diff-files -- "$1")
+	git diff-files -- "$1" >out &&
+	clean_if_empty=$(cat out) &&
 	case "$clean_if_empty" in
 	'')  echo "$1: clean" ;;
 	?*)  echo "$1: dirty" ;;
-	esac
+	esac &&
 	case "$2,$clean_if_empty" in
 	clean,)		:     ;;
 	clean,?*)	false ;;
-- 
2.35.1.1226.g8b497615d32

