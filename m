Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B765520D0A
	for <e@80x24.org>; Tue, 30 May 2017 05:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750911AbdE3FJy (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 01:09:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:59593 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750888AbdE3FJx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 01:09:53 -0400
Received: (qmail 12413 invoked by uid 109); 30 May 2017 05:09:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 05:09:51 +0000
Received: (qmail 20749 invoked by uid 111); 30 May 2017 05:10:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 01:10:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 May 2017 01:09:49 -0400
Date:   Tue, 30 May 2017 01:09:49 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/8] consistent "-h" handling in builtins
Message-ID: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
References: <20170529114518.dwlyayg5kfjjwtpx@macports.org>
 <CACBZZX4kfNhEOtgpFkWtuTZshJX+tX_Dogd6tk6qEuGX07JqiA@mail.gmail.com>
 <20170529153250.zq4qz3s5fmztc6ih@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170529153250.zq4qz3s5fmztc6ih@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 11:32:50AM -0400, Jeff King wrote:

> I'll try to put together patches in the next day or so. Comments welcome
> in the meantime.

So here they are. For those just joining us, the immediate problem is
that "git am -h" is broken (whether you're in a repo or not). That's
fixed by the first patch, which can go to "maint" separately (although
the rest are pretty unadventurous).

The rest of it cleans up "-h" handling for a variety of builtin
commands, and then adds a test to make sure they all behave sanely
(which unsurprisingly is how I found all the problems fixed by the
earlier patches).

  [1/8]: am: handle "-h" argument earlier
  [2/8]: credential: handle invalid arguments earlier
  [3/8]: upload-archive: handle "-h" option early
  [4/8]: remote-{ext,fd}: print usage message on invalid arguments
  [5/8]: submodule--helper: show usage for "-h"
  [6/8]: version: convert to parse-options
  [7/8]: git: add hidden --list-builtins option
  [8/8]: t0012: test "-h" with builtins

 builtin/am.c                |  3 +++
 builtin/credential.c        |  4 ++--
 builtin/remote-ext.c        |  5 ++++-
 builtin/remote-fd.c         |  5 ++++-
 builtin/submodule--helper.c |  5 ++---
 builtin/upload-archive.c    |  5 ++++-
 git.c                       | 12 ++++++++++++
 help.c                      | 25 ++++++++++++++++++++-----
 t/t0012-help.sh             | 12 ++++++++++++
 9 files changed, 63 insertions(+), 13 deletions(-)

-Peff
