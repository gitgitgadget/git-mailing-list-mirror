Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1564CC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF046214D8
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7kjvoMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgAaUQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:16:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53067 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgAaUQX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:16:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so9356632wmc.2
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7g3RInPRozRcqfiodm1wMBj88ZZT+XDAcmQ//AaX4/c=;
        b=R7kjvoMAip/CNnHoYJ968uAKkFX8YGo9QVm97qO3GDrrqX5e4gijzf4TyHCwkKxNDs
         aA0ZEKN1vkcU+sxx3HUKl08MhR5TNOdyQ/2fsNkyVqUyEJxOM0PjDouPke4m/T468BN/
         SNg3lUTHIGLxBdzoXWCXOSnbNX4ATVBcFpdPdZkyjgZSbzD3hOM1IrU9itr76ZWUYV3g
         a/26agrYzKAJlccwkoajSMPSiLtDsIagT6xQ5GVs1GlZz4v9EmWHZtk00J5VC3s+PaP5
         nRn0BqdCZuwNal1zBNm7h0slm+axT1QtmWzUYZu/BdAm8FgmlU5f0i3E2i94ySBGHSvk
         fMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7g3RInPRozRcqfiodm1wMBj88ZZT+XDAcmQ//AaX4/c=;
        b=BLWZ1MfNxvqWIVQje+YsPLEotkjSyHgj0fQkf4d2cqtPE5QkZKeevXakcABH2RPBdO
         v/wphMsemh8Og4N699Gka2EImRCRhbdXNVXVDMJdY1dpeOEF1qlxBP6HK8X4it9DsZoh
         xLeJFkx1juGUa0gj65UGcMEZI7PA740I2H0YayktapKM9o/Z/yuKaN+tmNuPghSAqltx
         EKyUdLlvy1ycV2/u6aM8/6TbUVtGMjxQKdYmXTinHa/w+zBCgpAQU8SSr9r4JN1IgtD5
         UUyMnFlbYrBa5Jv9868F9HmFJ0U4a0iXN8yBJTEhRQ4q0qnn0xDcCggJp7ZKlpns9rRf
         +eaw==
X-Gm-Message-State: APjAAAVJAsNRr71KXlCI8BdjAesIFJH5dAtPPT0+IcYFSS+VPhYWTpdP
        bbKubXCNxEqt0bz2jtajvjTSQ/yU
X-Google-Smtp-Source: APXvYqzsY2J8Hxq+uH8oRKvC6guV+0M5xp01CoWlhpOgmOcRqqxccPgdbKHTxCMPMC90PE8xWeiZNA==
X-Received: by 2002:a1c:a515:: with SMTP id o21mr13965923wme.85.1580501781558;
        Fri, 31 Jan 2020 12:16:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z4sm11833598wma.2.2020.01.31.12.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:16:21 -0800 (PST)
Message-Id: <aace0645107719f62c611296adc44f8c286d8403.1580501775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
        <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 20:16:07 +0000
Subject: [PATCH v4 07/15] sparse-checkout: detect short patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In cone mode, the shortest pattern the sparse-checkout command will
write into the sparse-checkout file is "/*". This is handled carefully
in add_pattern_to_hashsets(), so warn if any other pattern is this
short. This will assist future pattern checks by allowing us to assume
there are at least three characters in the pattern.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              | 3 ++-
 t/t1091-sparse-checkout-builtin.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 40fed73a94..c2e585607e 100644
--- a/dir.c
+++ b/dir.c
@@ -651,7 +651,8 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 		return;
 	}
 
-	if (strstr(given->pattern, "**")) {
+	if (given->patternlen <= 2 ||
+	    strstr(given->pattern, "**")) {
 		/* Not a cone pattern. */
 		warning(_("unrecognized pattern: '%s'"), given->pattern);
 		goto clear_hashmaps;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index e2e45dc7fd..2e57534799 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -339,4 +339,13 @@ test_expect_success 'pattern-checks: /A/**/B/' '
 	check_files repo/deep/deeper1 "deepest"
 '
 
+test_expect_success 'pattern-checks: too short' '
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	/a
+	EOF
+	check_read_tree_errors repo "a" "disabling cone pattern matching"
+'
+
 test_done
-- 
gitgitgadget

