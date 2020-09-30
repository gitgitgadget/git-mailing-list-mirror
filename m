Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB7EC4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3872065C
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF4TSgEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgI3WAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 18:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgI3WAw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 18:00:52 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDADC061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 15:00:52 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id z19so903279uap.2
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 15:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FbDX7jmFT+QNoLsxS9BBZbN1I4dLJ8SZw6dWWyXWzY=;
        b=GF4TSgEErq6KLilFlf/h6V0w01F9Suf7z5M6iR+mnuz9N+tsNXmtwriviiAGftB6oB
         ftWrFjy1QZkF2w9dgDDgtzV0aev5zul848tWb93T13aKXdgKbRKg9yhDoHSrYqMFQh1p
         EF2K/0RcGpitqHAwIxM2Nct1b5ESYKDIKb1LPDlMYctEqMWGnKoVRFQPlNQ3zOv5LGHe
         fvTSgFAwVnb2beWCdY+lQVeFZK+pxEFK1yRGJ5lWv9MTIgXlnA8XuxGs+pwUjUWGKiP8
         iSq0m4B/VHhn6vwgbtp7PLW+y6wy+YrLu+rex93d9BDM9+zNcy1hav5oI3sU9a1SY6sj
         Go/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FbDX7jmFT+QNoLsxS9BBZbN1I4dLJ8SZw6dWWyXWzY=;
        b=Ronh2c79NpeBctU739NkBNBtnK4xRNq855ZWGhHnWia4d+2faYCcQM1JY1I3ZpZbHt
         6yBH7wnoCqtSnSVnYeUFZHwvYwGLhqhbHlEmPD4Bpl6eLeParICEvm2qDpqHWRtL3CbR
         745F5DkGPdaIa+SD2HX7zBvjaKCGL3RYq81sXAr9S9I1abuSiYngj3Qv63DFg6K3umCf
         DfbWvg+Gl2iSYwsxRbhH2ml4xNC2eVt0z4Og2c6nd65TUgUkRRgCzZe1u5+kPzYCOs+l
         vUMYGExuRiFf7JE3uT+zpUDlEGfthNEOrTKq51tpNkulv9gH3Crm86rsHGl19UuHWTgq
         NrSQ==
X-Gm-Message-State: AOAM533r244UQzqdTVH2QFPsOJSRPZepE7ctsl5ABgzccijpGd5s6VG8
        h72JFfdBnukkeVSy5Ll8B3SOS8uaQtNbQtkYn+Bht1KjDmE=
X-Google-Smtp-Source: ABdhPJy8S85Rj/5Tvk2JT+WgL5CVbvFnpAJ8Kn5F3rSBJa9pXvDt8d4cG6T81Kw1bYIHZCLfPFqNoXFpoE9WyjZu0J8=
X-Received: by 2002:ab0:609:: with SMTP id f9mr2964649uaf.21.1601503251137;
 Wed, 30 Sep 2020 15:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200930212529.100458-1-jacob.e.keller@intel.com> <CAPig+cQUeQV0=LDQ_tY43k6z7km4X6Fm9JJVPUBoG=wY3gxDfw@mail.gmail.com>
In-Reply-To: <CAPig+cQUeQV0=LDQ_tY43k6z7km4X6Fm9JJVPUBoG=wY3gxDfw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 30 Sep 2020 15:00:39 -0700
Message-ID: <CA+P7+xoTXrjik5fqSN1Qndek8hyaSdTtn=88hRnxLCmRMhdQyg@mail.gmail.com>
Subject: Re: [v4] refspec: add support for negative refspecs
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 30, 2020 at 2:34 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Sep 30, 2020 at 5:26 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
> > Changes since v3
> > * removed the ?: usage (for real this time)
> >
> > +               /* Note the reversal of src and dst */
> > +               if (refspec->pattern) {
> > +                       const char *key = refspec->dst ?: refspec->src;
>
> Blorp.

.... I am very confused....   I made this change...

$git diff doesn't show anything...

Oh.. wooooops. git status has it as staged but not applied..

Sigh. I sent another round.
