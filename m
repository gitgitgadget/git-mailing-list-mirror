Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8068C433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 08:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DBB206C3
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 08:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uc3iovyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgFDIOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgFDIOl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 04:14:41 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358BDC05BD1E
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 01:14:41 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id v1so1084507ooh.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 01:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Ya78/1VUk2q3WnDeyoUMbZCfIs8FQpt6TA3XOqgD3I=;
        b=uc3iovyqwy+Sf0NIx+fV3+cYov/bIrLI9Ha4V/WrV3TZ1JVIsZgo9PAVFtz95WJWJ8
         tpJs5U7M+PYTqe+RLVnkvwvS0thZA5uapH4Px5Ax0//Fhgf+XVU5UzWkQsZN3X5X51xc
         3zSDODZ5OAIAkoHo15KMimHo0xJ+t6m3YS/Iym3+xeMR/Xx0e62ArLFrH/z58NSVNx87
         pLRlDLhtM/o8NKXFjyNVdANKEcwGe8QxchuTV4XayxRBKADssTQS8o20GbmorAEE0fmM
         NqSR7Azv9JvHUg208e7M30ZJR8EO4UxYxxQexWaxuJmDTnXhwVl0cjyLqqV+I4VuPMdM
         n5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Ya78/1VUk2q3WnDeyoUMbZCfIs8FQpt6TA3XOqgD3I=;
        b=ayNRdGt/kvQNi6bYwVs1yKA5Njo9loas9w8GfbTdM3d/KjVdbpONurBgVN/YXy0L96
         LpIW36ndsBnGLLR4HHjK43DegnuELmuxykDGYiAIf+aMM+Ie8W5ad9WkzanncTDaEqO6
         7DlptbwLHNY+v0ETktvcTzgVXv541QzlJ9GDPI7AlELAROJPP66CF33Cpt1rG0LxLiCz
         UM5y/2HEDwb7CZ2WK0HZveLmaB/dbfNKwpFPZMapRI5BQ0wT/+egHVeLMnD5rffvZP0X
         6DVmKmtbhnZmtIh62QB0B+go1m3yzaO/tH/4smoaIqqNRkEpfJYW+jcyigsDjTF0bzwi
         zLjQ==
X-Gm-Message-State: AOAM533gXlWoroktFYGEr9lMZaRaBdxmeCDQmjG1y2m4fguxO1zB9ZS0
        sH1Feor3QrRDwlIF8dAFvN3vc8AlInJd6qrLNqCP+AB8qUY=
X-Google-Smtp-Source: ABdhPJymIZE+Qr0GjjWTuiglp2EdJcIX8T+GmSduRdPZI0fOJ+GQo7NCYyvsOQlSAfKUqvQg3qcHEQUqgrGzcESZPFk=
X-Received: by 2002:a4a:8688:: with SMTP id x8mr2909954ooh.7.1591258480341;
 Thu, 04 Jun 2020 01:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqlfl3rhl0.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfl3rhl0.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 4 Jun 2020 01:14:28 -0700
Message-ID: <CABPp-BH=SqT5v=CnuPm+6Sqy+1tP=72Wx_oCKs+DxJcdKzwgFA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2020, #01; Wed, 3)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Jun 3, 2020 at 2:01 PM Junio C Hamano <gitster@pobox.com> wrote:
> Seeing a handful of regression reports [*] immediately after a
> feature release is made gives me a mixed feeling: people are eager
> enough to help by reporting issues they encounter, but there are not
> enough people who are eager enough to help by testing the tip of
> 'master' before the release.  Are there things we can do to help
> them become early adopters so that they do not have to scramble
> after the release?

That's very diplomatically worded, but perhaps let me peel back that
deflection layer a bit and be more direct...

A disproportionate number of regressions that we've had in recent
releases have traced back to me.  2 of the 3 regressions from 2.27 do.
In the 2.26 release, we had a whole pile of regressions with rebase
due to the change in the default backend, which came from me.  And,
we've also had a bunch of "fun" with dir.c in _every_ _single_
_release_ (to the best of my memory anyway) since I got my foot caught
in that unrelenting trap[1], including 1 of the 3 reported regressions
in this latest release.  The regression reports after releases have
been weighing on me too; I was thinking about it a fair bit last week
as well as this week.

[1] https://kernel.googlesource.com/pub/scm/git/git/+/8d92fb292706fd8d13cfe55353b2ec9345153a3e


Now, it's possible these regressions could just be a reflection of the
fact that I'm focusing more on fixing inconsistent behaviors rather
than adding new features, which is a type of work where it's much
harder to avoid fallout and reported issues.  But it's also quite
possible that I'm going about these cleanups wrong or at least
suboptimally.  I'm open for suggestions of what I should change, or
even experiments to try.

Recent attempts I've made to make things better: (1) I have in the
past month or so gotten a company internal distribution of git
started, with a growing number of users.  This distribution uses
pre-release versions of git, mostly off master so far though I'm
considering moving to 'next' for it.  (2) I pushed hard during 2.27
for the dir.c changes to either merge early in that cycle or wait
until early in the 2.28 cycle -- hoping that an early merge would give
more time for testing.  (This was an attempt to learn from the 2.26
rebase issues, since that merged late in the 2.26 cycle).

Any other ideas I should try?


Thanks,
Elijah
