Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2060C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 10:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346612AbiFUKIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 06:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348821AbiFUKIW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 06:08:22 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587A15FE8
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 03:08:15 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id n12so5711814pfq.0
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 03:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q1OiBh95vlgMgPk4l0uGy3ywpyAVdARndC3HAAq/YpQ=;
        b=kN1HWyAcrCI9eEKuwoQSLXcFZDtuJLQCaXbJv6QizyGui9iPhvX22yiUOMyI5GOQzU
         2A41d8IgVJe+1W2mwrjzf0J7GIkG1iuqqCsCLr6mUuspHaeDmxabXhgU+e6JhhQYCPWe
         CQ3y5bt2YYK7BLv2Wv6AT4Q0GbEjvI1DfeSE7zgEmNhhOqMGQ6tvln+q062REAm11eF/
         btsM1Kto5AqYZCi+Iyb8QEREwTMzLQZUenNffQv6U2pj/fwpE1nl1m+RjulSnHQSHktG
         F2EGIM5bontCRsFs+eFEtsSKIqcCeo7ZCMvDNoRHGT6h7TWjybqEaI6NxxYA7keHGbDS
         n6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1OiBh95vlgMgPk4l0uGy3ywpyAVdARndC3HAAq/YpQ=;
        b=lMs1iCtZi6K9G0tx1ItzL2KZtfYN57scaqTSQ3oXlByA1E59jnYHzCb5pHVA93kVXP
         nFaAgzp8gtecHirdGgJSTTv21sBs17dL3aO4/RXPoSxtI4ODtXZoU1+05vMTFh8hHFUI
         E8VsdhL4WmF0krPVZNDeuVuiqaFhOy+mgYZryq2KswRked7W0gF8TvWJ4mE39L0R6pu/
         eo7vrSK9la/+gubMqYGlF9XSXkXVWrn59O/4T05r4fo3p8V2Nm7Uqpz/slFzYfk3QAOb
         uLxfuCU/Zq7atLZFdTnNwLZw6tf8fm6v0GYUWsqsADYGDbi3DaIuq+HuxaoE+VN4k8QE
         2kuw==
X-Gm-Message-State: AJIora+jFxhgNwvDofRThHtF21oK5kMVdTqUOAH9bWdq7vSt0cN+/EsB
        Sj2YVrQJC2OmJeCPWblrDSg=
X-Google-Smtp-Source: AGRyM1u/GxKWXUVFje3hswr4zUUcix6Ov33KulysyIiF9kh10o77ZNN+d3cbAERSHdE0lTcHPXX7ew==
X-Received: by 2002:a63:794e:0:b0:40d:99b:bb4 with SMTP id u75-20020a63794e000000b0040d099b0bb4mr500609pgc.133.1655806094783;
        Tue, 21 Jun 2022 03:08:14 -0700 (PDT)
Received: from localhost.localdomain ([2409:4060:e8c:d9c4:5de9:32:b7ec:5230])
        by smtp.gmail.com with ESMTPSA id w20-20020a170902ca1400b0016a16e16c7fsm5213316pld.248.2022.06.21.03.08.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jun 2022 03:08:14 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/6] Documentation/technical: describe bitmap lookup table extension
Date:   Tue, 21 Jun 2022 15:38:00 +0530
Message-Id: <20220621100800.21767-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <25e03c86-5a47-2100-2da7-a635673a8e38@github.com>
References: <25e03c86-5a47-2100-2da7-a635673a8e38@github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> wrote:

> I think you mean 0x10 (b_1_0000) instead of 0xf (b_1111).
>
> I noticed when looking at the constant in patch 2.

Yes, you're right. It's kind of embarrassment for me :)

If the flag was Oxf it would enable all the extensions.

