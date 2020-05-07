Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7102C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 04:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB953207DD
	for <git@archiver.kernel.org>; Thu,  7 May 2020 04:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTeUwEhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgEGEMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 00:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725601AbgEGEMS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 00:12:18 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1DEC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 21:12:18 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e8so761902ilm.7
        for <git@vger.kernel.org>; Wed, 06 May 2020 21:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=AsogCBQpLzw1fSOp10rU36jIm/dcmLbjOnrNzLBljTE=;
        b=aTeUwEhc93FG4bXqwViKxRa5V14364w8/YHuqpWskfPvJrGk5KKt8pOy5pibpqg4ur
         zfkdanPVNaGJlySKk56rJ/xMzENIzbgXSUfnCnWQxFtb/Bzj4XldJNG1rouHScJ53Amd
         JefdxCIn3+Ksjqv1JONUv6OP7QuYLQdz9ZaevsfLu6TNUySchNaef9iVqWNHPHT7hrwe
         VS1RdDb2sDsFesZZ10qV75//5ffavULCFyywjhzmoK1I6itPIvCMa5AnWSPDlIOO8Tgx
         vvjH37RgRPSoIOHThpfDLMg4VmB/1S/wSTEeo7l2qnUXgzmknj9+JV37utaMjvYtcO0H
         mT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=AsogCBQpLzw1fSOp10rU36jIm/dcmLbjOnrNzLBljTE=;
        b=ljZ3HvR0nYNGEJQvLoASSHEvQwmdrVr4GAk1DVY6rCWgZLl6VN3cdqxDGIptWi+d1Y
         nXUk8ahhf1LNiBKtDtHxJPf3WfCT202c9H6zWUycf+bsQb70ZfCSlCiOrtS0OkVs8xnV
         5Pm3KTr1hSnYXuM5iY7N/V/53tc9/F2GdSQ6uALdyYxfCE7he+y4rgu/E87oZ+QwVuc8
         hGhXEj6+04/ejBhyAb0xHR/2xzgCN7kEwZYFSW7Hwcnm8YWnPUj2c4h245CX7Rsm0wr1
         G1Fh3O5MM1HTFejq+AFe3ed58adzJagK6pVITWMFfGjglNKRhiXHQq5ZcAv68rnuZ+Dp
         Ir0g==
X-Gm-Message-State: AGi0PubDIy4h50fhq05qIPYzhO8l5aDmO1QO2HDHqk8cGFoQm2H9/RYS
        v79/P/rjG2eydvpgDEjwLM0XVsdy1GYmJ4jsVKY=
X-Google-Smtp-Source: APiQypIR/bkTDX/1aOhXVcbFk2TF/ozmhRxrXdT25LiagcHWrq1sy22mWh0L1hQJOsVZVhQZHEGidGmW/wcu+Js8z54=
X-Received: by 2002:a92:3652:: with SMTP id d18mr12372889ilf.212.1588824737648;
 Wed, 06 May 2020 21:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8myTMOetxgaj1wt0MbvSQ0LSRV0FHz4ywsBM1zzhUQG=w@mail.gmail.com>
 <20200504165214.GF86805@Carlos-MBP> <CAPig+cSPXqvFg3-25aDzptuVOHmqOcnmsCKHgjMB9poPyJR2gw@mail.gmail.com>
 <20200504190830.g2tlrognjw6ddipo@tb-raspi4> <CAH8yC8=zsbXDVV99tdBMHwEhr-=dO=wrwBYZi=0J8iFmUHkk=g@mail.gmail.com>
 <20200504201944.gh3zykhil3txdwnk@tb-raspi4> <CAH8yC8mLvG-wqrws6fnXdnuoLAoDfPqgynG9MKoSnJLhPCYu+A@mail.gmail.com>
 <CAH8yC8nyg6pRStrQxkO6DzqRbLhhza0vx1U1cGUV4P4MQ3jZ7Q@mail.gmail.com>
 <20200505041033.w2q7h5k7otetfrus@tb-raspi4> <A6880B7C-78B7-4D90-91E3-1CED85325FF2@me.com>
 <CAH8yC8nZSWSHzMiY+L4kC8OSZu9GV6H82SyvSAOqw0zX6J4xbQ@mail.gmail.com>
In-Reply-To: <CAH8yC8nZSWSHzMiY+L4kC8OSZu9GV6H82SyvSAOqw0zX6J4xbQ@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 7 May 2020 00:12:04 -0400
Message-ID: <CAH8yC8maYWBGgNHX8AAwVNe+dxEwpD6yXPaFd822wPmAGaUPCA@mail.gmail.com>
Subject: Re: Git 2.26.2 and failed self tests on OS X
To:     Philippe Blain <philippe.blain@me.com>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 6, 2020 at 4:36 PM Jeffrey Walton <noloader@gmail.com> wrote:
>
> On Tue, May 5, 2020 at 8:26 AM Philippe Blain <philippe.blain@me.com> wrote:
> >  ...
> > > I am not an iconv expert - and don't intend to become one.
> > > The UTF-8-MAC conversion does probably only exist in the
> > > code for iconv shipped on Mac OS - so it could happen that this
> > > code is not open source.
> >
> > Yes, this encoding only exists in the Apple fork of iconv,
> > which is open-source (probably because of the original
> > license); tarballs can be found at [2]. However in typical Apple fashion
> > the versioning of their iconv fork is kind of undecipherable and hard to relate to the
> > upstream iconv versioning.
> >
> > Also, I searched the iconv mailing list [3] when I came across this error and the consensus
> > seemed to be that they do not intend to add this encoding upstream.
> >
> > [1] https://github.com/conda-forge/git-feedstock/issues/50
> > [2] https://opensource.apple.com/tarballs/libiconv/
> > [3] https://lists.gnu.org/archive/cgi-bin/namazu.cgi?query=utf-8-mac&submit=Search%21&idxname=bug-gnu-libiconv&max=20&result=normal&sort=score
>
> Thanks Phillipe.
>
> I found two sources for libiconv with UTF-8-Mac. First is a GitHub at
> https://github.com/fumiyas/libiconv-utf8mac. The second is the
> opensource.apple.com link you provided at [2].
>
> The GitHub claims to be layered on top of libiconv 1.16, but I was not
> able to get a working tarball from it. It looks like Apple's
> libiconv-59.tar.gz is the answer to this problem.

I had to punt on Apple's port. libiconv-59.tar.gz is libiconv-1.11. It
is too old to be useful.

libiconv-utf8mac is based on libiconv-1.16 and worked fine. It took my
patches after I figured out the complete procedure. On the upside,
libiconv-utf8mac works on Linux and Solaris too. So there is support
for UTF-8-Mac if needed.

Jeff
