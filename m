Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371B4C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 06:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E1160EEA
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 06:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhHGGaX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 02:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhHGGaW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 02:30:22 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3CBC0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 23:30:04 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id o10so15222841ljp.0
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 23:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/Mi80pzlwl71E9DElmJajc5YlcHqjgiQ8AF7f/eJBk=;
        b=ieYkjZUYznExULxS2Basm1XEX1crOVT2tTYVJc6TDiL2aWXtbYRd4mxRviAAk2BhgW
         Vi68njsTYXzDDACUqblW/PSdyBUd3ObrWY+PwPNP9hDksjKKuuyAu3mx7hkseBDwKF5k
         FryjgqKV9KNQMD3DGDaL9wvtFfgzd88efkgM+mHW6j+CrgMtAyjhVIDcIpLO+Se3JeiE
         JPvIWUFYFA2O/GTz+3S+WdI5rDt8z/qscgNYxi3n03a3flEfyZmkJtSgg5g2rfLgUzrX
         iXBxYFUN7LAqEZ+dbf08eO2qxhajmFRTIim7/uiRlxO+bvJjaK2OTokL3Z7cSXqlvWaz
         Wmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/Mi80pzlwl71E9DElmJajc5YlcHqjgiQ8AF7f/eJBk=;
        b=JrRgu0btjP7GPUFDIC7vC3FmXmfiBGEv2tDO7l0kEZaE/fa1/d8kCckisP8d9aOq0F
         a//6O6Gc4YftBpqsbV5rA82axTjF9Rwh0k76EWKUq3EBuLYYUO+5DlBd9jLJaBe7TEJ3
         BL6VbbOOpYLceyZ8j30OBv1JT1Jk0cMiVKCadtj3/dVHOPhF/58ArKhNV5jSf1vEiJka
         DtsN5jxaRa5YJnDYfeuNXnbllogGb5FvCwJpLyTW58MwmOkOsvZu1Be4eZqIKgReJXmr
         PrZj3BvCHYYozOnQByRHmsyHi0EYU6YwAK5LuSv5tqMUfSYZhMf+grk43ux3cpmxIyTo
         vgAw==
X-Gm-Message-State: AOAM532rQA0YPj/J4DCAuzOjwbXj229ey9Tbw16jZxJRGdGUOth7TRgO
        krBe36WcehsWZGpEBT4j/pLbN/0ibrDcr64wI10=
X-Google-Smtp-Source: ABdhPJx+0RzZjxjiQWw1H/4tjy0Cvk7m6jUT5fG65B/qRyTZzk+EgpLreb5Q0qMYwXeXNv7mwfLHuKbaQH8iaAjd7Fo=
X-Received: by 2002:a05:651c:327:: with SMTP id b7mr9229927ljp.74.1628317803057;
 Fri, 06 Aug 2021 23:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAMMLpeR8C_gjZ0CE8-nEo7syt=t0MwMGVKw8BL0k_BTpsk2D5Q@mail.gmail.com>
 <CAPUEspik6iGd2X5tOCwvo+FNmcoipy1KGvfgNJd2KLu9-XS7Yw@mail.gmail.com>
In-Reply-To: <CAPUEspik6iGd2X5tOCwvo+FNmcoipy1KGvfgNJd2KLu9-XS7Yw@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sat, 7 Aug 2021 00:29:51 -0600
Message-ID: <CAMMLpeRDLxRfskKV0+S2CHTNVTnFgfO1K_sGQy_v6DXrA5JGcQ@mail.gmail.com>
Subject: Re: Problems with Git's Spanish translation
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, git-l10n@googlegroups.com,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 7, 2021 at 12:12 AM Carlo Arenas <carenas@gmail.com> wrote:
>
> your last version has over 5K changes and from those almost 10% seem
> to be missing from the original, so my guess would be this is indeed
> not something that could be reviewed in time for the next release
> (currently in rc1) AS-IS.

I just rebased the patch to make sure that it doesn't include any
changes that have already been made upstream.

> Before I gave up, I noticed there were indeed some where the original
> text was too mangled to be readable, so maybe focus on those first to
> make the patch more easy to digest and to get those fixes for the
> release.
>
> Some of the other ones might be added on top as independent commits
> grouped in common cases (ex: the ones adding/removing spaces, or the
> ones where a specific term has been renamed) so the full list is more
> manageable IMHO, and might even get enough reviews to be included
> sooner than later.

If that's what it takes, I'll do it, but others have submitted tiny
pull requests at https://github.com/ChrisADR/git-po/pulls and they
have been ignored too.

> PS. for example one of the first changes does ("aplicar stash" ->
> "hacer stash") for "stash" which make more sense than the direct
> translation "esconder" in this context, especially considering the
> command is called "stash" anyway, but that seem more of a personal
> preference and definitely could wait, unlike others.  having that (and
> similar changes) on its own patch allows for a discussion and
> prioritization without holding the more important changes.

"aplicar stash" literally means "apply stash", but this is incorrect:
The command runs `git stash`, not `git stash apply`. That's why I
changed it; it has nothing to do with personal preference.

-Alex
