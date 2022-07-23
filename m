Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A3DC43334
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 03:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiGWDye (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 23:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGWDyb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 23:54:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6905C341
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 20:54:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id z23so11523148eju.8
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 20:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfqXwSiWjMe6/tP0mxwPHKfhrwpxyqfQ8fX2d8sTawo=;
        b=aMUml/opcNdw5PNTAdCH1xjMPgVqlVN+d4l4WE/U8x9DNKavujSd6Iugux+uDPRxNL
         a13pIYro2WkKnMpJUhmsFyH1eDauhH+QLMqAosCuw4uZscPjb5RPbmsmfRvb4ai/krMf
         lC9Rpalu4nphiW6/u7UoL5Q2VqN4GpmWZomwPS5w+SUrWpuLe7sifBQJCo1KpC5S/1oQ
         EvTg4rneIZzTt3q2xjR5h4s1aSVB4bWHTzOOueLcEoBXS3iTe2zvBvsEhc/Vd95bP1WH
         +tGX4ooZQtJdTWWeIqcNTZcfQ3t1o9SRGsQsR8M8RA9RRQHz3IiNWJxv2LytzKr5g/q8
         +TCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfqXwSiWjMe6/tP0mxwPHKfhrwpxyqfQ8fX2d8sTawo=;
        b=Ujr9vwX/9ZghmB13an/WiZ9RMDHuvx26/MHxfVQP4jSiH4wNfaXZhLizDuDvjR4Qr4
         7fS/1M9m/zTayAjEHE5Kal1pX2E2Xgmk9HagUPngf65uJRIGAy2oIXCOxpWCqVv8rEEM
         xBaooS8VjfPLvpEZU3kMSmQ0diKhqNceeb6XwkbCV6lT50hw9Kci23z7zEJkTVkvqQ0F
         jF+C2BZGgVjDyobAX+oLnExmnPk3ufIeSaAAREGQnBtIbnXknKwN9p4CaqtikDC166P9
         1uedcvMnwUbDydQKrhD/74wl0DZ/BBHtbVfrrUENdIAchGVfvm1NVeS8MoCuD9cH8ZH4
         1CNw==
X-Gm-Message-State: AJIora9k6dFJwqexHSty+45+tznx60r+CZ4n8+zV7GH76m1Fl9K7G6fU
        aopus9FD0CIx035rZIKZdjGyMuh5zDQ85zP5YLI=
X-Google-Smtp-Source: AGRyM1uICKfQxjHNwz0BncBjIGSTT5ZAvj1WHQrHTfQq5zAGB4sV50TwifmQ6Wh5ifPsZjE8w2e4OyFW7e0Jk3Q5yOs=
X-Received: by 2002:a17:906:ef90:b0:72b:50d5:7383 with SMTP id
 ze16-20020a170906ef9000b0072b50d57383mr2174863ejb.485.1658548469211; Fri, 22
 Jul 2022 20:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <822787da-bc26-0d72-a5c4-808a3d10126e@gmail.com>
 <YtPtQ6qsIviyTBF2@zbox.drbeat.li> <158251f2-9fa4-45b7-4c24-907c94602b6e@gmail.com>
 <CAPx1Gvc6ci1CjhL-zjwqkR=4o2yQTrT0V_Hb9bUBNuaBn47M8A@mail.gmail.com> <ccbc1e81-b406-9e73-7aa5-956ffae7074b@gmail.com>
In-Reply-To: <ccbc1e81-b406-9e73-7aa5-956ffae7074b@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Fri, 22 Jul 2022 20:54:17 -0700
Message-ID: <CAPx1GvceFLRL_O5zYW98tPdNV9S_Y=fChJafsq+HGkEYixKsZA@mail.gmail.com>
Subject: Re: 'git clone,' build makes user non-writable files (should be
 option keep user-writable)
To:     David Chmelik <davidnchmelik@gmail.com>
Cc:     git-l <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 5:29 PM David Chmelik <davidnchmelik@gmail.com> wrote:
> On 7/22/22 10:40 AM, Chris Torek wrote:
> > All true.  But Git has no control over, or affect on these: Git does
> > not attempt to affect ownership or permission of any build products
> > at all.  Git only attempts to affect the execute permission of
> > specific files as directed by the committed file mode (and provided
> > `core.filemode` is enabled).
> Not even projects' .git* subdirectories?  They typically are/become
> user-non-writable though deletable with several/many confirmations so I
> usually sudo (recommended against).

Ah, I thought you were (and I definitely was) talking only about the
*build products*. The stuff inside `.git` itself: some of that, Git does set
to non-writable. There is no need to use `sudo` though: a simple
"rm -rf .git" will blow away the Git repository itself.  However:

> I'd rather opt-out of .git* subdirectories for every clone.

In that case, *don't run `git clone in the first place*. The purpose of
`git clone` is to get you the entire repository. If you want a single working
tree, use `git archive` to make an archive from the commit you want,
and extract that archive to get the tree you want, without getting all
the *other* revisions.

Chris
