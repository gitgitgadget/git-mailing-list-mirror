Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DDAC433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 20:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKDUqA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 16:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiKDUp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 16:45:57 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E9F3135A
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 13:45:56 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z3so4746785iof.3
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 13:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sH84NP7Z4+aOEDQl/EgEp1YBvQSxVnJI2wNqGk2X7AI=;
        b=zSEoexo10Oki3p6NgkMKL4sLMm55xk04LHPZUIFEMD02CxeYwInI2WgVlU/vVu1q3K
         xY5vu1gCf0N+npxOaLaJOLtiIjZJ27r5J42foLjm6/LULoM9yuFUT8O/wXESMmPrNWSQ
         vekFEJUEfli1p5PEMHCWqWlx7pV5D5bIUJMDP0cTHKOadX/TvhDOSHsbQ8IPvD7k8380
         Othgehu5ZtQuJJHls90LP4REpGGbA0ZaBWAS5wYc5gxrIhdgHAa64Kmkb+LHcbBji3Ip
         Pk8fQce0H3QuZM/q15HheftMH+XSRluB5bIQapiQIRiXABGKdTtjXMW2CQpF44JvklyA
         awpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sH84NP7Z4+aOEDQl/EgEp1YBvQSxVnJI2wNqGk2X7AI=;
        b=ZNKLDayEXWWOuLcl/NzbQwZJkooY4g70z5Nlx3w/RqbI+KyrxaVMTRtkZQZV3BgiMm
         WGR2D/KblmzT8NbRVhNijuvyDYB/VrhaN/IrYbO0HMwoZZa/pAEYtUGEGMPC5QuhVTi+
         u/UBufkXAbo3iJdy50TqnirAZhkgfy16rUYl6sV1n7XZQ5s0qk4qL1Dcww/tmEKse5fX
         jnBg74gQxpFcnT9RDkTrCifW3qqzb2Tm6A+CMygSawCjckeS7uMQUwuRImajp3cT8GwN
         06Ih4zxhZyUosBMvk3GE4IFJSN7N2Ko6D/STf2CPUooNHIp0gZuN0qDDJwfOdwN8Az0H
         XKgA==
X-Gm-Message-State: ACrzQf2radFmQFimC0Vz/MSHHJ1PJTYIotEf26S9RbysgCODWMU5HSSX
        xKfvwaeIIe9AbMBFcoUbCudxFV7XUGRQXaoe
X-Google-Smtp-Source: AMsMyM4xF3raCENMFyTFvKtnI/bjKTHaKkYmJxPYCkkqfqxENYLqzdr9bGVZXUoyzArKe+yr4UuRZw==
X-Received: by 2002:a02:9f02:0:b0:375:6038:ab7b with SMTP id z2-20020a029f02000000b003756038ab7bmr17674169jal.100.1667594756139;
        Fri, 04 Nov 2022 13:45:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w8-20020a029688000000b003754d61acc2sm9971jai.44.2022.11.04.13.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 13:45:55 -0700 (PDT)
Date:   Fri, 4 Nov 2022 16:45:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jacob Abel <jacobabel@nullpo.dev>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] builtin/worktree.c: Update checkout_worktree() to
 use git-worktree
Message-ID: <Y2V55Mx4aC1r/0gj@nand.local>
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104010242.11555-3-jacobabel@nullpo.dev>
 <221104.86sfizzeq7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221104.86sfizzeq7.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 02:32:11AM +0100, Ævar Arnfjörð Bjarmason wrote:
> > @@ -357,7 +357,7 @@ static int checkout_worktree(const struct add_opts *opts,
> >  {
> >  	struct child_process cp = CHILD_PROCESS_INIT;
> >  	cp.git_cmd = 1;
> > -	strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
> > +	strvec_pushl(&cp.args, "checkout", "--no-recurse-submodules", NULL);
> >  	if (opts->quiet)
> >  		strvec_push(&cp.args, "--quiet");
> >  	strvec_pushv(&cp.env, child_env->v);
>
> Won't we now start to run the post-checkout when doing this, and is that
> intended?

Beyond that, does the change between `reset --hard` and `checkout`'s
treatment of modified files in the working copy matter?

I don't know enough about the worktree code off-hand to know if this
function will ever run in an already-populated worktree that may be
carrying its own modifications.

Thanks,
Taylor
