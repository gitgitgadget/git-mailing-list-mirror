Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20421C05027
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 02:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjAXCg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 21:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAXCg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 21:36:26 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9197C2DE57
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 18:36:25 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id w11so17514455lfu.11
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 18:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qJhnJi1j8/Y8WaA2Db2ICmstKXQQRKyDtARY/FrjNY0=;
        b=FPbx42WibWTLoU32s2Tvt7l/dSLTrMZX2str42c4XrdQHL9AYOUNYO6maLSMnCkl3h
         riWxX8MKUGZyVNrAO14lIwBI84nwpxi0qVGkLB3L8lR5KrNKyJcdwD8bmpmohaCH/Onx
         JAKTepg/0pxUXH9yJXSPTU6A/AAqjdVrMiGd2JK3OdL3fEHon70fTyXwTNO/S9YFTWP1
         iwAGWndPcSCnXlLV7fsdEQXHEfVdhidMkuEL5Ib+MZBs0L6NczeCO564qj1rOzz3Kanr
         LfXVUlowRULbPFmdPrj9ddYcpWsGAOSTSKdBcCEwLyxD/w/Gf3hc3SVOfOK8XxbqcYFK
         ca/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJhnJi1j8/Y8WaA2Db2ICmstKXQQRKyDtARY/FrjNY0=;
        b=DQFsf/TX4HFUDVey9cPF4AW8dDsXqcAubPlbZEZNQcfIz5vy2D8KGfu20C1Gycq3VS
         XCVodFJCMYNg2edFgIBgS/eMeoUfQbB1i5+fAj9cPkecxjPdogTv55nF1F/Wi3kY3OZe
         u5NrOU66/3BPKGcRh00mMOys7DJpQ1toCnG3Z4ZARij+ZJ8rab8+LwuRYJsmMwcpqK7Z
         4B5yTcjko7ZQ/tJEUFcQe+sffytd9wgzjQq4JYMDrT1HtK/4bQG/Vb5eNoKpSvoiOjGt
         244M0Rbwql5O2AApRj9tl6MwoiugYUFpkK28EATaRSI7Ux4hNaRAZhkhbc43Al37IocY
         bEBA==
X-Gm-Message-State: AFqh2kp26yWBIu3EQg8rWSjkf4BFspg6hHXmIFRfN7q8J8OdVYpVhDLW
        K+kQ0Qsfu+oSaMRZzu9Eeed5Xsq5HPtNJ29Vgu4=
X-Google-Smtp-Source: AMrXdXtKb3xY9l6hZ6iouAIvJJ+SfWIOIWFlrw8w+sz5kdzx5wx/y405AaiBcE+HvcUI1Yvmp9XUnbwQxn8sxOQuBfs=
X-Received: by 2002:ac2:5618:0:b0:4b5:b111:babd with SMTP id
 v24-20020ac25618000000b004b5b111babdmr2647990lfd.516.1674527783512; Mon, 23
 Jan 2023 18:36:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
 <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com> <5e4851e611ee18112bd71939ee900e02a8d590c5.1674367961.git.gitgitgadget@gmail.com>
 <759fb313-ce88-4eb7-96c0-4adeb75ca9f9@dunelm.org.uk>
In-Reply-To: <759fb313-ce88-4eb7-96c0-4adeb75ca9f9@dunelm.org.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 23 Jan 2023 18:36:00 -0800
Message-ID: <CABPp-BE+wRgjmWknARQpNsdUFjNOz0ND9wgx_-_RTyK+EwJjXA@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] rebase: add coverage of other incompatible options
To:     phillip.wood@dunelm.org.uk
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, Jan 23, 2023 at 12:08 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Elijah
>
> On 22/01/2023 06:12, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > The git-rebase manual noted several sets of incompatible options, but
> > we were missing tests for a few of these.  Further, we were missing
> > code checks for some of these, which could result in command line
> > options being silently ignored.
> >
> > Also, note that adding a check for autosquash means that using
> > --whitespace=fix together with the config setting rebase.autosquash=true
> > will trigger an error.  A subsequent commit will improve the error
> > message.
>
> Thanks for updating the commit message and for the new commits at the
> end of the series.
>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -1224,6 +1224,26 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >               if (options.fork_point < 0)
> >                       options.fork_point = 0;
> >       }
> > +     /*
> > +      * The apply backend does not support --[no-]reapply-cherry-picks.
> > +      * The behavior it implements by default is equivalent to
> > +      * --no-reapply-cherry-picks (due to passing --cherry-picks to
> > +      * format-patch), but --keep-base alters the upstream such that no
> > +      * cherry-picks can be found (effectively making it act like
> > +      * --reapply-cherry-picks).
> > +      *
> > +      * Now, if the user does specify --[no-]reapply-cherry-picks, but
> > +      * does so in such a way that options.reapply_cherry_picks ==
> > +      * keep_base, then the behavior they get will match what they
> > +      * expect despite options.reapply_cherry_picks being ignored.  We
> > +      * could just allow the flag in that case, but it seems better to
> > +      * just alert the user that they've specified a flag that the
> > +      * backend ignores.
> > +      */
>
> I'm a bit confused by this. --keep-base works with either
> --reapply-cherry-picks (which is the default if --keep-base is given) or
> --no-reapply-cherry-picks. Just below this hunk we have
>
>         if (options.reapply_cherry_picks < 0)
>                 options.reapply_cherry_picks = keep_base;
>
> So we only set options.reapply_cherry_picks to match keep_base if the
> user did not specify -[-no]-reapply-cherry-picks on the commandline.

options.reapply_cherry_picks is totally ignored by the apply backend,
regardless of whether it's set by the user or the setup code in
builtin/rebase.c.  And if we have an option which is ignored, isn't it
nicer to provide an error message to the user if they tried to set it?

Said another way, while users could start with these command lines:

    (Y) git rebase --whitespace=fix
    (Z) git rebase --whitespace=fix --keep-base

and modify them to include flags that would be ignored, we could allow:

    (A) git rebase --whitespace=fix --no-reapply-cherry-picks
    (B) git rebase --whitespace=fix --keep-base --reapply-cherry-picks

But we could not allow commands like

    (C) git rebase --whitespace=fix --reapply-cherry-picks
    (D) git rebase --whitespace=fix --keep-base --no-reapply-cherry-picks

For all four cases (A)-(D), the apply backend will ignore whatever
--[no-]reapply-cherry-picks flag is provided.  For (A) and (B), the
behavior the apply backend provides happens to match what the user
is requesting, while for (C) and (D) the behavior does not match.
So we should at least reject (C) and (D).  But, although we could
technically allow (A) and (B), what advantage would it provide?  I
think the results of allowing those two commands would be:

    1) Confusion by end users -- why should (C) & (D) throw errors if
       (A) and (B) are accepted?  That's not an easy rule to understand.

    2) More confusion by end users -- the documentation for years has
       stated that --reapply-cherry-picks is incompatible with the apply
       backend, suggesting users would be surprised if at least (B) and
       probably (A) didn't throw error messages.

    3) Confusing documentation -- If we don't want to throw errors for
       (A) and (B), how do we modify the "INCOMPATIBLE OPTIONS" section
       of Documentation/git-rebase.txt to explain the relevant details
       of when these flags are (or are not) incompatible with the apply
       backend?   I think it'd end up with a very verbose explanation
       that likely confuses more than it helps.

    4) Excessively complicated code -- The previous attempts to
       implement this got it wrong.  Prior to ce5238a690 ("rebase
       --keep-base: imply --reapply-cherry-picks", 2022-10-17), the code
       would error out on (B) and (C).  After that commit, it would only
       error out on (C).  Both solutions are incorrect since they miss
       (D), and I think the code just becomes hard to hard to follow in
       order to only error out on both (C) and (D) without (A) and (B).

(#2 and #3 might just be a repeat of the same issue, documentation,
but it seemed easier to write separately.)

I think it's simpler for the code, for the documentation, and for end
users to just error out on all of (A), (B), (C), and (D).
 --[no-]reapply-cherry-picks is not supported by the apply backend.

But, given this lengthy email, perhaps I should split out the handling
of --[no-]reapply-cherry-picks into its own commit and copy some or
all of the description above into the commit message?
