Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A14EC43334
	for <git@archiver.kernel.org>; Sat, 11 Jun 2022 09:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiFKJBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jun 2022 05:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiFKJBi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jun 2022 05:01:38 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8290B527C8
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 02:01:35 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n10so2148338ejk.5
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 02:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gV02uQB3JcktgAlyPmzGxwBhVnBGyYPh5gr51e1685U=;
        b=kuMLkpIZX1DrT39DTJzD/9xDaVCNiDz9OPhg/fyuGpYy80WTafuaptErU2/2xGawKZ
         3r702x8uXHs8NoEHhlBGeG3u7lz4F/6dSZxTCddU/K4VAKj2Jp6neDck4yMSPdQvf9QI
         xS5Q+TyvRIT6tJXR5Yn61+rTgtmuqUt9M9bP1kwaNEU+sdyxMQdI7smkJG/vKBaRbaV8
         e5UdzlJPW5Ru+ZFyf+HtB10SZoqgo9wb1IJurnjZYQm/K8Z8wvHponJpd4ZspYSVsBKU
         Dcrqqt8Ecy5g7mcwnh5NcG+ycG9LNdGl00dmUQSLXfkHd1RlxmvUv8rPmLZNjjennMtb
         Fd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gV02uQB3JcktgAlyPmzGxwBhVnBGyYPh5gr51e1685U=;
        b=SCMOANUEEoqVllNzxYK40UmHnWkUnQc7p78bYhQhSpU86bad753sI6vcKNjuMEbACf
         YMqYk0vmWfmXsX7z/dQ91bcZZpdkbvr05AXbWEkcMV7c7F34xGze9AFqje6Jw14uPE1v
         15VZvu9PQYe+Lez5b71V6jR2Oecb7lnPQCVZA1TSXB9Y/jZFtPj1gztM6xzZ2bdzDTkA
         69CYr9bmY6s4NLvAEZreqcSJfi3+RObxRJmqN2niQKXE1oVc7syl5s0qMu85NWISEakQ
         EvZ/hkc9iFchVu872/v7KTcUtoxOz9v6HcIpR1bU1d73EQJ1yc5qXCUHLSXntQHyP+sx
         1kOQ==
X-Gm-Message-State: AOAM53245o02Ky2p3CB7kh2iZz+F2zrPDPO6b71ZCcx/Rzq0pC6U0e+F
        yuo7/33GlwAM0MnGqvnM5Po=
X-Google-Smtp-Source: ABdhPJwj2nIlkvrUAbmnjOFpPR1uGKMijLB4Zt5imNO21Kgf+JnXM/GA8XanwM1zWNv31Lk3p4qbHg==
X-Received: by 2002:a17:906:5e4c:b0:70a:4673:bdcc with SMTP id b12-20020a1709065e4c00b0070a4673bdccmr42707021eju.511.1654938093971;
        Sat, 11 Jun 2022 02:01:33 -0700 (PDT)
Received: from localhost (92-249-246-141.pool.digikabel.hu. [92.249.246.141])
        by smtp.gmail.com with ESMTPSA id bk19-20020a170906b0d300b006feb3d65337sm752760ejb.102.2022.06.11.02.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 02:01:33 -0700 (PDT)
Date:   Sat, 11 Jun 2022 11:01:31 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joakim Petersen <joak-pet@online.no>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH v7] git-prompt: make colourization consistent
Message-ID: <20220611090131.GB1785@szeder.dev>
References: <20220606175022.8410-1-joak-pet@online.no>
 <20220607115024.64724-1-joak-pet@online.no>
 <20220609090302.GA1738@szeder.dev>
 <736a5f12-2ab3-977c-8cba-45529e9ebee0@online.no>
 <xmqq5yl9lmgq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5yl9lmgq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 09, 2022 at 11:29:25AM -0700, Junio C Hamano wrote:
> Joakim Petersen <joak-pet@online.no> writes:
> 
> > On 09/06/2022 11:03, SZEDER Gábor wrote:
> >> This patch seems to break colorization when __git_ps1() is invoked
> >> from $PROMPT_COMMAND:
> >>    ~/src/git (master)$ echo $PROMPT_COMMAND
> >> __git_ps1 "\[\e]0;\w - Terminal\a\e[01;32m\]\h\[\e[01;34m\] \w" "\[\e[01;34m\]\$\[\e[00m\] " " \[\e[01;34m\](%s\[\e[01;34m\])"
> >>    ~/src/git (master)$ git checkout 9470605a1b
> >>    HEAD is now at 9470605a1b git-prompt: make colourization consistent
> >>    ~/src/git ((9470605a1b...))$ source contrib/completion/git-prompt.sh
> >>    ~/src/git (\[\e[31m\](9470605a1b...)\[\e[0m\])$ # uh-oh
> >>    ~/src/git (\[\e[31m\](9470605a1b...)\[\e[0m\])$ git checkout 9470605a1b^
> >>    Previous HEAD position was 9470605a1b git-prompt: make colourization consistent
> >>    HEAD is now at 2668e3608e Sixth batch
> >>    ~/src/git (\[\e[31m\](2668e3608e...)\[\e[0m\])$ source contrib/completion/git-prompt.sh
> >>    ~/src/git ((2668e3608e...))$ # Looks good.
> >> 
> >
> > While I did test this on my own prompt for v6 (which is identical to v7
> > in terms of code) and not see any breakage, I have the same issue with
> > v7. Maybe I forgot to re-source the changed git-prompt.sh. Either way,
> > The issue stems from $b being wrapped in $__git_ps1_branch_name and then
> > back into itself after colouring. Moving this wrapping to before colour
> > is applied fixes this. I will submit a v8 shortly.
> 
> As the topic is already in 'next' (and presumably that is how SZEDER
> noticed the breakage),

Indeed.  I usually use a custom git built from 'next' with a couple of
my forever-WIP topics merged on top, and I just happened to build and
deploy a version with this patch already merged the other day, with
the additional stroke of luck that I opened a new terminal window
(what I normally rarely do) whose shell sourced the buggy prompt
script.

I did notice this patch being discussed on the ML, and found the
amount of changes to the expected output in the tests somewhat
suspicious, but, alas, haven't managed to take a closer look before
the patch went into 'next'.  Still hasn't, actually, but FWIW Joakim's
fix (as 0e5d9ef395 in 'seen') does work for me.


Thanks,
Gábor

