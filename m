From: Arne Babenhauserheide <arne_bab@web.de>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 08:50:08 +0100
Message-ID: <200810270850.09696.arne_bab@web.de>
References: <ge0rla$mce$1@ger.gmane.org> <200810270147.52490.arne_bab@web.de> <200810270252.23392.jnareb@gmail.com>
Reply-To: "Arne Babenhauserheide" <arne_bab@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3058658.ghgofSSQR8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, SLONIK.AZ@gmail.com, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 08:51:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuMst-00050Y-Nj
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 08:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbYJ0HuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 03:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbYJ0HuP
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 03:50:15 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:40635 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbYJ0HuN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 03:50:13 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 4F890F30C8E7;
	Mon, 27 Oct 2008 08:50:12 +0100 (CET)
Received: from [217.227.70.45] (helo=fluss.localnet)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1KuMrb-0007y8-00; Mon, 27 Oct 2008 08:50:11 +0100
User-Agent: KMail/1.10.1 (Linux/2.6.25-gentoo-r7; KDE/4.1.1; x86_64; ; )
In-Reply-To: <200810270252.23392.jnareb@gmail.com>
X-Sender: arne_bab@web.de
X-Provags-ID: V01U2FsdGVkX1+SckfkPaMDRspqlO9FfUNCWdDy6vx5MBg5jwOg
	ER++kZn+sJAMfvoBnKfYVBRofkLKlaysabcRQN6E7Bu8q8ZGXN
	SPUG+4iYM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99213>

--nextPart3058658.ghgofSSQR8
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag 27 Oktober 2008 02:52:22 schrieb Jakub Narebski:
> On Mon, 27 Oct 2008, Arne Babenhauserheide wrote:
> > Am Sonntag 26 Oktober 2008 19:55:09 schrieb Jakub Narebski:
> > > I agree, and I think it is at least partially because of Git having
> > > cleaner design, even if you have to understand more terms at first.
> >
> > What do you mean by "cleaner design"?
>
> Clean _underlying_ design. Git has very nice underlying model of graph
> (DAG) of commits (revisions), and branches and tags as pointers to this
> graph.
>
> > From what I see (and in my definition of "design"), Mercurial is design=
ed
> > as VCS with very clear and clean design, which even keeps things like
> > streaming disk access in mind.
>
> I have read description of Mercurial's repository format, and it is not
> very clear in my opinion. File changesets, bound using manifest, bound
> using changerev / changelog.

This grows very simple if you keep common filesystem layout in mind.=20

inodes and datanodes (the files in the store), organized in directories whi=
ch=20
keep many files (manifests) bound in changesets which keep additional data.=
=20

> Mercurial relies on transactions and O_TRUNC support, while Git relies
> on atomic write and on updating data then updating reference to data.

=46or most operations Mercurial just relies on appending support.=20

> I don't quite understand comment about streaming disk access...

If you tell a disk "give me files a, b, c, d, e, f (of the whole abc)", it =
is=20
faster then if you tell it "give me files a k p q s t", because the filesys=
tem=20
can easier optimize that call.=20

That's why for example Mercurial avoids hashing filenames.=20

> Well, they have to a lot less than they used to, and there is
> "git gc --auto" that can be put in crontab safely.

relying on crontab which might not be available in all systems (I only use=
=20
GNU/Linux, but what about friends of mine who have to use Windows?)

> Explicit garbage collection was a design _decision_, not a sign of not
> clear design. We can argue if it was good or bad decision, but one
> should consider the following issues:
>
>  * Rolling back last commit to correct it, or equivalently amending
>    last commit (for example because we forgot some last minute change,
>    or forgot to signoff a commit), or backing out of changes to the
>    last commit in Mercurial relies on transactions (and locking) and
>    correct O_TRUNC, while in Git it leaves dangling objects to be
>    garbage collected later.

As far as I know the only problem woth O_TRUNC was that it sadly had bugs i=
n=20
Linux.

>  * Mercurial relies on transaction support. Git relies on atomic write
>    support and on the fact that objects are immutable; those that are
>    not needed are garbage collected later. Beside IIRC some of ways of
>    implementing transaction in databases leads to garbage collecting.

But Mercurial normally works on standard filesystems, so this isn't the cas=
e=20
for normal operations.=20

You culd say, though, that git implements a very simple transaction model:=
=20
Keep all old data until it gets purged explicitely.=20

>  * Explicit packing and having two repository "formats": loose and
>    packed is a bit of historical reason: at the beginning there was
>    only loose format. Pack format was IIRC invented for network
>    transport, and was used for on disk storage (the same format!) for
>    better I/O patterns[1]. Having packs as 'rewrite to pack' instead
>    of 'append to pack' allows to prefer recency order, which result in
>    faster access as objects from newer commits are earlier in delta
>    chain and reduction in size in usual case of size growing with time
>    as recency order allows to use delete deltas. Also _choosing_ base
>    object allows further reduce size, especially in presence of
>    nonlinear history.

So having multiple packs is equivalent to the automatic snapshot system in=
=20
Mercurial which doesn't need user interaction.=20

>  * From what I understand Mercurial by default uses packed format for
>    branches and tags; Git uses "loose" format for recent branches
>    (meaning one file per branch), while packing older references.
>    Using loose affects performance (and size) only for insane number of
>    references, and only for some operations like listing all references,
>    while using packed format is IMHO a bit error prone when updating.

As far as I know, Mercurial got that "using packed format" right from the=20
beginning.=20

>  * Git has reflogs which are pruned (expired) during garbage collecting
>    to not grow them without bounds; AFAIK Mercurial doesn't have
>    equivalent of this feature.
>
>    (Reflogs store _local_ history of branch tip, noting commits,
>    fetches, merges, rewinding branch, switching branches, etc._

As far as I know Mercurial only tracks the state of the working directory, =
so=20
it doesn't track your whole local history.=20

But others can better tell you more about that in greater detail.=20

> [1] You wrote about "streaming disk access". Git relies (for reading)
> on good mmap implementation.
>
> > In git is has to check all changesets which affect the file.
>
> I don't understand you here... if I understand correctly above,
> then you are wrong about Git.

Might be that I remember incorrectly about what git does.=20

Are its commits "the whole changed file" or "the diff of the changes"?=20

If the latter, it needs to walk back all commits to the snapshot revision t=
o=20
get the file data.=20

One story I experienced with that:=20

My amd64 GNU/Linux box suffers from performance problems when it gets high=
=20
levels of disk activity (something about the filesystem layer doesn't play=
=20
well with amd64 - reported by others, too).=20

When I pulled a the Linux kernel repository with git half a year ago, my di=
sk=20
started klicking and the whole computer slowed down to a crawl.=20

When I pulled the same repository data from a Mercurial repository, the=20
computer kept running smooth, the disk stayed silent and happily wrote the=
=20
data.=20

Mercurial felt smooth, while git felt damn clumsy (though not slow).=20

> > 1) Hg is easy to understand
>
> Because it is simple... and less feature rich, c.f. multiple local
> branches in single repository.

That works quite well. People just don't use it very often, because the=20
workflow of having multiple repositories is easier with hg.=20

> > 2) You don't have to understand it to use it
>
> You don't have to understand details of Git design (pack format, index,
> stages, refs,...) to use it either.

I remember that to have been incorrect about half a year ago, when I stumbl=
ed=20
over many problems in git whenever I tried to do something a bit nonstandar=
d.=20

It took me hours (and in the end asking a friend) to find out about=20

"git checkout ."

just to get back my deleted files.=20

The answer I got when I asked why it's done that way was "this is because o=
f=20
the inner workings of git. You should know them if you use it".=20

> > And both are indications of a good design, the first of the core, the
> > second of the UI.
>
> Well, Git is built around concept of DAG of commits and branches as
> references to it. Without it you can use Git, but it is hard. But
> if you understand it, you can understand easily most advanced Git
> features.
>
> I agree that Mercurial UI is better; as usually in "Worse is Better"
> case... :-)

What do you mean with that?=20

Best wishes,=20
Arne

=2D- My stuff: http://draketo.de - stories, songs, poems, programs and stuf=
f :)
=2D- Infinite Hands: http://infinite-hands.draketo.de - singing a part of t=
he=20
history of free software.
=2D- Ein W=C3=BCrfel System: http://1w6.org - einfach saubere (Rollenspiel-=
) Regeln.

=2D- PGP/GnuPG: http://draketo.de/inhalt/ich/pubkey.txt

--nextPart3058658.ghgofSSQR8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkkFcrEACgkQMwdGm/6WxASHeQCghwzjUcZhHOlRV+RU6ap6X9f/
Uw8An1Fc5Rwo8eXYpr906GidkbtsyNZC
=uNzO
-----END PGP SIGNATURE-----

--nextPart3058658.ghgofSSQR8--
