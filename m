Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E82C20365
	for <e@80x24.org>; Thu, 13 Jul 2017 20:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbdGMUr1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 16:47:27 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33055 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753173AbdGMUr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 16:47:26 -0400
Received: by mail-pf0-f194.google.com with SMTP id e199so8419445pfh.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 13:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4eycNtRmiXBiZjvhvVc/z9KVUjPp4PKBKANgn0vKTq4=;
        b=QJWwSPUPDq2NhTPsgcH5sQgGZMdXry61Nbtx6uf8TGUmvKhreGArtAgGC+TEEreEdb
         zcKQr1P34Go1YWWKvUEtCXp3RWTAMrDRYQH8kY1f2p3KAX1xk7LsyKLHYvoBTuqGFTD1
         YtoLgM0osIeuqaLQmIC2vN92lFFitbGLUKfVGdVppm1lHWA1pKecZvE4raFl+weFoUC2
         /Uovjkr2YK7okykp0ZsnF36ZLW9J2sTZqIfChujugsian1vSMEUKGJKp9lhTTNWnm00K
         fEkeQT+Y4gj+Md46wWugxsEZ1wb46ryHqlYx3VyanNpNynIrjr+lGHrlhVrrgHG0NERu
         EK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4eycNtRmiXBiZjvhvVc/z9KVUjPp4PKBKANgn0vKTq4=;
        b=AMYqKjg5qUA00XD93f/GxGcYg6lyywMLIRvTlE9nYTB8opMY83RHUbGpvu9G36GUaH
         WUUvzFZnXXaAJe+286Js2frcXK2kOrwoMxZGFrZ7BKtV8JeLi50Yp6S859zS+4eESrz0
         zi3ENf/T74lVm+XExoNH5rmuk+Z0k5LSpZM8fv0nJOmUYJ2cqY2aoYYnP8F+pQdTiIq6
         +VSsLbdWOiJiZ8d1pdl1+SRjbGgfEJLODUTAwRfO+9PvT63bvMtK4SWT0/jO0g6Q+eaT
         1D465phoykOlVznk1sfvA8vB8hxjHn/5JR3mUisqlkIm6oxVwLauKFBbCH0ammZMpPJ5
         +23A==
X-Gm-Message-State: AIVw1122CUDENIYKAhLOdrIsopgHkdQV8fD/Y2Op6UTwqILKx3S11Xuo
        5MC5A+ZP24O+5w==
X-Received: by 10.84.164.193 with SMTP id l1mr12422136plg.106.1499978845683;
        Thu, 13 Jul 2017 13:47:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id h80sm16166624pfk.80.2017.07.13.13.47.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 13:47:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] RFC: Introduce '.gitorderfile'
References: <20170711233827.23486-1-sbeller@google.com>
        <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
        <20170712205734.h77fgbbkavwpkr4h@sigill.intra.peff.net>
        <CAGZ79kYYg6-UMrKRPeJTbHdGR0juZ2OwFZmkuYgeYe5X+cm_sQ@mail.gmail.com>
        <20170713155923.a2nissoyczvewoh3@sigill.intra.peff.net>
        <CAGZ79kbgypimtWE32SnDrG-QWT6gF3WGxR5mi785F_rwvRPOuA@mail.gmail.com>
        <xmqqr2xkw3qt.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kao8=L33jqSFdmYp4NhKfCKDmoqYWvCzuMJ2+Pfq=SYEA@mail.gmail.com>
Date:   Thu, 13 Jul 2017 13:47:24 -0700
In-Reply-To: <CAGZ79kao8=L33jqSFdmYp4NhKfCKDmoqYWvCzuMJ2+Pfq=SYEA@mail.gmail.com>
        (Stefan Beller's message of "Thu, 13 Jul 2017 12:20:09 -0700")
Message-ID: <xmqq8tjsukrn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The point I was trying to make is best demonstrated in
> t5526-fetch-submodules.sh:
>
>> ok 7 - using fetchRecurseSubmodules=true in .gitmodules recurses into submodules
>> ok 8 - --no-recurse-submodules overrides .gitmodules config
>> ok 9 - using fetchRecurseSubmodules=false in .git/config overrides setting in .gitmodules
>
> They were not suggestions, but defaults dictated by the project.

Yeah, and that is why I kept thinking that recurse-submodules may be
a huge mistake.
