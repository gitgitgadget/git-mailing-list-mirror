Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F33511F404
	for <e@80x24.org>; Sun, 18 Mar 2018 05:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750949AbeCRF2f (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 01:28:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50999 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeCRF2e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 01:28:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id w128so9814231wmw.0
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 22:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=44mGvgCGEOJpdd2jwREU+NIwovEKNS05cphx4PvzlC4=;
        b=Z/Fl4j6htvoYbPlDuLGWqC3OzV2L6oGulLPGVxAKoHOCmc5Kce0vuNxIBcjYceRV5b
         57dXqzpu5pnNMSBndb7RmmsG++dgtCrK9OfDYqWyM9J0FSWGk7R7cscxXcMC/WbBe981
         7k6pcpqDVIjgzZyxNFW+oU5amPrrK6avQ6+mltw3MWC0xDl0P7o/BS5R5sxpXKfXSnuN
         V2nTnek2N7jre1MH+TQEzAaHW0XTpzyTcITTfqFCmT5fti4lr0KFMidogNWVb/eqaTMu
         lR8xRnEbQpqXmn+UnAd23QJiHGmpwC66vb17yc1pfLS/R+kR4kS+PWdWKjpylAj5B3JV
         NhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=44mGvgCGEOJpdd2jwREU+NIwovEKNS05cphx4PvzlC4=;
        b=VXevdB9E6UGK/UmpznG/HWOpCepn4K+VCz+o0gz7LXKQmQa/xlb6LY7Po8C2sTs0iL
         4soJVD7ZgEUAB2hMnhk91iOaQEqoLlr08Yk+wT7o8pRIk5v//sHI24WsVzrge1kCbgXv
         H6yi4GLOZ4s8IFW8smptfiD6EQ56EJggh9NmRWQr1RDwC3sf2LIPUU8dgxIX0wcDHdvi
         8ZRWW78LriVsvLneFMV5IO1JQSc+JxBnmFQKiRnqaTqDVJHRrnlY6OxQMt9HoQtU+4h4
         cx/vtgnFG2Dez2zYc9lh3sGrDJUp9+wUWRVYOdm/AIuQq3lZoZxKWNeMj7TcqzECOSV5
         fFPw==
X-Gm-Message-State: AElRT7GqShFHFQzvXAAH1fK7trmx3X7uqMDNaSYCjLXCcrN+9zgZlpzF
        tSkvXk9LeYXTPe/9Z/C8GCE=
X-Google-Smtp-Source: AG47ELtsw0WSl7GgICAP+IZ6e0og2MZv/B31EHoeZJZ1d7SpA7Tz++pJpJak+PJfCd+834Dgddlz1Q==
X-Received: by 10.28.136.74 with SMTP id k71mr5100917wmd.46.1521350913376;
        Sat, 17 Mar 2018 22:28:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c14sm12900405wmi.16.2018.03.17.22.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 22:28:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Clemens Buchacher <drizzd@gmx.net>, git@vger.kernel.org,
        manlio.perillo@gmail.com, johannes.schindelin@gmx.de
Subject: Re: [PATCH 2/2] completion: simplify ls-files filter
References: <1521274624-1370-1-git-send-email-drizzd@gmx.net>
        <1521274624-1370-2-git-send-email-drizzd@gmx.net>
        <20180318012618.32691-1-szeder.dev@gmail.com>
Date:   Sat, 17 Mar 2018 22:28:32 -0700
In-Reply-To: <20180318012618.32691-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Sun, 18 Mar 2018 02:26:18 +0100")
Message-ID: <xmqq4llex88v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> First, neither 'git ls-files' nor 'git diff-index' produce quite the
> same order as the 'sort' utility does, e.g.:
>
>   $ touch foo.c foo-zzz.c
>   $ git add foo*
>   $ git diff-index --name-only HEAD
>   foo-zzz.c
>   foo.c
>   $ git diff-index --name-only HEAD |sort
>   foo.c
>   foo-zzz.c

Doesn't this depend on your locale?

    $ printf "foo%s\n" .c -zzz.c /c | LC_ALL=C sort
    foo-zzz.c
    foo.c
    foo/c

    $ printf "foo%s\n" .c -zzz.c /c | LC_ALL=en_US.UTF-8 sort
    foo/c
    foo.c
    foo-zzz.c

> Second, the output of 'git ls-files' is kind of "block-sorted": if you
> were to invoke it with the options '--cached --modified --others',
> then it will first list all untracked files in order, then all cached
> files in order, and finally all modified files in order.

This is a lot more important consideration.

> I have a short patch series collecting dust somewhere for a long
> while, which pulls a couple more tricks to make git-aware path
> completion faster, but haven't submitted it yet, because it doesn't
> work quite that well when filenames require quoting.  Though, arguably
> the current version doesn't work quite that well with quoted filenames
> either, so...
> Will try to dig up those patches.

Thanks.
