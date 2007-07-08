From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git cvsimport branches not consistent with CVS branches
Date: Sun, 8 Jul 2007 12:53:04 +0200
Message-ID: <200707081253.06129.robin.rosenberg.lists@dewire.com>
References: <46903396.1010507@heydon.com.au> <20070708054520.GD4087@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gordon Heydon <gordon@heydon.com.au>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Sun Jul 08 12:52:13 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7UNA-0006Aq-ON
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 12:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbXGHKwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 8 Jul 2007 06:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbXGHKwI
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 06:52:08 -0400
Received: from [83.140.172.130] ([83.140.172.130]:26114 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbXGHKwH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 06:52:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 091428026DB;
	Sun,  8 Jul 2007 12:45:05 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18713-03; Sun,  8 Jul 2007 12:45:04 +0200 (CEST)
Received: from [10.9.0.8] (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id 7ED5D802663;
	Sun,  8 Jul 2007 12:45:04 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070708054520.GD4087@lavos.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51873>

s=F6ndag 08 juli 2007 skrev Brian Downing:
> On Sun, Jul 08, 2007 at 10:45:10AM +1000, Gordon Heydon wrote:
> > After some investigation I found that git cvsimport was not importi=
ng=20
> > branches 100% correctly with CVS.
> >=20
> > Git and CVS do branching very differently in that CVS this is done =
at=20
> > the file level (like everything else) and git does it repository wi=
de.
> >=20
> > So if I have a CVS repository with the files a, b and c and I branc=
h b=20
> > with a `cvs tab -b BRANCH test` on the branch test I will just have=
 the=20
> > file b.
> >=20
> > If I do a git cvsimport on the test branch there will actually be t=
he=20
> > files a, b and c
> >=20
> > What I think needs to happen is that when git cvsimport created the=
=20
> > branch in the git repository it needs to delete all files from the=20
> > branch that were not branched.
>=20
> I've been vaguely working on Yet Another CVS Importer (an incremental
> one; both git-cvsimport (thanks to cvsps) and tailor take about ten
> minutes and a gigabyte of RAM to figure out that nothing has to happe=
n
> with my repository.  I think I can do better than that).

Corecode's fromcvs is pretty fast and incremental and AFAIK accurate. I=
 had=20
plenty problems with cvsimport, but fromcvs keeps in sync with the CVS =
repo.
Get  it at http://ww2.fs.ei.tum.de/~corecode/hg/fromcvs/ .

It does not convert regular tags, only branches, however so there is so=
mething to=20
do for those that want a complete cvs import.

> In thinking about this case, I think I've decided that you want an
> option on what to do here.  For some repositories you're not going to
> care about having extra files with the tag, and would greatly prefer
> that to having to create a branch for each and every tag (assuming yo=
u
> can arrange to have the correct files present otherwise; this isn't
> always possible.)
>=20
> For other cases, you really only want to get the subset of the files
> that are tagged.  For this, I think the best arrangement would be to
> make your branch, then make a commit that only deletes the files that
> are not present in the CVS branch, as you said.  Then immediately mak=
e

fromcvs drops the files that do not have the branch tag. It is pretty s=
imple to change
the behaviour ( http://rosenberg.homelinux.net/gitweb/gitweb.cgi?p=3DFR=
OMCVS.git;a=3Dcommitdiff;h=3Deb1c159bcc0d79eab182da3d7040ac62b52fd297 )
although this should be a switch and not hard coded.

-- robin
