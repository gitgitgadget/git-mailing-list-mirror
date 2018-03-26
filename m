Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 426C51F404
	for <e@80x24.org>; Mon, 26 Mar 2018 16:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeCZQtt (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 12:49:49 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36126 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbeCZQts (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 12:49:48 -0400
Received: by mail-wr0-f179.google.com with SMTP id d10so19616951wrf.3
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MvOazrE4SxfGFg1MZ94bXcNK42X+kkGPXLU0OGwAe5Q=;
        b=b/3FJe/uZdBmX+a2z/a56pm17Z5j4r5U2M0g6rfDHLhTgUvFB+uvKDMvO9gfUUqEHG
         tL1kkArUZvTjMt3jS0xlO2VIa66AqkMdrsa04bC5ifmaq3BsGUyCUaPluVK8ThQ7XnNP
         1aCGUuAuadXdoRPMePXYEjUs/gw66BOZB0bft69XhWSSKDUvP+6tEpHC5EXTFynXxcij
         +mhEjgmk7elLmIs7ZMMijDMxQIg5S2cqOvzwXxwNAQSoDMaaq9cUj8m6PkmhQYSGWii3
         /eMmv8gplLpn3Ny8rEd4cpmLBQTyOwG/+KtG9p8k+/MRXnYGB4AQ8YAzyzILtnb1W+4e
         bXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MvOazrE4SxfGFg1MZ94bXcNK42X+kkGPXLU0OGwAe5Q=;
        b=ShLFwLIf+6nJb91PjBn1KBGaCco6euo5w/ZWvv2yf2W/+CIxXnyOQZH37LxvbHucSs
         OCJJBzgsUdVBBGN+Q1R5nosdRx44dj8WVTn4gq4xFPLQbyssGIU/kjagH0TgEH3pptwr
         XG/kSzbMohsRUB8HQx0u2VZxubbCifSXUpiuDec6CXs9Vleb9Zwr9x3M8HPUn48UKEFT
         NFHm8Xg7NWg3purN/qgn9oXyZZpntMSG38wiSqGW3GenALov581oN4kQnQY4nmmX6wJb
         Z4CiFZ9BsJXnO+Lo3fR7Lz7+nL8wc/QGFQn8lGWkd8rDvKRq9U6aiqCwu4PvbruL2ZHa
         bk4w==
X-Gm-Message-State: AElRT7HiWl0O2NgU1HZy/8SYA0gnqMca1IVhjQh3FhsCjeZaoFu/1tWj
        1VLWP+KCsGKLsNphUQQkW+U=
X-Google-Smtp-Source: AG47ELtEK1S18S48bS62TfCqums3N4yInzQSTj4IjWOrWbAUMfd9X0YSekkPaUYkfzb5beypPPvI4g==
X-Received: by 10.223.151.1 with SMTP id r1mr31210429wrb.126.1522082986748;
        Mon, 26 Mar 2018 09:49:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f10sm11169374wrg.67.2018.03.26.09.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 09:49:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@matthieu-moy.fr
Cc:     Jeff King <peff@peff.net>, Aaron Greenberg <p@aaronjgreenberg.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] branch: implement shortcut to delete last branch
References: <20180323085636.GA24416@sigill.intra.peff.net>
        <1521844835-23956-1-git-send-email-p@aaronjgreenberg.com>
        <20180326081036.GA18714@sigill.intra.peff.net>
        <86r2o7nh4i.fsf@matthieu-moy.fr>
Date:   Mon, 26 Mar 2018 09:49:44 -0700
In-Reply-To: <86r2o7nh4i.fsf@matthieu-moy.fr> (git@matthieu-moy.fr's message
        of "Mon, 26 Mar 2018 14:41:49 +0200")
Message-ID: <xmqqvadidbo7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@matthieu-moy.fr writes:

>> That said, I'd still be OK with it.
>
> I don't have objection either.

FWIW, I do not even buy the "destructive commands should force
spelling things out even more" argument in the first place.

    $ git checkout somelongtopicname
    $ work work work
    $ git checkout master && git merge -
    $ git branch -d -

would be a lot less error-prone than the user being forced to write
last step in longhand

    $ git branch -d someotherlongtopicname

and destroying an unrelated but similarly named branch.

So obviously I am OK with it, too.

As long as we do not regress end-user experience, that is.  For
example, "git merge @{-1}" in the above sequence would record the
fact that the resulting commit is a merge of 'somelongtopicname',
not literally "@{-1}", in its log message.  It would be a sad
regression if it suddenly starts to say "Merge branch '-'" [*1*],
for example.


[Reference]

*1* https://public-inbox.org/git/xmqqinnsegxb.fsf@gitster.mtv.corp.google.com/


