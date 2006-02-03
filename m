From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Attn - repository browser authors] diff-tree combined format.
Date: Fri, 03 Feb 2006 13:35:07 -0800
Message-ID: <7v1wykceic.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602012334360.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602012353130.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602020002110.21884@g5.osdl.org>
	<7voe1qtbr5.fsf_-_@assigned-by-dhcp.cox.net>
	<7vvevyrtn9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602021454060.21884@g5.osdl.org>
	<7v64nxmhqn.fsf@assigned-by-dhcp.cox.net>
	<7v1wylkn54.fsf_-_@assigned-by-dhcp.cox.net>
	<e5bfff550602030417w290c12b6yc4406f890acadc73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>,
	Kay Sievers <kay.sievers@suse.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 22:35:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F58aX-0004hX-7M
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 22:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945989AbWBCVfM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 16:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945990AbWBCVfL
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 16:35:11 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:18407 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1945989AbWBCVfK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 16:35:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060203213225.XPMY17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Feb 2006 16:32:25 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550602030417w290c12b6yc4406f890acadc73@mail.gmail.com>
	(Marco Costalba's message of "Fri, 3 Feb 2006 13:17:50 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15556>

Marco Costalba <mcostalba@gmail.com> writes:

> Regarding the rest is all OK for me. I choose to do not alter/coloring
> the patch as gitk does, but to always use red for removed lines and
> green for added and to keep the patch output _as is_ . I found this
> more simple and clear, at least for me.

This reminds me of one thing.  One thing I did not like about
the colouring of gitk on an Octopus was that it repeats the same
parents in different colors, wasting lines.  From diff-tree -c
output, one thing coloured diff browsers _could_ do is to let
the user pick one parent and paint the lines to make the
differences from that parent alone stand out.

For example, If I had this, and I wanted to focus on the
difference from the first parent:

        diff --cc foo
        index 92cfee4,50392ff..e9bf860
        @@@ -55,A -55,B +55,C @@@
          # Define USE_STDEV below if you want git to care...
          # change being considered an inode change from t...

        - GIT_VERSION = 0.99.9n
         -GIT_VERSION = 0.99.9.GIT
        ++GIT_VERSION = 1.0.0
         +# This line was already in the first parent
        + # Not in the first parent but in the second already

          # CFLAGS and LDFLAGS are for the users to overri...

You could paint '  ' (unchanged from both) and ' +' (unchanged
from first parent) lines the same way (say white background with
black letters), '- ' (first parent had it but it is gone) lines
red and '+ ' and '++' (either way, first parent did not have it)
lines green.  And ' -' (disappeared from second parent, but
neither first parent nor the result has it) can even be dimmed
(say white background with gray letters).
