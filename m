Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F4241F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbeB1BCh (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:02:37 -0500
Received: from mail-pl0-f41.google.com ([209.85.160.41]:40421 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbeB1BCg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:02:36 -0500
Received: by mail-pl0-f41.google.com with SMTP id i6-v6so490810plt.7
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nb5WtTG8MtknMI0KgHxxz6JgBjhbccTj6ee1vJFDvDk=;
        b=YmC1r59PnPs2N+j0Q5sVJP/VJDxBFsgXK3RNiiOZepJg+LLUevoCGd20Zop7Z5gSBY
         LUe0heAhPWFUOWXyAvkyJzNalFXzcdWnVc/1xSmZC1i27ehtDllEe0V/MiK5areQ2vgF
         aTpz6MV0qDh0NQlYQ0V0A/Ayx7IqMNkvidmOoDNxie1I9lcJECOeyHe5nPIC0/ViNU49
         0sNbT/WhrgTSCvLOVw0HtTLD7bwMsf3JoStleHOEoKp+Pf5DIk1eO6wzuEgaTp/MXcwG
         H9sTYR5cZaTyclqJOJNBaSZE7F9Dey4YqC6n5CF1unn656bOd7JWR7vyzXRptUv1h/xq
         LOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nb5WtTG8MtknMI0KgHxxz6JgBjhbccTj6ee1vJFDvDk=;
        b=t7GEBj8G1AWE531Tmh8AexAyrkDsA+haCNbx8TufP8yI00txD7JlQNbkCcfCnIZ53o
         3xzcCNnT3wx6XBoVHdKuO+m4BmCIiYnSM7Y8uViIN9Z+lps0/0FetH4Fsv0PhWna2oBe
         GuGQPfB+CFk1ONGnS7dmau/x1mlAwTpVPnTOCreqMESHehixjo4OtZMDwwfTwKp7/mMx
         FdsmeRktQvoo6gkK6WsO27hrBWu5+OqWkFsiKj2B33RS62a026o3dzCVejgiY4qelFZO
         xc9VxBCol8lEI5czGHdVcy7ICzZT9itgPKDG9xaJNVB4XBF+0vjbMkhBwewkqZ1Hj67C
         kgPA==
X-Gm-Message-State: APf1xPD+77Q5Vq5dZUQIbsZW+G+8Ocpi7UXE+2q6YFUwyyfU7+r7XYXp
        /Vwp42kSeSFJic2+3uGr0LAXOgEbitk=
X-Google-Smtp-Source: AH8x2258+5dlAdeCSJRQO5IVJQT5v9BqXXvnD6MftA4q7dye9v+wc2DCLb6DVI0Auqko8uk/BiTXAw==
X-Received: by 2002:a17:902:2e04:: with SMTP id q4-v6mr15932172plb.22.1519779755715;
        Tue, 27 Feb 2018 17:02:35 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id b5sm374962pgc.13.2018.02.27.17.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 17:02:34 -0800 (PST)
Date:   Tue, 27 Feb 2018 17:02:33 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] protocol: treat unrecognized protocol.version setting as
 0
Message-ID: <20180228010233.GA45342@google.com>
References: <20180228005059.GA251290@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228005059.GA251290@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/27, Jonathan Nieder wrote:
> If I share my .gitconfig or .git/config file between multiple machines
> (or between multiple Git versions on a single machine) and set
> 
> 	[protocol]
> 		version = 2
> 
> then running "git fetch" with a Git version that does not support
> protocol v2 errors out with
> 
> 	fatal: unknown value for config 'protocol.version': 2
> 
> In the spirit of v1.7.6-rc0~77^2~1 (Improve error handling when
> parsing dirstat parameters, 2011-04-29), it is better to (perhaps
> after warning the user) ignore the unrecognized protocol version.
> After all, future Git versions might add even more protocol versions,
> and using two different Git versions with the same Git repo, machine,
> or home directory should not cripple the older Git version just
> because of a parameter that is only understood by a more recent Git
> version.
> 
> So ignore the unrecognized value.  It may be useful for spell checking
> (for instance, if I put "version = v1" intending "version = 1") to
> warn about such settings, but this patch does not, since at least in
> these early days for protocol v2 it is expected for configurations
> that want to opportunistically use protocol v2 if available not to be
> unusual.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Google has been running with a patch like this internally for a while,
> since we have been changing the protocol.version number to a new value
> like 20180226 each time a minor tweak to the protocolv2 RFC occured.
> 
> The bit I have doubts about is whether to warn.  What do you think?

Patch looks good to me.  And I don't have a strong preference either way
for whether to warn or not.


-- 
Brandon Williams
