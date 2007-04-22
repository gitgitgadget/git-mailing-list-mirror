From: Junio C Hamano <junkio@cox.net>
Subject: Re: Today's 'master' leaves .idx/.pack in 0400
Date: Sun, 22 Apr 2007 11:27:27 -0700
Message-ID: <7vejmcnu28.fsf@assigned-by-dhcp.cox.net>
References: <7vhcrml4wx.fsf@assigned-by-dhcp.cox.net>
	<7v1widrl0o.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704221019100.9964@woody.linux-foundation.org>
	<7vvefonvdz.fsf@assigned-by-dhcp.cox.net>
	<7vmz10nv1h.fsf_-_@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704221422250.28339@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 20:27:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfgmb-0003Sy-5S
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 20:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbXDVS13 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 14:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754351AbXDVS13
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 14:27:29 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:33084 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbXDVS12 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 14:27:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422182728.NOTI1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 14:27:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qJTT1W00W1kojtg0000000; Sun, 22 Apr 2007 14:27:28 -0400
In-Reply-To: <alpine.LFD.0.98.0704221422250.28339@xanadu.home> (Nicolas
	Pitre's message of "Sun, 22 Apr 2007 14:25:14 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45262>

Nicolas Pitre <nico@cam.org> writes:

> On Sun, 22 Apr 2007, Junio C Hamano wrote:
>
>> With recent glibc, mkstemp() creates 0400 file.  Updated
>> pack-objects uses it in pack/idx writing without fixing this,
>> hence this problem.
>
> Oops.  I guess I'm guilty for this.  I didn't bother looking at the 
> permission on the pack for git-pack-objects since git-repack seemed to 
> take care of that.  But it only _remove_ write permissions.

Ok, then probably we can change the 0444 in my "quickfix" patch
to 0644.  That should also let the 5300 test pass.
