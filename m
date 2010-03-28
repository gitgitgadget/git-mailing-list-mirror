From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] fast textconv
Date: Sun, 28 Mar 2010 12:19:21 -0400
Message-ID: <20100328161921.GA3435@coredump.intra.peff.net>
References: <20100328145301.GA26213@coredump.intra.peff.net>
 <4BAF7F3F.5020604@drmicha.warpmail.net>
 <20100328161728.GA2828@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Mar 28 18:19:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvvD6-00075u-Uq
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 18:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776Ab0C1QTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 12:19:32 -0400
Received: from peff.net ([208.65.91.99]:40006 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754752Ab0C1QTb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 12:19:31 -0400
Received: (qmail 24646 invoked by uid 107); 28 Mar 2010 16:20:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 28 Mar 2010 12:20:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Mar 2010 12:19:21 -0400
Content-Disposition: inline
In-Reply-To: <20100328161728.GA2828@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143395>

On Sun, Mar 28, 2010 at 12:17:28PM -0400, Jeff King wrote:

> If I understand you right, you are proposing a separate program
> that you would pass as a fasttextconv helper, and that would look in a
> notes tree. So you would still have a per-diff fork/exec, and pipe all
> the data.
> 
> I was thinking of actually doing it in-core, so cache hits would be as
> lightweight as a notes lookup (and cache misses obviously would still
> fork/exec a helper, but we don't care too much since the helper's time
> to convert will dominate in that path).

Side note: I think I might prototype it as a separate program and see
what kind of speed I can get.

> > Pruning the cache is done be deleting the refs/notes/bikeshed ref,
> > truncating it by truncating it's DAG (filter-branch...).
> 
> Yeah, that would work. It just means it's one more thing the user has to
> deal with. I didn't want to have to introduce a "git textconv"
> management helper. ;)

Other side note: it's not even that it's that hard to prune. It's that
you might tweak your config, and then you have to _remember_ to prune.

-Peff
