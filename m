Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B90C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 08:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD6A61186
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 08:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhKEIxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 04:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhKEIxk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 04:53:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791EDC061714
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 01:51:01 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j21so30435382edt.11
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=smRsi7ALYGVV1vqpKtQE4ED8ZVktiCEs7JZKOuMdTkQ=;
        b=iQsv4+3LvKEzCDWxR43554hvYcVz+atHpz+KDl7GBWerF4D39Vr9EmyrTlqlBQjHr3
         IGAgXoioL2qC7mZz+4Rs7t8hvmUJgCV7tg9egknFqFdLEF/tzSczqtcupiifwh0qleN5
         mUw+llueNfIUua5IMk+oAWWpWQuWkepKa5YxoFhbt+52Pn3IDWGwxso8EFJy2fLpMXho
         AHEZ7XslEOyYP/EfBUCwN9suoQYIKTTDOyc3g1/7rG7k1OZ9hH5Zu2bo656vKwZQjCfc
         n5HrIkU/btne3zpDpr/jldiNtFES0WXRqlCv8tjQc1qFDd/wN2yGrionSh4pQCV/f/+Y
         UQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=smRsi7ALYGVV1vqpKtQE4ED8ZVktiCEs7JZKOuMdTkQ=;
        b=rPFwxsXIacxg+rypDqP2DdYQycX50WNNNcsD2fNvX2jBVmyrQk7GAt1rmtU0YtlpHg
         F5kyLmdEokj6C62jLUXrEMOABxM/iRJVSMzcNIJCzRS7Y2hZTYf9lPa5WNwo+hC4EBI+
         Mq3/kdeydcIQHQmiYflqgqeX3ODBClavU2CaoducCGLgXx5LK+sfdqsPBOgvXGuff/s8
         9j9+8mRoH8ybEPasBclbUMRHRAskMS2yNReFsLO1h8RDe6+7INOkHs89QKqijcCTDEQR
         BN6GrzGgeQiyRhUa9GMfCZdWl6bkds9F1ygfB212pFirMxLeY+8LzatW7dEKBOsV+4d3
         djpQ==
X-Gm-Message-State: AOAM530Ch0owY0pPpis2l36pSBWet1PH1CCA5oCZbe2smW0hq8fCO2mD
        sCbF8w1c0NHPkDs7/gzg7DOGxRvbHKQ=
X-Google-Smtp-Source: ABdhPJyGuHQZBpb9+cNBYAE9Id3kNmeUt/MWqcS+j3o0Jp8bD4bU7UYVifPqTXJN5FY/8mJ/4AdvwQ==
X-Received: by 2002:a17:907:2a09:: with SMTP id fd9mr17842650ejc.550.1636102260036;
        Fri, 05 Nov 2021 01:51:00 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cw10sm4015514ejc.80.2021.11.05.01.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 01:50:59 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1miuw6-000H5l-VY;
        Fri, 05 Nov 2021 09:50:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 4/4] submodule: record superproject gitdir during
 'update'
Date:   Fri, 05 Nov 2021 09:43:56 +0100
References: <20211104234942.3473650-1-emilyshaffer@google.com>
 <20211104234942.3473650-5-emilyshaffer@google.com>
 <xmqqzgqjxl4e.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqzgqjxl4e.fsf@gitster.g>
Message-ID: <211105.861r3vhtot.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 04 2021, Junio C Hamano wrote:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
>> A recorded hint path to the superproject's gitdir might be added during
>> 'git submodule add', but in some cases - like submodules which were
>> created before 'git submodule add' learned to record that info - it might
>> be useful to update the hint. Let's do it during 'git submodule
>> update', when we already have a handle to the superproject while calling
>> operations on the submodules.
>
> We are hearing repeated mention of "cache" and "hint".  Do we ever
> invalidate it, or if we have such a record, do we blindly trust it
> and use it without verifying if it is still fresh?
>
> Also, this step and the previous step both say we record gitdir on
> their title, but we instead record common dir.  Whichever is the
> right choice to record, let's be consistent.

I had similar (AFAICT still unaddressed) feedback on the v2[1]. I'd lost
track of this series, and see one reason is that the In-Reply-Chain was
broken between v3..v4.

I.e. it seems to me that this whole thing started as a way to avoid
shellscript overhead by calling git-rev-parse from git-submodule.sh, but
now that the relevant bits are moved to C we could just call some
slightly adjusted code in setup.c.

Maybe I'm entirely wrong, but I think if I am that this series has a
commit message gap between the "hint" and "cache" and this really *does*
need to be written at clone/init/update time in some way that I've
missed.

Otherwise I still don't really get it, sorry. I.e. maybe the relevant
code in setup.c really does need caching, or maybe it doesn't anymore,
and this cache-via-config is a hold-over from when figuring out the
parent repo implied needing to shell out somewhere for every operation.

1. https://lore.kernel.org/git/87r1cnfkqx.fsf@evledraar.gmail.com/
