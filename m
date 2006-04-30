From: sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 3/3] fetch: optionally store the current remote
 information in the config
Date: Sun, 30 Apr 2006 13:19:36 -0400
Message-ID: <BAYC1-PASMTP054CF113E95D45B8778DACAEB00@CEZ.ICE>
References: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP08069B2CE6005391A1AFF9AEB00@CEZ.ICE>
	<Pine.LNX.4.63.0604301743370.3641@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP03034CC49FFA3042562BCBAEB00@CEZ.ICE>
	<e32pto$p3a$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 30 19:24:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaFec-00027z-AY
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 19:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWD3RYP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 30 Apr 2006 13:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWD3RYP
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 13:24:15 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:41876 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751186AbWD3RYO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Apr 2006 13:24:14 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Apr 2006 10:24:13 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id E797E644C28;
	Sun, 30 Apr 2006 13:24:12 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
Message-Id: <20060430131936.43598f6f.seanlkml@sympatico.ca>
In-Reply-To: <e32pto$p3a$1@sea.gmane.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 30 Apr 2006 17:24:14.0072 (UTC) FILETIME=[E6CE2F80:01C66C7A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 30 Apr 2006 18:51:54 +0200
Jakub Narebski <jnareb@gmail.com> wrote:
=20
> Well, it could also contain default head we merge to (instead of usin=
g what
> fetch set as FETCH_HEAD, usually current head while fetching), as
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0pull =3D master:origin:merger

Then lets take a simple case; we clone a new repo, and it has:

	[remote.origin]
	  url =3D git://outthere.com
	  fetch =3D master:origin:master
	  fetch =3D next:next

And we create two new branches:

	git branch br1 next ; git branch br2 next

Now say that we want a bare "git pull" to cause a merge from=20
the "next" branch regardless of which new branch we have checked
out.   In the above scheme we have to do something like:

	   fetch =3D next:next:br1:br2

That doesn't look right.  It seems better to have:
=09
	[branch.origin]
		description =3D "Pristine master from Junio"
	[branch.br1]
		description =3D "blah"
		defaultMerge =3D "next"
	[branch.br2]
		description =3D "More blah"
		LastMerge =3D 03/27/2008 3am
		defaultMerge =3D "next"
		qgitTagColor =3D Blue

> The --store option is similar to using 'git checkout -b newbranch' as=
 a
> shortcut for 'git branch newbranch' followed by 'git checkout newbran=
ch'.

Okay.

Sean
