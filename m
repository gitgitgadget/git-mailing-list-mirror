Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC48D201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 00:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751431AbdBYAp1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 19:45:27 -0500
Received: from mail-ot0-f172.google.com ([74.125.82.172]:33851 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdBYAp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 19:45:26 -0500
Received: by mail-ot0-f172.google.com with SMTP id x10so24749247otb.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 16:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CZcFdYtJzrnhgto2pNcWxOvfrAw1DchrU+3aeVCT6GI=;
        b=KZ0fdb9LMECLaJ0yi+Otd0CK2P5Ve+noB9HY4qnfMQWor8WoiJ5rvA6BDGPovi0vM6
         mvqU05oiKeC7wOAaOWeQKG6f8O2xRhWDJd4poiopC5dZFDAIAac0a8ptYQso0GE05nIU
         QlL51YPliLw5N91v0uXDCSl1eMJLyfkwpdB/05tmt9HaotF4RuVX4aezdeqmwcMirrtC
         yw2r7bx9XeUQCz+3h3gn5XiHXeXnYEEkPqeSUrJIjoxkvrafwu4/x7QVZjv74hJV/Zo+
         4Bxao9GX8rEaKN2KYCVYlOAyd955o9yD1yIyCQgtdQKVLzcEasQNSyoyurVR+x5syeg6
         HyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CZcFdYtJzrnhgto2pNcWxOvfrAw1DchrU+3aeVCT6GI=;
        b=gIFHMiKSQ4zYqjuebGwX+OdY1eR1T0njDYnTRVL5ivIGt0FVKQu3brVFY+u44BRLmz
         TXHZe3NbZ5YTCrNDm0Yfr448KMjtRNQVTn6BZo4bimozKwUWpYJwgO0hKkVmyfOE41SH
         +IU/1s3PX7VPR0StXSWy8RvfW/xEL4yOlz4bkl5utL8HuUvL+hn8KiTToPd16vcoAiM+
         SKnvBGOCSEsIdjlM2dmM0oks2XSrJ5UvuzkGEwi38S7ojF0TDv6qQ7KJB/S36k/TGqwy
         MjWIK+WGBi/Qqx/Bx5Stkur0Z8tKE0GNUxIBhOAls0/M51bfZ5u8b6CgMVNoEGK7zsK9
         +Dag==
X-Gm-Message-State: AMke39mI9TMB37vNNejvl1SI5wGJO7yfpmTZjhIg2Yh0dDSHBtkltffa5YbSJ+6BAhVtqN4mHErLmHi4mc+eZA==
X-Received: by 10.157.48.162 with SMTP id s34mr3557995otc.269.1487983449562;
 Fri, 24 Feb 2017 16:44:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.164.66 with HTTP; Fri, 24 Feb 2017 16:44:09 -0800 (PST)
In-Reply-To: <20170210050237.gajicliueuvk6s5d@sigill.intra.peff.net>
References: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>
 <20170210050237.gajicliueuvk6s5d@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2017 16:44:09 -0800
X-Google-Sender-Auth: lNpQy9To2pb77zDOdRxJqVqH4gE
Message-ID: <CA+55aFxY2CMJxdDs-LGChJFxHmhjnifEoi-aDV3AmDu8goM+rg@mail.gmail.com>
Subject: Re: [PATCH] mingw: use OpenSSL's SHA-1 routines
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 9:02 PM, Jeff King <peff@peff.net> wrote:
>
> I think this is only half the story. A heavy-sha1 workload is faster,
> which is good. But one of the original reasons to prefer blk-sha1 (at
> least on Linux) is that resolving libcrypto.so symbols takes a
> non-trivial amount of time. I just timed it again, and it seems to be
> consistently 1ms slower to run "git rev-parse --git-dir" on my machine
> (from the top-level of a repo).

Yes. It's also a horrible plain to profile those things.

Avoiding openssl was a great thing, because it avoided a lot of crazy overhead.

I suspect that most of the openssl win comes from using the actual SHA
instructions on modern CPU's. Because last I looked, the hand-coded
assembly simply wasn't that much faster.

We could easily have some x86-specific library that just does "use SHA
instructions if you have them, use blk-sha1 otherwise".

Of course, if we end up using the collision checking SHA libraries
this is all moot anyway.

                 Linus
