Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7427BC433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 09:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5775F610A1
	for <git@archiver.kernel.org>; Wed, 19 May 2021 09:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhESJvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 05:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhESJvB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 05:51:01 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34890C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 02:49:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v5so14572570edc.8
        for <git@vger.kernel.org>; Wed, 19 May 2021 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CvCgGacsovbHb6yOssbGvcXnwGNMERQFlUnsHFqn6fU=;
        b=lkvqYBUmgMQDubwlJncHlECbnCWWEdHoIKpmjQ5CGmZJCCln/uR9rcCnvFDAZQ8ggW
         RNemZ72tAnQN9iWaNjNCLDbCtON/SFA+LzWIobyh6mgXjYuf+CdDEEx5gFA1sq7MtaIT
         e+6Xz5qXAxdYCdCraWi5xxwB6PBUNdh8gHYGazhdCITPItN466o60o0Mu8mssxI8lsim
         srgQOJFM1FA9lul8ku2Yod3wm95QRxoQOTG8q2EmwyuPsoGJaWlVSkAXltMZb/Nud0u2
         nzcwxU+kF899pGp58O0kZooHlmXIoMRDtRLTJY7irsqVCwW7UASiVHVwfEboo7AP1Jct
         ueRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CvCgGacsovbHb6yOssbGvcXnwGNMERQFlUnsHFqn6fU=;
        b=kULstixpW0rEb9d+AhSNP53vR//NoaHn/jjwaGdVltFqy18tpznZWgL1FRQ9de/xuA
         TrWH/UNnvob1Dm5X52UiOMquT6DuGnNpMBVJ68LPBXFPHka3Q5CP3SgJoBXp94GPOYV7
         Q+JbRPtzmyEJUAtOJsGkUdfEO7abazY5Njqmiqnf3sLYZNvv0RBGeC1a70Fp7rZeJvOi
         etzaCUPQfTwRvrGsSNSdjj2s2CN3luM/lzksXWuG3E6+cjK83yqEYHrqjc/XNYKZBjPD
         WqQgKJP2Ywp4WMS02MrOO2H2nXnzP/jxq0BfgFRetARyDsdRJVbHyjusWJBKViczD0nr
         lbxw==
X-Gm-Message-State: AOAM533I216oYLOy6jbJLhk60pTt4+BmaTdc/NI0WHCgbuxleDLH/PNU
        HcW1uf7SyMMX7nors8hUU8eX96QurDIsAw==
X-Google-Smtp-Source: ABdhPJzRyu+YfQV5B/GSdrSspJrPQgG4MjMfpbjKkftBgN5nr32srKefz8T062nsRY7A2dvCN06Guw==
X-Received: by 2002:aa7:db57:: with SMTP id n23mr13382984edt.229.1621417775628;
        Wed, 19 May 2021 02:49:35 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l11sm14811788edw.42.2021.05.19.02.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 02:49:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] help: colorize man pages
Date:   Wed, 19 May 2021 11:26:12 +0200
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
Message-ID: <87im3fqci9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 18 2021, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2021-05-18 at 03:22:37, Felipe Contreras wrote:
>> brian m. carlson wrote:
>> > I think we should let the user decide whether they want to set this
>> > feature themselves instead of setting it for them.  For example, I have
>> > specific colors set up with these environment variables, and I'd like
>> > Git to honor them without having to configure Git independently of less.
>> > I expect other users will expect Git's rendering of the manual pages to
>> > work like other instances of man(1) on their system as well.
>> 
>> It does respect them.
>> 
>> This would render the man page with the color specified in the
>> environment, not the default of git.
>> 
>>   LESS_TERMCAP_md=$'\e[1;33m' LESS_TERMCAP_me=$'\e[m' git help git
>
> It still doesn't work like other instances of man(1) on the system.
> While you claimed that "that's a preference others don't share", I'm
> pretty certain that I'm not the only person who feels this way.
>
> There's a big difference between Git coloring a Git UI, like a diff, and
> Git coloring a separate program that already has sensible, standard
> defaults.  A user who has not configured any color settings would
> probably not want Git to render manual pages one way, cargo to render
> manual pages a second way, and still other programs to render manual
> pages in other, incompatible ways.  We need to consider not only the
> impact that our decisions have in a vacuum, but what results similar
> decisions from other projects would produce in the software ecosystem as
> a whole.
>
> Would you consider various projects coloring their respective manual
> pages differently to be a desirable state of affairs?

I think it's an important distinction that we're not coloring any manual
pages, it's a question of whether we invoke "man" invoked by "git help
<whatever>" with the exact same paramaters/options a user would get with
"man git-<whatever>".

Right now our documentation seems to suggest that we won't do any such
magic, but you can also set man.viewer to e.g. invoke a web browser or
something instead of man(1).

I don't think it's confusing in that context if we learn to do some "man
with fancy on top" in this mode.

>> > Additionally, using colors poses accessibility problems.  I know someone
>> > who, due to his colorblindness, finds terminal colors distracting and
>> > hard to read, and prefers not to use them at all.
>> 
>>   git -c color.ui=never help git
>
> Yes, but unfortunately, since you've colored the manual pages, they may
> be hard to read for the user who needs to read them to learn about your
> configuration.  This is great for you and me, who are already very
> familiar with Git and know how to do that without looking, but not great
> for the novice colorblind user.

Is the objection here against the use of color, or that we e.g. replace
grey bold underline with blue bold, as opposed to blue bold underline?

I'm not running the patch in this thread currently, but I'm running with
Felipe's earlier man alias noted in the other thread. So I see how
losing the underline would be confusing.

But if colors only add, but don't substract information by default
that's not an issue for the color blind, correct? Or at least that's
been my understanding in helping color blind user in the past (and not
being color blind myself).

I.e. issue isn't colors per-se, or even a UI that would make an
egregious of coloring, rather it's if that UI uses color as a
*replacement* for showing the same information in another way.

I may be entirely wrong, but I think it's a point worth bringing up to
find some solution here, i.e. if we find that not losing the underline
(but adding color) is a solution acceptable to everyone.

> For similar reasons, colorizing help output in general is unhelpful
> because users cannot find the options to disable it.

This seems to just be a re-hash of the old argument that git does
coloring by default, not specifically about "git help <xyz>".

I think there's good arguments for/against that, but I do think that
ultimately it was a good choice, and programs such as hg(1) seemed to
since have moved to git's more aggressive "color by default" stance.

> In general, this is made worse because Git doesn't honor the unofficial
> but widely supported NO_COLOR[0], so reading the documentation is
> obligatory.

I replied about NO_COLOR in
<87lf8bqdv0.fsf@evledraar.gmail.com>.

Regardless of whether or not that's a good idea I don't see how it's
relevant here. We'd support TERM=dumb, which is *the* standard way to
tweak this for all programs.

>> > Even users who want to use them might find some colors to be too
>> > similar, and this patch doesn't permit them to be configured.
>> 
>> Yes it does:
>> 
>>   LESS_TERMCAP_md=$'\e[01;38;5;33m' git help git
>
> I should clarify that the patch doesn't permit them to be configured
> using the normal Git mechanisms.  For example, unless the user sets the
> environment variables, which take effect globally, they're stuck with
> the colors that we've chosen here.  Yes, they can specify a single
> environment variable before the command, but practically nobody will do
> that.
>
> It's my argument that the user doesn't want Git manual pages to be
> colored differently than other manual pages on the system, but if you
> believe differently, then we should allow the user to configure the
> colors that are used in the Git-specific context using Git standard
> mechanisms.

I'm in vehement agreement about this. If we do invoke "man" differently
based on how we'd do coloring for any other git program we invoke, we
should of course be respecting the same configuration
mechanisms. I.e. it should respect color.ui=auto etc., you shouldn't
need to set LESS_TERMCAP_md or whatever.

>> > In my particular case, despite having normal color vision, because I use
>> > a transparent terminal which often results in a grey background, I find
>> > the standard terminal red to be difficult to read, and so this patch
>> > would result in a significant decrease in the readability of the manual
>> > pages for me.
>> 
>> If you have LESS_TERMCAP_md set in your environment, it won't.
>
> The problem is, I don't always.  I am on call for a set of hundreds of
> servers, only one of which has my shell configuration set up, so
> defaults here matter.  Moreover, because there are many novice users of
> Git, we should consider that for a decent number of users, they
> literally won't know where to look in our documentation to make
> changes, and therefore the defaults matter for them, too.

These servers don't have TERM in their list of AcceptEnv variables, or
equivalent?

In any case, I think for these defaults we need to be considering the
vast majority of users, who are mostly interfacing with one or two
computers in their use of "git", and who are running some modern OS that
supports terminal coloring, which is why color.ui=auto became the
default (to some objections at the time, but I think those have gotten
less prominent as time marched on).
