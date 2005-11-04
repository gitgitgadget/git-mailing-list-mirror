From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Cogito: Support for implicit remote branches in cloned repositories
Date: Fri, 4 Nov 2005 22:08:20 +0100
Message-ID: <20051104210820.GM1431@pasky.or.cz>
References: <200511041701.48881.Josef.Weidendorfer@gmx.de> <7vvez8wbpz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 22:11:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY8nY-00007Y-Ku
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 22:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbVKDVIa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 16:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbVKDVIa
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 16:08:30 -0500
Received: from w241.dkm.cz ([62.24.88.241]:5293 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750727AbVKDVI3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2005 16:08:29 -0500
Received: (qmail 32301 invoked by uid 2001); 4 Nov 2005 22:08:20 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvez8wbpz.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11157>

Dear diary, on Fri, Nov 04, 2005 at 06:43:04PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
>   I once considered to give an option to clone to map the origin
>   heads to .git/refs/heads/origin/{master,maint,pu,...}.  In
>   hindsight that might have been cleaner.  Instead I just followed
>   what Cogito already established, and mapped remote "master" to
>   "origin".

Well, that obviously works only when you resign on the workflow where
pull means fetch + merge, since your local master would conflict with
the remote master, therefore having nowhere to store the remote master.

> . The namespace under refs/tags theoretically also has the same
>   issue, but I suspect it would not matter too much in practice.
>   The tags people fetches from remote tend to be release-point
>   tags (e.g. v2.6.14) whose names implicitly follow an obvious
>   (to humans) naming convention; when you name your temporary
>   anchor points using lightweight tags, you can easily avoid
>   name clashes with those "for other people" tags [*2*].

I still believe we need the notion of private tags which shouldn't be
cloned.

Hmm. Wait.

All right. git-update-server-info ignores hidden refs, but referencing a
hidden ref works all right (unsurprisingly). So let's just codify that
private tags which shan't be fetched (unless requested explicitly) start
with a dot (/^\./) and we are all set...?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
