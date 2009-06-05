From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [BUG ext4?] Working tree getting out of date "spontaneously"
Date: Fri, 5 Jun 2009 18:14:44 +0200
Message-ID: <20090605161444.GD764@atjola.homenet>
References: <20090605122444.GA11035@atjola.homenet> <20090605132126.GB11035@atjola.homenet> <alpine.LFD.2.01.0906050825120.6847@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:14:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCc4F-0007aL-MR
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbZFEQOp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 12:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbZFEQOp
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:14:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:34033 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751478AbZFEQOp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:14:45 -0400
Received: (qmail invoked by alias); 05 Jun 2009 16:14:45 -0000
Received: from i59F5600C.versanet.de (EHLO atjola.local) [89.245.96.12]
  by mail.gmx.net (mp071) with SMTP; 05 Jun 2009 18:14:45 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+YBbhemHqYUVN6GuWpDo27idEpW0dc04uBo389/k
	6SA30gytzma9aI
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0906050825120.6847@localhost.localdomain>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120805>

On 2009.06.05 08:39:24 -0700, Linus Torvalds wrote:
>=20
>=20
> On Fri, 5 Jun 2009, Bj=F6rn Steinbrink wrote:
> > >=20
> > > *wait a minute, doing nothing*
> > >=20
> > > doener@atjola:git (master) $ git diff-index --name-only HEAD
> > > Documentation/RelNotes-1.6.3.2.txt
> > > Documentation/git.txt
> > > contrib/completion/git-completion.bash
> > > grep.c
> >=20
> > Hm, looks like this is not a git bug. Went back to 1.5.4, and even =
that
> > shows the error. So I actually looked at the files, and indeed, the=
 file
> > in the working tree gets modified. stat(1) shows:
>=20
> You have beagle running, don't you?

No, nothing like that is running here, I even switched to runlevel 1
just to make sure ;-)

> It's a piece of sh*t, and uses extended attributes to track indexing=20
> information.
>=20
> So the "wait a minute" will just give beagle the chance to index your=
 git=20
> working tree, and update the extended attributes. That is entirely hi=
dden=20
> from all normal filesystem stat information, *EXCEPT* it changes ctim=
e,=20
> since the inode is changed.

No, I'm pretty sure now that it's due to the fact that I use the ext4
kernel driver with an ext3 fs, as running sync(1) is as good as waiting
a minute. And the problem shows up neither with tmpfs nor with a real
ext4.

Bj=F6rn
