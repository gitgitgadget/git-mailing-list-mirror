Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8588FC433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3648264E90
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhBYH6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 02:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhBYH63 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 02:58:29 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B441C061788
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 23:57:49 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id u4so5410257ljh.6
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 23:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NF8jm0DLpgaMGyeDm7FqmiwtgLdS2HrDrzj3pZzXUzg=;
        b=IRvy+sr19p+C0Nk4YqovBlXGUtMP1/PcUD8dUslo3gupU5wN7Cx2X08KWekoG3b2YE
         QCyuGu+Dl+0h+Zbmq6C1IdDqXv1qOw3HTbxlLecD85eGejM8xKU2fD8Xsw3zaEXE1XRp
         CS/uY2eRgaiNgAIdmk56SOLomzfu2YzTm4XhXvE9int8YM89QLyzbpK+XgsFItvniogC
         pPszOro/TrUKS+FFVDLbvwnQ2hWtXv0ufyr4zNCRgesHa/3N4PawTp3r1/n/5Gle8YBt
         e83gGLZBmP6s3DH4IEcv9ilq9xCyrgurt8scL9J0+MwCppmGpjpc2LzCerPdj0TNHU/Y
         kVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NF8jm0DLpgaMGyeDm7FqmiwtgLdS2HrDrzj3pZzXUzg=;
        b=Y15qhehsLu2uwhCdYQt+h5XRm4AhzTMgou4gdAX9v1c6x8vilGX8fmv8g08RtrxZRj
         UjLi3+wkuDGuXv+Iwwi3nJCjd0TqFPnA1NEW55h/g5L+Io561tCGA4tm/J7T5EWfVwjI
         /lgxbCrBxrJNTySSiroVrX3Cp8fcJ1z1n9M9YsJorV0H5+LMNDdqH4w3XOw44OOBx0ZV
         UFua5oZatgS6CMBZYcRvTRGxOuuU5TWhhq9m3noBVM36fxtPvpHJj59XPJOXu2WMT0te
         xi3uwuvOj9sqjE71rgHgY7vFaStp4ACBzilGla+AMFTEGvx+ZKGmTNbhAgzxxob6p3+w
         7EpA==
X-Gm-Message-State: AOAM532XP3zmrtO2AVxHpbvmG8x3NsEA/5t2poo9eQAzWFULTHgLRffX
        bgl9bw7I/SVVg5wtNUpvbTZ07m+3JeZeMCiOYj8=
X-Google-Smtp-Source: ABdhPJzC9KhFl35GzW4t37y/oON67n8AvDnRka/im9mEpc0pw8rS0efIaFx9m2KHhQYp0MvONk8aKzpnjzpQwwP864U=
X-Received: by 2002:a2e:b81a:: with SMTP id u26mr942229ljo.434.1614239867735;
 Wed, 24 Feb 2021 23:57:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.877.git.1613616506949.gitgitgadget@gmail.com>
 <f52df30b-4ab0-fd6f-17f8-70daed81df39@jeffhostetler.com> <xmqqv9ana05b.fsf@gitster.g>
 <CANQDOdeEd=JjWL4gb5CWHL_HkvJMnFumW74ew4DXJahh4BKvfQ@mail.gmail.com>
 <xmqqo8gd8tyr.fsf@gitster.g> <CANQDOdfJApBOEm2gPMwtz9T0ETPoDk107mF7LYRGCmjFLi3Jxg@mail.gmail.com>
 <xmqqmtvswvp7.fsf@gitster.g> <CAPx1GvdA1prtO+y-bJ7yu8oZP6Lp9mHQ5gv-fXvS193NFospkA@mail.gmail.com>
 <xmqqeeh4wrad.fsf@gitster.g> <CANQDOdd+keN3LyC4CHWDZ3JHYurEy_FLyw5GT5UKqg0RcTA+DA@mail.gmail.com>
In-Reply-To: <CANQDOdd+keN3LyC4CHWDZ3JHYurEy_FLyw5GT5UKqg0RcTA+DA@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 24 Feb 2021 23:57:36 -0800
Message-ID: <CAPx1GvcFMzrFFmwMvDLofj73UcEi6T3u_v+usvENkU2yYGLoaQ@mail.gmail.com>
Subject: Re: [PATCH] read-cache: make the index write buffer size 128K
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git List <git@vger.kernel.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 11:36 PM Neeraj Singh <nksingh85@gmail.com> wrote:
> From a quick perusal of freebsd, st_blksize seems to be the system
> PAGE_SIZE by default (4k most of the time, I assume). The Windows
> equivalent of this value is really tuned to what you want to send down
> when bypassing the cache (to avoid partial cluster/stripe writes).

It's page-size for pipes, sockets, etc., but for real files, it's based on
a report from the underlying file system.  It's actually 8k on a typical
ancient UFS file system, 64K on UFS2, and 128K on ZFS, on FreeBSD.


> https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_stat.h.html
> doesn't elicit much confidence. The units of st_blksize aren't even
> defined.

Despite POSIX's rather obstreperous definition of st_blksize, the
units are actually just bytes, in practice.

Chris
