From: Josef Wolf <jw@raven.inka.de>
Subject: Re: git-svn and repository hierarchy?
Date: Thu, 5 Mar 2009 19:05:29 +0100
Message-ID: <20090305180529.GD11278@raven.wolf.lan>
References: <20090227171248.GB14187@raven.wolf.lan> <49A826C8.1060300@drmicha.warpmail.net> <20090227220512.GC14187@raven.wolf.lan> <49A97B7A.8010005@drmicha.warpmail.net> <20090303185108.GA11278@raven.wolf.lan> <eaa105840903031135o4cf72ed0oe3fffed69cb7ce03@mail.gmail.com> <20090303223600.GB11278@raven.wolf.lan> <eaa105840903031618s5e0b6f24j64aade8d752fb11@mail.gmail.com> <20090304192752.GC11278@raven.wolf.lan> <eaa105840903041406k36088763w5a70fe1d7458dfb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 19:12:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfI35-0000Bk-PF
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 19:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755810AbZCESKP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 13:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755796AbZCESKP
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 13:10:15 -0500
Received: from quechua.inka.de ([193.197.184.2]:53332 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755569AbZCESKN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 13:10:13 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1LfI1K-0008Vo-M1; Thu, 05 Mar 2009 19:10:10 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 00BB62CB92; Thu,  5 Mar 2009 19:05:29 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <eaa105840903041406k36088763w5a70fe1d7458dfb1@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112324>

On Wed, Mar 04, 2009 at 05:06:06PM -0500, Peter Harris wrote:
> On Wed, Mar 4, 2009 at 2:27 PM, Josef Wolf wrote:
> > On Tue, Mar 03, 2009 at 07:18:04PM -0500, Peter Harris wrote:
> >>
> >> Sounds like subversion isn't properly caching your credentials, or
> >> your admin is paranoid and turned off the svn credential cache. I
> >> can't remember the last time I had to enter a password.
> >
> > What credential cache are you talking about? =A0I don't know of any
> > worth to be mentioned. =A0If you talk about "store-passwords=3Dyes"=
 in
> > subversion's config
>=20
> Yes, that's the one.
>=20
> > you might be interested to read
> > http://curl.haxx.se/docs/adv_20090303.html
>=20
> Not really, since I use svn:// :-)

Doesn't help ;-)  Many applications are using curllib, and all of them
can reveal your .netrc or subversion config.  For example, zypper and
apt use curllib, AFAIR.

> > BTW: The paranoid admin is myself. =A0 ;-)
> > BTW1: I know there's the possibility of client certificates. =A0But=
 AFAIK,
> > =A0 =A0 =A0there's no equivalent to ssh-agent, so it's pointless.
>=20
> I thought that this was already a part of svn, but it appears in the
> 1.6 (not quite final yet) release notes: "SSL client certificate
> passphrases can be stored in KWallet, GNOME Keyring, Mac OS Keychain,
> a Windows CryptoAPI encrypted form or in plaintext form."

Ummm, I always found it hard to find their changelog.  At least
http://svn.collab.net/viewvc/svn/trunk/CHANGES?view=3Dmarkup&pathrev=3D=
36138
don't mention those features.  Do you have a pointer?

> > Within svn, the author field seems to be correct (at least, it is
> > identical to those of the commits that were done directly to svn)
> > But when the commits come back to git, it is set to
> > "jw <jw@041dc122-08ea-11de-a769-bddc3e64b585>" with the host-part b=
eing
> > the uuid of the svn-repo.
> >
> > Any ideas how to fix that?
>=20
> "git help svn" and look for "--authors-file", maybe. I don't use it
> myself, so I'm afraid I can't help with that one.

Ah, I missed that.

> > Oh, and what happens if svn's rev-properties (commit log, author, d=
ate...)
> > are changed?
>=20
> Too late. git svn will ignore the change to the history, since git
> forces you to rewrite your entire history if any part changes. Cue
> standard "log messages should [not] be mutable" flamewar.
>=20
> Ah, here it is... <flamebait version>: Nothing happens. git will
> correctly store your *true* log/author/date, ignoring any and all
> attempts by malicious parties to destroy useful historical
> information.
>=20
> Of course, you're a paranoid admin, so you already have a
> pre-revprop-change hook in your svn server that prevents
> log/author/date changes. Right? ;-)

Well, actually it allows the changes for a very limited user group (tha=
t
is: only me 8-).  While I agree that author/date should not be changed,
I like to be able to fix silly typos in the log.  After all, we all do
typos now and then ;-)

> > In contrast, working directly against an svn repository is _very_
> > tedious.
>=20
> Tell me about it. Fortunately, we have git-svn to save us from the
> default svn client. ;-)

=46ortunately, the default client asks me for the password only once wh=
en
I commit something.  git-svn is different here ;-)

> (Sorry, couldn't resist pulling that one out of context)

(Me too)

> > =A0With a dozen commits pending, you have to enter your password
> > about 30..50 times in "git svn dcommit".
>=20
> Maybe svn 1.6 will fix that for you?

I don't think the problem is svn here.  Me tends to think git uses
curllib not in the way it was meant to be used.  And git-svn should
reuse the existing connection instead of creating a new one for every
bit it is going to transport.

> > =A0# 2. move commits from clone to subversion
> > =A0#
> > =A0cd git-svn-repos
> > =A0git svn rebase
> > =A0git pull ../clone$clone topic-branch =A0 # need rebase?
>=20
> Yeah, a "git svn rebase -l" after this line wouldn't hurt, and is
> suggested by "git help svn".
>=20
> Or even reverse those two lines, to save adding a third:
>   git pull ../clone$clone topic-branch
>   git svn rebase

With this, I get twice as much conflicts (half of them being spurious).
But the history is linear on the clones, thus reflecting the svn histor=
y
more accurately, I guess.

> Alternatively, you can avoid potential pull conflicts by using a
> temporary branch to avoid the merge you are about to throw away with
> rebase -- remember that 'pull' is short for 'fetch && merge':
>=20
> git fetch ../clone$clone topic-branch:scratch
> git checkout scratch
> git rebase trunk
> git svn dcommit
> git checkout master
> git svn rebase -l # fast-forward master to where scratch is
> git branch -d scratch
>=20
> ...which should result in seeing only the rebase conflict(s). And
> ought to work if cloneN's topic-branch is on a different svn branch
> from master (although you'd need to -D scratch instead of -d).

I guess you meant "git svn rebase trunk", since dcommit complains about
outdated transactions if "git rebase trunk" is used.

Overall, this looks very good, since the history is linear and I get
only spurious conflicts, which I can get rid of with "git rebase --skip=
".

Maybe there's room for more improvement:  Since the merge is done on a
scratch branch anyway, why not letting the clones _push_ into branches
with random names: cloneX-`uuidgen` or something.  So the clones could
do the push whenever they have net access.  The actual merge can be don=
e
completely decoupled from the push operation.
