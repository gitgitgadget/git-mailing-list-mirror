Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338FBC433E0
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 01:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09B5C64E17
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 01:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbhAaBnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 20:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbhAaBnD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 20:43:03 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4022C061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 17:42:23 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id d85so12824249qkg.5
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 17:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zOyld+j7sExt8Sg8CgvK8MXDfDCFoAxMu+Ph3P7VTJc=;
        b=dfdo5lWVrRt3KxAqUXl1ZMB4OMWk3q8PLIVdjf2n9FsKcf8bU+hu+hJwlERCYeAJqk
         fOtS45WP7vmlgJmJ3yCCL+AX6NvsghF96Kx0YrE68BzJU2Hj6hur//GSl1uhdPHVRbV0
         L/33x2K5TJHAC5FlqZqcwX5uzgXx+iG4k5oQwZDxW02DwkQsKMdFr8nhbC66ES9s1tnK
         ldejBLkpUAZaHfootOxhuoBDE0fPhJEC9IUiKjkYvIChekyH5Kg4dDNsY1cuJWVoPyiv
         6OenWrfKIXUKLMK7KBaSf5lGUhnFFvh/Lqnl9CFR+ZacrR+9fvFAQhefzxFj2oKNML1r
         wx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zOyld+j7sExt8Sg8CgvK8MXDfDCFoAxMu+Ph3P7VTJc=;
        b=mwPcLLZkQ6IEJchNWksJTb4NLSJXXjShhOd8xyQalOISZoOJJ3fd3fZeB6e7Oppgey
         c7xcB9yb1hlVx96LdNjcEUPpg9ZlCM4S7IOzatZaia2yOButnGvdK2T4YjqI1Lb2lqZa
         n/OW78Y1MKCmD7iungeMMR6HmO5ZMYI+IGILQvAN2MS49LHCEfLRSoyDJD9qgpgrVwcz
         XkmSzdmTiM9KDHVbRm8hQfNWFd+gqoEJlj77jJyxOI/GhLdn67Q0InKHLgfo2FxupNXD
         SE8fkpKvLo78F7GdKXRHjLtHBrzJXmsjpPA7JrMSwNwjCk56H/sey1kRzuMZq8NshIXw
         yu2w==
X-Gm-Message-State: AOAM531AHZEC3phAfYI71stNT9UJGRB4gfvDbd/HBOZQI0VUI7ETRDDz
        kLt4oGH8DbQa/KbesmcdjUSE+xOblzfWkA==
X-Google-Smtp-Source: ABdhPJweExVqYQ1iLOA8unpf+GFdphJFA1dwn1I3iMVbKnNqxQu0xFrM4BfkO/+wE16t1fuz72CKhw==
X-Received: by 2002:a37:30d:: with SMTP id 13mr10180285qkd.199.1612057342921;
        Sat, 30 Jan 2021 17:42:22 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:cb6d:aba9:e3c2:e996])
        by smtp.gmail.com with ESMTPSA id 9sm10000983qtr.64.2021.01.30.17.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 17:42:22 -0800 (PST)
Date:   Sat, 30 Jan 2021 20:42:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #06; Sat, 30)
Message-ID: <YBYK/B9G30ro+mF+@nand.local>
References: <xmqqsg6infev.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsg6infev.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 30, 2021 at 04:00:56PM -0800, Junio C Hamano wrote:
> * tb/geometric-repack (2021-01-20) 10 commits
>
>  Expecting further work.

I think [1, 2] provide a good update of the alternatives considered.
I.e., that concatting the packs together is easy but likely produces
poor results, but reachability traversals are hard if you want to stop
early.

I'll work on both and see which ends up cleaner and send that to the
list, probably this next week.

[1]: https://lore.kernel.org/git/YBSSBviXOL8rM3Ao@nand.local/
[2]: https://lore.kernel.org/git/YBSaHHKV5ncjjJum@nand.local/

> * tb/pack-revindex-on-disk (2021-01-28) 10 commits
>
>  Looking good.

Just double checking that you aren't expecting a re-roll of this (and if
you are, that's fine, too). Peff reviewed v3 in depth and left a few
comments, the result of which is a replacement for the final patch [3].

FWIW, he said that v3 (with the replacement for 10/10) looked good.

[3]: https://lore.kernel.org/git/YBNlkvrxvAYrLeMc@nand.local/

Thanks,
Taylor
