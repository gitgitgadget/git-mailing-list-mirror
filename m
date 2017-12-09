Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11891F404
	for <e@80x24.org>; Sat,  9 Dec 2017 00:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751146AbdLIAbd (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 19:31:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:53138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750788AbdLIAbc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 19:31:32 -0500
Received: (qmail 6224 invoked by uid 109); 9 Dec 2017 00:31:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Dec 2017 00:31:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8123 invoked by uid 111); 9 Dec 2017 00:31:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 19:31:54 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 19:31:30 -0500
Date:   Fri, 8 Dec 2017 19:31:30 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 4/5] Makefile: use the sha1collisiondetection
 submodule by default
Message-ID: <20171209003130.GA28044@sigill.intra.peff.net>
References: <20171208223001.556-1-avarab@gmail.com>
 <20171128213214.12477-1-avarab@gmail.com>
 <20171208223001.556-5-avarab@gmail.com>
 <xmqqo9n86dde.fsf@gitster.mtv.corp.google.com>
 <xmqqk1xw6c24.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk1xw6c24.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 08, 2017 at 03:21:23PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > That endgame allows us not force people to grab an essential part of
> > the codebase as an external dependency from another place, which
> > feels quite bad, especially when their primary interest is not in
> > dogfooding submodule but in building a working version of Git.
> >
> > Removing one and keeping the other between the two will make the
> > distribution more streamlined by removing the build-time knob we
> > need to tweak, but the one that gets removed does not have to be the
> > in-tree one that allows people to "git clone" from just one place.
> 
> Perhaps this may deserve a bit more explanation.
> 
> I wouldn't be so against "let's do submodule-only" if this were not
> SHA-1 implementation but something like gitk and git-gui.  An optional
> part of a system that it is safe to leave to individual builders if
> they want to fetch and use that part *is* an ideal target to bind as
> a submodule to the system.
> 
> It's just the "default SHA-1 implementation" is at the far opposite
> end of the spectrum from "an optional part", and our use of
> submodule to bind this code is definitely *not* because it makes
> sense to use submodule in that context; it is because developers
> (not necessarily those who consume Git sourcecode) *wanted* to use
> submodule there, regardless of the real merit of doing so.

Thanks for writing this out. I had a vague feeling that I didn't quite
like going the submodule-only direction, but I was having trouble
putting into words. It's exactly this.

-Peff
