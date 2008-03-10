From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on maxsize reached
Date: Mon, 10 Mar 2008 10:47:46 +0100
Organization: NextSoft
Message-ID: <200803101047.47044.michal.rokos@nextsoft.cz>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <200803100959.43611.michal.rokos@nextsoft.cz> <47D4FF55.8020909@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 10:48:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYecV-0005F3-Sm
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 10:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbYCJJr5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2008 05:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbYCJJr5
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 05:47:57 -0400
Received: from holub.nextsoft.cz ([195.122.198.235]:59578 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbYCJJr4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2008 05:47:56 -0400
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id 722CC87C; Mon, 10 Mar 2008 10:47:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id 5494A882;
	Mon, 10 Mar 2008 10:47:52 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08978-01; Mon, 10 Mar 2008 10:47:52 +0100 (CET)
Received: from 89-24-249-174.i4g.tmcz.cz (89-24-249-174.i4g.tmcz.cz [89.24.249.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTP id 02BC055D;
	Mon, 10 Mar 2008 10:47:52 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <47D4FF55.8020909@viscovery.net>
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76711>

On Monday 10 March 2008 10:28:53 Johannes Sixt wrote:
> Michal Rokos schrieb:
> > Hello,
> >
> > I've managed to run testcase on
> > Tru64 OSF1 <hostname> V5.1 2650 alpha
> > and it returns
> > case1: 0
> > case2: 4
> > case3: 5
> > case4: 5
> > which is sad since our vsnprintf() cannot detect this ill behaviour=
=2E
>
> Ugh! We'd need to run the loop until we get a return value that is no=
t
> negative and less than the size specified...

Hmm, I'm afraid we have to grow our buffer size until 2 successive runs=
 return=20
the same value and that value is not -1.

But - do we want to fix it now, when we don't even know that else would=
 be=20
needed for Tru64 port? There's even no Tru64 paragraph in Makefile yet.

Michal

PS: I have no ambition to port git to Tru64 since that test machine is=20
accessible via friend of my friend - so I have to IM him the code and h=
e=20
returns value :)

--=20
Michal Rokos

NextSoft s.r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
phone:  +420 267 224 311
fax:    +420 267 224 307
mobile: +420 736 646 591
e-mail: michal.rokos@nextsoft.cz
