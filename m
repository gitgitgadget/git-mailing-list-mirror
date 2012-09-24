From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] silence git gc --auto --quiet output
Date: Mon, 24 Sep 2012 14:36:41 -0400
Message-ID: <20120924183641.GA15858@sigill.intra.peff.net>
References: <20120924024024.GA12700@tin.tmux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Tobias Ulmer <tobiasu@tmux.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 20:36:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGDWb-0002oX-45
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 20:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757593Ab2IXSgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 14:36:47 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57158 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757388Ab2IXSgq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 14:36:46 -0400
Received: (qmail 2010 invoked by uid 107); 24 Sep 2012 18:37:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Sep 2012 14:37:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2012 14:36:41 -0400
Content-Disposition: inline
In-Reply-To: <20120924024024.GA12700@tin.tmux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206307>

On Mon, Sep 24, 2012 at 04:40:24AM +0200, Tobias Ulmer wrote:

> When --quiet is requested, gc --auto should not display messages unless
> there is an error.
> [...]
> -		if (quiet)
> -			fprintf(stderr, _("Auto packing the repository for optimum performance.\n"));

That makes sense to me. I wonder if we should also be more careful about
propagating quiet flags from the callers of "gc --auto". For example,
"git am -q" will run "git gc --auto" without the quiet flag at the end,
potentially producing unwanted output.

-Peff
