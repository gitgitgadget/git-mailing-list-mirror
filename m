Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8094CC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 01:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579176135E
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 01:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242151AbhKRBRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 20:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239106AbhKRBRH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 20:17:07 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE06C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 17:14:08 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id g28so4593357qkk.9
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 17:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLEFHoN6wGsmz1/bagB1JmFojD+omRjTKTZyWENqMX4=;
        b=fyfUAHOO6z0fVrmTM9dinsyUL9LyEFwkprfB5liXlm5Ff673vgwEcJSSH76rOOPrZY
         pGfdfoPenhLDswlXzMrZJWDR7a917G9mqOM3xoTah2KN+8/+ZpJI82IVhaRFe9YSXz5O
         l4cphBhp5yHkD2IQoAPQ7ella9kBmLeg95aKv7LI4hkNYlUrR8b2KOi2ai3Wp8qW7ndz
         wdPWEel6Tpjfi7yZyjwAj7jF2HqbPc3aU8U4Rbd3NHtHm1Pa99zMeknze0oHUA1YqYOc
         b5sYmTfW0szMePWFPi6mCESyY38oNFgynkwor/fjsm/1zEyZKKRaBTaS+uPhVVwpBl8T
         yr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLEFHoN6wGsmz1/bagB1JmFojD+omRjTKTZyWENqMX4=;
        b=5uX2fCbWbz1QDybksAI7Li6jYRkC+CWplWxs3JGQedkJh+BkmFUg6aiaV1nDwdEfYf
         uH5VW9fUSjckL5jOWMSx8eTTdhxQUMq7BqPuQI/19BZu5dc+3pRnrfdNaqeM9qmGiqe6
         pRFAk88CBXEexfvwSys3yDaUM6dLjtnmRxYloNNebT9olH5sCOUqMzviFaFN1PPMbOIM
         7dWAr9wsehbc+0JVV06aknGnA7CaBI0UgZaIV9XPeI8dtwRR6qJzT2F1WtwbJlYQ9KdN
         2EQjWlVoKEHTDL34w7aV8tDk+CoDRd8OG9aSnUmlp6X4sLngyzs1VwxAZVN+Cfn3H+QO
         BE2w==
X-Gm-Message-State: AOAM532m/0oWjeBjMMkRBrqb6oO9AgIeZc4KTQOTY4i0foiHWxMqlmjr
        1imRTRj4OLf9QwLpACgVihlddvti1Dacg0KyWrG800W91vNnRA==
X-Google-Smtp-Source: ABdhPJwBoFGKW33mKUEWsVDUESYyRhVHlPkt1MlQNOj6UufiBlc8bvPIhRo6J2jyToW58rkQaSRjfG00DnYbV8DkB/U=
X-Received: by 2002:ae9:e649:: with SMTP id x9mr17180898qkl.204.1637198047298;
 Wed, 17 Nov 2021 17:14:07 -0800 (PST)
MIME-Version: 1.0
References: <127c9dbd-4861-beea-a85b-af7412ce141f@etguillot.fr>
 <6fa0b1dd-ac20-ff55-95ea-1c22347f9199@iee.email> <20211117175149.7slohfqqwsmn3ua6@yadavpratyush.com>
In-Reply-To: <20211117175149.7slohfqqwsmn3ua6@yadavpratyush.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 18 Nov 2021 09:13:56 +0800
Message-ID: <CANYiYbG0CF0hC+yamdNFz8cytB+W4onRkqXusNoWR1xv2aqJzw@mail.gmail.com>
Subject: Re: Need help in understanding how to submit a patch
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Etienne Guillot <git@etguillot.fr>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 3:34 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Hi Etienne,
>
> On 17/11/21 03:47PM, Philip Oakley wrote:
> > On 16/11/2021 21:15, Etienne Guillot wrote:
> > > Hi,
> > >
> > > I found a typo mistake in the french translation of git-gui.
> > > I did read the instructions on this page
> > > https://git-scm.com/docs/SubmittingPatches
> > > but I still not sure where should I push the correction.
> > >
> > > Thanks for your help
> > >
> > > Etienne Guillot
> > Hi Etienne
> >
> > The Git Gui is managed by Pratyush Yadav (cc'd) and hosted at
> > https://github.com/prati0100/git-gui
> >
> > Not sure what the latest is on contributing translations (not covered in
> > the GitHub Readme..).
>
> I usually ask people to post patches on this mailing list and I review
> them here. But I make an exception for translation changes since they
> never get any reviews anyway.
>
> So I am fine with either a Pull Request on GitHub or a patch on the
> mailing list.

For l10n of git project (not git-gui), different l10n teams use
different code review strategy, but at last all l10n team leaders will
send pull requests to "git-l10n/git-po" on GitHub. There are some sort
of code reviews for l10n and most of them are basically focused on
commit logs and typos. See:

    https://github.com/git-l10n/git-po/pulls?q=is%3Apr+is%3Aclosed

Starting from the recent release cycle of git 2.34.0, l10n of git has
a CI workflow and the CI robot can give some review suggestions for
l10n contributions using a helper program.

    https://github.com/git-l10n/git-po/actions/workflows/l10n.yml?query=event%3Apull_request_target

The helper program can be rewrite to help l10n for git-gui project.

    https://github.com/git-l10n/git-po-helper

--
Jiang Xin
