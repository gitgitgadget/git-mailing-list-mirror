From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Tue, 03 Mar 2009 12:54:31 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0903031248040.3702@perkele.intern.softwolves.pp.se>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
 <a2633edd0903020512u5682e9am203f0faccd0acf6a@mail.gmail.com>
 <alpine.DEB.2.00.0903021452010.17877@perkele.intern.softwolves.pp.se>
 <200903021530.01165.trast@student.ethz.ch>
 <alpine.DEB.2.00.0903022135360.20047@perkele.intern.softwolves.pp.se>
 <20090303075655.GB9875@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Lars Noschinski <lars-2008-2@usenet.noschinski.de>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:56:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeTEa-0001RM-CA
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 12:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbZCCLyu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 06:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753582AbZCCLyu
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 06:54:50 -0500
Received: from smtp.getmail.no ([84.208.20.33]:58279 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbZCCLyt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 06:54:49 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KFX00B68IFBU000@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 03 Mar 2009 12:54:47 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFX001WRIEVRF30@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 03 Mar 2009 12:54:31 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFX00K2TIEVAIB0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 03 Mar 2009 12:54:31 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id 27FCE189B20; Tue,
 03 Mar 2009 12:54:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 2462A1A97FE; Tue, 03 Mar 2009 12:54:31 +0100 (CET)
In-reply-to: <20090303075655.GB9875@lars.home.noschinski.de>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112061>

Lars Noschinski:

> Using no encoding for filenames was the obvious (and I would argue)=20
> correct choice. Unix filenames are specified to be a sequence of byte=
s,=20
> excluding '/' and '\0'.

I know the Unix way of thinking lends itself to such a design. This is =
one=20
of the few cases where I personally think Unix has got it wrong, and Wi=
ndows=20
(NT) has got it right. But then again, Unix' design pre-dates the local=
e=20
issue by quite some time, so it is not difficult to see where it comes =
from.

> Changing the filename (on checkout), so that the user sees an =DC reg=
ardless=20
> of his or her locale (instead of an \0xDC, which only resolves to an =
=DC on=20
> latin-1) would be an absolutely broken concept here.

Why would it? It is my view as a user on my files that define how file =
names=20
are looked upon. If I have three machines, one Linux box using a iso885=
9-1=20
locale, an OS X box (where, I would believe, file APIs use UTF-8, someo=
ne=20
please correct me if I'm wrong), and a Windows box (which uses UTF-16 o=
n the=20
file system layer, but does provide compatibility functions that use ch=
ar=20
pointers), and create a file on each of these called "=DC.txt" (which w=
ould be=20
the sequence "DC 2E 74 78 74" on the Linux box, "C3 9C 2E 74 78 74" (or=
=20
probably something else since I believe OS X decomposes the string) on =
the=20
OS X box and "00DC 002E 0074 0078 0074" on the Windows box, I see these=
=20
three file names as equal.

If I would create a Git repo on each of the three machines and put the =
file=20
name in it, and then clone that on one of the other machines. *I* would=
=20
assume that the file names were converted to fit the host operating sys=
tem.

> IMHO having encoding specific open functions is begging for problems.

Indeed. That's why I like Windows' wchar_t APIs, and dislike Unix' and=20
Linux' char APIs that, in some ways, depend on the user locale.

--=20
\\// Peter - http://www.softwolves.pp.se/
