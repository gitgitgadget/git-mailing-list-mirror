Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02872C433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 19:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbiBRTaz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 14:30:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbiBRTay (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 14:30:54 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE60135DD7
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:30:36 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id p14so17180855ejf.11
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=eTYBs+z/ZhFe6oHIBF3iqFVW4gy6MLBvbnkHAvd5PyE=;
        b=GF/WPDZHJJxtJzl26U162OBHggTWgd0TWtnwD1xi2UNdGDYOhKdiZgtzRzjtbJxcot
         XDkMBdl1xZojzjcpQVmsVkwbDe0trt5FKXeq5xSefGsUEL6EUJ79gxwZfbz8WptxO6li
         +wvNPmRdggto3J47GmtLU0bxeCzyeNO8GFH/ofSGQcDqcwG3qb61E4PEF44i310dco8/
         /kV64z6SPmgPV/G5reykUX3vQuX/u2/5mJFcsuJ2HWv8UojotPlhQ2LY26Dem31CrTC7
         M+m/2K28NcSPyjOSE1Do2Lc/Jhk/bKBMKywgilu9yN6yQpL2r4txfVLM14u1Es7yFKgH
         6wNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=eTYBs+z/ZhFe6oHIBF3iqFVW4gy6MLBvbnkHAvd5PyE=;
        b=Opfqfsf1kXOPmLViC2kfE9y6DDK1lYyYYMGDNC0qARqJGAeFaKLQ+HfKaIspA7yheG
         9G+tcaBDkXXAT/Bv4OOmt/KuKgWCEXlQeWt8+k6GD7cfU4zw0Odai52D4vdMhEbrki2J
         vaI9NAqBmPe/AOuOSJ3lRsjfduTTFHpVgLRbqukp2KqWA5V6QKsAnUFS2H3734EtuBpC
         Iu9NDdpU4qWEnPEvvqqvcAgY7JfDInnwYhcQDiYBoJUZ1XcW87hMr/HpeFCk/7Fw40zc
         pvShkTpB2QxOqI43NbqjDnvlKDjPAjsO8ZJydxrTxoYV4A58+cwca9W74hdK6NiVMKwt
         6ZPw==
X-Gm-Message-State: AOAM533Q0IyU/WPm21s95SWkjNKESmOEC/IyfEDcwAafBSXaSPuBWdLu
        mwQPliG2xWp3nUZ/O5i1+Wh8EM2sMCc=
X-Google-Smtp-Source: ABdhPJwZiGFRK/m+MuEe4lJ0lU/JXejcjPpPr2w9i9c0w1e7CBtgGCnpXrLozPIOJCUkVz8OO49bUA==
X-Received: by 2002:a17:906:6547:b0:6bd:e2ad:8c82 with SMTP id u7-20020a170906654700b006bde2ad8c82mr7620698ejn.693.1645212635054;
        Fri, 18 Feb 2022 11:30:35 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r2sm2521557ejo.65.2022.02.18.11.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:30:34 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nL8xd-004MQG-TC;
        Fri, 18 Feb 2022 20:30:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 0/3] libify reflog
Date:   Fri, 18 Feb 2022 20:29:19 +0100
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
Message-ID: <220218.86k0dsgeg6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 18 2022, John Cai via GitGitGadget wrote:

> In [1], there was a discussion around a bug report of stash not recovering
> in the middle of the process. It turned out to not be a bug we need to fix.
> However, out of that discussion came the idea of libifying reflog. This can
> stand alone as a code improvement.
>
> stash.c currently shells out to call reflog to delete reflogs. Libify reflog
> delete and call it from both builtin/reflog.c and builtin/stash.c.
>
> This patch has three parts:
>
>  * libify reflog's delete functionality and move some of the helpers into a
>    reflog.c library and export them
>  * call reflog_delete from builtin/reflog.c
>  * call reflog_delete from builtin/stash.c
>
>  1. https://lore.kernel.org/git/220126.86h79qe692.gmgdl@evledraar.gmail.com/

I just reviewed this in detail, it's very nice to see this done &
another shell-out in our code API-ified.

There's at least one bad bug here (but easily fixed), and some nits
etc. that I suggested mainly to make the diff easier to look at locally,
but aside from those minor adjustments this looks very good to me.


