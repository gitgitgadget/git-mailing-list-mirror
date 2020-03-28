Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F90C2D0EB
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 17:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE990206F6
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 17:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruaYrht7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgC1RRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 13:17:43 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40555 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1RRm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 13:17:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id r19so7499672otn.7
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQOUpFkA3v123nwpwOroFVjcDAR4oSBJ3gIBo8UpM9A=;
        b=ruaYrht7u5LF2Ym2W2+7AHbX49oInMbOzt4DKNI/ac7Hvlctc9GjI3rMxk+mJBpmUU
         Al/TDWtpV+XzYz4DnbVdgyKhckrWvoWIE61g7p49vJPOBlL5RSJ+BSP9/IWrUhOeUByE
         YQAooGhc1uBWJXWsGARcq0lbnTMlAPMM0/9WK87nragDreyDI8gDByZSio7iqnVRIHnN
         ur7VoXeovx5Dct9FZ6QOOVBnxFHY7o/jgMHvOrowSBohaN/4vjqa+XpMha1VTXsbcps/
         wg/JNEVLGapr3B1TCQ6Pcf1AxiSVxv6ai5B41l20qxFB18qXpf23txBjxqjBUELVGb9/
         ZS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQOUpFkA3v123nwpwOroFVjcDAR4oSBJ3gIBo8UpM9A=;
        b=f8MRk8AtEDbrCLoXiPEU3uLpv15y4ROLXXXu3/4Qa9VESzc+IBaMySUyZ+CnB27xOf
         JL+kkDGw9UcPPaGDEJh0nnHD7Z28cmf8QnUJOgMWJRG0E7/x35QnlzvcWP1xMHBuo5qX
         /fYklK3GUDUxOs8BpVyEy+s6Mpe6P1KitCWZtWsd+RpNJVTUJz//I8pra7f3QDBJvP7A
         H9ESJWDVfyybRMitnnXKM1cx7s7U0p7yimdwgdSqwVHXKP92RFlNK8BAdcQ0trWAyA5x
         7s71u+HlCkQenfsZKMFNmi7lmZjiTaerBTl139gtVYhW+uuzoPACU6XWW+pYVi4sxTxb
         TcAg==
X-Gm-Message-State: ANhLgQ3CsYF5O+Vp/vBEb2y61JOkpopy9EJaO49qDN7oSPvYw/Q8tef/
        +t7kX/GELDeSiuFSPdAU4KkpC9FEuyTCxWyhUZAXoex7/cc=
X-Google-Smtp-Source: ADFU+vsssyh3KqiRVbKRTgDFNBpcmqUmzhosUNqXNBFjfFOnutTg/0hMcaL8r2vufH/vt2xIF+kviKzBFCq2H82aBsw=
X-Received: by 2002:a4a:3b50:: with SMTP id s77mr4032682oos.53.1585415862193;
 Sat, 28 Mar 2020 10:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.739.git.git.1585345900763.gitgitgadget@gmail.com>
 <20200328155627.GB1215566@coredump.intra.peff.net> <afb593c8-ba46-fe8f-8853-d0b727186af0@gmail.com>
In-Reply-To: <afb593c8-ba46-fe8f-8853-d0b727186af0@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 28 Mar 2020 10:17:31 -0700
Message-ID: <CABPp-BHLtyCR_2KC6M=GaiJTOAR90wHTLAM4twEq_p4JaKrm3g@mail.gmail.com>
Subject: Re: [PATCH] pull: avoid running both merge and rebase
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Norbert Kiesel <nkiesel@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 9:55 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/28/2020 11:56 AM, Jeff King wrote:
> > On Fri, Mar 27, 2020 at 09:51:40PM +0000, Elijah Newren via GitGitGadget wrote:
> >
> >> When opt_rebase is true, we still first check if we can fast-forward.
> >> If the branch is fast-forwardable, then we can avoid the rebase and just
> >> use merge to do the fast-forward logic.  However, when commit a6d7eb2c7a
> >> ("pull: optionally rebase submodules (remote submodule changes only)",
> >> 2017-06-23) added the ability to rebase submodules it accidentally
> >> caused us to run BOTH a merge and a rebase.  Add a flag to avoid doing
> >> both.
> >>
> >> This was found when a user had both pull.rebase and rebase.autosquash
> >> set to true.  In such a case, the running of both merge and rebase would
> >> cause ORIG_HEAD to be updated twice (and match HEAD at the end instead
> >> of the commit before the rebase started), against expectation.
> >>
> >> Signed-off-by: Elijah Newren <newren@gmail.com>
> >> ---
> >>     pull: avoid running both merge and rebase
> >>
> >>     Cc: Norbert Kiesel nkiesel@gmail.com [nkiesel@gmail.com], Jeff King
> >>     peff@peff.net [peff@peff.net]
> >
> > I'm not sure how cc is supposed to work with GGG, but it clearly didn't
> > here. :)
>
> Angle brackets would work instead of square brackets:
>
>         Cc: Norbert Keisel <nkiesel@gmail.com>
>
> for example. Personally, I drop the names and only use email addresses
> so I don't make this same mistake.

My original did have angle brackets; it was literally the following line:

Cc: Norbert Kiesel <nkiesel@gmail.com>, Jeff King <peff@peff.net>

Not sure why it came through with duplicated email addresses with one
inside of square brackets.  Maybe GitHub markup does something to the
angle brackets, and GGG doesn't get the original text but the
markdown-interpreted clobbering thereof?  Or something like that?
