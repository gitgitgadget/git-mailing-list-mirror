Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E55EC2BB55
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 22:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 375AB2076D
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 22:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbgDOW5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:57:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:55320 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387663AbgDOW53 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 18:57:29 -0400
Received: (qmail 14810 invoked by uid 109); 15 Apr 2020 22:57:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Apr 2020 22:57:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12597 invoked by uid 111); 15 Apr 2020 23:08:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Apr 2020 19:08:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Apr 2020 18:57:26 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 2/17] Hooks in the future
Message-ID: <20200415225726.GA3600473@coredump.intra.peff.net>
References: <20200312141628.GL212281@google.com>
 <xmqqeetwcf4k.fsf@gitster.c.googlers.com>
 <20200407230132.GD137962@google.com>
 <20200407235116.GE137962@google.com>
 <20200410213146.GA2075494@coredump.intra.peff.net>
 <20200413191515.GA5478@google.com>
 <20200413215256.GA18990@coredump.intra.peff.net>
 <20200415034550.GB36683@google.com>
 <20200415224244.GB3595509@coredump.intra.peff.net>
 <20200415224852.GC24777@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415224852.GC24777@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 03:48:52PM -0700, Emily Shaffer wrote:

> > Here you've done a custom munging of pre-push into prePush. I'm fine
> > with that, but would we ever want to allow third-party scripts to define
> > their own hooks using this mechanism? E.g., if there's a git-hooks
> > command could I run "git hooks run foo" to run the foo hook? If so, then
> > it might be simpler to just use the name as-is rather than defining the
> > exact munging rules.
> 
> I did envision that kind of thing, or at very least something like
> `git hook --list --porcelain foo | xargs -n 1 sh -c`. When I saw
> Jonathan's suggestion I wondered if using the hookname as is (pre-push)
> was not idiomatic to the config, and maybe I should change it. But I
> would rather leave it identical to the hookname, personally.

You do still have to communicate to users of git-hook that their hook
names are limited to the characters used in config keys. But that seems
simpler to me than describing any special dash-and-capitalization
conversion.

-Peff
