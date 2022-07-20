Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8ECC433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 12:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbiGTMs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 08:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGTMs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 08:48:56 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1972A272
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 05:48:55 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id bh13so16308007pgb.4
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8KZAPQPljk/y8YOv8w2uwZtmKCisIOdynSAcg/E7XOQ=;
        b=TeNTB2/7n0V0NlAWO9nUZa4hCNrTmtIlSdt1afbTe7zCb9hmKiDid8xWNNi4HlIa6h
         nwBmXOLz3yrHoxcMo5feFiXPoDwLpkZqfVXduobgtNzZJKF40oLWeo7OXtybkoH3Jads
         8AwSA2zoMYVUvWk+zBEkjAZWXo4GDIqe31Wk6u3ZGAwHhRn/CemNR3yvVZynwB+C9zoo
         dEgWmd9cgKyNsL8X+89wq9OqCVkWcuS9OuiIwE09gmkAgaVt/kBCGs0FLRHfE/9hN/dk
         AnsCHmSS/rd4K6KXiG7uHD3n9oLvUoaG6dzPAFa7FLVZZv4z2o8YZyaAMQliA1g8k0Xx
         YYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KZAPQPljk/y8YOv8w2uwZtmKCisIOdynSAcg/E7XOQ=;
        b=zoB5Eb0O77EhirsTCrQMTRDyX+gV3gPC3E/gWwSWBPVSzoy5Xz9CpoVTX93tLhMw3O
         rruB2S8wKN4FNZELmvz6JFfr23T/N3ONjIhLkLOblk2VgFc7EWzRUEScWUQQKwkR4Kcu
         0L2OZTFMPLOtFHmnB06znVXLSqQTuypqL/YdF1CRup2+XqmdX6x+mTtHIVFU4jdyAdSo
         H0FEXOy40XzMZYEK5PY8RsaxS9gl0zFCUukDaY3mGMyVd/gUUcp0wRXeKchGHNiZ6qaF
         sqZHTRiEyYV3M0KX40IU4TjM2235ElM8VVSSJXHd/UfwnhXU3S5MqKPDKSAHINRmBPAg
         bdTQ==
X-Gm-Message-State: AJIora9HBiGJkdxuSycBjwEGRp0QljTktDlbMUREbWar+bKPmVUT9cmY
        bQxvwOpHjOJuxoZPfDYmiwI=
X-Google-Smtp-Source: AGRyM1v+f3TjYH+7PcgXMHhUFbMmegFV/7tK8vFFKs9T/oOU6iifKS1Do8Yn3hCMtd9G4Y9Yj3kJMA==
X-Received: by 2002:a05:6a00:319e:b0:52b:aa23:bb02 with SMTP id bj30-20020a056a00319e00b0052baa23bb02mr1259226pfb.43.1658321334973;
        Wed, 20 Jul 2022 05:48:54 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id d1-20020a62f801000000b00528c26c84a3sm13409400pfh.64.2022.07.20.05.48.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2022 05:48:54 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@tenglongtldeMacBook-Pro.local>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@jeffhostetler.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v7 7/7] tr2: dump names if config exist in multiple scopes
Date:   Wed, 20 Jul 2022 20:48:47 +0800
Message-Id: <20220720124847.65619-1-tenglong.tl@tenglongtldeMacBook-Pro.local>
X-Mailer: git-send-email 2.35.0.rc0.679.gc613175da2
In-Reply-To: <xmqq4jzcak8g.fsf@gitster.g>
References: <xmqq4jzcak8g.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This make it sound as if we do not show the scope if a configuration
> variable appears only in one scope, but I do not see how the updated
> code achieves that.  Instead, it seems that it shows the scope
> unconditionally in addition to the key-value pair.

Yes. There is a problem with this statement. I will fix it, maybe like:

  tr2: print corresponding scope with config key-value

> If that is the case, a retitle is in order.  Also this should
> probably be a separate topic, unrelated from the other 6 patches.

That's the case. I will send the [0-6] as the v8, and separate [7/7]
as a new patch series.

Thanks.
