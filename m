Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEDCC433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 19:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4542D2068F
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 19:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEWNXFNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgG2TaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2TaA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 15:30:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6DDC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 12:29:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id f24so5029509ejx.6
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcp0gY1OzLuXWIiwvhpZpMdmk5ObLJuqnHMvu/qPtgA=;
        b=AEWNXFNI6/yyxbxxKn2yMgSG3K3avd7TTNN9mXPDDBWtsgNF1kD7J3tjOl8kfoqXr1
         RvBV4q2ffJC6Bk4zGD9LrFp2+4/LJLpTnSMhIm+fUfAueM83E9bmtTIAwTviYTSi6q0R
         4A86h7BZ9XLYianSk1OZ5ScwamuQN4ZZMI5CuPkNHPZz5TlZSc5L8kY/xqTRzoJGDHDg
         hpcqrwNq1rbk3TFPjexumnQ9QXfXYaTYlOxd8no73p9UFlBbbAjfarwuv8YWeG2dt3Lr
         S1a0dPPZJ4lfZJlUfi8oAVMsolmw99jTmXzzXsJypNB2Lrai5WZI0CqQMxFAg+xbtmMa
         E9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcp0gY1OzLuXWIiwvhpZpMdmk5ObLJuqnHMvu/qPtgA=;
        b=g7r9MwW0R8jIfwgq/G4L1evAuPpb+sSJ/GHNt0Ii1QDCmjeA1JwWLmg/UqzoTzbCk4
         jslCJNRbYoaye+ATEyZMCdDB19eqsBs7yfOiiYfJLq9DmImpTNX7qRYT36r7uQJ2ZKbk
         1FpaQ8Otwq0DAor0wMmklzmyHU/mfCRIY23ISHiiKCVWyRgATW74mexfZ2++RDICfcJI
         d/Pq6H1cofagH3GZyPZ+G8R1tbGipmwBDpqOkz/RIobJIebtPqqZKuo1rczG7TAhCG9l
         e24WX+DYhhYy2PZQCz0cmUzZOyEOQSpJ5qzL0JPZ4+499B5Cnbq8wATQhRNukwghWUVW
         Zf3g==
X-Gm-Message-State: AOAM532v/NmsjMceCP4a2VXlLg4xCbb6oU07frJ4NbOXkNQ725TyZ2G0
        dheBAkOpSwnYgzFQKy7xjSiY3zkV1KFsZvLKkOSTbQ==
X-Google-Smtp-Source: ABdhPJx3WstGPCQCXYJIgwLafOLlA/gXcplUUY8BGsDUhOCa9bdPAljGkxNKfIQ6f/Ok7dr7CSfJa0m81ysjtzmrUhs=
X-Received: by 2002:a17:907:408c:: with SMTP id nt20mr23986586ejb.503.1596050998047;
 Wed, 29 Jul 2020 12:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <CA+TwhoKBYwUKmtQTyiocPWJD=KeZQryS+6Q8JKxKgLEy0qJwAw@mail.gmail.com>
 <20200726040226.GA19030@dcvr> <20200727151023.GB62919@syl.lan>
 <20200728100726.GA24408@dcvr> <20200728162528.GH87373@syl.lan>
 <6b4b3f77-a479-4d7b-d7c2-e3e35e658ac7@gmail.com> <CA+TwhoJqm-EB6OkLOr6+B4RZfaQ7aVde+hSrSeWV-jYkfBLGNg@mail.gmail.com>
 <xmqqzh7i9o11.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzh7i9o11.fsf@gitster.c.googlers.com>
From:   Carmen Andoh <candoh@google.com>
Date:   Wed, 29 Jul 2020 15:29:47 -0400
Message-ID: <CA+TwhoLrkf6Z1g0NxYN5OsRwV85ONQKY05J0fiQN6tKQR035gQ@mail.gmail.com>
Subject: Re: 24 hours to respond with date/duration preferences for inclusion summit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 2:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carmen Andoh <candoh@google.com> writes:
>
> > Hello All,
> >
> > Just a reminder that you have another day to respond to whenisgood
> > [1].  Note that times are listed as 6AM-9PM (21:00) Pacific.  Please
> > specify duration preferences ( half days, full days, etc)  in
> > comments.  Hopefully we'll respond soon after that with date/s that
> > works for most.
>
> Sorry for sending this on the last day.
>
> After re-reading the original announcement and the above part, I am
> wondering if responding to the "when is the good time for you?" poll
> is a requirement to be invited.  My tentative understanding is that
> this is merely to help resolove scheduling conflicts, and those who
> want to attend but have no particular time/date preference can just
> stay silent and wait for the invitation to come, to which they are
> required to respond via e-mail in order to attend.
>
> I suspect many people are wondering about the same thing and
> a bit of clarification may help.
>

Thanks for the question Junio.  Yes, this initial solicitation is
merely to get a feeling for what the best times and durations would
be.  It does not mean indication of attendance, registration, or
functioning as an RSVP.  This will come in a subsequent communication,
with a date/s and times chosen based on the survey.  ~C

> Thanks.
