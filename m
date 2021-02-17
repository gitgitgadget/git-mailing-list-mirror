Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BDCC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 00:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA27964E0F
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 00:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhBQAsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 19:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhBQAsf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 19:48:35 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD2C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 16:47:54 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id w1so19467216ejf.11
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 16:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XdOiE0TpOhdQ/zlbocz61pm999AHWtCyQZJ3n1e6DaQ=;
        b=rsdyki8SWbzHlG1RzmpgFA47s90mZK1Vt6VcsyncFY5/K0BQQyix7JHROUjmz7AfGL
         hbOpe29NYuQ2etGT36z1KgKme9aSxVOJJ5NPTA2ACytSs19grmdDjBDtuCXmqHMayAQB
         41f+NYLDY1RBmwDUqTvzGKb0AksnWr/LJxIhI+0IvK/sw+HZlG+StKhrUHDWFEK3KMUH
         hsOdukzb2doPvolDqbJndzfgL30Oygz1r88TwAONjhOe2fRsDr0I9aKO6DM29EbUUedZ
         /O9NTYxzjnF181S8TDozDFjzCX4l9fAthQycYpqZEnCyYivJptTd4CZ147cwjwAyHhXg
         LazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=XdOiE0TpOhdQ/zlbocz61pm999AHWtCyQZJ3n1e6DaQ=;
        b=bxUUFInSIn7Dkg5jWkCmUpE+4OUo0QO+HfjBjAUjLYdyEV9Xng6p7+rl0atTZix9xN
         zpGzxPPEg2DMuaDoun2PCLg/GIsOM3uZHO6QHSzoT5uTyNNkGthMvAszvg8FKaBbVOg7
         J3R9ZubEEP06xC4mOKiRC1XVS3u91DcEcDtFj8vqAby/nZm+vWtL5u0vf2YuJW34s0ko
         vmzbVFnSs7mgaANXmqmpcXP+THcdLoIn/TwQF691wZCf5zu5deZrNTtsmdDtyEmAdE2w
         0XObqSxHXyVBUUZ9R3U1okvhDXcNokiVbGas/0r4qpR1qhshN0NjBSTV23NnP3ikO3jn
         lquQ==
X-Gm-Message-State: AOAM530UHh5zc/WX9hkU8nIB6p84JoAAnMXNjZ93uT3LtKnFHsXStIff
        KZRqXmGQb3+PV9B+Pb0a8nk=
X-Google-Smtp-Source: ABdhPJypyGXuD6FC94la0YmBhAL6dtuJzgIaoHdRmgB2XOoYVqP55TBF6ZTAYBNK0f1eNvHJK/GvYA==
X-Received: by 2002:a17:906:4019:: with SMTP id v25mr16822515ejj.531.1613522873560;
        Tue, 16 Feb 2021 16:47:53 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id bo12sm235640ejb.93.2021.02.16.16.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 16:47:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eli Schwartz <eschwartz@archlinux.org>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pretty: add %(describe)
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
 <87pn109nhr.fsf@evledraar.gmail.com>
 <xmqqft1vrgxa.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqft1vrgxa.fsf@gitster.c.googlers.com>
Date:   Wed, 17 Feb 2021 01:47:52 +0100
Message-ID: <87mtw3a5af.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 16 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Sun, Feb 14 2021, Ren=C3=A9 Scharfe wrote:
>>
>>> Add a format placeholder for describe output.  Implement it by actually
>>> calling git describe, which is simple and guarantees correctness.  It's
>>> intended to be used with $Format:...$ in files with the attribute
>>> export-subst and git archive.=20
>>
>> Does it really guarantee correctness though? In "builtin/describe.c" we
>> first walk over the refs and use that to format all N items we're asked
>> about.
>>
>> Under "git log" this is presumably in a race where refs added/deleted
>> during the run of "git log" will change the describe output to be
>> inconsistent with earlier lines.
>
> Yes, but it is not a news that the describe for a given commit will
> not stay the constant while you add more objects to the repository
> or you change the tags, whether the "describe" is driven internally
> by "git log" or by the end-user, so I am not sure how that becomes
> an issue.  If the output is inconsistent in a quiescent repository,
> that would be a problem, though.
>
> Puzzled.

Usually something shelling out has going for it is that even if it's
slow it's at least known to be bug-free, after all we use the command
like that already.

I just wanted to point out this edge case, for "git describe <commits>"
we do the ref list once at the beginning so our N list will be
consistent within itself.

Whereas one might expect "git log" to also format such a list, but due
to the internal implementation the semantics are different.
