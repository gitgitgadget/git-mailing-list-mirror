From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 15:07:50 -0700
Message-ID: <7vodm5un61.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
	<db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
	<Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704031322490.6730@woody.linux-foundation.org>
	<alpine.LFD.0.98.0704031657130.28181@xanadu.home>
	<Pine.LNX.4.64.0704031413200.6730@woody.linux-foundation.org>
	<alpine.LFD.0.98.0704031735470.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:08:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYrAW-0006BI-IR
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 00:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946000AbXDCWHw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 18:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946003AbXDCWHw
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 18:07:52 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:50045 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946000AbXDCWHv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 18:07:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070403220751.UFDP373.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Apr 2007 18:07:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id im7q1W0021kojtg0000000; Tue, 03 Apr 2007 18:07:50 -0400
In-Reply-To: <alpine.LFD.0.98.0704031735470.28181@xanadu.home> (Nicolas
	Pitre's message of "Tue, 03 Apr 2007 17:42:01 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> Make it conditionnal on --stdin then.  This covers all cases where we 
> really want the secure thing to happen, and the --stdin case already 
> perform the atomic rename-and-move thing when the pack is fully indexed.

Repacking objects in a repository uses pack-objects without
using index-pack, as you suggested Chris.  Is there a sane usage
of index-pack that does not use --stdin?  I do not think of any.

If there isn't, the "conditional on --stdin" suggestion means we
unconditionally do the secure thing for all the sane usage, and
go unsecure for an insane usage that we do not really care about.

If so, it seems to me that it would be the simplest not to touch
the code at all, except that missing free().

Am I missing something?
