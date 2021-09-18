Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9180C433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 09:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A122460FBF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 09:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245295AbhIRKAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 06:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245601AbhIRKAg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 06:00:36 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A2CC06175F
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 02:59:12 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id g18so1667605uah.10
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 02:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GM+KujoTLDWr7aYDHh5dNaaSlKrMxepc6+Lnc64q9zE=;
        b=LHFOzJxHz03nbdU0P7T/jRfsbgcDPaHCptb5vo7eHgAZ76goHdbQwqvUZJuUwdpsE6
         I2Wgsc21IqPnQtIDtRGTKre6Fk+lx7HFeFnZUmkItqa81dquvXp5rep5chAoV8YHo199
         X7iZ/YYBiUnRGA4Hnvs00jGP74cyWYSMdHfeV3E/9q/3W4ujfNkxdZzzo9JE5+Roh4TL
         GAr/1DHk5fw3Duq0KOhyq0oRyGH9OPXjSAOUyjaWCL8Aj5S7Gqtfgqk4kYrqnefwLXXE
         7XfrmutqxA4MQxI/G7B/PshaijrDErKcGenuDKHsEG7f93f5I5NBCbsd5zC/Iiu29xnB
         iIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GM+KujoTLDWr7aYDHh5dNaaSlKrMxepc6+Lnc64q9zE=;
        b=QBFOY9aOqYdi5wds4IlE11JGgEMQ9r4KCfXvD/sO9625FNUk7P3Jbd20R0fDJofIvV
         Tj/164S8STITrFJ5r4XNVy0U7LX9P7gkmQDhxSlYF5vEVng6VGd9IEvdFAFVQAOU4sjI
         BadXeL7xF0JEA7yo+Xo52Z41meCKc6IKmpl7vZL/u8wj1/3f6SDpOHxtSWXLOHIzzs61
         dTwR8jITrMJCRAMKy2M+ORJ9cwDwhS0s8XZz8Io0Oc/I/dSK1GHvV00GvDOzGha1GiHL
         QslX01ZCaOLpUzo+D0Ybdpgpe0g/oclrJezd48fJbWzIlV+4/229FqahB8MDRCKYF16L
         RUdQ==
X-Gm-Message-State: AOAM533/xDuOFmC3tJt5+RuJ4GEgMfw6oJEYlFD3kDA0y2yl0IMcasN0
        RSVKzzB1OHqWkReON2T8F0c3uXYopWIfp6DCV/M=
X-Google-Smtp-Source: ABdhPJypcm3qTtI1ulyUZXe3KMpUyFKPQ9WRLYOdz2dPFDa1P1mfHq9/on6MybbP+5UpM6Bn5H/YzthL1WByvga8tWo=
X-Received: by 2002:ab0:6c52:: with SMTP id q18mr7822888uas.137.1631959150689;
 Sat, 18 Sep 2021 02:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAO-Ogzs7vCtfgjZqp+cg1ERiu3bSwZM47arHJyyTrEqAQ=ZLcw@mail.gmail.com>
 <xmqqlf3vilnb.fsf@gitster.g> <874kajdmsh.fsf@evledraar.gmail.com> <xmqqmtobgf7m.fsf@gitster.g>
In-Reply-To: <xmqqmtobgf7m.fsf@gitster.g>
From:   Kurt von Laven <kurt.von.laven@gmail.com>
Date:   Sat, 18 Sep 2021 02:58:34 -0700
Message-ID: <CAO-Ogzs8WLmOY9HWT=bUMjH3a7UR7WpJZ5HjJZcVL+Fhbo_7kg@mail.gmail.com>
Subject: Re: Don't Call commit-msg Hooks With Empty Commit Messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The primary reason commit-msg hook is there is *not* because we need
> a way to tweak the log message.  As you said, prepare-commit-msg and
> templates are much better way to give some sort of default.

Yes, I completely agree. I meant my original message to refer only to
the case of an empty commit message.

> The purpose of the hook is to serve as the gatekeeper to cause an
> attempt with a bad commit message to fail.  And a properly written
> commit-msg hook would be rejecting an empty message, instead of
> inserting cruft into an empty message file.

It doesn't conceptually make sense for Git to be calling the
commit-msg hook in this case to begin with though. The developer has
already expressed an intent to abort the commit, and that intuitively
feels like it should be the end of the process. When someone sits down
to write a commit-msg hook, it's very natural to think: "how should I
handle this commit message?" It's less natural to think: "How should I
handle the case where the developer aborted the commit?" This after
all has nothing to do with the intention of the commit-msg hook being
written, so it will tend not to be on peoples' minds. If they do think
about it without investigating thoroughly, they are liable to assume
that Git wouldn't call their hook in this case since the commit has no
message and is being aborted. Worse still, even if they do recognize
that their hook will be called, they are most likely to assume that
they should reject an empty commit message by exiting with an error
code in the typical guard-against-bad-input sense, but this is also
wrong. The correct action is in a sense doubly inverted: you want to
explicitly always allow an empty commit message by exiting
successfully without output. In essence, your script must pretend that
nothing happened, because it shouldn't have, which is rarely the
correct action to take as a programmer. Every single commit-msg hook
author is presently being relied on to get this right, which
automatically means more mistakes will be made. I would be curious if
anyone is aware of any hook using the pre-commit framework that
implements this correctly by default (without relying on the end
developer to pass additional arguments). My experience using the
pre-commit framework has been a spew of erroneous errors from
commit-msg hooks in the aborted commit case, because none of them made
it even to the first step of considering the possibility that the
commit may have already been aborted.

> So, from that point of view, if we were to change anything, a more
> useful thing to do might be to forbid commit-msg hook from modifying
> the file and make sure it would only verify but not modify, I
> suspect.  Doing so would have a side effect of making sure that no
> commit-msg hook will turn an empty message file into a non-empty
> message file ;-).

I would not recommend this, no. What other hook would be better suited
to programmatically modify a non-empty commit message? Such a
restriction would break, for instance, the witty sign-commit
pre-commit hook: https://github.com/mattlqx/pre-commit-sign.
Implementing sign-commit without the power to change the commit
message from the commit-msg hook boxes you into using a
prepare-commit-msg hook, which is a worse user experience. It puts the
signature in a human-editable field where they can accidentally mangle
or delete the signature, put their message beneath it instead of above
it, delimit it from their commit message inconsistently, etc. Also,
this would not solve the problem of preventing the commit-msg hook
from being run in the first place when the commit message is empty.

> I'd think we'd want to call it on an empty message, e.g. maybe someone
> depends on that with empty message =3D auto-generate a message for me.

This is the backwards compatibility point I was referring to.
Definitely understand if this is a show stopper since I consider this
more of a quirk than a serious issue. I would think some amount of
warning would be in order if the behavior of commit-msg hooks were to
change to avoid unnecessary chaos, and I would be curious if anyone is
specifically aware of any commit-msg hooks that intend to consume
empty commit message. The better way to implement the auto-generated
message in my opinion would be with a commit message template or a
prepare-commit-msg hook. In theory, one could potentially also offer a
new hook that is similar to a commit-msg hook but that didn't get
called if a commit was aborted, but that feels like overkill.

> But for those that don't, doesn't the default behavior of "git commit"
> catch this in either case, i.e. it wouldn't let it pass without
> --allow-empty-message.

I agree with your intuition in the sense that that would be preferable
behavior, but no, this is not how Git behaves presently. The
commit-msg hook still gets called, and a maintainer of the pre-commit
framework has assured me that they follow Git's behavior to the tee in
this regard.

> I understood this report as the hook taking the empty message (e.g. the
> user using it as a shorthand to abort), and their hook "helpfully"
> inserting some "default" message or template.

I believe that sign-commit does exactly what you suggest, yes. The
cases I personally have encountered were simply misleading validation
errors (e.g., the commit message doesn't follow conventional commit or
isn't long enough).

> I tend to agree with you that, especially if we are to keep the
> "commit-msg hook is allowed to change the message, even though it is
> a job for other hooks", we should invoke it even on an empty file.

Do you have a use case in mind for a commit-msg hook that runs on an
empty commit message that wouldn't be better implemented some other
way? More to the point, why continue with the commit process at all at
this point? It's vaguely analogous to a program allowing third-party
extensions to automatically relaunch a program after the user closed
it. Presently commit hooks are given the power to overrule what is
most often a developer's intention to abort a commit, and the most
common case in practice that this behavior manifests is in incorrectly
implemented commit-msg hooks that either spew misleading error
messages or abort the abort process unintentionally.

> They do not fall into either of the two camps.  Their hook does futz
> with the message indiscriminately and adds some boilerplate material
> blindly, even to an empty file.

> The complaint is "the message is otherwise without any substance,
> but because the hook blindly added some boilerplate material into
> the empty original, it appears to be non-empty and fails to trigger
> the --no-allow-empty-message machinery."

None of the hooks I have personally used do this, but such hooks exist
and are problematic.

Be well,
Kurt

El vie, 17 sept 2021 a las 12:44, Junio C Hamano (<gitster@pobox.com>) escr=
ibi=C3=B3:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > I'd think we'd want to call it on an empty message, e.g. maybe someone
> > depends on that with empty message =3D auto-generate a message for me.
>
> I tend to agree with you that, especially if we are to keep the
> "commit-msg hook is allowed to change the message, even though it is
> a job for other hooks", we should invoke it even on an empty file.
>
> > But for those that don't, doesn't the default behavior of "git commit"
> > catch this in either case, i.e. it wouldn't let it pass without
> > --allow-empty-message.
> >
> > I understood this report as the hook taking the empty message (e.g. the
> > user using it as a shorthand to abort), and their hook "helpfully"
> > inserting some "default" message or template.
>
> My understanding largely overlaps with yours but with some
> differences.
>
> They do not fall into either of the two camps.  Their hook does futz
> with the message indiscriminately and adds some boilerplate material
> blindly, even to an empty file.
>
> The complaint is "the message is otherwise without any substance,
> but because the hook blindly added some boilerplate material into
> the empty original, it appears to be non-empty and fails to trigger
> the --no-allow-empty-message machinery."
>
>
>
