From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-mailinfo: cut lines at ^M
Date: Mon, 16 Jan 2006 15:38:52 -0800
Message-ID: <7v1wz7n3oz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0601161104070.13339@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 17 00:39:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EydwA-0004uP-Sf
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 00:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWAPXi4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 18:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWAPXi4
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 18:38:56 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:54219 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751290AbWAPXi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 18:38:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060116233803.LFDQ3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 Jan 2006 18:38:03 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14767>

Linus Torvalds <torvalds@osdl.org> writes:

> Junio, feel free to ignore this. It shouldn't hurt, but
> admittedly it's a stupid hack for a problem that has nothing
> to do with git...

This is doing "instead of removing trailing spaces, terminate a
line at the first CR or LF and discard the rest".  So your "^M)"
at the end, especially the close paren, is dropped.

I've briefly wondered if a better alternative is to split lines
at "\r\n", "\n", or "\r", which would make the next line begin
with ")" in your example.  Normally the first two would have
already been done by fgets(), so the alternative approach would
involve wrapping the use of fgets() with something of our own.
I do not think "keeping the rest of the line after '\r' in the
middle" is worth that trouble, so I am personally fine with your
patch.
