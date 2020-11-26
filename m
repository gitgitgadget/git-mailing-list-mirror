Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E70C63777
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 20:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35F8721D7F
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 20:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXNPUuPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbgKZU0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 15:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbgKZU0M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 15:26:12 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258CCC0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 12:26:12 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id q68so876028uaq.3
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 12:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MY/7nwh3igpQArlD1top/miw4XD8aLkf8L41e/OL/u0=;
        b=gXNPUuPI4wIgnxNP2i6ZiclpR6DosNANOkTB4Oq09lRfZNaDxH/t7LaAysgbUwHN1Q
         FildZ+t4HWFD7CPIam4AUa6T2lQbBL8AR+BhnKWhjlFgvkjz1B9KgU+A6vHfgV8BKlWo
         BgVJlwYFgm784MY+1IgXtlVUEzRBEDektxs/Tj09/OfdLJ5dkOePEWlH4TbXb0FApxPt
         2lhVHrIXJCC7jHGhBBM4djMrUCKN/YWSVd1Qhaj+Fl49djK/8cqj7bvOYnkqc7qQcpGd
         8ir19P0PTeGHExAO8ChCCT0i0/DDu5RrlECzDeDTDsB9cr+RZGpHZOidKjaT1rKle6rI
         4ewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MY/7nwh3igpQArlD1top/miw4XD8aLkf8L41e/OL/u0=;
        b=hp4F9wWPEMkpwCdU2JNCiK2l0JQZMAuSGmi7CTfpgv+1zDmh02KpLOAM2vTVDF/rm8
         kiQnv2CgIKp+6Ix603j48OU6/IEiS5Iq8nW/YY3XZyRQdIUR3uSovXa3tVVfqEYIvRTT
         5tMs7lvgbqK5htuzlxvB/YDGL0dFHQn/4binE+fFiSKTn4Wyxdf5ISkUIq+7BPdtvf0J
         CF+6yvIy48ftvO7+76CE2kfp1dd4sSAcSrSnPl441iviyU0FbzJwyixnPdb+5tiepehG
         8UAaXDUhz8jWTIjk0iN1WV2LJqYYHPi6OAyimI5csL/QMi6e5iw1o10aaMQjtkclaEZo
         UHhQ==
X-Gm-Message-State: AOAM5321MI0C7Chn8FBfb4GHnfgLu5ir/+MvjnAPBclXuIAbLdCwrpOY
        Qnysx/usUATMz9pPTk//HlWqnLcCvOhDXGfPDg2/+M2gXJWIhA==
X-Google-Smtp-Source: ABdhPJwQYnP3wu6+gw6XLlRycroNOiJm1po8qcV1SbBLRyl1CibYQAqJAk+JM8uMWzfg23qWGxSpwU2PbQRXoqUiQGs=
X-Received: by 2002:ab0:3112:: with SMTP id e18mr3423383ual.112.1606422370243;
 Thu, 26 Nov 2020 12:26:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605972564.git.martin.agren@gmail.com> <cover.1606251357.git.martin.agren@gmail.com>
 <359355fb4eff6d99cb1baad9b72ff96e7dcda51d.1606251358.git.martin.agren@gmail.com>
 <xmqqsg8ygza7.fsf@gitster.c.googlers.com> <CAN0heSoM+qQe8BdKHVpqhA0RAqzyyL3Qr98G=O8kD504diruCg@mail.gmail.com>
 <xmqqlfepg9dq.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfepg9dq.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 26 Nov 2020 21:25:57 +0100
Message-ID: <CAN0heSp2L4Q0pcn8V5hAKzXF6szZgpGqncLNYZOq5tmM7EucOQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] grep: copy struct in one fell swoop
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 25 Nov 2020 at 08:53, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> >   /*
> >    * The instance of grep_opt that we set up here is copied by
> >    * grep_init() to be used by each individual invocation.
> >    * When populating a new field of this structure here,
> >    * be sure to think about ownership (i.e. a shallow copy in
> >    * grep_init() may not be what you want).
> >    */
>
> I find the text near the end of both my version and yours a bit
> unsatisfying.  One thing I care about is not to mislead readers to
> think that the way grep_init() copies the singleton template is
> correct and sacred and they need to design their data structure to
> be compatible with the shallow copying.  We'd want it to be clear
> that it is expected that they will deep copy the field, and release
> it once individual invocation is done, when they need a new field
> that won't work well with shallow copying.  Perhaps "may not be wnat
> you want" is explicit enough, but I dunno.

I understand your concern. Here's what I'm considering using:

  /*
   * The instance of grep_opt that we set up here is copied by
   * grep_init() to be used by each individual invocation.
   * When populating a new field of this structure here, be
   * sure to think about ownership -- e.g., you might need to
   * override the shallow copy in grep_init() with a deep copy.
   */

I'm not going into the releasing of those resources, but hopefully
that part can be left to the reader.

Other suggestions welcome, of course. I hope to get around to rerolling
this on the weekend.

Martin
