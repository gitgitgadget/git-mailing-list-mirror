Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AB6C0015E
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 12:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjGXMaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 08:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGXMaF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 08:30:05 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C2F10D5
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 05:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690201774; x=1690806574; i=l.s.r@web.de;
 bh=pC5wzALp2jMvt1f2TPS6UpHNG8IDoQlJhgeMgPh38/M=;
 h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:In-Reply-To;
 b=Q5twx38D71q5eJVD4mLSkTu3b9eBKtj8EfGYXAUrkxiYQ82G0hX1brXkElDDiniFNXIWoDd
 7nSpRZvXp+v+OECqRBapetL1YDoRjXp6NJ/J1dPR7Yyqh2f6Iu0dxpCjCoLNy6BSIL2GtYZPI
 rzs/6nNK5o5MbXmoPqFxFGlKM3bzVxtBnTJiG1OSQCba6vxwNdHhgBk8RYWalg3yJ+37IXBlO
 DzXCbtgmj1MCnG0a07WwGnZIoiNTiW1V2b+1FOFkYKLR/EuwX4Iv4aFv1TmFjYs3LvXvbqgFk
 I9kyPERwvThgsF2wwP4duUbT2UAnXRwkN6pjxHd87u4FBsMX0PJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNwjc-1qYqwA0Zia-00OV9x; Mon, 24
 Jul 2023 14:29:34 +0200
Message-ID: <1535f30e-3cf9-1a0a-04af-4ba4a7c46d15@web.de>
Date:   Mon, 24 Jul 2023 14:29:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] ls-tree: fix --no-full-name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq4jlxuiuu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9PtDp/otOMlMcWxpCVODdQ8ZSYE1E5Lo5LxTnumv9kO8QrjPDzp
 Pe7hEUN9t4/s0Svqhoxnz7hTSzMYdTW5ttvocdf6XNJWrqnGkHkLLXo22+mHxdaOrsUgpXS
 52juZLKz/9gw1xqjwRJ37JyubPY+OQ51u/hUEr8YChTZQBn+WbEtzviiz6siyLFKblAuEkb
 uRokO6TlcGtqm4KXOP/MA==
UI-OutboundReport: notjunk:1;M01:P0:Q0o0RZmmH6k=;yrynUVH4DD/Xyk7QcA3NGQJWXCn
 4+ZSpIyqw/c+kYVpFMC4gJ32MKaykCoHNf/ePPQk6t3Dw8on5/OIfA0PneWwwhGgfmbX7FjxL
 9j7f5I0udDK03gJkjVjLfpxCuOsFi88N9hF2K+BBNvTLU+3XoMRH0E2lyu7o0rcwEDE9FgU8L
 bXaAF4kRPHp1imDXgTLcLlQjyBEuybO8xcgYa+a//6odXX93wsvqBZavkfDa9+X/Vi8tG5Jiw
 /t1taToCHSmXsb+9ewOIqY1RYTHEGqU0ZUk0pJmixAYKJpqkMWCVD2DC147H2V8hP9cKOQQic
 gd8s/ujiGeXbx4KiNnbHMXWBjlmiAUm5V7nlrkO8ZAUjx0Kl1bK/QgOsE3H89YZ4OlBC4R9+Z
 XsyngziU8yRsrL+gkjWiHygc38bdr1gO+Fq260RnhYc6P3V3QAe2IrUQupP/wLDOHhmJ4JaPY
 9lHk29hyFzshoDIf+NDw844RTqBpVOzR77NKRL1fIJ9LTwxxoqSyz9nb16Rsxhv9ns6fElhi4
 H3ByxTj/pVWErGuCVRLn4aW59CA2uAs7UeAUHIe9j9IVeHBxWgsUi0vRNNOaiSfxfZiG2Ss4W
 VJHhIJfR2HgS4n9VtteV9v/nJy0YNbYRmgUgDz4ULyufa1Exl/Vaa4kej1ilK4gjAXwE7ROnR
 1oEmmwjQl+7x9CjHfLrS33LaQU0Y15+Cd1hjLhV/HilH1mwNJnIS3y5le0JyMJ3MrHh0jHYAr
 snC6WvgsiBTq4tHRRvLjUFeXbp09kJGYfXguRMzsDUFHgDIBvurxeXk1AoT4tjKnO/1tiMALN
 3HBrlXFZ2P1RWTTN4iIVQQarK1IT9fgszZvs3gPLeDqMLtzSFPd9ln3W7/oCcsRX/bhl5ZUoX
 lbEXANnZ9nMuyzmCqqBZbxU78ZXv18iikpVbUd97NjODaVJUOdWWx0udHIhKVc2g6ak48Z7EJ
 rg6uFg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.07.23 um 22:09 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> -    -D, --no-doubt        begins with 'no-'
>> +    -D, --[no-]no-doubt   begins with 'no-'
>
> Hmph, I really really loved the neat trick to allow "no-doubt"
> option to be "positivised" by _dropping_ the leading "no-" at around
> 0f1930c5 (parse-options: allow positivation of options starting,
> with no-, 2012-02-25).

Yeah, if there is a better way to document A) that the "no-" is optional
and B) whether it's present by default, I'm all ears.

> Many of the above are amusing and served as good demonstration to
> show the blast radius, but it seems that most of them should be
> marked with PARSE_OPT_NONEG.

Hard to say for me -- these are synthetic test cases and I lack context
to make that decision.  In t0040 (t/helper/test-parse-options.c rather)
we do have a few PARSE_OPT_NONEG uses already.  In t1502 we need to add
some...

>
>> diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt=
.sh
>> index dd811b7fb4..0a67e2dd4f 100755
>> --- a/t/t1502-rev-parse-parseopt.sh
>> +++ b/t/t1502-rev-parse-parseopt.sh
>> @@ -64,33 +64,38 @@ test_expect_success 'test --parseopt help output' '
>>  |
>>  |    some-command does foo and bar!
>>  |
>> -|    -h, --help            show the help
>> -|    --foo                 some nifty option --foo
>> -|    --bar ...             some cool option --bar with an argument
>> -|    -b, --baz             a short and long option
>> +|    -h, --[no-]help       show the help
>
> Indeed it is amusing, but we probably should give PARSE_OPT_NONEG
> appropriately, instead of changing the expectations, for many of the
> changes we see here, I think.

... and --help is the one obvious choice for me, because --no-help is
not supported, of course.  But we can use some more dedicated tests of
negation and double-negation.

Ren=C3=A9
