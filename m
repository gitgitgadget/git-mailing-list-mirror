From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@dwim.me>
Subject: Re: [PATCH v2 40/43] refs: allow ref backend to be set for clone
Date: Mon, 12 Oct 2015 11:00:08 +0200
Message-ID: <1444640408.41811.7.camel@dwim.me>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	 <1443477738-32023-41-git-send-email-dturner@twopensource.com>
	 <5612439E.4080200@alum.mit.edu> <1444094977.7739.24.camel@twopensource.com>
	 <20151006015806.GA4972@sigill.intra.peff.net>
	 <1444154963.7739.30.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 12 11:06:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlZ3L-0007t6-Hm
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 11:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbbJLJFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2015 05:05:51 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:55600 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbbJLJFu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 05:05:50 -0400
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2015 05:05:49 EDT
Received: from [IPv6:2001:6f8:900:8cd0:922b:34ff:fe1c:e3e4] (unknown [IPv6:2001:6f8:900:8cd0:922b:34ff:fe1c:e3e4])
	by hessy.dwim.me (Postfix) with ESMTPSA id 2407E802AB;
	Mon, 12 Oct 2015 11:00:09 +0200 (CEST)
In-Reply-To: <1444154963.7739.30.camel@twopensource.com>
X-Mailer: Evolution 3.18.0-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279367>

On Tue, 2015-10-06 at 14:09 -0400, David Turner wrote:
> On Mon, 2015-10-05 at 21:58 -0400, Jeff King wrote:
> > On Mon, Oct 05, 2015 at 09:29:37PM -0400, David Turner wrote:
> >=20
> > > > Therefore, I don't think this can be merged without a bump to
> > > > core.repositoryformatversion. Such a bump will tell well-
> > > > behaved older
> > > > Git clients keep their hands off the repository. (Of course
> > > > repositories
> > > > that use the files backend can continue using
> > > > core.repositoryformatversion 0.)
> > > >=20
> > > > I thought Peff proposed a way to do such a bump, including a
> > > > way to
> > > > extend repositories one by one with new features. But that was
> > > > something
> > > > that we were chatting about off-list.
> > > >=20
> > > > I haven't reviewed the actual code in this patch yet but I
> > > > wanted to get
> > > > the above comment on your radar.
> > > >=20
> > > > Michael
> > >=20
> > > I'll fix this to upgrade to v=3D1 when the lmdb refs backend is i=
n
> > > use,
> > > and to give sensible error messages in a v1 repo if built without
> > > LMDB.
> >=20
> > I think the relevant series is:
> >=20
> > =C2=A0 http://article.gmane.org/gmane.comp.version-control.git/2724=
47
> >=20
> > It did not seem too controversial, but it mostly got dropped amidst
> > the
> > release, and I haven't reposted it yet.
>=20
> That patch will work perfectly for this use case.=C2=A0=C2=A0I'll add=
 it to my
> series when I reroll, and set an extension.

This is something I'm working on right now for libgit2 as well; not
lmdb specifically but allowing user-provided backends, which would
allow built-in ones as well.

Did we ever decide on the format for these extensions? The series
mentioned above has a couple of examples, but doesn't have any testing
for backend stuff. Do we have a concrete proposal for this? I was going
to go for something like

extensions.refbackend =3D "lmdb"
extensions.odbbackend =3D "psql"

and have backends register themselves by the "lmdb", "psql" or whatever
format, but if we have already decided something else which I missed,
I'd swap over to that.

Cheers,
=C2=A0 =C2=A0cmn
