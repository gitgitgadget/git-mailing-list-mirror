Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE5EC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 14:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6FCE2072F
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 14:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duWj7+AR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgFJOwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgFJOwA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 10:52:00 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC23C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 07:52:00 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id a3so2316687oid.4
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wwTucCk0Sfr182Q4fLGz+4D6C1VZxwj9Gwcvaw2uXtA=;
        b=duWj7+ARq/J0byx6xPi42J7cpGLdGpgZGhRtmB1Bj6rFaW25iHaPPYIHZphSd21KC6
         CuWuj0TY6x8jTC9DBfUWRPgrZKMvCcPe13jvdVqZxWBrsMSFaACN2iJr3ZQipTqAEi3M
         8TPrR5huV2suYG3RhojCgUCY4wX9+fDnEYYqSuZVhz1PPHHWPa0IeNzHY5T1qoEfF9JF
         oO05bKYMMuuSoHPIGGyNwYE02+w1QfMjb+7BaPKkb6tK1B7yzK594o6BRnPvXtKwCReO
         teDvwivNHK8biiZAyZTtTfz94wUtBTwIcoROQs7xdCScaFkkj7fyHmRZzIx0X4tm7DJs
         8DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wwTucCk0Sfr182Q4fLGz+4D6C1VZxwj9Gwcvaw2uXtA=;
        b=dJ5RvdUrzrXgZ5nkXpy3dibug/2TCv4FsC9H6NFIIliDSnXm/nagS1PH5udi3nFe4I
         AYN71cLjovfm39pYfaBmRndb0kUlmt2fAa0mDtE5zzgA0GPy+hEcwr9NccMXwvkeOWkt
         9GlxEBIwUXHLYtqb2CKQ8GWMg4r4MhJYKBySPJD2135A083fhvyvO5Fkq4m5Vjtnwsv+
         m7G5KHvHUTgMTzYwZZ7tcW384fxoMvM+0aFXuD7c4VyifYMR4FkTNqpnfBBixHOVDqB0
         n6Tf/Q3iRPVaj8Xzdr5GADx5Do6frE2tIOOi4L7ZrCXraMAfurJQAYwK7Y3EBD38kHJ4
         W4lA==
X-Gm-Message-State: AOAM5323g7GlePIrY8R5wo2Ph8vBE/pP8azyik97/YSLi/Xsaw5mNQwy
        U8H/qtndxgDXPTJ551YXRCMcjc3M5zTEzSNllyT0eaRb
X-Google-Smtp-Source: ABdhPJxF2FlL9K3I46wnDZEJ7+xrKlQuQF1RjyGid5L3NnSpR/YGZBfETeJ0cavP5/mJNX4hhAL1QB8wRQiBCRUYsoA=
X-Received: by 2002:aca:ed03:: with SMTP id l3mr2652110oih.155.1591800719779;
 Wed, 10 Jun 2020 07:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <CACPiFCJKvnDL9Xj1Xs0RCvuhymjDz4N0hT42dNtBQxp+TLiPaw@mail.gmail.com>
 <20200609231336.GQ6569@camp.crustytoothpaste.net> <CACPiFCK0h0LfdyE6Q=UJkuX+Qdb=rULcgDJwgxQ0w-1O0zpMew@mail.gmail.com>
 <20200610143404.5sgww2fmsouubloj@tb-raspi4>
In-Reply-To: <20200610143404.5sgww2fmsouubloj@tb-raspi4>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Wed, 10 Jun 2020 10:51:48 -0400
Message-ID: <CACPiFCJe=LR7cUWyUjq4cCOrnGZ+9iPZspF_mtswN+Y2rOtO+A@mail.gmail.com>
Subject: Re: osx autocrlf sanity?
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 10:34 AM Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
> There is only one way out of this dilemma:
> renormalize the line endings in the repo (and live a happier life ;-)

that's not a useful answer for me.

git used to be extremely good treating all files as a bag of bytes,
not trying to interpret them. How can I get that?

regards,


m
--=20
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
