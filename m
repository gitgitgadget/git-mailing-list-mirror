From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] SVN import: Use one log call
Date: Wed, 30 Nov 2005 09:34:39 +0100
Message-ID: <20051130083436.GZ20418@kiste.smurf.noris.de>
References: <pan.2005.11.29.07.13.02.145977@smurf.noris.de> <7vhd9vdx1o.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511292247591.3122@localhost.localdomain> <20051130065241.GY20418@kiste.smurf.noris.de> <7vwtiqwoy7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 10:58:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhNS3-0001d7-7m
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 09:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVK3Ig1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 03:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVK3Ig1
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 03:36:27 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:56472 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1751133AbVK3Ig0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 03:36:26 -0500
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1EhNQF-00043p-Nl; Wed, 30 Nov 2005 09:35:37 +0100
Received: (nullmailer pid 6403 invoked by uid 501);
	Wed, 30 Nov 2005 08:34:39 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtiqwoy7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12994>

Hi,

Junio C Hamano:
> 	$ git svnimport -T main/sources \
> 	    http://127.0.0.1/svn/private/main/sources/photocat
> 
> seems to be doing something.  But I do not understand why.  How
> did you decide "-T main/sources" is good for my case while "-T
> main/brltty" is good for Nicolas?  I would have guessed you may
> say "-T main" for Nicolas, dropping the last path component.
> 
What git-svnimport does right now is rather simple. It pulls the log
from the SVN URL, drops everything that does not have a prefix of either
of the -t tags -T trunk -b branches options. The prefix is then thrown
away. If it's a trunk, import the rest to the "origin" branch; otherwise
remove the next path component and use that as either the branch name
or the tag name.

The point is that the picture in the SVN manual is incomplete. 
There's not just a branches/ subdirectory alongside the trunk/ one;
trunk/ directly contains the project's files, while branches/ contains
subdirectories which are named for the branch, and *they* contain the
files.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
If you're looking ahead long-term, and what you see looks like
science fiction, it might be wrong. But if it doesn't look like
science fiction, it's definitely wrong...
		-- Christine Peterson,
