Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651ADC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378355AbiBUOsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:48:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378311AbiBUOr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75264624E
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:01 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h6so27480953wrb.9
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Paw+vcgMDCBuDqlliib9ljjvXwbuiNwm5TpeoWveeQ=;
        b=GQU4czUBmdO9iLIaWtUYWXG6iC2MoZbrvnBgv+MZVc7njx3HHYUSTKSmU4Z/9yUyYn
         tc43X+eZxCgi9wmCCQrHfaH8EH2HsgfWxcNXtcErQUIRFp3prw5NpZtgAKf+YmSB9iSE
         hoY07eVoyoKFI/FxQTksAAm//Nt/J/b+pm0QPRu3VBta0xzNQ9XEwFLJnIoFqyd91yFs
         NC5UJXSPJpLlLASXi8g4rYeg7uTKGMk+BQ5LgycdQjvlH8+ujzQY8WxMqTn1Age6H1fq
         ZjqcY+aLcrD7AtTyQL/+rh0vVbUdk2jo9T/jhXkD6qonpx7z7J/04jqolzOQXKYfldHE
         kwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Paw+vcgMDCBuDqlliib9ljjvXwbuiNwm5TpeoWveeQ=;
        b=NipI3Tc9BwkxTWoFU1Wdf+F0UgsEwN9HmMWsbqaJZ2mNIbTwWsC+VtWSadlncoKXWd
         N3Ljvbu7KEKXOtdrZFkQcs07QMI0p8jIQJReiw9sjA2nVa+QO3w7+WSLyGAW5mHc0ECc
         5C/SC3QaXcBU+ufjTOC6S9r/kQXDsT2qwd6r+QSZB13V7xHLSPgj+MvcAQdG4+3oweCJ
         thO7WHePExZnlD26yBxRjdR0OprRE3U+LbAvmTH6TU63Mb/HunGnLYIh9kcwws26KlX7
         foxhd47ARJbtNRGe2PIc7i6AZdVwsmRmCdxoo+v7uhAy+xQ9pGXzwriQr4orD2jVYWWn
         XAGg==
X-Gm-Message-State: AOAM532WdIRlwr9KJARvSzvrmNmUghUJMetytf2vKdG/LF25Tam/33Bo
        6eeALoWBWjmk0+QkXUlsGokBwIwNXXaiGw==
X-Google-Smtp-Source: ABdhPJxoJG/Cirwy+Jinl7E7d93tpDTglBTF9hogap4fRB00iB6exVC1eQT+6qfb2sUWQ8wkvd1RWw==
X-Received: by 2002:adf:df8f:0:b0:1e6:8a5c:4b07 with SMTP id z15-20020adfdf8f000000b001e68a5c4b07mr16355732wrl.523.1645454819747;
        Mon, 21 Feb 2022 06:46:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:46:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/25] CI: check ignored unignored build artifacts in "win[+VS] build" too
Date:   Mon, 21 Feb 2022 15:46:25 +0100
Message-Id: <patch-13.25-46459fff296-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the newly created "ci/check-unignored-build-artifacts.sh" script
in the "win build" and "win+VS build" steps too. These steps weren't
doing this sanity check of untracked files against .gitignore before,
but as the check passes for them let's keep doing that extra sanity
check.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index c83f6a21ca3..05c5771e7f6 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -93,6 +93,9 @@ jobs:
         HOME: ${{runner.workspace}}
         NO_PERL: 1
       run: . /etc/profile && ci/make-test-artifacts.sh artifacts
+    - run: ci/check-unignored-build-artifacts.sh
+      if: success()
+      shell: bash
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
@@ -180,6 +183,9 @@ jobs:
       run: |
         mkdir -p artifacts &&
         eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts NO_GETTEXT=YesPlease 2>&1 | grep ^tar)"
+    - run: ci/check-unignored-build-artifacts.sh
+      if: success()
+      shell: bash
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
-- 
2.35.1.1132.ga1fe46f8690

