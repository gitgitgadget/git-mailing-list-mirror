Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55296C2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 20:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F582051A
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 20:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfcnT8od"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgDHUFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:05:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44678 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbgDHUFk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 16:05:40 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so1404326iok.11
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 13:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RdbBA1mMnVBXavvKID4ER0BlhDYxTm3TOg6zGZYwMUo=;
        b=QfcnT8odAkzBZnvpQNFWFgHI8as+7sBnvwwJSH/Ev8XxHZbO4h6sJMTdcjvlzEoaLo
         jfk/sI5J6bDfdb6Xcs9ZPYJJjIwkmksgfVA3QAg157drKJgmiFY2as9H5iOvQcpgXEZz
         jnazwHGm6D6xJXS8hqrMONt6zO2LDXD9pONLByDQlQ3ye2/NRNfSe/RN1fNCwcafu1dd
         N0peCkd0pvTCten0wyijamD2FgrdUjrH01yHHbCapAgDNpMTiTlCfJ3L6fL8B66E46A8
         uCu4+tcMEMMcHdwF6POr4fM0yhuHDSYNHY0kApLIAJ+gYQ2uRFJHoTdW22U1tDIbmEU8
         mz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RdbBA1mMnVBXavvKID4ER0BlhDYxTm3TOg6zGZYwMUo=;
        b=ZguIQpE7hs9W6z6tROikhVrpnAbMOdTShVLVUjB28azECUL/Pq5pxy12N/+/jMjm2h
         X1IaIZ7ASqhHWJbrhjOVGkhJ4vzLch1/udsNm6SqYa4H5IwNVLwrbc3vrYuEPkV6Bg9B
         Do4b15fQfHKC/q+WfTgsL45WFPZpz7XvQl7eYIQ5skJBxTd2VnXGkv+5dnEJsPzd5Qhy
         SqC9O3NBADAMBOoBkCLpgCQ35HSbIfVUmTKLf/PHA1J+4sROJN9Vl+r5E42GNi+FH2qX
         B7Wj4vZBB0AUgRjA4yaS1bXy5Nhzlufnx9X9DiLfhoc7BgN+vUJJXySDd8oIw/5s8xl5
         mqyw==
X-Gm-Message-State: AGi0Pubkub4Tpb8i+BEF3uwssoFFlfZhXGKBU5muamTRUh1aEHZvdAX+
        iAQAlNGCSSkph6YXAEapoRqjxS9PaGIG/f4R9nE=
X-Google-Smtp-Source: APiQypKtY+nEpzQzvZduccUZrT2uXenimohz+iFbuhld9VhCH/8GleCAp7/jjyt9rFFloxrQTvRftjW6jAd4E7x4BEc=
X-Received: by 2002:a02:69d4:: with SMTP id e203mr8318887jac.12.1586376338112;
 Wed, 08 Apr 2020 13:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
 <pull.497.v4.git.1586192395.gitgitgadget@gmail.com> <ced7a793-47d9-8254-93fe-acdda8f12334@gmail.com>
In-Reply-To: <ced7a793-47d9-8254-93fe-acdda8f12334@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Wed, 8 Apr 2020 22:05:01 +0200
Message-ID: <CANQwDwf-Ok5oToyRoMXxTWOmPN0BhR=FVm3P-AoQxBqbozmc7A@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Changed Paths Bloom Filters
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Garima Singh <garima.singh@microsoft.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 8 Apr 2020 at 17:51, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 4/6/2020 12:59 PM, Garima Singh via GitGitGadget wrote:
> > Hey!
> >
> > The commit graph feature brought in a lot of performance improvements a=
cross
> > multiple commands. However, file based history continues to be a perfor=
mance
> > pain point, especially in large repositories.
> >
> > Adopting changed path Bloom filters has been discussed on the list befo=
re,
> > and a prototype version was worked on by SZEDER G=C3=A1bor, Jonathan Ta=
n and Dr.
> > Derrick Stolee [1]. This series is based on Dr. Stolee's proof of conce=
pt in
> > [2]
> >
> > With the changes in this series, git users will be able to choose to wr=
ite
> > Bloom filters to the commit-graph using the following command:
> >
> > 'git commit-graph write --changed-paths'
> >
> > Subsequent 'git log -- path' commands will use these computed Bloom fil=
ters
> > to decided which commits are worth exploring further to produce the his=
tory
> > of the provided path.
>
> I noticed Jakub was not CC'd on this email. Jakub: do you plan to re-revi=
ew
> the new version? Or are you satisfied with the resolutions to your commen=
ts?

I am planning to re-review v4 of this series when I would have time,
which means probably after Easter.

I think if it handles endianness issues correctly, it should be ready.
--=20
Jakub Nar=C4=99bski
