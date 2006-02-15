From: Martin Mares <mj@ucw.cz>
Subject: Shared repositories and umask
Date: Wed, 15 Feb 2006 13:19:07 +0100
Message-ID: <mj+md-20060215.120104.14337.atrey@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 15 13:19:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Lcp-0005ek-0C
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 13:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWBOMTJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 07:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945914AbWBOMTJ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 07:19:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52356 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751076AbWBOMTI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 07:19:08 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 1000)
	id 8EAAA4B426D; Wed, 15 Feb 2006 13:19:07 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16239>

Hello, world!\n

I'm playing with a shared repository and I am still unable to get the
file and directory permissions kept correctly, that is writeable to
a group.

Setting the `core.sharedrepository' flag helps a bit, but not completely:
the object files and directories are group-writeable, but for example new
head refs aren't.

The documentation hints on setting umask, but I would really like to avoid
doing that globally, because the user accounts are used for many other
things as well where the permissions should be tighter.

It seems that a correct solution would be to add an `umask' option to
the repository config and make enter_repo() adjust the umask accordingly.

I was thinking about doing the same in setup_git_directory() for the
local commands, but that probably doesn't make much sense since many commands
are in fact scripts creating files themselves.

If you agree, I will send a patch.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Q: How many Prolog programmers does it take to change a light bulb?  A: No.
