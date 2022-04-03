Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD24AC433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 15:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359252AbiDCP5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 11:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbiDCP5s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 11:57:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEF3396BE
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 08:55:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b24so8298222edu.10
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=mkOyAti6NtfS90CxUqMOmKc/EntvPtNBrRTyL920aT8=;
        b=pQlF0K36ACSlOtp+htuz+dbzeLneN/A9TcsDg6faeMmBrlpMrc5RqY2rqz8g1n1mEm
         E91O/68lDQxaF5I0u7tYLhQXpsJ9fs9PcglHGmQ7oryQE+v23IfvKmdpDllofSKQ6APo
         XuDUDRRawyckOJr84EwBIOdy8Ad2BQENwdnsM0S6oOc7fiyNp5MU1xmi+6OzUEgEke4Z
         x0e6q3j4Gio0rRMJ+TSLxM03DDOF/5l87xS5xrUvHXfiyZv7/f/2F8tVMwYlB/uTadjV
         WQL3hlVctq0ar7m0K71Cjt7mK69wxHmpsEQzJJxloSfhNKCshHUWhEosLYX2mst+yD1X
         P/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=mkOyAti6NtfS90CxUqMOmKc/EntvPtNBrRTyL920aT8=;
        b=GnaA2W5ezfVD+ngiQHxpKj0b4STqfUQ0pU0/M9J0LSisw4P5RQibLPUrxQUjczUpkA
         SQizuagMAYpe+uCp1xcnEZxZG2Gk3m81AO/iSfsvXTtNTy7A4qdVyJBqUUGDrgreD8+u
         nEpMxLq6+WoYWg2biB9rrMfL16ZJEVJ19tGHVCo6Frd207R6GIGglBnwox5Bu+bmdP4I
         J5me3+rGTPenZzMRdhngCk1x18OpeU7sN+vziyqA/+9W1Itd4pKvLmChgUo3r9qabCcL
         evs/kT38YSTOnrBHSip8ep+cfYGUegzt/QI7AG2ZDBFHB7VR/4ZN/i+igUtygFtiZ5Yz
         p5EQ==
X-Gm-Message-State: AOAM530NqaZL3pVb+8L3Nw9jUCf2XqTmQZ3YlC7PJpaejQiibGh33z5p
        h9aa0yksNPzp0ggBEkPB/PI=
X-Google-Smtp-Source: ABdhPJxzhJnzUJCHwZyHfCUwPH1TJfWqF6/WJQOo2BXeOqT0YmipqJ7WrgfQsdSszUmapWfqXA4h8A==
X-Received: by 2002:a50:a408:0:b0:41c:cdc7:88bd with SMTP id u8-20020a50a408000000b0041ccdc788bdmr1759858edb.399.1649001351856;
        Sun, 03 Apr 2022 08:55:51 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w6-20020a170906d20600b006ca00cb99e0sm3333641ejz.34.2022.04.03.08.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 08:55:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nb2Zy-002H8S-Mn;
        Sun, 03 Apr 2022 17:55:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 7/7] git-sh-setup: don't mark trees not used in-tree
 for i18n
Date:   Sun, 03 Apr 2022 17:22:21 +0200
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
        <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
        <patch-v3-7.7-7a82b1fd005-20220326T171200Z-avarab@gmail.com>
        <2e2d20d6-a33d-b223-d364-ab43d92dd220@kdbg.org>
        <220327.8635j3fx3t.gmgdl@evledraar.gmail.com>
        <63bf6e97-1dca-c2b1-5673-301039e73acf@kdbg.org>
        <220328.86lewudzw3.gmgdl@evledraar.gmail.com>
        <45c963da-19a5-de51-34d4-5b29f461c9ec@gmail.com>
        <220331.86a6d6qqfe.gmgdl@evledraar.gmail.com>
        <12c7c651-49d2-d38b-122a-3fb5c29e94df@kdbg.org>
        <220402.86r16fn2bx.gmgdl@evledraar.gmail.com>
        <cc9aaba3-6904-4f96-db50-a368b9d9f0f2@kdbg.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <cc9aaba3-6904-4f96-db50-a368b9d9f0f2@kdbg.org>
Message-ID: <220403.86fsmukvp5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 02 2022, Johannes Sixt wrote:

> Am 02.04.22 um 12:44 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>=20
>> On Thu, Mar 31 2022, Johannes Sixt wrote:
>>=20
>>> Am 31.03.22 um 13:15 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>> I do have some WIP changes to tear down most of the *.sh and *.perl i1=
8n
>>>> infrastructure (the parts still in use would still have translations),
>>>> and IIRC it's at least a 2k line negative diffstat, and enables us to =
do
>>>> more interesting things in i18n (e.g. getting rid of the libintl
>>>> dependency).
>>>
>>> Why? Why? Why? Does the status quo have a problem somewhere? All this
>>> sounds like a change for the sake of change.
>>=20
>> So this is quite the digression, but, hey, you asked for it.
>
> Oh, no, this is not a digression *at all*. What your write below is the
> kind of text that is needed to judge the value of a change. Without it,
> a change that does not have an otherwise obvious improvement[*] is just
> for the change's sake.

Well let's be clear here.

It's been your claim that the proposed change must not be worth doing
because you don't place the same value on having a 1=3D1 mapping between
strings we ask translators to work on, and those that we'll actually
present as part of git's UI.

Which is fair enough, and something we can respectfully disagree on.

But that's not the same as claiming that the stated reason for the
upthread patch is incomplete or insufficient.

I can tell you that as the person who implemented this whole i18n
facility that providing translations for someone's random shellscript
was never the point, at all.

It just so happens that because we implemented some bits of
functionality of the porcelain as shellscripts, and at the same time had
a shellscript library which (regrettably or not) seems to invite both
in-tree and out-of-tree users to use it,that the two went hand-in-hand.

But now that they don't anymore I don't see anything "handwaving" about
simply removing the translation markings. I don't think they serve any
purpose anymore.

> [*] In my book, getting rid of a libintl dependency is not an obvious
> improvement. I may be biased in this case, because that dependency was
> never a problem for me. Might be because my personal builds all have
> NO_GETTEXT set.

So not only don't you use a translated version of git, but you don't
even compile one with it?

Yes, I can imagine that hasn't exposed you to any of the problems with
it :)

>>>> But I also don't think that such a series is probably not possible in
>>>> the near term if we're going to insist that all shellscript output must
>>>> byte-for-byte be the same (for boring reasons I won't go into, but it's
>>>> mainly to do with sh-i18n--envsubst.c).
>>>
>>> Such an insistence can easily be lifted if the change is justified
>>> sufficiently. I haven't seen such a justification, yet.
>>=20
>> Sure, but re the "chicken & egg" problem I might do all the work to do
>> all that, and someone such as yourself might rightly point out that it
>> would break someone's obscure use-case, scuttling the whole thing.
>>=20
>> Which isn't an exaggeration b.t.w., if you e.g. look through our
>> remaining gettext.sh usage you'll find that we carry the entirety of
>> sh-i18n--ensubst.c and everything around it (at least ~1k lines) for
>> emitting a single word in a single message in git-sh-setup.sh, that's
>> it.
>
> See, someone thought it was a good idea to have i18n in shell scripts
> and others agreed that it was worth having ~1k lines of code to do that.
> So the code went in. From then on, these ~1k lines are *not a problem*
> in themselves. From then on, the decision of having ~1k lines or not
> having them can only be based on what effect they have, but no longer on
> "oh, wow, that's 1k lines to write a single word; do we really want that"?

Aside from i18n. I don't agree with that in general.

Yes, code that's in-tree and working needs to be under less scrutiny as
a new addition, and refactoring something isn't always worth it. We'll
also need to review the removals.

But there's also a cost to keeping things around, as you can e.g. see
from various portability and correctness fixes to this code we've
perma-forked from the GNU GPLv2 version.

There's some tipping point wherea refactoring isn't worth it, but
emitting the word "usage" with ~1k lines is a pretty clear candidate in
my mind for a "git rm".

>> Because the whole reason eval_gettext exists, and everything to support
>> it, is to support the use-case of feeding *arbitrary input* into the
>> translation engine, i.e. not the string you yourself have in your source
>> code & trust (it avoids shell "eval").
>>=20
>> But if you think that's of paramount importance (that word is "usage"
>> b.t.w., and the equivalent in usage.c isn't even translated) there
>> wouldn't be any way to make forward progress towards the next step of
>> making the remaining shellscript translations call some "git sh--i18n"
>> helper to get their output.
>>=20
>> So, to the extent that I was going to pursue the above plan at all I
>> wanted to do it in small steps, especially now as git-submodule.sh et al
>> are going away.
>>=20
>> So.
>>=20
>> It would be nice to get some leeway in some areas, especially for
>> something like this where I implemented this entire i18n system to begin
>> with, so I'd think it would be clear that it's not some drive-by
>> contribution. I clearly care about the end-goal, and have been sticking
>> with this particular topic for more than a decade.
>>=20
>> Not everything can always be a single atomically understood patch that
>> carries all possible reasons to make the change with it, some things are
>> more of a longer term incremental effort.
>>=20
>> And since we all have limited time on this spinning ball of mud
>> sometimes it can make sense to trickle in initial changes to see if some
>> larger end-goal is even attainable, or will be blocked due to some
>> unforeseen (or underestimated) reasons.
>
> You can't have leeway for a change whose conclusion is "removes some
> miniscule feature". But if you add "Here is the secret plan to Scrat's
> golden nut; let's start with this change, even though it removes some
> miniscule feature", things are vastly different.

I mean leeway on the topic that I probably have some idea of what I'm
talking about when it comes to git's i18n support, and whether it's
worth the effort to keep certain things around or not.

I.e. you started this thread by claiming that the removal of these
translations would be "castrating [out-of-tree] functionality, [which
is] unacceptable.".

As noted above I don't think that assessment is correct, and if I'm
understanding you correctly you don't even use git's i18n mechanism at
all.

Which I think presents only two possible conclusions.

One is that I, the person who added the i18n mechanism in the first
place, am so clueless about how it work or what it's for, that I'm
(intentionally or not) submitting patches that "castrate" it.

The other is that you've understandably missed some of the nuance, such
as why we're even marking strings for translation, and what the intended
audience of them.

