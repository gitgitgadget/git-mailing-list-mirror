Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343EDC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 11:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbhLGLKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbhLGLJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 06:09:59 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A99C061748
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 03:06:29 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so1976920wmb.0
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 03:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7oAFd+T9bgT/uBHukQ2pj4+iinrlwmq8/pya8UpAF8w=;
        b=isYowC0RTEMAB7wpntoHNNuFfvcs2B5jxsf5KZRvaxIMySGDfF5V/uuo4hMqoQI546
         YwEKdpxNvq7/UfU1UrACI+E45CrNeFEqXd4Z+8N+4m2mzuD4kCKocJJUcQsBi90ANkip
         Vr2ISOMnJv1QY73dxR0x50/5Fk0GPkEjSlEmLvqvdxc92XRnypbOpg28DP9agcdsFKNr
         901KOTrFVZf3Zy1x1CkGYRtWTqZ1q0oVNEZYVb2CcA6thUDHnjEH0C3h/ymRpxFx0JKy
         tTMknHk6DCYxEiueatDT9wmcCqqSAa0xOigWn1IT8RZqEhmgtIXl2JBanrlQ59nbp1cd
         TJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7oAFd+T9bgT/uBHukQ2pj4+iinrlwmq8/pya8UpAF8w=;
        b=YTNHBy+Ozkn9VXE/392O9RoiODmTLQo6Edk6nAYIKM4+O6LfL7kqwGCO7DAXvaANFs
         mIAZy8UZHOlMzsNzyeGfLrtFvhuS3M3voa79ycdDkjnayf6zOQqj5YCzInPkaMCnPls6
         sJAhAGqeY/C9uT+onjpQB7cLYzIWrX4msw2H94K9+gba7HTes+9wwOUPN0Vndhb0dOGO
         WxEIiAIqXUIcJm7asFYFMMfAG3FJKviuAfa9mK9ebrN8/byALr80BRWxd0sfTqSx6D2R
         QJLcavxNKwsdA/oJkFmv8sEx1pZwHpqWhkp652p1/GjN5bYQ+9UEPK3vgYwGc20LQcIv
         6fnQ==
X-Gm-Message-State: AOAM530rBKZ+re3NEfBNnpwcXyms8+a2MD1OWblbaeROHW72yVsOWsG+
        C3Nj30GANZpmb4kY5hUA1nbt9eHp7nwCeA==
X-Google-Smtp-Source: ABdhPJy+Z8SRF4HYjFvNHfnhLWtWogXSb6XgdBoEO+GrRsisHCIcEGlABt6sj8PeFrm2Y5GOtiegYg==
X-Received: by 2002:a1c:e913:: with SMTP id q19mr5920785wmc.87.1638875187918;
        Tue, 07 Dec 2021 03:06:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r17sm2629587wmq.11.2021.12.07.03.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 03:06:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/4] pack-objects: use BUG(...) not die("BUG: ...")
Date:   Tue,  7 Dec 2021 12:05:51 +0100
Message-Id: <patch-v2-1.4-4f39177a763-20211207T110440Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-v2-0.4-00000000000-20211207T110440Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211206T162442Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20211207T110440Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change this code added in da93d12b004 (pack-objects: be incredibly
anal about stdio semantics, 2006-04-02) to use BUG() instead.

See 1a07e59c3e2 (Update messages in preparation for i18n, 2018-07-21)
for when the "BUG: " prefix was added, and [1] for background on the
Solaris behavior that prompted the exhaustive error checking in this
fgets() loop.

1. https://lore.kernel.org/git/824.1144007555@lotus.CS.Berkeley.EDU/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 857be7826f3..b36ed828d8d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3397,7 +3397,7 @@ static void read_object_list_from_stdin(void)
 			if (feof(stdin))
 				break;
 			if (!ferror(stdin))
-				die("BUG: fgets returned NULL, not EOF, not error!");
+				BUG("fgets returned NULL, not EOF, not error!");
 			if (errno != EINTR)
 				die_errno("fgets");
 			clearerr(stdin);
-- 
2.34.1.898.g5a552c2e5f0

