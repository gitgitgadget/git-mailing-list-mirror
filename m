From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/5] Add --remote option to send-pack
Date: Fri, 04 May 2007 23:33:03 -0700
Message-ID: <7vr6pvn5k0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704281304360.28708@iabervon.org>
	<7vtzuzg26l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704290152410.28708@iabervon.org>
	<7vejm3g0dg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705022330460.28708@iabervon.org>
	<7virba31wd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705030137520.28708@iabervon.org>
	<7vejly305u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705050115270.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat May 05 08:33:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkDps-0005ct-2w
	for gcvg-git@gmane.org; Sat, 05 May 2007 08:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031499AbXEEGdG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 02:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031501AbXEEGdG
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 02:33:06 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52284 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031499AbXEEGdF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 02:33:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070505063305.TDMD22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 5 May 2007 02:33:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vJZ41W0031kojtg0000000; Sat, 05 May 2007 02:33:05 -0400
In-Reply-To: <Pine.LNX.4.64.0705050115270.28708@iabervon.org> (Daniel
	Barkalow's message of "Sat, 5 May 2007 01:21:42 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46245>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Is this actually supported in config files? At least for pulls, the "tag 
> <tag>" notation is only available on the command line, afaict.

That is the only difference as far as I remember.  But you are
right in that the set of refspecs allowed on the command line
does not have to coincide with the ones in remotes file or the
config (the latter two should match, though), and the latter may
not be documented (the intention was to match all of them so the
quoted documentation was enough, but having "tag <tag>" in
config does not make sense).  Documentation/config.txt could use
a bit of updates.  Hint, hint.

> I think that having "<ref>:" or "<ref>" in a config file fetch 
> line would be really bad; these refs would always be merged into any 
> current head (without any remote tracking) when the remote is fetched 
> from?

It's not bad at all.  Why people are so eager to _force_
tracking on other people, I do not understand.

I had a moral equivalent of this in .git/remotes/origin (back
then .git/config did not exist) when I was a contributor:

	[remote "origin"]
        	url = git.kernel.org:/pub/scm/git/git.git/
                fetch = refs/heads/master

If the user does not want to track, he does not have to.
