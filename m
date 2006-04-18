From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: GIT_OBJECT_DIRECTORY
Date: Tue, 18 Apr 2006 20:26:50 +0200
Message-ID: <20060418182650.GB25688@wohnheim.fh-wedel.de>
References: <20060418133847.GC4720@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0604180822470.3701@g5.osdl.org> <20060418175853.GA25688@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0604181104420.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 20:27:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVuuv-0003Dp-5L
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 20:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWDRS1K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 18 Apr 2006 14:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWDRS1K
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 14:27:10 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:20665 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750947AbWDRS1J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 14:27:09 -0400
Received: from joern by wohnheim.fh-wedel.de with local (Exim 3.36 #1 (Debian))
	id 1FVuuY-0001fE-00; Tue, 18 Apr 2006 20:26:50 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604181104420.3701@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18867>

On Tue, 18 April 2006 11:08:40 -0700, Linus Torvalds wrote:
> On Tue, 18 Apr 2006, J=F6rn Engel wrote:
> > >=20
> > > 	git clone git://git.kernel.org/... foo/
> >=20
> > Is it possible for non-owners of a kernel.org account to do this?
>=20
> Yes, kernel.org runs the git daemon.

Excellent!  I have a faint memory of hpa recently saying that the git
daemon would be too resource-hungry.  One of the cases where being
wrong is a Good Thing.

> >=20
> > Well, .git/objects for your kernel still consumes 121M.  It's not
> > gigabytes but I still wouldn't want too many copies of that lying
> > around.
>=20
> Right. However, these days we have better approaches than=20
> GIT_OBJECT_DIRECTORY for that.
>=20
> In particular, if you create local clones, use "git clone -l -s", whi=
ch=20
> shares its base objects with the thing you clone from. It makes the c=
lone=20
> incredibly fast too (the only real cost is the check-out, which can=20
> obviously be pretty expensive), and you can then use
>=20
> 	git repack -a -d -l
>=20
> on all the to repack just the _local_ objects to avoid having packs=20
> duplicate objects unnecessarily.

This still isn't good enough for me.  Before git, all my trees were
hard-linked (cowlinked, actually) and another copy barely consumed any
space.  "git clone -l -s"  creates a copy of the currently 311M of
kernel source, quite a bit more expensive.

But it appears as if I could "cp -lr" the git tree and work with that.
The nice thing of having cowlinks is that I don't have to rely on git
breaking the hard links - which it probably won't.  But since the
estimated user base of cowlinks is 1, that won't help too many people.

J=F6rn

--=20
Good warriors cause others to come to them and do not go to others.
-- Sun Tzu
