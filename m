Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1271CC4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 23:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiKEXSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 19:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKEXSl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 19:18:41 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A369BFCD3
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 16:18:37 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id m15so4287204ilq.2
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SKAFQ4pa4EoueDHvz3jcYHFO8nqZ9G0k/pk6gN33n0U=;
        b=HLrmX3d0OiioYjbHIAzEHIyLroRxMyB7vD+J3BaNiFuHhC9ijUiz657Vbrbph7Kc/D
         Vbn8QILNBribpXKiDi+TtK5Um961tp9xXMDaRpCb34U8WQ7t7OEAWYRiBfJSCTnFI4CU
         pMrJZKA3IyBeKZFLSmrkrf2GTYG9oyrv5ZX541eIHAoe3k0IlfGapDwpy4FRNAOEaQqp
         lAaSRIuuqHE8UEMKagBrcfB3EqBKu4F0p7F+nE4MllRKvTNxsgNonpRThdxOZ+EQhVeF
         pK5q02hdRHX5U8i6ft5Hpcdc8f/ohAjQjUVl0ilBpC6ibZAFOUBVFZStRZIyDlPxNCE7
         sevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKAFQ4pa4EoueDHvz3jcYHFO8nqZ9G0k/pk6gN33n0U=;
        b=tWuj6/d84+WRaR0N+MuIhzMcje7mUEnkF6LVAbCK9mJTPjClB9OFlkd82FnJoCUDmt
         f24QQ0M2F7w9fE0xNjYY/ppLEsKw91S2HQTeLZegURxcAuuAF1W5+bi3yfH9mO6+QaJK
         6PbEQD/rfYLIXzDxYbSsHgWxxrSR3elkQ8VjHocFUbupLiE/kw37GLVXnn8x9xHsOY9v
         HyKhAlpepHOTFSQsSRp5fLDQbwjU1COihLZn8D0B2gU29za9YLw/X4jDJ3pRcMssn6qM
         9quEPbCZr9zMjcLD+4qe+TvBbV2HXNXh+I8ksNol3T9/doT3hj23b7MXLZqcQd92BH34
         PaWw==
X-Gm-Message-State: ACrzQf36T1almFcJj3B5lJy+Dxovt6wbnpWqx7fz/+38sf7PKgYf4hP9
        pQleUEk52CpXn4Palz/QgoeJ8g==
X-Google-Smtp-Source: AMsMyM7cXvLt4Rj2HVhhO93k5Cu+YajtyKFZjq6F7EFg/ZzIvfclR9u8kNI0ri35wqGE9tkqS/8+tA==
X-Received: by 2002:a92:c7ce:0:b0:300:5bd1:265d with SMTP id g14-20020a92c7ce000000b003005bd1265dmr16143871ilk.261.1667690317009;
        Sat, 05 Nov 2022 16:18:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v21-20020a02cbb5000000b00363e4730a41sm1067548jap.175.2022.11.05.16.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 16:18:36 -0700 (PDT)
Date:   Sat, 5 Nov 2022 19:18:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/3] Convert git-bisect--helper to OPT_SUBCOMMAND
Message-ID: <Y2bvStmh9LBfgDVE@nand.local>
References: <cover.1667561761.git.congdanhqx@gmail.com>
 <cover.1667667058.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1667667058.git.congdanhqx@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 06, 2022 at 12:03:33AM +0700, Đoàn Trần Công Danh wrote:
>  builtin/bisect--helper.c    | 229 ++++++++++++++++++++----------------
>  git-bisect.sh               |  23 +---
>  t/t6030-bisect-porcelain.sh |  10 ++
>  3 files changed, 142 insertions(+), 120 deletions(-)

Thanks, this version looks good to me. Will queue.

Thanks,
Taylor
