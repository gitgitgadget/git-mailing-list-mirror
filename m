Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA364C433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 05:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B21A60F92
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 05:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhISFIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 01:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhISFIW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 01:08:22 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CFCC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 22:06:57 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id g16so8858559uam.7
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 22:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vpEUf1cZ2GkcmXvhU7A35KZpw5xWKKsEio/Ed6fOGe4=;
        b=jA0HCbn/v+whbTRFrnZ1L0z+QvOEaTT8Pp4wfyP4uX0t5gQ8snoQ+QJ8hT/mBnSSjY
         kiQ0hxV7g0IH3D76BOR71QUZ+AQ4U/Fe+v0Fvw6oIJV/ukKaono7VJuJpP5vsVVI1bOI
         S44eU1wcqrhU92B0WOfHpHKupcWAWWBsQmT+rNqXSz7RaexkKkI1+FZFfPvPmd8xc1so
         PrCftTyCXrvles72Wgi4SOJNbdX3L81Pz0Ihb2Hx5Xnn5hYq0UxCeid1NgIYshTEmBvH
         +XT76dScMpeJ50ODbMRL/EKt6bTRH69u2Ao6PZI7UWqCpFxIwmIhC8wO9kIkC6pRszBW
         1Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vpEUf1cZ2GkcmXvhU7A35KZpw5xWKKsEio/Ed6fOGe4=;
        b=LkW2YPXZ4XomZZRPRel2PQFQdwT++Rc59toobrCxiQKCzQA7xzYbUwwzSfeY6Y1Hp5
         ppVvGVnA0QGr1/fE9dQmh6F7O9j4n3aOVjrGqDwVC3qN11AOKsAFDU+XDbKhp/eWPUFX
         T+0Y6CGOd1uissVO85LEiQOOo9/3KSu8y62mumR+f7xV3bmXWd34ymgn/6NN8HgMgFSO
         B9cxPHVrRnmd4fO0PaXP2zTP+a/tvV47N5xKPCfT2t63ebmcRxOfN5SxVPTTYJiFPwA9
         AtQU2B1dTxmrg4xHtQQftjOdEQl44SoF0gYpUxjdRxJj6bp2XS51X+lcidmYzJQ2smQM
         vISw==
X-Gm-Message-State: AOAM5314TIsADZ2jHpB3FrU3e08kBNk8vJgIv1Ok5i/1gC2dsj2KFEOU
        ovcEZm1pDS7aPiLESaHTNyCt44zXpl7v2gIJ5+eYLhwFVh4=
X-Google-Smtp-Source: ABdhPJy3NlGi49+3USZFhYYdPAm/i5YSPItkqDUrW+Wvj4VYEHA0qEVJXmDbDlei3VSTb1fUwIHiBRz/giZ8jIKc9Gs=
X-Received: by 2002:ab0:470a:: with SMTP id h10mr1839413uac.27.1632028016133;
 Sat, 18 Sep 2021 22:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAO-Ogzs7vCtfgjZqp+cg1ERiu3bSwZM47arHJyyTrEqAQ=ZLcw@mail.gmail.com>
 <xmqqlf3vilnb.fsf@gitster.g> <874kajdmsh.fsf@evledraar.gmail.com>
 <xmqqmtobgf7m.fsf@gitster.g> <CAO-Ogzs8WLmOY9HWT=bUMjH3a7UR7WpJZ5HjJZcVL+Fhbo_7kg@mail.gmail.com>
In-Reply-To: <CAO-Ogzs8WLmOY9HWT=bUMjH3a7UR7WpJZ5HjJZcVL+Fhbo_7kg@mail.gmail.com>
From:   Kurt von Laven <kurt.von.laven@gmail.com>
Date:   Sat, 18 Sep 2021 22:06:20 -0700
Message-ID: <CAO-OgzsU+A3iLV1jS9kPDk9vFQQgKtcx8QoAfx4jGazpFPRosQ@mail.gmail.com>
Subject: Re: Don't Call commit-msg Hooks With Empty Commit Messages
To:     git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

P.S. The maintainer of gitlint, a commit-msg hook, pointed out to me
that handling the case where the commit message is empty is trickier
than what I described. Presently there is no way to discern whether
--allow-empty-message was passed, so the hook doesn't even know
whether the commit is being aborted and is forced to handle both
cases the same way. I view this as a deeper issue with the present
behavior than what I initially brought up since it fundamentally limits
commit-msg hooks. My point here isn't that commit-msg hooks should
be told whether the commit is being aborted explicitly, but rather
that aborted commits should abort as soon as the developer enters an
empty commit message (with the one exception being the confirmation
prompt verifying that the developer intended to abort the commit),
before commit-msg hooks are called.

El s=C3=A1b, 18 sept 2021 a las 2:58, Kurt von Laven
(<kurt.von.laven@gmail.com>) escribi=C3=B3:

>
> > The primary reason commit-msg hook is there is *not* because we need
> > a way to tweak the log message.  As you said, prepare-commit-msg and
> > templates are much better way to give some sort of default.
>
> Yes, I completely agree. I meant my original message to refer only to
> the case of an empty commit message.
>
> > The purpose of the hook is to serve as the gatekeeper to cause an
> > attempt with a bad commit message to fail.  And a properly written
> > commit-msg hook would be rejecting an empty message, instead of
> > inserting cruft into an empty message file.
>
> It doesn't conceptually make sense for Git to be calling the
> commit-msg hook in this case to begin with though. The developer has
> already expressed an intent to abort the commit, and that intuitively
> feels like it should be the end of the process. When someone sits down
> to write a commit-msg hook, it's very natural to think: "how should I
> handle this commit message?" It's less natural to think: "How should I
> handle the case where the developer aborted the commit?" This after
> all has nothing to do with the intention of the commit-msg hook being
> written, so it will tend not to be on peoples' minds. If they do think
> about it without investigating thoroughly, they are liable to assume
> that Git wouldn't call their hook in this case since the commit has no
> message and is being aborted. Worse still, even if they do recognize
> that their hook will be called, they are most likely to assume that
> they should reject an empty commit message by exiting with an error
> code in the typical guard-against-bad-input sense, but this is also
> wrong. The correct action is in a sense doubly inverted: you want to
> explicitly always allow an empty commit message by exiting
> successfully without output. In essence, your script must pretend that
> nothing happened, because it shouldn't have, which is rarely the
> correct action to take as a programmer. Every single commit-msg hook
> author is presently being relied on to get this right, which
> automatically means more mistakes will be made. I would be curious if
> anyone is aware of any hook using the pre-commit framework that
> implements this correctly by default (without relying on the end
> developer to pass additional arguments). My experience using the
> pre-commit framework has been a spew of erroneous errors from
> commit-msg hooks in the aborted commit case, because none of them made
> it even to the first step of considering the possibility that the
> commit may have already been aborted.
>
> > So, from that point of view, if we were to change anything, a more
> > useful thing to do might be to forbid commit-msg hook from modifying
> > the file and make sure it would only verify but not modify, I
> > suspect.  Doing so would have a side effect of making sure that no
> > commit-msg hook will turn an empty message file into a non-empty
> > message file ;-).
>
> I would not recommend this, no. What other hook would be better suited
> to programmatically modify a non-empty commit message? Such a
> restriction would break, for instance, the witty sign-commit
> pre-commit hook: https://github.com/mattlqx/pre-commit-sign.
> Implementing sign-commit without the power to change the commit
> message from the commit-msg hook boxes you into using a
> prepare-commit-msg hook, which is a worse user experience. It puts the
> signature in a human-editable field where they can accidentally mangle
> or delete the signature, put their message beneath it instead of above
> it, delimit it from their commit message inconsistently, etc. Also,
> this would not solve the problem of preventing the commit-msg hook
> from being run in the first place when the commit message is empty.
>
> > I'd think we'd want to call it on an empty message, e.g. maybe someone
> > depends on that with empty message =3D auto-generate a message for me.
>
> This is the backwards compatibility point I was referring to.
> Definitely understand if this is a show stopper since I consider this
> more of a quirk than a serious issue. I would think some amount of
> warning would be in order if the behavior of commit-msg hooks were to
> change to avoid unnecessary chaos, and I would be curious if anyone is
> specifically aware of any commit-msg hooks that intend to consume
> empty commit message. The better way to implement the auto-generated
> message in my opinion would be with a commit message template or a
> prepare-commit-msg hook. In theory, one could potentially also offer a
> new hook that is similar to a commit-msg hook but that didn't get
> called if a commit was aborted, but that feels like overkill.
>
> > But for those that don't, doesn't the default behavior of "git commit"
> > catch this in either case, i.e. it wouldn't let it pass without
> > --allow-empty-message.
>
> I agree with your intuition in the sense that that would be preferable
> behavior, but no, this is not how Git behaves presently. The
> commit-msg hook still gets called, and a maintainer of the pre-commit
> framework has assured me that they follow Git's behavior to the tee in
> this regard.
>
> > I understood this report as the hook taking the empty message (e.g. the
> > user using it as a shorthand to abort), and their hook "helpfully"
> > inserting some "default" message or template.
>
> I believe that sign-commit does exactly what you suggest, yes. The
> cases I personally have encountered were simply misleading validation
> errors (e.g., the commit message doesn't follow conventional commit or
> isn't long enough).
>
> > I tend to agree with you that, especially if we are to keep the
> > "commit-msg hook is allowed to change the message, even though it is
> > a job for other hooks", we should invoke it even on an empty file.
>
> Do you have a use case in mind for a commit-msg hook that runs on an
> empty commit message that wouldn't be better implemented some other
> way? More to the point, why continue with the commit process at all at
> this point? It's vaguely analogous to a program allowing third-party
> extensions to automatically relaunch a program after the user closed
> it. Presently commit hooks are given the power to overrule what is
> most often a developer's intention to abort a commit, and the most
> common case in practice that this behavior manifests is in incorrectly
> implemented commit-msg hooks that either spew misleading error
> messages or abort the abort process unintentionally.
>
> > They do not fall into either of the two camps.  Their hook does futz
> > with the message indiscriminately and adds some boilerplate material
> > blindly, even to an empty file.
>
> > The complaint is "the message is otherwise without any substance,
> > but because the hook blindly added some boilerplate material into
> > the empty original, it appears to be non-empty and fails to trigger
> > the --no-allow-empty-message machinery."
>
> None of the hooks I have personally used do this, but such hooks exist
> and are problematic.
>
> Be well,
> Kurt
>
> El vie, 17 sept 2021 a las 12:44, Junio C Hamano (<gitster@pobox.com>) es=
cribi=C3=B3:
> >
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >
> > > I'd think we'd want to call it on an empty message, e.g. maybe someon=
e
> > > depends on that with empty message =3D auto-generate a message for me=
.
> >
> > I tend to agree with you that, especially if we are to keep the
> > "commit-msg hook is allowed to change the message, even though it is
> > a job for other hooks", we should invoke it even on an empty file.
> >
> > > But for those that don't, doesn't the default behavior of "git commit=
"
> > > catch this in either case, i.e. it wouldn't let it pass without
> > > --allow-empty-message.
> > >
> > > I understood this report as the hook taking the empty message (e.g. t=
he
> > > user using it as a shorthand to abort), and their hook "helpfully"
> > > inserting some "default" message or template.
> >
> > My understanding largely overlaps with yours but with some
> > differences.
> >
> > They do not fall into either of the two camps.  Their hook does futz
> > with the message indiscriminately and adds some boilerplate material
> > blindly, even to an empty file.
> >
> > The complaint is "the message is otherwise without any substance,
> > but because the hook blindly added some boilerplate material into
> > the empty original, it appears to be non-empty and fails to trigger
> > the --no-allow-empty-message machinery."
> >
> >
> >
