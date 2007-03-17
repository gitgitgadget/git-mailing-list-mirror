From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [BUG] bisecting miscounts revisions left to test
Date: Sat, 17 Mar 2007 14:46:39 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070317134639.GA10968@informatik.uni-freiburg.de>
References: <20070316161421.GA24584@lala> <Pine.LNX.4.63.0703170139110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 17 14:46:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSZF8-0001aY-Rn
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 14:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965527AbXCQNqo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 17 Mar 2007 09:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965548AbXCQNqo
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 09:46:44 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:48864 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965527AbXCQNqn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2007 09:46:43 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HSZF4-0003Ag-K2; Sat, 17 Mar 2007 14:46:42 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l2HDke30012360;
	Sat, 17 Mar 2007 14:46:40 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l2HDkdCE012359;
	Sat, 17 Mar 2007 14:46:39 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703170139110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42433>

Hello,

Johannes Schindelin wrote:
> Hi,
>=20
> On Fri, 16 Mar 2007, Uwe Kleine-K=F6nig wrote:
>=20
> > zeisberg@cassiopeia:~/gsrc/linux-2.6$ git bisect good
> > Bisecting: 2 revisions left to test after this
> > [e7b0d26a86943370c04d6833c6edba2a72a6e240] sysfs: reinstate exclusi=
on between method calls and attribute unregistration
> >=20
> > zeisberg@cassiopeia:~/gsrc/linux-2.6$ git bisect good
> > Bisecting: 2 revisions left to test after this
> > [b810cdfcf91d76f603fd48023aede48ced8e6bed] Merge branch 'upstream-l=
inus' of master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6
>=20
> The problem is that after the first git-bisect good, it looks like th=
is:
>=20
> g1 - b2 - b1 - M - B
>              /
>      g2 - b3
I wonder if bisect really knows that B is bad.  git bisect visualize
doesn't mark B (i.e. bac6eefe96204d0ad67d144f2511a6fc487aa594) bad.
Maybe the problem is, that this is a tag and not a commit?

After 2 more "bisect good"s I once more get B to test.  If I mark that
as good, I get "... was both good and bad"?

The commandline is:

	git-rev-list --bisect '^069f8256362b7a17da532f0631cee73b4cfee65b' '^08=
e15e81a40e3241ce93b4a43886f3abda184aa6' '^0bdd0f385a44344f83409b9e00797=
bfe2596faf8' '^2cb8a57b9851805883dfe92cf5d88a726134a384' '^6ab27c6bf38d=
5ff71dafeca77b79e7c284804b75' '^a7c999114ecd0c69bd3970272b64d8842b765b2=
1' '^b810cdfcf91d76f603fd48023aede48ced8e6bed' '^bdf3aaf9519ddd8a026b5e=
04e713d2fa673532e5' '^e7b0d26a86943370c04d6833c6edba2a72a6e240' bac6eef=
e96204d0ad67d144f2511a6fc487aa594 --

Maybe better "git-rev-list --bisect $good $bad^ --" should be used to
find the bisection point?

> P.S.: if Momo's turtle thinks that your name contains no non-ASCIIs, =
why=20
> should I?
You should differentiate between my user name and my real name.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

$ dc << EOF
[d1-d1<a]sa99d1<a1[rdn555760928P*pz1<a]salax
EOF
