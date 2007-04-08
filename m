From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/8] git-repack --max-pack-size: Add new file statics and struct fields
Date: Sun, 08 Apr 2007 16:55:20 -0700
Message-ID: <7vabxi8lqv.fsf@assigned-by-dhcp.cox.net>
References: <46197885.3060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 09 01:56:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HahEM-0006WO-TM
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 01:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbXDHXzW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 19:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbXDHXzW
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 19:55:22 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:45865 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbXDHXzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 19:55:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070408235521.RCHE1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 8 Apr 2007 19:55:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id knvM1W0071kojtg0000000; Sun, 08 Apr 2007 19:55:21 -0400
In-Reply-To: <46197885.3060502@gmail.com> (Dana How's message of "Sun, 08 Apr
	2007 16:19:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44019>

Dana How <danahow@gmail.com> writes:

> ... The fields
> in object_entry are re-arranged & shrunk to save memory.

Is the driving principle "place fields with coarser alignment
requirements first in the struct"?  I noticed you have a handful
pointers and an off_t after two short fields.  Two shorts would
be likely to make the next field aligned suitable for an int,
but (1) if we ever add another short later that would not be
true anymore, and (2) I suspect a pointer and an off_t can be
longer than an int but int would never be longer than them.
