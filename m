Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6958FC19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 13:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbiHCNFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 09:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237671AbiHCNFS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 09:05:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBEF2BF
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 06:05:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b16so13892502edd.4
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 06:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=8fOVuMvog03Gd8YXtpGpvyC4PdSm9Vqpucv1aUR/nPA=;
        b=STqW2l/pp6rGBk+xVS1UfEMmY+gyazz2plL7OCiQYIeEEWs2ED2t/wpW6tY71GvxGD
         CaQlUY2B/dVJZgoi//hJla7cfkp6SohY75kAnQ7/QCMg2x7LJZy3o0z+rTi8AzfTlYpy
         ymBA/tmJgoUmS1uVa5m/2Wa1MWhUnbLIUVoSRmSXY7D+nUC+9uV5GA0QQx15nVRATeL9
         7iyyCaPqmvldLwpRMyp0htni0SZEV4u4OI4qfBEW6HWqHVHLVc5W8HKeaGjxIM8yt4Fm
         2RoJIpxsmiLVPR/Z8uHxgKEsV2lxWKR3b1PpYrUAu0L2acGRkWanuOWzRhkdl5XAsvFW
         8bCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=8fOVuMvog03Gd8YXtpGpvyC4PdSm9Vqpucv1aUR/nPA=;
        b=sZBityhqKMatfZ3geBdgJ5CGm8E1nHv8Nq/nYjbu7PJKoMFcYOqOftQwwiXe7HH8pK
         TbRKOxLR6MCa1Fxw3UxGqtqMKWjHsjftqytskw02SlTBRSi67tI1xwlnzCRHXh8Iazzo
         CxpCMfY9bM2BE6HaUk5HSHajIqOo72Fij4vF034Yiyb4yGgmOJu5pzC2iqyK64BtKByW
         1RPNBMR3cL0tR/7ba0z8b04iDU1JtTB/x03ToYqZEewlQTym+zrIoeBA3yB91/rJhqW1
         BeiC9uhx7PTg93sRXHP9rOx+xOrqQcqgJBUP4goESZEzY6zspGfevP9A+1KYzGfIrZJi
         orvw==
X-Gm-Message-State: AJIora9COR2s9tWDWI5s4/md7KsGL1yK/Lw//+9e0m7CPLgCWo69Bwpt
        ziPRN5n7ULLo9/L7NmDOgQ8=
X-Google-Smtp-Source: AGRyM1t2TlvqgRw5nliMKZTSZ8HJX01qHBpVn4dnu9xL5qFhZ/UzdtK39K+FVDkJGIUroRZ/o0OUWg==
X-Received: by 2002:a05:6402:2b88:b0:43a:6c58:6c64 with SMTP id fj8-20020a0564022b8800b0043a6c586c64mr26292497edb.348.1659531910419;
        Wed, 03 Aug 2022 06:05:10 -0700 (PDT)
Received: from gmgdl ([2a02:a213:23c2:bf80:c530:8f19:38e6:f393])
        by smtp.gmail.com with ESMTPSA id r9-20020a17090609c900b00722bc0aa9e3sm7246581eje.162.2022.08.03.06.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 06:05:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJE3f-009T6S-2Z;
        Wed, 03 Aug 2022 15:05:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>,
        Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 02/10] t4207: test coloring of grafted decorations
Date:   Wed, 03 Aug 2022 15:03:30 +0200
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <b5eb110958baa80b72a345b3c850f1dfceabf076.1659122979.git.gitgitgadget@gmail.com>
 <220803.86y1w5g7r0.gmgdl@evledraar.gmail.com>
 <CAPig+cTUTXuBov4m0xvxehVFbbPjVPrAHAFfPWO5Yv4C9imyaQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAPig+cTUTXuBov4m0xvxehVFbbPjVPrAHAFfPWO5Yv4C9imyaQ@mail.gmail.com>
Message-ID: <220803.86les5fpfg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 03 2022, Eric Sunshine wrote:

> On Wed, Aug 3, 2022 at 2:32 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>> On Fri, Jul 29 2022, Derrick Stolee via GitGitGadget wrote:
>> > +     sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
>>
>> {10,10} in a regex is just {10}, no?
>
> I'm more than a little surprised that this regex repeat-count notation
> works on macOS `sed` which, in the BSD tradition, is rather feature
> poor. Testing it, though, I find that it does work, even on my
> relatively old version of macOS. However, I'd still worry about other
> BSD `sed`s in the wild.

It seems you missed it but we already have this code tested "in the
wild", i.e. the "new" code here is really just copy/pasting test setup
from above.

So maybe we want to change (and you have some good suggestions here),
but it's already shown itself to be portable enough. We've had this
"sed" command since v1.7.2, or 567102819ac (Add test for correct
coloring of git log --decoration, 2010-06-29).
