From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: git-sh-setup.sh:cd_to_toplevel problematic with symlinks
Date: Tue, 7 Aug 2007 12:11:56 +0200
Message-ID: <20070807101155.GA19233@moooo.ath.cx>
References: <20070806161045.GA21815@moooo.ath.cx> <20070806211238.GA27363@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Aug 07 12:12:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIM2n-0002Zq-Ra
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 12:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620AbXHGKMB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 7 Aug 2007 06:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755794AbXHGKMB
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 06:12:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:60506 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753387AbXHGKMA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 06:12:00 -0400
Received: (qmail invoked by alias); 07 Aug 2007 10:11:57 -0000
Received: from pD9EBB480.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.180.128]
  by mail.gmx.net (mp040) with SMTP; 07 Aug 2007 12:11:57 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+CuKAO8EmCYEU+cWp76S9Og6ylVhxycj/uBM6K1M
	hNRtJ4OFrBfyUA
Content-Disposition: inline
In-Reply-To: <20070806211238.GA27363@informatik.uni-freiburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55239>

Your mail did not make it to the list, therefore I quote the full
mail.

Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de> wrote:
> Matthias Lederhofer wrote:
> > cd_to_toplevel takes the output of git rev-parse --show-cdup and fe=
eds
> > it to cd.  The problem is that cd uses PWD to do what the user mean=
s
> > when saying cd .., i.e. it goes to /foo when in /foo/bar even thoug=
h
> > /foo/bar might be a symlink.  Example:
> >=20
> >     (in an existing git repository)
> >     /tmp/foo$ mkdir -p a/b
> >     /tmp/foo$ ln -s a/b c
> >     /tmp/foo$ cd c
> >     /tmp/foo/c$ git fetch . master:master
> >     git-fetch: line 108: /FETCH_HEAD: Permission denied
> >=20
> > Is there any way to tell cd to ignore $PWD?
> cd -P ... does the trick.  IIRC it's in SUSv3, but once more, Solaris
> /bin/sh doesn't know about that option:
>=20
> 	login@~ > uname -a
> 	SunOS login 5.10 Generic_125100-10 sun4u sparc
>=20
> 	login@~ > /bin/sh
>=20
> 	$ mkdir /tmp/foo; cd /tmp/foo
>=20
> 	$ git init
> 	Initialized empty Git repository in .git/
>=20
> 	$ mkdir -p a/b; ln -s a/b c; cd c
>=20
> 	$ git rev-parse --show-cdup
> 	../../
>=20
> 	$ cd -P ../../
> 	-P: does not exist

Do we care about that shell?  There was another thread about shell
script cleanup where the default sun /bin/sh doesn't support some
other features from the git shell scripts too.
