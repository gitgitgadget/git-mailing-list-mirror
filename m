From: Mike Stump <mikestump@comcast.net>
Subject: Fwd: Rebase safely (Re: cherry picking and merge)
Date: Fri, 8 Aug 2014 09:23:47 -0700
Message-ID: <3D5C75D8-69D5-449D-9B0A-1B147D711C51@comcast.net>
References: <A769B84E-42D1-44AC-B0A8-0F4E68AB71FB@comcast.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 08 18:24:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFmxz-0005zi-60
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594AbaHHQY1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2014 12:24:27 -0400
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:54998 "EHLO
	qmta01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756299AbaHHQY0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Aug 2014 12:24:26 -0400
Received: from omta03.emeryville.ca.mail.comcast.net ([76.96.30.27])
	by qmta01.emeryville.ca.mail.comcast.net with comcast
	id cFbZ1o0050b6N64A1GQRkB; Fri, 08 Aug 2014 16:24:25 +0000
Received: from [IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d] ([IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d])
	by omta03.emeryville.ca.mail.comcast.net with comcast
	id cGQQ1o0102ztT3H8PGQRaa; Fri, 08 Aug 2014 16:24:25 +0000
X-Mailer: Apple Mail (2.1878.6)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1407515065;
	bh=5gsA56nXLo/+lGlAecTufBDbKfj1GR+AwyfmIsPI62c=;
	h=Received:Received:From:Content-Type:Subject:Date:To:Message-Id:
	 Mime-Version;
	b=G1qHEMLhbSwLHhx+MvMvOGsHMjNblJRSDCPl6n1DQO/Ju6Nj10zLZa86F0iko1G+v
	 u1SlDiYBxexLFt9dh/KVsmF3vUFL8qTxEGeTszC5sQAS6kAJSMRDkaZp4bu5UjtIhv
	 ebdcx1uSYIk4dGTXQuv17UmEX07C+Za9+mjNahozrJkI7i1LZPUY/qteotm469ulSA
	 Qe6s0Iz/OolbHtHB57tPV4IKufV6qUj8cUtL6WQVTgEw2lhvZQfIgRPGKxWcuRLYz4
	 j34i7+6jfyJgU8l+RSfESDZ2gqmToTDKpKnx0modxbCnkRgeBWJBAQYhsBeFE3QzGy
	 gIQfTx31iCGqQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255022>

[ sorry for the dup ]

Begin forwarded message:

On Aug 6, 2014, at 12:44 PM, Nico Williams <nico@cryptonector.com> wrot=
e:
> It's not a good idea to rebase a branch in a repo that others pull fr=
om.

Well, so rebase is then out, as I don=92t want to rebase _my_ tree, I w=
ant to rebase _the_ tree.  Recall, I don=92t want to cherry pick for my=
 tree, I want to cherry pick for the tree.

[ reads rest of email ]

Oh, wait, maybe I have misunderstood the prohibition.  I have:

       upstream  <=97=97 fsf
           |
            \
             |
             v
Me  <=97>   master  <=97> coworker.

Me is a git clone of master, coworker is a git clone of master.  Master=
 is a bare repo on a shared server where we put all of our work.  upstr=
eam is a bare git repo of the fsf git tree for gcc.  fsf is a box owned=
 by other that hosts the gcc git repository.  I do a git pull fsf in up=
stream from time to time, and a corresponding git merge fsf in Me from =
time to time.  When I like my work I do a git push (to master exclusive=
ly).  To go to upstream, we submit patches by hand, git is not really i=
nvolved.  I never pull into master from upstream (don=92t even think th=
at=92s possible since they are both bare).

I read the prohibition as don=92t rebase my branch called master on Me =
and push it to master on master as others then pull master from master.=
  Did I misunderstand?  Instead, the prohibition is you can use push/pu=
ll freely and you can have as many coworkers as you want, just don=92t =
use push -f and don=92t let anyone push/pull from your own private clon=
e.

I had envisions that the rebase of master on Me once pushed to master a=
nd then pull from master to coworker is the exact case that would screw=
 us.

> The only use-case I've seen where a rebase-based workflow doesn't wor=
k

Well, and now mine, which I claim is a the canonical open source use ca=
se.  Can't use source, unless you import the source,  can=92t be real u=
nless you can change the source, once you do that, you then need to mer=
ge in newer sources, and if the company has or will have more than a si=
ngle individual and these folks are ever to work together, then they ne=
ed to share the source between them.

I=92m trying to envision how anyone could ever use rebase.  If you can=92=
t share your work, it isn=92t work.

> is where you have multiple upstreams that you're following.

I only have a single (for this repo) upstream.

>> Now, I found the stack-overflow commentary first, and all the horror=
s
>> of it, and all the nuances.  I carefully read what people were doing=
,
>> how what I wanted to related to what they were doing, and it sure fe=
lt
>> like I was in the, don=92t go there camp.
>=20
> A lot of people rant about rebase.  They're wrong.  They've distorted
> your perspective.

What I saw were the people that screwed their world and were trying to =
recover.  It was a question, how do I recover, and what did I do wrong.=
  There was no rant.  Or, at least, I=92m impervious to rants and don=92=
t actually see them.  I deal in the cold hard facts and transform the r=
ant into what happened, what they did wrong, and how to avoid doing it =
myself.

No, you=92ve set my perspective, let me quote you:

  It's not a good idea to rebase a branch in a repo that others pull fr=
om.

this matches the doc, matches the experience of users on stack overflow=
 and matches what what I think is true.  You are free to correct that i=
f I am wrong.

I don=92t know why you think my perspective is distorted.  Either, I ca=
n rebase all my patches, all my coworkers patches, and push those up to=
 master and have all my coworkers pull from master and develop (meaning=
 branches off master as well as patches to master) as normal, or I can=92=
t.

> There's just two simple rules to follow and you'll be safe:
>=20
> 1) NEVER git push -f (--force) to a "published" repo/branch.

I can never use push -f.  That seems trivial.  git config --system rece=
ive.denyNonFastForwards true seems to be exactly what I would do to my =
master to enforce this rule.  This then seems to permanently be a non-i=
ssue.

> 2) NEVER work directly in a published repo.  Instead work in a privat=
e
>   clone.

I only ever work in a private to me clone, so I=92m safe.  The only pub=
lished repo is a bare repo, which can=92t be worked in by design, so, a=
gain, I think I=92m perfectly safe.

So, if that is true, why do others write such things as (from http://ct=
oinsights.wordpress.com/2012/06/29/git-flow-with-rebase/):

> The way to get the best of both worlds is to be explicit about when t=
o use one versus the other. For us the simple rules to follow are:
> 	=95 Rebase feature branches.
> 	=95 Never rebase develop or master branch. (Always merge into develo=
p and master.)
> 	=95 Never rebase public branches.
master is public, I want to rebase master.  This violates rule 3 above,=
 but not any of your rules?

I develop on master, thus violating rule 2.  This does=92t violate any =
of your rules?

I want to rebase master, thus, violating rule 1.  This doesn=92t violat=
e any of your rules?

I violate every single rule, by his standard, I am screwed.

http://blog.experimentalworks.net/2009/03/merge-vs-rebase-a-deep-dive-i=
nto-the-mysteries-of-revision-control/ says:

> Never rebase branches or trees that you pulled. Only rebase local bra=
nches.=20

I violate that.  This doesn=92t violate ant of your rules?  I pull mast=
er rebase it, then push it.  master is not a local branch, or, more cor=
rectly, I have a local branch called master that is push to and pull fr=
om a bare repo that I=92m calling master to/from a branch called master=
=2E  git diff origin/master master shows our work.

To me, a local branch is one call b, that doesn=92t push or pull to any=
 remote repo.

Linus in https://www.mail-archive.com/dri-devel@lists.sourceforge.net/m=
sg39091.html said:

But never other peoples code. That's a "destroy=20
history"

Thus violating his rule.  Recall why rebase was suggested.  I want to m=
erge the upstream fsf tree into our tree (or our tree into a copy of th=
e fsf tree) and instead of using merge, it was suggested to use rebase.=
  But I operate on our entire tree.  He further says:

- You must never EVER destroy other peoples history. You must not rebas=
e=20
   commits other people did.

I want to exactly rebase either the entire fsf tree onto mine, or mine =
on to the fsf tree.  Either result I am rebasing code I didn=92t write,=
 commits other than mine.  This violates his rule, not your?

He states:

- Minor clarification to the rule: once you've published your history i=
n=20
   some public site, other people may be using it, and so now it's clea=
rly=20
   not your _private_ history any more.

And I violate this rule, but it doesn=92t violate any of your rules?

>  To help make sure of this, never publish a non-bare repo
>   (bare =3D=3D has no workspace; non-bare =3D=3D has a workspace).

We only have a bare repo (our master) and we only ever push/pull from i=
t, so I=92m safe.

> It really helps to think of git as a pile of commits arranged in a
> Merkle has tree.  Branches and tags are just symbolic names for speci=
fic
> commits.  Rebase builds a new line of commits in the tree then it
> changes the symbolic branch name's HEAD to point to the head of that =
new
> line of commits, BUT NOTHING IS LOST in the pile of commits that is t=
he
> repo, not until you git-prune(1) to remove commits not reachable from
> symbolic names (branches and tags).

Wrong, let me introduce you to git gc:

       --prune=3D<date>
           Prune loose objects older than date (default is 2 weeks ago,=
 overridable by the config variable
           gc.pruneExpire). --prune=3Dall prunes loose objects regardle=
ss of their age. --prune is on by default.

which, I run every now and then as we work on stuff that is more than 5=
 lines long.  I bring in 60,000 changes, I push, I git gc on the bare r=
epo.

>>> The only case where I can imagine not using a
>>> rebase-heavy workflow is where I have to track multiple forked
>>> upstreams and so I want to merge each into my branch.
>>=20
>> So, sounds like I fit that use case and rebase could be my friend.
>=20
> Excellent.

I=92m optimistic.

>> How do I square what you said and:
>>=20
>>  Rebasing (or any other form of rewriting) a branch that others have
>>  based work on is a bad idea
>>=20
>> ?
>=20
> See above.

So, rebasing will always work just fine, one just needs to never, ever =
use push -f and never ever share ones own private clone.  Sharing a bar=
e repo that everyone works on (push/pull) is fine.  rebasing and pushin=
g into it and others pulling from it will always just work fine.

Gosh, could you get the documentation to say that.  I=92ve certainly be=
en scared off even trying rebase.

Rebase should just say it always works perfectly (remove the warning en=
tirely) and then burry into push -f, this option will destroy your worl=
d and put into it, the entire how it will screw it, how to recover from=
 it, and then say in the clone documentation, you should never clone a =
none bare repo, because if you do, your world will end when you rebase.=
  In fact, I=92ve make if a clone -f operation, and then fail the defau=
lt is non-base, and then under clone -f explain this is a ver bad idea.

Articles like http://stackoverflow.com/questions/457927/git-workflow-an=
d-rebase-vs-merge-questions:

Reason #2: With rebase, there is no undo!

makes me nervous.

>> I want all old refs in old emails to work.  I want all refs in
>=20
> They will if you stick to the two rules I mention above.

Ah, excellent.

>> bugzilla to work.  I want to see the original dates of all the work.
>=20
> Ditto.

Ah, nice.

>> I want git blame to report those artifacts in email and bugzilla.  I
>> have coworkers that I push to, pull from (through a single sharing
>> point, we call the master tree).  We work on gcc, we pull git gcc do=
wn
>> to a local copy, then merge it into our tree.  I want to cherry pick
>> changes from upstream.  I do work and push to our master, I pull wor=
k
>> of coworkers from the master, my coworkers do the same.  Isn=92t thi=
s
>> the canonical open source use case?
>=20
> That means that you have/maintain an intermediate upstream, yes?

Yes.  I have upstream which is a virgin copy of the fsf in a bare repo.

Our master only ever pulls from the upstream.

> This is a bit trickier since once in a while that intermediate upstre=
am
> and everyone downstream of it has to catch up with the real upstream.
>=20
> Here you have two options:
>=20
> - the intermediate diverges from the real upstream, and then you
>   merge/cherry-pick from the upstream as needed

Virgin copy, it only can ever lag in time, no other way.  We can only p=
ull or get work from our virgin copy, no other way.  To get a patch tha=
t just went in, I would like to pull from fsf into upstream, cherry-pic=
k upstream into Me, push into master.  When I merge I same thing except=
 I do a merge upstream.

>   The intermediate's maintainer must still merge/rebase/cherry-pick
>   from the intermediate branch and onto a branch of the upstream in
>   order to push to the upstream.

It never pushes up, it is unidirectional.  The only direction down is p=
ull the entire bare repo, everything, or nothing, that=92s it.

> (We always left symbolic names for the pre-rebase branch HEADs, mind
> you, to make life easier for everyone.)
>=20
>>> (I find that many users are allergic to rebasing.  Many people have
>>> told me that rebase is lying, that history must be immutable, and s=
o
>>> on, all ignoring that: git users don't rebase published branches,
>>=20
>> So, when I push, and someone else pulls, is that published?  I thoug=
ht
>> it was.
>=20
> Yes.  You shouldn't push -f.  As long as you don't there's no problem=
=2E

So, you would like to withdraw your statement, git users don't rebase p=
ublished branches, and instead say, git users can rebase published bran=
ches and it all works flawlessly well, provided they stay away from non=
-bare shared repos and stay away from push -f?  The later statement doe=
sn=92t make be nervous at all.  Though, I would like an option like rec=
eive.denyNonFastForwards to turn off the ability to push/pull from a no=
n-bare repo.


So, thinking about it some more, would references to the fsf git repo f=
rom the fsf bugzilla work in our tree once I rebase the fsf work on our=
s?  Remember, I do want those to work.