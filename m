Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D0E720D0A
	for <e@80x24.org>; Mon, 29 May 2017 14:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbdE2Oih (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 10:38:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:59409 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbdE2Oig (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 10:38:36 -0400
Received: (qmail 3503 invoked by uid 109); 29 May 2017 14:38:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 May 2017 14:38:35 +0000
Received: (qmail 17395 invoked by uid 111); 29 May 2017 14:39:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 May 2017 10:39:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 May 2017 10:38:33 -0400
Date:   Mon, 29 May 2017 10:38:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] WIP: add deprecation & experimental process/interface
Message-ID: <20170529143832.65hjawks74co6tqe@sigill.intra.peff.net>
References: <20170527111032.30897-1-avarab@gmail.com>
 <CACsJy8CUpHNDfvN+P7=Jub4+Z281rzExFV9x3_hdVKw6ORUSqQ@mail.gmail.com>
 <CACBZZX5SbYo5fVPtK6LW1FF96nR5591RHHC-5wdjW-fmg1R0EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX5SbYo5fVPtK6LW1FF96nR5591RHHC-5wdjW-fmg1R0EQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 01:20:02PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >>  * Add a new config variable `core.version`. E.g. `core.version =
> >>    2.14.0` With this the user can specify that they'd like
> >>    new/experimental features introduced in that version (and below),
> >>    as well as immediately getting new deprecations added in that
> >>    version as errors.
> >
> > We have extensions.* for this purpose (or close to this purpose). I
> 
> From reading repository-version.txt it seems unrelated to what I'd
> like to do. I.e. there you'd like to introduce a hard breakage and
> it's already documented that if you encounter some extensions.* keys
> you don't understand you *must not* proceed.
> 
> Whereas for this you'd like to e.g. turn on some experimental feature
> in 2.16, but if you're running a 2.14 git you'd like it to just ignore
> that config key it doesn't know about instead of git breaking.

Right. repostoryformatversion (and extensions) is about the on-disk
format of a repo. If I understand correctly, this is about the user
specifying their preferred behaviors. Which is totally orthogonal.

The former must be set in the repo-level .git/config, and would
generally be set by Git itself when it writes a repo using that feature
(e.g., upcoming ref backends).  But this new thing would likely be set
in the ~/.gitconfig explicitly by the user, when they want to change the
behavior profile.

For that reason, I'd suggest using a name that is a little different
from "core.version", since it's easily missed up with
"core.repositoryformatversion". But that's a minor detail.

-Peff
