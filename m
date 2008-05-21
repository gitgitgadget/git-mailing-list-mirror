From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Using git to perform merges between SVN branches
Date: Wed, 21 May 2008 20:01:40 +0200
Message-ID: <20080521180140.GA21231@atjola.homenet>
References: <a5c338c9-7820-41bd-a3a3-36ba5aad4379@l64g2000hse.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: davetron5000 <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 20:04:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyse7-0004t9-IT
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 20:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934727AbYEUSBq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 May 2008 14:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935836AbYEUSBp
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 14:01:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:59297 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753904AbYEUSBo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 14:01:44 -0400
Received: (qmail invoked by alias); 21 May 2008 18:01:42 -0000
Received: from i577B9A75.versanet.de (EHLO atjola.local) [87.123.154.117]
  by mail.gmx.net (mp001) with SMTP; 21 May 2008 20:01:42 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+SDVBEne2Sxc0taFBp42IhF3xY8FcaDrMXxMKX4I
	GFQ4eCGBM7b1Xc
Content-Disposition: inline
In-Reply-To: <a5c338c9-7820-41bd-a3a3-36ba5aad4379@l64g2000hse.googlegroups.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82559>

On 2008.05.21 08:50:33 -0700, davetron5000 wrote:
> Working out of an SVN/subversion repository.  Initially cloned it so =
I
> could work with git via git-svn.  I was given a branch in svn to work
> on.  Created local branches connected to the main trunk and my branch
> via:
>=20
> git-checkout -b local-trunk trunk
> git branch local-foo FOO
>=20
> where svn_root/branches/FOO is where I'm to commit changes
>=20
> commits work fine, etc.
>=20
> What I'd like to do, for simplicity, and as a demonstration of git's
> superior merging, is to do the merge of my code to the main trunk
> using git.  My main concern is not getting into a situation where I
> cannot commit to svn (since it doesn't track merges)
>=20
> Would something like this work:
>=20
> git checkout local-trunk
> git-svn rebase
> git checkout -b merge-foo local-trunk
> git merge local-foo
> # Resolve conflicts, etc.  local-foo now has what should go onto SVN'=
s
> trunk
> git checkout local-trunk
> git merge merge-foo
> # this should work without any conflicts, since I resolved them on
> merge-foo
> git-svn dcommit
> # Now I've merged my changes to the main trunk

You can skip the whole merge-foo thing and just merge local-foo into
local-trunk, the second merge would end-up as a fast-forward anyway.

That said, the above should work, given that a) you don't do any
rebasing after merging and b) the merge commit is the first commit that
gets dcommitted to svn.

I don't remember what happens when there are new revisions in svn since
you last ran "git svn rebase", so you might want to try that case on a
throw-away svn repo first.

What SVN will see is basically what git would see had you done a "merge
--squash", but git will retain the merge information (big plus!).

Bj=F6rn
