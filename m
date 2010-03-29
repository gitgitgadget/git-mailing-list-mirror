From: Eli Barzilay <eli@barzilay.org>
Subject: Re: `git check-attr' problems & questions
Date: Mon, 29 Mar 2010 11:28:27 -0400
Message-ID: <19376.50971.397375.810974@winooski.ccs.neu.edu>
References: <m3iq8jn3ar.fsf@winooski.ccs.neu.edu>
	<20100328014208.GA23015@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 17:28:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwGtH-0003B7-5A
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 17:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620Ab0C2P23 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 11:28:29 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:55284 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753541Ab0C2P23 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 11:28:29 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1NwGt9-0000BU-EH; Mon, 29 Mar 2010 11:28:27 -0400
In-Reply-To: <20100328014208.GA23015@progeny.tock>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143482>

On Mar 27, Jonathan Nieder wrote:
> Hi,
>=20
> [quoted text reordered for convenience]
>=20
> Eli Barzilay wrote:
>=20
> > I'm trying to use .gitattributes to use some custom properties that=
 we
> > have in an svn repository which is migrating to git,
> [...]
> > So my first question is -- am I missing something obvious?  It almo=
st
> > looks like `check-attr' is intended only for low-level use...
>=20
> Yep.  It=E2=80=99s listed under =E2=80=9Cpurehelpers=E2=80=9D (Intern=
al helper commands) in
> command-list.txt and hence git(1).

(Ah, it would be nice to have that in the `git-check-attr' man page.)


> I suspect a good place to put a user-visible equivalent would be a
> future =E2=80=98git ls=E2=80=99 command [1].
>=20
> Therefore...
>=20
> > Fixing the first problem seems like it would be easy with a quick
> > shell script (maybe even with just an alias),
>=20
> If it proves pleasant to use, it would be very nice if you could
> send a copy of such a shell script after a while.  Experiments like
> this are the foundation of a good UI.

A script is easy, but even if it's for internal use, I don't see the
point in `check-attr' not doing so...

> > 2. I'm also trying to use an attribute on a hook script on the serv=
er
> >    (with the idea that email notifications are sent according to th=
e
> >    set of modified files) -- but it looks like `git check-attr'
> >    doesn't work on a bare repository.
>=20
> Current =E2=80=98git check-attr=E2=80=99 reads its attributes from ac=
tual .gitattribute
> files in the work tree first and then examines the versions registere=
d
> in the index.  So the secret is to read the .gitattribute files you c=
are
> about into a temporary index file --- e.g., something like this.
>=20
>  : "Usage: $0 commit check-attr-args" &&
>=20
>  GIT_INDEX=3Dtmp-index git read-tree --reset -i "$1" &&
>  shift &&
>  GIT_INDEX=3Dtmp-index git check-attr "$@" &&
>  rm tmp-index

I tried that, but it doesn't work.  (I used GIT_INDEX_FILE.)

--=20
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay=
:
                    http://barzilay.org/                   Maze is Life=
!
