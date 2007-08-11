From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-diff: Output a warning about stale files in the index
Date: Sat, 11 Aug 2007 13:07:33 -0700
Message-ID: <7vzm0xltru.fsf@assigned-by-dhcp.cox.net>
References: <7vbqdj9709.fsf@assigned-by-dhcp.cox.net>
	<20070807071712.GA32751@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 22:07:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJxFJ-0001DD-VQ
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 22:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152AbXHKUHf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 16:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755055AbXHKUHf
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 16:07:35 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:49427 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368AbXHKUHe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 16:07:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070811200733.HLKY7193.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 16:07:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ak7Z1X00b1kojtg0000000; Sat, 11 Aug 2007 16:07:34 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55626>

Actually this is wrong in two points:

 * The filtering should be done upfront at the beginning of the
   diffcore_std(), not before the end.  Otherwise, unchanged but
   cache dirty file could be subject to copy detection.

 * I do not think it should affect the low-level git-diff-* (or
   you should update the tests, documentations and perhaps
   whatever people can find from google).

By the way, I had an updated version of my patch to fix the
first point on 'pu' for a while.
