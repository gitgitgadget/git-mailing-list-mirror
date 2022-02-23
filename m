Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DD6C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 16:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242576AbiBWQDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 11:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242414AbiBWQDq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 11:03:46 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002767DE33
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 08:03:18 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d28so12647251wra.4
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 08:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HKgoO0YXdrpxQaCTqKz3yiJBDgSCowAE1BP45GDxf4M=;
        b=bU27bWmK5Ykgk5vNYXRtoafYy+9pNMIFfSUOJ13l9VIdetdS7tcO2EZTgMPjmS2cyo
         EvD/+njGJdfvxwBB0mqYfefdv2vKk9/He18ZGMc7GqyJy60o7IwsrATQkKLPN3QWJREW
         oOdBIr/5mZbKhOe2bJuaAl17eHkNdqz+IyBcnQSrNRAH2b0rv2QBDoN+AuI2/XThrDC9
         eBbylrPfl65Tp//O97bMxpojrAw3I26pswFbyBGrwLfAmmhStw6drqytBmEmLNhBSfgd
         86pieLCRGR2IZU+VcY/wCIuDr16zGN+OEs1RndzkGoHdcBECbzit6KpK7R9buJdaPJdV
         /LCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HKgoO0YXdrpxQaCTqKz3yiJBDgSCowAE1BP45GDxf4M=;
        b=Mxe+anarxYsaeargJy+l/F3XmP0imbb+Yl1G1b1SKWMVs0dDhclnQeGmbmQRZaVXkb
         Mmr6azp7XVgqNa4qgySmcv1Rn5wFKDHKmMd5fTUg8KhE6Uj6bRfH8X81DgxlvQGA/IjE
         HA8ZgufgOm9OB6jKxOiWVKml7web6O3qwFEvHG6PpUepW+tysNZY5ZTR/8JB05NfDziS
         jyhY2vP5IjSMmpZ5XblVaQFJ38LlPJF5qyf8MfeueCH7cUgYf1wcNmvp9KOdzj+QbU+t
         X+g6kG7APxjwAueC491CwzNawAqJ9oupSGUJJ9dzzYUqlWVlZroIWx9bHpSf87+znYvP
         bUvA==
X-Gm-Message-State: AOAM5333wzd651kHC/4hmVRZEmqmzNq/ZD/mNylupMUs1Cfx21+4pvEb
        UfaZA8KfCAVarJi/6EPb5HcZS9vhbzk=
X-Google-Smtp-Source: ABdhPJwf9bJ2a1kwsVQ2Le39ZIpPOHLsjR4Y/aUDRruJ5J2DedplxxS4KDDmQIvNE00EcAk5hBfyng==
X-Received: by 2002:a05:6000:15c4:b0:1ea:78a4:9cce with SMTP id y4-20020a05600015c400b001ea78a49ccemr219115wry.375.1645632197461;
        Wed, 23 Feb 2022 08:03:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m62-20020a1c2641000000b00380d0cff5f3sm171952wmm.8.2022.02.23.08.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:03:17 -0800 (PST)
Message-Id: <43990408a10d65058d872f13ea9619e85de7081d.1645632193.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1158.git.1645632193.gitgitgadget@gmail.com>
References: <pull.1158.git.1645632193.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 16:03:13 +0000
Subject: [PATCH 2/2] t5302: confirm that large packs mention limit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, derrickstolee@github.com,
        Matt Cooper <vtbassmatt@gmail.com>,
        Matt Cooper <vtbassmatt@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matt Cooper <vtbassmatt@gmail.com>

When a pack can't be processed because it's too large, we report the
exact nature of the breach. This test ensures that the error message has
a human-readable size included.

Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t5302-pack-index.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 8ee67df38f6..b0095ab41d3 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -284,4 +284,12 @@ test_expect_success 'index-pack -v --stdin produces progress for both phases' '
 	test_i18ngrep "Resolving deltas" err
 '
 
+test_expect_success 'too-large packs report the breach' '
+	pack=$(git pack-objects --all pack </dev/null) &&
+	sz="$(test_file_size pack-$pack.pack)" &&
+	test "$sz" -gt 20 &&
+	test_must_fail git index-pack --max-input-size=20 pack-$pack.pack 2>err &&
+	grep "maximum allowed size (20 bytes)" err
+'
+
 test_done
-- 
gitgitgadget
