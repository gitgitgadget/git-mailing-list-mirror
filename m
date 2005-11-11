From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] cg-pull to stop treating "master" specially, fix
	fetch_local for .git/HEAD
Date: Fri, 11 Nov 2005 10:26:31 -0500
Message-ID: <1131722791.1284.20.camel@dv>
References: <1124832796.23795.9.camel@dv>
	 <200511110213.54846.Josef.Weidendorfer@gmx.de>
	 <1131684784.31172.16.camel@dv>
	 <200511111522.37979.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 16:29:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaaoB-0001x8-3i
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 16:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVKKP0t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 10:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVKKP0t
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 10:26:49 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:60646 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750810AbVKKP0g
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 10:26:36 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EaanU-0008Pw-1u
	for git@vger.kernel.org; Fri, 11 Nov 2005 10:26:36 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EaanP-0000Cf-KD; Fri, 11 Nov 2005 10:26:31 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200511111522.37979.Josef.Weidendorfer@gmx.de>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11606>

On Fri, 2005-11-11 at 15:22 +0100, Josef Weidendorfer wrote:
> On Friday 11 November 2005 05:53, Pavel Roskin wrote:
> > I'm not sure if we understand each other, but "recorded" refers to
> > automatically determined branch name.  If cg-clone can determine the
> > branch name, that name should be saved and used for updates.
> > 
> > Whether the branch name is saved in .git/branches/ using hash notation
> > (old style) or in .git/remotes/ (new style) is irrelevant.
> 
> Yes.
> But for the conrete implementation it is relevant.
> 
> AFAIK, there is not really a "new" and "old" style, but more the
> git way (attributes for remote repositories in .git/remotes) and the
> Cogito way (attributes for a remote branch).

Switching to the "git way" is long overdue, since hashes can be used in
the actual path.

> "Recording" talks about storing the name of the remote branch that
> maps to the local "origin" branch, so I would vote for storing this
> in .git/branches/origin.

Yes, cg-clone should do its best to determine the branch name and to
save it for future use by cg-fetch.

> For cg-clone, this is no problem because cg-clone writes this file itself.
> Another thing is if you add later on a remote branch with cg-branch-add
> without specifying a concrete remote branch name. Do we want the
> record the branch name at the first cg-fetch for the future?

Good that you noticed that.

cg-fetch could do that, but maybe cg-branch-add would be an even better
place for that?  I mean, cg-branch-add could actually check the
repository and prompt the user which branch to use if there is no
obvious default.  I think, there should be a way to run cg-branch-add
without having it connect the repository or prompt the user, but the
default should be user-friendly.

-- 
Regards,
Pavel Roskin
