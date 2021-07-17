Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7571C636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 21:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7633F610A5
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 21:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbhGQVog (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 17:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhGQVog (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 17:44:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F24C061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 14:41:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h2so17774147edt.3
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=yvqhlLkZpX90E2k8OBA33nL5yllhvtz7qcjbv0rJsy8=;
        b=qxX0bXoffYYgT3936ellIMNy+JPaxhuSgmDgGLjlQrSBwnJ7eTA3CSCuSzNf+uSFeE
         7UXJjfvV+3XAusnYP7JmorlgHRpRQ0bx0sIEy14CYwsyJw/pzj81mygsFHq914Lrk0rP
         2NuXIs3FvBh37XYi1dySBLPgIg9wQeJit59zsgf4ze85GfsN4M0ADdWTS9S5YpTgBLyF
         oxpW6/HpPcaR87vLdRG1mZiGEdbOXfFeAc4dkIJwIBRyE5Jbnn9CnFejq9Pm+k7RV7np
         NDxZBSd0ZU+DAe86ferTEgcyUXV2XchjieOMyEgYFOvffYhgfKBJYGfglFiccFEWKAKa
         YI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=yvqhlLkZpX90E2k8OBA33nL5yllhvtz7qcjbv0rJsy8=;
        b=QIbmc6nc5rkQI7DoG1zM8zi2EAolMhSl4S0jpD1gGnXJqNE9M2gLo/V5rlvETL39vI
         uPezTVJaZzUxuBOgkiEtl4ttt1bz7RWYbFZcEvxnyJ9Xc57cqXy6zraMRIu0L7eAvG96
         qaKwbqHyhqoHbpg2686gAyPjr/3lkr0FUyv0KpUhpLXjsMnEXBY4ycIkw9GPaik4AjYc
         diM7FBrkxLkUZuaxWe7+wJ+lGX4S2QhrkK6a1g5xt5M7o3fdWOt8DNU7nLp5e0hvjf51
         WjF+oBaH2QX7RclVDD7PBxqXObI0FgWknkA30vJcBHa9Y8vDksRMUB5UzXBBL6uoE21x
         jl1g==
X-Gm-Message-State: AOAM533mlggunE9QigLLJuUAhIXmEZSw71Add/A20+YS/d/xsPxerEiv
        pl2IyMQV1L8Bug4EQUf0/ZM=
X-Google-Smtp-Source: ABdhPJzeZJ/HhbiLSr7wsHa3CGvwqlrOTm4XMH3nUNatgHMtzyW4Vo0iQWufdoCRhtBShh2hBXVxzw==
X-Received: by 2002:a05:6402:198:: with SMTP id r24mr24435631edv.93.1626558095724;
        Sat, 17 Jul 2021 14:41:35 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c17sm5397243edv.6.2021.07.17.14.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 14:41:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] refs file backend: remove dead "errno == EISDIR" code
Date:   Sat, 17 Jul 2021 23:36:59 +0200
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <YO8PBBJZ2Q+5ZqFs@coredump.intra.peff.net>
 <871r801yp6.fsf@evledraar.gmail.com>
 <YO9wCqetxHii+TvK@coredump.intra.peff.net>
 <875yxczbd6.fsf@evledraar.gmail.com>
 <YO/EpxU0NG+HVSlx@coredump.intra.peff.net> <xmqqk0lppw49.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqk0lppw49.fsf@gitster.g>
Message-ID: <87mtqkwrc6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 16 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, Jul 15, 2021 at 02:02:40AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>
>>> > Maybe that is splitting hairs, but I definitely try to err on the side
>>> > of caution and over-analysis when touching tricky code (and the
>>> > ref-backend code is in my experience one of the trickiest spots for
>>> > corner cases, races, etc).
>>>=20
>>> I'd entirely forgotten about this, but I had a patch to remove that
>>> "oid" call entirely, as it's really an unrelated bug/undesired behavior
>>>=20
>>> You also looked at it at the time & Michael Haggerty reviewed it:
>>> https://lore.kernel.org/git/20190315155959.12390-9-avarab@gmail.com/
>>>=20
>>> The state of that patch was that I needed to get to some minor issues
>>> with it (commit message rewording, cleaning up some related callers),
>>> but the fundamental approach seemed good.
>>>=20
>>> I then split it off from the v4 of that series to get the non-tricky
>>> changes in:
>>> https://lore.kernel.org/git/20190328161434.19200-1-avarab@gmail.com/
>>>=20
>>> I then just never got to picking it up again, I'll probably re-roll it &
>>> make it a part of this series, then we can remove this whole OID !=3D N=
ULL
>>> case and will be sure nothing fishy's going on.
>>
>> Yeah, that sounds like a good path forward. I do think the patch under
>> discussion here is probably the right thing to do. But it becomes all
>> the more obvious if lock_ref_oid_basic() ends up dropping that parameter
>> entirely.
>
> OK, so what's the final verdict on this step?  It is unfortunate
> that when =C3=86var took over a topic from Han-Wen, this patch has been
> inserted as the very first step before the patches in the series, so
> until we know we are happy with it, it takes several other patches
> hostage.

I'm just interested in the end result landing sooner than later, so if
you think this re-imagining of it hinders more than helps I'm happy to
discard it and just take the last version Han-Wen submitted, i.e. the
v5:
https://lore.kernel.org/git/pull.1012.v5.git.git.1625684869.gitgitgadget@gm=
ail.com/

I can then re-roll whatever I've come up here that I still find useful
on that after it lands.

I just thought that given the complexity of the ref code tying any loose
ends up before those changes would help, but maybe not.

Anyway, you/Han-Wen let me know. I'm happy to re-roll what I have
outstanding here based on feedback, but also just to discard it for now
and go with his version. I'll hold on any re-rolls in that area pending
feedback on what you two would like to do.
