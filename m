Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CC4C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 19:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2BA61157
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 19:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbhI1TpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 15:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242470AbhI1TpV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 15:45:21 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C805CC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 12:43:41 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dj4so88064236edb.5
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 12:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ekpHDlcbQyGZLcD+0cVZJeW03PkmKftz7GXK7UNC/Aw=;
        b=SSn19mcpzE7+y2xfu+Y2o7ty/pp/cDWx6J30nU5OkU7BuFnMCKRKkKooinwgRakFsD
         g7cvdwS8TE/tkyC5bXRP9eJyr/OqQXRYnYNO2XNGpAfAmLdzfgol0Q9OGePVTGugARog
         A6gl6cKPlyxHhUSUihJtmNAHm8BlygmMnbTjEBmk0eLPLUjamZGVMBb7rCinj6YBnlCp
         GtCetIPVc8VHVpTMWXchxe56D0lCZiDAy/R7XB2wfA1VX/SBgIsuoRVK9sM8J+I2YVpL
         lv8tPQ/BQAxv4FZ4BH7v4qv3424Kz4jtT4C8oDQl1TLLJfKKeoRKmQDnN39TdafL9XQN
         5STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ekpHDlcbQyGZLcD+0cVZJeW03PkmKftz7GXK7UNC/Aw=;
        b=gIqmV3kMf5Ur3wvNJaZq0pO5sYVdWAKz5ge9e9weA6b8V3+RxgA5oELt7y5534tbTj
         l0Ela54qSo+ffnPgYcXihEVPlaCD9nBUELkYfHoTJ2RYgK1fdBCxnBgWAnM1uwLgtQ6o
         D1TW01dZz8lPba5xenTpxbQNGKv1ZRlCHv6cEX1JCaric1KcsdgtA0fq5vbi9YFxLI5g
         hhi5R0Ltb+PIlVqkwFkTR9JGxv0XHslyNDoJpZHPy++5iHDdzczRx488JrVGCbLaTH7B
         Op1L+X/n1/HDgOq2pYkGdaz5J+NhTtRUDfYK5B7tzBUMD2Je+obFOmvHP11lOzYD2I5c
         PVGQ==
X-Gm-Message-State: AOAM533Q+pdzPmWQOjI/yZsaRDYgYXOfwlGzdMO3aSnQyAmX6oCB01SG
        yYDdZAEkNgOUZpQBA8LyHss=
X-Google-Smtp-Source: ABdhPJzevVcivL/9n8FNVdmcTANQ82AeeS/eaAiWhfNH/fe4PNdIDs70KFhOVG1qxtWhwTf3zsZ+bQ==
X-Received: by 2002:a17:906:7a09:: with SMTP id d9mr9019055ejo.116.1632858220376;
        Tue, 28 Sep 2021 12:43:40 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h13sm22248edr.4.2021.09.28.12.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:43:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/5] cbtree.h: define cb_init() in terms of CBTREE_INIT
Date:   Tue, 28 Sep 2021 21:42:45 +0200
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
        <patch-5.5-7e571667674-20210927T003330Z-avarab@gmail.com>
        <694f477d-b387-c8ea-4138-0e9334540c69@kdbg.org>
        <87czou1dmp.fsf@evledraar.gmail.com>
        <YVJZrOYucywgoi+v@coredump.intra.peff.net>
        <xmqqpmssk0v1.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqpmssk0v1.fsf@gitster.g>
Message-ID: <877df0wknp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 28 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>>> >> +	memcpy(t, &blank, sizeof(*t));
>>> >
>>> > Is
>>> > 	*t = blank;
>>> >
>>> > not a thing in C?
>>
>> It would be fine to use struct assignment here, and should be equivalent
>> in most compilers. They know about memcpy() and will inline it as
>> appropriate.
>
> FWIW, I'd be fine with structure assignment, but we already have too
> many such memcpy(<ptr>, &<struct>, sizeof(struct)), adding one more
> is not giving us too much incremental burden for later clean-up.
>
>> I think some C programmers tend to prefer memcpy() just because that's
>> how they think. It also wasn't legal in old K&R compilers, but as far as
>> I know was in C89.
>
> I think so, too.

Getting back to the topic of this v2 in general, my reading of the
discussion since then is that nothing in it necessitated a v3 re-roll to
address outstanding issues. If I've got that wrong please shout...
