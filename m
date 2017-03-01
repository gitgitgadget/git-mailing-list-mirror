Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE4362023D
	for <e@80x24.org>; Wed,  1 Mar 2017 17:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbdCARhs (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 12:37:48 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:35885 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdCARhq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 12:37:46 -0500
Received: by mail-it0-f52.google.com with SMTP id h10so101574732ith.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 09:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SBMpSwNHc6KhE6Sg64RY0LeLXuFj+9RVbYhFTj8rMdA=;
        b=QEGrPlVlpKQmLyApJgrHZZfsD9cwo7ZJ+MXDJi5FDIpIos5ch9zfP9kLZi6ICgtMNF
         0mP/O4qHBnFOh5K53W4EqqHTke7bD5J17I0eaT55m6WqEjyMK3Pim8/t47IqXjHjK7mj
         tIA2BqoeJENn8rW+0hutYVJninw9s789zRQ8vIWajbIhA6Zk0yV+oXefeTNldqb4NdII
         f5rMsVpluHQgnGC6Gfvij2NzRHArtmVcloIQzfZt2jSZogSC3LrUrEOq79DF+RNgP/Z2
         q/upAgqlDlYiEX7lrHZy+65prbzut4YxGhLEFQxBA7thgqbdtV9GuXXUNJuiX+3fuSZD
         oCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=SBMpSwNHc6KhE6Sg64RY0LeLXuFj+9RVbYhFTj8rMdA=;
        b=eBOF1ODrVzuumZEz0bs7BVOP75UYkF0YpvEi6vMBmY0SsQNgWomesct+gnYoW47FSL
         8yAgx49SGfq89GlAM9bYFnBHTFnLtuaoQp2Ik0FF1En2gdUCPeqwK11MsrX//ngxCX+Y
         jFVfG1txFY7k/sNy74UvZ3PaClpumxJ/JnDriUeMPml+SE4NKM9Vy7twwSjAD7vdBI8U
         u2y6xbgtzeiXnzwNpFfr2gQijUDjRkcdXXn/ZvIZQj99x5eqpVzdJkMwdPn6aa6Swzfw
         JaopYy0ShAdqSiYCO3l8q+ZoJ4KhTtRmkXUNEpRWbbQizv+Yf6uOjxjUslPDVD2hYOh8
         xa0w==
X-Gm-Message-State: AMke39kdpqNAb2N7erlq1rvkFg7nOUDNW1iTtbX6Q0vqquMD52yWIDo5qmwJiK727LRiY1qMMojoK1esU44zVQ==
X-Received: by 10.36.144.132 with SMTP id x126mr4894471itd.35.1488389787959;
 Wed, 01 Mar 2017 09:36:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Wed, 1 Mar 2017 09:36:27 -0800 (PST)
In-Reply-To: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com>
References: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Mar 2017 09:36:27 -0800
X-Google-Sender-Auth: iS7_QEn7a3J2SMsdnveXszN19eM
Message-ID: <CA+55aFzQ0o2R2kShS=AuKu0TLnfPV-0JCkViqx5J_afCK0Yt5g@mail.gmail.com>
Subject: Re: Delta compression not so effective
To:     Marius Storm-Olsen <mstormo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 5:51 AM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
>
> When first importing, I disabled gc to avoid any repacking until completed.
> When done importing, there was 209GB of all loose objects (~670k files).
> With the hopes of quick consolidation, I did a
>     git -c gc.autoDetach=0 -c gc.reflogExpire=0 \
>           -c gc.reflogExpireUnreachable=0 -c gc.rerereresolved=0 \
>           -c gc.rerereunresolved=0 -c gc.pruneExpire=now \
>           gc --prune
> which brought it down to 206GB in a single pack. I then ran
>     git repack -a -d -F --window=350 --depth=250
> which took it down to 203GB, where I'm at right now.

Considering that it was 209GB in loose objects, I don't think it
delta-packed the big objects at all.

I wonder if the big objects end up hitting some size limit that causes
the delta creation to fail.

For example, we have that HASH_LIMIT  that limits how many hashes
we'll create for the same hash bucket, because there's some quadratic
behavior in the delta algorithm. It triggered with things like big
files that have lots of repeated content.

We also have various memory limits, in particular
'window_memory_limit'. That one should default to 0, but maybe you
limited it at some point in a config file and forgot about it?

                                     Linus
