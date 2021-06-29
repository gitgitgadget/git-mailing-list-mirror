Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B62C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 12:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E8461D70
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 12:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhF2MJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 08:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbhF2MJu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 08:09:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D66AC061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 05:07:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j11so5452323edq.6
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 05:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=n7FIibEPQGAm/ci7qh1O4AkO1wpvKBVezX+2Lx1UO2A=;
        b=ORgsvXkWzufXR6L2i1fdskBtxHQjzT6IKO7EhalBrtBoPS2u0+nDjOhCt2VFOtfQmH
         1/XIZPk9YjdLoFSqYICeT+1S+1trjgnCw/+0QE9NZ7nCtxWk6N6ijyIbz5m4sMaKIy1M
         Qti7BKQ1uvnIA4Ld98x7z0uL0Mt/9q2v1LJMk+xSlMwo4NTj5PfH3OZxEm0z1IEKJHbn
         RbfeiCwbf3bd26cGoS/Hmkr9zulorqIDaPY2qijmhCapb6i/ktjojqK0MmUarwnbS3oz
         x0vC42FoMujG+A2I7ljZFhon0z5+bLH4vrgL0s7KTLi/SSy7vfnGcAGySmSNjjXazp+G
         /org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=n7FIibEPQGAm/ci7qh1O4AkO1wpvKBVezX+2Lx1UO2A=;
        b=OVJhL83W4p+oDi6RJmEYhzbBEVtM/TNuZLV/6AdTjxjbTmrnCac45iAAF++XBPhiw8
         m1dVNTex80y6kNJN5USO4REhHamS1jTAPgKgdiFbO9ZUTInMTocKqyaylA3m515Ekc35
         1UHoyYVKg5U6y857k0ShtHsYIpYAomkpufAZaGNyETVQ/tVkW6EwlQbwM7YDTBeL9RNH
         yaCjTqsZXG2rBRA4p9vectDx5t6Onx3mmslLR5AYs5heK6nGD4mwlEx0KPe+k/6k5cl1
         B/46nI2305rvZe+jTjdhibwDTSRQmjDpX4FYV+72c/kD/oP+necqAi8eAGywkx5pqu5S
         69ZA==
X-Gm-Message-State: AOAM533gtdApeB8HFQiIQNaQVYGOdKNzKHznx2LoA7X+05fKDLN9AlKX
        rvImRdgtMS44NIgprQWFU0g=
X-Google-Smtp-Source: ABdhPJyryhyLYh+DzkfbJYjYot4iCqJi6f67UA6xKOB9pZ6rdQxvieMxCdJcW3s3RCy+3a8nmq0rsg==
X-Received: by 2002:a05:6402:706:: with SMTP id w6mr39403327edx.176.1624968439922;
        Tue, 29 Jun 2021 05:07:19 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id cd4sm8250164ejb.104.2021.06.29.05.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 05:07:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>
Subject: Re: [PATCH 0/3] Makefile: "make tags" fixes & cleanup
Date:   Tue, 29 Jun 2021 14:07:00 +0200
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
 <xmqqa6n9yyim.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqa6n9yyim.fsf@gitster.g>
Message-ID: <87tulgg9hl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 28 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> A small series to fix the various "tags" targets, i.e. "make tags TAGS
>> cscope". We'll now properly detect their dependencies, so we don't
>> needlessly run them every time. I have this as part of my standard
>> "make git" command, so doing nothing when we have nothing to do is
>> preferrable, especially when my editor will eagerly reload the TAGS
>> file every time it changes.
>>
>> As noted in 3/3 this is better on top of my just-submitted
>> .DELETE_ON_ERROR change[1], but will also work independently of that
>> patch/series.
>>
>> 1. https://lore.kernel.org/git/patch-1.1-9420448e74f-20210622T141100Z-av=
arab@gmail.com/
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
>>   Makefile: move ".PHONY: cscope" near its target
>>   Makefile: fix "cscope" target to refer to cscope.out
>>   Makefile: don't use "FORCE" for tags targets
>>
>>  .gitignore |  2 +-
>>  Makefile   | 31 +++++++++++++++++--------------
>>  2 files changed, 18 insertions(+), 15 deletions(-)
>
> Looks mostly like good patches, with concrete suggestions for
> improvements given.  Please do not leave another loose end that
> should be easy to tie untied and float away to some other topics.

In the v2 re-roll of both I detached these two topics from each other,
as it turns out it wasn't needed to begin with. Sorry about that.
