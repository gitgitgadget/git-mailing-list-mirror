Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 178F61F404
	for <e@80x24.org>; Wed, 24 Jan 2018 22:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933019AbeAXWrb (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 17:47:31 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:38597 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932845AbeAXWra (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 17:47:30 -0500
Received: by mail-wr0-f175.google.com with SMTP id a1so988062wri.5
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 14:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=xp/Sa2UT9MUahnMBlrM0JoIcPMYjn6Vm+WkDb0GegGo=;
        b=lT01ghhoEtDQejnZcazIVsUCGv0EyHOwM0AV1xTcg1jsmH3P2p2YblY/PbNovQq/Cv
         Rz1i6ext3v7uIcV4/jxCyVQ4PRzEDmpZm7RD9nJM5AlyAWIDr5yOIaApzh4TYH8s8CZq
         9Yn2Iv9LSUbrvdZaJbPW6Ekx41NVk5Ikjusa9A1WEmnLmHJDn1Onjh1Qu7qZ7II/j68x
         l7vWjI1cGz9gVNVeCNaiG9x3zjQ3WdCiNpzglFsXay/4ABzMXmwqmKgZ5FP3m5NZmZmS
         1+f6sRHjxxXL2ZH29Sr7AXsUGr/x5C7bCB7mwE5+3T4fdUPlPUeZMy3lEZwtChwujMEV
         cYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=xp/Sa2UT9MUahnMBlrM0JoIcPMYjn6Vm+WkDb0GegGo=;
        b=qKaxZQAYeXaW5v6thS6tWwv4gp6zU2czX1hUf9ZSLDC3bWk695UY6Q3fjGqlo6Vy1v
         SDWRhmV+35+DkxYX/DSy0GgBFi29a1ReQ5gEBVfyU3e/wERcfx06CuWnWFgMRzzb29Au
         GIr8ERlJwWNfDmTRaOQfAGA0EEM7dcXiqPmsDoVQkDFlyTv8e6kBdbEXnnHk3VLCS50C
         ILEUu9qSrIUompemZ7uf9GbX4S3V4viUQTvVYL/+SB1UpasTABf0CzSSxuSFIviCo/Ur
         opj/f+aVnfnD9edDGhvVS0aRCGLv4v71h0/J93Ciz3b0iyDBvlOLkjFAn/vqZBDouMGB
         gPpw==
X-Gm-Message-State: AKwxytd3TeZ18Y6c5QacfOCODdMbB6NiJdCOG7pZbJnyne+VHkebhTsV
        UL8iKLkA2GwKQE5+ze+3u/cjJTw8
X-Google-Smtp-Source: AH8x225KGSOoS1nyYmjMlV5zuWgQKN7Mtvhr2mnJzUmYHf8AputDZNpCW6XGCCorUVkE0f6sHjKoMQ==
X-Received: by 10.223.187.82 with SMTP id x18mr6483128wrg.41.1516834049778;
        Wed, 24 Jan 2018 14:47:29 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id o98sm4661210wrb.19.2018.01.24.14.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 14:47:28 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mike Hommey <mh@glandium.org>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>
Subject: Re: Git packs friendly to block-level deduplication
References: <87bmhiykvw.fsf@evledraar.gmail.com> <20180124221932.v6up7j67llwhjox4@glandium.org> <xmqq607qc2v6.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <xmqq607qc2v6.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 24 Jan 2018 23:47:27 +0100
Message-ID: <87a7x2yiv4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 24 2018, Junio C. Hamano jotted:

> Mike Hommey <mh@glandium.org> writes:
>
>> FWIW, I sidestep the problem entirely by using alternatives.
>
> That's a funny way to use the word "side-step", I would say, as the
> alternate object store support is there exactly for this use case.

Things you can't do with alternates that block-level de-duplication
gives you:

 1. Your filesystem may be mounted from some NFS host that does
    block-level deduplication internally against other content you don't
    have permission to access, think the /home of a bunch of dev VMs you
    know will have the same repos cloned (along with most of the same FS
    content, e.g. the OS).

    In this case the storage can de-duplicate blocks purely as an
    implementation without git knowing about it, as long as git (or any
    other program using the FS) can be coerced into writing the same
    blocks other gits on other machines write, at least most of the
    time.

 2. Ditto NFS, but e.g. chroot'd /home on a local non-NFS.

 3. Even if the repos are all on the same host they may just be ad-hoc
    cloned in /home by different users, it's easy to write something in
    /etc/gitconfig to give them the same repack settings, less so to
    maintain some git-clone wrapper that implictily adds --reference
    (they'll not know, or forget) to all clones, or goes hunting around
    for checkouts and adding alternates after the fact.

 4. With alternates you always need to maintain some blessed "clone from
    this" repo that can't go away least everything cloned from it become
    corrupt and needs manual repair. If you're aiming to just save
    storage block-level deduplication may be a better trade-off.

Also once you clone with --reference doesn't the local clone only add
new objects as you "git fetch", never pruning those if the same objects
appear in the alternate later on, or am I misremembering things?

I mainly have use-case #1 & #3, although they could both be made to use
alternates with some hassle (e.g. for #1 exposing a separate read-only
copy of "these are alternates" to each VM) it seemed worthwhile to see
if repack could be made to be more block-level deduplication friendly,
as deploying that is easier.
