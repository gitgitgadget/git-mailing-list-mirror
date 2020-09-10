Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E48FC433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 02:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D325A21D40
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 02:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lufia-org.20150623.gappssmtp.com header.i=@lufia-org.20150623.gappssmtp.com header.b="y7hdj7AD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbgIJCAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbgIJByb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 21:54:31 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7465CC06134B
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 17:35:56 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id nw23so6156787ejb.4
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 17:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lufia-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0ULL4dLCx4B2UD26X9wsvj8SeopXu+E+4KRUEZJttjs=;
        b=y7hdj7ADn64SnzXvdjqaXDYA7+QXtolmKkok9xOk4U7YQ56sCLpxL4xzqGx4PDGvpv
         PZjzWgwL49lM5LEJ8uxlB3kn5ow6q5HWMs0MARKqgB66RFPGjTD9Z8zmeOYgv3RmpEfD
         ViPMSKE+sJlTv8E6VdMth2EqQXzC5YS4P9tX16Sij5/NbOqnjXlMQfXrNpnAx2fHhhAT
         En4Mpmi56ysiMKGD2XQfc6pkGCS1YAcYnxYyoRLAgoOoDpsFkUNEIFjkV5IdoGcmc2Zp
         I17K9XOeAgOmAI+oxQx2fUZuOFby1odCKq4CaSo23Pe5mFyQtpM78S7ohAzEm5pojZV5
         C3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0ULL4dLCx4B2UD26X9wsvj8SeopXu+E+4KRUEZJttjs=;
        b=HZ3pKsDZ5/P+3nh9gbf2Nndc20VhqL1PKLVOJLudlVLQeBwbJdOI99dm5oG8bWDcDq
         bhw4K1Do6/VlHeGHFyQ91Y/Fg8fTsbRnEZ00Gc9oqXDI20w7oQCDBYlG0670XNZ5b2TN
         R4j2FUxIQE+0SuMESLs/xiGSIZ/QpMiGwl+gNZJF2dsNT7ureSWenQ4yQXOx0j/ptYXk
         f9eFe8mczCjcpeWCmVqy2qqtu3azTPXJ04SwLmYYMHDaowUc+bPy0aiJ/POgdyNIlex9
         yg/8XDgdspHY/oEn9jeLIK34NZWq4wVLuWQNgnOutiTedfor/GBnTECwPFgwCtr3OsUw
         T6aA==
X-Gm-Message-State: AOAM533J+bG0Ca1jHC3nf5xXTtyFNoODMKoqB7P7dL6oa/92h/clZh3h
        0jmyYz0wEmn3AqhW2cFKlLvDoGeTKB07mB58l5E++J8KPXhSxAqHq3E=
X-Google-Smtp-Source: ABdhPJwDeYLGx80/Fw21hDgD3rCqNeipvnfRL1eEOdmKmh3VxZb/0eNo+4azW61cXQsEukcOcDU11gVtz/2Rix8uig4=
X-Received: by 2002:a17:906:ce3b:: with SMTP id sd27mr6218685ejb.433.1599698150457;
 Wed, 09 Sep 2020 17:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
 <pull.694.v2.git.1599680861.gitgitgadget@gmail.com> <c850888c25d4d1e1c6b0ca40ab4638462c1649fa.1599680861.git.gitgitgadget@gmail.com>
 <CAPig+cQ_KCAGpmfBAymBefB2JSVpw0-bk5HOnm41=SpADEyDnA@mail.gmail.com>
In-Reply-To: <CAPig+cQ_KCAGpmfBAymBefB2JSVpw0-bk5HOnm41=SpADEyDnA@mail.gmail.com>
From:   Kyohei Kadota <lufia@lufia.org>
Date:   Thu, 10 Sep 2020 09:35:39 +0900
Message-ID: <CAFMepc=wvY3zycHbJkX3Av55SgCPLExnqaxEUP_F403KTsz49A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Fit to Plan 9's ANSI/POSIX compatibility layer
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your review!

2020=E5=B9=B49=E6=9C=8810=E6=97=A5(=E6=9C=A8) 4:56 Eric Sunshine <sunshine@=
sunshineco.com>:
>
> On Wed, Sep 9, 2020 at 3:48 PM Kyohei Kadota via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > And its sed(1)'s label is limited to maximum seven characters.
> > Therefore I replaced some labels to drop a character.
> >
> > * close -> cl
> > * continue -> cont (cnt is used for count)
> > * line -> ln
> > * hered -> hdoc
> > * shell -> sh
> > * string -> str
>
> These are reasonable. "cl" feels a little odd, but I can't think of
> anything better.
>
> > diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> > @@ -24,7 +24,7 @@ category_list () {
> >  get_synopsis () {
> >         sed -n '
> > -               /^NAME/,/'"$1"'/H
> > +               /^NAME/,/'"$1"'/h
>
> This change is not mentioned in the commit message. "H" and "h" are
> very different commands, so it's difficult, at a glance, to tell if
> this change is even valid. Some explanation in the commit message
> would help (if it is indeed valid).

I missed, this change was not needed. It is remnants of trial and error.
