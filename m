Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50E8D1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 02:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeFFCRS (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 22:17:18 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35801 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752424AbeFFCRR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 22:17:17 -0400
Received: by mail-wr0-f194.google.com with SMTP id l10-v6so4474422wrn.2
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 19:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SbiYgcvJ/GsaHU/0dVz5uqfhHaOEyJBi0+0guX9Q6XY=;
        b=kTuk5wo6cguFFJ5zU6ea/pVQ983QOrkpDAcA9t2yICeaAVOCK+N2dyQyq/VHkTGb2T
         0HuKwDtBWb75KrW5W5ie5kiDugQHQeAgOCMDrPCvD5Mbqi5FadW6knmTlttSemT6Bmu2
         3z8qUw1GRG2BztocLySnK1eIQ9Ja8FGWE6HoGHc+hmzxsnZ5tXRg9LnRIKqcyRCjqA8s
         UvsccdNz2/SmFfBdVLLa5feS31q62dRsYjERGhf8mR+bl4URhAGnSV1TCWYsckPVhWw6
         XgdxNsgcp5+7SpDtqa4KCx6W66hDt8TC50bIWWtaBDsrnTj93aXLkmg8xwwuUAp0udU1
         MVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SbiYgcvJ/GsaHU/0dVz5uqfhHaOEyJBi0+0guX9Q6XY=;
        b=PtM61eHkjzW3ERf5zCE1ZrFygnlAiZyISLluZW4CbEmOEDWyBpOwwCqnizxbGlFA4d
         QczIqKvNlTcBLOD794zMMdatmNhFFIBEUeNKelna7fawSypBFNazghIBht4niFYrydGs
         jhFH7UQHsdbMFMTqH4Lp6QlsTObCRTU95uxJ8Lij8oAFxhZAAt/mp1IlwQKHL+5LFz/Q
         /X8ylRXDPGgoelbm3Tcsfvpy8ijzWpv3SPidHE1Wcb6p9dCZzrFRodpn2AOENAEH5wWI
         Hf9+pmzO/KVO5nTQmuyQwearAW+C8+JdrEDfVkfhbfikuuHLmXOwTE7z9UlF9umIuNrT
         KpWw==
X-Gm-Message-State: APt69E2ggK/9bRxK/7i18NbWiOaNZx24fuR3FCgbuMRj4aVyQD/ThkEx
        +ZbS+60P0EUhOGDr4kRT/JhV3hN9OwuAv71on44cbA==
X-Google-Smtp-Source: ADUXVKIVH9rslhfYglwIOwCl2sYdsXRcLFjBP+hPfHwh9VRAEbO98aE0ts/UZ5i/b+54/mFfYaA/tRdPgdhj4udk6uI=
X-Received: by 2002:adf:a581:: with SMTP id g1-v6mr720789wrc.233.1528251435911;
 Tue, 05 Jun 2018 19:17:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:e90d:0:0:0:0:0 with HTTP; Tue, 5 Jun 2018 19:17:15 -0700 (PDT)
In-Reply-To: <20180606003745.GI9266@aiede.svl.corp.google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
 <c7e504a4664bb6008de970671af13eda7d85dc5b.1527894919.git.jonathantanmy@google.com>
 <20180606003745.GI9266@aiede.svl.corp.google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 5 Jun 2018 19:17:15 -0700
Message-ID: <CAGf8dgKWPy6ACsNPas=z1dT6qirAEHkkk8wCo91cFaxPVkgrhQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] fetch-pack: introduce negotiator API
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 5, 2018 at 5:37 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> This patch is written to be more easily reviewed: static functions are
>> moved verbatim from fetch-pack.c to negotiator/default.c, and it can be
>> seen that the lines replaced by negotiator->X() calls are present in the
>> X() functions respectively.
>
> nit: s/more//

OK.

>> +#include "fetch-negotiator.h"
>
> To avoid various standards weirdness, the first #include in all files
> should be git-compat-util.h, cache.h, or builtin.h.  I tend to just
> use git-compat-util.h.

OK.

>> +#include "cache.h"
>
> What does this need from cache.h?

If I remember correctly, I needed something, but I might not. I'll
remove it if so.

>> +#include "commit.h"
>
> optional: could use a forward-declaration "struct commit;" since we
> only use pointers instead of the complete type.  Do we document when
> to prefer forward-declaration and when to #include complete type
> definitions somewhere?

I'll use the forward declaration then.

> [...]
>> +struct fetch_negotiator {
>
> Neat.  Can this file include an overview of the calling sequence / how
> I use this API? E.g.
>
>         /*
>          * Standard calling sequence:
>          * 1. Obtain a struct fetch_negotiator * using [...]
>          * 2. For each [etc]
>          * 3. Free resources associated with the negotiator by calling
>          *    release(this).  This frees the pointer; it cannot be
>          *    reused.
>          */
>
> That would be a good complement to the reference documentation in the
> struct definition.

OK.

>> @@ -1061,19 +944,17 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>>       if (!server_supports("deepen-relative") && args->deepen_relative)
>>               die(_("Server does not support --deepen"));
>>
>> -     if (marked)
>> -             for_each_ref(clear_marks, NULL);
>> -     marked = 1;
>> -     if (everything_local(&data, args, &ref, sought, nr_sought)) {
>> +     if (everything_local(&negotiator, args, &ref, sought, nr_sought)) {
>>               packet_flush(fd[1]);
>>               goto all_done;
>>       }
>> -     if (find_common(&data, args, fd, &oid, ref) < 0)
>> +     if (find_common(&negotiator, args, fd, &oid, ref) < 0)
>>               if (!args->keep_pack)
>>                       /* When cloning, it is not unusual to have
>>                        * no common commit.
>>                        */
>>                       warning(_("no common commits"));
>> +     negotiator.release(&negotiator);
>
> Should this go after the all_done so that it doesn't get bypassed in
> the everything_local case?

Good point - will do.

>> @@ -1434,6 +1316,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>>                       continue;
>>               }
>>       }
>> +     negotiator.release(&negotiator);
>>
>>       oidset_clear(&common);
>
> nit: could put the negotiator.release(&negotiator) after the blank
> line, in the same paragraph as the other free calls like
> oidset_clear(&common).

OK.

>> +++ b/negotiator/default.c
>> @@ -0,0 +1,173 @@
>> +#include "default.h"
>
> First #include should be "git-compat-util.h".

OK.

> [...]
>> +/*
>> +   This function marks a rev and its ancestors as common.
>> +   In some cases, it is desirable to mark only the ancestors (for example
>> +   when only the server does not yet know that they are common).
>> +*/
>
> Not about this change: comments should have ' *' at the start of each
> line (could do in a preparatory patch or a followup).

I'll add a followup.

>> --- /dev/null
>> +++ b/negotiator/default.h
>> @@ -0,0 +1,8 @@
>> +#ifndef NEGOTIATOR_DEFAULT_H
>> +#define NEGOTIATOR_DEFAULT_H
>> +
>> +#include "fetch-negotiator.h"
>> +
>> +void default_negotiator_init(struct fetch_negotiator *negotiator);
>
> optional: same question about whether to use a forward declaration as in
> fetch-negotiator.h.

I'll use a forward declaration.
