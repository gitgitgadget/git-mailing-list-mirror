From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Cogito chicken-and-egg problem
Date: Tue, 26 Apr 2005 12:38:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504261229220.30848-100000@iabervon.org>
References: <1114531570.19478.6.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:46:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQTBU-0006Z1-M4
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 18:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVDZQon (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 12:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVDZQls
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 12:41:48 -0400
Received: from iabervon.org ([66.92.72.58]:44294 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261678AbVDZQip (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 12:38:45 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DQT54-0005NA-00; Tue, 26 Apr 2005 12:38:38 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1114531570.19478.6.camel@dv>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Apr 2005, Pavel Roskin wrote:

> Hello!
> 
> My patch for Makefile was misapplied, so installed commit-id is still
> needed for "make" to succeed.
> 
> Shell commands are processed by make before being passed to the shell,
> and $(...) is expanded by make before new PATH is set, as it is done in
> the current Makefile.
> 
> Also, the dependency on commit-id was dropped from my patch for some
> reason.  I believe it's still needed.  Also, we need a dependency on
> cat-file, which is used by commit-id internally.

commit-id doesn't really use cat-file; the way it calls gitXnormid.sh
definitely suppresses that section. In fact, commit-id with no arguments
is simply an easy-to-remember way of doing "cat .git/HEAD" using a much
more complicated script. Earlier, I sent a patch to just do this, since it
avoids the whole issue.

(Also, .git/HEAD is a dependancy, since you want to redo the version
script if you commit; but if you don't have it, that's okay and just means
you're building from a tarball, which is described completely by VERSION)

	-Daniel
*This .sig left intentionally blank*

