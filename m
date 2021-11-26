Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B4DC433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 14:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377812AbhKZOQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 09:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352281AbhKZOOv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 09:14:51 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B24FC08EA74
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 05:26:31 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r25so38871283edq.7
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 05:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hPKm/uiv/3GaIMgIfGTVKY2LWZD4VSd3ns8abN4ndug=;
        b=RTGtGe/2WLerNh99nKDMCgeeEW16IVda8ewNhhEduyh326e7cr22imnfAiWld0ah5L
         D97dhcu1SYj8GFYfvtMnHv16xZeV/lG5JbVkOyI/rQCUl5/R5fMm4czamNV8vpCwOvS8
         /AsxR0E/sqjiEjZVvOC6ydfUxcvKCw2ybY1pXPYOEBEaKpJFTcxVis8gXsDYB2VFdlv/
         Do3CihLHatX6saRfSdpGSMbyXlUOiEA4BCQwNUYCL1jHQWCB8s6+V7ofTG0PPajvEWn/
         uAX0NEvHK6gCn7At3nC4U/cL1qWe6Mq/p5AvU7UD8UR6gaRbMsHFbttsaW89vIRSyD6N
         Iyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hPKm/uiv/3GaIMgIfGTVKY2LWZD4VSd3ns8abN4ndug=;
        b=vXzgT4MIHjpXMRnteM2+cICe8SfDzcUJV0eSWmKXOWBWA7KXtw8t5P+DOI8AMotLtk
         ga78gmTgiuD/JmmXGDFxaZxefjYPdcAG6PxfcQ48+sr3jIGygQ9+RTKVzRKSYQAmX2f1
         JSwXHwb81qlH+pAIsMsfbwvZQrTAtAJOkcnhbk9QW0QkY1eOb1PdVv2MI5KcdnBLvARF
         uMiAJOE45oi9elHgiGoYfdGXzjW3aRU7hOqKUIP1Srge8Rocd15/Vmke2Fx6Ii0t9rTc
         GgersPQWHlWRRMe/xUS6gZt59HPF4Ip5mRjRdaqm7GalghKhM+kvxmpDfqBrCxh5FnuB
         zzrg==
X-Gm-Message-State: AOAM533f5ZZuAkcodiTNaJQc42XznJXTgiohy7m6nrntptoskrbcqPPG
        dhRPs+kO5DAWcZCUDEoVeUhqT272O8x4Mw==
X-Google-Smtp-Source: ABdhPJzS4/Nh5EKF1iPuQVV4DSogfJUBCY7cZhpTEih1ne5fe1rANV8AxEESQMdu8ZR8DJWKC0cigA==
X-Received: by 2002:a05:6402:278e:: with SMTP id b14mr47673364ede.354.1637933188763;
        Fri, 26 Nov 2021 05:26:28 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hd18sm2917538ejc.84.2021.11.26.05.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 05:26:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mqbFD-000QM3-KK;
        Fri, 26 Nov 2021 14:26:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: bc/require-c99 + jc/c99-var-decl-in-for-loop (was: What's cooking
 in git.git (Nov 2021, #06; Wed, 24))
Date:   Fri, 26 Nov 2021 14:11:36 +0100
References: <xmqqlf1caica.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqlf1caica.fsf@gitster.g>
Message-ID: <211126.86czmnhwu4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 24 2021, Junio C Hamano wrote:

> * bc/require-c99 (2021-11-18) 1 commit
>  . git-compat-util: add a test balloon for C99 support
>
>  Weather balloon to break people with compilers that do not support
>  C99.

It would be nice if they'd upgrade, but maybe breaking those people is
going a bit far :)

> * jc/c99-var-decl-in-for-loop (2021-11-22) 1 commit
>  - revision: use C99 declaration of variable in for() loop
>
>  Weather balloon to break comiplers that do not grok variable
>  declaration in the for() loop.

s/comiplers/compilers/

