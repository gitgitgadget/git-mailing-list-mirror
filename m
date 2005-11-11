From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] cg-pull to stop treating "master" specially, fix
	fetch_local for .git/HEAD
Date: Thu, 10 Nov 2005 23:53:04 -0500
Message-ID: <1131684784.31172.16.camel@dv>
References: <1124832796.23795.9.camel@dv>
	 <20051110234029.GE30496@pasky.or.cz> <1131668075.3987.5.camel@dv>
	 <200511110213.54846.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 05:54:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaQus-0004kJ-C0
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 05:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVKKExL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 23:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVKKExL
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 23:53:11 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:14786 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932354AbVKKExK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 23:53:10 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EaQuS-000617-Bb
	for git@vger.kernel.org; Thu, 10 Nov 2005 23:53:08 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EaQuO-0003rK-Hx; Thu, 10 Nov 2005 23:53:04 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200511110213.54846.Josef.Weidendorfer@gmx.de>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11555>

On Fri, 2005-11-11 at 02:13 +0100, Josef Weidendorfer wrote:
> > Correct.  But if it's a concern, I think we could make some
> > improvements.  Following approaches could be tried (starting from top,
> > using following steps as a fallback):
> > 
> > 1) Use recorded branch, i.e. the branch name that was used in cg-clone.
> 
> This is the "#..." part in .git/branches/origin, and it is already used.

I'm not sure if we understand each other, but "recorded" refers to
automatically determined branch name.  If cg-clone can determine the
branch name, that name should be saved and used for updates.

Whether the branch name is saved in .git/branches/ using hash notation
(old style) or in .git/remotes/ (new style) is irrelevant.

If cg-clone cannot determine the branch name, we may either support it,
or revert to "master".  I'm ambivalent about that.  Probably reverting
to "master" is better to simplify the code.  On the other hand, I can
imagine public repositories without the "master" branch.

> I have nothing against using HEAD for cloning, but the branch name should
> be recorded, such that cg-pull always fetches from the same branch.

To use HEAD, we'll need to port git from Cygwin, since readlink doesn't
work over http.

> I think 1) is enough if we add the detected branch name in the #... part
> in .git/branches/origin at cg-clone time.

I agree that the branch name should be saved explicitly using already
supported notation (if that's what you mean).

> And "detectable" covers the local case, which was my concern here [*1*]
> 
> Josef
> 
> [*1*] after being told about the "stable HEAD" property of public repositories,
> which is correct. I am not even sure that a HEAD makes sense
> in public repositories: in my opinion HEAD has something to do with checked out
> files, and a public repository usually does not have these. But perhaps
> that's only me...

That's why I mentioned the idea of having a separate file to indicate
the default branch for export.

-- 
Regards,
Pavel Roskin
