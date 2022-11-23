Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67A1C433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 00:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiKWAfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 19:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiKWAft (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 19:35:49 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9487AF47
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 16:35:48 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w23so15195447ply.12
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 16:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3XJpk6a/r+JQzD28oJ+V7n5c2GCO8MnBt5lKtUn5uE=;
        b=MMAuePwzWXQdPu/WjdpS6T/FpKawwpSdxY36g0Jrc3bF65ZieNbq5O1/Z2zLAjz+Wc
         PCl7jse83tA3vlp2aw0VcfChIyp19oDmpLhiFuIKx7Wmt/PMjgOj16ZqNadWGsxNwh9D
         4BtdZ1FAulWM6IqkFJoBWExz+lwg3fhHYQMHVQrh9B9xlKTb4pp0ka0BL2WDxv33SSyu
         9FOj+7rRHouSDT+zwUKK5eBhRC0ha5xuBgrsWSrnU578qDxDMfofWRxRIfvyDg0+ESY4
         yEenAuAXGFbMIQUUvMgT6eP5G2zTz5K+YXMyXGXBZe29m9R5EQlBpBv0ZvN2iVQicppA
         Pb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b3XJpk6a/r+JQzD28oJ+V7n5c2GCO8MnBt5lKtUn5uE=;
        b=2d6pSlv2xLPLMMAPQO7azN0Qar1yHfjE5lJVfwJnQAsd/MMShl4uDXa6kyRu0aY0iY
         FYT1VrM+xGbjKK9Ql8dKWaAQwjpc9sdXiVr3FMvjmJw8CSVlBaunP98jALDTo3lQ2V4x
         PeUbvurmDCGNZCBeBDwfZh2pPDPsnoWML622ay9uloJtL3ViTG1pog+bUrzoKvIOCdLg
         xnG7frNz35y3Hk5hOaKN9pcOeNRvEptaSlQbKJzFb+tcDFO36HEtpmCti19uWLgP14sW
         in+HQUKk7lfyC44erPcxWMRUas7xZsKhy+IJhjjDeG9hw5fcFEinbzR+bVyJTiUg0A70
         ysLA==
X-Gm-Message-State: ANoB5pnQ5L87o3bKYQjiRyXzidkzLMQ19wAoq47OUITE8t4H0uukemNz
        /xS2PHiQVtAGOVUZ7688Rt4=
X-Google-Smtp-Source: AA0mqf6VOXcrffCrtEa5o5sD6LMOt2VzCxBD06EqCdSTH2Mq19JfN2xVXWJWQAFFvKSpTk5srpPvFQ==
X-Received: by 2002:a17:902:ab44:b0:186:acb0:e93c with SMTP id ij4-20020a170902ab4400b00186acb0e93cmr6847464plb.141.1669163748412;
        Tue, 22 Nov 2022 16:35:48 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g10-20020aa796aa000000b00571f4386697sm11291048pfk.24.2022.11.22.16.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 16:35:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/2] Implement filtering repacks
References: <20221025122856.20204-1-christian.couder@gmail.com>
        <20221122175150.366828-1-christian.couder@gmail.com>
Date:   Wed, 23 Nov 2022 09:35:47 +0900
In-Reply-To: <20221122175150.366828-1-christian.couder@gmail.com> (Christian
        Couder's message of "Tue, 22 Nov 2022 18:51:48 +0100")
Message-ID: <xmqq5yf6pkws.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> So the only changes in this v3 compared to v2 are the following:
>
>   - rebased on top of a0789512c5 (The thirteenth batch, 2022-11-18) to
>     avoid a simple conflict,
>
>   - patch 2/2 uses has_promisor_remote() to check if a promisor remote
>     is configured and die() otherwise.

Both sounds like sensible things to do.  Thanks.
