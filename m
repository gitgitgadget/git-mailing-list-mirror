Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F23C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 12:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiCCM4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 07:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiCCM4J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 07:56:09 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FF1F65C1
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 04:55:24 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i11so6464600eda.9
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 04:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=C6Jcv4RlRDyPafANSuxBdBis50GxKk6fUFhKHuAi54Y=;
        b=A/VAfONHAAsgnUBCKGqsfigXS2ltqRBgGo+xvDggsvUudtM4VhbgtP+9ovXcYjZxD+
         FmRNa2ue4wtB3qya2xRWgP4rNMwJe1f9K2PPzzP4vwAV60sdEzSn+nEZvNRUTs7poWJw
         KSa8US3UV2pQ8tZnYT9CJlG1O0/CNoTIpWgrksPKOzBpceWwxYFNYdwBUZAQ1lTCFTHn
         gxLbO0RkbHfTKrQ3hdvpyrcPzyIuyUqAd6nvO1HLoF1gzkz8UytcMEJSts7JU/RVaT/h
         zMYI+NqPmsYUlbfBiwbIdZbKRGRPsvh21M/e+vW5gBuBBaS6W7bbZJuVHqwJsix8kQHn
         gy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=C6Jcv4RlRDyPafANSuxBdBis50GxKk6fUFhKHuAi54Y=;
        b=KLm3bBrlfgYFFcw0f7p1h62B4Ts+rGc0EY7sBLxu39l3o2aKXP6GTGRtehCgRlPbCv
         yt1hfujZWHJs0lGNxosbsIy9D9n/R98u3kWk6XM2f1nZrgaYD5rmeHxmkwXrD4gEpMYb
         uuSkaciUAGHs6R/ugzwXLj1PyRDRwdFRKfbFAoMP3rsnPLYy6Rl7OFRzKTRfRCw7W5/l
         /wrhKAZLFEvvUuCxZa2WchWThE6/DeHHZd95TJSA/t6l8Rk1o/S8NlvZ5yGCS2m8QXv9
         i+cE6lhLdYSjieO5+Y3Nfr6EaYFZw4kUj4T2+iBQHJszLaKs96pu1lb9LOT8RsvPeJd4
         fJPw==
X-Gm-Message-State: AOAM5315587T+NviDW9SyR2elggNp2Mv/QT+ob3Z36eOBN6AbsUfnL7z
        AwAJvxxBTknTSW1ofnFUc8k=
X-Google-Smtp-Source: ABdhPJx7T0AaNwfFaEbf0R3UCJO//ZmsEe/Hdg+UxRNxExvV4nWklF7v33t/bHysmbMGOWJwpsOAZw==
X-Received: by 2002:a05:6402:5cb:b0:415:e04a:5230 with SMTP id n11-20020a05640205cb00b00415e04a5230mr2376696edx.352.1646312122337;
        Thu, 03 Mar 2022 04:55:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a4-20020a170906274400b006da9456e802sm484551ejd.102.2022.03.03.04.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 04:55:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPkzH-000VO9-IG;
        Thu, 03 Mar 2022 13:55:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>, Josh Steadmon <steadmon@google.com>
Subject: Re: What does it mean to have multiple upstream tracking branches?
Date:   Thu, 03 Mar 2022 13:54:38 +0100
References: <CAPMMpoiTJAuadBEOPWOVa-kguSXMDvAhvD22B63QwYpu=H7xEw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAPMMpoiTJAuadBEOPWOVa-kguSXMDvAhvD22B63QwYpu=H7xEw@mail.gmail.com>
Message-ID: <220303.868rtr42mg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 03 2022, Tao Klerks wrote:

>  Hi,
>
> In my recent attempt to create a "simple" branch.autosetupmerge
> option, I have repeatedly been confused by the enforced rules around
> what is and isn't valid for the branch.<name>.merge and
> branch.<name>.remote configs.
>
> Until Josh Steadman's recent work on --track=inherit, the "automatic"
> addition of branch.<name>.merge could only ever result in a single
> entry.
>
> Now we support multiple entries being added as a perpetuation of an
> existing branch's setup - but what does it *mean*? I could understand
> if the idea was to have transparent tracking across multiple remotes
> that are supposed to have the same content (eg a single server set up
> over multiple protocols), but that does not appear to be possible -
> branch.<name>.remote can only have one value.
>
> Is there any documentation (or could someone provide pointers) as to
> when multiple branch.<name>.merge values can make sense and what that
> means / what it does?

Can you point out some existing tests where we end up with multiple
*.merge values? I looked a bit and couldn't find any.

Or maybe it's only possible to get into that state with some command we
have a test blind spot for?
