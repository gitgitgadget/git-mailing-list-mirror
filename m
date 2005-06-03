From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git-tar-tree: add a test case (resent)
Date: Fri, 03 Jun 2005 16:43:34 +0200
Message-ID: <42A06C96.8050107@lsrfire.ath.cx>
References: <20050602185046.GA3717@lsrfire.ath.cx> <Pine.LNX.4.58.0506021830340.1876@ppc970.osdl.org> <429FEBD5.5040306@lsrfire.ath.cx> <Pine.LNX.4.58.0506030728120.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 16:42:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeDMB-0004By-LV
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 16:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVFCOoF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 3 Jun 2005 10:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVFCOoF
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 10:44:05 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:22410 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261298AbVFCOnk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 10:43:40 -0400
Received: from [10.0.1.3] (p508E770B.dip.t-dialin.net [80.142.119.11])
	by neapel230.server4you.de (Postfix) with ESMTP id CEA69101;
	Fri,  3 Jun 2005 16:43:36 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506030728120.1876@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds schrieb:
> 	torvalds@ppc970:~> tar --version
> 	tar (GNU tar) 1.13.25
> 	Copyright =A9 2001 Free Software Foundation, Inc.
> 	This program comes with NO WARRANTY, to the extent permitted by law.
> 	You may redistribute it under the terms of the GNU General Public Li=
cense;
> 	see the file named COPYING for details.
> 	Written by John Gilmore and Jay Fenlason.

[...]

> I get
>=20
> 	?rw------- git/git          52 1969-12-31 16:00:00 pax_global_header=
 unknown file type `g'
> 	drwxr-xr-x git/git           0 2005-05-27 15:00:00 a/
> 	-rw-r--r-- git/git          18 2005-05-27 15:00:00 a/1.......10.....=
=2E..20........30........40......481.......10........20........30......=
=2E.40........50
> 	?rw------- git/git         111 2005-05-27 15:00:00 37e07bc886b166ad2=
525f1cc7a2df9bda0e07a02.paxheader unknown file type `x'
> 	-rw-r--r-- git/git          18 2005-05-27 15:00:00 37e07bc886b166ad2=
525f1cc7a2df9bda0e07a02.data
> 	?rw------- git/git         112 2005-05-27 15:00:00 f72c8a14fa272506e=
5de2d779cfe088769158b61.paxheader unknown file type `x'
> 	-rw-r--r-- git/git          18 2005-05-27 15:00:00 f72c8a14fa272506e=
5de2d779cfe088769158b61.data
> 	?rw------- git/git         113 2005-05-27 15:00:00 b53ac87f1a63ea1a2=
eec65cc8b5bed9130b8c114.paxheader unknown file type `x'
> 	-rw-r--r-- git/git          18 2005-05-27 15:00:00 b53ac87f1a63ea1a2=
eec65cc8b5bed9130b8c114.data
> 	-rw-r--r-- git/git          16 2005-05-27 15:00:00 a/a
> 	drwxr-xr-x git/git           0 2005-05-27 15:00:00 a/bin/
> 	-rwxr-xr-x git/git      719924 2005-05-27 15:00:00 a/bin/sh
> 	tar: Unexpected EOF in archive
> 	tar: Error is not recoverable: exiting now
>=20
> which doesn't tell me anything, except I assume it means that my tar=20
> doesn't understand extended headers.

That's true, but you don't need them if all your pathes' lengths are 10=
0
or shorter.  Of course the test exercising long paths will always fail
with your version of tar.  I should split it out better, so you will at
least get a positive result for short paths.  I just didn't expect such
an old version of tar to be in use anymore. :-P

But your output shows a more serious problem: "Unexpected EOF" means th=
e
archive is missing a piece.  I sent you a patch for that bug in my
previous mail.

Thanks,
Rene
