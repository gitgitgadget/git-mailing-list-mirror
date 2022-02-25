Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F9EC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 18:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiBYSjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 13:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiBYSjc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 13:39:32 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06704BC99
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 10:39:00 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id z66so5238391qke.10
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 10:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qQzBeaQffECt9g1+W2GJ92a7PKw5DAc2YlM7EMH4yLs=;
        b=RwRC7+qOe7L//m/fok0jTtcEezDIiTy29TG2IcxOF2+vLzFLNlRYtLIGBYnPNx+FMG
         7vrTmgVTlQVsFpKqScreOiHXp5dXYkBJ30Ful8yS5kS81dar9PIzm5dbC9mOg2CpFrGH
         R/3GHqJ5YWNlrVAMCVYRR6Ow43a2h7mn9bQccEHuFGpHZcPn4nMQjJow1Ez48wAaDwfI
         s6Ph1t01JHaxvdOBfWDZHuLI3kBZpD+aWC5IlnROGZklw3dh3kxBVhGfAr/j3UHec9Fo
         r+NMzgEyeKjXCWEqcCAtxEpS9KUBxMe4bZpbKN4Y/nlKaC/tj4ssIeBE2IvsK8SXc0XV
         72HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qQzBeaQffECt9g1+W2GJ92a7PKw5DAc2YlM7EMH4yLs=;
        b=X/mpR4QbcHxSKVg3G2bZB7esZkapOIVvpB/jx5exMij1Zb1T/7i7lHQ4BKBn3S7/5m
         JHNb29Cy/quVBhRWSLJoEfy9OlPciokzdlbkOGd6I5UWTfr09dceD7vlRhfdv88Cf1kI
         Vh/OAXvXOTKcUh8iB/WYQBmM0vYNFo7wMHHFwRn1bQrUj65/QuSwbaoI3iDTwFqrPteS
         7L6FokxfPJKNqYrDIR6R7sUzr+DMapvoBOaO8ReuXJwt5VvWl+CzwiZZvRUPneZy5hAt
         PBJog4JYsskntAths3bj/SnYbUqUxncNDdgghuZ9lWe73r8GGh6Rl0Pro4I7vp5680k/
         gyKw==
X-Gm-Message-State: AOAM5303hcP8Dy7BgmamDuPIIN1XLcd95N0GJCHij0Ez0bC0eK10ztUM
        hP5JczRtbJC/WPKQruOKSv/kRTs+UHSTeImb
X-Google-Smtp-Source: ABdhPJzVw0sGImDX3XVRhKfK+PCR5yf7ufPevTTJ/uP7lE/OlZ0beO8PWPiEa2N+CjIPLFJE6w9cWA==
X-Received: by 2002:a05:620a:ec9:b0:608:292f:8479 with SMTP id x9-20020a05620a0ec900b00608292f8479mr5771229qkm.328.1645814339116;
        Fri, 25 Feb 2022 10:38:59 -0800 (PST)
Received: from 811aa366e12e ([50.234.189.46])
        by smtp.gmail.com with ESMTPSA id u26-20020ae9c01a000000b0062ce6955181sm1520640qkk.31.2022.02.25.10.38.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Feb 2022 10:38:58 -0800 (PST)
Date:   Fri, 25 Feb 2022 18:38:54 +0000
From:   Edward Thomson <ethomson@edwardthomson.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 1/1] xdiff: provide indirection to git functions
Message-ID: <20220225183854.GA9@811aa366e12e>
References: <20220217225218.GA7@edef91d97c94>
 <20220217225408.GB7@edef91d97c94>
 <e73c6746-9f8d-7e23-3764-18d01307278b@gmail.com>
 <nycvar.QRO.7.76.6.2202251639590.11118@tvgsbejvaqbjf.bet>
 <xmqqo82udctt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo82udctt.fsf@gitster.g>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 25, 2022 at 10:24:14AM -0800, Junio C Hamano wrote:
> 
> Not so fast.  I still do not see a strong reason to support
> xdl_malloc() and other wrappers.

git has an `xmalloc` but no matching `xfree`.  libgit2 does not
necessarily use the system allocator (and on Windows, you run into the
question of _which_ system allocator you're using) and therefore has its
own allocation _and_ deallocation functions.

When libgit2 includes xdiff, I don't want to monkey around and try to
redefine `free` to our deallocator.

There are several options that could suffice for this.  A different
tactic is to have xdiff call `xfree` which is just defined as `free` in
git.  This would feel non-obvious to me as a git developer that in this
one part of the project, I need to use `xfree` instead of `free` on
memory that I have `xmalloc`ed.  Using a net new name for allocation
functions may help serve as a reminder that it is a different API.

> Is the expectation for other projects when using the unified code,
> they do not use xdiff/git-xdiff.h and instead add
> xdiff/frotz-xdiff.h that defines xdl_malloc() and friends with the
> infrastructure they provide as part of the Frotz project (and the
> Xyzzy project would do the same with xdiff/xyzzy-xdiff.h header for
> them), making "git" the first among equal other consumers?

No, the thinking is that they would provide their own `git-xdiff.h` that
defines the mappings to their project-specific APIs.

Cheers-
-ed
