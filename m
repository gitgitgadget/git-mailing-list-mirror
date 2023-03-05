Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546BBC61DA4
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 13:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCENkx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 08:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjCENkv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 08:40:51 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CFEC156
        for <git@vger.kernel.org>; Sun,  5 Mar 2023 05:40:51 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id y19so3989665pgk.5
        for <git@vger.kernel.org>; Sun, 05 Mar 2023 05:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFJG4RPihFl3MwTHkJv1LTphLUGBA+PG7HFjDplPRnk=;
        b=He+AwvzjQqb1Zv0WumLbO0m8ueVkONY6pOimzBIxSte46i+Tt+7/Aox0Eg6ta1bztV
         xDU8vb25yuMySqTbT1W8IgV04ltJsnflS/0ZXxMdW1OY3zmfpRNGyygaUjU9eT/jGbXl
         g5FbRDEFgG6TeT7QJHaXczdw+pn/D5SeyuvrZN0NM73c1QYga4p9inrj5RMmmFaUcl5b
         L3t5wMEYKB6KuhMFi1haU3ShByxK+mzn00Ux/9uQ0uBCLl9sLiWLigGyXw5fFiO2nFIX
         cCe0/X03Rlsqf23YIb/hd1cBUbRM354CcbFZ6kycMFR0pPMLEI7YhNOAITt2fP7XU0lL
         62iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFJG4RPihFl3MwTHkJv1LTphLUGBA+PG7HFjDplPRnk=;
        b=bNJ0OF7guV0Rz9Sn17oUi+xkSB96XQF4wIHGMgsW4kD8oNNb3zJ5KNPDxYBZTFBx3I
         KNrrKPK+QJvdzo/6bDj0SKWi9kfqCpTOrU/7AHfAVHv0YFJFK4k8UT4mjxsOSCqk+nro
         tSe2puuLn6L5NWlu9I7cu2aV+85mvVLoQEhIa5zJ8Ve1T60tJujj5iKI1GdYz865aEZj
         UC4oshuSkM/6PpMuJesKK7pz1fXhKTN/+cubk6GAaMSMo5J4Ap2N2jnpFYEXcwnhaRQ0
         1kA0rME1mGaZTA87ffinJm8Jm6grX62S5Xl+DYyeitzzl7LNtdcbixLM0PYXplFb2FQj
         Pj3A==
X-Gm-Message-State: AO0yUKXLvKBmoC4iE8GobTjakE41Z6sSzTkPTHGNljPV+worVpqqFTnN
        PPDJQ/pic0BnIMw3UuFodFz8myWHKgNLvQbZlTDCfOxb
X-Google-Smtp-Source: AK7set+u6quhbH3/hIYKKrZuZIFd7SE+lNPVjcJtEgfujtw3uXDvKW4ZNJJeKNXbBdVgxBjWdZWkrC8uRVQVWETVttw=
X-Received: by 2002:a63:f91d:0:b0:502:fd12:83ce with SMTP id
 h29-20020a63f91d000000b00502fd1283cemr2766779pgi.5.1678023650384; Sun, 05 Mar
 2023 05:40:50 -0800 (PST)
MIME-Version: 1.0
References: <20230303145311.513960-1-eantoranz@gmail.com> <xmqqcz5phjgz.fsf@gitster.g>
 <CAOc6etb9pCXx9S5jxk8Yex++_iai21THU74qdXmOm1XxjHx8Lw@mail.gmail.com>
 <CAOc6etaCz=JWPnk2Jv8KYG02xBN+jZG1EfbnwtKnq_A0UBUpEg@mail.gmail.com> <CABPp-BFCNjMsxAcLOxr_9Rnu3n_KL5RMCfD_m7ytS+b_gbd3Xw@mail.gmail.com>
In-Reply-To: <CABPp-BFCNjMsxAcLOxr_9Rnu3n_KL5RMCfD_m7ytS+b_gbd3Xw@mail.gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sun, 5 Mar 2023 14:40:39 +0100
Message-ID: <CAOc6etZeWpxLwkuJM-auhc0N-zu92zYtrMnSjHMGyxvvs2+vEw@mail.gmail.com>
Subject: Re: [RFC PATCH] sequencer - tipped merge strategy
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 4, 2023 at 9:36=E2=80=AFPM Elijah Newren <newren@gmail.com> wro=
te:
>
> On Sat, Mar 4, 2023 at 3:57=E2=80=AFAM Edmundo Carmona Antoranz
> <eantoranz@gmail.com> wrote:
> >
> > On Sat, Mar 4, 2023 at 12:45=E2=80=AFPM Edmundo Carmona Antoranz
> > <eantoranz@gmail.com> wrote:
> > >
> > > Usercase can be at the moment trying to rebase (with merges) on top o=
f
> > > an exact base copy. In cases like this, git just crashes on merge
> > > commits. An easy example:
> >
> > I should have said _crashes on merge commits where there was a conflict=
_.
>
> Crash tends to mean the program has done something not allowed by the
> operating system.  I don't think that's what's happening here.  Do you
> mean Git stops with conflicts?

Ok, sorry for the sloppy wording. Yes, it stops with conflicts.
