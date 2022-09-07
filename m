Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3104C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 18:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIGSyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 14:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIGSyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 14:54:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9F2A0617
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 11:54:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so12479224wme.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xC9AnOeG9fgcFrXfJFWBsq63QGcE7yogU/vNybypxrE=;
        b=oNG4GiA595HOO5pIw8WZrPJ8V3CovxwGRAFmR4OIjgw+N4COlE3LOe0GA4+3+F4yi0
         AFHu4lgu37LH5I/Kp98uja/M5feBJ+tVAlsD8UpDOK4eoFrsT32TOyP657hcBBPYErdH
         bO2CceVyt6fH7NX+QkpRDM0d+eumpOg0VlMkC8kG/W2FiGNS1edCwcsojZrdiNihQgff
         nd7oTSSrdhkeBW2cT0vzGgNtuVihna68w5UfHkGyff9bhqSeV5f8Avh16+A/RbLJXaSd
         1S5QosQUVpedUT03jggDBC81qU7EnwA60jZNzThQqqzULKktIsAwTLgqfqlVf+kQ4c7Q
         JXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xC9AnOeG9fgcFrXfJFWBsq63QGcE7yogU/vNybypxrE=;
        b=iJm0JSysdnXUG3AhtlupW0ZSQVtWXwMgGAt4WzFzJAjfWdod0m5ScgDYF7TSt/nXLw
         rabVCIs1mNo/Eqw5/YakOOFiAOlvQ7+avy3Ruv0qpQHbaMHe0LdqyrFpxchwqZe02pwi
         swz+6q7nV8QtnTgkPCLyaMJnkze+sR8cpmMnnynKFNgPU1r6kkDkp2dLDsJ0QfNh/AW9
         uNxTlLHilKCNJw91wo0d7kKZ3b8DaGgQfq1n0VDesk3i07Gwt6qjCzj7sBVI+CnIKO5z
         QCyrpAspj4HjiVeCeSrGGsmsZuVRkcJxxxxeVgBiLtc8mFKibQ10NGXw+oAAqrLs//FV
         7n/A==
X-Gm-Message-State: ACgBeo2pzDZ5Th2rf4R8/gtP9QEDuDl9TBlXNzGYGy5crjptLnA18FdT
        UQqI9Xq9Xo9Yez2dr9nFv/2cX4AXQJxtsbukEgY=
X-Google-Smtp-Source: AA6agR42HvogDTPM8b0lkFKvBHIMB/JxvZ94LJQqdlhhtLQ/mfOLIW+gLGNs4w/1TH5mQOaBpMOu7Y8+f1aBtvfFLd8=
X-Received: by 2002:a7b:ca42:0:b0:3a6:9d:a444 with SMTP id m2-20020a7bca42000000b003a6009da444mr14704wml.51.1662576853562;
 Wed, 07 Sep 2022 11:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
 <YxKo2l5nBoOa9Jfa@coredump.intra.peff.net> <CA+4x=b-GYMnZygHXOfNb3CdSRoxUeT80n=gSCLyfCA9WsB0wEw@mail.gmail.com>
 <Yxf9yETBi3k6Wasl@danh.dev> <CA+4x=b9M+HRWdDx-Mr4q0NiRQESwJ5uEkOBL_nVPPPHhXs7i_g@mail.gmail.com>
 <YxjhQ8xVI4YtA7xb@coredump.intra.peff.net>
In-Reply-To: <YxjhQ8xVI4YtA7xb@coredump.intra.peff.net>
From:   Lana Deere <lana.deere@gmail.com>
Date:   Wed, 7 Sep 2022 14:53:37 -0400
Message-ID: <CA+4x=b9upd2uTihZK5hXDULkCz6y+CX-dS7p65Pfhn0zh0eMiA@mail.gmail.com>
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OK, I tried the bisect again.  I used the bin-wrappers/git from my git
source each time I did a pull and each time I did a bisect.  This time
the final result was indeed different:

$ ~/tmp/git/git/bin-wrappers/git bisect bad
eb049759fb6b739310af52ee0e13ce6cd0c86be7 is the first bad commit
commit eb049759fb6b739310af52ee0e13ce6cd0c86be7
Author: Jeff King <peff@peff.net>
Date:   Fri Sep 25 14:34:36 2020 -0400

    protocol: re-enable v2 protocol by default

    Protocol v2 became the default in v2.26.0 via 684ceae32d (fetch: default
    to protocol version 2, 2019-12-23). More widespread use turned up a
    regression in negotiation. That was fixed in v2.27.0 via 4fa3f00abb
    (fetch-pack: in protocol v2, in_vain only after ACK, 2020-04-27), but we
    also reverted the default to v0 as a precuation in 11c7f2a30b (Revert
    "fetch: default to protocol version 2", 2020-04-22).

    In v2.28.0, we re-enabled it for experimental users with 3697caf4b9
    (config: let feature.experimental imply protocol.version=2, 2020-05-20)
    and haven't heard any complaints. v2.28 has only been out for 2 months,
    but I'd generally expect people turning on feature.experimental to also
    stay pretty up-to-date. So we're not likely to collect much more data by
    waiting. In addition, we have no further reports from people running
    v2.26.0, and of course some people have been setting protocol.version
    manually for ages.

    Let's move forward with v2 as the default again. It's possible there are
    still lurking bugs, but we won't know until it gets more widespread use.
    And we can find and squash them just like any other bug at this point.

    Signed-off-by: Jeff King <peff@peff.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

 Documentation/config/feature.txt  | 4 ----
 Documentation/config/protocol.txt | 3 +--
 protocol.c                        | 6 +-----
 3 files changed, 2 insertions(+), 11 deletions(-)


.. Lana (lana.deere@gmail.com)


On Wed, Sep 7, 2022 at 2:21 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Sep 07, 2022 at 11:56:27AM -0400, Lana Deere wrote:
>
> > Sorry, I was confused by the "0 left".  With one more besect it says
> >
> > 9f489ac6bbb755fa4c83289e44cad12f3b765d69 is the first bad commit
> >
> > That appears to be
> >  [9f489ac6bbb755fa4c83289e44cad12f3b765d69] Merge branch 'dl/zero-oid-in-hooks'
>
> That seems unlikely to be the real culprit. I wonder if something went
> wrong during the bisect.
>
> A common gotcha when building Git from source is to directly run:
>
>   /path/to/git-clone/git pull
>
> Under the hood git-pull will run git-fetch, which it will look for in
> the installed libexec dir. But of course if you didn't run "make
> install", then what is there may be some old version installed
> previously. Instead, you want to run:
>
>   /path/to/git-clone/bin-wrappers/git pull
>
> which will set up the environment so that we'll find any other git
> commands inside the build directory.
>
> That's all a wild guess, of course, but if you think that might be the
> problem it's worth trying the bisect again.
>
> -Peff
