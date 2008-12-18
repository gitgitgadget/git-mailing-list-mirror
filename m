From: jidanni@jidanni.org
Subject: negated list in .gitignore no fun
Date: Fri, 19 Dec 2008 05:53:23 +0800
Message-ID: <87hc51tajw.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: joey@kitenet.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 23:21:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDRFf-0000HG-3I
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 23:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbYLRWUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 17:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbYLRWUd
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 17:20:33 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:59763 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753041AbYLRWUc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2008 17:20:32 -0500
Received: from jidanni1.jidanni.org (122-127-37-70.dynamic.hinet.net [122.127.37.70])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id 1403C414BB;
	Thu, 18 Dec 2008 14:20:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103502>

I discovered git is so negative: it has very good .gitignore negative
matching facilities, but not as good positive matching facilities.
(Maybe positive glob lists are merely fed to git-add from the command line.)

I had dreams of tracking only a few files in a large tree.
I thought I would maintain that list as a negated list in .gitignore,
and then always use "git-add ." to keep git's index reflecting my list.

However that's just not possible.

# head -n 5 .gitignore
*
!X11/xorg.conf
!anacrontab
!apt/apt.conf.d/10jidanni
!apt/sources.list
# git-add .
But git-status only shows anacrontab got added. None of the files in
the subdirectories get added. We continue,
# sed -n s/^!//p .gitignore|xargs git-add #no help!
# sed -n s/^!//p .gitignore|xargs -n 1 git-add #Geez. Finally worked.
OK, I suppose my next step is just to rm .gitignore and just add any
future files I want to add to my list one by one with git-add... like
git was designed to do in the first place. OK, thanks. Bye.
Next episode: some kind of middle ground with etckeeper.
