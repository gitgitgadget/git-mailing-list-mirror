From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-pull - strange (copy/rename) messages ?!
Date: Tue, 01 Nov 2005 09:43:51 -0800
Message-ID: <7vbr149sbs.fsf@assigned-by-dhcp.cox.net>
References: <43678C73.1080601@excelsior-online.org>
	<Pine.LNX.4.64.0511010801370.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 18:45:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX0Au-0000QO-Fq
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 18:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbVKARnx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 12:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbVKARnx
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 12:43:53 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:13970 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751043AbVKARnw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 12:43:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051101174353.JMGQ9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Nov 2005 12:43:53 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10945>

Linus Torvalds <torvalds@osdl.org> writes:

> Btw, Junio, I thought "git pull" was only supposed to do rename 
> detection, not copy detection.

Sorry, but what do you mean by "only rename detection but not
copy detection" in this case?

When you have "ce A B; ce A C; ce A D;... ; mv A Z", (ce is like
cp but "copy+edit") where B-Z are all new files and A disappears
from the result, trying to detect renames would end up detecting
copies without extra processing; B through Z are rename
destination candidates, and A is a rename source candidate
(there may be others), and it turns out that B-Z all look like
A.

Would it be easier to read if we say A was renamed to B, and A
was renamed to C, and A was renamed to D, ...?  I think the
current output is easier to understand than that.  B-Y gets
labelled as copy of A and Z gets labelled as rename.
