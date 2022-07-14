Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923BBC43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 19:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbiGNTkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbiGNTj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 15:39:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5D0BCBB
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:39:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bk26so3890391wrb.11
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RGDbRm9Pks4vmfqob4fy12ZJBmfseF25WvQRYLgkgLk=;
        b=HOWI471MjGHi82luuKkDE2RMPj/ENxol+svQeRhYjiboBPsrzCONENYCmmw1jaHHxI
         tcC6kqjKx04yMntj0/o982qL+VJs9pc8f9qMlTESbUBk3Rh8jQyvL8XjrvaB+CKKfmgJ
         Y7/Fj2JXSS8+7jBzRje2+IvBA6GMbpjgu+DnRc11JO7Q4qntUIPUbvfJWkjvw2UqMNE2
         3hv1qkWVMvrouTeDH35qWzNFdMNIk5hGRV6IdvJHvPYYvOOKV4P2YlOJDtZZU/UgBT7z
         10oenG9Mtm6WBOB/Ssf5b0nDFAr3VChJ+mMMq7Juj4SuSoIoNkJ8Q2PYHkx1O+KBLZup
         69jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RGDbRm9Pks4vmfqob4fy12ZJBmfseF25WvQRYLgkgLk=;
        b=OKUA4D8pZM/pHo4U6UFqWSEdNLnab4fd4Hs01RJ1SXvvAGBFHkQsPBstoDU8OuyBkV
         GoRvLTXpuwh+3Oeo4ztEsqh8S/puZBt6rE3p4yc8GiWAQR/TKbhYuQJKBgnzE0eDLE1P
         bXYrd0BNWX2TZoE40q+mbe1sp1pBMHBOKt9jlPd1tLUjWobFZD1U9fVyOzfhHS/5MME7
         Izf/EQOLVgy83AMROlssxZROGSp5R2IsVuLCJH+QqJhGPElJLtOkEXhHgBYBrVYQRD7D
         7UgFn6+h+naEGi/+Ff3SnDF4Y4pGJTzWLLzvezGXOZQpCp/EGVfBUPritW6eSndjg3/5
         Ymqg==
X-Gm-Message-State: AJIora8aEq5ffc8+/1F+b5Gj1idBmn/nVyGyFefslPJiRc618KFDFvcG
        rldx5Yg+JyxoGLmhLjqCx7mqX2/K0LsRFA==
X-Google-Smtp-Source: AGRyM1uuXDGnpPai6MNMbywy4mg6ZdfbLLQaXvYaLnlaG/4379mpa+Lon+nurT59iEMVt4BbK2wcgw==
X-Received: by 2002:adf:f9c3:0:b0:21d:7b3d:d924 with SMTP id w3-20020adff9c3000000b0021d7b3dd924mr9774196wrr.536.1657827596796;
        Thu, 14 Jul 2022 12:39:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600018c900b0021dac657337sm2145145wrq.75.2022.07.14.12.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 12:39:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/10] CI: make "$jobname" explicit, remove fallback
Date:   Thu, 14 Jul 2022 21:39:41 +0200
Message-Id: <patch-04.10-5d1df78d0de-20220714T193808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.996.g651fc6e809f
In-Reply-To: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the $jobname fallback last adjusted in b011fabd6e0 (ci/lib.sh:
encapsulate Travis-specific things, 2019-01-27).

This makes all of our CI jobs have an explicit $jobname, and removes
the special-case of the Windows jobs implicitly setting one (that they
don't currently use).

This is a follow-up to my 25715419bf4 (CI: don't run "make test" twice
in one job, 2021-11-23), since then all the jobs except the Windows
jobs have had an explicit $jobname.

In the case of the Windows jobs we were using a jobname of windows-gcc
for both, due to picking "gcc" as a default fallback for "$CC" in
ci/lib.sh.

Since we'll need this to run ci/lib.sh it makes sense to move the
check to the top of the file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml |  7 +++++++
 ci/lib.sh                  | 12 +++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index cd1f52692a5..8b7697df9fb 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -79,6 +79,8 @@ jobs:
 
   windows-build:
     name: win build
+    env:
+      jobname: windows-build
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     runs-on: windows-latest
@@ -100,6 +102,8 @@ jobs:
         path: artifacts
   windows-test:
     name: win test
+    env:
+      jobname: windows-test
     runs-on: windows-latest
     needs: [windows-build]
     strategy:
@@ -134,6 +138,7 @@ jobs:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     env:
+      jobname: vs-build
       NO_PERL: 1
       GIT_CONFIG_PARAMETERS: "'user.name=CI' 'user.email=ci@git'"
     runs-on: windows-latest
@@ -183,6 +188,8 @@ jobs:
         path: artifacts
   vs-test:
     name: win+VS test
+    env:
+      jobname: vs-test
     runs-on: windows-latest
     needs: vs-build
     strategy:
diff --git a/ci/lib.sh b/ci/lib.sh
index fcb79c83087..969ba2ff0d0 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -8,6 +8,13 @@
 # are installed.
 set -e
 
+# Starting assertions
+if test -z "$jobname"
+then
+	echo "error: must set a CI jobname in the environment" >&2
+	exit 1
+fi
+
 if test true != "$GITHUB_ACTIONS"
 then
 	begin_group () { :; }
@@ -119,11 +126,6 @@ else
 	exit 1
 fi
 
-if test -z "$jobname"
-then
-	jobname="$CI_OS_NAME-$CC"
-fi
-
 export DEVELOPER=1
 export DEFAULT_TEST_TARGET=prove
 export GIT_TEST_CLONE_2GB=true
-- 
2.37.1.996.g651fc6e809f

