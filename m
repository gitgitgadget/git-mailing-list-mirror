From: Petr Baudis <pasky@suse.cz>
Subject: Re: Merge conflict.
Date: Sat, 13 Aug 2005 18:17:08 +0200
Message-ID: <20050813161708.GH5608@pasky.ji.cz>
References: <pan.2005.08.13.14.45.32.401071@canit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 18:18:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3yhF-000851-39
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 18:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVHMQRM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 12:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVHMQRM
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 12:17:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42508 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S1751350AbVHMQRL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 12:17:11 -0400
Received: (qmail 22416 invoked by uid 2001); 13 Aug 2005 16:17:08 -0000
To: Kenneth Johansson <ken@canit.se>
Content-Disposition: inline
In-Reply-To: <pan.2005.08.13.14.45.32.401071@canit.se>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Aug 13, 2005 at 04:45:32PM CEST, I got a letter
where Kenneth Johansson <ken@canit.se> told me that...
> I used cogito to do a cg-update and got conflicts and the exact files are
> printed to the screen. But say I somehow lost that output is there anyway
> to list conflicting files ??
> 
> cg-status shows the files as modified but that also includes non
> conflicting files.
> 
> The best I could find was to do a "git-update-cache --refresh" but that
> still do not tell me if I already have removed the conflict in the file.
> 
> Is this not something that needs to be answered if we ever are going to
> have a graphical merge tool?

Yes, I know about this problem and something should be done about it.
The possible approaches:

* Check for /^<<<<<<</ lines (that's what CVS does)
	+: User does not need to take an explicit action to indicate
	   resolved conflict.
	-: False positives if the file with conflict contains that
	   string naturally.

* Make auxiliary files and check for their existence (what SVN does)
	+: User can use the auxiliary files (usually containing the
	   to-be-merged revisions) for better conflict resolution,
	   or run some own merging tool on it later.
	-: Extremely rare false positives.
	-: User needs to explicitly get rid of the files to get rid
	   of the conflict.

* Keep the conflict recorded in index
	+: No junk in working directory, cg-status should start working
	   right away.
	-: Unknown caveats wrt. index files containing conflicts...?
	-: User needs to explicitly run cg-resolve or something to
	   get rid of the conflict.

Ideas? Opinions?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
