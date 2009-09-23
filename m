From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: git-cvsimport: missing branches
Date: Wed, 23 Sep 2009 21:51:38 +0200
Message-ID: <20090923195130.GA30264@book.hvoigt.net>
References: <4ABA5C5C.2060207@blinkeye.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>,
	mhagger@tigris.org
To: Reto Glauser <linux@blinkeye.ch>
X-From: git-owner@vger.kernel.org Wed Sep 23 21:51:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqXsS-0000hS-8U
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 21:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbZIWTvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 15:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbZIWTvh
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 15:51:37 -0400
Received: from darksea.de ([83.133.111.250]:57416 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751338AbZIWTvg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 15:51:36 -0400
Received: (qmail 3417 invoked from network); 23 Sep 2009 21:51:38 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 23 Sep 2009 21:51:38 +0200
Content-Disposition: inline
In-Reply-To: <4ABA5C5C.2060207@blinkeye.ch>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128992>

On Wed, Sep 23, 2009 at 07:35:24PM +0200, Reto Glauser wrote:
> - Is the problem in cvsps or git-cvsimport or in the CVS history?

It is very likely a problem of cvsps. I have collected a couple of tests
illustrating the current limitations:

http://repo.or.cz/w/cvsps-hv.git

Interested in fixing some of them ?

> - Can I use the cvs2git import as a starting point and later use  
> git-cvsimport for incrementally update the git repository?

Unfortunately there is no robust incremental tool for cvs at the moment.
As soon as you get your colleagues to use git the pain just dissapears ;)

> - Can I somehow compare the result of git-cvsimport and cvs2git to see  
> differences?

How about a plain diff between the directory structures.

> - Is there any other feasible workflow to stay in sync with a CVS  
> repository with a large history while still using git behind the scene?

During the transition phase I used to track the old system with a
seperate branch. Everytime you get an update from CVS you simply
commit it to that branch. Its important that you do not mix this branch
with your development. You do not do any work on it just commit the
clean revision like you get them from the server.

I then used feature branches for the work which I rebased regularly.
Once you want to merge a branch comes the hard part:

A:
* Update the tracking branch from CVS

* Merge the first/next commit from the branch in git

* Commit to cvs and copy the commit message

* Goto A:

Maybe for cvs you can script this. You can also merge the whole branch at
once if you are lazy but then the diffs will not be nice when you later
completely migrate to git.

cheers Heiko
