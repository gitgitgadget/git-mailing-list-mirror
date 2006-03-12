From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree -M performance regression in 'next'
Date: Sat, 11 Mar 2006 19:10:35 -0800
Message-ID: <7v7j70gxxw.fsf@assigned-by-dhcp.cox.net>
References: <20060311172818.GB32609@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Mar 12 04:11:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIGyt-0004kN-9W
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 04:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWCLDKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Mar 2006 22:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWCLDKk
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Mar 2006 22:10:40 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:52406 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751103AbWCLDKj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Mar 2006 22:10:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060312030740.JAGN17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Mar 2006 22:07:40 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060311172818.GB32609@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Sat, 11 Mar 2006 18:28:18 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17506>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> I turned out that the rename detection took almost 10 minutes on my
> machine.

Yes, that is one of the reasons why it still is in "next", not
in "master".

The rename-detector change was done primarily to work around the
correctness problem the finer-grained delta changes would have
introduced.  The new delta code would have produced far more
copies from the source than the current xdelta code, but the
nature of the new copies it would have found was quite different
from what we would usually call "file being renamed".  Now we
decided to shelve the finer-grained delta code for now, I do not
see a pressing reason to have the experimental rename detector
graduate to "master" until we resolve its performance issues.
