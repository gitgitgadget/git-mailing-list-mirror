Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74096C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 07:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2679F2074B
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 07:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhA0HfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 02:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbhA0HdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 02:33:16 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2C5C061574
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 23:32:35 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id a25so951111ljn.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 23:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K31HPaUO9HhpdwPhMe3VBptW/M1Hhco3a1/ior0haNM=;
        b=lX+XG3Q8BoZOFnBLQRY1Lu0NtAGCMHFUHDg2BmNe08S1yd7oxBAv0N7w3a7vR1Nbn1
         S3b/FWMIylOFJN7WsK5pPmXfPtbbMdLpOkgBouscI6EiBK6glNmp6wLIBw3QI04hDxst
         w3gkJEgC+p5VEQdYcM9wAvRSEiTwPPnvlJB4jA4tQLF4G6K+kow/e6dKOrXngMzZKrND
         cs769g8AkIjcmCgK5RnaZhY35cdZ33QE07WxymV6WXjcVLjo7MK/GgU66DoJVsoqan0I
         Mi+veOZej+RqoBRaBI3g8wiXfQCLVQtw2gkJ2D+C+kt/TX/EMnMwcpIQCxAQFAHcR4qE
         oC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K31HPaUO9HhpdwPhMe3VBptW/M1Hhco3a1/ior0haNM=;
        b=gwvzFxKgTkLmkc1fZzD+ttZnn8InGD1oSBqXrv4jtli9MMk98ocu4UrGxZt5Rz0yoo
         /dlzvpTGkSIUlw/VIqpdcE7btfeGVOqmEXjaH2jiaAuGLtjgzwqh6BFEuiJIYgDNTSQ8
         ENdH8Mxx61WWCbdZfF9sdyA+3YZSWftCHNUPk2cftsteLZGTGQqA/Y3WKfk3HVel1FSJ
         FRo+a7dfmacKtmNglYoCbZIFEIJF1YvTowWZCyx2Dqixr9ORsx4tSgzfJBwOAVXP/Ctf
         8hjFPPxDsPN/7p/B53/yl+EXsWRESkdvQjx4yWVSOFtwMEy9KrHVCr5BWkZf0B4f1ish
         r5uw==
X-Gm-Message-State: AOAM530Ng2IG2cvKouAzGZiYH8tIouUrpUe19tog1gFn8ljQURS3x5OA
        WuJ1WhNSlyGcY4zKm3E/UX6DJ+nIsr4uTOTAhxU744Peocs=
X-Google-Smtp-Source: ABdhPJzj2okoFCduTzWz5WMsmNZ5yvQ2+frNOC1kxX/sfqMk8CE+3ht5wv/WA92/nLSWn9m51M2SugvAp0Pb1Y2OCpk=
X-Received: by 2002:a2e:7d09:: with SMTP id y9mr5172544ljc.6.1611732754096;
 Tue, 26 Jan 2021 23:32:34 -0800 (PST)
MIME-Version: 1.0
References: <CALmLNPQAKzzzAUPhejvcF7SEvq4zGDDqkm6HaVi9pAfB0JjoLQ@mail.gmail.com>
 <CALmLNPTUSJvxKwDVJViZ7qETP5nGBUftdeHjEX9U7coT0Ve8yQ@mail.gmail.com>
In-Reply-To: <CALmLNPTUSJvxKwDVJViZ7qETP5nGBUftdeHjEX9U7coT0Ve8yQ@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Tue, 26 Jan 2021 23:32:23 -0800
Message-ID: <CAPx1GvcCj++vO_a4PE2sAN4=3qGat6_72BLNnAhHnQ49z7hUuw@mail.gmail.com>
Subject: Re: Bug report: gitk is no longer working on my OSX machine
To:     Dan Lew <dlew@atlassian.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 2:50 PM Dan Lew <dlew@atlassian.com> wrote:
> I have managed to figure out how to fix the issue - I removed my
> ~/.config/git/gitk. Upon recreation, everything worked fine.

Not that I know much about the internals of the objc runtime,
but this indicates a bug in wish and/or the objc runtime
(tickled *by* the geometry state line, but not in gitk itself).
Note that the corrupted autorelease pool page data:

>  magic     0x00000000 0x00000000 0x00000000 0x00000000
>  should be 0xa1a1a1a1 0x4f545541 0x454c4552 0x21455341

suggests that the page was already released or something,
since the three words of "should be" spell out "otua eler !esa"
which is "autorelease!" with byte-swapping (the old NUXI
issue but expressed in 32 bits this time).

Chris
