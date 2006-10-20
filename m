From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Signed git-tag doesn't find default key
Date: Fri, 20 Oct 2006 20:21:58 +0100
Message-ID: <200610202021.58157.andyparkins@gmail.com>
References: <200610201004.17263.andyparkins@gmail.com> <Pine.LNX.4.64.0610200922170.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5961158.4fZmC1e8Yr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 21:24:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gazyz-0002gb-86
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 21:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992725AbWJTTYd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 15:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992709AbWJTTYd
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 15:24:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:16869 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S2992726AbWJTTYa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 15:24:30 -0400
Received: by ug-out-1314.google.com with SMTP id z34so714388ugc
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 12:24:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=S6GSfbTCF+StEaXzzXez0Nu6y67RQOJFOiRuEBk5dX4Q16q1xyTj6Q1BWg9z4B80G58iwMg9x3pqy9En7zGNYsBo4v7aLj1gpW/RB0Is3O5ar3TxxAl55BniEhGth/Hy97wr3l0IWD6kdqjaij/tdBJ87XK+V/oO+UdLbD5wAqc=
Received: by 10.67.27.3 with SMTP id e3mr2500318ugj;
        Fri, 20 Oct 2006 12:24:25 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 53sm1776732ugn.2006.10.20.12.24.23;
        Fri, 20 Oct 2006 12:24:24 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0610200922170.3962@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29527>

--nextPart5961158.4fZmC1e8Yr
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 2006, October 20 17:32, Linus Torvalds wrote:

> and then do an "adduid", and then add your UID _without_ the "(Google)" in
> there, and that should solve all your problems.

Yeah, obviously that's one way; and while it doesn't really matter to me, i=
t=20
seems poor form that git doesn't work with gpg as it is.  While one could o=
f=20
course use the "-u" switch, if that is the answer, then why bother with=20
having the "-s" switch at all?

> You're probably better off with something like
>
> 	git var GIT_COMMITTER_IDENT | sed 's/\(.*\)<\(.*\)>\(.*\)/\2/'

I've actually settled on:

: ${username:=3D$(expr "z$tagger" : 'z.*<\(.*\)>')}

In git-tag.sh.

> That said, I've never understood why gpg matches on the comment field.
> Dammit, it _should_ find the key anyway. Stupid program.

I think it's doing the right thing unfortunately.  If you search on any part
 "Andy Parkins"
 "<andyparkins@gmail.com>"
 "andyparkins@gmail.com"
 "andyparkins"
It finds it fine; the only thing it doesn't find is
 "Andy Parkins <andyparkins@gmail.com>"
Which I suppose is fair enough, as it's a fairly specific format to be=20
searching for.

I'm going to advocate my change of only searching on the email address for=
=20
finding the key - there shouldn't be two keys with the same email address=20
anyway, so there shouldn't be a danger of ambiguity of key.  Also, it deals=
=20
with the case when someone has entered a different name in git and in their=
=20
gpg UID.  For example, I would think it shouldn't be a problem that I like =
to=20
be called "Andy" on the git list, and yet want my key to say "A. D.=20
Parkins", "Andrew Parkins" or "Sparky McFly".=20

Now, I think I've written my name far, far too many times in this email.


Sparky McFly
=2D-=20
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com

--nextPart5961158.4fZmC1e8Yr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFOSHWwQJ9gE9xL20RAhHdAJwJhYgagL6NNunMSgB+aPFiWy+3ZACgn1Ra
8s7JnTn4Jpht0CdE4rDFTlg=
=y7W2
-----END PGP SIGNATURE-----

--nextPart5961158.4fZmC1e8Yr--
