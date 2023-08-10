Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA0BC001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 19:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjHJTqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 15:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjHJTqa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 15:46:30 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EC02702
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 12:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691696750; x=1692301550; i=l.s.r@web.de;
 bh=a4Uoia22o3P4R1xQHvJsVXWTYSDYSzmfzWfiaBCstGI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=VH8vaVUfUTW0heQn+3XhqDDI+dQLf6fjdpH0UhbyYvvNtmhnJPo42teb84WXfmHoI831CpI
 4Si0xT5rfP2paIzj/k/7dFlTBF3bCAe0CDHTTWGJq5YL0sTmLl36kZIKXCVKmKTlk7qfM28Xr
 9sn+JOU88hpBmtC9MmLedkCQgMwUwweq4i9wjNoqfJitiDiaQHVbzYlNOT8f1qL1Lf7rUxP7+
 gpZ9TPFsNZFDsRSG1XryeYWzdP7Bt6MfsxSKVJriowGNzGNxzaJFCZKa8gbGZuADsod6Bwaih
 EhwJz5o4QsrpfOhm4u/92ct6RMzMbBWIYiMcV0o8jKkM2lJ+NLcg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7Nii-1qQr9W2OWC-007upP; Thu, 10
 Aug 2023 21:45:50 +0200
Message-ID: <b5fcc572-c710-5869-7a40-ba784d8edf0e@web.de>
Date:   Thu, 10 Aug 2023 21:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] describe: fix --no-exact-match
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
 <20230808212720.GA760752@coredump.intra.peff.net>
 <xmqqzg3156sy.fsf@gitster.g>
 <20230809140902.GA775795@coredump.intra.peff.net>
 <22e5a87a-cd35-9793-5b6f-6eb368fdf40e@web.de> <xmqqzg30m3vo.fsf@gitster.g>
 <20230810002638.GC795985@coredump.intra.peff.net>
 <xmqqo7jfk8xq.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo7jfk8xq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sWDQxn9mH3/YZY3MRUIqf7X5PKj63/fK9JMMIo8IWHBKAyjo4yw
 W7kegi+ntofDopTreUuI8cuk5rX3pquJc+2d3s74ScqcM6LTJdX/plIRpddWTbvUcNMyoB0
 ra26DL5vbzik7JrfYia8QGT7YtcYuZmAShe7+Lt8VAglLSpa9UgF+YLjHlxAsjNQ/ycloAg
 x9cnbsAIkIYT9hJl3Rgiw==
UI-OutboundReport: notjunk:1;M01:P0:Sfv72S2QpH0=;tL+MT8KQxJLQdgoEZiNVibuxB3j
 ByEQfF3jPs3ZliV+Gn3SdbgCuEqjmHc5PMrpTFCEPY6TWJ/SV/BiyydDnryc9gs9yo+6d8QIb
 P6rHyxFU6FBlK6mYde4MC6gjp3MKKwBjvoJEtmXHepDogs5K1o9TV7GGE32OabsSixjdpK5AC
 uDgEDTqExY3T+Gj8e9VrdSxk/bFkdKdUnkAgHq9wCIxGDMsHLrNhO13lZK9V8bhZHNTB5Q5oG
 wjBbeycOLHRIwAO1vU78zvPe8nEHyzNSA12N6t6vj3UdFRhLyWhfH7OLRM57KEzvcje0kEu4U
 Ak2KvQ4Z9CTeoTrKRNNKiL3WKFCToGnBRgv16UvFMVjKpcjN2ejAdF4ir1ECNj/Uw7l/vSHwz
 pmslVdfiVuRVdwL9JGsAqq7sg7C7zHiPkOJIP5SA6mBBPfG7SdVCFcEbvsGmiWuRD8vgrZTP7
 kvIFnHRXf7AM+zGJe4pP8qi9jFGH8AbZDfeK1TjThLJHukMCqgrmphTtk/VVVLsNr/jJRKiUK
 9gt8vmWULEi0xcS01/pWK40ctoCnjpv740+lkxGykhXTwsvYJ60pN6lMtzgMlrZUZdmvuFElj
 ql8vzolGsyFpel2SUNQiC8xvkUtvg1mcB/PgxUTrr9N55V7abRl6V+FNasEh8hnCuWcbu48Qe
 0NZ8lm4/Bxnn+4DZzrSHoLlOlddbarhgKAZIdG+YE7QKMRxFIRJeKhZ72qbTUjIc9AKa1JFsr
 FIjMrfLCD7DF863NRr31yJV8eODlzhXY8coez5xNWX2F3+OF0jZ3PFWDtVNEjE+MN3s0KJU4D
 TZHeHKVpNimawqypbCGpiYX0JS+N4SQTlt1+x0FvKcEXe2y3L1HoJ29xHlx23E94DZj/i5zKj
 OSbjK3playggCEgwhh/g+E1L8qDgj88cTsWRPcO+aoCsIyD4i++XIWje3di1B64cRaepunZef
 /BNVeniYvd9cq/ahVlWEHjV+1sM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.08.23 um 03:00 schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
>
>>   int my_foo;
>>   ...
>>   OPT_CALLBACK('f', "foo", int, &my_foo, ...etc);
>>
>> Not great, but it might not be _too_ bad given that most helpers like
>> OPT_BOOL() can just say "int" behind the scenes.
>>
>> That said, I don't recall these void pointers being a large source of
>> errors in the past. So while it's a fun type-system puzzle, the
>> effort/reward ratio might not be favorable.

I have vague memories of changing a callback from using a string_list
to a strset (or whatever) and getting crashes out of some other callers
that used it non-obviously via some macro.  A compile-time check would
have helped me.

> I tend to agree on both counts, it is a fun puzzle, and it probably
> is not going to give us sufficient reward.  The fact that "int" and
> typeof(my_foo) need to be manually kept straight defeats the "type
> safety" justification for this mental exercise.

The many-pointers idea is a bit silly, admittedly.

Having to declare a type manually is how most of C's type safety works,
though, so a certain amount of that is unavoidable.

typeof (along with typeof_unqual) is nice, but I guess it will take a
few years (or decades?) before we can expect it to be supported by all
relevant platforms.

The typed-callback-with-void-wrapper idea seems promising.  Let's see
if we can get it into usable shape.

Ren=C3=A9
