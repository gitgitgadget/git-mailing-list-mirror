Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B9E32018E
	for <e@80x24.org>; Tue, 12 Jul 2016 07:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbcGLHEz (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 03:04:55 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35867 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbcGLHEy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 03:04:54 -0400
Received: by mail-wm0-f44.google.com with SMTP id f126so116361537wma.1
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 00:04:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6xA6cYsc/JQ/aIMe7VypLNtdLHe1x7gByV1YqlnPQ7k=;
        b=OVijrP6XdRXGHCdqRay0HwhZ4kYCwFXBbxkBgPvz9ksHvu78ie9junu4zeKsq4wFI1
         2osHdx3/ihhRzbJGzpgTTGc/g+2BpUPzWaTLr0cGDaDNx91TJyo/eWKmvnY2ZOVIbAL7
         /tNtfXZrRzVsbAOE3s1yU6fzm8ZAxYXuxZsFgAnM2GMwXEYI40BxS0DqjnuJkMbPAjZQ
         KZ5hDB6Pog0Nx9p7QkkgMwwUyeBKCZ6zcch++ylVlk2vOU8Pr0xdX7h0ZeQA19LwYrip
         CR1D2YOUrJrj+Vvzc8c3mGJXyycKRpYij+naKLis3QitswH2xjHDpu+LOExI+VqhVoDf
         rU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6xA6cYsc/JQ/aIMe7VypLNtdLHe1x7gByV1YqlnPQ7k=;
        b=nBDxCRsUmgO4ySwkaIa9ghPe5SUOZWuhJWLDldYPITws6QgF40KRlIVjtF3GBuJE8G
         lqHJtTYsd6+TdGva+kch5D0MgdF+qSt2Lsec11HaJj6nPBY6PY6+G0HJK67j7tFhf6Uf
         6eFoi3K3gSqv7Avvxd7SxfkB1RZrQKsT4F2J1JERR28ECQvT6LfEYa1UBWaxClWNv6Ai
         mx8Jm7uCwUcU2PgDyT1QHKTWRe2CTZfT/+W1hLNimvB/76ByFBN3wFBeGpM0HH1lLsna
         W90RdlM4IfpTvpo4a0Q88+sHuIeos2d27Q1Sga31iTcStJc8HeJ8186g0DZGxLnZr2nV
         EAYQ==
X-Gm-Message-State: ALyK8tK3/2wnbqwS+rcmzvfqCzcv/d0++BM779ihwc7IKrWAxOTk0ZTBJ3S9NXhpDrREKV0yctP5pwAZb9gGRg==
X-Received: by 10.194.192.39 with SMTP id hd7mr813876wjc.94.1468307092869;
 Tue, 12 Jul 2016 00:04:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.151.134 with HTTP; Tue, 12 Jul 2016 00:04:52 -0700 (PDT)
In-Reply-To: <CACsJy8BqMFASHf5kJgUh+bd7XG98CafNydE964VJyPXz-emEvA@mail.gmail.com>
References: <20160711172254.13439-1-chriscool@tuxfamily.org>
 <20160711172254.13439-9-chriscool@tuxfamily.org> <CACsJy8BqMFASHf5kJgUh+bd7XG98CafNydE964VJyPXz-emEvA@mail.gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Tue, 12 Jul 2016 09:04:52 +0200
Message-ID: <CAP8UFD01MiMnz6qNGYa9WEjZ_EOy-hBqO4gGKGyxUc71aOyp4w@mail.gmail.com>
Subject: Re: [RFC/PATCH 8/8] read-cache: unlink old sharedindex files
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 11, 2016 at 8:27 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Jul 11, 2016 at 7:22 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Everytime split index is turned on, it creates a "sharedindex.XXXX"
>> file in the git directory. This makes sure that old sharedindex
>> files are removed after a new one has been created.
>
> Hmm it's one-way link, we don't know how many index files use this
> shared index file, how can you be sure nobody else will need it? I'm
> thinking about temporary indexes. If a temp index is created, saved on
> disk, and use delete the shared index file, the real, main index may
> become useless. Temp index will most likely replace the main index
> (git commit) but if a failure happens, we can't fall back.

Isn't there a way to scan all the current indexes (temp or not) to see
which shared indexes they need?

> A safer approach is "touch" the shared index every time a linked index
> is used, then we can delete shared indexes with old mtime, older than
> a grace period, in git-prune (or here).

Maybe old linked indexes could be converted after some time to use a
newer shared index, so that we can get rid of the old shared indexes.
That seems safer than just deleting old linked indexes.

Thanks for your review,
Christian.
