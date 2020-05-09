Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4E0C54E49
	for <git@archiver.kernel.org>; Sat,  9 May 2020 22:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 956C920746
	for <git@archiver.kernel.org>; Sat,  9 May 2020 22:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wgg4Sf2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgEIWE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 18:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgEIWE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 18:04:28 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5CBC061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 15:04:28 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id t12so1151800oot.2
        for <git@vger.kernel.org>; Sat, 09 May 2020 15:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=caMK5XXX8vmTDBtV/+0EQvfRG4kMiV0/gWrowa3E2Tw=;
        b=Wgg4Sf2JCsA8Cc0cTzhmcf04N1R26NrvqgXmMLrN9RCiQfiuShFzwotWMan3ePtWb3
         2V6/GVVfIjdFttDNEItkOniZKeiiDnvxRlhvTreOto7upBpfDIYzMLdrxP6pE8QaELTQ
         nSe6mxMjG41sSbUQENhfaoBYy+VR3o0sfghCsGy7NYfd9rkzBlXWAKyu3O1oaMyYJybB
         3sD8zs3wftri4u79K6PdAkW/2Jxn6OKVHvpWZxlMFrcvfnA+I9u+Sl1pX1Ep9O9bnKsD
         AuxuxT27FREJpwez4JF/u7NbwiDbjk/xw+XvTpYZZUAf/uy7uv6BWoRxAT2x/+upSx30
         r2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=caMK5XXX8vmTDBtV/+0EQvfRG4kMiV0/gWrowa3E2Tw=;
        b=XGKc8m7Q+R006ok983wIUc0DhPSz5r5po+k4mxWUTl5W6xUUiyD+GddePRiGftM13j
         UZ3+fCMckVaX6Aoyxb0IcsYTEPoQ4qfjyBUUYJbylEgQ8zyMzezMO/Vc8bcj2F4qaeZW
         oYKc4l7s2uDSbY0DMuHsSa3kcwKOrOelm0iylSsvIVd+XgS+omdjlJQshvCGuDGKzBZV
         NJRP+QFtZJyZGa/BJSH8ig0uEHnixieItnwrPI7/6kC4Y9jB3vonhJ0XL+5AmqXbTRNC
         wu74fhq+X8Zs3MrYe7hbG8CJPssnxh0dMOvV/qZEcb5KbXxG2U/U/MptZcBoRZZYG3Ff
         JO1A==
X-Gm-Message-State: AGi0Pubh1sZGiavBQOlxN0r8bKFHryd5i+0ZpoSUmddytvl6bvPeOsUG
        1E5nICCHwW8bjngY0GKwCzYxDoMsYazpgnJFxiewJoG5
X-Google-Smtp-Source: APiQypKW1mBoUFmrmB9+eLhXLxypHHDTN6HdTRl29Dk3H2qCUK22LqQM7q/lLIc5A4or92fpUTxgsXVv0DyW4Y8nqJg=
X-Received: by 2002:a4a:e59a:: with SMTP id o26mr8138516oov.54.1589061866211;
 Sat, 09 May 2020 15:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAFKec1W0-OOQYypP-3VC=dJnuNDrykdQ2xibc=u4D=Zo6if-+Q@mail.gmail.com>
 <xmqqd07cvl9b.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqd07cvl9b.fsf@gitster.c.googlers.com>
From:   George Brown <321.george@gmail.com>
Date:   Sat, 9 May 2020 23:04:15 +0100
Message-ID: <CAFKec1Wj_uK-moVfin3XrTEmmBaAzaJKsh1f8q-3+RBs2-3Jdg@mail.gmail.com>
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The are editors that open their own window, or tell an already open
> editor instance to edit the buffer (think: emacsclient) and in order
> to be functional, they do not have to be launched from inside a
> working terminal window (whose input comes from the keyboard---the
> test "-t 1" is an approximate check for that).
>
> Wouldn't this change hurt the users of such an editor?

I'm unsure of emacsclient but I would have thought that editors in
general would be more amenable to receiving lines than relying on
additional spawned instances to behave as clients.

> Would it work to set GIT_EDITOR to "cat" while performing the
> "populating quickfix list" (whatever that is) operation?

It would, though I considered this to be less elegant.

Just for background the quickfix list in Vim is simply a list of
locations that you can browse and jump to.

On Sat, 9 May 2020 at 22:41, Junio C Hamano <gitster@pobox.com> wrote:
>
> George Brown <321.george@gmail.com> writes:
>
> > contrib/git-jump: cat output when not a terminal
> >
> > The current usage to populate Vim's quickfix list cannot be used from
> > within the editor as it invokes another instance.
> >
> > Check if stdout is to a terminal or not. If not simply cat the output.
>
> The are editors that open their own window, or tell an already open
> editor instance to edit the buffer (think: emacsclient) and in order
> to be functional, they do not have to be launched from inside a
> working terminal window (whose input comes from the keyboard---the
> test "-t 1" is an approximate check for that).
>
> Wouldn't this change hurt the users of such an editor?
>
> Would it work to set GIT_EDITOR to "cat" while performing the
> "populating quickfix list" (whatever that is) operation?
>
> > Signed-off-by: George Brown <321.george@gmail.com>
> > ---
> >  contrib/git-jump/git-jump | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> > index 931b0fe3a9..253341c64e 100755
> > --- a/contrib/git-jump/git-jump
> > +++ b/contrib/git-jump/git-jump
> > @@ -19,8 +19,12 @@ EOF
> >  }
> >
> >  open_editor() {
> > -    editor=`git var GIT_EDITOR`
> > -    eval "$editor -q \$1"
> > +    if test -t 1; then
> > +        editor=`git var GIT_EDITOR`
> > +        eval "$editor -q \$1"
> > +    else
> > +        cat "$1"
> > +    fi
> >  }
> >
> >  mode_diff() {
