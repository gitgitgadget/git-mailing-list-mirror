Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E6BC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 11:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B56764E32
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 11:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhBWLGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 06:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhBWLGv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 06:06:51 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628E9C061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 03:06:11 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id j9so25444693edp.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 03:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xbk84pdb4uGBnoE7vjTEadmxia9YEpYNL9Smj3qa2nU=;
        b=YW1vVHDNZPygTndOoqbzxmwZuoqLHeA0oQOhmC47sYTOoHvm7u1boY1XUrd0GvBBLx
         Sm+xMGcUt1KzL6nTShDlvGVqqdxVek7YnUVORQdWm8svN6aUhUX3KxXNLtNp56THx3cf
         N/o9yEoYHfu4XLFDA9p1kgbC10ZX00W4PNCSQArEL74HSZ4eoY6IsA8CMs7W0pUi0uaW
         cPzQDkqjoL2tbUBOoEB4xbx5Eef3In/YWpFSvnRhU/XiPs4WjFPKBWRDTofBpw73gh1X
         lGzEB2v79jZI/wGLCQgnYPSbM9A79mnW34Q2hrjCwhvY02bDydMDhtANkIWH0kCncrGv
         462w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=xbk84pdb4uGBnoE7vjTEadmxia9YEpYNL9Smj3qa2nU=;
        b=Capkn817Qu54iBIsX9xNDY8FPPwO7v0OM/hEqzFoISGVM49n2afaNt0pBlX4l4sBqC
         IDKDoRiyUNDYwfGJ4YutDH3zDYiFL4BGhyTWeB5yC/FhTJXM7tl01JJIFO1uDplvGOjY
         TvJ+GqmzI4V4m8vCZA43ecxVn1LMGZrFqUw4sXaJM3ZoIcF9a+ORQTaIqrRHHE5VHi7Y
         4yL6dJjzJxaKaVuh/PTQZfqk6YWcAzcdoJ7tBhMkuSfW7y6pLnQblvOFBBTc+SYXIQmF
         COHm27GCnnCb7axu4bM8Nqr5Oj005B1DooIdTHB8U+ZRBi1XciXNHC0sW5JlzmZbbgyO
         opWQ==
X-Gm-Message-State: AOAM533oFz3BTS/zWE7Rz/HfkvTRU6nbG1KQCqdADYx5GqM2E8VKFeG5
        JK43nPHfc0Vrzv7H1Mjy6DE=
X-Google-Smtp-Source: ABdhPJwBkRujnGMvskQnQDNtDhEW5x/FTnm/nQhbdLP9VfimHwIZs+EzcGgFYwj2ZEgO+2iLNJ45OQ==
X-Received: by 2002:aa7:c2cd:: with SMTP id m13mr26739896edp.176.1614078370043;
        Tue, 23 Feb 2021 03:06:10 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id qn24sm12341517ejb.104.2021.02.23.03.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 03:06:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: New orphan worktree?
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
        <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
        <CAPig+cRzXd+zd+xVisaW+HToSaGzAE28acGmxwRxNU4bczHXbw@mail.gmail.com>
        <87wnv688u4.fsf@evledraar.gmail.com>
        <CAPig+cQ9oqMWjBkyRt-SQFuyfAGkMu1J-U6ZCCJqeL0a_3ynkw@mail.gmail.com>
        <87ft1o8mi0.fsf@evledraar.gmail.com>
        <CAPig+cSkL+5otKUWwm=CLaRR+j71wW61U7LWtmuUHO+7bZaY_g@mail.gmail.com>
        <87czwr8wou.fsf@evledraar.gmail.com>
        <CAPig+cQxYtw5z_bRQbS6MLgHQM2OTs5oRfpvKSOwZo8GcuwpTg@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAPig+cQxYtw5z_bRQbS6MLgHQM2OTs5oRfpvKSOwZo8GcuwpTg@mail.gmail.com>
Date:   Tue, 23 Feb 2021 12:06:08 +0100
Message-ID: <87a6rv82n3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 23 2021, Eric Sunshine wrote:

> On Mon, Feb 22, 2021 at 7:17 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Tue, Feb 23 2021, Eric Sunshine wrote:
>> > I'm not sure I follow. In git-switch, --orphan does not imply -c even
>> > though --orphan also creates a new branch (thus seems to work similar
>> > to -c); it is nevertheless mutually-exclusive with -c and -C. The same
>> > goes for --orphan in git-branch.
>>
>> I think we're on the same page with regards to what I meant. I.e. I
>> don't see how it makes sense to conflate the type of branch we want
>> (orphan or not orphan) with whether we want to clobber that branch or
>> not (switch -c or -C, or worktree -b or -B)
>
> I see where you're coming from in viewing --orphan as a modifier of
> branch creation rather than as a branch-creation option itself.
> However, as far as UI is concerned, that ship sailed a long time ago,
> I suppose.

Not really, I think we can have a new-style of it and just say:

    It is also possible to provide `--orphan <branch-name>`, but
    supplying it as an option to `-[cC]` as `-[cC] <branch-name>
    --orphan` is preferred these days.

Whether we should is another matter, see below...

>> > As far as combining --orphan and -C (or -c), I'm not sure how we would
>> > arrange that using the existing parse_options() mechanism. It seems
>> > too magical and has potential for weird corner cases.
>>
>> Isn't it just having --orphan be an OPTION_STRING with
>> PARSE_OPT_LASTARG_DEFAULT. I.e. to support:
>>
>>     git switch -b branch --orphan
>>     git switch -B branch --orphan
>>     git switch --orphan branch
>>
>> And:
>>
>>     git worktree add -b branch --orphan
>>     git worktree add -B branch --orphan
>>
>> I didn't test it, just skimmed the code.
>
> I haven't dived into this stuff in a long time, but I'm having trouble
> convincing myself that it would work out as intended. If I'm reading
> PARSE_OPT_LASTARG_DEFAULT correctly, `git switch -b <branch> --orphan`
> would not be the same as `git switch --orphan -b <branch>`

Yeah, I think so. But I think for an option like that it would be more
obvious. I.e. we could say:

    If "-b" or "-B" is provided a subsequent "--orphan" is a boolean.

We don't support the combination of the two now, so we could just
mandate that the order matters.

Anyway...

> , and I don't think it would work at all for git-worktree-add which
> has additional <path> and <commitish> arguments (i.e. `git worktree
> add -b <branch> --orphan <path> [<commitish>]`).

...we can parse these options, whether it's easy or trivial with
parse-options.c is something I'd like to leave aside for now.

Right now I'm not intending to re-roll this patch, but maybe someone
else (or even me) will get to it sometime. I think it's more useful
if/when that happens to get people's take on whether this makes sense as
UI, not whether it's trivial with the current parse_options() API.

I think it's fairly easy to tease this behavior out of
parse_options(). Worse case we can do a pre-loop over argv and see if
both "--orphan" and "-b"/"-B" occur. if so parse it with "--orphan" as a
BOOL, otherwise STRING.

> Anyhow, as I responded elsewhere to Junio, my present leaning is
> toward -b, -B, --orphan all being mutually-exclusive branch-creation
> options, each taking a <branch> argument -- just like they are in
> git-checkout and git-switch (-c/-C, in this case) -- and allowing
> --force to overwrite an existing branch (in which case, -B can be
> viewed as shorthand for `--force -b`).

See https://lore.kernel.org/git/7vpqzlrmo4.fsf@alter.siamese.dyndns.org/
for past Junio arguing with his future self :)

I.e. the reason we had -B in the first place is because --force means
something else. We'd need "--force-ref-deletion
--force-work-tree-clobbering" or whatever, or "--force --force".

I like this lower/upper case convention. It started with "branch -D" in
ba65af9c1f6 (git-branch -d <branch>: delete unused branch., 2005-09-14),
but in checkout the --orphan option pre-dates -B. See 9db5ebf4022 (git
checkout: create unparented branch by --orphan, 2010-03-21) and
02ac98374ee (builtin/checkout: learn -B, 2010-06-24).

I don't think we're going to change how "branch -D" and "switch -C" work
at this point, so making things consistent with it makes sense.

>> > Since git-worktree doesn't yet support --orphan, we certainly have
>> > more leeway and could go with your proposal of having --orphan be
>> > boolean and always requiring it to be used in conjunction with -b/-B.
>> > However, I'm quite hesitant to take that approach since it breaks with
>> > existing precedent in git-branch and git-switch, in which case
>> > --orphan takes its own argument (<branch>) and is mutually-exclusive
>> > with -b/-B/-c/-C.
>>
>> In git-branch? Isn't it only git [checkout|switch] that takes --orphan?
>
> Um, yes, I meant git-checkout everywhere I wrote git-branch. Sorry for
> the confusion.

*nod*

>> I think not having a -B or -C equivalent at all would be preferrable to
>> having a --force special-case just to work around the lack of it for
>> --orphan.
>
> I'm having trouble wrapping my brain around this statement.

I mean I'd rather not have an --orphan mode that works like -B (as
opposed to -b) at all instead of having one that's "--orphan
--force-ref-deletion" or whatever.

It's an obscure enough thing that I don't think anyone *really* cares. I
just wanted to find out if it not being a boolean was intentional, or a
historical accident we would consider fixing if there was further work
on it.
