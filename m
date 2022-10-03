Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D81C433F5
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 14:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJCOJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 10:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJCOJr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 10:09:47 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8132FC
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 07:09:35 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h194so8149081iof.4
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 07:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=CwXz/2AAl9ZTDNVP853wen3yOU2wgGf0nmOfg3QTbLI=;
        b=tVdhkndzSObVqqkMaukDZAuD24/nkYQBaM0DY+7tYAe5Knoj/6r/UX6KskoJTXxX16
         vIM+qoxZAOW1CGJINb/Bw9HMO5YUZ5TTjNhQZ1aurQkIJVFao0Az0dg13EBpVAJUZ+mH
         8sNtNUnuJafqkVfG4tDXHAvyAR9Uu7RS3iHKwtn258paJLqQkFAGbmWAkeGLVgagwaQZ
         K95PqkaMGMoev3PUIwTotIKRD1qg+ivr0h6BbbxGDcDLfDoi02VSWUvrnQbcCPaxJsy9
         2hpqRvYp/Vi4uU+tAicfe49dMTWZycE9c0sSIWVWT9YzjoBlcJmtIvxMlL4Q2puEaC2b
         QM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CwXz/2AAl9ZTDNVP853wen3yOU2wgGf0nmOfg3QTbLI=;
        b=s72T+yYB2/d8VaXgMiXuNqulbjRB0ZWlsa7Xa+Z+cym5PdCCfrc+cwj24AxbgpF+Yw
         PY37VEqttGxVgyRPJOPWNceiBqo/RCd2eia0tWHyOEpx072lw41uFvz/+IK6ijlTPd/O
         zuTpURIH0HAixEcb2l3F2zPpbUYKtCxqklbuuzQcEpjEONsZGfXvzcRS4DT94PoHr1n9
         PQTJWCd1BciB5nEfapcYOdo3LxApONWUWEX6uHAvKcCX+XAgtt0OmeX3bkDQMo4yUjrZ
         ob6ME0mjV55gWAA3joCKJip4nLaJLmleO4YbsE7CAzyRK+bLIGYGphi80G/36UfJqYDr
         7oMQ==
X-Gm-Message-State: ACrzQf3Yj3bDQHU1LwYtdOWiyabHiLx5T7plz5Y6DHVecBC49QXj3SJH
        cQm0VKgtamreC/qfV9WyFuzxQg==
X-Google-Smtp-Source: AMsMyM4bcnFeLRh4Odyz/S+Q0MT8tfqXpKIfkhvYudykHR21UjquhWA8dSFojaWhlZXn4BdQr+AOlQ==
X-Received: by 2002:a05:6638:138e:b0:357:a6c7:e972 with SMTP id w14-20020a056638138e00b00357a6c7e972mr10491544jad.40.1664806175125;
        Mon, 03 Oct 2022 07:09:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f94-20020a0284e7000000b0036339329bb5sm726699jai.135.2022.10.03.07.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 07:09:33 -0700 (PDT)
Date:   Mon, 3 Oct 2022 10:09:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        lwn@lwn.net, Glen Choo <chooglen@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Luca Milanesio <luca.milanesio@gmail.com>,
        Bruno Brito <bruno@git-tower.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tim Hockin <thockin@google.com>
Subject: Re: [ANNOUNCE] Git Rev News edition 91
Message-ID: <YzrtHLAu110L5oqt@nand.local>
References: <CAP8UFD0_TLWTHpjwxgqAjBLpvBo5BntvpwRLqXrndYosEj7tHw@mail.gmail.com>
 <CAOLTT8S+VcbnEehSo7Cinff4aC-LLu6FJ45ny+82a=FFKQVxwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8S+VcbnEehSo7Cinff4aC-LLu6FJ45ny+82a=FFKQVxwg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2022 at 09:41:30PM +0800, ZheNing Hu wrote:
> Is there any videos about Git Merge Meeting 2022?

We didn't take any video recording of the Contributor's Summit meeting,
though some notes from that meeting are available on the list.

The talks were recorded, and will be published on GitHub's YouTube
channel in the next few weeks.

Thanks,
Taylor
