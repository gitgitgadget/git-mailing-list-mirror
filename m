From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: Print a message describing the number of
	threads for packing
Date: Tue, 26 Feb 2008 16:25:16 -0500
Message-ID: <20080226212516.GB32530@sigill.intra.peff.net>
References: <47B1BEC6.6080906@nrlssc.navy.mil> <1203732369-30314-1-git-send-email-casey@nrlssc.navy.mil> <47BF812A.4020205@nrlssc.navy.mil> <20080226074933.GA3485@coredump.intra.peff.net> <47C435DC.2070508@nrlssc.navy.mil> <alpine.LFD.1.00.0802261149220.3167@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 22:26:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU7JN-0002as-3i
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 22:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765514AbYBZVZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 16:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765508AbYBZVZU
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 16:25:20 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4687 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765348AbYBZVZS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 16:25:18 -0500
Received: (qmail 6898 invoked by uid 111); 26 Feb 2008 21:25:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 26 Feb 2008 16:25:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Feb 2008 16:25:16 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802261149220.3167@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75176>

On Tue, Feb 26, 2008 at 12:05:46PM -0500, Nicolas Pitre wrote:

> > For example, it seems easy to do this:
> > 
> > 	git config pack.thread 4
> > 	git repack
> > 
> > The user would immediately know something was wrong when they saw the
> > message "Using 1 pack threads" instead of the "4" they thought they
> > configured.
> 
> Maybe a message for any unrecognized config option should be displayed 
> instead.

I think that is generally useful, though it is somewhat hard with our
config parsing mechanism. You could handle specific cases like "I'm in
git_pack_config, this is a pack.* variable, and I don't understand it".
But it would be nice to have a general "no callback claimed to
understand this variable" which I think is impossible (since we do
things like parsing the config just to grab a small part of it).

> Also, I think that such message should absolutely not be sent over in 
> the context of a fetch/clone.  This is a local matter only, and should 
> be displayed only when those progress messages are meant for the local 
> user.
> 
> Therefore I propose this patch instead:

I think that is a nice addition to my patch, but I am also fine with
simply reverting 6c723f5e entirely, as Brandon suggested.

-Peff
