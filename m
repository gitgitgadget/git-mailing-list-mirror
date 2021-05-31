Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E10C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7312C61186
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhEaTXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhEaTXW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:23:22 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF32C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:21:41 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so12012666oto.0
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=3JduFIpeV3hCJjq/q4RZCx8tllNH9q8vwehTy7Jjy1A=;
        b=gV1/7DZkat4vKKfom1kjCeCOUandcdkw2Pa76/WziKCeLjrLMIC9pjtaswB/lYTgdH
         MWF7oEXCCZowfL1zbJqrrNBTHZp9GALF4q0310Db0vhOhQtp/MOqfdGo01XCnzoHb5Lm
         yg45f0ETwr0627yJnjq2efm3TyrnLlYMJ16p43EBNRyYU6TEB50KZuEdLJz61eEIwnVZ
         0hV4N3tHL9b87HL1vmzYuN0fuJ6B4k2FJDWaF9hc3xJQV0PerOLRkS5jGnQrB9YIcLji
         LgrvcyAkeXXNzsvrCvxEOpRJpVyr19Qxk2AQr9/VRHwoDdCneysLOt/V4nivY2Sb6sCG
         axiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=3JduFIpeV3hCJjq/q4RZCx8tllNH9q8vwehTy7Jjy1A=;
        b=fUa7yWMqsXtgjGyinbRBl9YsuGvZbLVpRXe1LFc+f6LZopu/8TRVjd5ZFg/NTFMYRb
         BRjjuYZzDgMxB5qGUbq90lcpnR6+J7mxVRxho48FO1d34aFiNBKce3Rov++Ayv2e3Piv
         NpumPXTzKeQXVFTmYLNb/bfG73TXViuoKCjsWb1cnkmzUQoFGemy9sq4h34x+KHpAJNd
         OB3UDP0C7U1e9ddoEQtzamJFIpDr36uOK8KMC+4SiXQUQUVeC5ujkIF8vvJ2N//IdFM0
         miDD64UydHpWEi+IDrbj5gih82yP/GWesjwEupGaanyUGpxeQ2Edj2szsPYEcFFGTurk
         ttCQ==
X-Gm-Message-State: AOAM530tETfSmUdfwPi+dg3OilK8LHUgDLnXSqeTJFFfrUci8GNICPxl
        mSOEPQdQlFT3jn336nUzwpQ=
X-Google-Smtp-Source: ABdhPJzMc7btN2x+oRNg8ChgYQ7WNi+ZkFJVm+fzkBLnpF25buDnQILlcElqq+KGGcqlNSJCVVoqIw==
X-Received: by 2002:a9d:3644:: with SMTP id w62mr10239403otb.205.1622488900414;
        Mon, 31 May 2021 12:21:40 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id s24sm2974673ooh.28.2021.05.31.12.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:21:39 -0700 (PDT)
Date:   Mon, 31 May 2021 14:21:38 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Message-ID: <60b5374298413_312ef208a0@natae.notmuch>
In-Reply-To: <87fsy7lqve.fsf@evledraar.gmail.com>
References: <20210527000856.695702-1-emilyshaffer@google.com>
 <20210527000856.695702-23-emilyshaffer@google.com>
 <87fsy7lqve.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v9 22/37] read-cache: convert post-index-change hook to
 use config
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Wed, May 26 2021, Emily Shaffer wrote:
> =

> >  Part of the linkgit:git[1] suite
> > diff --git a/read-cache.c b/read-cache.c
> > index 1b3c2eb408..6a5c9403f4 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -26,6 +26,8 @@
> >  #include "thread-utils.h"
> >  #include "progress.h"
> >  #include "sparse-index.h"
> > +#include "hook.h"
> > +>>>>>>> 9524a9d29d (read-cache: convert post-index-change hook to us=
e config)
> =

> This adds a conflict marker, which is removed later in the series.
> =

> Obviously a trivial mistake, but it's a good idea to use git rebase -i
> -x 'make test' or equivalent for such a large series, perhaps there are=

> other inter-patch issues lurking here...

Ahh, thanks so much for this. I've often wanted to do this and sometimes
wrote simple scripts. It's good to know there a straightforward way from
standard commands.

That way I have less excuse not to do the check... and I just found a
couple of transitory issues on my latest patch series.

Cheers.

-- =

Felipe Contreras=
