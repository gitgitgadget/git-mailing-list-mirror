Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EBAC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 08:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345827AbiCOIWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 04:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244745AbiCOIWO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 04:22:14 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2637A4BFEB
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 01:21:03 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id t2so15749444pfj.10
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 01:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQYuQad+NQIU68Kcj7i1m5uTdiAiIyL8GrRO6K3lCVs=;
        b=oTFU4TcL4I9rH9glV37oYKBX6xCk1rQKH2jX5OJ22kcr7AZ+gkOdf9FeF9ySbQhKG4
         PSN7c6YpXnelo4ZR8yULn3TSN+wCEo/fCfFapieGbugZ1bU1FmZ8DwLnRXZAnTLbTQXE
         6pSc+HAf0iDfTfWh/H2ENx5DkCoYWMz1DBioVl2S3urdij4daWUuSzta5x+Kd+ZBj449
         DMhwjWJPGb45lApAyiuw3RUpj/NKhkBtuECMwr93AZyLPOuABKiurpCTG81g7Co5Fhyc
         KJF/GWC6SRTtL/PhKmMqrQBSRRsX8N6tZYzScbxvbw5iQEJQsRmy4c0dYq3HI67Ts2Kg
         3OZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQYuQad+NQIU68Kcj7i1m5uTdiAiIyL8GrRO6K3lCVs=;
        b=nEq2Nwi41Fpy1Ekbu4uUTVyPi8QGygDRd7LNrgpZtbLvr5B/cxnDk8H8T1WPx3ekyb
         jvufgEhU11SmqyjvwnWRNTuvfwPS7tzJxj+z3oUcMBuhjoAJZICZWFPIkn6j0Yn9/RcL
         /5GY5wE2tLiNpMFRQsMuxv+MS79km1340CF3hw49sfmllmwGbdW4ICluaBcWdw7qkINy
         oYq2QwJAq7cUMBZQpn1xEpJVHIQcxFlTavjNvtHcB3eWIBJKqpx6YSg/y7RpZxEM2KiM
         RhI2v28qUWofp4Amghe2+tLRxKm5kBHh+7+/9Ptf3aiolMqWHPl/PlHqLrJDVAcE+1AL
         NjrA==
X-Gm-Message-State: AOAM530xq24ta6+TXkLSvjTr7WZd0+YE0qBETmr9nb2Rfa09CL+2C2Bm
        1D7ahcs9gCf5uRxj65Mye/fl07vivzFV4X/6
X-Google-Smtp-Source: ABdhPJzowCgpd7eZzSCusXo1eKIcmxe0jmBEBbsFm4ChhFev0v77Evhs6yumAc4Z4NednfpSy5HEzg==
X-Received: by 2002:aa7:909a:0:b0:4e1:6d4:5905 with SMTP id i26-20020aa7909a000000b004e106d45905mr27936019pfa.34.1647332462494;
        Tue, 15 Mar 2022 01:21:02 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2d81:5a50:b496:2194:e934:160])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f791d0115esm15481398pfk.171.2022.03.15.01.20.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Mar 2022 01:21:01 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] partial-clone: add a partial-clone test case
Date:   Tue, 15 Mar 2022 13:50:46 +0530
Message-Id: <20220315082046.61250-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <e38ebbfd-3ce4-6900-97e4-74b987c08b7d@github.com>
References: <e38ebbfd-3ce4-6900-97e4-74b987c08b7d@github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> wrote:

> This reason is something that could be mentioned in the commit message
> to motivate the change to the helper.

Sure, definitely. Will add it.

> As I mentioned earlier, it seems that
>
>	test_subcommand_inexact ! git fetch
>
> would actually work for your needs without changing the helper. We will see
> whether or not the helper needs to be updated in a way that that line would
> not work anymore.

Okay. got it!

Thanks :)
