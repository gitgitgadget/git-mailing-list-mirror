From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 19:04:46 +0200
Message-ID: <1318525486.4646.53.camel@centaur.lab.cmartin.tk>
References: <loom.20111013T094053-111@post.gmane.org>
	  <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>
	  <20111013145924.2113c142@ashu.dyn.rarus.ru>
	  <loom.20111013T130924-792@post.gmane.org> <4E96D819.20905@op5.se>
	  <loom.20111013T152144-60@post.gmane.org>
	 <1318517194.4646.30.camel@centaur.lab.cmartin.tk>
	 <loom.20111013T171530-970@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-CkFP1YxgZBcpdGQmpAD/"
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 19:04:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REOiE-00047d-T5
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 19:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143Ab1JMREt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 13:04:49 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:46078 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754417Ab1JMREt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 13:04:49 -0400
Received: from [192.168.1.17] (brln-4dbc7ca2.pool.mediaWays.net [77.188.124.162])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id CC1DA460FE;
	Thu, 13 Oct 2011 19:04:19 +0200 (CEST)
In-Reply-To: <loom.20111013T171530-970@post.gmane.org>
X-Mailer: Evolution 3.0.3-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183497>


--=-CkFP1YxgZBcpdGQmpAD/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-10-13 at 15:53 +0000, arQon wrote:
> Carlos Mart=C3=ADn Nieto <cmn <at> elego.de> writes:
> > I have not seen a revert command in any of your messages. If a revert o=
n
> > one branch changes another one, that would be a bug, but you haven't
> > shown this to happen.
>=20
> Sorry, it was in prose in the original post (near the end)
> "At this point, reverting the master with "checkout --" also wipes out th=
e
> changes on the other branch. It's like the merge symlinked the two branch=
es
> rather than, well, merging them."
>=20
> Based on the explanations here, and the git *st* message, it wiping out t=
he
> other branch is to be expected, because it's "the working directory", not
> "the branch".
>=20
> >git st
> # On branch foo
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working direct=
ory)
> #
> #       modified:   file1.txt
> #
> no changes added to commit (use "git add" and/or "git commit -a")
>=20
> What makes this really interesting though is this: I tried to switch to
> master to see if that gave the same warning, and NOW, I get the correct
> error.
>=20
> >git co master
> error: Your local changes to the following files would be overwritten by
> checkout:
>         file1.txt
> Please, commit your changes or stash them before you can switch branches.
> Aborting
>=20
> I'm sure if I thought about it enough (ie re-read Andreas's post a couple
> more times) I'd be able to understand why git gets it right sometimes but
> not other times, but I'm too tired right now. Even when I *am* awake and
> grok it properly, I'm still going to be annoyed that it's so inconsistent=
,
> but I can live with that if I have to.

If file1.txt in the foo branch is different from the one in the master
branch, git will refuse to switch branches. 'git diff foo master' should
show that those two files are different.

>=20
> > The reason this happens both in svn and git is that the most likely
> > cause for someone to change a branch mid-edit is that they decide
> > they're doing the changes on the wrong branch.
>=20
> Lucky you. :P  The most likely reason for me is, I'm working on something
> and I get interrupted and have to switch. Since the code may well not eve=
n
> compile at this point, the last thing I want to do is commit it. git's
> ability for that commit to be local is half the reason I'm trying to swit=
ch
> to it. (I'm not particularly keen on having to commit broken code to even=
 a
> local repo, but that's still a hell of a lot better than having it pushed
> upstream as well).

Yes, this is a great feature of distributed systems. A local repo is
where you experiment. Treat it as your own personal space to play around
with things. Committing non-working code is fine, as long as you don't
push it out.

>=20
> > svn doesn't tell you about the modifications being carried over
> > (presumably you're meant to use status and diff to figure out what's
> > going on). Therefore, the same workflow (with the only difference being
> > how to create and switch branches) works for svn and git in this case.
>=20
> I expect part of my confusion comes from using different workdirs for svn
> branches, ie "clone" rather than "branch", because branching in svn is su=
ch
> a PITA I just don't bother with it unless the branch is going to be
> "heavyweight" enough to warrant a "proper" branch.

Then the issue is that you've changed the workflow but haven't adjusted
for it. You can do this as well with the git-new-workdir. As I mentioned
it has a few rough edges, but if you're going to use it to have a
checkout of a particular branch, it shouldn't present any problems. That
would be like your current workflow.

Another option is to clone with a reference which will create a brand
new clone but will use the objects that you've already downloaded (or
just clone locally). This can be more comfortable than using the
new-workdir and will hardly put any strain on the filesystem.

The bigger problem seems to be your reluctance to accept that git is
different from subversion, as you keep saying "that's just how git is"
to back your claim that you can't trust git on a feature where
subversion behaves the same way. If you'd rather use different
directories for different branches, you can. That is not an aspect which
you can point to and say that you can't migrate to git for that reason.
If you're more comfortable with subversion, that's fine also, it's an
excellent piece of software[0], but don't go around saying that git
corrupts branches when that's blatantly not true.

   cmn

[0] Whatever one may think about the merits of CVCS vs DVCS; that
shouldn't come into the quality of the software.


--=-CkFP1YxgZBcpdGQmpAD/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOlxouAAoJEHKRP1jG7ZzTNWkIAKM4yeTqWgeheacL2T2pFV2f
XntUSG5qWLkS5Pav+/FP0YzwebTPwL+HAiTRej4aTxCpwHas48AiZh/1yyuV4UMK
MIGOmCDLTwGLOioDZNxwVQci5ne/jHklaiGfmgQwqHO8uzE4b2VN5nKoBlO9/lyv
XZ/uZQiXxOCbkbLcm4ucFuHk6eElmChvHLJiqLZKGKYrDH51ICrCt1t+J6RHN4Ng
kZWFRKxgyOLlO+0IcDop0m2YzEM2U2vLxnfw1KnX0pTg0QxnD1V1kkOYIESKjEew
B37+M8/bmjJcpKuQ9pcIF2wMyRjVY1Aa80h5xh9SDK1JWaJHSclrtOXj/vFsQ0w=
=QxYA
-----END PGP SIGNATURE-----

--=-CkFP1YxgZBcpdGQmpAD/--
