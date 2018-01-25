Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82FDD1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 00:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932479AbeAYADa (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 19:03:30 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36021 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932239AbeAYAD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 19:03:29 -0500
Received: by mail-wr0-f178.google.com with SMTP id d9so5823735wre.3
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 16:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1mGqDgzMAQuzXLvL53y/NkWx253a0PwyC9zrREKbiKM=;
        b=XFdkM64r333/mV9mm71qe7D7cKhcBoqi8hA/okql2kEG5650qgBacj6OlSWRCcAtig
         RWYWnHdJzGW6hK25EBu1UGJZ+j7gtJVWGq04ueFReEmpIa/fZGF2BwRS1qxpucn/C9pT
         c37bM0LtaBPnbgVKw5TaGvXoA2avEc0H//Qc9ZpkGiF0Ai5fa18JEozuZZasZDOo7ABl
         4GgixaloXr6hhlaMMJ4J42COFDdqrGp7PjHCHy93IIHFlxsnpbAv82tnDHkNsXruRsHb
         U9ti6OF54PX/AjD9h/yD3yO2vuKBJc6ivm8oAe3rnKK1hablWOwGRKtDlDYic2h9jSUj
         rlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=1mGqDgzMAQuzXLvL53y/NkWx253a0PwyC9zrREKbiKM=;
        b=g+MGLpYEjhG/hDhjQQcwFXaZTenL2tvLRcUUD0oQ+F8B8g9dGNm1JSEHUbEpP/dKF5
         klQsUR8KPmwXqGJRgxPu50CT9fHS74a3htwVQqDSrGhUq2IgUr22e+O79uCXho1ZP7tR
         +dRZbFcU5qH+d7gbFXOtYkwz2JzVUE3VCu0faI2Ph1b9IFa/4JydMvFZxKVrqUjmJXCO
         WM9COHQwa/BtJyuC80cWrUds0LoY0AZ9z6qtCh/a/yAHUFuhBMQ6lT5uNBuoVG8xkHvY
         xqtPvApskSefR82X0kHnrEfYnR0VKOr9X59rQqRoEoASNQKljp0qUqB6jFZG1OZjRI+x
         x3dQ==
X-Gm-Message-State: AKwxytevsHmvG8FA8O3LxhZ/cqkLOnLD9LGFfQDWtNOQ0sS8Ta5ktvme
        +FXQ9L4qbIP3NIoTzkhGmssnetI7
X-Google-Smtp-Source: AH8x225z9+B46YyRKSrhoJ6BDJctRYd6sWbjX3c0XnMWpNB5gdDg+QbSZtFcGgxRPwHzN4ZOSKr0tA==
X-Received: by 10.223.135.115 with SMTP id 48mr7647039wrz.212.1516838608336;
        Wed, 24 Jan 2018 16:03:28 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id 186sm1720946wmu.16.2018.01.24.16.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 16:03:27 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Git packs friendly to block-level deduplication
References: <87bmhiykvw.fsf@evledraar.gmail.com> <20180124232214.GA11348@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180124232214.GA11348@sigill.intra.peff.net>
Date:   Thu, 25 Jan 2018 01:03:25 +0100
Message-ID: <87607qyfci.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 24 2018, Jeff King jotted:

> On Wed, Jan 24, 2018 at 11:03:47PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> This produces a total of 0 blocks that are the same. If after the repack
>> we throw this in there after the repack:
>>
>>     echo 5be1f00a9a | git pack-objects --no-reuse-delta --no-reuse-object --revs .git/objects/pack/manual
>>
>> Just over 8% of the blocks are the same, and of course this pack
>> entirely duplicates the existing packs, and I don't know how to coerce
>> repack/pack-objects into keeping this manual-* pack and re-packing the
>> rest, removing any objects that exist in the manual-* pack.
>
> I think touching manual-*.keep would do what you want (followed by
> "repack -ad" to drop the duplicate objects).

Thanks, that got the number of identical blocks just north of 15%...

> You may also want to use "--threads=1" to avoid non-determinism in the
> generated packs. In theory, both repos would then produce identical base
> packs, though it does not seem to do so in practice (I didn't dig in to
> what the different may be).

..and north of 20% with --threads=1.

>> I couldn't find any references to someone trying to get this particular
>> use-case working on-list. I.e. to pack different repositories with a
>> shared history in such a way as to optimize for getting the most amount
>> of identical blocks within packs.
>
> I don't recall any discussion on this topic before.
>
> I think you're fighting against two things here:
>
>   - the order in which we find deltas; obviously a delta of A against B
>     is quite different than B against A
>
>   - the order of objects written to disk
>
> Those mostly work backwards through the history graph, so adding new
> history on top of old will cause changes at the beginning of the file,
> and "shift" the rest so that the blocks don't match.
>
> If you reverse the order of those, then the shared history is more
> likely to provide a common start to the pack. See compute_write_order()
> and the final line of type_size_sort().

I'll have to poke at what compute_write_order() is doing, but FWIW this
to type_size_sort() got shared blocks down to 3%:

    diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
    index 81ad914cfc..c9ada1bd1c 100644
    --- a/builtin/pack-objects.c
    +++ b/builtin/pack-objects.c
    @@ -1764,7 +1764,7 @@ static int type_size_sort(const void *_a, const void *_b)
                    return -1;
            if (a->size < b->size)
                    return 1;
    -       return a < b ? -1 : (a > b);  /* newest first */
    +       return b < a ? -1 : (b > a);  /* newest first */
     }

     struct unpacked {

>> It should be possible to produce such a pack, e.g. by having a repack
>> mode that would say:
>>
>>  1. Find what the main branch is
>>  2. Get its commits in reverse order, produce packs of some chunk-size
>>     of commit batches.
>>  3. Pack all the remaining content
>>
>> This would delta much less efficiently, but as noted above the
>> block-level deduplication might make up for it, and in any case some
>> might want to use less disk space.
>
> We do something a bit like this at GitHub. There we have a single pack
> holding all of the objects for many forks. So the deduplication is done
> already, but we want to avoid deltas that cross fork boundaries (since
> they mean throwing away the delta and recomputing from scratch when
> somebody fetches). And then we write the result in layers, although
> right now there are only 2 layers (some "base" fork gets all of its
> objects, and then everybody else's objects are dumped on top).
>
> I suspect some of the same concepts could be applied. If you're
> interested in playing with it, I happened to extract it into a single
> patch recently (it's on my list of "stuff to send upstream" but I
> haven't gotten around to polishing it fully). It's the
> "jk/delta-islands" branch of https://github.com/peff/git (which I happen
> to know you already have a clone of ;) ).

Thanks. I'll look into that, although the above results (sans hacking on
the core pack-objects logic) suggest that even once I create an island
I'm getting at most 20%.
