From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: GIT_OBJECT_DIRECTORY
Date: Tue, 18 Apr 2006 20:58:59 +0200
Message-ID: <20060418185859.GA7504@wohnheim.fh-wedel.de>
References: <20060418133847.GC4720@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0604180822470.3701@g5.osdl.org> <20060418175853.GA25688@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0604181104420.3701@g5.osdl.org> <20060418182650.GB25688@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0604181139150.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 20:59:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVvQ4-0000rV-QR
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 20:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWDRS7R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 18 Apr 2006 14:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWDRS7R
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 14:59:17 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:40407 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932086AbWDRS7R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 14:59:17 -0400
Received: from joern by wohnheim.fh-wedel.de with local (Exim 3.36 #1 (Debian))
	id 1FVvPf-0002Bw-00; Tue, 18 Apr 2006 20:58:59 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604181139150.3701@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18872>

On Tue, 18 April 2006 11:47:53 -0700, Linus Torvalds wrote:
> On Tue, 18 Apr 2006, J=F6rn Engel wrote:
> >=20
> > But it appears as if I could "cp -lr" the git tree and work with th=
at.
>=20
> That should work. I just personally fear cowlinks, because some thing=
s=20
> will edit the files in place, and then you're screwed.

s/cowlinks/hardlinks/ ?

The reason for me to write the cowlink patches was exactly the fear
you are talking about.  With those patches, links are broken whenever
such a thing happens.

> I _think_ it should be ok for the .git subdirectory, but quite frankl=
y,=20
> I'm not going to guarantee it. Also, you will break the cow-linking w=
hen=20
> you ever re-pack either the source or the destination, so you'd actua=
lly=20

In that case, cowlinks should still turn a blatant bug into some
wasted space - which is a hell of a lot better.

> 	# cow-link the checked-out state

And this happens to be a problem.  Creating the links when the copy is
created is simple.  Detecting identical files and linking them after
the fact is racy, complicated, racy and, well, racy.  I wouldn't want
to touch it with a ten foot pole.  Not without kernel support.

J=F6rn

--=20
Linux is more the core point of a concept that surrounds "open source"
which, in turn, is based on a false concept. This concept is that
people actually want to look at source code.
-- Rob Enderle
