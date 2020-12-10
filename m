Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD81C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 14:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B09E23CD4
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 14:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389488AbgLJOPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 09:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389197AbgLJOPl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 09:15:41 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F03DC0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 06:15:01 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c7so5647348edv.6
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 06:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=EWH286/43bNjdoG+3l2MtBPouip5Xy8aYxIaJmzdc4E=;
        b=RgIrUISZYiMpWUj4mhq6i2F+7f0DUQ3tCP1IpCBb02zMK7PZ4Qt6OKmp89PabDtX9l
         YXOthzEFsei2hR/hAhD2XM9+Jf/AcLyPUZl/hLS6laMnAuDUVFej+5P3nZmd3/bobjSH
         VecszuC1LFPG3xLSvkyUBlkRPL4hDalaAtarc/OqEdwDUEJBuQArZ7R58KwWrhaOOXfq
         Y1EjzzjrsU1+5ZBDB6wZ6Xg7qrrw9XAN2AZS5cZNpAAvqAWeinhF5OiMihsPWu7Scfgb
         tlBv2YjzgRUy2XhuePL9VhDnaJoa4PV9San7xiEn/USym7v81Behjg4xCgJHsOu0/Rjj
         a7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=EWH286/43bNjdoG+3l2MtBPouip5Xy8aYxIaJmzdc4E=;
        b=s3sIwmERADhjZiyfWj8Z+lOhxi1vbTMWvZlRvQzpkz5m08fXZSPr9EqNjEoh0/MOws
         i/1WzEU1LxoIIofbdD8XRgSl2Lljl4m9b1ap3+ELjGSPEHVusxMBdVM8F3z7gnIAmX3i
         46e4zNbPCjeQVSmWQi62MEriPhAWkijk0hoKst5iWewdEYS9UtvErKQbbUO8p0e4+a+B
         d4+GqffmR0pMqcUtwg4wzz9ZriqHNa8ruFbuHdFbALO46S3MoKdGsa/TGD2mkddaTJRT
         aOs75isuBpOC+d6YNjH8m4cIhTfJIlDkBjmRSQQ694O9x5a3LbTaSGXVJ5vfftfB361R
         nbgg==
X-Gm-Message-State: AOAM531/UhKpbqLYwgFexY6ddUM9zwu9AbSElpmKb4fAh5ySghSMQtIc
        Tr3av0uPCqDSpfhwhplvw8G91ZfrVxypWQ==
X-Google-Smtp-Source: ABdhPJyns/MJezSgqU6mHJwlDxQS0+y9h89PMuygHcAozrRTLN68Af03XEQGzzP94Ceb5D1E7UqjyA==
X-Received: by 2002:a50:8d89:: with SMTP id r9mr6682034edh.144.1607609699960;
        Thu, 10 Dec 2020 06:14:59 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id m24sm4507673ejo.52.2020.12.10.06.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 06:14:58 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: RFC: Modernizing the contept of plumbing v.s. porcelain
References: <878sa7xujm.fsf@evledraar.gmail.com>
 <xmqqczzi3h3a.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <xmqqczzi3h3a.fsf@gitster.c.googlers.com>
Date:   Thu, 10 Dec 2020 15:14:58 +0100
Message-ID: <87v9d9wxwd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 09 2020, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> A lot of external guides and people's mental models of /usr/bin/git as a
>> scriptable client reference the concept of plumbing & porcelain. Just
>> one such example [1] prompted me to write this E-Mail.
>>
>> I've wondered if we shouldn't be updating this concept to reflect the
>> reality on the ground in the git command ecosystem.
>
> The example tells me that they are trying to be a good ecosystem
> citizen by sticking to the plumbing and refraining from using
> Porcelain command when writing their script.  The practice gives
> them assurance that we won't unilaterally break them, and gives us
> the freedom to improve Porcelain for human consumption.
>
>> I.e. if you look at "git help git"'s list of plumbing v.s. porcelain it
>> makes no mention or distinction between those commands & functionalities
>> that are truly transitory "porcelain". E.g. the specific error message a
>> command might return, and those that are effectively plumbing. E.g. some
>> "git config" functionality, "git init", the pretty formats in "git log"
>> etc.
>>
>> I'm not quite sure what I'm proposing if anything, just putting out
>> feelers to see if others think this documentary status quo has drifted
>> from reality.
>>
>> One potential change would be to mostly/entirely remove the
>> "porcelain/ancillary/plumbing" distinction in "git help git" (except
>> maybe e.g. "hash-object") and instead make a mention of the status of
>> the command at the top of its own manpage, which could then also
>> (e.g. in the case of "git log") document the API reliability of its
>> various sub-features.
>>
>> 1. https://gitlab.com/gitlab-org/gitaly/-/blob/afc90e3c2/doc/serverside_=
git_usage.md#L11-17
>
> I am not sure what you want to propose as a solution, but even
> before that, what problem you are perceiving.  Are you wondering if
> it may be a better general direction for us to tell "no, no, there
> is no value in sticking to the plumbing because we will break you
> anyway in the future" to those who wrote [1]?

I was updating that documentation, and ended up going for:

    +#### Plumbing v.s. porcelain
    +
     `git(1)` is the default choice to access repositories for Gitaly. Not =
all
    -commands that are available should be used in the Gitaly code base. Gi=
t makes
    -a distinction between porcelain and plumbing commands. Porcelain comma=
nds are
    -intended for the end-user and are the user-interface of the default `g=
it`
    -client, where plumbing commands are intended for scripted use or to bu=
ild
    -another porcelain. Gitaly should only use plumbing commands. `man 1 gi=
t`
    -contains a section on the low level plumbing.
    +commands that are available should be used in the Gitaly code base.
    +
    +Git makes a distinction between porcelain and plumbing
    +commands. Porcelain commands are intended for the end-user and are the
    +user-interface of the default `git` client, where plumbing commands
    +are intended for scripted use or to build another porcelain.
    +
    +Generally speaking, Gitaly should only use plumbing commands. `man 1
    +git` contains a section on the low level plumbing. However, a lot of
    +git's plumbing-like functionality is exposed as commands not marked as
    +plumbing, but whose API reliability can be considered the
    +same. E.g. `git log`'s `--pretty=3D` formats, `git config -l -z`, the
    +documented exit codes of `git remote` etc..
    +
    +We should use good judgement when choosing what commands and command
    +functionality to use, with the aim of not having gitaly break due to
    +e.g. an error message being rephrased or functionality the upstream
    +`git` maintainers don't consider plumbing-like being removed or
    +altered.
    +
    +#### Executing Git commands

I.e. the existing advice was to say "just use plumbing", now it takes a
more nuanced view of e.g. pointing out that certin porcelain commands
have "-z" options that can be considered as reliable as things
explicitly marked as plumbing.

It's widespread traditional wisdom when discussing git that there's
plumbing and porcelain, but I think ever since all the builtins were
shellscripts way-back-when this distinction has blurred.

We now have some plumbing tools whole entire functionality is considered
a stable API, some porcelain tools you shouldn't rely on at all for
that, but a large set of tools that are in-between somewhere. E.g. maybe
their output format(s) are "plumbing-like", or some options (such as
"-z") but not others.

I think updating our documentation to reflect this would be a good idea,
and I'm willing to write those patches. Just thought I'd weather-balloon
what others thought about it first.

I think a good way forward there would be:

 1. Keep the high-level/low-level list in "man git", but not mention
    plumbing/porcelain so prominently.

    Some of that's ... a bit suspect, e.g. "its low-level commands are
    sufficient to support development of alternative porcelains", but
    then git-config(1) is porcelain. These days you're not getting very
    far in developing your own alternate porcelain with just the
    plumbing commands.

 2. Either inline at the bottom, or probably better in a new
    gitplumbing(5) (or gitapi(5) or something) explain the nuance, that
    some commads are pure-plumbing, some pure-porcelain, and some are
    hybrids.

    That you can follow some general rules (does it have "-z" output,
    can probably be relied on) to determine "plumbing-like", or
    porcelain-like (is it stdout/stderr output in English, does it
    change under i18n?), that not all manpages might explicitly call out
    plumbing / porcelain, and that when in doubt ask the list.

