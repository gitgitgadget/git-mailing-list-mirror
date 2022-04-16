Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A559C433F5
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 11:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiDPLj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 07:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiDPLjy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 07:39:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC633F327
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 04:37:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z12so12603798edl.2
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 04:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=GCcjMgq7QaAWYxM5/WUkkEYDdHw3Bma9Q4QO3dBam/8=;
        b=qPSaqe2/TtbVzlOatkXOty4Z97oa258HwAd3Rvn87Tmk9KIqMnRuDUE+74d4VwVFVE
         78QkWA8feZbg2u4VYsMS7iEytAoOVL0FgvRflXtlzGlzprO5ELc3F1kO5u5/G+wzhkh7
         QM6fz2fvuWdbjcstWq8ubVEjoEpIP0bDJKWGHgZlWHzx+ZxZtw7zkSkKuMAqGu5+GjFN
         CVvP/RV6xAlMAdwnGYSHK/4YwQ6sS+6+/mD3jhJTV1/qKoPihxlneCCcjTUBU+EbqV9X
         790Zja7Azk8aldnS9iqKecRk/D0zxI0FP1l7ZpSp0TQ6fsgMElp2j5FuQ/ByI1iVorB/
         /hzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=GCcjMgq7QaAWYxM5/WUkkEYDdHw3Bma9Q4QO3dBam/8=;
        b=1eW0hiMUNA2/0NjWoxOA3OQ10/54KB95SUUsB6MlQSNw0U1WQUWlXdstGh9+Kb5SWW
         8RleIVgQKCxCOZO8BusEWTtThCxgfkg75+xzy8WNvmty00vSzceRPVHpZFOVgNEBMnmx
         38EvLtW6tt7JF0yNfa3rm/WguKqHKMUi1/XYeHmpsEKGc2mH9JW1zA4yC+IAaOjUcb+z
         jgf7BJZOINf/RME3/HqgO61UdvfPqQOnC6LS+Lo+l4BHTCrukCAVe684WLOSzpobm4O0
         dvMHeQm7RxOuxMPIt3nFOoM3Al/Wg2S7de8Z/99tx5lSjs7Yi0KZL+8YAbmwkrJVFHh4
         73iA==
X-Gm-Message-State: AOAM53172SoIbvjlx4BEMb1IJYklZ6fHYFjpqPlP905AynVAckchsPj5
        TAMrfrcSNt6nsFi+cYgWusM=
X-Google-Smtp-Source: ABdhPJwVbDFfSs0+WyzY2OQge6cHeMRKazbjTDmF4slkapSu10lqFhbtPi+1kscwWVxozn5KOdPp1A==
X-Received: by 2002:a05:6402:1908:b0:423:d634:126d with SMTP id e8-20020a056402190800b00423d634126dmr701721edz.216.1650109040455;
        Sat, 16 Apr 2022 04:37:20 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006d2a835ac33sm2586277ejc.197.2022.04.16.04.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 04:37:19 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nfgju-006DX3-LB;
        Sat, 16 Apr 2022 13:37:18 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Pathological performance with git remote rename and many
 tracking refs
Date:   Sat, 16 Apr 2022 13:23:28 +0200
References: <YldPmUskbU+bOU2n@camp.crustytoothpaste.net>
 <220414.8635igdtfn.gmgdl@evledraar.gmail.com>
 <YljFnJk55WYLKd6Y@camp.crustytoothpaste.net>
 <220415.868rs6cyal.gmgdl@evledraar.gmail.com> <xmqqfsmedzsp.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqfsmedzsp.fsf@gitster.g>
Message-ID: <220416.86h76t9s41.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 15 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I actually wonder if this wouldn't be that hard, because if we have any
>> reflogs we could simply "replay" them by turning (again, I'm a bit rusty
>> on the exact lock dance);
>>
>>     lock(refs/remotes/origin/master);
>>     lock(refs/remotes/def/master);
>>     create(refs/remotes/def/master, refs/remotes/origin/master^{});
>
> Why deref?  Trying to be prepared for seeing a symbolic ref, or
> something?

I just meant "$(git rev-parse $NAME)", sorry about being unclear. It
would work for branches, but yeah, for annotated tag objects it would be
the wrong thing.

>>     delete(refs/remotes/origin/master);
>>     unlock(refs/remotes/origin/master);
>>     unlock(refs/remotes/def/master);
>>
>> Into instead doing:
>>
>>     lock(refs/remotes/origin/master);
>>     lock(refs/remotes/def/master);
>>     for from, to, msg ref_update(refs/remotes/origin/master):
>>         update(refs/remotes/def/master, from, to, msg);
>>     delete(refs/remotes/origin/master);
>>     unlock(refs/remotes/origin/master);
>>     unlock(refs/remotes/def/master);
>
> Would this (or the above, for that matter) work well when renaming 'foo'
> to 'foo/bar' (or the other way around), I wonder?

Hrm, probably not. Also for that we'll have tricky collisions with the
2nd level (master) v.s. 1st (origin/) won't we?

> Is the reasoning behind "replay each and every reflog entry" because
> you are trying to avoid depending on the implementation detail (i.e.
> "R=3D.git/logs/refs/remotes; mv $R/origin/master $R/def/master" works
> only with the files backend)?

It's a suggested workaround around the ref backend not understanding how
to "plug in" someting like a "mv", i.e. we can represent this sort of
thing as a sequence of normal ref operations.

> Unless we are willing to add a new
> ref backend method to help this natively, it would be a workable but
> an ultra-slow way to do so, as it would involve open, write, fsync,
> and close for each reflog entry.
>
>     ... goes and looks ...

It's far from optimal, but I think the main slowdown is due to the
(re)writing of the packed refs file, whereas the churn of doing a bunch
of locks, append-only writes etc. should be small by comparison, I
haven't benchmarked it though...

Also for my own reflogs (especially of remotes) some have very busy
logs, and some just 1-2 entries...

> Hmph, I am utterly confused.  refs/files-backend.c eventually
> dispatches to files_copy_or_rename_ref() when rename_ref method in
> ref_storage_be is used on the files backend, and the function
> already renames the reflog file without having to copy entry by
> entry.  We cannot just open a transaction, run many rename_refs and
> close it?

The whole problem (such as it is) is that that isn't part of the
transaction mechanism.

I.e. all of the logic to make this failure tolerant is missing, you're
renaming N refs and their logs, and we fail in the middle of it, does it
roll back to a consistent state? (it doesn't).

Of course this code could be made to handle such failures, address
consistency issues etc., but doing so would essentially be a
re-implementation of transactions.

So I'm wondering (perhaps unproductively) if having some way to
piggy-back the mechanism into the transaction mechanism in an easy way
would be a good way to do it...
