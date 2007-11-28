From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] "color.diff = true" is not "always" anymore.
Date: Wed, 28 Nov 2007 14:04:39 -0500
Message-ID: <20071128190439.GA11396@coredump.intra.peff.net>
References: <474B42EC.1000408@wanadoo.fr> <7vr6icej23.fsf@gitster.siamese.dyndns.org> <7vd4tuakzj.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 20:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxSEE-0000oJ-0z
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 20:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594AbXK1TEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 14:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755511AbXK1TEm
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 14:04:42 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2881 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755540AbXK1TEm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 14:04:42 -0500
Received: (qmail 13381 invoked by uid 111); 28 Nov 2007 19:04:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 28 Nov 2007 14:04:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2007 14:04:39 -0500
Content-Disposition: inline
In-Reply-To: <7vd4tuakzj.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66412>

On Tue, Nov 27, 2007 at 11:26:56PM -0800, Junio C Hamano wrote:

> Too many people got burned by setting color.diff and color.status to
> true when they really should have set it to "auto".
> 
> This makes only "always" to do the unconditional colorization, and
> change the meaning of "true" to the same as "auto": colorize only when
> we are talking to a terminal.

I think this is a good change. However, there needs to be a matching
change for all scripts which read the color.* variables (git-svn is the
only one now, I think, but Dan's git-add--interactive patch does the
same thing).

It would be nice to have a "git config --colorbool" option, but it has
the unfortunate problem that the stdout of "git config" is piped back to
the caller, so the isatty check is meaningless (and the "pager in use"
is similarly tricky). Perhaps it should go in Git.pm, so it at least
only needs to be written once.

-Peff
