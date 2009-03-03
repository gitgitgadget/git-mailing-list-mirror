From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Tue, 3 Mar 2009 21:59:25 +0100
Message-ID: <200903032159.25461.robin.rosenberg.lists@dewire.com>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se> <alpine.DEB.2.00.0903031248040.3702@perkele.intern.softwolves.pp.se> <20090303162917.GA8096@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Krefting <peter@softwolves.pp.se>,
	Thomas Rast <trast@student.ethz.ch>
To: Lars Noschinski <lars-2008-2@usenet.noschinski.de>
X-From: git-owner@vger.kernel.org Tue Mar 03 22:01:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lebjl-0000yO-Jy
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 22:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbZCCU7g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 15:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbZCCU7g
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 15:59:36 -0500
Received: from mail.dewire.com ([83.140.172.130]:17399 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185AbZCCU7f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 15:59:35 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 92F421295E87;
	Tue,  3 Mar 2009 21:59:30 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XdZhASm0Kj3G; Tue,  3 Mar 2009 21:59:29 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id D8C751295E60;
	Tue,  3 Mar 2009 21:59:26 +0100 (CET)
User-Agent: KMail/1.11.0 (Linux/2.6.27-12-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <20090303162917.GA8096@lars.home.noschinski.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112166>

Lars Noschinski <lars-2008-2@usenet.noschinski.de> writes:
> * Peter Krefting <peter@softwolves.pp.se> [09-03-03 12:54]:
> > Lars Noschinski:
> > >Changing the filename (on checkout), so that the user sees an =DC =
regardless of=20
> > >his or her locale (instead of an \0xDC, which only resolves to an =
=DC on=20
> > >latin-1) would be an absolutely broken concept here.
> >=20
> > Why would it? It is my view as a user on my files that define how f=
ile names=20
> > are looked upon. If I have three machines, one Linux box using a is=
o8859-1=20
> > locale, an OS X box (where, I would believe, file APIs use UTF-8, s=
omeone=20
> > please correct me if I'm wrong), and a Windows box (which uses UTF-=
16 on the=20
> > file system layer, but does provide compatibility functions that us=
e char=20
> > pointers), and create a file on each of these called "=DC.txt" (whi=
ch would be=20
> > the sequence "DC 2E 74 78 74" on the Linux box, "C3 9C 2E 74 78 74"=
 (or=20
> > probably something else since I believe OS X decomposes the string)=
 on the OS X=20
> > box and "00DC 002E 0074 0078 0074" on the Windows box, I see these =
three file=20
> > names as equal.
>=20
> Because a function in the source code refers to (e.g.) "DC 2E 74 78 7=
4",
> not "C3 9C 2E 74 78 74" nor "00DC 0024 0074 0078 0074". And it does s=
o
> regardless of the locale.

The only actual language I know where I've seen people use non-ascii na=
mes for
referenced files, i.e. classes, is Java and there you specify the encod=
ing to
the compiler. Class names are not byte sequences there. XML files are a=
nother
case where references files are defined in unicode. I assume this appli=
es to
C# and other modern languages too.

> The file name may look funny depending on your locale, but if you ren=
ame
> the file to fit your local enconding, it would not work.

In the Java case, you /have/ to "rename" or the build will break. Build=
 systems like Ant
or Maven require you to "rename" too regardless of what you build. A C =
Git clone
will produce unbuildable code, but JGit will produce a working one for =
unicode
aware systems and documentation, the case where unicode filenames are m=
ore common
than in source, will look good.

-- robin

PS. I readded the people you forgot to Cc
