Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57982C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 21:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiKIVQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 16:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKIVQR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 16:16:17 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25503120C
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 13:16:16 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 11so15017407iou.0
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 13:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBIeGwL6lgbyj3CjYwON/AET83+SoU5NEfei50nn9Qs=;
        b=cI63en9ic6FnagEyEMu9VU01ROrnYa8njOnsKoaU4VpowQqdmyvFwsqUcvgl2RhLMM
         4PVYqn/fBxk7Z09O85KnDilJTqL3YN7RYfjtBOVvQYPSzc896K4i+rGf0qMzUyXfpnDx
         8CK53AWualL9Njpcv0RM2mc8YYkdlDbva5tNR3jjrVIH1L/BubiwwFacxtKIuvssU3ic
         6hPN6crN4s1GbRLwIuxJ5YRC7Z2BgtpPhqBhOPip9m8qt/KcI/EvCnQlvAHB+D9wdTen
         zYlUxMmYhVOQC7gbP4E9cpmvrpyjsBGiYE1+V5jIu36RPQ6fz0txIkqghEEsmrSkbgPs
         +W2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBIeGwL6lgbyj3CjYwON/AET83+SoU5NEfei50nn9Qs=;
        b=sTfQnrE1XFAGOec65SRCsJebPgYWBuzJgqWOP9xnpDHjJ4/aHCcEyEcFRWKMifUVcn
         11i+U7PEojt6/X+yo2q26WTKR5jFfyKD6ZBFLIxot8YuaW1WOZ0Vh+CwYzsE6qv2EvxI
         5eCtzZeV6ZN7Hh0FMDx8xETu3DVHQDkuh5Xx60YihwlpRH/57Hhez2H9yphOX8oCm0pl
         anbZVhZmabfTkj98Xp+/Ilnc5D6QIpP0IHl/AruS2hcLYVJQQvuicN4wPwp+D2629mmv
         hOwvzsbR4KqRKP2d9m+FZ5zgNM0PWc1gmyeYVHvZto3/S73QHdOKcoIVZHuWG8PkTH2Z
         Jz/Q==
X-Gm-Message-State: ACrzQf2oWzmh47qVlhM8jdwmeZJZhSJF8GqU48ej16nwrJKU4241iQYX
        s4+89NWCzP+t+r+ma4NqhNBaubXDcwp17A==
X-Google-Smtp-Source: AMsMyM7LCz1ilfeX8Dk0KIio7ZI4XoWXV8LskY7QiC4CqPc9rOVTYD1fUoK+JptvA0Jmj59gqtE02w==
X-Received: by 2002:a05:6638:4784:b0:375:5b8e:4ae4 with SMTP id cq4-20020a056638478400b003755b8e4ae4mr2189213jab.93.1668028575956;
        Wed, 09 Nov 2022 13:16:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x15-20020a0566022c4f00b006cb4c036d6asm5816717iov.36.2022.11.09.13.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:16:15 -0800 (PST)
Date:   Wed, 9 Nov 2022 16:16:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 0/4] git: remove --super-prefix
Message-ID: <Y2wYnpASncR2E0Ja@nand.local>
References: <20221109004708.97668-1-chooglen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221109004708.97668-1-chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 04:47:04PM -0800, Glen Choo wrote:
> *Note to maintainer*: See "Interactions with other series".

Thanks for the heads up ;-).

It looks like this series is broken, at least in my application of it.
On the first patch, running t7401, for example, I get:

    BUG: builtin/submodule--helper.c:121: cannot have prefix 'sub/' and toplevel_cwd_prefix ''
    Aborted

after running the first test (-x shows that it happens after running
'git submodule summary', unsurprisingly).

I pushed out the result of what I have to the 'gc/remove--super-prefix'
branch of git@github.com:ttaylorr/git.git. As you'll see, the base is
'master' (as of 319605f8f0 (The eleventh batch, 2022-11-08)) with a
--no-ff merge of 'ab/submodule-helper-prep-only'.

Let me know if I'm holding it wrong.

Thanks,
Taylor
