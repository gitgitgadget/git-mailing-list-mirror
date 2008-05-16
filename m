From: Nikolaus Schulz <microschulz@web.de>
Subject: partial globbing in fetch refspecs broken in v1.5.5
Date: Fri, 16 May 2008 23:28:34 +0200
Message-ID: <20080516212833.GA5366@penelope.zusammrottung.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 23:29:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx7UY-00014l-5Z
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 23:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348AbYEPV2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 17:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754947AbYEPV2j
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 17:28:39 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:44519 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbYEPV2j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 17:28:39 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id AD77DDB039D8
	for <git@vger.kernel.org>; Fri, 16 May 2008 23:28:37 +0200 (CEST)
Received: from [83.125.40.75] (helo=tunichtgut.zusammrottung.local)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1Jx7Th-0007Or-00
	for git@vger.kernel.org; Fri, 16 May 2008 23:28:37 +0200
Received: from penelope.zusammrottung.local ([192.168.178.202])
	by tunichtgut.zusammrottung.local with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nikolaus@penelope.zusammrottung.local>)
	id 1Jx7Tf-0001yF-SW
	for git@vger.kernel.org; Fri, 16 May 2008 23:28:35 +0200
Received: from nikolaus by penelope.zusammrottung.local with local (Exim 4.63)
	(envelope-from <nikolaus@penelope.zusammrottung.local>)
	id 1Jx7Te-0001Of-KR
	for git@vger.kernel.org; Fri, 16 May 2008 23:28:34 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Sender: microschulz@web.de
X-Provags-ID: V01U2FsdGVkX18SX5CD4foS/aGDz+mk/lkzo71Ugnt4KqSr+v/j
	n/yaNTNntHKz9JTDbER6lLGPSJNhcsvMlgvYWUx34bfOCYc3tf
	+0kg+03ho=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82317>

Hi, 

the new refspec parser in v1.5.5 has also broken fetch uses like

    git fetch <url> +refs/heads/<foo>*:refs/remotes/<bar>*. 

Such a refspec works like a charm with git 1.5.4.  In case the usefulness of
such a refspec isn't obvious, here's my use case.  I want to track several
remotes, and in particular a selection of branches from one remote repository,
which has the following branches[1]: 

  HEAD
  candidate
  candidate+patches
  debian-experimental
  debian-sarge
  debian-sid
  maint
  master
  release
  release+patches

With git 1.5.4, I can add the following to .git/config

[remote "debian"]
        url = http://smarden.org/git/git.git
        fetch = +refs/heads/debian-*:refs/remotes/debian/*

...and it will work just like '%'-style pattern matching in Makefiles, e.g.
the remote branch debian-sid becomes remotes/debian/sid.  I find that very
natural; but git v1.5.5 rejects this refspec as invalid.  

I am just a beginner with git, and I do not know if there is any problem with
such a use of refspecs.  But if not, I would like to beg the maintainers to
consider restoring this functionality.

Nikolaus
