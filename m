Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED30C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 21:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198876109F
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 21:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbhI0Vj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 17:39:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:55772 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237050AbhI0Vj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 17:39:28 -0400
Received: (qmail 7533 invoked by uid 109); 27 Sep 2021 21:37:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Sep 2021 21:37:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20683 invoked by uid 111); 27 Sep 2021 21:37:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Sep 2021 17:37:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Sep 2021 17:37:49 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>,
        =?utf-8?B?J8OGdmFyIEFybmZqw7Zyw7A=?= Bjarmason' 
        <avarab@gmail.com>, git@vger.kernel.org,
        'The Grey Wolf' <greywolf@starwolf.com>
Subject: Re: [PATCH] config: add an includeIf.env{Exists,Bool,Is,Match}
Message-ID: <YVI5rYamHBkGQ/jy@coredump.intra.peff.net>
References: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
 <patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@gmail.com>
 <YU49+Y+nRhl1mgof@coredump.intra.peff.net>
 <xmqqa6k1slxe.fsf@gitster.g>
 <YU5KOpGkS5sH4iFJ@coredump.intra.peff.net>
 <xmqqo88eq8um.fsf@gitster.g>
 <YVImeFHxY7hmb3wY@coredump.intra.peff.net>
 <00ee01d7b3e1$ceb06840$6c1138c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00ee01d7b3e1$ceb06840$6c1138c0$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 04:53:59PM -0400, Randall S. Becker wrote:

> What about something like:
> 
> 	[includeIf "env:PATH ~= '^(.*😊)/usr/bin(:.*)*$' "]
> 
> Using single quotes and a full regex pattern instead of trying to
> provide a syntax to extract a pattern and then match. One call to
> regexec() would be easier. Then escaping is regcomp's problem
> (mostly). Potentially, you could even remove the outer ", but that
> would be wonky. You could omit the ^ and $ by default assuming a full
> match.

I almost suggested that, but then...how do you put single-quotes in your
pattern? You can backslash-escape them, but:

  - do you need to escape the backslash to get it through the config
    parser intact?

  - it seems extra funny to me because single quotes usually imply a
    lack of interpolation

-Peff
