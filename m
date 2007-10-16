From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: .gitignore and svn:ignore [WAS: git-svn and submodules]
Date: Tue, 16 Oct 2007 09:05:26 -0400
Message-ID: <20071016130526.GA14263@pe.Belkin>
References: <Pine.LNX.4.64.0710141901450.25221@racer.site> <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma> <Pine.LNX.4.64.0710142309010.25221@racer.site> <20071014224959.GA17828@untitled> <Pine.LNX.4.64.0710142359020.25221@racer.site> <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr> <20071015144513.GB7351@diana.vm.bytemark.co.uk> <20071015151405.GA1655@pe.Belkin> <20071016075827.GB32348@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>,
	git list <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 15:05:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihm7A-0001xD-9t
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 15:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbXJPNF3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2007 09:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758204AbXJPNF3
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 09:05:29 -0400
Received: from eastrmmtao104.cox.net ([68.230.240.46]:44150 "EHLO
	eastrmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757645AbXJPNF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 09:05:28 -0400
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20071016130528.QUGY19158.eastrmmtao104.cox.net@eastrmimpo02.cox.net>;
          Tue, 16 Oct 2007 09:05:28 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo02.cox.net with bizsmtp
	id 115S1Y00M0epFYL0000000; Tue, 16 Oct 2007 09:05:26 -0400
Received: from chris by localhost with local (Exim 4.66)
	(envelope-from <c.shoemaker@cox.net>)
	id 1Ihm6w-0003jB-Ji; Tue, 16 Oct 2007 09:05:26 -0400
Content-Disposition: inline
In-Reply-To: <20071016075827.GB32348@soma>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61161>

On Tue, Oct 16, 2007 at 12:58:27AM -0700, Eric Wong wrote:
> Chris Shoemaker <c.shoemaker@cox.net> wrote:
> > On Mon, Oct 15, 2007 at 04:45:13PM +0200, Karl Hasselstr=F6m wrote:
> > > On 2007-10-15 09:07:21 +0200, Benoit SIGOURE wrote:
> > >=20
> > > >   - git svn create-ignore (to create one .gitignore per directo=
ry
> > > > from the svn:ignore properties. This has the disadvantage of
> > > > committing the .gitignore during the next dcommit,
> > >=20
> > > I built ignore support for git-svnignore a long time ago. It conv=
erts
> > > the per-directory svn:ignore to per-directory .gitignore at commi=
t
> > > import time, which is very handy:
> > >=20
> > > -I <ignorefile_name>::
> > >         Import the svn:ignore directory property to files with th=
is
> > >         name in each directory. (The Subversion and GIT ignore
> > >         syntaxes are similar enough that using the Subversion pat=
terns
> > >         directly with "-I .gitignore" will almost always just wor=
k.)
> > >=20
> > > The only downside with that is that svn ignore patterns are
> > > non-recursive, while git ignore patterns are recursive. This coul=
d be
> > > solved by prefixing them with a "/".
> >=20
> > Has anyone put any thought into mapping the other direction?=20
> > i.e. .gitignore  ->  svn:ignore
>=20
> If we support .gitignore <-> svn:ignore in git-svn; bidirectional,
> transparent mapping is the only way I want to go.
>=20
>=20
> This means that *all* .gitignore files will be translated to svn:igno=
re
> files and vice versa; and the .gitignore files will be NOT be committ=
ed
> to SVN itself, but present in the git-svn created mirrors.  Recursive
> .gitignore definitions will be mapped to svn:ignore recursively on th=
e
> client side; and non-recursive ones will only map to one directory.
>=20
> Sound good?
>=20
> I may be sleepy at the moment, but the thought of implementing this i=
s
> sounding complicated now...
>=20

OTOH, a general propset solution would probably be good enough that I
wouldn't even miss any transparent .gitignore -> svn:ignore mapping.

I would just accept that I'd have to explicitly specify the
svn:ignores.

> Since externals/submodules don't operate recursively in either
> system like .gitignore; supporting svn:externals <=3D> submodules
> will be much easier and done first[1] :)
>=20
> [1] - I've personally rarely bothered with putting svn:ignores in the
> repository and have been very much spoiled by .git/info/exclude;
> whereas externals support I have semi-immediate use for.

That's great.   I'm eager to see/test the svn:externals support.  Thank=
s.

-chris
