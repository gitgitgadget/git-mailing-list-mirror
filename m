Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA161F404
	for <e@80x24.org>; Tue, 13 Feb 2018 19:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965594AbeBMT01 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 14:26:27 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34951 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965315AbeBMT00 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 14:26:26 -0500
Received: by mail-oi0-f67.google.com with SMTP id e15so14723518oiy.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 11:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FVkoS3M5/rsk77Tno4/LzXswJPdWC0elBAiE7UJ9dX8=;
        b=f2YL5a5fXYpLFrDAqf1GNkwO/G4sC0dqgDf+CLKC/zIbC7yKmLLptlb75xZovOyYey
         IxM6spZuZK+FGkBTTcGnqMLdkiuZ8tPVxDsTKibxM3FK7LHeWYTd+ZuA3Fs6AyTThJsg
         GFmrXTQ9wIHANL95WXh35KJXtWZjmwQFA1IsfpoH8V6rnRgaL0bbwU9UOLJywmdG9ZMN
         iUqUtetGnxABAFPvV/JAIqZybJFyZeqnS2FCJZwkiD0CMeN7mGfNuz5qxvdAJsb9+1IM
         dls44TSX9BRL73AkDDNcVtUikONxubuMZP9wPwA2hidB7VTdlrau53xgDKkHLDR5P4IG
         sPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FVkoS3M5/rsk77Tno4/LzXswJPdWC0elBAiE7UJ9dX8=;
        b=GwgZ+8Q2Am5EwfXItLYxwMjcLLFzxWw0v1CXI1Deg+cEZ8aMVmniF7MB2Wn+ipPhct
         JcYHcPdc1eKqU97ZfUp2jMUh7lEIJnevvv7SLNjx7DPzmNosYs+kxXHVpZEs7WQMd7nF
         vn/yryXOE3XY0HH22vE0DjX0ZDiRV3KaTzaJlvuTingyknYhgFJ6nfHppT0mYpkdgisl
         q6CeF0NzgxLkyelmcrsreeLUej/eruWLG9Brs6PiPESal/yx4UMs9D5GZB3zh7mf1I21
         Odiuh0vOwCqb/8qtT4KQdAwO1GGGVF1rwkWqG+GIG25Sfux7JrLu/3dZ21I5BoEUw4lQ
         LfMA==
X-Gm-Message-State: APf1xPCdGDcXG/xkW80hehnyUYGZlkajNZyC5j1UCBXluZIowVOIxqbt
        vmSdnqzlMbME65jtbVrPn5az49yx
X-Google-Smtp-Source: AH8x2247e2x4cfYPABaU7jadPEuZ402UwH3gA0rM94t6r7yCzICZUHeGL8D5BpksT2mjczh5A/u9UA==
X-Received: by 10.202.0.144 with SMTP id 138mr1427437oia.331.1518549985449;
        Tue, 13 Feb 2018 11:26:25 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x47sm6604548oth.62.2018.02.13.11.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 11:26:24 -0800 (PST)
Date:   Tue, 13 Feb 2018 11:26:21 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com,
        sunshine@sunshineco.com, jonathantanmy@google.com
Subject: Re: [PATCH 00/26] Moving global state into the repository object
 (part 1)
Message-ID: <20180213192621.GC42272@aiede.svl.corp.google.com>
References: <20180213012241.187007-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> This is a real take on the first part of the recent RFC[1].
>
> Jonathan Tan suggested[2] that "sha1_loose_object_info to handle arbitrary repositories"
> might be a good breaking point for a first part at that RFC at patch 38.
> This series is smaller and contains only 26 patches as the patches in the big
> RFC were slightly out of order.

Thanks.  This looks like a nice reviewable series, so I'm happy to see
it broken out.

[...]
> Comments in the early range of that RFC were on 003 where Junio pointed out
> that the coccinelle patch ought to be not in contrib/coccinelle, so I put it
> in a sub directory there, as 'make coccicheck' doesn't traverse subdirs.

Can you say a little more about this?  Was the problem that the
semantic patch wasn't idempotent, that it was too slow to run, or
something else?

If we're including the semantic patch for reference but never running
it, I think I'd prefer it to go in the commit message.  But if it's
useful to run then we should make it idempotent so it can go in
contrib/coccinelle.

[...]
> Duy suggested that we shall not use the repository blindly, but should carefully
> examine whether to pass on an object store or the refstore or such[4], which
> I agree with if it makes sense. This series unfortunately has an issue with that
> as I would not want to pass down the `ignore_env` flag separately from the object
> store, so I made all functions that only take the object store to have the raw
> object store as the first parameter, and others using the full repository.

I think I want to push back on this a little.

The advantage of a function taking e.g. an object_store as an argument
instead of a repository is that it increases its flexibility, since it
allows callers that do not have access to a repository to call it.  The
disadvantage is also that it increases the flexibility without any
callers benefitting from that:

 1. It ties us to assumptions from today.  If e.g. an object access in
    the future starts relying on some other information from the
    repository (e.g. its config) then we'd have to either add a
    back-pointer from the object store to its repository or add
    additional arguments for that additional data at that point.

    If all callers already have a repository, it is simpler to pass
    that repository as context so that we have the flexibility to make
    more use of it later.

 2. It complicates the caller.  Instead of consistently passing the
    same repository argument as context to functions that access that
    repository, the caller would have to pull out relevant fields like
    the object store from it.

 3. It prevents us from making opportunistic use of other information
    from the repository, such as its name for use in error messages.

In lower-level funcitons that need to be usable by callers without a
repository (e.g. to find packfiles in an alternate) it makes sense to
not pass a repository, but without such a use case in mind I don't
think it needs to be a general goal.

To put it another way, most callers do not *care* whether they are
working with a repository's object store, ref database, or some other
aspect of the repository.  They just know they want to e.g. read an
object from this repository.

It's similar to how FILE * works: some operations rely on the buffer
the FILE * manages and some other operations only rely on the
underlying file descriptor, but using the FILE * consistently provides
a clean abstraction that generally makes life easier.

> Eric Sunshine brought up memory leaks with the RFC, and I would think to
> have plugged all holes.

Yay, thank you!

I'll try to find time to look at the patches in detail soon, but no
promises (i.e. if someone else reviews them first, then even better
;-)).

Sincerely,
Jonathan
