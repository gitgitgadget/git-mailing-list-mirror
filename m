Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA81C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 21:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBFVmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 16:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFVmA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 16:42:00 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB33F741
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 13:41:57 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k13so13682492plg.0
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 13:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/s8Jz9FnCFYezB7eiBnToO1JYoVTEkRimdiypikvHVQ=;
        b=Ckh0wk5ew7qdN8bttZXCFCKOQMRPnFQHbeSdEHRHmOufjoAnxE65Erbf7zTDs1tiWH
         yesDUmYefy28qMHft36b0Xgk6zmLiSxXifA4PDSbUZLiiotvDsfOYGg6RhRdAKkfB9FM
         S7uFaa+vbHEjfC+fxBw+AsNUS7IO+DqGn7LWk1+elfU49Tx5ejlxn9aMLrktZp4UypjR
         gQ29a6RcfScwNmeNnP0y9k7TdNd0FBcRGF6TN8iz34eQgv+vPADwIR/NrZwDqvYWY+8o
         NARatfYNulFm6WG/AeShOcouxHD2XTePmAQBzj/bj9AM9UY/S7nQ9KIkEcs2jMdQOFjp
         PnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/s8Jz9FnCFYezB7eiBnToO1JYoVTEkRimdiypikvHVQ=;
        b=b5PV2rLLxP+/mwhFTNvdw+A2yOx4HBNmVY8zC0KFLUavaW9mdS2XQuXWAmiP7J5bVp
         XlL25QpVJGH2xA52f4yGBHIwDx74/gqA7XcIRce3cDGwQZi9RB/GqfHWKl4flv/5wb/k
         mnll/tCmH7/OhH3ok+C8WTTkglWZKsPpVLtvvorPDUdqCf4oi2AEYnDg7rlLPCLIbm6h
         juIPRJj83p41a8QF+Ueg047fAmYy068j+h+C9jJt+XnjoGeOg4nQ3mR1xXU/cN+YEW4F
         JqwUCnDIq/RIOogFRmoC4J4hNUqnou1o9vuWeqI4mSG5lEyYaZyQmpy559t/vuoHa5HR
         kKJA==
X-Gm-Message-State: AO0yUKWeXLw8+I5+h3z41UHeloRHVMC0GYVH7FmQOxTeMkDVoP3Q527s
        n+OoCeunaXhryRUxZXXe7obimf+VTXM=
X-Google-Smtp-Source: AK7set/N7IhqQaHKm9yFQP1bysxpDf/LxBHLWw40EXt+49pCkU/i5V3XCS+PrFCEc1IHUL+rxgE35g==
X-Received: by 2002:a17:902:c702:b0:194:7d25:cb78 with SMTP id p2-20020a170902c70200b001947d25cb78mr229253plp.46.1675719717208;
        Mon, 06 Feb 2023 13:41:57 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090264cf00b001967580f60fsm7340668pli.260.2023.02.06.13.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:41:56 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 6/6] imap-send: correctly report "host" when using
 "tunnel"
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
        <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
        <Y91J+P5P9gV1Dygm@coredump.intra.peff.net>
        <230203.86bkmabfjr.gmgdl@evledraar.gmail.com>
        <Y94866yd3adoC1o9@coredump.intra.peff.net>
Date:   Mon, 06 Feb 2023 13:41:56 -0800
In-Reply-To: <Y94866yd3adoC1o9@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 4 Feb 2023 06:09:31 -0500")
Message-ID: <xmqq1qn25v4r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yes, I agree that the scenario I'm giving is contrary to what the docs
> say. But IMHO it is worth preferring what the code does now versus what
> the docs say. The current behavior misbehaves if you configure things
> badly (accidentally mix and match imap.host and imap.tunnel). Your new
> behavior misbehaves if you have two correctly-configure imap stanzas
> (both with a host/tunnel combo). Those are both fairly unlikely
> scenarios, and the outcomes are similar (we mix up credentials), but:
>
>   1. In general, all things being equal, I'd rather trust the code as
>      the status quo. People will complain if you break their working
>      setup. They won't if you fix the documentation.
>
>   2. In the current behavior, if it's doing the wrong thing, your next
>      step is to fix your configuration (don't mix and match imap.host
>      and imap.tunnel). In your proposed behavior, there is no fix. You
>      are simply not allowed to use two different imap tunnels with
>      credential helpers, because the helpers don't receive enough
>      context to distinguish them.
>
>      And that is not even "two imap tunnels in the same config". It is
>      really per user. If I have two repositories, each with
>      "imap.tunnel" in their local config, they will still invoke the
>      same credential helpers, and both will just see host=tunnel. The
>      namespace for "host" really is global and should be unique (ideally
>      across the Internet, but at the very least among the hosts that the
>      user contacts).

All good points.

> Yes, there are many config schemes that would avoid this problem. If you
> are going to tie the two together, I think it would make sense to use
> real subsections based on the host-name, like:
>
>   # hostname is the subsection key; it also becomes a label when
>   # necessary
>   [imap "example.com"]
>
>   # does not even need to mention a hostname. We'll assume example.com
>   # here.
>   tunnel = "any-command"
>
>   # assumes example.com as hostname; not needed if you are using a
>   # tunnel, of course
>   protocol = imaps
>
> But I would not bother going to that work myself. IMHO imap-send is
> somewhat of an abomination, and I'd actually be just as happy if it went
> away. But what you are doing seems to go totally in the wrong direction
> to me (keeping it, but breaking a rare but working use case to the
> benefit of a rare but broken misconfiguration).

Yup.
