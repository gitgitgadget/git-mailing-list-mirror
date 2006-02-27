From: Junio C Hamano <junkio@cox.net>
Subject: Re: the war on trailing whitespace
Date: Sun, 26 Feb 2006 16:45:42 -0800
Message-ID: <7vr75p4ojt.fsf@assigned-by-dhcp.cox.net>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
	<20060225210712.29b30f59.akpm@osdl.org>
	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
	<20060226103604.2d97696c.akpm@osdl.org>
	<Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>, junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 01:45:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDWWL-0001bl-Kr
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 01:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWB0Apr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 19:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWB0Apr
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 19:45:47 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:15233 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750712AbWB0Apq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 19:45:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060227004407.UKKN6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Feb 2006 19:44:07 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602261213340.22647@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 26 Feb 2006 12:16:25 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16814>

Linus Torvalds <torvalds@osdl.org> writes:

> Personally, I don't mind whitespace that much. In particular, I _suspect_ 
> I often have empty lines like
>
> 	int i;
> 	
> 	i = 10;
>
> where the "empty" line actually has the same indentation as the lines 
> around it. Is that wrong? Perhaps.

Yes, you do, and I hand-fixed one a couple of minutes ago ;-).

Regarding git-apply change, I suspect warn_on_whitespace should
not squelch itself after the first one, and error_on_whitespace
should not die instantly.  The sample pre-applypatch hook (it
was missing code to figure out where GIT_DIR was so it never
worked as shipped; corrected in "master") shows line numbers of
suspicious lines from the files being patched.  They can be
manually fixed up, and then "git am --resolved", if the
integrator is in a better mood.

The error messages from pre-commit/pre-applypatch hook mimic the
way compiler errors are spit out, so that it works well in Emacs
compilation buffer -- doing C-x ` (next-error) takes you the
line the error appears and lets you edit it.
