Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1642B1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 21:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932630AbeCEVg4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 16:36:56 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42435 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932450AbeCEVgw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 16:36:52 -0500
Received: by mail-pl0-f65.google.com with SMTP id 93-v6so10508911plc.9
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 13:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YBh0YzUgu01mCBde6X+NdZrF23qaoJISCgB7ya6ZFrc=;
        b=OSizpFCsFM0ZXoFZ132QGP4jCkcp4/KMcNlP9BalwYpyFZEcvMVt2pwKqEfSPmicui
         6PCmIzrG7CFNlQvuf0uOSC9T4terVpZrzd/0ik7vctY4NPoYQcRJwQSgYrU7LYrbfRVM
         gA+UOXMMBMnANNVbjab8bsFICyAR8Wrpb1SPDO04kEakDImE5Z/Ea9r/BrUZ64RrhSUL
         VDhSTUfPJGKxggjfLRFNXDTwnqlZcSmagTBOZFOGEHimBknL+tfB1rmzQpTNCRpGtUOu
         oljKNN1cNxc0KNVpA9lbI11Ua6H4QHvaPT+7lC7EYlOTHMoPAvEgg4igdShA/W+Rbq2H
         wk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YBh0YzUgu01mCBde6X+NdZrF23qaoJISCgB7ya6ZFrc=;
        b=uTq+7OdH7ziNWIEJTvXnJ6QyMOmj6VEiUWqDEZcHV9ZwCnMaV5fnXrPFHxS8JRoLVv
         sggA03FvvlQEXLgTYH7Wj930RGhRoAt7Dl84B5aTxAiZ1K05K0KYKMsIyHnmzsgOGDmX
         QhfcnsyKtmHv/MM5dC1Mg5PpFVL80LxDa3QnptpZSUgGcnIaTVOoaLpf8SB5jU/Re7Gn
         m2SHbxR9TBbBZKydRWkkqT3/SxtQWBZXjTjfdT6JOisjefb/hEqgGyWNri0NI9ED6okS
         bsPMCBUteOiGKJlZSGSG2nm+depIsUDBF4rSD1WdYa4W16RrAxZGTVD2+fek8bF8kNWX
         +lpw==
X-Gm-Message-State: APf1xPArv3MLqIQTG37gROVvQK4n9VKrDxxDPNTIX26/aK02gysjCpv4
        BKZH9/kjMedHsdjrkQJmsbw=
X-Google-Smtp-Source: AG47ELtRtOmQqtdkzhpdtvIBF8wbUPeyfxyccDTosA4/gQqU6tCBg9ijDRBGD1HN78QkZ7H/FTm3Og==
X-Received: by 2002:a17:902:b691:: with SMTP id c17-v6mr14349426pls.308.1520285811941;
        Mon, 05 Mar 2018 13:36:51 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g13sm23893073pfi.134.2018.03.05.13.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 13:36:51 -0800 (PST)
Date:   Mon, 5 Mar 2018 13:36:49 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 12/35] serve: introduce git-serve
Message-ID: <20180305213649.GF28067@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-13-bmwill@google.com>
 <20180222093327.GA12442@sigill.intra.peff.net>
 <20180223214557.GF234838@google.com>
 <20180303043338.GC27689@sigill.intra.peff.net>
 <20180305184321.GC72475@google.com>
 <20180305205254.GC5953@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305205254.GC5953@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> I agree that would be a lot more pleasant for adding protocol features.
> But I just worry that the stateful protocols get a lot less efficient.
> I'm having trouble coming up with an easy reproduction, but my
> recollection is that http has some nasty corner cases, because each
> round of "have" lines sent to the server has to summarize the previous
> conversation. So you can get a case where the client's requests keep
> getting bigger and bigger during the negotiation (and eventually getting
> large enough to cause problems).

That's not so much a corner case as just how negotiation works over
http.

We want to do better (e.g. see [1]) but that's a bigger change than
the initial protocol v2.

As Brandon explained it to me, we really do want to use stateless-rpc
semantics by default, since that's just better for maintainability.
Instead of having two protocols, one that is sane and one that
struggles to hoist that into stateless-rpc, there would be one
stateless baseline plus capabilities to make use of state.

For example, it would be nice to have a capability to remember
negotiation state between rounds, to get around exactly the problem
you're describing when using a stateful protocol.  Stateless backends
would just not advertise such a capability.  But doing that without [1]
still sort of feels like a cop-out.  If we can get a reasonable
baseline using ideas like [1] and then have a capability to keep
server-side state as icing on the cake instead of having a negotiation
process that only really makes sense when you have server-side state,
then that would be even better.

> If anything, I wish we could push the http protocol in a more stateful
> direction with something like websockets. But I suspect that's an
> unrealistic dream, just because not everybody's http setup (proxies,
> etc) will be able to handle that.

Agreed.  I think we have to continue to deal with stateless-rpc
semantics, at least for the near future.

Jonathan

[1] https://public-inbox.org/git/20180227054638.GB65699@aiede.svl.corp.google.com/
