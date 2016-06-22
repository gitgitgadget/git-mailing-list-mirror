Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F5A20189
	for <e@80x24.org>; Wed, 22 Jun 2016 20:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbcFVUsk (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:48:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:58802 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752187AbcFVUsk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:48:40 -0400
Received: (qmail 10341 invoked by uid 102); 22 Jun 2016 20:48:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Jun 2016 16:48:39 -0400
Received: (qmail 5777 invoked by uid 107); 22 Jun 2016 20:48:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Jun 2016 16:48:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jun 2016 16:48:36 -0400
Date:	Wed, 22 Jun 2016 16:48:36 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t/perf: fix regression in testing older versions of
 git
Message-ID: <20160622204836.GA4628@sigill.intra.peff.net>
References: <20160622193904.GA1509@sigill.intra.peff.net>
 <20160622194013.GA1697@sigill.intra.peff.net>
 <xmqqmvmdkl3y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmvmdkl3y.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 22, 2016 at 01:46:25PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So let's introduce a new variable, $MODERN_GIT, that we can
> > use both in perf-lib and in the test setup to get a reliable
> > set of git features (we might change git and break some
> > tests, of course, but $MODERN_GIT is tied to the same
> > version of git as the t/perf scripts, so they can be fixed
> > or adjusted together).
> 
> I can see how this works for "git -C ... rev-parse ..." or any other
> built-in commands, but I am not sure if this is sufficient when any
> non-built-in command is used in the perf framework.  How does it
> interact with GIT_EXEC_PATH we set in ../test-lib.sh that is
> dot-sourced by ./perf-lib.sh that everybody dot-sources?

I didn't test it but it should work because we are pointing to
bin-wrappers/git, which will override GIT_EXEC_PATH, and stick itself at
the front of the PATH.

-Peff
