Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C1BC43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 00:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiFOAAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 20:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiFOAAN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 20:00:13 -0400
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F66289A9
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 17:00:11 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-fb52c59eb6so7881362fac.10
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 17:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=betBHBVLgXLzXsYi2c2mXzjt26AVH22e19KicZ5PlT0=;
        b=MQ0j/kygsh/ztZKG+I98cHQ2WCfCUe6VKSGhzCqXUzt4LsmI3vgORMx3T4woq4/FoH
         /soHUuCUPF/e/Dau4wJQFKp9zTJWK4tkxy2UuJ7DEYh1OCsXd02HJp7re9AtNEq4Tvqn
         oEWgjCoUmoNyb8VWj/QD08C6Kk+Yb3cuEMv7dSXfol9Azqi5C6tEPUGzfZN/q8XpQJ0H
         hehFrcvBvvD2WtOCWdf1BFIGS6VbXd9YVcP2Be+kj8CfYPcuxwODVIWOJQYheJOzaqyx
         h4TkXW1EbvWKAaTxJofefc7bdD2mD199Cn87zM6SVr40uJY8myZlKwAUrtUQZJ+te0KS
         7hSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=betBHBVLgXLzXsYi2c2mXzjt26AVH22e19KicZ5PlT0=;
        b=pCohB1oJ0oeaK0YSNk7RvKNHdrCKzHpdfXbCRp5BorI+tHgt/r3ZEcRNOjbQCXZCTL
         7qX+nuw/mjDm9vKWmxxUdSAp3w6usbuLv+nz0N+nk8SHdTZH0k0Ot25zL9uswaT2pGDL
         uidQ7WtW7cYg//HU6/r2PXdPXSik6Zl8OWCfB2p75AUFTEOSxuESDFMrZnEcv5uaYcgk
         ja5ydZUxj8cPyxtpRZ+2h6f9ZCa+l7bzk9DfF/6br2NDuOrFUX/CENpgt+Sp+rV+PTfD
         bw12XJX8Pw5FKb4cYb8BFvAUTR94JBvUOM9RU9LkpOcWh7tYwg4UdAnNoAKOcN2SLZET
         oQww==
X-Gm-Message-State: AJIora8MvY6EggVF88iGw2PLS0MY/mxpIgqtCHXzTim0ph/xSL7gLXNf
        BYcqXdKzKuC+75v6i90A8/4iVNCsPWKrQA==
X-Google-Smtp-Source: AGRyM1tZIkx2WOLLfo6g0ybcZ6tWDeiMzH47jivJcvJru1BAkNLlyv40IlZ1qTjVyALwpCorDLEBKOOvLgLPlw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6871:5cc:b0:f3:3341:3db0 with SMTP id
 v12-20020a05687105cc00b000f333413db0mr3900117oan.207.1655251209881; Tue, 14
 Jun 2022 17:00:09 -0700 (PDT)
Date:   Tue, 14 Jun 2022 17:00:08 -0700
In-Reply-To: <220614.86pmjcyv4u.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lsfo66bjr.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
 <kl6lwndk5ffc.fsf@chooglen-macbookpro.roam.corp.google.com> <220614.86pmjcyv4u.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v2 00/12] submodule: make "git submodule--helper" behave
 like "git submodule"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> [...]
>>> This is still in this series as 02/12. I think you've misunderstood
>>> that code, it *is* invoking "git submodule--helper" with
>>> "--super-prefix", but the option is passed as:
>>>
>>>     git --super-prefix <path> submodule--helper
>>>
>>> And not as:
>>>
>>>     git submodule--helper --super-prefix <path>
>>>
>>> This is thus handled by other code before builtin/submodule--helper.c,
>>> and it doesn't need to handle it.
>>>
>>> But anyway, this is confusing, so I updated the commit message (seen
>>> in the range-diff below)>
>>
>> Ah that's right, I forgot that we have to pass it to "git" directly.
>> Thanks.
>>
>> I wonder why we ever needed this. 89c8626557 (submodule helper: support
>> super prefix, 2016-12-08) doesn't really explain it, so it looks like
>> I'll have to dig around the ML.
>
> It was needed, but not after b3c5f5cb048 (submodule: move core
> cmd_update() logic to C, 2022-03-15) as my 02/12 discusses.
>
> As a quick test try to check out b3c5f5cb048 and apply this change:
>
>     -#define SUPPORT_SUPER_PREFIX (1<<0)
>     +#define SUPPORT_SUPER_PREFIX 0
>
> You'll find that t7406-submodule-update.sh passes, but check out its
> parent (which is a commit of yours) and it'll fail, as we'll then emit
> output like:
>
>     -Submodule path '../super': checked out 'e1c658656b91df52a4634fbffeaa=
739807ce3521'
>     +Submodule path 'super': checked out 'e1c658656b91df52a4634fbffeaa739=
807ce3521'
>
> So this is just one of the things that were overly complex in
> git-submodule--helper because parts of it had to bridge the gap between
> *.sh and *.c land, but once we moved more parts to C we ended up getting
> that for free.

Ah yes you are right, as of b3c5f5cb048 we never pass `--super-prefix`
to "git submodule" any more. Great!

I also remember that when I was reading the patch that became
b3c5f5cb048 (submodule: move core cmd_update() logic to C, 2022-03-15),
I noted (internally) that we used `prefix` to set "--recursive-prefix",
which was unusual because `prefix` is usually mapped to
"--super-prefix".

I have a patch to replace "--recursive-prefix" with "--super-prefix",
but it doesn't make sense for that patch to be included in this series
(it's preparation for something else entirely, and it won't make this
series any cleaner.)
