From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/5] Add --remote option to send-pack
Date: Sat, 28 Apr 2007 22:49:38 -0700
Message-ID: <7vtzuzg26l.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704281304360.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Apr 29 07:49:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hi2I2-0001kT-GO
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 07:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193AbXD2Ftk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 01:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756206AbXD2Ftk
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 01:49:40 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:46438 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193AbXD2Ftj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 01:49:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070429054938.PDVO1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 29 Apr 2007 01:49:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id stpe1W00J1kojtg0000000; Sun, 29 Apr 2007 01:49:38 -0400
In-Reply-To: <Pine.LNX.4.64.0704281304360.28708@iabervon.org> (Daniel
	Barkalow's message of "Sat, 28 Apr 2007 13:05:18 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45811>

Daniel Barkalow <barkalow@iabervon.org> writes:

> With the --remote option, send-pack will look at the remote
> configuration for the specified remote (which must match the
> destination URL), and update the local tracking refs to match changes
> it causes in the remote heads they track.
>
> The previous values of local tracking heads are ignored.

I didn't actually look at the code of this patch, as I am
rejecting the initial round of [PATCH 2/5] this depends on, but
this is one thing Cogito did that we don't, and I think it makes
sort of sense.  We pretend as if we fetched back immediately
after we pushed without giving anybody a chance to further
update the refs we updated at the remote.  I generally do not
like "pretend that we did something" when talking about reliable
operations (and SCM _is_ all about reliable operation), and this
behaviour is exactly it, but I think this one is excusable.
