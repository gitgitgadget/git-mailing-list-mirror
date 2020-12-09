Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D115BC433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 04:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F0723B23
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 04:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgLIEzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 23:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgLIEzX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 23:55:23 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBBAC0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 20:54:43 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id o11so196966ote.4
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 20:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FsX0IwNGAXTwQAbQmKUiv8Zs1z5weS3aFgZNEN47Iz8=;
        b=lm7MH5yINUif+MRkGMwxyBZwx8BZ6OMJwH0XnUVIVRy0yXeSTZa+togBOQPpGW/fZi
         nHn8u0PpiVYfEYwuz3NU42PwV5jehNmvbOsS8vm8WCDIuas3yo3C35rK4W+z4MXp2H6X
         dJsnQS87sKvZ26iJd452Y9V++e9KigTVQu6vsE7qNa7yA4+uuxruOQB4PEWZEnWGYsGz
         gkVRPQHG5LDHGkKtwEYJwNDLGMgY1wOpBto/rXjxo8wXzWEdUQVoKs78KnjXzYp73I/8
         7rXZnYtzblDlXYxVEGv5ennBkI5jPCz58ZuC2LofxcYY+pvOKusZIpfEmavBuxUGG1OS
         dZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsX0IwNGAXTwQAbQmKUiv8Zs1z5weS3aFgZNEN47Iz8=;
        b=lXMyU+cXlmPcZuyxdRh6wgd3Eacooy06pzBfITffMeKQUKeU/uLnitIA6X8TUAmkmf
         EOllSPGJUuplTW6rsdumuXdV5r6X8Fqe1JKIbBsXdTIHJswM8ATQiU/YfCpmILgrl4lG
         SnR+We8h/4GqR42t42W5TprIQabYJ+SqUmww/8IPSUvuMERfmCyM46DH8j8iCpFH5MUE
         4nPTA1K+hihTuV9KH3Hp/5fiU5NkTw9e92TOG3mXyu4XHGRQ8BacPT+uFSbT563ZH7Uy
         pk2QkGySMA0HDbC0++sg0UFzajT+AvO9LPeFKKloAzoZv76UAZjGNRDtLWpew550qdSu
         PtSw==
X-Gm-Message-State: AOAM5325yS1455IzGM59HcyJWNcMQcX7g6JKSwv/1fQA7RXs4t4HR0dv
        0h1E1Mo3uYsXFHRimjuOqdkcSCekA87fqL0o0LY=
X-Google-Smtp-Source: ABdhPJwxBeYmZW/9Jvq5VJLt8FUpXitzGWa1VRvknIvfuhGDpWmhtpSjugZp78POn3WQC+HzCiqESz1wT8QPYqvZVzc=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr349357oth.316.1607489682310;
 Tue, 08 Dec 2020 20:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <87y2i8dptj.fsf@osv.gnss.ru>
 <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
 <87y2i8c4mr.fsf@osv.gnss.ru> <CABPp-BE3D7ifQx6MZCT_ntRnG0QZm1Ga10SJ=DN+6bpF6mX2GQ@mail.gmail.com>
 <xmqqtusv4w2g.fsf@gitster.c.googlers.com> <CABPp-BHCtrKAWR1v3OrUgX8iSfxvDwN8p+yiJy=G1BFfnSopjw@mail.gmail.com>
 <xmqq7dpr4qa0.fsf@gitster.c.googlers.com> <CABPp-BHWhiUZ=wCSz1f0oxtHiRzAKCPVmoUYDf+mvvm63ykCEw@mail.gmail.com>
 <xmqq360f4npg.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq360f4npg.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Dec 2020 20:54:31 -0800
Message-ID: <CABPp-BEAmB9DA7RXrf6vJGbHfGU37V4sE0d1CW+2vRwp_uAudw@mail.gmail.com>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 8, 2020 at 8:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> If I can run "git log --some-options master..next" (or more
> >> realistically, over the range ko/next..next) to get individual
> >> commits (without patch) and merges (only when --cc gives some
> >> interesting nearby-changes), I would be very happy.  But is there a
> >> set of options that lets me do so?
> >
> > So, you're saying you changed your mind since five years ago?[1]  Or
> > that what you said five years ago is still valid, but you'd appreciate
> > more/different options that allow this new thing?
> >
> > [1] https://lore.kernel.org/git/1440110591-12941-1-git-send-email-gitster@pobox.com/
>
> Sorry, but I am not seeing in [1] anything that relates to the above
> "want to see --cc patch for merge but just log message for single
> parent commit". 5 years is a long time even in Git timescale, so I
> would not be surprised if I changed my mind over time, but I am not
> sure what opinion on the matter you think I expressed back then.
>
> "git log --cc master..next" shows all commits' log messages, patch
> for each single-parent commit, and combined-dense patch for each
> merge.  There is no option to squelch the patch for only single
> parent commits.  It may not be such a bad thing to have as an extra
> option.
>
> So, I think what I am saying is that ...
>
> > > ...  As I said, I'm not sure why
> > > anyone would ever want to see diffs for merges and not for normal
> > > commits, the closest useful thing I can imagine is commit messages +
> > > diffs for just merges, stripping the normal commits.
>
> ... I see use for such a feature (assuming that you didn't mean by
> "diffs for merges" a regular "--first-parent -p" patch, but meant to
> say "--cc" patch) in my workflow.  I'd review "log ko/next..next"
> before deciding to push out the day's integration of 'next', and at
> that point, I trust individual commits that came from contributors
> well enough (otherwise I wouldn't be merging them to 'next'), but I
> would appreciate the last chance to re-examine conflict resolutions
> in merges.
>
> It does not mean that I do not like the current behaviour that
> "--cc" always implies "-p"; it is convenient.  It's just I find the
> lack of feature slightly less than ideal, but I do not care deeply
> enough to design how to express such a feature from the command
> line.

Okay, thanks for clarifying.  It sounds like you were focusing on the
tangentially related comment I made (diffs for merges and not for
normal commits) while I was focusing on Sergey's question (should we
revert --cc implies -p).  I was having a hard time understanding if
you were answering his question or not.  This last paragraph of yours
acknowledges the question, though you still avoid answering it.  :-)

However, even my focus was on a secondary question.  His real original
question is: -m and --cc are inconsistent -- one requires -p, while
the other doesn't.  Should that be fixed...and which option(s) should
change?  He gave two possibilities I didn't like.  I added a third
that you didn't like.  So...
