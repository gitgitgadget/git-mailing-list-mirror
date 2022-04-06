Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30D0C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 14:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiDFO2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiDFO2W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 10:28:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20204FB69E
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 03:42:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b19so2528217wrh.11
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rYBfEiu9Ji28jY0nHDyeI29eUKXbr5EpMLXlx6nhqZg=;
        b=SBOfQuoZDKfuhWyEBU0GhsMGlWNkcpJaCJVHbyOQrDPf1x+oKV1CMEPtgffOfJpdLX
         Y4zKATNA2w6hsjZW8MGOQzyT74ZTCTsoxCE2+AYsRWfcpN7LI5/47noIzQfGF/wZdgGm
         1Q4dAb1DUlzFFj8Q465HyUQZwEjfaUg2RDAnAUfcUi2RPImz1x8VotV+kQ17q2mLo/tO
         AcOh2yybM+jgq2k1NppsbePhJpH8ZStpIu3Jr7bLff3zLTbYRVpDddcGEATirlCrJVAc
         /KPBR7n314/7j/g2M5+eoRSmpQQmEk/qRKt81+iPeCstmGHi0WhHyRhk2pf4NwmGC9CX
         2Geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYBfEiu9Ji28jY0nHDyeI29eUKXbr5EpMLXlx6nhqZg=;
        b=q0P3ikEuXzhKaslGEVC++1qWtI6znlqX/gjdP1+9QP2QWRYIM/69DuIdiglBiYjI4L
         4zGnA7OUDehF1mdAmt8EzNwgfczpsQdhgZG1NuZFDVLf2dIvRjO6uGltfEW7js37btVd
         WlJwcK3bEuBt8G0DHgrtyQyikgazX+wRiAZXmJ7Op86Riw06A8TwLrcthATmLrFH/rcO
         lyuvV/dYvcD8QCHMqeP3DKbMhsuVA3Go5EmWA6rU7ekaIvRBiv5iUDumUd2AfzrBkWXI
         QbgDFHoRk0LEIe92OXMhifk0TC1pP+50wnEmL8xGufrfB09G+okdknI4WZWB/c49HSJC
         ohAg==
X-Gm-Message-State: AOAM532QNrMH2Tr+RSnljcpLitxTcDaQgzhJ4AhI4WHICokAYzvd2o+7
        Da+FjBYH0hUT9Q704gbxurEFTJujY4/aWA==
X-Google-Smtp-Source: ABdhPJyl8Lcr+f1nQK1nwm6j2HMY81lG1lX6ZgYG0CrgT2JD91rW12U/boVxfMVFvwR/4zPNYAgDZQ==
X-Received: by 2002:a5d:6244:0:b0:1e7:686d:41e7 with SMTP id m4-20020a5d6244000000b001e7686d41e7mr6067963wrv.491.1649241771186;
        Wed, 06 Apr 2022 03:42:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c354200b0038cb422e3fesm4831288wmq.32.2022.04.06.03.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 03:42:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] cocci: add a rename of "struct child_process"'s "env_array" to "env"
Date:   Wed,  6 Apr 2022 12:42:43 +0200
Message-Id: <patch-1.3-b943ed5d5b7-20220406T104134Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc0.849.g2d5b5d9ab01
In-Reply-To: <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com>
References: <Ybtb6Shdj56ACdub@coredump.intra.peff.net> <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start following-up on the rename mentioned in c7c4bdeccf3 (run-command
API: remove "env" member, always use "env_array", 2021-11-25) of
"env_array" to "env".

The "env_array" name was picked in 19a583dc39e (run-command: add
env_array, an optional argv_array for env, 2014-10-19) because "env"
was taken. Let's not forever keep the oddity of "*_array" for this
"struct strvec", but not for its "args" sibling.

This is added as a "pending" migration because it'll need a couple of
manual changes to go along with it, those will be performed in the
subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/run_command.pending.cocci | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 contrib/coccinelle/run_command.pending.cocci

diff --git a/contrib/coccinelle/run_command.pending.cocci b/contrib/coccinelle/run_command.pending.cocci
new file mode 100644
index 00000000000..709fdfcf720
--- /dev/null
+++ b/contrib/coccinelle/run_command.pending.cocci
@@ -0,0 +1,11 @@
+@@
+struct child_process E;
+@@
+- E.env_array
++ E.env
+
+@@
+struct child_process *E;
+@@
+- E->env_array
++ E->env
-- 
2.36.0.rc0.849.g2d5b5d9ab01

