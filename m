Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC89C43334
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 06:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiGWFxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 01:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiGWFxv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 01:53:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F35CE0E8
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 22:53:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v12so7962649edc.10
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 22:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=DEUq+mkXtj8P0ZMpq1N3EkZ5cjsZt4sQ0ZiW+7W/ZIo=;
        b=jS23rCV5fBPTQv50QsDVTyVf+ldwme4NpjBTril+UeDhG/esQkJZykSg0lup8NsQfp
         USfDNFiLthQwsfLsQDwjYu85On6KwyiiOEqlvuNiJrTKd3vvbMAY+E947kN0C+wVrJIL
         88fcOXofSUAB9XWEHXCEviq3t6Tlloc4sMTO4LYPACGUGr3pGElg9NsJXii6ZxzVLI2N
         itsZMr68TytBSv4PSAtW2Dgg3Sfc/dkv5dX/OzxdbykIfbWa4tTSpuqdbyJuZ3dMZ6n7
         OaiYCLE9dle+ncMWojZa3MH6pn/9njdg2qInUiN9NQOyjljZ4VWYdCVPfnJ5bNBOaoeO
         rs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=DEUq+mkXtj8P0ZMpq1N3EkZ5cjsZt4sQ0ZiW+7W/ZIo=;
        b=GGry0W2ETqZ5e6XaRucht5OZF1RPnJXw+N9snLR0MyjaAhOoPRUAdT7+rKrxJUFByf
         8UcVpUax94CBYrhDUlXnKCFF/jihhq+H1L+OVQgrDgbRBd2BXx9KTdqPTtX7jVMZkk/M
         dmcr59ab27mTbrq8chAnPkbpKSY8dPE/1RRcWnd+Obcyli/MaYI2FNHFN6zUQyQqQcF7
         uXMQHGCE3O88W919ZFaKrLnvAgByCyYLKCi4rdZdEWh1tCm7vq08ZJjh/zauLW+pB5kF
         dx3Kl23aDmXGppPkUxzK1JIF0rDZV1pZG0gIF0YeH1FMJoEoAa5YcJtWGaQWmoFL0eOK
         G5GA==
X-Gm-Message-State: AJIora+N/keRfHeJdHMqYpuCamyOceO8MVSEDjaKcalD/KiZ9p4onybQ
        rv5FZ5hJy7xzTuf8xlFZCHE6kXBLaKc=
X-Google-Smtp-Source: AGRyM1sP5Ve2wWjrM5KlyIDqp2RQ/+1ra9H4+GhOEz+aaHMmpZuRARy7/R4RujibQ09b/Xe7db/zsg==
X-Received: by 2002:a05:6402:42c3:b0:43b:c870:9b54 with SMTP id i3-20020a05640242c300b0043bc8709b54mr2992455edc.11.1658555627413;
        Fri, 22 Jul 2022 22:53:47 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id vp5-20020a17090712c500b0072b1e27888asm2722364ejb.50.2022.07.22.22.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 22:53:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oF85C-005Qir-5R;
        Sat, 23 Jul 2022 07:53:46 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/7] merge-resolve: abort if index does not match HEAD
Date:   Sat, 23 Jul 2022 07:44:35 +0200
References: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
 <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
 <b79f44e54b9611fa2b10a4e1cb666992d006951c.1658466942.git.gitgitgadget@gmail.com>
 <220722.86sfmts9vr.gmgdl@evledraar.gmail.com>
 <CABPp-BHToEDv=8W9nf4XDC8b+5=EVuc=OnoT6xCRGWxB9CKWfw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CABPp-BHToEDv=8W9nf4XDC8b+5=EVuc=OnoT6xCRGWxB9CKWfw@mail.gmail.com>
Message-ID: <220723.86h738qsr9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 22 2022, Elijah Newren wrote:

> On Fri, Jul 22, 2022 at 3:46 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> [...]
>> I don't know enough about the context here, but given our *.sh->C
>> migration elsewhere it's a bit unfortunate to see more *.sh code added
>> back.
>
> This seems like a curious objection.  "We are trying to get rid of
> shell scripts, so don't even fix bugs in any of the existing ones." ?
>
>> We have "git merge" driving this, isn't it OK to have it make this
>> check before invoking "resolve" (may be a stupid question).
>
> Ah, I can kind of see where you're coming from now, but that seems to
> me to be bending over backwards in attempting to fix a component
> written in shell without actually modifying the shell.
> builtin/merge.c is some glue code that can call multiple different
> strategies, but isn't the place for the implementation of the
> strategies themselves, and I'd hate to see us put half the
> implementation in one place and half in another.  In addition, besides
> the separation of concerns issue::
>
>    * We document that users can add their own merge strategies (a
> shell or executable named git-merge-$USERNAME and "git merge -s
> $USERNAME" will call them)
>    * git-merge-resolve and git-merge-octopus serve as examples
>    * Our examples should demonstrate correct behavior and perform
> documented, required steps.  This particular check is important:
>
>     /*
>      * At this point, we need a real merge.  No matter what strategy
>      * we use, it would operate on the index, possibly affecting the
>      * working tree, and when resolved cleanly, have the desired
>      * tree in the index -- this means that the index must be in
>      * sync with the head commit.  The strategies are responsible
>      * to ensure this.
>      */
>
> So, even if someone were to reimplement git-merge-resolve.sh in C, and
> start the deprecation process with some merge.useBuiltinResolve config
> setting (similar to rebase.useBuiltin), I'd still want this shell fix
> added to git-merge-resolve.sh in the meantime, both as an important
> bugfix, and so that people looking for merge strategy examples who
> find this script hopefully find a new enough version with this
> important check included.
>
> In general, if merge strategies do not perform this check, we have
> observed that they often will either (a) discard users' staged changes
> (best case) or (b) smash staged changes into the created commit and
> thus create some kind of evil merge (making it look like they created
> a merge normally, and then amended the merge with additional changes).
>
> We're lucky that the way resolve was implemented, other git calls
> would usually incidentally catch such issues for us without an
> explicit check.  We were also lucky that the observed behavior was
> '(a)' rather than '(b)' for resolve.  But the issue should still be
> fixed.

Makes sense I guess, yeah I was wondering if we could just assume that
"git merge" would always invoke those, and therefore could offload more
of the pre-flight checks over there.

>> For this code in particular it:
>>
>>  * Uses spaces, not tabs
>
> Yes, that's fair, but as I mentioned in the commit message, it was
> copied from git-merge-octopus.sh.  So, as you say below, "so did the
> older version".

*nod*

>>  * We lose the diff-index .. --name-only exit code (segfault), but so
>>    did the older version
>
> Um, I don't understand this objection.  I think you are referring to
> the pipe to sed, but if so...who cares?  The exit code would be lost
> anyway because we aren't running under errexit, and the next line of
> code ignores any and all previous exit codes when it runs "exit 2".
> And if you're not referring to the pipe to sed but the fact that it
> unconditionally returns an exit code of 2 on the next line, then yes
> that is the expected return code.  Whatever the diff-index segfault
> returns would be the wrong exit status and could fool the
> builtin/merge.c into doing the wrong thing.  It expects merge
> strategies to return one of three exit codes: 0, 1, or 2:
>
>     /*
>      * The backend exits with 1 when conflicts are
>      * left to be resolved, with 2 when it does not
>      * handle the given merge at all.
>      */
>
> So, ignoring the return code from diff-index is correct behavior here.
>
> Were you thinking this was a test script or something?

We can leave this for now.

But no. Whatever the merge driver is documenting as its normal return
values we really should be ferrying up abort() and segfault, per the
"why do we miss..." in:
https://lore.kernel.org/git/patch-v2-11.14-8cc6ab390db-20220720T211221Z-ava=
rab@gmail.com/

I.e. this is one of the cases in the test suite where we haven't closed
that gap, and could hide segfaults as a "normal" exit 2.

So I think your v5 is fine as-is, but in general I'd be really
interested if you want to double-down on this view for the merge drivers
for some reason, because my current plan for addressing these blindspots
outlined in the above wouldn't work then...

 >>  * I wonder if bending over backwards to emit the exact message we
>>    emitted before is worth it
>>
>> If you just make this something like (untested):
>>
>>         {
>>                 gettext "error: " &&
>>                 gettextln "Your local..."
>>         }
>>
>> You could re-use the translation from the *.c one (and the "error: " one
>> we'll get from usage.c).
>>
>> That leaves "\n %s" as the difference, but we could just remove that
>> from the _() and emit it unconditionally, no?
>
> ??
>
> Copying a few lines from git-merge-octopus.sh to get the same fix it
> has is "bending over backwards"?  That's what I call "doing the
> easiest thing possible" (and which _also_ has the benefit of being
> battle tested code), and then you describe a bunch of gymnastics as an
> alternative?  I see your suggestion as running afoul of the objection
> you are raising, and the code I'm adding as being a solution to that
> particular objection.  So this particular flag you are raising is
> confusing to me.

I wasn't aware of some greater context vis-as-vis octopus, but it just
seemed to me that you were trying to maintain the "Error" v.s. "error"
distinction, i.e. the C code you're adding uses lower case, the *.sh
upper-case.

Which I see is for consistency with some existing message we have a
translation for, so if that was the main goal (and not bug-for-bug
message compatibility) the above gettext/gettextln use would allow you
to re-use the C i18n.

