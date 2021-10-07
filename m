Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298F4C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 03:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED6EF6124C
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 03:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhJGD5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 23:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhJGD5I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 23:57:08 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA57C061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 20:55:15 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id r16so4896373qtw.11
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 20:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r5TGJqjhg0Fefyts+NKgQhKKp4sZEMmkp7URxRyRwMc=;
        b=RfgNDM9NNJCtxNs/cLZZ3IrK0aGAWTsE6m9LDjuQWoyygai9Enz7NcSZ6seIrjqsff
         HkmTmJUXd8o6ZR3OQjUWKmzNkKFziBxm7sYILpfc9EFv1g4MzWAw59XuI7tvZkswFPhJ
         tHCS3Dy/LHo/HtfS0oqA/Kk3s3oQrYJOmevi0hF1pEHLmw3N7CQ+hxrkGokD5UzyHwx6
         QpCoYrxAQIQSOP4UEpSIS6XJNuAOUpM2tYpTA6UtG9z/PFjJ+pz1vE/2yYMFepJ89yws
         +RtPcwR+BKZD2G6btImjh5+fyZk1onyuGQjIWYbAlwQG62UHERdf6mQz0znlXmhCoWuP
         9PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r5TGJqjhg0Fefyts+NKgQhKKp4sZEMmkp7URxRyRwMc=;
        b=HI+kwdqJOyDi8xxd5sUu6lzTu7+pi93lnAptMwplwISdRLHDG+ZBbB7nNarv/3rvfu
         haYhZ+dlyZttA7IyrIACusl7E5hGP+lxOftR0hD9Mthdfkc2/ZPlOw2MwU4lVEUVhziC
         CkznpNpHK6Qc7rqDvkBHk2pFPAkZvBs4SEbGCJN+C5cWU9VZh6irZqbrEwjGWcrJU1/O
         hp9sOBlezwRFkwAr67qSgV5vCAAo68Mbk1K/N/psIy2bnfYqWidzMMXxp3ElYyeZJtp2
         AlrT9jZd8R1SKaIaMp0YfyOuEBgrHkNILXZCUP96ejDesuOq4SLHl0OG+XXKu3MtxwzZ
         XqZA==
X-Gm-Message-State: AOAM530OZ/jsxOhppovR5i3NQV9RgZBHWzwcOXh+jSHXlIJcsvwAGKic
        wtym58Qf2w4ztt0FH8nsliN0ohiZ1kK+/w==
X-Google-Smtp-Source: ABdhPJxB4k3hwi6k336v/YG9qanQjEwGHmJCM7Z0m2q4NNcPyuLtwaG6m3PT5/CewuSG02lsFkYupA==
X-Received: by 2002:a05:622a:178b:: with SMTP id s11mr2459587qtk.13.1633578914255;
        Wed, 06 Oct 2021 20:55:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q14sm15591352qtw.82.2021.10.06.20.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 20:55:13 -0700 (PDT)
Date:   Wed, 6 Oct 2021 23:55:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
Message-ID: <YV5voCafN8dLff/R@nand.local>
References: <xmqqfstdr8b5.fsf@gitster.g>
 <YV5aaD418SyZqS/1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YV5aaD418SyZqS/1@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 06, 2021 at 10:24:40PM -0400, Jeff King wrote:
> On Wed, Oct 06, 2021 at 05:24:14PM -0700, Junio C Hamano wrote:
>
> > * tb/repack-write-midx (2021-10-01) 9 commits
> >   (merged to 'next' on 2021-10-06 at ccdd5aaf2a)
> >  + builtin/repack.c: pass `--refs-snapshot` when writing bitmaps
> >  + builtin/repack.c: make largest pack preferred
> >  + builtin/repack.c: support writing a MIDX while repacking
> >  + builtin/repack.c: extract showing progress to a variable
> >  + builtin/repack.c: rename variables that deal with non-kept packs
> >  + builtin/repack.c: keep track of existing packs unconditionally
> >  + midx: preliminary support for `--refs-snapshot`
> >  + builtin/multi-pack-index.c: support `--stdin-packs` mode
> >  + midx: expose `write_midx_file_only()` publicly
> >
> >  "git repack" has been taught to generate multi-pack reachability
> >  bitmaps.
> >
> >  Will merge to 'master'.
>
> Sorry not to catch this before it hit 'next', but there's a small leak
> in the test helper. This patch can go on top to fix it.

Thanks for taking a look and catching this. The fix you wrote looks
good to me. For what it's worth:

    Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
