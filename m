Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B8FC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89156611C7
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhJUUAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 16:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhJUUAb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 16:00:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DE6C061224
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:58:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p21so731789wmq.1
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C3Xl+racZ5cb94llHK5lduwl8tjFQoapIzybIn+nBWM=;
        b=lJDDLsdn7dqGxzwL5f6kGtR7MhbuBtYh+tSlhUSjaccrHAQTG2IZJ54l86D/mAZDiS
         nN4ScLe1eHOm41vqcJpT9Fd4pRM/F3qyUZMBsr5SRTF5dGwG/nlp4d9Oa8l850oX/q7k
         278+QeP0k6/1NeJgTEFyuihj/oiUH3aJqlUJETMLUUIhM8gK11J9lkK4nSVIo4A1+JOc
         5fapkjduKkz0ljghT4LFwp7HzEIokks72gcCBZgwXZGoKP+bzfrEAy02br62B3WDMB4j
         xYqlhdpDCh4783guG2B0+wpUvSeK7QB8s8spK04HWojq3kDVo4aZcyJ4XoipDQ5+rdrm
         OH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3Xl+racZ5cb94llHK5lduwl8tjFQoapIzybIn+nBWM=;
        b=HUoEpFpjFLABGpikLjDhpRyo/6InJH5iMCqwf6Rj5Ynd/BqdYhF1RsEIonebHzwdv9
         a0X0+st2cgKZWArBNa8l+3uhyQbMF69oPlrN6pAdFdUOY8vgVpJW65pprCSGgzAn/Oyn
         cqfjjofkTzAafRDyin0E7wZqWVxHPlSJ7memDdKm+7dS15h9xG4DW+/xyFMsnoZecC5j
         fhSVyxlPIbdAEw4TpGzQF4+ZI8SHpk2/U9zpNlWDqVvpHHcYHt6dcgTa9v1fKxofG4K/
         IqLMwlkW/jjfa32LjCH839RQutSXGR4Mf8jFBn5XyCkbI12TFv1QxiP6pefOJbl9yaqI
         f3gA==
X-Gm-Message-State: AOAM530zluGI9CCtrKA5UCbyb9TSo+QaTfREHw1UpK6Di8fJWcz6cZrP
        xiQAqb2fbd+MgC3OCc+DSEm6pV8VqJ/iIw==
X-Google-Smtp-Source: ABdhPJw2ihjtNZzwTTt1jHERPd9qzyMJ0w6rKqP8EivQ8lKpyvC1Edj5L+179JgSthmS1kk0KPwf7g==
X-Received: by 2002:a05:600c:4e94:: with SMTP id f20mr9113422wmq.166.1634846286070;
        Thu, 21 Oct 2021 12:58:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o40sm388765wms.10.2021.10.21.12.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:58:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] git-sh-setup: remove unused sane_egrep() function
Date:   Thu, 21 Oct 2021 21:57:59 +0200
Message-Id: <patch-5.6-eacbfd6be0e-20211021T195538Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The is_zero_oid() function in git-submodule.sh has not been used since
e83e3333b57 (submodule: port submodule subcommand 'summary' from shell
to C, 2020-08-13), so we can remove it, and the sane_egrep() function,
dead is_zero_oid() was the only function which still referenced it.

Unlike some other functions in git-sh-setup.sh, this function has not
been documented in git-sh-setup(1), so per [1] it should be OK to
remove it. I'm still unclear about the future of some of the other
functions[2], but any questions in that area should not apply here.

1. https://lore.kernel.org/git/xmqqr1dtgnn8.fsf@gitster.g/
1. https://lore.kernel.org/git/87tuiwjfvi.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-sh-setup.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index cee053cdc38..758520f5a61 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -177,10 +177,6 @@ sane_grep () {
 	GREP_OPTIONS= LC_ALL=C grep @@SANE_TEXT_GREP@@ "$@"
 }
 
-sane_egrep () {
-	GREP_OPTIONS= LC_ALL=C egrep @@SANE_TEXT_GREP@@ "$@"
-}
-
 is_bare_repository () {
 	git rev-parse --is-bare-repository
 }
-- 
2.33.1.1494.g88b39a443e1

