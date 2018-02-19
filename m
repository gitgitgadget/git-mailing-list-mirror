Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55CE11F404
	for <e@80x24.org>; Mon, 19 Feb 2018 22:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932191AbeBSWu5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 17:50:57 -0500
Received: from grym.ekleog.org ([94.23.42.210]:37302 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932180AbeBSWu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 17:50:57 -0500
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id 0cdf6319;
        Mon, 19 Feb 2018 22:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        grym-20170528; bh=5zRPZwgcWVubcWmTl1YP0DPySk8=; b=GITOHy6OIwfV82
        CUd9+fgH92T7q0o/Hdajn0ciwcKcyd1nFGICGl3aLQMdj5oC+Xo612W83RsGoEKd
        2WOueoUY81dWBCigZQoQpXupQtGdfJup6hgqFEBymndyXNfu0p32ssau3U1tWf2F
        uyoqIShs0FUxf+PjyNg3I1+wu1COM=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTPSA id 59ad2a4e (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Mon, 19 Feb 2018 22:50:54 +0000 (UTC)
Subject: Re: Fetch-hooks
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
 <87po5dbz1a.fsf@evledraar.gmail.com>
 <20180209223011.GA24578@sigill.intra.peff.net>
 <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
 <20180210001317.GA26856@sigill.intra.peff.net>
 <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io>
 <20180210122131.GB21843@sigill.intra.peff.net>
 <5abf8565-1aa1-c101-83a7-90781682bc7a@gaspard.io>
 <20180214013520.GA25188@sigill.intra.peff.net>
 <96dd7fb3-849b-8de6-7c3a-cd6bde9da432@gaspard.io>
 <20180219212347.GA9748@sigill.intra.peff.net>
From:   Leo Gaspard <leo@gaspard.io>
Message-ID: <cdef8e46-92ee-2062-385a-999b5b49ae9a@gaspard.io>
Date:   Mon, 19 Feb 2018 23:50:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219212347.GA9748@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/19/2018 10:23 PM, Jeff King wrote:
> [...]
> If you do go this route, please model it after "pre-receive" rather than
> "update". We had "update" originally but found it was too limiting for
> hooks to see only one ref at a time. So we introduced pre-receive. The
> "update" hook remains for historical reasons, but I don't think we'd
> want to reproduce the mistake. :)

Hmm, what bothered me with “pre-receive” was that it was an
all-or-nothing decision, without the ability to allow some references
through and not others.

Is there a way for “pre-receive” to individually filter hooks? I was
under the impression that the only way to do that was to use the
“update” hook, which was the reason I wanted to model it after “update”
rather than “pre-receive” (my use case being a check independent for
each pushed ref)
