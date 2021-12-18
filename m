Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFABC433EF
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 10:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhLRKJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Dec 2021 05:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhLRKJs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Dec 2021 05:09:48 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5B6C061574
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 02:09:47 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 13so7152217ljj.11
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 02:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BI7+llnAxCJGTrrUUHhKfjnvm1G6FkdO0ZTdv3eUPCc=;
        b=QgWXRBUeYbzymEE7e5bf8WhrgIXS1OGmWhb325l5ffD4YIT23nVdLUBUc7xtCdpCNt
         hu4PYNs8UFKGTHR8xF2tJDBAHc+evH8UVQJQVw/ZoIA7tIDeAlRkUV2Sdz1RY9sC2SnK
         RPqmPGs759ZmoGZVzSPfk98dL5FsQnt2yPNn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BI7+llnAxCJGTrrUUHhKfjnvm1G6FkdO0ZTdv3eUPCc=;
        b=pS6mv1QPB3haxewrMj4tmkxtWaDT4jcznGG/R7ef6jAk7J+XCfVsg/G0xmjZCLOE2l
         B0Q4HV+bvVMz5vVxL+7Eh7+Ot2s88lIRGxFfVjsCB81R0A824dDZMv11W+HoHt4mlN0P
         49qHGqIoyS7/Z72Tcyo2L9wLTn2G0jVzbmN+BgoCoxf+QAQhp5d2TfF+WYaaCEFJ0gzT
         b5ZP1Bg7hhRGysWnjPJPGPyuKGnPcz6RkWO+IEIt/+F1ZEKXmCdOmsRq2b51vqSdJdXL
         ZgPp1BDkQCC+dK/fjlnYk1iKP1VJVwZL9Jx3/iZM50vmRtS0ULzux20bdPppA8cv9hRU
         Z15A==
X-Gm-Message-State: AOAM5306XYs5zGwzRPb6VgAzwP/b8FygZk5uKpURPGCteqH+zd9iZ2kS
        gOua6yYZCHu6KB0LCksqfbjNVIhZB9W86BGVybB2gQ==
X-Google-Smtp-Source: ABdhPJxL8IRO1s7Cs/04vK8knKU47+kKxtCktsjA8XJn1gtmLCU4ME1TAlXrYAfIgi9PYMUWo8MO9dFmy5kAHr7/NNE=
X-Received: by 2002:a05:651c:1687:: with SMTP id bd7mr6515740ljb.305.1639822185700;
 Sat, 18 Dec 2021 02:09:45 -0800 (PST)
MIME-Version: 1.0
References: <20211217203856.2339161-1-jholdsworth@nvidia.com>
 <20211217203856.2339161-2-jholdsworth@nvidia.com> <39F3A9A9-AE61-4C2E-AA66-6B072634D91E@gmail.com>
In-Reply-To: <39F3A9A9-AE61-4C2E-AA66-6B072634D91E@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sat, 18 Dec 2021 10:09:34 +0000
Message-ID: <CAE5ih7_knaVsxYBkWrJO4+jURM02E98iL9juroahW0k=ZF7Oiw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] git-p4: print size values in appropriate units
To:     Joachim Kuebart <joachim.kuebart@gmail.com>
Cc:     Joel Holdsworth <jholdsworth@nvidia.com>,
        Git Users <git@vger.kernel.org>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 18 Dec 2021 at 07:44, Joachim Kuebart <joachim.kuebart@gmail.com> wrote:
>
>
>
> > On 17 Dec 2021, at 21:38, Joel Holdsworth <jholdsworth@nvidia.com> wrote:
> >
> > git-p4.py | 22 +++++++++++++++++-----
> > 1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/git-p4.py b/git-p4.py
> > index 2b4500226a..4d8a249b85 100755
> > --- a/git-p4.py
> > +++ b/git-p4.py
> > @@ -56,6 +56,16 @@
> >
> > p4_access_checked = False
> >
> > +def format_size_human_readable(num):
> > +    """ Returns a number of units (typically bytes) formatted as a human-readable
> > +        string.
> > +    """
> > +    for unit in ["", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi"]:
> > +        if abs(num) < 1024.0:
> > +            return "{:3.1f} {}B".format(num, unit)
> > +        num /= 1024.0
> > +    return "{:.1f} Yi{}B".format(num)
>
> This now has an extra pair of braces.
>
> Cheers,
> Joachim

It also seems to add some slightly spurious floating point precision.
For example, 1<<20 comes out as "1.0 MiB" and 50 bytes comes out as
"50.0 B".

There's actually an older python2->python3 conversion bug going on here.

The code uses:

    Size / 1024 / 1024

With python2 that came out as an integer, which for bytes is what you want.
For python3 it comes out as a float - it should have been converted to
Size // 1024 // 1024.

I guess Joel was trying to preserve that original bug, but really we
should just fix it!

Overall I think this would definitely be an improvement, just needs to
drop the spurious precision (and fix the return for values beyond ZiB
as noted by Joachim).

Luke
