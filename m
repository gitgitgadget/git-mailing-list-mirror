Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B1BC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6139D61077
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241823AbhDSTud (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 15:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239315AbhDSTuc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 15:50:32 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E16C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 12:50:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u25so2474139ljg.7
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 12:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1eXU9UHOChKg8kla6r39mJOAwKdZxqeBtRcbKBV5Vfw=;
        b=gPaoj40NiSk0Ggq21SNSqhWTFpjAoobVel0tfN7AzEd901blygWP0dpWMVVHe4cwP/
         24x7WxRtPmUVZlaOmFHDr3ztqJXWYRAEWramuqmJUWE3EzESKIhJPDMLaRN+wLxL4Qit
         EuDNkzWhCUGFFadovrrV/6evP3c+DkhNOK1ffqhJ1z/G9jb7blDxFHjEFWzRTjvMK64K
         DH/suABBR7QE73oQuRCBWEXl0TddZUQ1C/qMSxJ3IN25rftIDqgHJgy+4ZhV2WgFm3+z
         5GkHbiCrnHw8iYnUd/8PH6H64stT45j+YC+q+i4i9/TZJ1TqEffx5+g9DBD2CAxnmL6P
         1plA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1eXU9UHOChKg8kla6r39mJOAwKdZxqeBtRcbKBV5Vfw=;
        b=Ff86Rbe7AMy7H5Tf8ht4z7lkV5XOZT8C8VwVmAd2MjcYL7+gAKsDXOVL3M7CHXVBeb
         Q3rK0NsQ5VjV/HrIIwNf1te4kpnVUQHZifGb8LSvHLok/I6zUYlAUaz6hWE1vvLg9x/D
         m71UGE277lKLrtUlcubDjGy7JcwUigWErzKJI7O/eVPm8jPvGBOJgd4c5tQek76UIJm4
         GhjNkzcEs5pB1eGyTfYQL55jJMjtT3+UUMF4M9wAWM4WKOViXiun7swy+cRNqypPieky
         LmxuAIw4acebF1/kx+5eDX7IEKn6cmY/LFYu6M406s6iSnwH/pmrod3FDb3JVINZ2G+x
         /JRQ==
X-Gm-Message-State: AOAM532qXCCo04sLPhAh/wXFCzc95Eshqe+D3A3JlJhzf5JFk31h+1sx
        r2FyPnsrPhtCTRtiMsYjZWTc2lFcwQ+y7SzaAdk=
X-Google-Smtp-Source: ABdhPJz5CoVmP6Kmug8mRKd/b3ms/E9g3IjHXwN9I5qVi0ZrGN075d5FwKaqM8U3N8MDS4HmjZxUjGx1ZlgoDtIXrQ8=
X-Received: by 2002:a2e:a172:: with SMTP id u18mr12521248ljl.382.1618861799948;
 Mon, 19 Apr 2021 12:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <YHaIBvl6Mf7ztJB3@google.com> <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
 <87fszn48lh.fsf@evledraar.gmail.com> <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
 <20210419193600.GA19186@dcvr>
In-Reply-To: <20210419193600.GA19186@dcvr>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Mon, 19 Apr 2021 21:49:46 +0200
Message-ID: <CAHGBnuOv5PvCcKqed-sTOs2uxyuhRS7RDF4XvzPu9oHpyroasQ@mail.gmail.com>
Subject: Re: Pain points in Git's patch flow
To:     Eric Wong <e@80x24.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        patchwork@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 9:36 PM Eric Wong <e@80x24.org> wrote:

> > Also, I wouldn't say I "gave up in frustration". It was a mostly
> > unemotional decision on which of the many OSS projects I contribute to
> > my rare spare time is spent best.
>
> I guess some things aren't for everybody.  When I started
> git-svn, I never expected git to be the right tool for others.
> I figured most folks could just continue using SVN since they
> seem to like centralized things or at least have some sort of
> "authority" to look to.
>
> I'm largely uninvolved with git nowadays since I'm reasonably
> satisfied with how it works; that and I prefer scripting
> languages rather than ahead-of-time languages.

True, since quite a while I'm also at a point where I'm satisfied with
how Git (for Windows) works, so I also ceased to see the need to
contribute. That's indeed another reason I forgot to mention.

> To watch a particular filename, the "dfn:" prefix may be used.
> The prefixes supported for a particular instance are documented in
> <https://public-inbox.org/git/_/text/help/>, and you
> can watch multiple files by combining with "OR".

Thanks for pointing out these interesting features, I wasn't aware of them.

> I don't think any sort of radicle "flag day" or tool mandate is
> going to fly.  I seem to recall at least one prominent Linux
> kernel hacker doesn't even use git; though I'm not sure if
> that's still the case.

Like you said in the beginning, I guess some things aren't for everybody.

> Email is already well-established with a good amount of small
> players, and plain-text is relatively inexpensive.  So it seems
> best to build off the only halfway-decentralized thing we have
> in wide use, rather than trying to start from scratch.

While I can understand that conservative approach for a community
around a tool as important as Git, I still fear that only ever
sticking to technology that is already in wide use will hinder to look
over the rim of the tea cup.

-- 
Sebastian Schuberth
