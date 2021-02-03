Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E805DC4332B
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 14:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDD964F8C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 14:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhBCOZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 09:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbhBCOYi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 09:24:38 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB93C0613ED
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 06:23:58 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i5so4872571edu.10
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 06:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=7F3KCyv6bUvXzyHs3/HN4+YQNhb+twDqvxt8vufgNqw=;
        b=nl1JLbZ2pK2+1JL8eoPqZbI3ppMABUcm53/4ltM+qfGiXNUeUF3NazTLuMSKopeVhB
         WTfkxM0+kKWcujL+slvDpkCpQMwaqi+YJQKqZvl3PclECih2Sn55sb+Or2AGF5F3NzdC
         laXeBOj9Ady416IzRyl/17v6kiiBtgJdv31nJUtPEmc34mHobJpKK+gOHEfe9evBb2v8
         /KeaCKWHSwc+qa3SDPgr6QbjmTnlB6zxXlfjs1IlT410fLwuOJyYsjg1xQU0Iz3nNt3h
         HEvsmQQOojif65nG1m/ysnIRxgoYjlkfVr+2uAGlZv/279mZLDScUbE60Lk46uPEqp3n
         YVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=7F3KCyv6bUvXzyHs3/HN4+YQNhb+twDqvxt8vufgNqw=;
        b=eDVvWR6XX13AFp2M0FGwxgghVFjjK8BrHginfMLjuRDC9mq6hJuM+Nt9GCMpDeeN8d
         f6nfCiSRFO/hDNlcKtdSOmnfM46BqM836MuEAZp/bqmfW1Ys7T7StqNNuYHdvu5Ng62J
         YFZDqNECzz4anIC/Qj9yQ8ZDJLz+f2CBjsYbaB9SAvqYrL4g4YPHC/24UHpd+yAFNN0G
         ENFkDGdE3FFZ7rScuheGFlyOMkAIk5D6Zg9MzpRLbm/tj0FOHcVMpEvFRxPZsGblF27t
         nbGdViUOQSzozleKfSDmiHH6odA7zyfKpeLLyiPt1BgMyYsFRDQ3lVYYYRmUrD/gSzFs
         WJCQ==
X-Gm-Message-State: AOAM532M0F+faYUKU5xmQqgbxDLZmUQmCcfbNdRhi2Sw1cjpv7KuM4ZP
        +Rm4kgUlPPxxP3s/UKu6mtw=
X-Google-Smtp-Source: ABdhPJw64o5lSz5QF7siJJr7kvhK66ektSaAdrQCOgEUodD7FnTwh7AQcGwveROeSBJxgF9xNpOekw==
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr3168989edd.52.1612362236984;
        Wed, 03 Feb 2021 06:23:56 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id k4sm1086522eji.82.2021.02.03.06.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:23:56 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Cloning with remote unborn HEAD
References: <20210130044142.808860-1-jonathantanmy@google.com>
 <20210202022254.1793991-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210202022254.1793991-1-jonathantanmy@google.com>
Date:   Wed, 03 Feb 2021 15:23:55 +0100
Message-ID: <877dnpdybo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 02 2021, Jonathan Tan wrote:

>> > I really don't care much, but this really needs a corresponding
>> > documentation update. I.e. something like:
>> > 
>> >     init.defaultBranch::
>> >         Allows overriding the default branch name e.g. when initializing a
>> >         new repository or when cloning an empty repository.
>> >     
>> >         When cloning a repository over protocol v2 (i.e. ssh://, https://,
>> >         file://, but not a /some/path), and if that repository has
>> >         init.defaultBranch configured, the server will advertise its
>> >         preferred default branch name, and we'll take its configuration over
>> >         ours.
>> 
>> Thanks - I'll use some of your wording, but I think it's best to leave
>> open the possibility that cloning using protocol v0 or the disk clone
>> (/some/path) copies over the current HEAD as well.
>
> Looking back on this, I think that it's natural to think that both an
> empty repository and a non-empty one have a HEAD that points somewhere,
> and "git clone" would behave the same way in both cases. So I'll hold
> off on the documentation change.

You mean for a v6 it'll do the same thing in the local clone case too
and thus we won't need to document the exception? Sounds good.

I was mainly pointing out the need to document the current divergent
behavior.

Documenting that something isn't consistent shouldn't be seen as a
blessing that the divergence is a good idea, it's an aid to our users so
they can understand why their git version does X when they might be
expecting Y.
