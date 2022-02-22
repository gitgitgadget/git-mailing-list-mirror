Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BD8C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 12:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbiBVMzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 07:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiBVMzh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 07:55:37 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD8B128DC5
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 04:55:11 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id r13so19587604ejd.5
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 04:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ltMh9xEZXMbUUahkFMzXJ8G3AlHS+vl0E8bYr37F1sA=;
        b=Iu4Q8gmDKJa6FtHwXE9p+KTM9192v4DnjufcMyAGftSex+4dn0cJns70LA8twgc1zr
         Trb+aLMe8zi7HPp7bYLM7/R3WcE0TgqDWOGO8W4AXDRyR2Tr34KSnS11fcZxzxTwT+nw
         fp+H2EnD3/0xZW3A/WNE6bdNiSe/krsWK6RkiGQogEtlCkwl2cfbiOlB4ygcqRb7C83E
         6RtSvBnBqyCNYf+V8RSuNxVg3nu4I88p5qmmhQMSRCocf92l27uUxGwrkSrH88Je1oGm
         +W1v6//AxOPbfVAPKCK1jbVOjKtUFYXIV08B7mDBDaiFyETiEq9lw9tq7m3um76g3eDE
         ZIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ltMh9xEZXMbUUahkFMzXJ8G3AlHS+vl0E8bYr37F1sA=;
        b=3gbanKvwFBpsRxZxP2NpnFrrcIG6efPcr7cYs72EpFiC3n4dLNvSXx77w7DDB5Nqww
         qu55h3BhtSqQuRQBmexWQ0PsZEWn9NYqI7l7HLPirgcp9d00Ev+KShaQeblpOa12ypv7
         lHpcDlHhx6wk7EOPwOD+FX+ldg1nU+QSfw6cbmcxqSIfsVfMHwMJbkLaDpKTOR3cnT71
         P2Sbw8b5NkyQTcU8T5JwuDt9BeBhgPL8CJy6MggSnuyDJrXAE/3Rr5GEhUA4Z7AFTFfw
         NzU84mGjV/YIxA4rBf2WA9Rf8RjkP1QIC0EKIdIHJYvH/7udqptFe1mivhAsb9+hnNIU
         5EIQ==
X-Gm-Message-State: AOAM532iUciVbwKwX+WauK83P3cALZaXkOJ8y1C9be2oR6//NNhZqesU
        NEjWzHwQtp2IWNxvWwgQZP8=
X-Google-Smtp-Source: ABdhPJxnukduLoorKUH38uXq/sYZmpsjA07nij5KtHEkbTG1g2h9sbYfZ3dzMMy+13w3bKhTNE8ePA==
X-Received: by 2002:a17:907:58e:b0:6ce:375a:4b8d with SMTP id vw14-20020a170907058e00b006ce375a4b8dmr18953846ejb.107.1645534509639;
        Tue, 22 Feb 2022 04:55:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id kw5sm6379608ejc.140.2022.02.22.04.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 04:55:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMUhA-0063YS-Lo;
        Tue, 22 Feb 2022 13:55:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git <git@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH] add usage-strings ci check and amend remaining usage
 strings
Date:   Tue, 22 Feb 2022 13:37:12 +0100
References: <220221.86tucsb4oy.gmgdl@evledraar.gmail.com>
 <20220221173357.8622-1-chakrabortyabhradeep79@gmail.com>
 <nycvar.QRO.7.76.6.2202221152230.11118@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2202221152230.11118@tvgsbejvaqbjf.bet>
Message-ID: <220222.867d9n83ir.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 22 2022, Johannes Schindelin wrote:

> Hi Julia,
>
> I would like to loop you in here because you have helped us with
> Coccinelle questions in the past.

Thanks. Probably better to CC the relevant ML, adding it.

> On Mon, 21 Feb 2022, Abhradeep Chakraborty wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> wrote:
>>
>> > That should be fairly easy to do though, and if not we could always
>> > just dump these to stderr or something if a
>> > git_env_bool("GIT_TEST_PARSE_OPTIONS_DUMP_FIELD_HELP", 0) was true,
>> > and do the testing itself in t0012-help.sh.
>>
>> Okay but if the logic can't be implented in the `parse-options.c` file
>> (most probably I will be able to implement the logic), would you allow
>> me to try the `coccinelle script` method you mentioned?
>
> The task at hand is to identify calls to the macro `OPT_CMDMODE()` (and
> other, similar macros) that get a fourth argument of the form
>
> 	N_("<some string>")
>
> The problem is to identify `<some string>` that ends in a `.` (which we
> want to avoid) or that starts with some prefix and a colon but follows
> with an upper-case character.
>
> In other words, we want to suggest replacing
>
> 	N_("log: Use something")
>
> or
>
> 	N_("log: use something.")
>
> by
>
> 	N_("log: use something")
>
> =C3=86var suggested that Coccinelle can do that. Could you give us a hand=
 how
> this would be possible using `spatch`?

I probably shouldn't have mentioned that at all, and I think this is
academic in this context, because as noted we can just add this to
parse_options_check() (linking it here again for off-git-ml context):

    https://lore.kernel.org/git/220221.86tucsb4oy.gmgdl@evledraar.gmail.com/

We now pay that trivial runtime overhead every time, we could run it
only during the tests if we ever got worried about it.

And it's a lot less fragile and easy to understand than running
coccicheck, i.e. as nice as it is it's still takes a while to run, is
its own mini-language, needs to be kept in sync with code changes etc.

So by doing it at runtime we can adjust messages, code & tests in an
atomic patch more easily (i.e. not assume that you ran some cocci target
to validate it).

It also makes it really easy to do things that are really hard (or
impossible?) with coccinelle. I.e. some of these checks are run as a
function of what flag gets passed into some function later on, which in
the general case would require coccinelle to have some runtime emulator
for C code just to see *what* checks it wants to run.

That being said (and with the caveat that I've only looked at this code,
not done this myself) if you clone linux.git and browse through:

    git grep -C100 -F coccilib.report '*.cocci'

You can see a lot of examples of using cocci for these sorts of checks.

And the same goes if you clone coccinelle.git and do:

    git grep -C100 @script: -- tests

For linux.git it's documented here:
https://github.com/torvalds/linux/blob/master/Documentation/dev-tools/cocci=
nelle.rst

I.e. it's basically writing the sort of cocci rules we have in-tree with
a callback script that complaints about the required change.

For our use it would probably better (in lieu of parse_options_check(),
which is the right thing here) to just have a normal *.cocci file and
complain if it applies changes. We already error in the CI if those need
to apply any changes.

But I don't off-hand know how to do that. E.g. I was trying the other
day to come up with some coccinelle rule that converted:

    die("BUG: blah blah");

To:

    BUG("blah blah");

And while I'm sure there's some way to do this, couldn't find a way to
write a rule to "reach in" to a constant string, apply some check or
search/replacement on it, and to do a subsequent transformation on it.

In this case the OPT_BLAH(1, 2, 3, "string here") has OPT_BLAH() as a
macro. I can't remember if there's extra caveats around using coccinelle
for macros v.s. symbols.

Disclaimer: By "couldn't" I mean I grepped the above examples for all of
a few minutes quickly skimmed the coccinelle docs, didn't find a
template I could copy, then ended up writing some nasty grep/xargs/perl
for-loop instead :)
