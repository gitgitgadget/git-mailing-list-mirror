Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BCAE1F461
	for <e@80x24.org>; Thu,  2 May 2019 09:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfEBJVJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 05:21:09 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:50604 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfEBJVI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 05:21:08 -0400
Received: by mail-wm1-f41.google.com with SMTP id p21so1766631wmc.0
        for <git@vger.kernel.org>; Thu, 02 May 2019 02:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=VoXf0Tm3p1D/18A0bCfLY01rNtIvqJOmKw/6iNdXqxo=;
        b=q08+oC22681AFbdnK8aTcAksY9z84BDw6EubnHCsqGp7acU1Nj42cvPRHM/Q74wFeu
         pzRhAMYAtIWU+f0TrgjaNTX4WHNGGk3AhwFmMa9GGYqlAo5oTJo77yXzULbEhojJPR9I
         IGASy/Ki7jeD1WFSzhXy77Y2YdeEUeMPvxp8+Ek5OIV9X2+hdXwClUNhEBNFqfjiOkvh
         o0EHISx3PZJzZl8ek8ci66RXqKtQVpRpJakBxtyiOQf8+1XlmEmG5blX+rECLyK4Exuf
         38wCyT6rqAIMqnXs5inbI777AFDV9LlHKDlgbAbm+3QxfnK3/tV9Yb9cP5UtLyMg39xw
         OLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=VoXf0Tm3p1D/18A0bCfLY01rNtIvqJOmKw/6iNdXqxo=;
        b=EevssFBv2xnzDubHn+BQWF68wWGTAzz2GpHtpTn4ItF3ayM/JLou1OgVc2tLXfN2xn
         xvFcEnwya2p+FKfcjI1ne5UIpesEhYLfVQR7AK4Aq4Yv+7GiZSzHJMAnk0f1g869uWI/
         KA+NBi9qstHK04qkxkiH/NnCw9LN7qRyMSVbMeaEH5HiOhjMN/lArhueodyb7T0cXvIy
         qJqE5zS7SK+R/jhriQouyLW2q+cfJgfsZbe13bmmds0iDBuOJxXR0U00g+KwRCKlXC2E
         S+W9olHTtdlOl/OBLMyA6/jNz2y19er00iQvG18+S4oN5sk8gbW3jsapKqvint9+gFHD
         Zo+w==
X-Gm-Message-State: APjAAAWTb5LKGPenif1iNERyrJnXx2MypqW5G7Y2fEnl2ZpHhEj3ZRTi
        ZfSYU6mj4o2wLUIqcy4YrwQ=
X-Google-Smtp-Source: APXvYqw1efQu0w0c3KD9N02t7isiSFEgIqa8x/jJxSILeaT1dHEf8sT/Oo7aB/SuEpv83hEYGs3rvg==
X-Received: by 2002:a1c:1b08:: with SMTP id b8mr1631006wmb.35.1556788866996;
        Thu, 02 May 2019 02:21:06 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id o5sm7250143wmc.16.2019.05.02.02.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 02:21:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        meta@public-inbox.org
Subject: Re: "IMAP IDLE"-like long-polling "git fetch"
References: <20181229034342.11543-1-e@80x24.org> <20181229035621.cwjpknctq3rjnlhs@dcvr> <20181229043858.GA28509@pure.paranoia.local> <CAGZ79kb9Tbnxe1mSnxpqT_FO6Gdi6wxd-r2YarHXRF1sVRyxLA@mail.gmail.com> <20190502085055.34kkll2deowat6il@dcvr>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190502085055.34kkll2deowat6il@dcvr>
Date:   Thu, 02 May 2019 11:21:05 +0200
Message-ID: <87ftpxqkji.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 02 2019, Eric Wong wrote:

> Stefan Beller <sbeller@google.com> wrote:
>> IIRC, More than half the bandwidth of Googles git servers are used
>> for ls-remote calls (i.e. polling a lot of repos, most of them did *not*
>> change, by build bots which are really eager to try again after a minute).
>
> Thinking back at that statement; I think polling can be
> optimized in git, at least.
>
> IIRC, your repos have lots of refs; right?
> (which is why it's a bandwidth problem)
>
> Since info/refs is a static file (hopefully updated by a
> post-update hook), the smart client can make an HTTP request
> to check If-Modified-Since: to avoid the big response.
>
> The client would need to cache the mtime of the last requested
> refs file; somewhere.
>
> IOW, do refs negotiation the "dumb" way; since it's no better
> than the smart way, really.  Keep doing object transfers the
> smart way.
>
> During the initial clone, smart servers could probably
> have a header informing clients that their info/refs
> is up-to-date and clients can do dumb refs negotiation.

Doing this with If-Modified-Since sounds like an easier drop-in
replacement (just needs a client change), but I wonder if ETag isn't a
better fit for this.

I.e. we'd document some convention where the ETag is a hash of the refs
the client expects to be advertised in some format, it then sends that
to the server.

That allows the same thing without anyone keeping more state than they
keep now in their local ref store

On the fancier side I think bloom filters are something that's been
discussed (and I believe someone (Twitter?) had such an internal patch),
i.e. the client sends a bloom filter of refs they have, and the server
advertises things they don't know about yet (and due to how bloom
filters work, some things they *do* know about already but tripped up
the bloom filter...).
