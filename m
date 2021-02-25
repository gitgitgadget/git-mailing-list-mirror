Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236D9C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CABD364E90
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhBYHpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 02:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbhBYHpP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 02:45:15 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217C1C06174A
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 23:36:33 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 2so809912ljr.5
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 23:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzkCJ/P+F+6mpTHLLTNNkUH37s8upKGTKoCdVF3cOEI=;
        b=t4XxwT2o0w8jv9M9JvX82GMXXPElO2RfRF2mXwZxmBoQo85dJRcC7rxUmwmzJzl9Gm
         MY9TbbQOabYV7SETluQCXWNrjpYzRYcfJHfjj+i74q5XnhYGZndnRz4yu2ppvBgofDvY
         MbcpYLf1i36eA/Lt+PcBmHV3anfpQwtenuuon7jPZiUqe/kH0m+ygr+RDfRl/GoApezH
         m7jV2xrRn3ewweX7ncTzkAXO585+3/cfCE0sUBXsc16aEcD91KpzIA+ehLf8Av10Lrhj
         nFMdiGqPPY971AcFlqbUz+3Phcy9vJkwS7VfbdZAo69vWwIoi8/xKiREzXEW3ufBAj3+
         zRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzkCJ/P+F+6mpTHLLTNNkUH37s8upKGTKoCdVF3cOEI=;
        b=fddaOKjROz6buIBUAwFfXQEFJJiRKGhWhZKLrQvqWfyh3GV7IjPtpZ+gFNjAh6ztj7
         H5ZY8AZRr1k3VHrXB/SmN2FvEJzaU2r5SJ0szJ+8GcaB8sCWCQJIBLZVsbx1vYnqCeO7
         VOH5Sp8Y1ukU2nSeDAftuoulgu+cVlMIlsliJr/BkocvSSy2c2mqMt5NG4w5YGL21qAW
         HBM407zSZD3mKVZQ//2Ufh/xqUEi0Nz1BgQFejdA4q6IGmLVNQFLP2sTblFvihsza/e9
         tiS6Zw2ImZIw23GlBKyYGvzeLS/M/B0VtFnZ0fmynrcBQtttucWoL9a0qOgtHTc+d2GR
         dHcQ==
X-Gm-Message-State: AOAM530vx66UwKtfKibqZm0LNJLgTSb+fXi7CE0A7YrVvfowsHErlyGP
        Ke7z/uopgU6kU9Zt9HleB6RW2TWHDPL2klX2aJY=
X-Google-Smtp-Source: ABdhPJz9IN3jHvlX1Q7NUpkSHL37TGqWz/K/svBFNMuVrwPfTxvkwz7LTrfpTDQqkjge08DHKSOqRLs5YXX+SJgV0h4=
X-Received: by 2002:a2e:589:: with SMTP id 131mr899024ljf.336.1614238591657;
 Wed, 24 Feb 2021 23:36:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.877.git.1613616506949.gitgitgadget@gmail.com>
 <f52df30b-4ab0-fd6f-17f8-70daed81df39@jeffhostetler.com> <xmqqv9ana05b.fsf@gitster.g>
 <CANQDOdeEd=JjWL4gb5CWHL_HkvJMnFumW74ew4DXJahh4BKvfQ@mail.gmail.com>
 <xmqqo8gd8tyr.fsf@gitster.g> <CANQDOdfJApBOEm2gPMwtz9T0ETPoDk107mF7LYRGCmjFLi3Jxg@mail.gmail.com>
 <xmqqmtvswvp7.fsf@gitster.g> <CAPx1GvdA1prtO+y-bJ7yu8oZP6Lp9mHQ5gv-fXvS193NFospkA@mail.gmail.com>
 <xmqqeeh4wrad.fsf@gitster.g>
In-Reply-To: <xmqqeeh4wrad.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 24 Feb 2021 23:36:20 -0800
Message-ID: <CANQDOdd+keN3LyC4CHWDZ3JHYurEy_FLyw5GT5UKqg0RcTA+DA@mail.gmail.com>
Subject: Re: [PATCH] read-cache: make the index write buffer size 128K
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git List <git@vger.kernel.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 11:16 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Chris Torek <chris.torek@gmail.com> writes:
>
> > Linux/BSD/etc `stat` system calls report st_blksize values to tell
> > user code the optimal size for read and write calls.  Does Windows
> > have one?  (It's not POSIX but is XSI.)
> >
> > (How *well* the OS reports `st_blksize` is another question
> > entirely, but at least if the report says, say, 128k, and that's
> > wrong, that's no longer Git's fault. :-) )
> > ...
> > 128K is correct for ZFS; 64K is typically correct for UFS2; 8K is
> > the old UFS1 size.  Anything under that has been too small for
> > a long time. :-)
>
> That's rather tempting.  After opening a locked index to write
> things out, the value is a single fstat() away...
>

From a quick perusal of freebsd, st_blksize seems to be the system
PAGE_SIZE by default (4k most of the time, I assume). The Windows
equivalent of this value is really tuned to what you want to send down
when bypassing the cache (to avoid partial cluster/stripe writes).

https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_stat.h.html
doesn't elicit much confidence. The units of st_blksize aren't even
defined.

Thanks,
Neeraj
