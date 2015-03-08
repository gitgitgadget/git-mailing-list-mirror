From: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: Git very slow ?
Date: Sun, 8 Mar 2015 19:20:46 +0000
Message-ID: <20150308192045.GB32504@milliways>
References: <20150307013007.GA13250@milliways>
 <20150308155136.GA6273@vps892.directvps.nl>
 <87zj7nmpdp.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin D <me@ikke.info>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Mar 08 20:29:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUgsx-0006Ns-U7
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 20:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbbCHT3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 15:29:07 -0400
Received: from know-smtprelay-omd-7.server.virginmedia.net ([81.104.62.39]:56636
	"EHLO know-smtprelay-omd-7.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbbCHT3F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 15:29:05 -0400
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Mar 2015 15:29:04 EDT
Received: from localhost.localdomain ([81.106.150.188])
	by know-smtprelay-7-imp with bizsmtp
	id 17Lm1q00n4481jl017LmGw; Sun, 08 Mar 2015 19:20:46 +0000
X-Originating-IP: [81.106.150.188]
X-Spam: 1
X-Authority: v=2.1 cv=cpwVkjIi c=1 sm=1 tr=0 p=eFcqwsrwAAAA:8
 a=DGj713NdaxKrsjjgQne7PA==:117 a=DGj713NdaxKrsjjgQne7PA==:17
 a=J0QyKEt1u0cA:10 a=IkcTkHD0fZMA:10 a=NLZqzBF-AAAA:8 a=emO1SXQWCLwA:10
 a=VTq9Hxa_IRFOunbCOlkA:9 a=QEXdDO2ut3YA:10
Received: by localhost.localdomain (Postfix, from userid 500)
	id 131558887A; Sun,  8 Mar 2015 19:20:46 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <87zj7nmpdp.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265104>

On Sun, Mar 08, 2015 at 05:21:22PM +0100, David Kastrup wrote:
> Kevin D <me@ikke.info> writes:
>=20
> > On Sat, Mar 07, 2015 at 01:30:07AM +0000, Ken Moffat wrote:
> >> Hi, please CC me if that is not your usual fashion, because I am n=
ot
> >> subscribed.
> >>=20
> >> I use git for my build scripts - those are accessed over nfs.  Sin=
ce
> >> I started using 2.1 and later (I don't think I used 2.0) commands
> >> such as 'commit' take a long time before anything happens.  I
> >> assumed that the newer version meant this would take longer.
> >>=20
> >> But today^Wyesterday I was bisecting the kernel on a local
> >> filesystem - even when the number of revisions left to test was in
> >> the single digits, git bisect took a long time to decide which
> >> revision should be the next one to test.  The filesystems are ext4=
=2E
> >> Is this sort of delay normal now?
> >>=20
> >> What really prompted me to ask is that I ran git blame on a script=
,
> >> to see when I made a particular change so that I could add that
> >> information to a ticket, and almost gave up waiting because it fel=
t
> >> as if it was taking for ever.
> >>=20
> >
> > What kind of repository are we talking about? How many files, how b=
ig?
> > Git should not have become significantly slower recently.
>=20
> Particularly not git-blame in 2.1.  I should be quite surprised to se=
e
> any git-blame call running noticeably slower in 2.1 than in any
> preceding version.
>=20
> What may have happened is that the repository recently got repacked
> aggressively and thus any access to older revisions got slower.
> However, that change would be mostly tied to the repository rather th=
an
> the version of Git you access it with.
>=20
That is possible - well, not recently-recently, but I might have
repacked my repo of buildscripts some time last year.  Running
 ls -al .git
in that repository gives me:
drwxr-xr-x   8 ken 100   4096 Mar  8 16:08 .
drwxr-xr-x  48 ken 100   4096 Mar  8 03:05 ..
-rw-r--r--   1 ken 100    220 May 12  2014 BRANCH_DESCRIPTION
drwxr-xr-x   2 ken 100   4096 Apr 13  2010 branches
-rw-r--r--   1 ken 100    470 Mar  8 16:08 COMMIT_EDITMSG
-rw-r--r--   1 ken 100    566 May 17  2014 config
-rw-r--r--   1 ken 100     73 May  1  2010 description
-rw-r--r--   1 ken 100 196439 Sep 17 21:56 gitk.cache
-rw-rw-rw-   1 ken 100     29 Feb  8 22:19 HEAD
drwxr-xr-x   2 ken 100   4096 May  1  2010 hooks
-rw-r--r--   1 ken 100 218255 Mar  8 16:07 index
drwxr-xr-x   2 ken 100   4096 Sep 16  2013 info
drwxr-xr-x   3 ken 100   4096 Sep 16  2013 logs
drwxr-xr-x 260 ken 100   4096 Nov 12  2013 objects
-rw-r--r--   1 ken 100     41 Nov 11 06:05 ORIG_HEAD
-rw-r--r--   1 ken 100   1879 Sep 16  2013 packed-refs
drwxr-xr-x   5 ken 100   4096 May 20  2014 refs
-rw-r--r--   1 ken 100     41 Dec  7  2010 RENAMED-REF

Running git blame on a script which dates back to when the repo was
created takes between 5 and 6 seconds to show the first screen,
running it on a file first created last August took about 3 seconds.
I have another small repo also on nfs with only a few files, started
last year, and there git blame takes about a second.

In my clone of linus' tree, running git blame scripts/headers.sh (a
random example,I do not normally run git blame there) took 10
seconds to return the first screen.

All of those timings are from preparing the comand, watching my
desktop clock until it changes the second, and hitting enter - so,
only accurate to approx one second.

=C4=B8en
--=20
Nanny Ogg usually went to bed early. After all, she was an old lady.
Sometimes she went to bed as early as 6 a.m.
