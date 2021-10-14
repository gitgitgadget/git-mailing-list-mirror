Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ABEC433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0656E61154
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhJNAtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNAtg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:49:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D7DC061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:47:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m22so14202629wrb.0
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lFXvqg/A9/5kZH5VtLoFttzAf4iJYpnlGNil35Boya4=;
        b=j/FlcGTw68rmeAHUrTReAm0sFGAVQdO7jTXFTIdNN5mhabQO3poUrSDSa1hRFGiwtr
         7ZqSatmmuobCFiLztTLroQ/Bo6Bf47YXrHNpy7a2/MVv7WDtc+SZWHqnaEP0un5YiMqh
         ZFR0vc/gmDYiPqr0VWkKsyyqEYIZ80wFd2nKJz6LUkIEqoml8ncdKufmDu3Xa7h+AxS8
         x2ywDN5qfpch5x+71xS07wk3zM3AYem0ZvrLc20rSZ4OIIyP75E59e6NyRSsD9YLqgH9
         scOYnrd3MumZs4WTPstVWsif119giu1bX1J0WUslO6ZoCF8h835Of+WHWvRBbDOfkMBa
         miaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lFXvqg/A9/5kZH5VtLoFttzAf4iJYpnlGNil35Boya4=;
        b=LoMd3Aii8DuD80Gb3GtfUIj6iOc7Joz376gYIgEmI9i0sOyLQtBItjXG+JeqM00vRB
         R86uXa/1hm0/3ynzPdh3wN6EGs9FuLZwVIyNl9wX9fli8rvCcr4dqwrEORk6ToL6xkrJ
         TmJVZyh6Gmh/IRxAS1SKNVj6CU44BevzEu97dNvdsstizk9FJ+UYVTM5ean6pdH68mVz
         o+5ptryJWh2c4tMezaliCyG6r92gUB5B5ejIOo1smxO28Xv56iqN/9hVomKqHY2RIpMV
         HOqVssU8jMFrkB4WOZNw1S92VccF06Yu9OB9B/aquPnfDsuwXiQglT2vUcrMfwFA03p4
         6Ssw==
X-Gm-Message-State: AOAM530xLchwyMRp2+gj4PcNcdpQp/2eCjjZgqhhpUk1eLqZ1S4VLt/v
        JTL+pVwt2qhMOQ3EpOne+lGkJRL8uzcxOg==
X-Google-Smtp-Source: ABdhPJxDNaBY9dyNIWjrFbV9JAW06za4b9VcnFfEFnVsVdyndN7V/eoJ80LwXbAzpcpZGf1WQdUAqg==
X-Received: by 2002:adf:e3c6:: with SMTP id k6mr2876463wrm.90.1634172450927;
        Wed, 13 Oct 2021 17:47:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w11sm736126wmc.44.2021.10.13.17.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:47:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] test-lib.sh: add BAIL_OUT function, use it for SANITIZE=leak
Date:   Thu, 14 Oct 2021 02:47:27 +0200
Message-Id: <cover-0.2-00000000000-20211014T004542Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds a BAIL_OUT function, and uses it when the new
GIT_TEST_PASSING_SANITIZE_LEAK=true mode is misused.

Once we have this function we'll be able to use it for any other error
that's a cause for aborting the entire test run.

I experimented with making BUG() and error() always be a "BAIL_OUT". I
think that's worth pursuing, but e.g. for the error about missing
"&&-chains" we'd need to support emitting multi-line messages.

TAP consumers only understand what follows the "Bail out!" message up
to the first "\n", so we can't quote the entire "test_expect_success",
as the "&&-chain" error does. I think emitting them with "say_error()"
beforehand (piped with ">&7" in the case of "BUG()") should work, but
let's leave those #leftoverbits for later.

Ævar Arnfjörð Bjarmason (2):
  test-lib.sh: de-duplicate error() teardown code
  test-lib.sh: use "Bail out!" syntax on bad SANITIZE=leak use

 t/test-lib.sh | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

-- 
2.33.1.1346.g48288c3c089

