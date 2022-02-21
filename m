Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DCDC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 16:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381137AbiBUQqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 11:46:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381200AbiBUQqj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 11:46:39 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6251824589
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 08:46:04 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bg10so34793567ejb.4
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 08:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=z+hMbs9jznyo7gjFsIhysvEPsIq06+yjKMNC5kr2/xQ=;
        b=EFED0m5N1/ZjMklYdGSLXlOzJqZAM6HOVs6tmuEvRwT8R4ho5rJly8LkGgRMeu+9h8
         3B+jzXm7Y46iuGLjC9eCF6cHSTzBAtr3WHGzPdd4ls3rSB6fyWSlgIgHHNkyHhiChIU+
         ZRFija+pIWPQBFPiYrc14T6MTZmkvlqp4IAQw/vh1JBJ+yDaoqoMm6iIdpBJT7JDCSuK
         tpF8x04A//iF3vCQZ0UaBJcgWrM/5e4IVshnEQzpXnE02sVVQ2bH3CuZ66zmOZZjiANM
         2Tt8xp5d+kbZwr3Jzx/XoNqbc8h0CIkXZhwyc90a4U4mJRZHKiWUwmUHzTwXqwtR7B54
         pfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=z+hMbs9jznyo7gjFsIhysvEPsIq06+yjKMNC5kr2/xQ=;
        b=JcLAnjP2XIgOvjUUI2cvpiUVBlasojUINmBBOpa/m/W+qpXPDokvCgtUEj9LtPcn07
         TtYcJ+r6hG2d+WL4Qax274zBbpH6HvkCoCJYgGWhe0q0e1d9BQMNb0k1hYkLwWCupAc1
         fB2foe/KB7SBMyl3RArWkUVFo+Ri0Zb+58LFVwKH7N26hjieO6Vt/4YJVmN43oBLfU4J
         upiMIO4viMcc7cyYxwonvv54ufuuwjMW9Uo9agb9l1vZq4Ut4N5V1KFrpWp0slLU4Uog
         /ydDBeVjO9tlKMA1dnxv97LyVh1JtqU+flWooQz+Fo3BWQ2gfQsjBDRQ50X5wwXPJHni
         sP5w==
X-Gm-Message-State: AOAM532AFB54BBCB2ei9lhEKPsGYqluZDvEpp7TMLqTK2UaIt/0h7cwh
        vytChALcMqu6p61nuw0YM+dFq2HZfEgUnQ==
X-Google-Smtp-Source: ABdhPJwOH7nTCn1aa3Z9gczy3NIRGj1qMaioVFEA/rS/A7aMPXQQqZ16sOfO4x5wQq0nlrD/bUIW2Q==
X-Received: by 2002:a17:906:2897:b0:6ce:e16a:c09c with SMTP id o23-20020a170906289700b006cee16ac09cmr15873548ejd.114.1645461962723;
        Mon, 21 Feb 2022 08:46:02 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ha3sm5339841ejb.157.2022.02.21.08.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 08:46:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMBp3-005jhm-B9;
        Mon, 21 Feb 2022 17:46:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Erlend Aasland <Erlend-A@innova.no>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] branch: delete now accepts '-' as branch name
Date:   Mon, 21 Feb 2022 17:34:01 +0100
References: <pull.1217.git.git.1645020495014.gitgitgadget@gmail.com>
 <xmqqbkz6vjkj.fsf@gitster.g>
 <00720bfb-c7b7-aaf2-e846-19b08d7b9cf4@sunshineco.com>
 <400A4D37-74EA-4F3B-BA3B-99FFDAE3CB3C@innova.no>
 <CAPig+cR0Ks2bnTRqs3uF4M+3q+n9X6pApBQ9HQTUq=zK5TpuXQ@mail.gmail.com>
 <xmqqiltd9vyg.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqiltd9vyg.fsf@gitster.g>
Message-ID: <220221.86pmngb22e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 17 2022, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Perhaps. Perhaps not. I may be misreading Junio's responses in this
>> thread, but it didn't seem like he was necessarily opposed to the
>> change.
>
> I do not care too much about this issue to expend my political
> capital on enforcing my preference ;-)
>
> FWIW, my preference in an ideal world would be to limit "-" as a
> short-hand to go back to previous (i.e. "checkout -"), which can be
> justified with similarity to "cd -", but do not add any more use.
> If we could, I would even deprecate "merge -", "rebase -", etc. that
> can not be justified with similarity to "cd -", but I think we came
> too far for that.
>
> "-" cannot be used as a universal "the branch we last 'git checkout'
> out of" notation because some commands and people expect "-" to be
> something else, like "read from the standard input".  The only two
> reasons this pops up from time to time is because "checkout -"
> exists and because "@{-N}" notation, which is accepted everywhere
> uniformly and does not have problems "-" has, is not very well
> known.
>
>> A documentation update as in [1] would be a good idea, though,
>> if resubmitted.
>
> Yeah, [1] talked about both "@{-1}" and "-", but limiting it to the
> former may make sense.  It feels a bit odd that we single out "git
> branch" and describe "@{-1}" there, when the notation is universally
> available, though.
>
>     $ git grep -l '@{-' -- Documentation/ :\!Documentation/\*/\*
>
> shows hits only in check-ref-format, checkout, switch, and worktree,
> but the mention in "revisions.txt" is included in all commands in
> the "log" family of commands.  If we add one to "branch", we should
> at least teach "@{-1}" to the documentation of merge, rebase, and
> revert.  The hits we see here
>
>     $ git grep -l -B1 '"@{-' \*.c
>     builtin/checkout.c
>     builtin/merge.c
>     builtin/rebase.c
>     builtin/revert.c
>     builtin/worktree.c
>
> all are about replacing "-" the user typed with "@{-1}".
>
> Continuing the "thinking aloud" a bit, I _think_ this tells us these
> things:
>
>  * @{-1} has way too many letters to type to be liked by users, who
>    won't learn or remember what they do not appreciate (and do not
>    blame them---it is a bad notation).
>
>  * @{-<n>} may have been a generalized way that satisfied geeky mind
>    while being implemented, but the users only need the "last one"
>    and no such generalization.
>
> If it is too late for a more easy-to-type-and-pleasant-to-eyes
> notation, perhaps "@-", that does not have downsides of "-" or
> "@{-1}", I have to wonder.

I too find the syntax really annoying to type.

I wonder if we couldn't say that:

 * @[-]N is the same as @{[-]N}. I.e. @1 is the same as @{1} and @{-1}
   is the same as @-1

 * Optionally (and this is a bit nasty) say that @{-} is a synonym for
   @{-1}, and therefore @- is the same as @-1 is the same as @{-1}.

   Nasty because the logical conclusion would be that @ is the same as
   @1, but it's HEAD, but this would allow us to have a shorter "@-" for
   "delete last", as opposed to "@-1". Also @{-0} (which would presumably
   be a synonym for "HEAD", or "@" errors out currently, and would continue
   to do so).

 * Declare that any other single-letter special @{...} syntax is the
   same as @...; In particular that @u would be @{u} which is short for
   @{upstream}.

 * Live more dangerously and allow @push @upstream etc.? One the one
   hand it feels a bit usurp-y to close the door on such a syntax having
   a similar meaning as regex flags where /ix is /i and /x, but on the
   other hand I don't really see us wanting @pu for "@push" and
   "@upstream" at the same time (makes no sense...).

I haven't hacked it up (and won't any time soon), Erlend: are you
interested? :)
