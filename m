Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAEBC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 13:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B745B206B9
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 13:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qk2NDN+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgD1N5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgD1N5y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 09:57:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C05C03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 06:57:54 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w2so16443323edx.4
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fbMPIJJp+G0ayGTNH+1zPv+QlKJ5EneAG2UpaOD00s=;
        b=qk2NDN+YlbOFKwlrMGRvE86JK2vvCePGaUPI3smh52HAHrk+WAphNUHUdE2YSpvg7r
         n0p0f4HnqQ55kVbTllOYkHl0i6wmvkRAzlZuLg6b5WdE/g5kJBy6c0KUrW5AsC4BPZVM
         bxnXtWNaxcyjeIfNKPK2ER+YcLfXE/KL6CQ84vPHBstdqjw3eMlZVdPOTHGYl+qmCm+m
         LhaHlAAMAPpiUlJX0Xxj2aLv4sMHjxyF7QmTwdVk2mBv3iWxzEjRARfYjLUDMT7yk/tK
         b/fD9JwJ+bJIv+LWQ3xx+ZkirX9FribitGRIb1lQh16IDpYOYNKDcZGIPovVV2MMxFFQ
         9MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fbMPIJJp+G0ayGTNH+1zPv+QlKJ5EneAG2UpaOD00s=;
        b=bT7dpaszowlwN9FloZMGMena77pj3oLxDhZUNN32BDIbb6gL4YAFzHOjvc2hrAydll
         CCw3TrEdLT/bZk3ldxzGkS+dcJzCIFMON8VGgthSe0ZIh5qJKDSC3bh2CTd6TRo329gd
         Rt9bRqUxg308Mb5qg3jpKSxUwGmKbT1iJ0SKf6P68SfcYlKtyjB9H6bDW8EbLUmVjp3u
         /x5C/sm6/rCAEqT3YwN+VZkE2adDK3fKxVOctVTX1+gSeX88dyXExfXXfZwv7vALfv8S
         LTDR2S13Px9d0yzVsebhlR/4bvqoAf67iQM2jMqZBEiX11Y7CQ5vm3sTM4/f34syYidU
         7rjQ==
X-Gm-Message-State: AGi0PuZgHU4HI9y4ejdULELX6HEYu4Hd6DbGZQ41/t2cl4MOe6Kp90Ud
        vedqXch4XJALBn4MgWbuijQZWrSjrX0wNdpT4Bk=
X-Google-Smtp-Source: APiQypJfd2BhbPXTVa9Z+102m16CSG4YeKCi9IUjALDLqZY37i2nHNRjzg+Q4Xeb4vg2W/V4qEWsvs+sR5fxaxA8bYc=
X-Received: by 2002:aa7:cc88:: with SMTP id p8mr22770806edt.387.1588082272649;
 Tue, 28 Apr 2020 06:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <EED2CFF1-5BEF-429D-AB99-AD148A867614@gmail.com>
In-Reply-To: <EED2CFF1-5BEF-429D-AB99-AD148A867614@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 28 Apr 2020 15:57:41 +0200
Message-ID: <CAP8UFD32D4WnSbpB1erMTidFpinCNwzqHG_fsyHqRmWgZpsSjA@mail.gmail.com>
Subject: Re: Git Stash brake splitIndex
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Apr 28, 2020 at 3:21 PM Son Luong Ngoc <sluongng@gmail.com> wrote:

> I am on git version 2.26.2.526.g744177e7f7 (latest next)
> When you do a git stash while using splitIndex, it seems like the index will get corrupted
>
> Using configs:
> core.splitindex=true
> splitindex.maxpercentchange=50
> splitindex.sharedindexexpire=now
>
> Reproduce steps:
>
> mkdir repo
> cd repo && git init
> echo a > a
> commit -a -m 'add a'

It looks like it should be `git commit -a -m 'add a'`

When I try to reproduce the steps using git version 2.26.2.526.g744177e7f7:

mkdir repo
cd repo && git init
git config core.splitindex true
git config splitindex.maxpercentchange 50
git config splitindex.sharedindexexpire now
echo a > a
git commit -a -m 'add a'

I get a segfault then:

Program received signal SIGSEGV, Segmentation fault.
0x00005555556ccf89 in ewah_each_bit (self=0x0, callback=0x5555557af648
<replace_entry>, payload=0x555555b47480 <the_index>)
    at ewah/ewah_bitmap.c:252
252             while (pointer < self->buffer_size) {
(gdb) bt
#0  0x00005555556ccf89 in ewah_each_bit (self=0x0,
callback=0x5555557af648 <replace_entry>, payload=0x555555b47480
<the_index>)
    at ewah/ewah_bitmap.c:252
#1  0x00005555557af90c in merge_base_index (istate=0x555555b47480
<the_index>) at split-index.c:162
#2  0x0000555555748b9f in read_index_from (istate=0x555555b47480
<the_index>, path=0x555555b4cd80 ".git/index",
    gitdir=0x555555b4ac20 ".git") at read-cache.c:2335
#3  0x000055555576faf3 in repo_read_index (repo=0x555555b33f20
<the_repo>) at repository.c:271
#4  0x000055555559b91b in prepare_to_commit (index_file=0x555555b4d760
"/tmp/git/repo/.git/index.lock", prefix=0x0,
    current_head=0x0, s=0x555555b04420 <s>,
author_ident=0x7fffffffd810) at builtin/commit.c:927
#5  0x000055555559d6a4 in cmd_commit (argc=0, argv=0x7fffffffdcf0,
prefix=0x0) at builtin/commit.c:1595
#6  0x0000555555570fda in run_builtin (p=0x555555af1218
<commands+504>, argc=4, argv=0x7fffffffdcf0) at git.c:447
#7  0x000055555557134b in handle_builtin (argc=4, argv=0x7fffffffdcf0)
at git.c:672
#8  0x0000555555571610 in run_argv (argcp=0x7fffffffdb9c,
argv=0x7fffffffdb90) at git.c:739
#9  0x0000555555571aba in cmd_main (argc=4, argv=0x7fffffffdcf0) at git.c:870
#10 0x0000555555641bc4 in main (argc=5, argv=0x7fffffffdce8) at common-main.c:52

It looks like merge_base_index() in split-index.c is calling
ewah_each_bit(si->replace_bitmap, replace_entry, istate) when
si->replace_bitmap is NULL.
