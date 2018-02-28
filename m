Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52BB91F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeB1BQJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:16:09 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40458 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbeB1BQH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:16:07 -0500
Received: by mail-pf0-f194.google.com with SMTP id m5so338745pff.7
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZeY6DiEocP2079oizHNwt3Vnakx7VVlUB2bIAPXOdAE=;
        b=kUPZlQ5sovH4L75Ul0eMyLZDbFQI5hy3W9Cdfn1TqIErLaxY7vCDj51aa9ZQBAuFDp
         RXHtQsXI4BscZUHLqFwX4XJs0dOMQj0EX/hElMpvFS+hqJr76IPpoMu1fC1bBe4HEmqx
         1Z2cQyaPRVyHZt0EyBBs+UM67eMyQWgx7NIy5rlHGclhkGlhJHd4/0PcfFB2OA/sdnxQ
         /uek73UhUF0nKwUcMxj3oLQ4D02gBTi2/N4/HG7baLH7OOkvm4ruZfkvE3iZNdtk8BNS
         F2zgDJveC3MDIDCg89xvEYVPPLB0+WptTWUiWlo0W6gqzG4whB7nfaOhCOml64xgZhGG
         cShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZeY6DiEocP2079oizHNwt3Vnakx7VVlUB2bIAPXOdAE=;
        b=M9n7EFOC2G24bVmoXhCjirRORVQLJR0qpbAQIFELMd3mtJYMlAF8nhxbhYOYLjG9AT
         taPfVNPbfN5qySGhAVmWg/PATRENtoB43Icq9Hkg5Gvix8eU+ksEwr3Ee/uxOACQg6yg
         x8of0xZH1PlUNbFWbbAz/VCfg6P++H0ItiAxQwAos5YzoGvRgO6LlnFYhAWvaM938zlW
         8wPeJapjSKj8WC47oT8zoD/eQyU05z3o3/r8wOCEFK0M74mG/oWdwXPaYG6ZielcIH+V
         /L9eatZ1VFf/vF16Aaym6wSwBQS3W/sr4myiCzfut1sbf0QPWtK7WZFQVPtTBPF6rZu4
         xd/g==
X-Gm-Message-State: APf1xPDE/S91EamhyzaIu60ojgBwLOl5u9ipJbV4Mk5hI3lgp2R22Tgd
        YkNiPBJiUjKjcXTVdIr9GEKzqw==
X-Google-Smtp-Source: AG47ELtiE+xyaBVR8HImVK33kFubrxWWmqJuxlcG/BVd0t4Sq4imgm0iAj8IW9RPlhUY0bKiDEk/gQ==
X-Received: by 10.98.34.143 with SMTP id p15mr3195824pfj.101.1519780566277;
        Tue, 27 Feb 2018 17:16:06 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id f13sm372030pgp.59.2018.02.27.17.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 17:16:05 -0800 (PST)
Date:   Tue, 27 Feb 2018 17:16:04 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] protocol: treat unrecognized protocol.version setting as
 0
Message-ID: <20180228011604.GC45342@google.com>
References: <20180228005059.GA251290@aiede.svl.corp.google.com>
 <20180228010233.GA45342@google.com>
 <CACsJy8Cn2hcodoR8ksRBY9qf7MmJaP+KAzYqv6seeR9s-Be8Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8Cn2hcodoR8ksRBY9qf7MmJaP+KAzYqv6seeR9s-Be8Hw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/28, Duy Nguyen wrote:
> On Wed, Feb 28, 2018 at 8:02 AM, Brandon Williams <bmwill@google.com> wrote:
> > On 02/27, Jonathan Nieder wrote:
> >> If I share my .gitconfig or .git/config file between multiple machines
> >> (or between multiple Git versions on a single machine) and set
> >>
> >>       [protocol]
> >>               version = 2
> >>
> >> then running "git fetch" with a Git version that does not support
> >> protocol v2 errors out with
> >>
> >>       fatal: unknown value for config 'protocol.version': 2
> >>
> >> In the spirit of v1.7.6-rc0~77^2~1 (Improve error handling when
> >> parsing dirstat parameters, 2011-04-29), it is better to (perhaps
> >> after warning the user) ignore the unrecognized protocol version.
> >> After all, future Git versions might add even more protocol versions,
> >> and using two different Git versions with the same Git repo, machine,
> >> or home directory should not cripple the older Git version just
> >> because of a parameter that is only understood by a more recent Git
> >> version.
> 
> I wonder if it's better to specify multiple versions. If v2 is not
> recognized by this git but v0 is, then it can pick that up. But if you
> explicitly tell it to choose between v2 and v3 only and it does not
> understand either, then it dies. Not sure if this is a good idea
> though.

I mean that's definitely a possibility, but I don't think its worth the
effort to get that working until we actually need it.  I'm hoping we
really don't bump version numbers often.

-- 
Brandon Williams
