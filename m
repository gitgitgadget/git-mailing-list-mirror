Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7246420248
	for <e@80x24.org>; Wed, 27 Feb 2019 17:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfB0Rbw (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 12:31:52 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46235 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfB0Rbv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 12:31:51 -0500
Received: by mail-ua1-f65.google.com with SMTP id j8so16075426uae.13
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 09:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rS7kmC4jt8p8hF9uVF+yMelHny6v/Rj5ucAGpQ1CWy8=;
        b=MGBmYeadAacYglMONt2hdZ6dtSmOVzJYUkivaIVRyro0ffOYtVpFvw2a9uX36cUmIT
         y6xCGEeC2FmmU5lCKEDUjiQNc+H57vY1wnoHWgZn7XaWGrwaygBpq81nz9JSndpep0VJ
         cY4aEUhCfzXVte1s/8gvmQbzXdwrSk8Dy3wNT/9C43GtIYGGV8L+YQSEouFhK+jrxX1I
         BdBAe9a8bFbtZqFOkUG/s/FWoGCiqY8X0q2mdoMd/2jYpmfXnEZLwQ045pHqbrbjnU7R
         Brcye7LhEztncp/AQBIShrmAYGhgZB01um6sc8nCMwjShJ6g1PF+0oihJnwZplImMuXx
         aHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rS7kmC4jt8p8hF9uVF+yMelHny6v/Rj5ucAGpQ1CWy8=;
        b=JyoxxYYQMHwvASDQM3rN0ghIqD67mrJ9+myNUswAjx5wVrzMhL8WS01pbsrnvqZgsX
         1/5hkZ38b3YKjf4EhD/7rs60LiTLRzlwQf0i9aeFftXg+yRZlKiIrGG03Tr6I3rJxrwg
         uik7w6ydDxItHoQgRKHakP+v+INiiQnsBqGmjWu62tN6Vz3MiGnxEnpRa9QB1xkVJ26A
         6hdMMn+0w+y8l1sQg13OLk012znKlS4ARXEMS0dvy6a4ESPMbx1g5Sf5CoZMCpTHtd5F
         enBIvzLjdZL7DPwsnmL80JedMd+RuIch9fpagRzVm18SgSNB0yoGn9ifYtGm8MZhEUEl
         aRuw==
X-Gm-Message-State: AHQUAuba8OfIKMRzmhx/gn6fjjpclaSGhg+17iTzal1GqKf/wnEaAnDV
        4RjkgzuSsKLXMFyvlJS1Lle5FlBZ2SOIm0c/x64qAQ==
X-Google-Smtp-Source: AHgI3IaTVLtKJ+qo2HuGO7uoWneoCXLDEzx+Y9AM2JrGUw7dmH0RgVkOtGV0Lg8llwIAL8As0EaQOua7rAGYkXUna0U=
X-Received: by 2002:a67:eb97:: with SMTP id e23mr2508506vso.175.1551288710121;
 Wed, 27 Feb 2019 09:31:50 -0800 (PST)
MIME-Version: 1.0
References: <67C5CE5D6EC13D4DB8FC51E2F9BD262F022B8B3151@Triton.ad.trimma.se>
 <512993fe-51da-745d-031b-37ea162499fb@gmail.com> <CABPp-BGbrWrS0622yfTRUqRzWzNsZ_v9cAWW6ucXBYXqD26qHA@mail.gmail.com>
 <20190227164056.GA2062@sigill.intra.peff.net>
In-Reply-To: <20190227164056.GA2062@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 27 Feb 2019 09:31:38 -0800
Message-ID: <CABPp-BGOqQ0P8ywCK_sybPOeASxPnkTq7NXW8678f=345=68-Q@mail.gmail.com>
Subject: Re: [BUG] All files in folder are moved when cherry-picking commit
 that moves fewer files
To:     Jeff King <peff@peff.net>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 8:40 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Feb 27, 2019 at 08:02:35AM -0800, Elijah Newren wrote:
>
> > > > I have found what I suspect to be a bug, or at least not desirable
> > > > behavior in my case. In one branch, I have moved all files in a
> > > > directory to another directory. The first directory is now empty
> > > > in this branch (I haven't tested whether this is significant).
> > >
> > > I suspect that because you've moved all the files git thinks the
> > > directory has been renamed and that's why it moves a/file2 when fix is
> > > cherry-picked in the example below. I've cc'd Elijah as he knows more
> > > about how the directory rename detection works.
> >
> > Yes, Phillip is correct.  If the branch you were
> > merging/cherry-picking still had any files at all in the original
> > directory, then no directory rename would be detected.  You can read
> > up more details about how it works at
> > https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/technical/directory-rename-detection.txt
>
> Is there a way to disable it (either by config, or for a single run)? I
> know there's merge.renames, but it's plausible somebody might want
> file-level renames but not directory-level ones.
>
> -Peff

Not yet.  Adding such an option, similar in nature to the flags for
turning off renaming detection entirely (merge.renames, diff.renames,
-Xno-renames) would probably make sense (I don't see an analogy to
-Xrename-threshold=, though).  It might make sense as just an
alternate setting of merge.renames or diff.renames, though it's
possible that could get confusing with "copy" being an option.
#leftoverbits for someone that wants to figure out what the option
names and values should be?
