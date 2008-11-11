From: Jeff King <peff@peff.net>
Subject: Re: Git Notes - Track rebase/etc + reverse-lookup for bugs ideas
Date: Mon, 10 Nov 2008 19:31:36 -0500
Message-ID: <20081111003136.GA26481@coredump.intra.peff.net>
References: <6A0F154C-B9FE-4770-BF70-82A5BEBF907C@gmail.com> <20081110191134.GA3329@sigill.intra.peff.net> <alpine.DEB.1.00.0811102049460.30769@pacific.mpi-cbg.de> <74EBEC20-FC39-444E-8B96-31E5B36894B8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Thomas Harning <harningt@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 01:32:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzhBe-0001n7-5o
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 01:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbYKKAbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 19:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbYKKAbj
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 19:31:39 -0500
Received: from peff.net ([208.65.91.99]:1512 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbYKKAbj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 19:31:39 -0500
Received: (qmail 9868 invoked by uid 111); 11 Nov 2008 00:31:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 10 Nov 2008 19:31:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2008 19:31:36 -0500
Content-Disposition: inline
In-Reply-To: <74EBEC20-FC39-444E-8B96-31E5B36894B8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100607>

On Mon, Nov 10, 2008 at 03:26:52PM -0500, Thomas Harning wrote:

> What I intended is that if notes are attached to 'A',  A` (after a  
> rebase) will have the exact same note.

I think that may have been brought up at the GitTogether. It would be
very easy, when rebasing A to A', to copy any notes for A to A'
(retroactively applying notes for A' to A (or vice versa) is much
harder, since we don't maintain any mapping between the two).

_But_ that is not necessarily a good idea in all cases, because your
notes may say certain things about A like "I tested this on system X".
But you _haven't_ tested A', and it might not pass your test. Leaving
aside editing the commits with "rebase -i", there might just be a bad
interaction with the commit you rebased onto.

So I think it would probably make sense to add a "--copy-notes" option
to rebase for those times when the user knows it makes sense, but doing
so by default is probably a mistake.

-Peff
