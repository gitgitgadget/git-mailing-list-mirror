Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D919C433E1
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 20:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2D120734
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 20:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJVbeCWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgGRUHV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgGRUHV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 16:07:21 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C842C0619D2
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 13:07:21 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id e15so6567030vsc.7
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 13:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YtpJDhVoC6Y6l43xkvzq20xUgVyvVpIfvljyWJ/cy0o=;
        b=VJVbeCWS6sXVeWqtQhEWtRoC2d3VI2M/OIYI7NWgBoyhEYcBUd9vPs7AfcdkEQe2nC
         sMSj34F+zicgA5mjvlQ93ps58fWtgEauf+W5q5in0QWzMdu20FIvYFPXQjz6yNfFNgNX
         tvGy1dFrhNWf7CebYY3vy6n/JSzAEbcXagF1b1FrY5LVhs6KhNgrBgV+LKloGCMOE3DM
         ahy9OqHTM9Hcah22CAzU3O74SmC6r9qB3aM8Os6dMpQ8nlTKbwtSrSOiKG+Jv4s8y2yd
         EY7bNoC05WYwlygIuUZbmw9T2mhNRgLU6cejyBbCfMcm8FEx1zyPsO4zudVrTXGuT0eL
         7xnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YtpJDhVoC6Y6l43xkvzq20xUgVyvVpIfvljyWJ/cy0o=;
        b=oUtRIbm+tXvmb741QcdgDKE9pf327iABFlcLA+B/dbF7uonx5aQpVthol8qYVCZvZl
         GNBADUPlW7C+pl4SSiz0HgPUR4X6SkS/D+oYaBdSIJjr7p/v01IRJeuOwcT6a1DWpyfm
         Idosqq9sA8rzBbFF3NiJAm2RiirglVDpPmhue/95jeKFXB95qeMkiyyXARtm5fxElN39
         UuLklNOIc8fVXWZmEexrAAKHAjqrSDIOs4YMXsAu8e3oU5ODBQXv9dg875QK2lsgVC65
         d/8wC7r0AgSfv6ihjpKdLotw1gFsMaL7u5snsAk2+wuJcvF6B3+8wag+mS6IZZWE+jHF
         0+Vw==
X-Gm-Message-State: AOAM532yqb57tmAHIxp6YMnI328e9bWWobD5bymK+hxI4L5j3iwNdbKR
        IV98UfWXoMCa1VZE5uIh3iQ8HATDzOom+Az9pS1iC5+1
X-Google-Smtp-Source: ABdhPJzfNSDI5KMogyDHUW09P5pj7xxt3VK10835n9mt1DCX+u/NlvWJIaj38tIseTSDVj8mU1Ju6Z53HyLWVupKfNw=
X-Received: by 2002:a67:b448:: with SMTP id c8mr5767414vsm.54.1595102840335;
 Sat, 18 Jul 2020 13:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <00d001d65c80$3519c960$9f4d5c20$@nexbridge.com>
 <20200718094840.31269-1-martin.agren@gmail.com> <xmqqtuy4bt7f.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtuy4bt7f.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 18 Jul 2020 22:07:06 +0200
Message-ID: <CAN0heSrsLnRZoAgnDB8uNrxC_Ah=29MDr73KP9REye+hTSTJSw@mail.gmail.com>
Subject: Re: [PATCH] t3200: don't grep for `strerror()` string
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 18 Jul 2020 at 19:59, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > Similar to 4605a73073, grep for the beginning of the string instead to
> > avoid relying on `strerror()` behavior.

> Yup, that looks like a good description and a fix to check only the
> parts of the message we write, ignoring what the system library may
> add.
>
> >  Hi Randall,
> >
> >  Does this fix the test for you?
> >
> >  Martin
>
> Hopefully it would ;-)

Heh, yeah, I feel pretty confident it should, but testing beats
believing, and I don't have access to a NonStop box. ;-)

Martin
