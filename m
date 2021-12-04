Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02452C433EF
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 23:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhLDXgV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 18:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbhLDXgU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 18:36:20 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74FFC061751
        for <git@vger.kernel.org>; Sat,  4 Dec 2021 15:32:54 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id b187so8450449iof.11
        for <git@vger.kernel.org>; Sat, 04 Dec 2021 15:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yK1Ggmro4cjTikljLEIWWn6QcGLKDa6RbHLSmjGbjJ4=;
        b=g7GVQb2PAVcfC8evXmTGDJTZNmGs6GvrNI+0X3lRf1keiSiJ+9/I1nDmqNqDUBzT+E
         03Dso+QpdrJCcFRiZp729N1J/FiKoxYCaYZMTsw25GnYSbIM5sFOEH+KZcAV3mcHCUce
         LBykKPgt4rWBxjO4iAYGVC2YG+0rvVB2fgJAZmJOGC+Kv+JvIkKt7i1uHIX9maIDceXD
         kvtegBHoiVidRkkRc9gUk+fDDOl3Uz+SMTIlbfXgE6K2JpGCJpcxZYZVK+0UC07doUpm
         6oQ4CzolnbsmWF8q7HhhAixBMjhCytyj2TzoPvhox1pARaEo9QCJH6r5RJ7Q55aW+m0V
         oXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yK1Ggmro4cjTikljLEIWWn6QcGLKDa6RbHLSmjGbjJ4=;
        b=8MGUSWYyQBJQUl7wZ3ebsWuEGArHC57ND40AIBNRbwe9mNBJcewG5yiiihDMn4pb9K
         93ru47n+lA8kTV7nVfhYfFiSryTdpnPkojX5QuKCDzywplptnl5Q/3/hnTnmxsXPZxiK
         EUQPklZ3cCxxofnxDHTNG0WJr0x20rgSmjug9f6h+YJ/EQYdKTd0D6kJkP6j2GNG+wsR
         F7SAGcjo2LHJClx6+qUctKELvL7nZab4Knua/dNGK85DRTK4dg7ds13AQh0VlWtu6APp
         NZIGFxt3Y/gwlf/HE31uWah1EvR0X6apbAV9jz/1bTp0nabFkskh4qRfvqpuAngMhHlS
         fxyQ==
X-Gm-Message-State: AOAM533k1MvHE/nYyWfKNOtEK8m60+AZtrSvBawy0WgUW5wOwrcKZesh
        BqIffjT7U5nYL9EBWlnvqfi+Soa0A4a/3g==
X-Google-Smtp-Source: ABdhPJwyCAWyuM/YvbhWjwjPmCSl/hki38aBuNo2SPneBfoBrZ2TrEIyRMfeTgit03oOngobFEUmJA==
X-Received: by 2002:a05:6602:2b83:: with SMTP id r3mr27056083iov.93.1638660774106;
        Sat, 04 Dec 2021 15:32:54 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r18sm3755207ilh.59.2021.12.04.15.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 15:32:53 -0800 (PST)
Date:   Sat, 4 Dec 2021 18:32:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH 01/17] Documentation/technical: add cruft-packs.txt
Message-ID: <Yav6pDmSSDzm7lZO@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <a9f7c738e0ffbc5cdedc26768a0623446c98d239.1638224692.git.me@ttaylorr.com>
 <CABPp-BGW3t1LnUGNSLSzYtQfAJuAQKxpHJMJOdh5T2pUyaDWAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGW3t1LnUGNSLSzYtQfAJuAQKxpHJMJOdh5T2pUyaDWAw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 04, 2021 at 02:20:23PM -0800, Elijah Newren wrote:
> > +== Cruft packs
> > +
> > +Cruft packs are designed to eliminate the need for storing unreachable objects
> > +in a loose state by including the per-object mtimes in a separate file alongside
> > +a single pack containing all loose objects.
>
> I had the same question as Stolee here: why not use the cruft-pack's
> mtime for all the objects in it?  Much later below, you make it clear
> that a repository will generally only have one cruft pack which kind
> of answers the question, but the repeated mention of "cruft packs"
> throughout the document subtly made me make the opposite assumption.
> It might be nice to address the almost-always-only-one-cruft-pack
> earlier on, which may also help answer the question about why you need
> to store individual mtimes in an additional file.

Responding to your suggestions out of order ;-). Throughout the
document, I wrote "cruft packs" in the sense of "the feature this series
implements", not "multiple cruft packs".

But my wording is unintentionally vague, especially because this
document does talk about why this series stores unreachable objects in a
single cruft pack. I updated my copy to make clear the difference
between the two, which should hopefully avoid any confusion here in the
future.

As far as why not use the cruft pack's timestamp as the mtime for all of
the unreachable objects contained within it, there are a few reasons:

It makes freshening objects more complicated. Not because we couldn't
freshen individual objects (we would likely do so in the same way this
series does, by rewriting it loose and using the loose copy's mtime
instead), but because it makes it complicated to repack a repository
with many cruft packs. If I have a handful of cruft packs, and freshen a
handful of objects within them, I now need to update many cruft packs,
or pay the price of storing their objects twice (if I instead don't
rewrite them and keep the loose copies around).

It also makes it impossible to share deltas between cruft objects that
don't have the same timestamp, unless the cruft packs are stored thin
(in which case it becomes much more complicated to figure out which
cruft packs can be safely pruned without storing information about which
other packs a thin pack has deltas against).

I'm sure there were others, but these are the ones that I could recall
off the top of my head. This all felt like a little too much detail for
the "alternative designs" section, but if you think some or all of this
would be interesting to memorialize not just on the mailing list, let me
know.

Thanks,
Taylor
