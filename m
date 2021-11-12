Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D54C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 06:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60EA60FE3
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 06:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhKLG5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 01:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbhKLG4z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 01:56:55 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3385C061767
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 22:54:04 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso6179769wms.3
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 22:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OP+4cfNwQy4XWJeio2/6BsZxkX2KWh+xphdHeyg0U+E=;
        b=buDk/0AxEgiEZ734/BycBP1VSXHUbNZDOzTvBG01N2BSx1pFaUXmBm5laCIkEMjacA
         VNCr4eCUsG9PAW5cABm7gkq0FznLDwc4k+uERDbBSla5r7ZDvE9mplnxRpTNUTLHDHE6
         BRKpXImxrmR2KtOLmNmiQ8NJKAC/DLvL3lylKGWcnf1GDMGmDort9r4k6E/sVQ/+Wnf7
         zNu6ueXO/Oz85JqeGEMEddcTjRENkcbZLmonWzc+6sHBF6B3kscmf1xkDvWo8zXhDudQ
         U6grjGtRGN2JejN6dAKw4tS9arLVNIqvFmoIOhzAJmMJgkX6t+VFbku0XyIgyP/x+puJ
         RQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OP+4cfNwQy4XWJeio2/6BsZxkX2KWh+xphdHeyg0U+E=;
        b=1tMT+IaWK/Skq5OPBJDwbpvcZLp7GnaitkAhKRUJVRed7vxGf+EVtfvE3TBT22Z9VX
         IgPAuLUco1OITMyL3qwDNhLVXl3yUvIkvY3Hlp/uIDF/TnCQEUgBm+yF4UUdhUTmjUbr
         AYeNWBgQQVUfuuGOPsoNkjYm9S2emwwGFHF1NPeeGAPA3whmLAqAKsedN+wfsYewdqwp
         9BtwfK4PtdTgwAJ3pbdi2oXmnyCilJqcECcdHx3YgfNim7dg/jodBwsJWfLz4S0Hpacp
         WLOCeWdCM0oPQjzHnFesRFYh2hNtSgG70UtqKB0EqvKahmIBrDaiDHpDtffCqbdRekfS
         Uwnw==
X-Gm-Message-State: AOAM5325k3BgSrJ5SFmo4QaA3tYsalgFP1slwyX1Ei4bIyamDEjtWSlz
        p59wZpWOOidOgvjTddmH5BNQvf8m9Mc=
X-Google-Smtp-Source: ABdhPJxwH/UOvQweOWUSt8X7LOVF3F5bGyiusRsgyURggGEtgz6YcTS4sLMk4MgbMbLv3HHOPD7z1Q==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr15083330wmj.84.1636700043391;
        Thu, 11 Nov 2021 22:54:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm13545608wmq.31.2021.11.11.22.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 22:54:03 -0800 (PST)
Message-Id: <da024ced6686bfcae3e824c14ba0a7550c8317ad.1636700040.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v2.git.1636700040.gitgitgadget@gmail.com>
References: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
        <pull.1076.v2.git.1636700040.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Nov 2021 06:53:59 +0000
Subject: [PATCH v2 3/4] test: am: add the case when not passing the --always
 option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Aleen <aleen42@vip.qq.com>, Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Aleen <aleen42@vip.qq.com>

Signed-off-by: Aleen <aleen42@vip.qq.com>
---
 t/t4150-am.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 5b3617857a8..364c61ba198 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1166,7 +1166,17 @@ test_expect_success 'am a real empty patch with the --always option' '
 	test_cmp expected actual
 '
 
-test_expect_success 'am a patch with empty commits' '
+test_expect_success 'am a patch of empty commits without the --always option' '
+	grep "empty commit" empty-commit.patch &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout empty-commit^ &&
+	test_must_fail git am empty-commit.patch >err &&
+	test_path_is_dir .git/rebase-apply &&
+	test_i18ngrep "Patch is empty." err
+'
+
+test_expect_success 'am a patch of empty commits with the --always option' '
 	grep "empty commit" empty-commit.patch &&
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-- 
gitgitgadget

