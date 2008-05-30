From: Petr Baudis <pasky@suse.cz>
Subject: git-log vs git-rev-list
Date: Fri, 30 May 2008 18:56:41 +0200
Message-ID: <20080530165641.GG18781@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 18:57:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K27v8-0005NV-D2
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 18:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbYE3Q4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 12:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbYE3Q4q
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 12:56:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59715 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221AbYE3Q4p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 12:56:45 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 2233B1E4C027; Fri, 30 May 2008 18:56:41 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83316>

  Hi,

  the baroque usage options of both git-log and git-rev-list make them
pretty much equivalent as far as I can see, except that:

  * Both have slightly different options set

  * git log --pretty=format is actually sane and does not pollute the
output with spurious 'commit' lines

  * I assume there are more subtle behaviour differences

  I think that having two commands that by now do essentially the same
thing, but slightly differently, is rather messy UI. Thus, I'm wondering
if it would be worthwhile to make rev-list a thin git-log wrapper and
start phasing it out?

  Yes, git-rev-list is supposed to be a plumbing thing, but from my
porcelain, I actually have to use git-log anyway if I'm to avoid messing
up my code with workarounds to the --pretty=format commit lines
evilness (hey, if I'm using --pretty=format, it means I actually want
to _control_ rev-list output, not having it trying to outsmart me
anyway).

  Merging porcelain and plumbing interface in a single command may sound
like a bad idea UI-wise, but I believe that consolidation would actually
result in a UI _improvement_ - you can cleanly separate the
documentation to the porcelain and plumbing part (actually, maybe
pushing all the plumbing part like --pretty documentation to
git-log-plumbing(1), having actually user-relevant options like -p or
--no-meges in git-log(1)). And you do not have to tell the user "oh, and
there is also git-rev-list(1) which does the same thing, but
differently; ah, and for some reason you are also to use only that one
if you need to query for bisect points".

  Should I do it?

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
