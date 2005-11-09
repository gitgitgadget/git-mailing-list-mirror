From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Real-life kernel debugging scenario
Date: Wed, 9 Nov 2005 10:36:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511091028241.3247@g5.osdl.org>
References: <dkosr7$f4s$1@sea.gmane.org> <Pine.LNX.4.64.0511071721200.3247@g5.osdl.org>
 <Pine.LNX.4.64.0511090901370.6744@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 19:40:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZuoj-0007z7-OH
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 19:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbVKIShA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 13:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbVKIShA
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 13:37:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38539 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751478AbVKISg5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 13:36:57 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA9IapnO018415
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 9 Nov 2005 10:36:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA9IaowD004065;
	Wed, 9 Nov 2005 10:36:50 -0800
To: wa1ter@myrealbox.com
In-Reply-To: <Pine.LNX.4.64.0511090901370.6744@x2.ybpnyarg>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11408>



On Wed, 9 Nov 2005, wa1ter@myrealbox.com wrote:
> 
> The built-in variable ORIG_HEAD isn't explained anywhere AFAICT, or at
> least it wasn't until today.  Are there other such magic variables which
> might be useful for us to know about?

No, ORIG_HEAD is pretty much it.

There's a few special files that a non-committed merge leaves around 
(either because you asked it to not be committed, or because it had 
clashes and requires manual fixing), but they are not normally useful to 
any regular people. You can poke around in the ".git" directory after such 
a merge if you want (MERGE_HEAD, MERGE_MSG).

ORIG_HEAD is _very_ useful, though, and I use it all the time. Any time 
you've pulled something from somebody else, and you wonder what you 
pulled, just go

	gitk ORIG_HEAD..

and you'll see exactly what new stuff you got in your branch. I often do 
that command line several times a day as I merge stuff. Otherwise the new 
stuff tends to be hidden in the noise.

(There's also FETCH_HEAD, which is the head of the last fetch, so if you 
aren't interested in any potential merge, you could instead use the range 
ORIG_HEAD..FETCH_HEAD, but quite frankly, I doubt anybody really cares 
except for the internal git fetching/pulling logic).

		Linus
