From: Pavel Roskin <proski@gnu.org>
Subject: Re: 'pu' branch for StGIT
Date: Thu, 09 Aug 2007 12:33:30 -0400
Message-ID: <1186677210.31394.28.camel@dv>
References: <20070807022043.GA8482@diana.vm.bytemark.co.uk>
	 <1186549433.2112.34.camel@dv>
	 <20070808092027.GB7860@diana.vm.bytemark.co.uk>
	 <20070808213917.GA22521@diana.vm.bytemark.co.uk>
	 <1186611514.7383.4.camel@dv>
	 <20070808232349.GA23172@diana.vm.bytemark.co.uk>
	 <20070808201003.nm90u2s5ny888wcc@webmailbeta.spamcop.net>
	 <20070809073801.GA31482@diana.vm.bytemark.co.uk>
	 <1186665883.28228.31.camel@dv>
	 <20070809141848.GA6342@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 18:34:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJAxZ-0001sq-KX
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 18:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939020AbXHIQdh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 9 Aug 2007 12:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761992AbXHIQdg
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 12:33:36 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:50448 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S940599AbXHIQde convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 12:33:34 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1IJB00-0001Op-Or
	for git@vger.kernel.org; Thu, 09 Aug 2007 12:36:36 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1IJAx0-0003CA-MY; Thu, 09 Aug 2007 12:33:30 -0400
In-Reply-To: <20070809141848.GA6342@diana.vm.bytemark.co.uk>
X-Mailer: Evolution 2.10.3 (2.10.3-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55459>

On Thu, 2007-08-09 at 16:18 +0200, Karl Hasselstr=F6m wrote:

> You should be able to do something like
>=20
>   $ stg applied > .git/patches/branch/applied
>   $ stg unapplied > .git/patches/branch/unapplied
>=20
> and then manually change the version from 3 to 2, and be ready to go.
> I haven't tested this, though!

That seems to work.  Thank you!  "branch" should be substituted with th=
e
current branch, of course.

> > I have noticed two problems so far, but I cannot tell is they are
> > specific to the "pu" branch.
> >
> > 1) Undead patches.
>=20
> I saw the same problem today. I haven't had time to look into it, but
> I believe it's due to stgit trying to directly modify files under
> .git/refs instead of using git-update-ref, which breaks with packed
> refs. The DAG patches rely much more on the refs, so the bug is more
> severe in that case.
>=20
> https://gna.org/bugs/?9710

I've attached the test case to that bug.  You are right, git-gc is invo=
lved.

> > 2) Invisible branches.
>=20
> I haven't seen this problem at all -- in my repositories, "stg branch
> -l" just works. Will try to reproduce (hopefully tonight). Do you hav=
e
> a recepie on how to reproduce this from scratch?

It's a problem with git-gc too!  Just clone some repository and run "st=
g
branch -l" in it.  It with show master.  Run git-gc, and "stg branch -l=
"
will show "No branches".

I see that in my Linux repository there are files
in .git/refs/remotes/wireless-dev but not in other directories
under .git/refs/remotes/

--=20
Regards,
Pavel Roskin
