From: Jeff King <peff@peff.net>
Subject: Re: Incorrect git-blame result if I use full path to file
Date: Sun, 2 Dec 2007 21:49:16 -0500
Message-ID: <20071203024916.GA11003@coredump.intra.peff.net>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com> <20071203022729.GD8322@coredump.intra.peff.net> <7v4pf0sdp7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 03:49:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz1NK-0004eL-VP
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 03:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbXLCCtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 21:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbXLCCtT
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 21:49:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1340 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbXLCCtS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 21:49:18 -0500
Received: (qmail 25681 invoked by uid 111); 3 Dec 2007 02:49:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Dec 2007 21:49:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Dec 2007 21:49:16 -0500
Content-Disposition: inline
In-Reply-To: <7v4pf0sdp7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66852>

On Sun, Dec 02, 2007 at 06:40:36PM -0800, Junio C Hamano wrote:

> > Even more useful would be to convert
> > /path/to/repo/file to 'file' internally.
> 
> ... that might help "cut & paste from file manager" people, and I think
> we had comment session for such a patch recently on the list.
> 
> Sorry, but I lost track of that the current status of that patch.  Did
> it die?

I didn't pay attention to it originally, but I assume you mean the
recent patch from Robin Rosenberg (cc'd). Looking it over, I see one
obvious omission: there is no canonicalization of the paths. IOW, I
think it will break in the presence of symlinks (if I specify
/path/to/repo/file, /path/to is a symlink to /other/path, I think the
worktree will end up as /other/path/repo, and fail a string comparison
with /path/to/repo).

-Peff
