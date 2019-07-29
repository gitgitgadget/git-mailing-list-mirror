Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED821F462
	for <e@80x24.org>; Mon, 29 Jul 2019 09:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfG2JNP (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 05:13:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46126 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfG2JNP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 05:13:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id d4so58684097edr.13
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 02:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LpVGiVtUJSMKo9moxXdxFKoFknTZhdEzhrfh7bsyEFw=;
        b=qMliZyh+V2+bujr+doEDeHiiIqOaUn1bKbV2KLYc6/OrkW7voCZ0sgTsc3AxiCFpDl
         WWWnmcqCy2s1cDFb4um7UFYQfu80NbAz8HCNbkslJ4Asu73NyhwibAwL0JxbGi41WJNZ
         paIxLwjTy7gqEiyLhPljPcFoj3hHz4ICW0iMobs30RxmtLYLHUxEjyuIR2HWWQFFBiq4
         PXo9eAgDaawi9hpcNbhcLZIQQgfuVxtj3WZ3CHLR9Kd5vfTPuCcVXPYEdnJxgNJ87JPM
         ctIlYhKRWI1ivvTjNmyLcigo2qYqKT3bsZCiZDptzAznCyKKAt/gPri/ScFgk1/WeUrh
         q8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=LpVGiVtUJSMKo9moxXdxFKoFknTZhdEzhrfh7bsyEFw=;
        b=FoGC/7F1MiIS7HFc80Ptvdr/3KVfGE9Z4BSwPUZbAVVflebRURQr8FyblyXDh7aGAk
         P+Ht3+gjSVlwfR1pSQRd6uZ5u59XtYJbAEx4zTt76MzUngQnkaA9vUi8W3ZpWmPuQQed
         fzW9KSoPHdlBhFjksXWKSa3r38c2pIJIKcpQaIATPYfTfmQeQZF8gia7axiCNKENwKAD
         KpQE5xkJrWwceLxD8yFD+3x7oNhrV9kO49sAvUAkZaJm1n30TSrz6PU2leKi400TkVPe
         JPaQQLE4TDPCJXs9TqHSAv/8BNAWfP2NBafS3odOshzaj0QWGV3w1txrd24/qZz7MRtz
         Fjuw==
X-Gm-Message-State: APjAAAUWRG2HulVI+5c5Fa9fkQBwhHno1dC47NimyBRD1+38E9sg+cId
        ZC0td39h5tGdoC/YbZHSveLjZxEypKQ=
X-Google-Smtp-Source: APXvYqy0jXrDu4utB/8eRzbmGGImNtRk/FnN4iUR4NAJcRqEedJJcK28jXSNA33csl8fE/jBwg6gQQ==
X-Received: by 2002:aa7:da03:: with SMTP id r3mr94391884eds.130.1564391593717;
        Mon, 29 Jul 2019 02:13:13 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id k23sm5690560ejs.67.2019.07.29.02.13.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 02:13:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/8] grep: consistently use "p->fixed" in compile_regexp()
References: <20190724151415.3698-1-avarab@gmail.com> <20190726150818.6373-5-avarab@gmail.com> <CAPUEspgay3RnLH3pdEWyktgn8XeuiKZ8PYPNB_38gyxffmh5Jw@mail.gmail.com> <871ry96wiq.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <871ry96wiq.fsf@evledraar.gmail.com>
Date:   Mon, 29 Jul 2019 11:13:12 +0200
Message-ID: <87zhkx5hlj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 29 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Jul 29 2019, Carlo Arenas wrote:
>
>> On Fri, Jul 26, 2019 at 8:09 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>>
>>> It's less confusing to use that variable consistently that switch back
>>> & forth between the two.
>>>
>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>>> ---
>>>  grep.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/grep.c b/grep.c
>>> index 9c2b259771..b94e998680 100644
>>> --- a/grep.c
>>> +++ b/grep.c
>>> @@ -616,7 +616,7 @@ static void compile_regexp(struct grep_pat *p, stru=
ct grep_opt *opt)
>>>                 die(_("given pattern contains NULL byte (via -f <file>)=
. This is only supported with -P under PCRE v2"));
>>>
>>>         pat_is_fixed =3D is_fixed(p->pattern, p->patternlen);
>>> -       if (opt->fixed || pat_is_fixed) {
>>> +       if (p->fixed || pat_is_fixed) {
>>
>> at the end of this series we have:
>>
>>   if (p->fixed || p->is_fixed)
>>
>> which doesn't make sense; at least with opt->fixed it was clear that
>> what was meant is that grep was passed -P
>
> I assume you mean "was passed -F...".
>
>> maybe is_fixed shouldn't exist and fixed when applied to the pattern
>> means we had determined it was a fixed
>> pattern and overridden the user selection of engine.
>
> They're two flags because p->fixed is "--fixed-strings", and p->is_fixed
> is "there's no metachars here". So the former case needs escaping, as
> the code just below might do (the two aren't mutually exclusive).
>
> I don't get how you think we can always fold them into one flag, but
> maybe I'm missing something...
>
>> that at least will give us a logical way to fix the pattern reported
>> in [1] and that currently requires the user to know
>> git's grep internals and know he can skip the "is_fixed" optimization
>> by doing something like :
>>
>>   $ git grep 'foo[ ]bar'
>>
>> [1] https://public-inbox.org/git/20190728235427.41425-1-carenas@gmail.co=
m/
>
> As I noted in a reply there this seems like a way to fix a bug in "next"
> with a config knob. Yes we should fix the bug, but we've had the kwset
> code in git for years without needing this distinction, so after we work
> out the bugs I don't see why we'd need this.
>
> The reason we ignore the user's choice here is because you might
> e.g. set grep.patternType=3Dextended in your config, and you'd still want
> grepping for a fixed "foo" to be fast.

...and more generally, for any future sanity of implementation and
maintenance I think we should only make the promise that we support
certain syntax & semantics, not that the -F, -G, -E, -P options are
guaranteed to dispatch to a given codepath.

Internally we should be free to switch between those, so e.g. if a
pattern is fixed and you configure "basic" regexp, but we know your C
library is faster for those matches with REG_EXTENDED we should just
pass that regardless of -G or -E.

Of course that means we *must* expose the same semantics (to some
reasonable extent), which means I have a lot of bugs in "next" to
address.

I'm just saying that the presence of those bugs means we should be
inclined to fix them / back out certain changes, not work around them
with user-servicable knobs.
