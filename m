From: Petr Baudis <pasky@suse.cz>
Subject: Re: RFC: grafts generalised
Date: Thu, 3 Jul 2008 02:13:31 +0200
Message-ID: <20080703001331.GF12567@machine.or.cz>
References: <20080702143519.GA8391@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Jul 03 02:14:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KECT4-0000oP-1L
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 02:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbYGCANf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 20:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbYGCANf
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 20:13:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59889 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbYGCANe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 20:13:34 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 6B8451E4C026; Thu,  3 Jul 2008 02:13:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080702143519.GA8391@cuci.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87208>

On Wed, Jul 02, 2008 at 04:35:19PM +0200, Stephen R. van den Berg wrote:
> - Extend the grafts file format to support something like the following syntax:
> 
> commit eb03813cdb999f25628784bb4f07b3f4c8bfe3f6
> Parent: 7bc72e647d54c2f713160b22e2e08c39d86c7c28
> Merge: 3b3da24960a82a479b9ad64affab50226df02abe 13b8f53e8ccec3b08eeb6515e6a10a2a
> Merge: ac719ed37270558f21d89676fce97eab4469b0f1
> Tree: 32fc99814b97322174dbe97ec320cf32314959e2
> Author: Foo Bar (FooBar) <foo@bar>
> AuthorDate: Sat Jun 6 13:50:44 1998 +0000
> Commit: Foo Bar (FooBar) <foo@bar>
> CommitDate: Sat Jun 7 13:50:44 1998 +0000
> Logmessage: First line of logmessage override
> Logmessage: Second line of logmessage override
> Logmessage: Etc.

  Please, don't. It adds completely unnecessary complexity and it is
_not_ grafting anymore - look the word up in a dictionary. :-)

  Have a look at what you wrote above - now, Git already has a way to
store all this information, right? In the commit objects!

  So, the real solution is to take the commit objects you want to
modify, create new commit objects, then graft the new commit on all the
old commit children. It fits neatly in the Git philosophy, there is no
need at all to tweak the current infrastructure for this and it should
be trivial to automate, too.

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
