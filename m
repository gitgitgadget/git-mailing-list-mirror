Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74095C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 15:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiCOPSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 11:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349575AbiCOPRz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 11:17:55 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E181E4EA0D
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 08:16:43 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t22so5250249plo.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 08:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HbseScL/LQhtYltYypvTlD/qs86uXkfg4rOjahZOZT0=;
        b=nkN6ZL9v8Xk3gzRJ4nl5vWoMg5pzs9w2hbUwkcnrltuuNNPGDVmJA1RH9hMJ8WxLjT
         fL4TlJ16Hn+YRmv3Q78vJOcv/sRMFEjAjryFEL/psoR+S5LjsLCJVy9fSHCIMo/IBjSM
         7+z0j+YVbh2JY7nuV3tB0AVfux/BBzoVIi7DNhN8veeO6xj2Dyzq/lQdW6Pbv/LuMttA
         pjo4t1PX6EB91UjbnEMmZjZ1ahE/aP0AD5o9cmuBs7XFgGOJZCtHPyti7P61KCy7K5xc
         aA//H/EPA8wf/t8L78F7tO5q6hz6NC15CU16ACstFLhC9yR9k2Y59TGaHUaeRVbQy0Ao
         mx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HbseScL/LQhtYltYypvTlD/qs86uXkfg4rOjahZOZT0=;
        b=lg8WgtxYRTzTsrCr52qbwiUT3ihWHSp+dCob5kY/zqSAN6aw4KP0/ArTfygamHlaRr
         yUMFiLaBRHHPE7udvmS+Wvqksg3dLXvjLYGqxh33gxR5w6Tky1ZtfZmQhYlkRsGCz944
         YGRZGXTb8eoUPwoXb94lTTeuKyZ+n+pYxPihbvrNvy+48zkVqqgvX9hs083xM3inexCg
         xOTViavpBisWna3RB40zkSvDU8MhMF8sN03xQijJQj/wKitwDPwLUaCjgo33YtFPR8QT
         Iq0FfQkgd0jcfAgOsMLyFlmNzPH1v0dW5Q1CwttN6BtRvzAgBlNau4fHjuC7HzBY4pYo
         N5pw==
X-Gm-Message-State: AOAM531I1ZalIN4lp+G2kknLt8N4XeDRFLB05xaj2B1bWRDnry+7fO1j
        lGSai7qislwJ0So/QWhs+nW7FDvKa123gT1g
X-Google-Smtp-Source: ABdhPJzJqJGC6ZhBbCT7O87EvAaan4bVOCBYZn3VVSMqNDRrrLsJsxsqA9Sqb+N23Wm6xIb0oKfTBg==
X-Received: by 2002:a17:903:2308:b0:151:8ca0:cd8d with SMTP id d8-20020a170903230800b001518ca0cd8dmr28185601plh.119.1647357403320;
        Tue, 15 Mar 2022 08:16:43 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2d81:5a50:a03c:318f:6e3a:9cbe])
        by smtp.gmail.com with ESMTPSA id i187-20020a62c1c4000000b004f78c98bc57sm18025255pfg.106.2022.03.15.08.16.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Mar 2022 08:16:42 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] partial-clone: add a partial-clone test case
Date:   Tue, 15 Mar 2022 20:45:45 +0530
Message-Id: <20220315151545.62125-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <4d78dece-1212-5232-a441-683e941016c5@github.com>
References: <4d78dece-1212-5232-a441-683e941016c5@github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> wrote:

> Ah! This method really should have worked. And the test as written
> is not testing the right thing, because we also skip downloading the
> blobs if we already have them.
>
> I think the key issue is that your clone says this:
>
> +	git clone --filter=blob:none "file://$(pwd)/repo" partial.git &&
>
> which will do a checkout and download the blobs at tip.
>
> If you add a "--bare" to this clone command, then no blobs should be
> downloaded, and your rev-list command should show the missing objects.

Thanks Derrick! Let my try it.

Thanks :)
