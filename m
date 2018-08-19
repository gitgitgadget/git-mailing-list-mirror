Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD5461F954
	for <e@80x24.org>; Sun, 19 Aug 2018 05:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbeHSIUe (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 04:20:34 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:35100 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeHSIUe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 04:20:34 -0400
Received: by mail-io0-f169.google.com with SMTP id w11-v6so10080491iob.2
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 22:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZxVEaEsIKmZq7N++Wpr/XqlG8VrSfjSTDOVcUMAHZIg=;
        b=AKmk1uyuUWL5LvlBHL3kde9NncyU6g5CNTgx8szJHQPcO40nfuo+s23cjg222aLvnc
         UhPD2pgo4iHrOvj1+9V4xiIw6pUpRSgLXKt5pbO6YbwtAsXVZCw5IUIBR39hMuWnrNVD
         cLgXAOZXS6tOmRe87ma3QZHPkeQKmxIiXjjYe2sEp65ylqSs6b9OprD7C78F0GVXcTjU
         Gzdd4VluJ5F66Gn0vG9PBhsAcy5082cBkgJWbhzpVSXImW2kXotTQddLjiGHrdJRFi6V
         DYT01SrL6cF15k0ieWnvtOX74RGz2Zm+y44VnrK+zmpFisTH0M/avjrK/ZgYm+tWwYme
         Y7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZxVEaEsIKmZq7N++Wpr/XqlG8VrSfjSTDOVcUMAHZIg=;
        b=PVSBBFzO+ncT0DU/m5AO3HGqtPAOblq97846FBGVGJueUVsVBCqTaeCvhoY+99L9gp
         Qybzfo4UEiK7Sn6BoSKmU1nikB4qW9uWSKU4+SGkoGsDI+9cAVU9PjnACCXQZEGR9y7T
         URFq9X8I9hJTJdneP6yC90KEwyNbMESaYVusKPlubYJnYqUcBaG5LNrDpyMFBAJQ+qSt
         vE1zLVnq3x0ND5TkIZR1IlaWzq8m/Evgq3+l4JqHv3AazYJTQZ+SXqtju4xkguftOs1p
         0x/gOIBygF17glfTXApR4Gtz9dCbhq0D0JzkOMuMTEiNeRLBRN2+Jjy2gK2akXf8svt2
         bUhw==
X-Gm-Message-State: AOUpUlG1Y97ioWRHhhzzRx778REneK0qK9QYGfBnGW82xFDmnNbyz/Am
        avA/QrCruacmmog1E/6CreEJ1SRk7y6SzqXcDoE=
X-Google-Smtp-Source: AA+uWPzzjajbynn3RTbXX75DvHYNqku3E9hjmOmCQhWGtY3lMLVgE1aCcsbbrud2Lqq4dOtwIar31DN4Adx7bFrbkMg=
X-Received: by 2002:a6b:8f4b:: with SMTP id r72-v6mr34260993iod.118.1534655421132;
 Sat, 18 Aug 2018 22:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180812081551.27927-1-pclouds@gmail.com> <20180818144128.19361-1-pclouds@gmail.com>
 <CABPp-BEK-oFWBbjgZBCDaixtmnxrTYtvHnPeT5enHBr9XJ8fGg@mail.gmail.com>
In-Reply-To: <CABPp-BEK-oFWBbjgZBCDaixtmnxrTYtvHnPeT5enHBr9XJ8fGg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 19 Aug 2018 07:09:53 +0200
Message-ID: <CACsJy8AmX48=2N-MsXcnaFrCybArj8YaCpc7+LvahUQQBvSXAQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Speed up unpack_trees()
To:     Elijah Newren <newren@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 19, 2018 at 12:01 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Sat, Aug 18, 2018 at 7:41 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
> >
> > v5 fixes some minor comments from round 4 and a big mistake in 5/5.
> > Junio's scary feeling turns out true. There is a missing invalidation
> > in keep_entry() which is not added in 6/7. 7/7 makes sure that similar
>
> I'm having trouble parsing this.  Did you mean "...which is now
> added..."?

Oops. Yes.

>  Also, if 6/7 represents a fix to the "big mistake in 5/5",
> why is 6/7 separate from 5/7 instead of squashed in?

I felt that was cramming up too much in the commit message. But if
it's the right thing to do, I'll reroll and combine 5/7 and 6/7 .
--=20
Duy
