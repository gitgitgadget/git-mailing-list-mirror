Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264D1C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 19:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917B324171
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 19:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JK5GtofE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405190AbgJUTkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 15:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731447AbgJUTkd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 15:40:33 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD4CC0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 12:40:33 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r9so4435411ioo.7
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 12:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRD5gcKGR+pssMmpx+l49FgFne3swD03w9M6NBZ2vqU=;
        b=JK5GtofETVSBSNugQuVM6MdOUpGHdllkeG9zsM9uD5R0OG72z8g5xsz3ulVbkYjXJW
         iLZB8P8pO5qC5DEIAAL5I+qiXskf36qga3Y8mzc37a+z+C01CpMnm2HXSaBofj38ytup
         2FS0dvsNOinON1qXMY1St5HAsPfS89SJzdLkcylcMuDQDXl5ykULHnUoxyW7aYDsoWJJ
         FpiGJuj8l5lKFPCb8g1xF0Gw5rl9+IyW09n1lzSGgJDetOPcX2srPyinfR/+bBunXTPo
         Zd+mW/JwS55N1rmarL17vFs6Dw7BDwC9/MyiYPbDpEqTAG+TpjG1Hlc7P5Nfo7S9GSGU
         rBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRD5gcKGR+pssMmpx+l49FgFne3swD03w9M6NBZ2vqU=;
        b=ef7rLaawMW3QGEzwKH9jtf5OQoosq/szaowJFn8X67PXQ7X2KBItpT2DQe6qRZSdIX
         X/HYpFLEtzqwf6g6IXL6VlDxKlDh1SnxAgQdb3zzhzPRHu2PUnQFXbCohziqIi+psVRZ
         enpThLNarl1GBe59Pgh9eVCYUg99bUtt42qR/Fv3lHX1HWS5KhohOAksOMSZDOZOz6lu
         jY7f9dDUmQgswgk5nLuntiWb3gMI4ugVNZFcCDcnMqWyhGN9p7G/Aok1nofp7h7qSYaB
         7p8GhCWwEagwILhQGBl9AnUc7HbZYzS8RWD71X0Vg4IjI8qLc4EEQALXdPJa0PXFOc5r
         Aicw==
X-Gm-Message-State: AOAM532BJDAtCqTv1VTNJ5K1+W2kxGY+7ldk/zRVowARvwesjPeaQmYc
        dfL6APKtQ+h9k0u2c7dg/Se09MWp+fB9rAekn1l4TBBCBCs=
X-Google-Smtp-Source: ABdhPJwI0GuHtRRRZb7ld94LxVHeHrbmqkBwuYqDolGYRVNVWSBSjarV/doCmjy9ronrFnQyexHnihVd3U2+j/rI5I0=
X-Received: by 2002:a5d:815a:: with SMTP id f26mr4122213ioo.111.1603309232357;
 Wed, 21 Oct 2020 12:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
 <20201021131012.20703-1-sangunb09@gmail.com> <CAPig+cSi1SSZTS86-6_0gDCeDqPCEvT+Lh3gLXe--Y1PDJSDfw@mail.gmail.com>
In-Reply-To: <CAPig+cSi1SSZTS86-6_0gDCeDqPCEvT+Lh3gLXe--Y1PDJSDfw@mail.gmail.com>
From:   Sangeeta NB <sangunb09@gmail.com>
Date:   Thu, 22 Oct 2020 01:10:21 +0530
Message-ID: <CAHjREB6Agm9Nia2+e4=1zAJ6Y3NXgPQLmN_he1353ScaznK5hQ@mail.gmail.com>
Subject: Re: [Outreachy] [PATCH v2] diff: do not show submodule with untracked
 files as "-dirty"
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

> Again, it's a judgment call whether to go with modern style or follow
> existing style of the file.
>
> Another option is to have a preparatory patch which first modernizes
> the script, and then your new tests would follow modern style. But,
> that may be outside of scope of your submission.
>
> To summarize: The only really actionable review comments are the minor
> style nits in the C code. The nits about style issues in the tests are
> judgement calls, and could be handled (by someone) at a later date.

Thanks for the feedback, Eric. I would add the style nits in the
upcoming patch.

For the style issues in the tests maybe what I can do is I can submit
another patch with this patch to modernize the test scripts of these
files? I am expecting some feedback from the community on how to
handle this.
