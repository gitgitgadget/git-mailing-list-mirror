Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C6951F404
	for <e@80x24.org>; Fri,  2 Mar 2018 00:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163218AbeCBAOd (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 19:14:33 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:42764 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162976AbeCBAOc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 19:14:32 -0500
Received: by mail-oi0-f52.google.com with SMTP id c18so5887674oiy.9
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 16:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bR4WCeKUy5DuY1EEkTGEptxIR+VVnBySTbxcwq65GUw=;
        b=LJFtG7gxJhLw8wx/dJ9a2E/iWmxALX5C3KnRwzWHTwL1H9O9vsImPZz4tjkXTrWJAz
         Bu/29SXDGKkGRx4BxYEgPEPEA5B8fJJPqm6Q1S6OeA0x6Nq1xHq0+4HXZyQNK38085Sv
         jQjgxHuxEgz71lbSbjnrizEhLISnHytq5csmk5tFoOKPFDm4wmKdyq+vjCJFBoVkecmE
         ixn+kTzvwpBafyR3nN4IGEHkrJuBgxRepZlqgU/+o8jUKyla0WGDVkhG+IDmFQo7Mn/q
         tbMMXqVsjInYkvn9/vE0RjmcANnkHbS2OivcKHFL7usXxcsZcb7L0Dm3/N8/Nbm1QqoD
         NI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bR4WCeKUy5DuY1EEkTGEptxIR+VVnBySTbxcwq65GUw=;
        b=RnvYaW9JKRK5zG9n4+ucQ83fXlt84ajyrv6jqsEQsG661F6Jilz2v+D7lrZRxGAY9m
         q2Je73GXYumvMOlHQnbv/vFH4vxflDGXMoG5WUa3CsPz7tGsI947aJGYBQoPS34trNJp
         /6kAsNh6aLBeMVZZG2lRPN3z3U46OZLoIb2/XOxpGcLVCcwLN3N+pK07IpqLvBKxpwdA
         WNbsOZPgfSeJJWqRxKl0MlQFvnHClWuq2hZlcM8shVmmztzOS7pkuJnjoGIujnIHTECI
         JMPf3/XnHb/qwgrwJx+knTuOoICE1E2+5LJu3YUjtF8uZ94j0+aBP+10nOuziKSvTG9e
         7ddg==
X-Gm-Message-State: AElRT7Hqn5jatbfHhcD0bOfyLkjbRQIwQHM+T14mKO7ETAZ9avOyWKav
        +yojPqYVapmLzEuDQb9sreYNoIvzjXXhBREBP/I=
X-Google-Smtp-Source: AG47ELsKuKukwpsvKkfTe7CuN2nC7/9t+7vHwKaZM9+OhTqU9Zlvmk7chfEH/bvC+84yr9WbpH5BTilD7l/qvSu5Ayw=
X-Received: by 10.202.187.4 with SMTP id l4mr2611874oif.56.1519949671437; Thu,
 01 Mar 2018 16:14:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Thu, 1 Mar 2018 16:14:01 -0800 (PST)
In-Reply-To: <87y3jbdiof.fsf@evledraar.gmail.com>
References: <20180228092722.GA25627@ash> <20180301091052.32267-1-pclouds@gmail.com>
 <87y3jbdiof.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 2 Mar 2018 07:14:01 +0700
Message-ID: <CACsJy8Bvtk_rKJ34F_PmBD5F2WN4L8ecug5dQX8-gt8i1owy3Q@mail.gmail.com>
Subject: Re: [PATCH 00/11] Reduce pack-objects memory footprint
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 1, 2018 at 8:33 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Mar 01 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy jotted:
>
>> The array of object_entry in pack-objects can take a lot of memory
>> when pack-objects is run in "pack everything" mode. On linux-2.6.git,
>> this array alone takes roughly 800MB.
>>
>> This series reorders some fields and reduces field size... to keep
>> this struct smaller. Its size goes from 136 bytes to 96 bytes (29%) on
>> 64-bit linux and saves 260MB on linux-2.6.git.
>
> I'm very interested in this patch series. I don't have time to test this
> one right now (have to run), but with your previous RFC patch memory use
> (in the ~4GB range) on a big in-house repo went down by a bit over 3%,
> and it's ~5% faster.
>
> Before/after RSS 4440812 / 4290000 & runtime 172.73 / 162.45. This is
> after having already done a full git gc before, data via /usr/bin/time
> -v.

Jeff correctly pointed out elsewhere in this thread that RSS covers
both heap (this is what I try to reduce) and some file cache (we mmap
the whole pack file just to ease the reading) so RSS might not a good
indicator of memory reduction. Any new freed memory should be used for
cache which raises RSS back up. I think the RssAnon field in
/proc/<pid>/status shows it better.

> So not huge, but respectable.
>
> We have a big repo, and this gets repacked on 6-8GB of memory on dev
> KVMs, so we're under a fair bit of memory pressure. git-gc slows things
> down a lot.
>
> It would be really nice to have something that made it use drastically
> less memory at the cost of less efficient packs. Is the property that

Ahh.. less efficient. You may be more interested in [1] then. It
avoids rewriting the base pack. Without the base pack, book keeping
becomes much much cheaper.

We still read every single byte in all packs though (I think, unless
you use pack-bitmap) and this amount of I/O affect the rest of the
system too. Perhaps reducing core.packedgitwindowsize might make it
friendlier to the OS, I don't know.

> you need to spend give or take the size of .git/objects in memory
> something inherent, or just a limitation of the current implementation?
> I.e. could we do a first pass to pick some objects based on some
> heuristic, then repack them N at a time, and finally delete the
> now-obsolete packs?
>
> Another thing I've dealt with is that on these machines their
> NFS-mounted storage gets exhausted (I'm told) due to some pathological
> operations git does during repack, I/O tends to get 5-6x slower. Of
> course ionice doesn't help because the local kernel doesn't know
> anything about how harmful it is.

[1] https://public-inbox.org/git/20180301092046.2769-1-pclouds@gmail.com/T/=
#u
--=20
Duy
