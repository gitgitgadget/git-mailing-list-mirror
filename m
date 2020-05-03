Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F39C28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 15:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D21920757
	for <git@archiver.kernel.org>; Sun,  3 May 2020 15:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9h9GdxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgECPdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 11:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgECPdm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 11:33:42 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0CFC061A0E
        for <git@vger.kernel.org>; Sun,  3 May 2020 08:33:41 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c10so3079417qka.4
        for <git@vger.kernel.org>; Sun, 03 May 2020 08:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yXQMAUV/neJJOqdvgfin2Hb9LahWvdFx7YwYMbhfqLY=;
        b=e9h9GdxK1slXQ9TZsn1h2BT7tFxQhgFTqFgttntqfihkScDxzGOP6a/pMPvAgCyKtO
         9BJhXVX3TrOopuOgvT3GOvo2eidK7U8jaXbqdGkTniQ6SQGsyQyCDlVQG6zwS5Hh8crR
         LI/lU1mw2EL/XFX4QMIlkQ7PmwMNftwCUOO8a6tsEI/eO2zlerFzEoWnv0BpAyIzEqLY
         YZrZmChzCh3DC092dPO42yfKeAuAt6R1oHbECOkWmMToeDnJj4pWnYizsj7SY2jiNwWi
         YxcdsvJSrj+C+XrvGjd2rbV88Wpi2vK6aRSAC+1JFwvZSvfQqAa4zjFfg3UmjdltDXYp
         D8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXQMAUV/neJJOqdvgfin2Hb9LahWvdFx7YwYMbhfqLY=;
        b=axe6QOySeMjeNJS5Ae/iVRj5WVaR17GhYhQzu2GuxeFt/SxVS+F+VG9adHgMMhSviy
         DNPCODT9kQJTDKXxGufLyYt2iWnm9sGQPWQ3K6tsuijID3ItriYhWZBVXPqqmOr3AfzD
         ITIM9D5OpgRY3VzNyjTzLWa/QRxJXxpENICnm8ehQyDh+8akbulwSKEHrPOA+8jplaCm
         OrR1ta9+61UAJtzxxS0M++j5/d66FhLd720so2Gw6+UZN1jf2fD/4BqzumHJa0DCFGJf
         kcy849aeK6TTDunwad07hkJYDziEC6RkJ676lbvakA2kNguuajSVThHG+2DLlkoZSyZ+
         eOBg==
X-Gm-Message-State: AGi0PubpjhyNX8RUbHz1nqNPx/4WKdB8yycXaCbaPJgK0uSFuX02T58g
        YS04Bj1vHR54hVfER37oBYEeQMmTCPS/vIpw8lk=
X-Google-Smtp-Source: APiQypKIZyXyUgqiXGqrVn6uaVC+/HLDzFivyL+t5/qtESdBOMFmqW7M4eE7d3DjmAO6l5nEngUXnZKVHYK5sPtDjaw=
X-Received: by 2002:a05:620a:688:: with SMTP id f8mr12061173qkh.431.1588520021222;
 Sun, 03 May 2020 08:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com> <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
 <20200427200852.GC1728884@coredump.intra.peff.net> <20200427201228.GD1728884@coredump.intra.peff.net>
 <20200428135222.GB31366@danh.dev> <20200428210750.GE4000@coredump.intra.peff.net>
 <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com>
 <nycvar.QRO.7.76.6.2005012130010.18039@tvgsbejvaqbjf.bet> <CAKiG+9UvnLtF7eS9FsPLyRR4ZPNSnakZwyYy3dO7WoAnRpvoMA@mail.gmail.com>
 <xmqq4ksyl4mz.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4ksyl4mz.fsf@gitster.c.googlers.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sun, 3 May 2020 21:03:29 +0530
Message-ID: <CAKiG+9Vvwz_ajhJ1KPVWtq25UaGtJOH57eXTA=cgm5qzoZCfGw@mail.gmail.com>
Subject: Re: [PATCH 0/8] CMake build system for git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Danh Doan <congdanhqx@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 2, 2020 at 9:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:
>
> >> How about contrib/cmake/?
> >>
> >
> > The CMakeLists.txt will be non-functional if it in any other directory except
> > the root source directory. To help users we can,
> > add some instructions in INSTALL on how to use the script.
> > OR
> > create a dummy CMakeLists.txt in the root directory which just
> > says
> > `message("Copy and Replace the CMakeLists from `whatever-folder` to here")`
> > along with some instructions if necessary. This is what LLVM does for autoconf.
>
> Isn't there a corresponding feature to make's "-f" option to specify
> which file to read instructions from?

Sadly, CMake expects CMakeLists.txt only, nothing else.

>
> As you say, an extra instruction in INSTALL file to tell users to
> copy from contrib/cmake may workable, though it is unsatisfactory.
> But the other one will not simply work.  If we need to have a new
> file with string "CMake" in its name at the top-level *anyway*, we
> should have the real thing to reduce one step from those who want to
> use it.  Those who do not want to see "CMake" at the toplevel are
> already harmed either way, if is a dummy or if it is the real thing.

In your opinion, what would be the best way to communicate with users, there is
an optional CMake build system for git?

Thank You,
Sibi Siddharthan

>
> Thanks.
