Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46BF320248
	for <e@80x24.org>; Mon,  8 Apr 2019 01:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDHBXx (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 21:23:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39948 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfDHBXx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 21:23:53 -0400
Received: by mail-io1-f65.google.com with SMTP id d201so9621834iof.7
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 18:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pHJGplNOV+cARceIaBmMZMmeNiNGjo4kXIDlFhjKRBg=;
        b=K+nwhEk6zc5WPsjbpXGVmfex4f/Q9WE4NIsOJ7eDVGlzzMFSdKJIE05mDJIO8p/1g6
         19Q75RAljE7GlvyJ0Bo68OJQgWepOQxPpe9qLVI+UyeDNCvkb4p9LQhBILbvHL0aeckI
         hNVef8KlL21wJ6hGFLHTS3ukwgvxuxoxtU2ggDMplLnJDCg0VqWuOrMEB75mLO6tSdZy
         Pu2uECthXt2dTIJYg7rWoe0+9lptFv30JzrjCE9BDCHJXmAVXtE5sEROchAMOnfMpxgW
         ReoU+CVtkMFjiHAn95FDAxRCXm70V6QUDdaRLhp3TOSnoXUWNd6bG8fSNmCdV9dllkfW
         MItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pHJGplNOV+cARceIaBmMZMmeNiNGjo4kXIDlFhjKRBg=;
        b=ceNnV21Ek3mocfOXfsUxVbMEg/Igqc1vTA9D3exVYTtYmdzfLL+IuQAryDSyLqS6mS
         T80H0QrocRijSl7NPmGfQ5wDjr1ciC4Gf5U85ttqV2XKJjOVUJghqpB096OGKeHEeXmu
         Nk2fy71ekYDAVZsV87fmnbOuVKwkwGWPo4G0L8zoCX0/QuW7eBAQ6+5Beajc1qj90WX3
         TA3VQ4M9PpSELcCHa98StKMWui/Ehgrws00i7PdJkYW8YGI4bQlLOADUtREf2CLwmSX0
         3Qve8+s3EKUBz8iAUPONYl7XWrUOs0i46mUYOpOKBgsVtYetlyqHp0G62SWwy0NhfNHV
         7p8g==
X-Gm-Message-State: APjAAAVLVS5ZypVQZ1M0kUI7P9NnBgiUBZQFBs9izlsiBTIhDsx/XA/9
        ZmRHJLNQ/ib8vuxf2K38RGrdp1g8Dpp7n4Y9GvqWlA==
X-Google-Smtp-Source: APXvYqzcPrIjKp/KPt8BISqvtIIOEpfq34NVhg+Xv/lp8fDO16S+4/7quEQ733K+afD0PUjMrKlGy+57VdiIgYRpYaM=
X-Received: by 2002:a5e:9805:: with SMTP id s5mr18124707ioj.149.1554686632846;
 Sun, 07 Apr 2019 18:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7KMrDJ-cyzk63oqW9-QVpag6fKnDp+Mo5bWxg1KfzY3g@mail.gmail.com>
 <CAP8UFD0qeOaS8NBOaMjzDf_tWJrgkYSAOgn8D=4JER2atg3H8g@mail.gmail.com>
In-Reply-To: <CAP8UFD0qeOaS8NBOaMjzDf_tWJrgkYSAOgn8D=4JER2atg3H8g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 8 Apr 2019 08:23:26 +0700
Message-ID: <CACsJy8DxW7ZcSNQBZq4+A6c+9xZopg79sXfi6Na61Xgcoqd6ng@mail.gmail.com>
Subject: Re: [GSoC][RFC] Proposal: Make pack access code thread-safe
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 8, 2019 at 5:52 AM Christian Couder
<christian.couder@gmail.com> wrote:
> > Git has a very optimized mechanism to compactly store
> > objects (blobs, trees, commits, etc.) in packfiles[2]. These files are
> > created by[3]:
> >
> > 1. listing objects;
> > 2. sorting the list with some good heuristics;
> > 3. traversing the list with a sliding window to find similar objects in
> > the window, in order to do delta decomposing;
> > 4. compress the objects with zlib and write them to the packfile.
> >
> > What we are calling pack access code in this document, is the set of
> > functions responsible for retrieving the objects stored at the
> > packfiles. This process consists, roughly speaking, in three parts:
> >
> > 1. Locate and read the blob from packfile, using the index file;
> > 2. If the blob is a delta, locate and read the base object to apply the
> > delta on top of it;
> > 3. Once the full content is read, decompress it (using zlib inflate).
> >
> > Note: There is a delta cache for the second step so that if another
> > delta depends on the same base object, it is already in memory. This
> > cache is global; also, the sliding windows, are global per packfile.
>
> Yeah, but the sliding windows are used only when creating pack files,
> not when reading them, right?

These windows are actually for reading. We used to just mmap the whole
pack file in the early days but that was impossible for 4+ GB packs on
32-bit platforms, which was one of the reasons, I think, that sliding
windows were added, to map just the parts we want to read.

> > # Points to work on
> >
> > * Investigate pack access call chains and look for non-thread-safe
> > operations on then.
> > * Protect packfile.c read-and-write global variables, such as
> > pack_open_windows, pack_open_fds and etc., using mutexes.
>
> Do you want to work on making both packfile reading and packfile
> writing thread safe? Or just packfile reading?

Packfile writing is probably already or pretty close to thread-safe
(at least the main writing code path in git-pack-objects; the
streaming blobs to a pack, i'm not so sure).
-- 
Duy
