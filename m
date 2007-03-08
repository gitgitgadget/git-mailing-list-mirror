From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] Teach receive-pack to run pre-receive/post-receive hooks
Date: Wed, 07 Mar 2007 16:00:26 -0800
Message-ID: <7vbqj4eh9h.fsf@assigned-by-dhcp.cox.net>
References: <20070307215205.GE28649@spearce.org>
	<Pine.LNX.4.64.0703071522030.5963@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 01:00:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP63c-0006AB-BJ
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 01:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992779AbXCHAA3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 19:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992782AbXCHAA2
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 19:00:28 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:43433 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992779AbXCHAA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 19:00:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070308000028.RCVQ2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Mar 2007 19:00:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y00S1W00m1kojtg0000000; Wed, 07 Mar 2007 19:00:27 -0500
In-Reply-To: <Pine.LNX.4.64.0703071522030.5963@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 7 Mar 2007 15:31:56 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41706>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Can you give a concise explanation of how "pre-receive" differ from the 
> old "update", and how does "post-receive" differ from the old 
> "post-update"?

They are somewhat redundant.  They get everything at once,
unlike update hook.

The old interface is adequate to do the same thing if you
arrange them so that update hook notes which refs (with what old
sha1 value it had) were asked to be updated, and make your
post-update hook (which gets the names of refs) notice if some
of them failed and from what ref a successful update happened.
But getting everything at once is sometimes easier to work
with.
