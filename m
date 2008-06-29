From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 09/21] Remember how a Ref was read in from disk and created
Date: Sun, 29 Jun 2008 14:00:29 -0400
Message-ID: <20080629180029.GG11793@spearce.org>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org> <1214726371-93520-9-git-send-email-spearce@spearce.org> <1214726371-93520-10-git-send-email-spearce@spearce.org> <200806291551.06201.robin.rosenberg@dewire.com> <alpine.DEB.1.00.0806291516540.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 29 20:02:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD1Dp-0005QE-72
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 20:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbYF2SAf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 14:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754619AbYF2SAf
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 14:00:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34451 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621AbYF2SAf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jun 2008 14:00:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KD1CJ-0005vB-JL; Sun, 29 Jun 2008 14:00:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6AEC420FBAE; Sun, 29 Jun 2008 14:00:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806291516540.9925@racer>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86814>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 29 Jun 2008, Robin Rosenberg wrote:
>=20
> > s=C3=B6ndagen den 29 juni 2008 09.59.19 skrev Shawn O. Pearce:
> > > To efficiently deleted or update a ref we need to know where it c=
ame=20
> > > from when it was read into the process.  If the ref is being upda=
ted=20
> > > we can usually just write the loose file, but if it is being dele=
ted=20
> > > we may need to remove not just a loose file but also delete it fr=
om=20
> > > the packed-refs.
> >=20
> > One could argue that we should not normally just delete a ref, but =
mark=20
> > it as deleted and let git gc delete it when it expires, just like a=
ny=20
> > old ref, but then we should try to get C Git to do the same. There =
was a=20
> > thread relating to this recently.
>=20
> ... but it petered out, so you should consider any ideas in that thre=
ad=20
> rejected.

Right.  Its a nice idea, but until there is a really solid agreement in
the community about how this should be stored on disk, I don't want to
try and implement it in jgit, or in C Git for that matter.  And I don't
really care enough to come up with something and reopen the thread myse=
lf.

I just realized that the dumb transport push support doesn't delete
the reflog when it deletes the ref.  Whoops.  That's a problem
if you later try to create a ref where a directory used to be.
Either git will run into errors trying to create the reflog.

--=20
Shawn.
