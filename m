Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A27EC35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0909621582
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHUSHnPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEGX2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 19:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEGX2x (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 19:28:53 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC32DC05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 16:28:52 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l19so1671523lje.10
        for <git@vger.kernel.org>; Thu, 07 May 2020 16:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Hz07uxUS0pkUZoAPAsl7wy8TvCLrrDwvGeFBrXo3vDU=;
        b=gHUSHnPch/aajwAoacxGKlWWiddrX6wq6pkBbStBsK/AFlu08nubCH5HbS044evm0j
         2lrtbQw7rH6L7UCZHWd6sG8izDuTe7WpM3AOo+q862oyhn+YT+DqXHLat2mqzwNOHmZg
         C6SwPERllMej0gPDvWwCj89+K3B8w1xeD5U2fK2fKtnfEqA7RnmXi9HiaT6PFATXd0kE
         MPLUaN1d5vQ69/voxJgOehG8WVXQFJHgQoOLG7tQhbcRgBu1o6ozV2beuYxf0MGTpYLh
         rTaPsb8YAH5Fe4teth0eCWJdf4n6oYAZas4FZQTVKAhOi4i6fjswxVflXZPBf/Y1LWVl
         h/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Hz07uxUS0pkUZoAPAsl7wy8TvCLrrDwvGeFBrXo3vDU=;
        b=tF7WVNAgoppgyc+03jIAlm3xGks4KvNCQqzSR6qpZJSxuSN9ZpkvBrSmddoXP2eWCR
         kNr/K/UrI6qBYj35HLfNwxsxLJwR0TM/B9GVVlt1Va5cQ2Xk6GYZ/zLgDEKuA2b5otve
         3NFk5bYaQgXwpeS0MliYujbWlf2mgh53P0eKZWMhCVBClkei41p0vVCdXNHzrb4wmc4Y
         JKVfA5l0jT7wc4XwGZpsOAbD6eFTtGfYiewlqRwaZ3k/cSGGotSIIIgYmUegvQu/vosO
         ivtctRsFT+9MZUElwIdFN86GQDqdjbGs/Ioox4mVj/aNE8b0c0i8wF8aoqSSQskNNAaY
         HtHQ==
X-Gm-Message-State: AGi0PuYzcdgxcPS1DXgULcnAPv48D7B8faSvPlsQ5lWgCTL06vup2dtg
        GJwSZvKcIgMZWzgppR0xxt99d/rdiFfDj96qP8E8zJKjHU0=
X-Google-Smtp-Source: APiQypJwv0E63azEpGFbB6/1e0G3YlfBhxpNVShC9HWa9d9B9x8pC/xbmthc9+w0AnBd8gdJ5KmK6Nzg6CQhCLIt1B4=
X-Received: by 2002:a05:651c:390:: with SMTP id e16mr9875371ljp.186.1588894131313;
 Thu, 07 May 2020 16:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <CA+KyZp7TELrswPjNgB99BXXHEXi5pRr5bO3g_wy7zBvv1R4Kww@mail.gmail.com>
 <xmqq1rnv2vi2.fsf@gitster.c.googlers.com> <CA+KyZp6pvqqNnOOj0ap9ekPdv9mZg2u_NQuwFgMXfwfV17SrYQ@mail.gmail.com>
 <20200507232448.GB7234@camp.crustytoothpaste.net>
In-Reply-To: <20200507232448.GB7234@camp.crustytoothpaste.net>
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Thu, 7 May 2020 16:28:40 -0700
Message-ID: <CA+KyZp4keGp8j0rzCtr0fEogZqkKwTNLvRBZ2QOUzjStP+V2uA@mail.gmail.com>
Subject: Re: check if one branch contains another branch
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alexander Mills <alexander.d.mills@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks will check that out.

This command does not seem to work :(

> git branch --contains branchB

I do this:

git checkout branchB
git commit --allow-empty -am 'empty commit message'
git checkout dev
git branch --contains branchB  ==> exit code 0
git branch --contains $(git rev-parse branchB)  ==> exit code 0

this seems like a bug or something.  Why wouldn't it exit with 1,
since it obviously does not contain that commit?
This kinda sucks tbh :(





On Thu, May 7, 2020 at 4:25 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-05-07 at 23:12:09, Alexander Mills wrote:
> > so it would be:
> >
> > feature_branch='my_branch'  # the branch that I want to ensure is
> > completely merged into origin/dev
> > git merge-base  origin/dev --is-ancestor "$feature_branch"
> >
> > that won't work?  since git merge-base only works with current branch?
>
> No, that's not the case.  You can write this:
>
>   git merge-base --is-ancestor $feature_branch origin/dev
>
> This works from any branch and exits 0 if the branch is in origin/dev
> and 1 if it is not.  In neither case does it print anything.
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204



-- 
Alexander D. Mills
New cell phone # (415)730-1805
linkedin.com/in/alexanderdmills
