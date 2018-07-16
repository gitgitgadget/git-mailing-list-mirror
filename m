Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C5B2208E9
	for <e@80x24.org>; Mon, 16 Jul 2018 21:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbeGPWAX (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 18:00:23 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41522 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbeGPWAX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 18:00:23 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so15829280ply.8
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 14:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N3/RBQY8buMIwYGYcqhTFMuUjSO9aLJaG/rZIWmA6h8=;
        b=uxooOklfbTtciyfDiAoZOTK0U5xGSdG8SoMAMIEvKxjedMe60ApcKSo2WF5eKEVocD
         Dn7LvkTr3gz8j8QhviXTTSi6PolDGthrfF22PifABSlv4zsH9Vs4zLopVehtngSDCf6E
         LmKzD1Nljz/wlWVKUasv55jwH8AXCkYxjrWGJ7L/bBGmjLYZVnZuvMHXG7faz78vThMe
         PKIUe1FNuYXdRb8XzT+4FH1mgNB9bRLZLLr+2oK0a+D9FL3Dz0IPFeLKjM53olseta7m
         1vApKGHJK7oDV+55xDLR459pbkbFisiC5mSFY3Oz1K9BG14YMn61AZHkShgDd/F3t6Px
         rAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N3/RBQY8buMIwYGYcqhTFMuUjSO9aLJaG/rZIWmA6h8=;
        b=DsgdAQ1N+ZE4ZHuxBIK85g3XMSi9yntHP1A45fcAGYKzwh2Sw5Wu7RNPtUYIa0zlNJ
         fXfMCaWpnUaNTVMYlJEOocBaSSIGCLmaz5mjUP6h5JHpr0fgDlbwBaQTwuzYpBiEMiQw
         B6o/45tveBR3aMLf0KDFYsvh1lQ8PCGXRG1Vn81id8cJQz4jxNDXeL22iNmmMKF8IBMo
         StxvU1Gdi2gkR9Axf7yUG33xB6Loa3YbOojSi4UGFgq55Y8Lz3x0wbTD5tMBfZcvVxng
         HjMnqcScj4Dk2EiEZtl97Gk93wk0usSxcK0xyE9arzmO9jDe5aET42f8YAZ169wn1YRx
         sdZw==
X-Gm-Message-State: AOUpUlFNyXgFRRt0UITAb1KZ0mTiY2rqGqX3hJx/q82E/Q9lKHN55UdL
        Dckk9W4HN/X5M7aniT4LLhs=
X-Google-Smtp-Source: AAOMgpcI5ekSpb8B2BusUT5cDJvmfCZXnh1in1QhZPZYetaY4/XBE8pniqMYEP/AAar93xhwEVij2Q==
X-Received: by 2002:a17:902:d711:: with SMTP id w17-v6mr17713120ply.200.1531776666987;
        Mon, 16 Jul 2018 14:31:06 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n11-v6sm11231372pgc.22.2018.07.16.14.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 14:31:06 -0700 (PDT)
Date:   Mon, 16 Jul 2018 14:31:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716213104.GG11513@aiede.svl.corp.google.com>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716191505.857-1-newren@gmail.com>
 <20180716195226.GB25189@sigill.intra.peff.net>
 <CABPp-BGdzyhPkFYyocqArtMX8=cDKFuV88q3mboeaTDjt275Tw@mail.gmail.com>
 <20180716203847.GE25189@sigill.intra.peff.net>
 <CABPp-BEpCF9FE7eJwZWjY+bMsjDQnnDaSrHO+e3DtDDsR-=7Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BEpCF9FE7eJwZWjY+bMsjDQnnDaSrHO+e3DtDDsR-=7Hg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:

> I totally agree with your general plan to put unreferenced loose
> objects into a pack.  However, I don't think these objects should be
> part of that pack; they should just be deleted instead.

This might be the wrong thread to discuss it, but did you follow the
reference/prune race that Peff mentioned?  The simplest cure I'm aware
of to it does involve writing those objects to a pack.  The idea is to
enforce a straightforward contract:

There are two kinds of packs: GC and UNREACHABLE_GARBAGE.

Every object in a GC pack has a minimum lifetime of <ttl> (let's say
"1 days") from the time they are read.  If you start making use of an
object from a GC pack (e.g. by creating a new object referencing it),
you have three days to ensure it's referenced.

Each UNREACHABLE_GARBAGE pack has a <ttl> (let's say "3 days") from
the time it is created.  Objects in an UNREACHABLE_GARBAGE have no
minimum ttl from the time they are read.  If you want to start making
use of an object from an UNREACHABLE_GARBAGE pack (e.g. by creating a
new object referencing it), then copy it and everything it references
to a GC pack.

To avoid a proliferation of UNREACHABLE_GARBAGE packs, there's a rule
for coalescing them, but that's not relevant here.

It is perfectly possible for an object in a GC pack to reference an
object in an UNREACHABLE_GARBAGE pack via writes racing with gc, but
that's fine --- on the next gc run, the unreachable garbage objects
get copied to a GC pack.

We've been using this on a JGit DfsRepository based server for > 2
years now and it's been working well.  More details are in the "Loose
objects and unreachable objects" section in Documentation/technical/
mentioned before.

Thanks,
Jonathan
