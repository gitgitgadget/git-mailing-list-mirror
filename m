From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD/PATCH] Implement pack.compression and pack-objects --compression=N
Date: Thu, 03 May 2007 22:49:02 -0700
Message-ID: <7vejlxxho1.fsf@assigned-by-dhcp.cox.net>
References: <463802ED.1080200@gmail.com>
	<7vk5vr3w8n.fsf@assigned-by-dhcp.cox.net>
	<56b7f5510705021155k40b576d6ke286e65494fc8b05@mail.gmail.com>
	<56b7f5510705021551q2d48f1e5i3f4a5c2f9891368a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 07:49:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjqfI-00037Q-5W
	for gcvg-git@gmane.org; Fri, 04 May 2007 07:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbXEDFtH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 01:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753880AbXEDFtH
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 01:49:07 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:35314 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbXEDFtF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 01:49:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070504054903.XBDG1318.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 4 May 2007 01:49:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id utp31W0081kojtg0000000; Fri, 04 May 2007 01:49:03 -0400
In-Reply-To: <56b7f5510705021551q2d48f1e5i3f4a5c2f9891368a@mail.gmail.com>
	(Dana How's message of "Wed, 2 May 2007 15:51:25 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46132>

"Dana How" <danahow@gmail.com> writes:

> So for a 25% increase in blob size I get 33% less elapsed time
> in git-add, all by changing core.compression from -1 to 1.
> I'll definitely take that improvement.  [For the compressible files
> we typically have, using 0 is a bad idea:  the CPU "advantage"
> is swamped out by the time to write a much larger file.]

The above number is about loose objects, right?

> Since I don't care [to the same degree] about the responsiveness of
> packing,  I'd rather pack with -1 or better to keep packs small.

I see.  You are saying that the fact that core.compression is
used also for packing makes the variable less useful.

I agree that it would make sense to have at least the pack and
core compression independent.  I am not sure if we would also
want to make the pack compression tweakable depending on the
purpose of the packing (network transfer vs .git/objects/pack/).

> (And inflation time seems independent of compression setting.)

True.
