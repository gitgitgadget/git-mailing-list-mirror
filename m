Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ACAD1F428
	for <e@80x24.org>; Tue,  2 Jan 2018 23:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750934AbeABXET (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 18:04:19 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:35301 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeABXES (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 18:04:18 -0500
Received: by mail-qt0-f169.google.com with SMTP id u10so65165766qtg.2
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 15:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F3hDOnE02w2nQPf3NqLvJhhbBskuP0+//PBtgxl8LVY=;
        b=vAbOK2RqVUQAi0LTj1tcF4dPI2dI1gxL08JEpyivL9jLQKQLufR0L10tYu0hBsp5nB
         H10/AKUQkjR50MXpbYIhrbWbNP+7Tmjdh+RgzAskk+s6UvkCQwDXX5UbaSThWCfcgt/z
         SwiEkOLflmCD+CCk9J+qHWMytEIFH53K+RrNCALT+PgBeLFSIC7a/lWGdJwRkxT7kQ6Y
         Bu4BYCUUmqlarf9Xs2gW6A0yuSg4aaDKA3yazs8/lVueQyrw6h+y/7vLeqPGVxMgwb46
         deKRjQIRzhuk9dH9kbGTijMSWaKqA6xH+lRjKWFhl20u9NPXb7a26TgdpPZQWq010xQn
         qVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F3hDOnE02w2nQPf3NqLvJhhbBskuP0+//PBtgxl8LVY=;
        b=oyO86WwVHgHVW6RAwgarZOjiWHJpb48tsxAk8hzcQusiFaWVl5N+nIxdNo4y/l+t8a
         Qc4v8Vi1gq9sGJE55czffHrYIUBBr128S6geDO6fg6eL71oDahb+cpDNPQR9PAgq1xaL
         bolmcSNs6qz+IX0ilGMEdx591rnJHRH+l0+xsy4gpEytZE84tnhAv7ADnxmIrCGVmyQC
         B5Gl6Cv0ofwByAJ5z/he22+wiHQWfRsnaSu8nUnDiIizfhkHa2GJk4/GOmTv3SDcrhpf
         FgoFAu0oKBBpVLV30WsgDLKljVwQjGOXnuEsB6MqOfa33JhX1glmJI9t3k58JtSb5DE4
         auOQ==
X-Gm-Message-State: AKGB3mLbg7uaGI9Qeudc0SHwOIQMqO0UH29qwbsrYHbKhXUYFxW+jP4M
        4pKZtn0Y02e2W2vO6K0tOay8ATc7a7Xh/vYmJvTB9QD7Uys=
X-Google-Smtp-Source: ACJfBotexSnQ9bzxIpLEU00zCBe5i52MYq7kXLRRaSIHL7cVgZ82TSXHuXhmRki3I8lDVS6END6k0m02EFzMcPiM04o=
X-Received: by 10.237.42.22 with SMTP id c22mr59700693qtd.162.1514934257125;
 Tue, 02 Jan 2018 15:04:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 2 Jan 2018 15:04:16 -0800 (PST)
In-Reply-To: <xmqqbmichws2.fsf@gitster.mtv.corp.google.com>
References: <20171219222636.216001-1-sbeller@google.com> <20171227225705.73235-1-sbeller@google.com>
 <20171227225705.73235-5-sbeller@google.com> <xmqqbmichws2.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 2 Jan 2018 15:04:16 -0800
Message-ID: <CAGZ79kaogOLj4e38aWfzOr9TwMGngDjCL9+weFm2Jm4gTtSjEA@mail.gmail.com>
Subject: Re: [PATCHv2 4/5] unpack-trees: oneway_merge to update submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 2, 2018 at 11:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index bf8b602901..ac59524a7f 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -2139,6 +2139,9 @@ int oneway_merge(const struct cache_entry * const *src,
>>                           ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
>>                               update |= CE_UPDATE;
>>               }
>> +             if (S_ISGITLINK(old->ce_mode) && should_update_submodules() &&
>> +                 !verify_uptodate(old, o))
>> +                     update |= CE_UPDATE;
>>               add_entry(o, old, update, 0);
>>               return 0;
>>       }
>
> This is more sensible than the previous one that broke same() by
> unconditionally checking the working tree state, even when the
> machinery is told not to look at the working tree.
>
> The code in the pre-context of this hunk, (i.e. the original one you
> are half-way mimicking), we realize that the original cache entry
> and the cache entry we are checking out are exactly the same and we
> overwrite when we know that the path in the working tree is dirty,
> and we are not told to "skip" that path in the working tree
> (i.e. sparse checkout).  That happens only when we are told to
> o->update and o->reset.
>
> Shouldn't we be setting the update bit only when o->update is in
> effect,

Yes, we should.

> just like we can see in the pre-context of this hunk?  I do
> not know if we need to require o->reset and/or need to pay attention
> to the skip worktree bit in this new case.

verify_uptodate takes care of the worktree bits
("o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTREE))")

o->reset is taken care of inside the nested verify_uptodate_1 function via

    ...
    else if (o->reset || ce_uptodate(ce))
        return 0;

So I'd think we only need to toss in the o->update check.

And that additional check would only be a performance optimization
as it would omit the check in case we do not want to update.
(verify_uptodate is expensive for submodules)
