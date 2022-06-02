Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9D1C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 08:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiFBIis (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 04:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiFBIiq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 04:38:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B6529A628
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 01:38:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id s12so1348844ejx.3
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=sdRIeGhRWY2aEfU+qdkUIxO6Qx601KR4vb/EjLwTcyI=;
        b=lS7Xqbt0BbciQxzQst1l2PEgRqmYcor0t5w8+GgSwwBShi0DZzOksirt9lB9dtHpIw
         mdf9gO4qPLWFLRxpKDn4x3VBDzzJDaWqzp7cMwnv4m2EQGZ8rmP8gNabex69HhvAlbfm
         hsdEVKlxf1UyVjqUdf7NlS7Pf5eSawZyIZwfOUl8Rl9z5m/eA4x+uzYNFcIcYlRQyZXS
         OgGHt8ztios8D9MavL4AMTseS6DAws34pXPhX9tb88GnxvlURRBqyt3Q/ujM8GqnnADI
         sogLtyYq+0ydZEykeU1e+wBj4S0gz8TJtMZC3dDCc8pXXTYv5MEQSsFzQJHpPXR6MWfT
         RJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=sdRIeGhRWY2aEfU+qdkUIxO6Qx601KR4vb/EjLwTcyI=;
        b=aRL+C8VNEeuDvXyuryulpJakdr8v+I41WadblzM1/1MhN60HOomtPEeet8Pnm+yDfY
         0xxFoOsHUcDUOSXy3umZ48yjpjUgtFkFhxmFK8vJbiSfjL60cwu+wta01peSyQwe6RVP
         5vinKyAwk54mpHy32Wuz5j/OhtBwUM+S5mQkFDfPrQfaPSR6oGD5tFIOfozZGgsxVLnp
         P1Jr17qJm9eRGsa5D11L67bNehey4d6LynGFurxsAYpTMTPMy7YgSJIRdNWjkJjHV0Pt
         XAmaNKGl99gLa0ck3g/OU67hQGPvnRyDthT/i2Wm7OHKyHIzUyu7I/jbMAk6qwb785VO
         2BeA==
X-Gm-Message-State: AOAM530BUIfRrEX40/FDuYzZGlf8TS5RqAOt6mzEoeRZx7twFa+XUz03
        uUgxAiBxdKJt0IMIbQD9QstWu633OsA=
X-Google-Smtp-Source: ABdhPJzoTHR42RM0T/65a0P9IBsl9MKKiIuwPwEyxNpIi2C7VZdfGaRcxT8/w3bOuYQd8nbRn2ao0g==
X-Received: by 2002:a17:907:1c8d:b0:6f2:eb2:1cd6 with SMTP id nb13-20020a1709071c8d00b006f20eb21cd6mr3130591ejc.568.1654159122955;
        Thu, 02 Jun 2022 01:38:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t20-20020a1709066bd400b006fea3702e56sm1523654ejs.79.2022.06.02.01.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 01:38:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nwgLo-001Ndm-P8;
        Thu, 02 Jun 2022 10:38:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: gc/zero-length-branch-config-fix (was Re: What's cooking in
 git.git (Jun 2022, #01; Wed, 1))
Date:   Thu, 02 Jun 2022 10:37:39 +0200
References: <xmqqee07q3xc.fsf@gitster.g>
 <kl6lfskneugf.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <kl6lfskneugf.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220602.86mtevzchb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 01 2022, Glen Choo wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * gc/zero-length-branch-config-fix (2022-06-01) 2 commits
>>  - remote.c: reject 0-length branch names
>>  - remote.c: don't BUG() on 0-length branch names
>>
>>  A misconfigured 'branch..remote' led to a bug in configuration
>>  parsing.
>>
>>  Will merge to 'next'?
>>  source: <pull.1273.git.git.1654038754.gitgitgadget@gmail.com>
>
> I'm happy to see this go to 'next' if =C3=86var doesn't have any lingering
> concerns over the commit message [1].
>
> [1] https://lore.kernel.org/git/kl6lilpke31e.fsf@chooglen-macbookpro.roam=
.corp.google.com

I'm happy to have it advance to "next" as-is. I just had a question
about if we thought this config existed in the wild, but that & the
answer can just live in the ML archive. Thanks.
