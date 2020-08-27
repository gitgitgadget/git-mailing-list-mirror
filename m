Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692C7C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 335CA22B4B
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv08TFrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgH0RrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgH0RrV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 13:47:21 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F56C061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 10:47:21 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 2so5333126ois.8
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 10:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SgXeYgGfIkQ1UMcnoSaYMmm8RXZlJBCKn83pew8rgb0=;
        b=Cv08TFrAsH7dk4fjND8dJ6zBnN91uXlwiYrjUdcjAJO+rNiSBBYLWBhmehaPoUxTus
         MRVmLwbuYZ/CrXLQdGnLuAJnkVbDT86MSgbtHS+J9KWFytaPF/R5wGwY3GXSmg0s/e0D
         WZKxJVRiv+GG/FDMjMp0z3pNH6Vj61S1bkEFnkf/jS14c4STQaZajEiEMu9XRLYQrXO3
         TB0FifjhhOZXRahx1h0C6wD86hF/NSEu/ZhWk3B30/qqP3rIkP/1ni+VeA4jFu1r9CiO
         feEVeyXJGQGOXPGZ2PJ5MJp6xv1OyPRltXwPiQNuYhVifeE3Nr64nsWA8vClAPWA+70K
         Ys1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SgXeYgGfIkQ1UMcnoSaYMmm8RXZlJBCKn83pew8rgb0=;
        b=F31TLi9fO5geYKpvR4winHUIWqL6WeHNF4txOKGMTzFHGeMKvbyuAyCR+5YzyP3MuS
         k3NxUHrFuqKnbdP3DQ2kjpaXoOZp5ZtYdNOcSBU/jel8Cf964/8WIU8vLx+j19VvoL6U
         SP1UXSBlXvhXX5n0Si9x+f70wx6iJmGH8lLwiCgOyv8isqldFaEMUsLeUtfMNEr5rrcs
         08MpVJoW0kZIvOg5pKH02/XByV1niYXurodZxs2sRh6Qgu4ASbYJ+YH28YCiKnC7OjOm
         80NkW6JQOKBSe2nmpIjSidhX8s43rWic8QRi84KfxJYr9kqS1b2b7zxb4VIdjA+xC2wx
         wjKg==
X-Gm-Message-State: AOAM532FnbdmP6k+CXDzouXoeVzFdvW9edYMT8/RhAhTyJGjbbcpCSwJ
        xVN1FVxeFe+3GJednBIZLwFVbBSttvYtws8tJ8njv+Z+PZw=
X-Google-Smtp-Source: ABdhPJwP5ofY6W3NcvX5Ob8ma9i9NeOsxgSS07sDw0/WvV6QrKpQ6axcTBDI/917oeLk9eVK9dWN3YKpJG9wue4ZQSk=
X-Received: by 2002:aca:b705:: with SMTP id h5mr11360oif.31.1598550440309;
 Thu, 27 Aug 2020 10:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com>
 <xmqq7dtlt080.fsf@gitster.c.googlers.com> <xmqq3649szs8.fsf@gitster.c.googlers.com>
 <CABPp-BF=ydfHE2XqN4L9qfeAg3AZL9yNJhs4rykGj0baT1Eh6g@mail.gmail.com> <xmqqd03cq9r5.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqd03cq9r5.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 27 Aug 2020 10:47:08 -0700
Message-ID: <CABPp-BEmjKR1HcZ_C0es9M7f6rMy3BLcZRdK0phm2J3VwtV26Q@mail.gmail.com>
Subject: Re: post-checkout hook aborts rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tom Rutherford <tmrutherford@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 10:28 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Wed, Aug 26, 2020 at 5:24 PM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>
> >> > ...  If "git rebase" or whatever
> >> > command wanted to place files and the index into some state by using
> >> > "git checkout" command, and if the post-checkout hook mucked with
> >> > the state in such a way that contradicts with what the "git rebase"
> >> > command wanted them to be in, it is not surprising the hook's behavior
> >> > broke "git rebase"'s operation.
> >>
> >> Having said all that, I actually think that "rebase" shouldn't be
> >> invoking "git checkout" (and its equivalent) internally when
> >> switching to a specific version, in such a way that it would trigger
> >> any end-user specified hooks and allow them to muck with the working
> >> tree and the index state.
> >>
> >> I haven't checked the actual implementation of "git rebase" for
> >> quite some time to be sure, but we have lower-level plumbing
> >> commands that are not affected by the end-user hooks for exactly
> >> that kind of "build higher-level commands by synthesis of
> >> lower-level machinery", and it is very possible that what we are
> >> looking at is actually a bug that needs to be fixed.  I dunno.
> >>
> >> Thanks.
> >
> > Yes, and I think we should also make rebase stop invoking "git commit" too.
>
> Note that I didn't say we should make it stop invoking "git
> checkout".

Understood that you didn't say that, but I am of the opinion that we
should do that.

Invoking "git checkout" and "git commit" were convenient
implementation details when rebase was written as a script.  When it
was rewritten in C, forking out to these processes made for an easy
conversion path (even if slightly ugly).  But forking other processes
is costly, it has given us multiple reports of unwanted side-effects
from hooks[1], it makes the code more difficult to debug in a
debugger, etc.  I think these are all problems we could avoid by no
longer calling these external commands.

> We could invent a mechanism that disables all the hook invocations
> and other customizations [*1*] (done e.g. via the configuration
> variables) for internal use of the Porcelain commands, and use it
> when "rebase" invokes Porcelains like "checkout", "commit" as its
> implementation detail, for example (some "invocations" I think
> bypass the run_command() inteface and instead done by directly
> calling the implementation detail of "checkout" and "commit", but
> the principles are the same).
>
> [Footnote]
>
> *1* of course, it becomes a balancing act to decide what kind of
>     customizations are OK to honor under such a mode.

That'd be one way to solve it, but it feels like it'd push maintenance
burden onto future folks that people touching the commit and checkout
builtins have to be aware of what other commands are using them under
the covers and tweak them appropriately.  I'd rather checkout and
commit just shared the relevant bits of important code with sequencer,
and then if people want to add configuration bits (be that hooks or
config settings or whatever), then it only gets added to the commands
that people explicitly add them to, rather than them getting added to
rebase via accident.
