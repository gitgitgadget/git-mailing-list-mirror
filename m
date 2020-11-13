Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16AEC388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 15:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E191208D5
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 15:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9uYnrjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgKMPtx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 10:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgKMPtw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 10:49:52 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3C4C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 07:49:52 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 10so8519270wml.2
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 07:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qfKg3PORPDWLLGrPlgQb5/ZhXFy4g2edo3+b09VbAY=;
        b=H9uYnrjVgIb7TBhS2jy6Lo9Xxyu1cThilYs5oIQ86fWLBRjjxWiiBF6TKLww0jgjoJ
         gGzcG1P8VUpN5q7N6185nPrF+vN/JWdHDXa2JCs2j8Ry/P2x1ILTEgVHHbdcoCy/5CZ1
         Ozy51mwFJ0YRo4edTwDQsxVSn4nGc5eUPLhJ/Wnt7nfiIoBUW9wuKpStFpHaKDfiWLdN
         IyRFJwE2pBW8XsJaUdLe2ePnj5ap/4bpLUaR4/E6kB961MHELfFBzuDKbC67jbSYtooz
         FwJActIWZtzyB0X4UkKr450bHhXuLW3QOKhY/2LcHZAAy4x829ufmiu+hzVZWrsZw34J
         OZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qfKg3PORPDWLLGrPlgQb5/ZhXFy4g2edo3+b09VbAY=;
        b=DQW0ypIx6BOTKvZY+E/OUCdTEkocmViihOPqELFt+Wk4VhGnD00xfq9RFrTVbNgk50
         5zGGcICjrVkkXCwF1IN6YnKdOUj7VqTpWkyNidbzMNfKBJOs0lqoJD3tx+c1gODUFqMs
         6+T9GBwxbUnN06J+zFwfb/d/nE5dD8DR3TrXleza2MmLtUMW0Hq6eSs1tlfpQEVm8Z9Z
         /NDUOV6FHiwH0rbFweHskbE13pMaD8nUnwZn+bvPdNDK9QJUtGud1CRJ1dcELeaz+YxA
         Q/I0dbVP3JjcSKJgGV5F72gc5SBESVXi+jkLWyR9i/EgFkGNU6OZn/IkozIiOSyBfm5+
         1B0A==
X-Gm-Message-State: AOAM531JrbcBOu4jsEy/gKXb156h3syGm7g4q92p0RoC7ZdKaPbQjJV9
        +5pCDG0MfghQknlsHzXpY+/9S2TQr3/sD1P6yBE=
X-Google-Smtp-Source: ABdhPJzt+DmhDeZt0u4DEe2O2lbF52qe0TBQmoAlhqES0xpGMPL1Ykls2AQWui3700q77E3QoUjs9qNbqYurXPS/+ho=
X-Received: by 2002:a1c:4c09:: with SMTP id z9mr3187682wmf.55.1605282585810;
 Fri, 13 Nov 2020 07:49:45 -0800 (PST)
MIME-Version: 1.0
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
 <20201113010107.GL6252@camp.crustytoothpaste.net> <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
 <nbCkLegnP_kb-16UzAuDChE0p68ZtRD_3ZN3o3BJHYBYpUxTWuKjvhCSKT7zRZl_sckHrkyJl2fwePFUBR-HtDcEV0rHuac6Ygg-FrrYsYI=@goodman-wilson.com>
 <CAMP44s1vx==-0Sh_dN66k-u_LwUSqQRn+ckMrYMHhz7i8ZVr2Q@mail.gmail.com> <3EC700EE-8DB1-4A31-9061-6C5899330CCC@gmail.com>
In-Reply-To: <3EC700EE-8DB1-4A31-9061-6C5899330CCC@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 13 Nov 2020 09:49:34 -0600
Message-ID: <CAMP44s3ksNQGg2cDjC5msqs=NfdUbdQzSJA+sTTtN20PrH74Hg@mail.gmail.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo fiasco
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     "D.E. Goodman-Wilson" <don@goodman-wilson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 7:53 AM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:

> > This discussion never happened.
> >
> > Everyone in the June thread argued about the different names of the
> > potential branch, and the culture war implications. Virtually *nobody*
> > argued about the manner of implementation: deprecation period, clear
> > warnings, Git 3.0 consideration.
>
> I couldn't agree more. We really need to be warning users several versions in advance,
> and I mean months or even years. I don't wan't to come up with a number, but I would
> guess that maybe 85 %, (or even 95 % ?) of the world-wide Git user base is unaware that any discussion
> on that topic ever took place.

More like 99.9%.

> Brian mentioned that some people voicing their concern on the list did not abide by the code of conduct.
> There was also very vocal disagreement voiced in the Git-for-Windows GitHub project before the
> discussion reached the mailing list, of which a lot was also considered to not abide by that project's
> code of conduct. While I agree that discussion should be done with respect, and some people that
> are driven to react to such important changes might not be aware of any code of conduct they should
> follow, because they don't participate in the "day-to-day" life of the project, just the fact that they even
> care enough to voice their disagreement should be a big red flag in terms of how this change should be done,
> in my opinion.

Yes, the abrasive tone of those users did not help, but neither does
tone policing. At the end of the day they did some valid arguments,
and it will be the users that suffer because the project decided to
focus on the tone, rather than the argument.

> I had avoided commenting on this whole subject, but the main point you are bringing,
> that such a change, if done, should be made with great care to our user base and a lot
> more warning, is a very important one.

Indeed. I am debating whether or not I should bring up the arguments
nobody brought up in that big discussion, because in 2020 the concept
of freedom of speech is lost, and merely stating facts can get you
banned from a community, or worse. But the facts remain true.

For now I think this is the imminent issue, and a warning must be
issued so that users know what is coming. I suspect when they realize
what's coming, they will preemptively complain in the mailing list.

We'll see. But sneaking this change is *definitely* going to upset
many users, making the problem worse.

Cheers.

-- 
Felipe Contreras
