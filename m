From: Lars Noschinski <lars-2008-2@usenet.noschinski.de>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Tue, 3 Mar 2009 16:29:25 +0000 (UTC)
Message-ID: <20090303162917.GA8096@lars.home.noschinski.de>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se> <a2633edd0903020512u5682e9am203f0faccd0acf6a@mail.gmail.com> <alpine.DEB.2.00.0903021452010.17877@perkele.intern.softwolves.pp.se> <200903021530.01165.trast@student.ethz.ch> <alpine.DEB.2.00.0903022135360.20047@perkele.intern.softwolves.pp.se> <20090303075655.GB9875@lars.home.noschinski.de> <alpine.DEB.2.00.0903031248040.3702@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 17:31:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeXWO-0006X2-9Z
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501AbZCCQ3i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 11:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754317AbZCCQ3i
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:29:38 -0500
Received: from main.gmane.org ([80.91.229.2]:60763 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754578AbZCCQ3h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 11:29:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LeXUs-0001iU-Hs
	for git@vger.kernel.org; Tue, 03 Mar 2009 16:29:34 +0000
Received: from xdsl-87-78-126-251.netcologne.de ([87.78.126.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 16:29:34 +0000
Received: from lars-2008-2 by xdsl-87-78-126-251.netcologne.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 16:29:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: xdsl-87-78-126-251.netcologne.de
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0903031248040.3702@perkele.intern.softwolves.pp.se>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112112>

* Peter Krefting <peter@softwolves.pp.se> [09-03-03 12:54]:
> Lars Noschinski:
> >Changing the filename (on checkout), so that the user sees an =DC re=
gardless of=20
> >his or her locale (instead of an \0xDC, which only resolves to an =DC=
 on=20
> >latin-1) would be an absolutely broken concept here.
>=20
> Why would it? It is my view as a user on my files that define how fil=
e names=20
> are looked upon. If I have three machines, one Linux box using a iso8=
859-1=20
> locale, an OS X box (where, I would believe, file APIs use UTF-8, som=
eone=20
> please correct me if I'm wrong), and a Windows box (which uses UTF-16=
 on the=20
> file system layer, but does provide compatibility functions that use =
char=20
> pointers), and create a file on each of these called "=DC.txt" (which=
 would be=20
> the sequence "DC 2E 74 78 74" on the Linux box, "C3 9C 2E 74 78 74" (=
or=20
> probably something else since I believe OS X decomposes the string) o=
n the OS X=20
> box and "00DC 002E 0074 0078 0074" on the Windows box, I see these th=
ree file=20
> names as equal.

Because a function in the source code refers to (e.g.) "DC 2E 74 78 74"=
,
not "C3 9C 2E 74 78 74" nor "00DC 0024 0074 0078 0074". And it does so
regardless of the locale.

The file name may look funny depending on your locale, but if you renam=
e
the file to fit your local enconding, it would not work.
