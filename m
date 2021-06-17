Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD58DC48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F7B2613BA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhFQKoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbhFQKoP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:44:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C315C06175F
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:42:07 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y13-20020a1c4b0d0000b02901c20173e165so3429822wma.0
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8UqdX3ZT1FDhf+ek2ieelEFM7LoEC3gfsY2xujK9Ii8=;
        b=hwx6hkkV6dxq39SsTyOaiDceESvs3fnGcniWAfCYr3jZtlrfEhRfqOqYfS7LnJ/fnc
         67CvxCyEexiF08ZzNZJZr5OdHPo4XNTwTzCd8akNdI6rr9fHoyeUxiFhffb6weCdqRRX
         pB/0+dBJKPHiro1+xoWFGnbb9TkIe0+tH49Sib6tDozVHThmVQoOg6lCWlS1suQuQFA+
         vU/zF+F7bbZ/mtr0tGFIWtw9PrL/IXH1kjm8AwEd8Cog36nKGY9hnQYNH3yxO2B5YtPK
         K3xpRJM/IV/+GrLz5pDly1ywgkYffbCmCpLw/aHmrofYf7/XTtSfRKW2koVgDQRYDc1m
         ei7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8UqdX3ZT1FDhf+ek2ieelEFM7LoEC3gfsY2xujK9Ii8=;
        b=ZGBxLrXLSNTRdt6rOgKmzaufmEORpMW4P1fvy1CeLodyhHJp6l7xklvLTLLXdzJcOo
         +0WUoM2zNonWiw1Gj3cZlCzRHuEjUUqIx03U5gHbcQ7KAQchMM2hVkvwMCyiZUpv1aZM
         gcwP3KFJa+JNoMtM7fDzUEGMiSVmrm4yGdCUhjb4XSg8iOoZvbXlNek8vk+2z6hg0aTJ
         FOpLjaDxggNJ7/8wgxYnynaf+MzOGZ8aP/GFh+J5m3s2VKSOtE++1NE2Ht2Z4KMwuHxw
         oH/eolXl4v4bdjQat72W3thWSqV2MHR+Itha00Xzs03UOldHeU3IVWRi4RbmGPNwbLge
         9tyA==
X-Gm-Message-State: AOAM5326a1uF0UgceuvjmtRTfI5CogIBDnC3UFrDHYBPCuGpfz8xpdSZ
        Cw+0sH+AmKRt4nDgpXrfvmG6yi9cKqmG0g==
X-Google-Smtp-Source: ABdhPJy31nJvNoHoOWJG2ceVyPauDd9e0fk2kN5Dekj7xbw9DhT2oDlQYs39Xh4QB2r09rFWdyBG1g==
X-Received: by 2002:a7b:c3c6:: with SMTP id t6mr4168959wmj.66.1623926525823;
        Thu, 17 Jun 2021 03:42:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p10sm4784607wrr.33.2021.06.17.03.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:42:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>, Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/6] mktag tests: invert --no-strict test
Date:   Thu, 17 Jun 2021 12:41:58 +0200
Message-Id: <patch-2.6-550dcedfcb-20210617T104011Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
In-Reply-To: <cover-0.6-0000000000-20210617T104011Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com> <cover-0.6-0000000000-20210617T104011Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the mktag --no-strict test to actually test success under
--no-strict, that test was added in 06ce79152be (mktag: add a
--[no-]strict option, 2021-01-06).

It doesn't make sense to check that we have the same failure except
when we want --no-strict, by doing that we're assuming that the
behavior will be different under --no-strict, bun nothing was testing
for that.

We should instead assert that --strict is the same as --no-strict,
except in the cases where we've declared that it's not.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index e9008744e3..951e6d39c2 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -33,6 +33,8 @@ check_verify_failure () {
 		then
 			test_must_fail git mktag <tag.sig 2>err2 &&
 			test_cmp err err2
+		else
+			git mktag --no-strict <tag.sig
 		fi
 	'
 }
-- 
2.32.0.571.gdba276db2c

