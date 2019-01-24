Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36F21F453
	for <e@80x24.org>; Thu, 24 Jan 2019 12:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfAXMy2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 07:54:28 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37463 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfAXMy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 07:54:28 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so4208820iti.2
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 04:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xmJu5w4AT7O4WGH/sQXRa8dzqi3lap9NSzuzLFzA8bY=;
        b=sPOGCnF8q67pIdXtl63rScCUWzAVZ88C4viPoG0D4Ie3FzHSUi+T1MkibOUoUThlFE
         7g8asmlAN1sXxjzI1r/h4auVLsBR/GVTrkW9qxR+et8Q6U+EG1r+0kexDujJ+xjfiPEa
         SARaGRtcMpF2vVwIjRYLmRX+mDZa6+d/DBD/Wd7hF2zrF194E9cmZzors37sJnwUm2bl
         VatBH8vhRgidqSNPwxYaQnm/ZPDizBOt8Mz2aw1NbgBP9m+CCri8KibJVPSnH22pQ1ay
         JIPi+bcS8Q6P0GAwLmtez/TRSLdNQAMUdp/IQoUYh9jLyC/WgjXZKzBfDOiv9z2HK5S/
         veTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xmJu5w4AT7O4WGH/sQXRa8dzqi3lap9NSzuzLFzA8bY=;
        b=lcAPupZlg3SnxcP6nUKBo30i4DiVBnD2++lnZs5xJVrGHJ/NVkc09JMisR1cH9SWAE
         b0pKUiRbTUMT7VqHNO1RtXFbTBpvkPG4WZzpK+nntx8LWiQ1/gKx98DatWhjdp/xupT+
         9ywfZV36vjpVRkmjvWnhmwZjsLaq0VR/xvunW2oF0vE7pmoEdGY2GaVeldLv/yvbQR2l
         gDGJcCNLWZn2UYO9emlKZbDloIEZ9fzaQaYCs946RZLuXwISzytMh1rVzM9VSz1gy6vf
         xtXfQYHpv554MystJfjs2KZCJBylwe9/vgILDwGN9g9zwrKh69MKSTy9h66M2YEQQyjV
         6pmg==
X-Gm-Message-State: AJcUukeBmvbA3ItjNrpob0qohaFF2Ev/OqvwdRGNo5a4D5XAv0iIKf0l
        RgYldGfdVjY5s90nQSq88EacPhfetKVTgZOGoR8=
X-Google-Smtp-Source: ALg8bN5GGLBA59M9o77+ChtaO+hTdjfONoUR+prKXX48aVDNsGh1tCL8wSNLVHsOOzybqw6P3FqTnQrDf/+sMB+mINc=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr1287270ith.123.1548334467419;
 Thu, 24 Jan 2019 04:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20190122220714.GA6176@kitenet.net> <20190124121037.GA4949@sigill.intra.peff.net>
In-Reply-To: <20190124121037.GA4949@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 24 Jan 2019 19:54:01 +0700
Message-ID: <CACsJy8A3JbO775qaR1PBAsosh031JWmDPv5Y40JzUP=fuT9hRA@mail.gmail.com>
Subject: Re: git status OOM on mmap of large file
To:     Jeff King <peff@peff.net>
Cc:     Joey Hess <id@joeyh.name>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 7:11 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Jan 22, 2019 at 06:07:14PM -0400, Joey Hess wrote:
>
> > joey@darkstar:~/tmp/t> ls -l big-file
> > -rw-r--r-- 1 joey joey 11811160064 Jan 22 17:48 big-file
> > joey@darkstar:~/tmp/t> git status
> > fatal: Out of memory, realloc failed
> >
> > This file is checked into git, but using a smudge/clean filter, so the actual
> > data checked into git is a hash. I did so using git-annex v7 mode, but I
> > suppose git lfs would cause the same problem.
> >
> > [pid  6573] mmap(NULL, 11811164160, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = -1 ENOMEM (Cannot allocate memory)
> >
> > Why status needs to mmap a large file that is not modified
> > and that is configured to pass through smudge/clean, I don't know.
> > It seems like it should be possible for status work in this situation.
>
> One minor point: I don't think this is us mmap-ing the file. The
> descriptor is -1, and Git never uses PROT_WRITE. This is likely your
> libc using mmap to fulfill a malloc() request.
>
> That said, it just turns the question into: why did Git try to malloc
> that many bytes?  If I reproduce your example (using a 100MB file) and
> set GIT_ALLOC_LIMIT in the environment, the backtrace to die() is:
>
>   #1  0x0000555555786d65 in memory_limit_check (size=104857601, gentle=0) at wrapper.c:27
>   #2  0x0000555555787084 in xrealloc (ptr=0x0, size=104857601) at wrapper.c:137
>   #3  0x000055555575612e in strbuf_grow (sb=0x7fffffffdbf0, extra=104857600) at strbuf.c:98
>   #4  0x000055555575731a in strbuf_read (sb=0x7fffffffdbf0, fd=4, hint=104857600) at strbuf.c:429
>   #5  0x0000555555664a1f in apply_single_file_filter (path=0x5555558c787c "foo.rand", ...)
>   #6  0x0000555555665321 in apply_filter (path=0x5555558c787c "foo.rand", ...)
>   ...
>
> Looking at apply_single_file_filter(), it's not the _original_ file that
> it's trying to store, but rather the data coming back from the filter.
> It's just that we use the original file size as a hint!

Really cool! I guessed as far as malloc() but did not actually test
it, let alone examine the problem closely like this.
-- 
Duy
