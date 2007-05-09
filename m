From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] Second parent for reverts
Date: Thu, 10 May 2007 00:26:52 +0200
Message-ID: <200705100027.06087.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <Pine.LNX.4.64.0705092206540.4167@racer.site>
 <20070509202224.GG3141@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=nextPart1384717.uYBlZnr7vN;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 10 00:27:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlucw-00035l-MU
	for gcvg-git@gmane.org; Thu, 10 May 2007 00:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975AbXEIW1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 18:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756142AbXEIW1N
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 18:27:13 -0400
Received: from smtp.getmail.no ([84.208.20.33]:52493 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755975AbXEIW1M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 18:27:12 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JHS00005P1A9R00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 10 May 2007 00:27:10 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JHS0073DP17VU20@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 10 May 2007 00:27:07 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JHS00GRJP16XG80@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 10 May 2007 00:27:07 +0200 (CEST)
In-reply-to: <20070509202224.GG3141@spearce.org>
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46803>

--nextPart1384717.uYBlZnr7vN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 09 May 2007, Shawn O. Pearce wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Wed, 9 May 2007, Daniel Barkalow wrote:
> > > The discussion about having a header to specify, for a revert
> > > commit, what it reverts made me realize that this header *would*
> > > be useful, but that we don't need a *new* header for it. I think
> > > that the right method is to add the parent of the reverted commit
> > > as a second parent for the revert.
> >
> > I am not so sure. In a sense, you are correct. But everybody who
> > does "git log --no-merges" would no longer see reverts. Which is
> > somewhat incorrect.
>
> Right.
>
> I've actually done what Daniel just talked about doing in one of my
> "production" repositories.  I did it by hand as a developer had
> created a bad merge and accidentially reverted 800 files during
> that merge.  80 or so commits later along a public non-rewinding
> branch coworkers realized things weren't right, and asked me
> to fix the mess.  As I wanted to save the blame data when I
> reverted-the-revert I did what Daniel suggests.
>
> But since the revert-the-revert wasn't really an interesting point
> in history, and neither was the bad merge, I don't really care that
> neither shows up with --no-merges.  The original bad merge was a
> simple honest mistake made by a developer who was new to Git, and
> was only caused because merge-recursive wasn't installed properly
> on that system.
>
>
> As Dscho says, most reverts are interesting points in time.  *Why*
> a particular revert was done is important.
>
> And so I have to disagree quite a bit with Daniel's idea, for exactly
> that reason.  If I'm looking at a block of code in a file I want to
> know why its there.  If blame tells me its a revert of something,
> that tells me we tried another path and it didn't work out.  I might
> be sitting here looking at this line because I'm thinking of redoing
> whatever it was that wasn't good!

Sorry for butting in with pretty much the same arguments as I had in the=20
previous thread on the "Reverts" header field, but...:

Isn't this exactly why we could use the "Reverts" header field?

1. It would enable Daniel (and me) to get the "correct" blame data (for=20
some version of "correct" that at least seems to make sense to us).

2. It would make it trivial for git-log (and other porcelains) to detect=20
reverts and color them bright red in Shawn's and Dscho's logs, so that=20
they can easily see when and why things were reverted.

3. It wouldn't screw up "git log --no-merges" since it doesn't interfere=20
with the "real" parent data.

What am I still missing here?

> Hmm.  I should teach git-gui to parse out the revert message and
> let you click into its parent.  Simple enough.  Maybe it will be
> in 0.7.0.  Maybe it won't be.  ;-)

Isn't it better/cleaner to get this info from a (strict-format) header=20
field, rather than parsing the commit message? (or worse, detecting=20
reverse diffs/patches?)


Have fun!

=2E..Johan

=2D-=20
Johan Herland, <johan@herland.net>
www.herland.net

--nextPart1384717.uYBlZnr7vN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)

iD8DBQBGQkq6BHj4kl4fT1wRAmdrAJ4r0q3l0VULEiqhG2Dm27R+B1gw/wCgi4Zi
30+VqmKXrV+k84XMgbZcrZU=
=/bqm
-----END PGP SIGNATURE-----

--nextPart1384717.uYBlZnr7vN--
