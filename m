From: Jason Baker <jbaker@zeomega.com>
Subject: git-svn checksum mismatch
Date: Thu, 18 Feb 2010 08:55:30 -0600
Message-ID: <fa34f1941002180655n79430e79yc8658ce17e4e1093@mail.gmail.com>
References: <fa34f1941002170821p66cf0ac7i9385b341c94993c3@mail.gmail.com>
	 <20100218005347.GA8528@dcvr.yhbt.net>
	 <fa34f1941002180652wb91c36bt8feba5c7f653701d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 15:55:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni7n6-0003yg-PI
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 15:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758023Ab0BROze convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 09:55:34 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:55296 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662Ab0BROzd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 09:55:33 -0500
Received: by fxm20 with SMTP id 20so9105210fxm.21
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 06:55:30 -0800 (PST)
Received: by 10.216.171.145 with SMTP id r17mr4116971wel.182.1266504930059; 
	Thu, 18 Feb 2010 06:55:30 -0800 (PST)
In-Reply-To: <fa34f1941002180652wb91c36bt8feba5c7f653701d@mail.gmail.com>
X-Google-Sender-Auth: 936809b0d9c709f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140343>

On Wed, Feb 17, 2010 at 6:53 PM, Eric Wong <normalperson@yhbt.net> wrot=
e:
>
> Jason Baker <jbaker@zeomega.com> wrote:
> > Hey Eric,
> >
> > I'm emailing you because you're listed on the git-svn manpage. =A0I=
'm trying
> > to import an svn repository using git svn, and I'm running into a b=
it of a
> > problem:
> >
> > r57269 =3D f5bbaec2f7e8d866d794b421f68706baf81b16ec
> > (jiva_model_0.6-Jiva-4.5.0)
> > =A0 =A0 M =A0 =A0src/jiva_model/schema/episode.py
> > =A0 =A0 M =A0 =A0src/jiva_model/schema/group.py
> > Checksum mismatch: src/jiva_model/schema/member.py
> > expected: d6f1b614f3ec9c757ab21ebdfd01e011
> > =A0 =A0 got: a90dbcbdb3082deadecca9d1d00879bd
> >
> > I'm running git version 1.6.3.3 and git-svn version 1.6.3.3-2 on Ub=
untu
> > Karmic.
> >
> > I'm able to check out these files at this revision normally through=
 svn.
> > Does this mean that there's a problem somewhere in git svn? =A0Or d=
o I need to
> > do something more complex to reproduce it outside of git svn? =A0It=
 is
> > entirely possible that something's wrong with our svn repository.
>
> Hi Jason,
>
> It could be a problem with either the repo or git svn. =A0Is the repo
> public by any chance? =A0If it's a smallish repo I'd be glad to try
> reproducing it on my end.

Nope, it's a private repo and it's rather largeish.

>
> The checksum SVN relies on is just an MD5, so it should be easy to
> test arbitrary revisions of it (svn cat -r$rev $URL@$rev | md5sum)
> and see if there's an error for that repository.

This gives me something different from either value.=A0 :-/

$ svn cat -r57269
$URL/jiva_model_0.6-Jiva-4.5.0/src/jiva_model/schema/member.py@57269 |
md5sum
b5a6b9473d602027b1fe9b5b9d993cc0=A0 -

=A0(URL being the path to the root of the repo of course)

>
> You could also try updating between two revisions:
>
> =A0svn co -r57269 $URL FOO # (57269 was the last successful one)
>
> =A0cd FOO
> =A0svn up -r$NEXT_REV =A0 =A0 =A0# see if this errors out

This works:

$ svn co $URL/branches/jiva_model_0.6-Jiva-4.5.0/src/jiva_model/schema/
-r 57269
Checked out revision 57269.

$ cd schema

$ svn up -r 57270
At revision 57270.

So does this mean there's a problem on my side somewhere?

>
> > Also, is there a mailing list I should send questions like this to?
>
> The normal git mailing list, git@vger.kernel.org, but feel free to Cc=
 me
> to increase my chances of seeing it.

Added that list to this email.=A0 Thanks!
