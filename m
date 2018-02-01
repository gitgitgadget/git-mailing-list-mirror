Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDC481F404
	for <e@80x24.org>; Thu,  1 Feb 2018 20:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754944AbeBAUIb (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 15:08:31 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41516 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754940AbeBAUI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 15:08:29 -0500
Received: by mail-pl0-f68.google.com with SMTP id k8so2152898pli.8
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 12:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sp5YOWsV9ozLZueceFg5OWM2TTbTjvchOf4gn60r3co=;
        b=PXK++lrPnYGYI3WHVGqHicIfyMyFGIICNFZlZdpPulL92Szfqy1/XijiOCcPi1TxG1
         Nks4v9Z/p3tDiXkjjLW9Uf4f+7j2QmlwWJ9tonHgqCpcZK0xNZorCFUIlskxOY/82qXU
         d1VWRbZVedTtpGqmJDmg8u8fs+Gs3KtEniNmgdReBBT/2s8s0ATYmbibP5Mxx3MUbkch
         X2ITxQNpLAHPSvYuh/KphHjU4zQeNtknrV2Yeu/yS65XvrcZfM+Wj32JSr362blwy+oL
         MZW28FmL0zOThOtg/KfLHKEehRMyRD3+1ThTQuH/a2ccBEsID9Mv4aoaIWoQIWdRLEWS
         BPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sp5YOWsV9ozLZueceFg5OWM2TTbTjvchOf4gn60r3co=;
        b=SpsIRsKquZCaG2aGgD0SMSeJ1cgiEP6qP6Hv99bnRGj5FbiUBfMBTqWRP3wX3KNbYF
         vgMYWc7VIQwHaENrS+kqjv8tIw+/tvKX65Wzhn+uUVauddf68yESYga1hXpRov1F4XGZ
         JOo/l7eqPtqPUIaNDh6EWoDfIVznySQFhGbKIL+QYP14w679gHmWAOYbyrfWO8ATyuhi
         eUGytUrdKUh26hwlpdILVVs+TMaQSfH/HhHBBQYpY3sKqm+VlQ+Jaf2i722t7nfXGDAm
         bv0r0OxXb7gTDLng3f/4om3omJguKeK4IoP/nYS/6K065934NQ6lzyr2xwgRnqkHFfUp
         d8iA==
X-Gm-Message-State: AKwxytdUK8ZUiWw6XuDsLjZv8z9AE/mVyitKP7J+DUWIkSNo2o3kW/M+
        Na7EKJDLJ4mNndVdFNtBZWnZCg==
X-Google-Smtp-Source: AH8x225OKPNNy28hlnIqYRSAA/zUu0kWLNLg16yGvKzKR8Njs9k5dHLagMrIgIwNEoVGKHj+lWR+dg==
X-Received: by 2002:a17:902:8c89:: with SMTP id t9-v6mr31730683plo.2.1517515708706;
        Thu, 01 Feb 2018 12:08:28 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id f12sm254855pga.67.2018.02.01.12.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Feb 2018 12:08:27 -0800 (PST)
Date:   Thu, 1 Feb 2018 12:08:26 -0800
From:   'Brandon Williams' <bmwill@google.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Stefan Beller' <sbeller@google.com>,
        'Jeff Hostetler' <git@jeffhostetler.com>,
        'git' <git@vger.kernel.org>,
        'Junio C Hamano' <gitster@pobox.com>,
        'Jeff King' <peff@peff.net>,
        'Philip Oakley' <philipoakley@iee.org>,
        'Derrick Stolee' <stolee@gmail.com>,
        'Jonathan Nieder' <jrnieder@gmail.com>
Subject: Re: [PATCH 11/26] serve: introduce git-serve
Message-ID: <20180201200826.GC138727@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-12-bmwill@google.com>
 <d9a15c0a-35f3-8e9c-ddf2-34420ac7555b@jeffhostetler.com>
 <CAGZ79kZpD6m=5YP0dNuM70Yce=PyxLO6qr6aVpHKa_S9iyACww@mail.gmail.com>
 <005801d39b95$2bbc7600$83356200$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005801d39b95$2bbc7600$83356200$@nexbridge.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/01, Randall S. Becker wrote:
> On February 1, 2018 1:58 PM, Stefan Beller wrote:
> > On Thu, Feb 1, 2018 at 10:48 AM, Jeff Hostetler <git@jeffhostetler.com>
> > wrote:
> > >
> > >
> > > On 1/2/2018 7:18 PM, Brandon Williams wrote:
> > >>
> > >> Introduce git-serve, the base server for protocol version 2.
> > >>
> > >> Protocol version 2 is intended to be a replacement for Git's current
> > >> wire protocol.  The intention is that it will be a simpler, less
> > >> wasteful protocol which can evolve over time.
> > >>
> > >> Protocol version 2 improves upon version 1 by eliminating the initial
> > >> ref advertisement.  In its place a server will export a list of
> > >> capabilities and commands which it supports in a capability
> > >> advertisement.  A client can then request that a particular command
> > >> be executed by providing a number of capabilities and command
> > >> specific parameters.  At the completion of a command, a client can
> > >> request that another command be executed or can terminate the
> > >> connection by sending a flush packet.
> > >>
> > >> Signed-off-by: Brandon Williams <bmwill@google.com>
> > >> ---
> > >>   .gitignore                              |   1 +
> > >>   Documentation/technical/protocol-v2.txt |  91 ++++++++++++
> > >>   Makefile                                |   2 +
> > >>   builtin.h                               |   1 +
> > >>   builtin/serve.c                         |  30 ++++
> > >>   git.c                                   |   1 +
> > >>   serve.c                                 | 239
> > >> ++++++++++++++++++++++++++++++++
> > >>   serve.h                                 |  15 ++
> > >>   8 files changed, 380 insertions(+)
> > >>   create mode 100644 Documentation/technical/protocol-v2.txt
> > >>   create mode 100644 builtin/serve.c
> > >>   create mode 100644 serve.c
> > >>   create mode 100644 serve.h
> > >>
> > >> diff --git a/.gitignore b/.gitignore
> > >> index 833ef3b0b..2d0450c26 100644
> > >> --- a/.gitignore
> > >> +++ b/.gitignore
> > >> @@ -140,6 +140,7 @@
> > >>   /git-rm
> > >>   /git-send-email
> > >>   /git-send-pack
> > >> +/git-serve
> > >>   /git-sh-i18n
> > >>   /git-sh-i18n--envsubst
> > >>   /git-sh-setup
> > >> diff --git a/Documentation/technical/protocol-v2.txt
> > >> b/Documentation/technical/protocol-v2.txt
> > >> new file mode 100644
> > >> index 000000000..b87ba3816
> > >> --- /dev/null
> > >> +++ b/Documentation/technical/protocol-v2.txt
> > >> @@ -0,0 +1,91 @@
> > >> + Git Wire Protocol, Version 2
> > >> +==============================
> > >> +
> > >> +This document presents a specification for a version 2 of Git's wire
> > >> +protocol.  Protocol v2 will improve upon v1 in the following ways:
> > >> +
> > >> +  * Instead of multiple service names, multiple commands will be
> > >> +    supported by a single service.
> > >> +  * Easily extendable as capabilities are moved into their own section
> > >> +    of the protocol, no longer being hidden behind a NUL byte and
> > >> +    limited by the size of a pkt-line (as there will be a single
> > >> +    capability per pkt-line).
> > >> +  * Separate out other information hidden behind NUL bytes (e.g. agent
> > >> +    string as a capability and symrefs can be requested using
> > >> + 'ls-refs')
> > >> +  * Reference advertisement will be omitted unless explicitly
> > >> + requested
> > >> +  * ls-refs command to explicitly request some refs
> > >> +
> > >> + Detailed Design
> > >> +=================
> > >> +
> > >> +A client can request to speak protocol v2 by sending `version=2` in
> > >> +the side-channel `GIT_PROTOCOL` in the initial request to the server.
> > >> +
> > >> +In protocol v2 communication is command oriented.  When first
> > >> +contacting
> > >> a
> > >> +server a list of capabilities will advertised.  Some of these
> > >> capabilities
> > >> +will be commands which a client can request be executed.  Once a
> > >> +command has completed, a client can reuse the connection and request
> > >> +that other commands be executed.
> > >> +
> > >> + Special Packets
> > >> +-----------------
> > >> +
> > >> +In protocol v2 these special packets will have the following semantics:
> > >> +
> > >> +  * '0000' Flush Packet (flush-pkt) - indicates the end of a message
> > >> +  * '0001' Delimiter Packet (delim-pkt) - separates sections of a
> > >> + message
> > >
> > >
> > > Previously, a 0001 pkt-line meant that there was 1 byte of data
> > > following, right?
> > 
> > No, the length was including the length field, so 0005 would indicate that
> > there is one byte following, (+4 bytes of "0005" included)
> > 
> > > Does this change that and/or prevent 1 byte packets?  (Not sure if it
> > > is likely, but the odd-tail of a packfile might get sent in a 0001
> > > line, right?)  Or is it that 0001 is only special during the V2
> > > negotiation stuff, but not during the packfile transmission?
> > 
> > 0001 is invalid in the current protocol v0.
> > 
> > >
> > > (I'm not against having this delimiter -- I think it is useful, but
> > > just curious if will cause problems elsewhere.)
> > >
> > > Should we also consider increasing the pkt-line limit to 5 hex-digits
> > > while we're at it ?   That would let us have 1MB buffers if that would
> > > help with large packfiles.
> > 
> > AFAICT there is a static allocation of one pkt-line (of maximum size), such
> > that the code can read in a full packet and then process it.
> > If we'd increase the packet size we'd need the static buffer to be 1MB, which
> > sounds good for my developer machine. But I suspect it may be too much for
> > people using git on embedded devices?
> > 
> > pack files larger than 64k are put into multiple pkt-lines, which is not a big
> > deal, as the overhead of 4bytes per 64k is negligible.
> > (also there is progress information in the side channel, which would come in
> > as a special packet in between real packets, such that every 64k transmitted
> > you can update your progress meter; Not sure I feel strongly on fewer
> > progress updates)
> 
> Can I request, selfishly from my own platform's (NonStop) performance heartache, that we don't require 1Mb? We're not embedded on this platform, but there is an optimized message system packet size down at 50Kb that I would like to stay under. Although above that is no problem, there is a significant cost incurred above that size point. And please make sure xread/xwrite are used in any event.

I think that it would be too much of a change to up to 1MB lines at the
moment so I'm planning on leaving it right where it is :)

> 
> > >  Granted, we're throttled by the network, so it might not matter.
> > > Would it be interesting to have a 5 digit prefix with parts of the
> > > high bits of first digit being flags ?
> > > Or is this too radical of a change?
> > 
> > What would the flags be for?
> > 
> > As an alternative we could put the channel number in one byte, such that we
> > can have a side channel not just while streaming the pack but all the time.
> > (Again, not sure if that buys a lot for us)
> 
> Cheers,
> Randall
> 
> -- Brief whoami:
>  NonStop developer since approximately 211288444200000000
>  UNIX developer since approximately 421664400
> -- In my real life, I talk too much.
> 
> 
> 

-- 
Brandon Williams
