From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 7/11] Avoid git-fetch in `git-pull .` when possible.
Date: Thu, 28 Dec 2006 00:08:16 -0800
Message-ID: <7v8xgsxx1r.fsf@assigned-by-dhcp.cox.net>
References: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
	<20061228073517.GG17867@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 09:08:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzqJR-0003i4-I6
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 09:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWL1IIV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 03:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWL1IIV
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 03:08:21 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:56917 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964959AbWL1IIS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 03:08:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061228080817.GQEF3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 03:08:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 488X1W0061kojtg0000000; Thu, 28 Dec 2006 03:08:31 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35535>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Users may also now use `git-pull . foo~3` to merge the early part
> of branch foo.  This was not previously possible as git-fetch does
> not know how to fetch foo~3 from a repository.

I personally think this is not an improvement, but rather a new
source of confusion.  If the user wants a local merge, there is
'git-merge'.  And the distinction between the commands makes it
clear that local merge can merge any commits exactly because
they are available locally, while remote fetch+merge needs to
choose from what the remote side offers so not arbitrary commits
like foo@{3.days.ago} cannot be pulled.

Also I thought there was a configuration variable that talks
about "remote = ."  (didn't I merge that patch -- I do not
remember offhand) and I wonder how that interacts with this
change.

How much performance gain are we talking about here?
