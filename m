Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4FCC5ACD7
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 16:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC362076C
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 16:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=economicmodeling-com.20150623.gappssmtp.com header.i=@economicmodeling-com.20150623.gappssmtp.com header.b="CulX6tOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCRQCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:02:34 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34511 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCRQCe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 12:02:34 -0400
Received: by mail-il1-f196.google.com with SMTP id c8so24219550ilm.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 09:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=economicmodeling-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=bubyOQaUju3ub0sIroqgOIy/keO4bVUNbwdXqzq7ErU=;
        b=CulX6tOZCr/UxpsHKLjRBt+2fWtvVa23K2l4WfqEYk5ms4LA8ujH9MbnILFV1AnqUb
         gP3Grt8vGES3qS86l/AL1n9rg07QsDTPDapFqdF07R3DX4qebCjXsSUrC1xJ9i/nU3B5
         M+s53xL5G+JHzCyi4qUlaXLbxBXyUUTK2sQtqv1kyfp8hdxz1A+7P5vEJ6tup8PMtU6X
         MM4AeuTrXa/fiBG45Eqbdo9ZNo9pgRi67wM4MdzSTzSdSYxglVgvDM3z/aP/snC0JgpS
         9bocTqAqEr6IQV5ONp1H2HLYQLUDDhSQQqxmGbZmGkcTeBdnmrdK67HcpplBU2LvX80N
         m4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=bubyOQaUju3ub0sIroqgOIy/keO4bVUNbwdXqzq7ErU=;
        b=lIFID98CHBoSZvHT0B2Q3D5C/tiW4oK8j7fnEeotM8WJcxulryH7W5J3ls37yyUCZP
         RheUeO6vsBK3FovWMZiRIrQLl6rbPA6mlg9YEJ05VztE88BXEiANHnXKkcB1DljQ+Bg9
         RBVdnWADq5bXTY99Px9nnLzMHCoqo3pKHfrs554xbD+bFJTntm8rXoDcsyTMfraw41p5
         pL/L7d+Xs7TW7ZPQ7oaVatJ524Y2WIl1jAVELgiNzv8PI++dc0kv81A4nN+SUZJJnX2x
         Tuc75IyrXyvFEGv7milngCLrVfc/NL3pHLVQXIyD5MgzY/R6i3PWGBC8VPd0XibUVlmg
         k6jg==
X-Gm-Message-State: ANhLgQ1UFE98X8Kf1t/rFOnR+wcOjlvr0jPIFBC5mJvLCuAYCxuP1l1U
        7bHF7+UrtMq0UR3KBP+zIWBanNY3Mb9w0fllvU+y0P8ymw8=
X-Google-Smtp-Source: ADFU+vuv5YjigtoqD1M397QicZcwQ6PIxXoXvbtLh+YsfD1eE03XsZBLZBECkHRiF+qWUSIA5lzAB4zNHsuxlGUB0p0=
X-Received: by 2002:a92:6a10:: with SMTP id f16mr431699ilc.113.1584547350541;
 Wed, 18 Mar 2020 09:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAAjm7Ga5JOJ2w=01o1-x-80HMGVaYQQy8SBBb-zJ6MOQAe4SxQ@mail.gmail.com>
 <20200318002630.GA366567@camp.crustytoothpaste.net>
In-Reply-To: <20200318002630.GA366567@camp.crustytoothpaste.net>
From:   Benjamin Shropshire <benjamin.shropshire@economicmodeling.com>
Date:   Wed, 18 Mar 2020 09:02:18 -0700
Message-ID: <CAAjm7Gb8DdGUCfoPO+p2=YsmvFj5eoCn3jjEbwg3-hwRnt0Q9A@mail.gmail.com>
Subject: Re: Relative url values in .gitmodules confusingly sensitive to clone
 via ssh vs https.
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Benjamin Shropshire <benjamin.shropshire@economicmodeling.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 17, 2020 at 5:26 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2020-03-17 at 18:34:09, Benjamin Shropshire wrote:
> > From my perspective, this is a bug.
> >
> > If I clone a repo twice like this:
> >
> > git clone https://github.com/user/repo.git ./https
> > git clone git@github.com:user/repo.git ./ssh
> >
> > And if it contains a .gitmodules like this:
> >
> > [submodule "x"]
> >     path = xxx
> >     url = ../../different-user/something.git
> >
> > When I `git submodule update --init --recursive` in each, only the
> > HTTPS version works. the SSH version confusingly seems to try to find
> > something at ~/different-user/something.git or some other path in the
> > local file system.
> >
> > this seems consistent with the URL parsing resulting in different
> > segmentation and thus the ../../ ending up in different places:
>
> Looking at the code, it appears that we don't let you go above the top
> of the URL, which makes sense.  So we interpret it as a file system
> path.
>
> (And since this SSH format is not technically a URL, we don't have a
> root slash, which is probably why this is a problem.)
>
> Does it work if you write the following?
>
>   git clone git@github.com:/user/repo.git ./ssh

That seems to work... thought if the final resolution is telling
people to just use a particular format for the repo address, I'd vote
for telling them to use a full and proper ssh:// URL. (Technically I
think `git@host:/...` may be a protocol relative URL? or maybe that
would need to be `//git@host:/....`?)

> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204
