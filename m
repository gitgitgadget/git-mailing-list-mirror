Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2123C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 20:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06FE206A5
	for <git@archiver.kernel.org>; Mon,  4 May 2020 20:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKvy1/ZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgEDUae (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 16:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgEDUae (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 16:30:34 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DA4C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 13:30:34 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id f82so142875ilh.8
        for <git@vger.kernel.org>; Mon, 04 May 2020 13:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=02Hxagir2BP3AYYKx4Ewqr6f6ggtUYTpxP1iy3o0kvk=;
        b=OKvy1/ZCyaMr2hKMirItiIL3+rsI0DJEqlyMP0yH5VA/D1xaO0gup8MUA3FHhdwmpy
         0Nc4uFqV7HljavnNQvq095rYPCVfmft1g5E5vHb72Rkl/k0502t+ldh5k9mLX/KMtLVl
         F/5s27lydneFso8lWhO3XVyElPV8kJ3ZG0Qp7Nh5sYAr2so06nrsuOBwfmIpOZECJPcc
         sWMulepohaCJ8wniMPBgKQ3XntwkbP/fBW/hoOxS9HEZ/U7wAyL+sGAGgXMTaBB6C+do
         SDA71q3uSSoqPZ10pKZRje6Ahe46v2rfVedpc+K8+ee6ypv7S5/DBjVqYL+dLuvQkOyp
         JrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=02Hxagir2BP3AYYKx4Ewqr6f6ggtUYTpxP1iy3o0kvk=;
        b=GZBknKRc3ZFXFZSF6esBBi1YpcQb+29G/BXnDQ8xGthb6mfzsPiRnTle7eVDOscXlV
         OD2CNDfqtIXIQ5VayOPXlV14HKCWCn2tNmEVuicelQq6ag60Ell1tYBc90/HT4zN+nb3
         9qV+mljfae2/vIoXdX2h6EV54nCPn0WpGjkHlxLP5qgdig/LWH6vMvztpqYVQW47WSxH
         l+vptJKCp3ZFIlyaxE5APf23qWqpRc3acQKKZDOnCH/RdmWV93iaQZ1K1eKSxtZcSgkz
         nmZUnwo1lNVyQk6SDFmfD0dhH5EbwYk1lsGjlYacdO16mjum7NoasxJKk6D9svifuRYj
         IAew==
X-Gm-Message-State: AGi0PubUMfroJC4gfbjLF2tYV3yNnns/Z01lVLl/PDR72lpNzOiNtV8t
        mUe24g2IKXv7SVLRSjyNDqUox1NQ7Y7C0cbcuQ+lLA==
X-Google-Smtp-Source: APiQypLTnGaABXrQCW2QQtyFSezi7WVW419H2+hqr2v5Jqdi/XxXVz2zwGUVp3oT5NXK4osCigBb4czRlMxRZnqMFDA=
X-Received: by 2002:a05:6e02:ca:: with SMTP id r10mr221063ilq.41.1588624233809;
 Mon, 04 May 2020 13:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8myTMOetxgaj1wt0MbvSQ0LSRV0FHz4ywsBM1zzhUQG=w@mail.gmail.com>
 <20200504165214.GF86805@Carlos-MBP> <CAPig+cSPXqvFg3-25aDzptuVOHmqOcnmsCKHgjMB9poPyJR2gw@mail.gmail.com>
 <20200504190830.g2tlrognjw6ddipo@tb-raspi4> <CAH8yC8=zsbXDVV99tdBMHwEhr-=dO=wrwBYZi=0J8iFmUHkk=g@mail.gmail.com>
 <20200504201944.gh3zykhil3txdwnk@tb-raspi4>
In-Reply-To: <20200504201944.gh3zykhil3txdwnk@tb-raspi4>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 4 May 2020 16:30:06 -0400
Message-ID: <CAH8yC8mLvG-wqrws6fnXdnuoLAoDfPqgynG9MKoSnJLhPCYu+A@mail.gmail.com>
Subject: Re: Git 2.26.2 and failed self tests on OS X
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 4, 2020 at 4:19 PM Torsten B=C3=B6gershausen <tboegi@web.de> wr=
ote:
> On Mon, May 04, 2020 at 03:20:11PM -0400, Jeffrey Walton wrote:
> > ...
> > > Does
> > > ./t3902-quoted.sh   -v -d
> > > give anything useful ?
> >
> > Yes, it looks like the command reveals a couple of problems.
> >
> > I'll have to look into my iconv recipe. It has not changed in a while,
> > so something else may be responsible for the failure.
> > https://github.com/noloader/Build-Scripts/blob/master/build-iconv.sh.
> >
> > I'm not sure what to do with the HEAD problems.
> >
> > $ ./t3902-quoted.sh   -v -d
> > Initialized empty Git repository in
> > /Users/jwalton/Build-Scripts/git-2.26.2/t/trash
> > directory.t3902-quoted/.git/
> > expecting success of 3902.1 'setup':
> >
> >         mkdir "$FN" &&
> >         for_each_name "echo initial >\"\$name\"" &&
> >         git add . &&
> >         git commit -q -m Initial &&
> >
> >         for_each_name "echo second >\"\$name\"" &&
> >         git commit -a -m Second &&
> >
> >         for_each_name "echo modified >\"\$name\""
> >
> >
> > fatal: iconv_open(UTF-8,UTF-8-MAC) failed, but needed:
> >     precomposed unicode is not supported.
> >     If you want to use decomposed unicode, run
> >     "git config core.precomposeunicode false"
> >
>
> I am quite sure, that the trouble starts here.
> It seems as if you are building iconv yourself ?
> And that iconv does not include "UTF-8-MAC", which is a speciality
> for Mac.

Oh, thanks. I was not aware.

I'll open a bug report with the iconv folks letting them know
configure has some gaps on OS X.

> Are there any special reasons to build your own iconv ?

Yes, iconv bugs on older platforms.

The only way I've found to avoid intermittent problems on older
platforms is using the latest iconv (which is pretty stable nowadays),
and avoid the glibc iconv.

Jeff
