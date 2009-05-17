From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Sun, 17 May 2009 13:24:49 +0200
Message-ID: <20090517112449.GT15420@raven.wolf.lan>
References: <32541b130905081344m634a78d5l984f4903ec1515eb@mail.gmail.com> <20090508235821.GO15420@raven.wolf.lan> <20090513120922.GP15420@raven.wolf.lan> <32541b130905131028i5c4b1a31j7f760f8157507df6@mail.gmail.com> <20090513222243.GQ15420@raven.wolf.lan> <32541b130905132335t3cbd0e7wf29577ee15ba0bac@mail.gmail.com> <20090514214120.GR15420@raven.wolf.lan> <32541b130905141457u196e1a68w8250489b88eb83c4@mail.gmail.com> <20090515175203.GS15420@raven.wolf.lan> <32541b130905151205h6ca89d85q97e72ce23bf233ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 17 13:30:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5eZi-0003JB-0i
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 13:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868AbZEQLaa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 May 2009 07:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753690AbZEQLa3
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 07:30:29 -0400
Received: from quechua.inka.de ([193.197.184.2]:39676 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021AbZEQLa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 07:30:28 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1M5eZY-0004kE-CL; Sun, 17 May 2009 13:30:28 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id EA6D42CD00; Sun, 17 May 2009 13:24:49 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <32541b130905151205h6ca89d85q97e72ce23bf233ee@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119392>

On Fri, May 15, 2009 at 03:05:14PM -0400, Avery Pennarun wrote:
> On Fri, May 15, 2009 at 1:52 PM, Josef Wolf <jw@raven.inka.de> wrote:
> > On Thu, May 14, 2009 at 05:57:00PM -0400, Avery Pennarun wrote:
> >> On Thu, May 14, 2009 at 5:41 PM, Josef Wolf <jw@raven.inka.de> wro=
te:
> >> > So here's my second plan:
> >> > 1. instead of doing the cherry-picking in a single repository, i=
t might
> >> > =A0 be helpful to do it in separate repositories: one repository=
 for each
> >> > =A0 direction. =A0While there are still two remote svn repositor=
ies in each
> >> > =A0 svn repository, there is no need for criss-cross anymore. =A0=
The flow
> >> > =A0 of the data is in one direction and it seems (at least at fi=
rst glance)
> >> > =A0 I can use git-svn-rebase to get a linear history.
> >>
> >> it's still criss-crossing, it's just less obvious that way. =A0One
> >> repository is exactly the same as two repositories in git; all tha=
t
> >> matters is the branch histories.
> >
> > Yeah, I see... =A0But this step is here _only_ to get the existing =
svn
> > repositories in sync again. =A0After cherry-picking and dcommitting=
, those
> > cherry-pick repositories would be wiped. =A0They have no real histo=
ry. =A0The
> > steps I outlined in my previous mail wouldn't even create any files=
 in
> > the .git/refs subdirectory.
>=20
> Hmm, getting them in sync the first time seems to be "easy"
> (relatively), in that you've already done it, right?

No.  I have a perl script to do the cherry-picking and to resolve
conflicts.  Because of this, I can try out different methods to do the
sync.  And of course, I'd like to do it in a way that produces the leas=
t
problems in the future, since this is a one-shot thing.

> >> I'd say that basically none of your problems have anything to do w=
ith
> >> svn's lack of merge support, and everything to do with the fact th=
at
> >> you aren't doing all your changes first on a 'public' branch and t=
hen
> >> merging from there into the private branches. =A0(That's really no=
t so
> >> hard to do in svn either, and would save a ton of confusion.)
> >
> > The problem here is that it does not match the work flow. =A0IMHO, =
my work
> > flow is very similar to the work flow of the kernel, so I fail to s=
ee why
> > it can not work. =A0See the analogies:
> >
> > kernel: Submodule maintainers are committing into private repositor=
ies
> > me: =A0 =A0 People are committing into private repositories
> >
> > kernel: Those commits are forwarded to Linus's repository
> > me: =A0 =A0 Those commits are forwarded to the public repository
> >
> > kernel: Maintainers receive commits for other submodules from linus
> > me: =A0 =A0 Commits are distributed from public to private reposito=
ries
>=20
> There is one critical difference here: if someone merges from Linus
> and then Linus merges back from them, then the two resulting
> repositories will be *identical* (at least, the trees will be; if the
> second merge uses --no-ff, the histories will be very slightly
> different, but not importantly so).
>=20
> If someone has patches that they don't want to send back to Linus, an=
d
> those patches are intermixed with ones they *do* want to send back,
> then they either have to cherry pick them over to a separate branch
> (which Linus can then pull), or equivalently they email individual
> patches to Linus, or they need to rebase a lot, or they need to just
> put their "finished" patches onto a separate branch and keep the
> unfinished ones somewhere else that Linus won't pull.

Does any description exist how this process works in detail?

> Rebasing is (I think) actually the most common solution to this
> problem, but it doesn't help if you're using svn.  svn has no concept
> of rebasing.  (git svn rebase uses git rebase, but it's not really fo=
r
> the same purpose.)

In the long term, I am willing to get rid of svn.  But I have to create
a migration path, so I need to keep git+svn in parallel for a couple of
months.
