Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9819C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 20:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F782075E
	for <git@archiver.kernel.org>; Wed,  6 May 2020 20:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StHr59Qp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgEFUgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 16:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726093AbgEFUgu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 16:36:50 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41202C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 13:36:50 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id c2so3629475iow.7
        for <git@vger.kernel.org>; Wed, 06 May 2020 13:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=xXTRRZDGtinz2zqjbOBG63sgED29wPypznJrELbOB+o=;
        b=StHr59QpiUkdbhtAXM6E4YS3aeCVAMTOc6J3mWRREEGSW15ODO7te6xsO/OMdIdNVX
         jyOQDRlNSIoyzZsT27vvnlXipeq6gqSWWOSzRr/LpyC7q5TOgcwxFR/+eusOL9IBwtAS
         F45qhUg8RN4bH6Y/y1Wjxi0RhBV7vEOv/qS/wBnfcC7rOMbXY0krrbgm3Hqvhw5VzpFv
         uV6kg658D+9ZiBP2NXqUuGqFYzywXsVWVIuyt5BVkYt8nmWGb/m2rStZHESQYpyzwX8B
         VPOhvxDUAUd5CyXmqQ3DsKf1vhLnkh5HNkw660+NsKv1c9gmJ9/KXX07R0NxLB41XTYk
         hniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=xXTRRZDGtinz2zqjbOBG63sgED29wPypznJrELbOB+o=;
        b=qbL8DbUC3xziYAJb1E4ymZDml8t1rPuIleyxv+GXztMFmqke/Tcwn+NKoQZ4z0ZN4w
         /oAWf2dDw6uju3+XJxzII/qZqQ7/0KCBoMPyLZyUdogCb4VlWGHDUrIDUEI/On7JvDvq
         dL3+v3DmfrTAvJprRd8TNJ+qgxKhYjma83k/upR+W8BkLPOzUMAtrZLfVpTKrcYsCibb
         MpNViQl8M48LwS9VyKCyDIZ+SgsUXAPBkGcxLoWb6Q/RkU03Y/Qo9/XSShYG03am43KT
         2/DBNuh/rZsI/GPHIgS6Q2ZlkcP+GlPKSELX6oh0NC1pbFQ9uhzTPdcamy0tinLa4Sq3
         Osyg==
X-Gm-Message-State: AGi0PuY/Z6YOp9oGr6rQp+BETO59BFWbza/Jr4kFbBJGlec0x0INNUVI
        Colv6F2hez3kHt82U0tzlXPY6GRrBgTx1O3XwEs=
X-Google-Smtp-Source: APiQypJyFMwRWMYZosSDOd6yPdQ0CTenHo+H+AaWf3XoWTt0UcHEB7RM1n1OPzLy1cBHFdUEZdKyTxeohTAk9/dA65k=
X-Received: by 2002:a5d:9c88:: with SMTP id p8mr10155041iop.200.1588797409510;
 Wed, 06 May 2020 13:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8myTMOetxgaj1wt0MbvSQ0LSRV0FHz4ywsBM1zzhUQG=w@mail.gmail.com>
 <20200504165214.GF86805@Carlos-MBP> <CAPig+cSPXqvFg3-25aDzptuVOHmqOcnmsCKHgjMB9poPyJR2gw@mail.gmail.com>
 <20200504190830.g2tlrognjw6ddipo@tb-raspi4> <CAH8yC8=zsbXDVV99tdBMHwEhr-=dO=wrwBYZi=0J8iFmUHkk=g@mail.gmail.com>
 <20200504201944.gh3zykhil3txdwnk@tb-raspi4> <CAH8yC8mLvG-wqrws6fnXdnuoLAoDfPqgynG9MKoSnJLhPCYu+A@mail.gmail.com>
 <CAH8yC8nyg6pRStrQxkO6DzqRbLhhza0vx1U1cGUV4P4MQ3jZ7Q@mail.gmail.com>
 <20200505041033.w2q7h5k7otetfrus@tb-raspi4> <A6880B7C-78B7-4D90-91E3-1CED85325FF2@me.com>
In-Reply-To: <A6880B7C-78B7-4D90-91E3-1CED85325FF2@me.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 6 May 2020 16:36:36 -0400
Message-ID: <CAH8yC8nZSWSHzMiY+L4kC8OSZu9GV6H82SyvSAOqw0zX6J4xbQ@mail.gmail.com>
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

On Tue, May 5, 2020 at 8:26 AM Philippe Blain <philippe.blain@me.com> wrote:
>  ...
> > I am not an iconv expert - and don't intend to become one.
> > The UTF-8-MAC conversion does probably only exist in the
> > code for iconv shipped on Mac OS - so it could happen that this
> > code is not open source.
>
> Yes, this encoding only exists in the Apple fork of iconv,
> which is open-source (probably because of the original
> license); tarballs can be found at [2]. However in typical Apple fashion
> the versioning of their iconv fork is kind of undecipherable and hard to relate to the
> upstream iconv versioning.
>
> Also, I searched the iconv mailing list [3] when I came across this error and the consensus
> seemed to be that they do not intend to add this encoding upstream.
>
> Cheers,
>
> Philippe.
>
> [1] https://github.com/conda-forge/git-feedstock/issues/50
> [2] https://opensource.apple.com/tarballs/libiconv/
> [3] https://lists.gnu.org/archive/cgi-bin/namazu.cgi?query=utf-8-mac&submit=Search%21&idxname=bug-gnu-libiconv&max=20&result=normal&sort=score

Thanks Phillipe.

I found two sources for libiconv with UTF-8-Mac. First is a GitHub at
https://github.com/fumiyas/libiconv-utf8mac. The second is the
opensource.apple.com link you provided at [2].

The GitHub claims to be layered on top of libiconv 1.16, but I was not
able to get a working tarball from it. It looks like Apple's
libiconv-59.tar.gz is the answer to this problem.

Thanks again for the help.

Jeff
