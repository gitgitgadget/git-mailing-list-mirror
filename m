From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Thu, 30 Apr 2009 18:59:50 -0400
Message-ID: <32541b130904301559w329bdd4bo6f2736a505b7235f@mail.gmail.com>
References: <20090427201251.GC15420@raven.wolf.lan>
	 <32541b130904281353k572fed5la468de65f73ccd19@mail.gmail.com>
	 <20090428223728.GE15420@raven.wolf.lan>
	 <32541b130904282019n4b930f80g1ed22b2dde22510a@mail.gmail.com>
	 <20090429160129.GF15420@raven.wolf.lan>
	 <32541b130904291113p6f99a82ft824cd3c482447117@mail.gmail.com>
	 <20090429223747.GG15420@raven.wolf.lan>
	 <32541b130904291907q4003ad86v4728c5b2ba0aacb7@mail.gmail.com>
	 <20090430222808.GH15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 01:00:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzfEX-0006un-DQ
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 01:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbZD3W7x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Apr 2009 18:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbZD3W7w
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 18:59:52 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:12286 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbZD3W7v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2009 18:59:51 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1219696yxj.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 15:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=2zE3vQZFtUGdr6dos+vxKwt7lTdL7T5haf7s8uU2ga8=;
        b=fKU2nnejdMk9DIZRgU5LtMgYcBWrfSSsOzIza/8sutX/faSCuYxXl9Da4XymiYZTlU
         EfKRieoVgU/BCW2ngWrUFo6QrWyjetiwxrcsxXKOJBLKypxq4QW4tD/HBXHvd+xaUJU2
         J/349kDwXj7EpnBDYNMdSIasoPNWZKQ5DVbNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=rPTiFKcNYPSzyTZGoIoSMTEWVDPIsZs3fRls/5o6FwUbEHBc7Z4z2R5jBqq/S7nhQL
         UHb55asR/b8t8LFxtpBP3mxuw0emKP5o8/zjsVBWaHI5tWS+jA8hJjqcmAQutDePaZZq
         ZAtkxpnH4hQ3e9xVFRAxCFxgQg4enSG1zCtHY=
Received: by 10.151.124.7 with SMTP id b7mr4361631ybn.221.1241132390766; Thu, 
	30 Apr 2009 15:59:50 -0700 (PDT)
In-Reply-To: <20090430222808.GH15420@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118050>

On Thu, Apr 30, 2009 at 6:28 PM, Josef Wolf <jw@raven.inka.de> wrote:
> =A0# cherry-pick from second-svn to first-svn
> =A0#
> =A0git svn checkout first-svn
> =A0git cherry-pick sha1-from-second-svn # repeat as needed
> =A0git checkout first-svn/trunk
> =A0git merge --no-ff first-svn
> =A0git diff first-svn/trunk first-svn >changes.diff
> =A0git svn dcommit
[...]
> But I am still somewhat confused:
>
> =A0git log -1 first-svn/trunk
>
> says "Merge branch first-svn into HEAD". =A0But this does not reflect
> what I've actually done: I've picked _from_ second-svn and committed
> that _to_ first-svn.

The most recent commit to first-svn/trunk was "git merge --no-ff
first-svn", which creates the merge commit you're seeing here.  (HEAD
=3D=3D first-svn/trunk).  So this sounds right to me.

"git log -1 first-svn" would give you the first cherry-pick.  But
remember, it's a completely different branch.

>> What you probably thought you should do, given that the existing
>> git-svn documentation says to do it, is more like this:
>>
>> =A0 =A0# WRONG
>> =A0 =A0git checkout first-svn
>> =A0 =A0git cherry-pick some stuff
>> =A0 =A0git merge [perhaps -s ours] second-svn/trunk
>> =A0 =A0git svn dcommit
>
> Almost... In addition, I was trying to "git svn rebase" before the
> dcommit

'git svn dcommit' implies 'git svn rebase' first anyway, so it's the sa=
me.

> What would happen if somebody else creates a new commit just after I
> "git svn fetch" but before I dcommit? =A0Guess, svn will not accept t=
his
> commit, because it is based on an outdated revision. =A0How would I
> get out from this situation?

AFAIK, it will attempt to do "git svn rebase" first, and if that
succeeds, it will do the commit.

In such a case, the rebase should be okay, because it's only changing
commits (in fact, just one commit: the merge commit) that don't exist
on any other branch.  Thus it won't mangle any other merges.

>> As it happens, I wrote the git-svn chapter for the
>> very-nearly-available new O'Reilly book "Version Control with Git." =
=A0I
>> gave the complicated solution there too.
>
> Interesting. =A0Do you have any information when it will be available=
?

Mid-May, as I understand it.

> Ummm, no.. I have _two_ branches:
>
> =A0first-svn: =A0contains the cherries that I picked from second-svn.=
 This
> =A0 =A0 =A0 =A0 =A0 =A0 =A0branch looks the way first-svn/trunk shoul=
d be
> =A0second-svn: contains the cherries that I picked from first-svn. Th=
is
> =A0 =A0 =A0 =A0 =A0 =A0 =A0looks the way second-svn/trunk should be

Okay, if you want to end up with two different remote branches, it
makes sense to have two different local branches.

> Don't I need to rebase at least one of them if I want to "merge" thos=
e
> two branches into a single one?

I don't think so.  If you merge them together, what do you *want* it
to look like?  And what do you want to do with that branch afterwards?
 It's hard for me to guess, but it seems unlikely that rebasing things
will get you there.

If what you want is "one central branch that currently looks like
first-svn/trunk or second-svn/trunk or maybe something else, but we'll
be merging future changes to first-svn and second-svn into it in the
future", then you would do:

   git checkout -b one-true-branch
   ...make it look however you want...
   # now mark it as up-to-date with svn, but don't change anything
   git merge -s ours first-svn/trunk
   git merge -s ours second-svn/trunk

And then in the future, whenever first-svn/trunk or second-svn/trunk
change, you would do:

   git merge first-svn/trunk
   git merge second-svn/trunk

etc.

> I have a hard time to adopt my mental model to the one-branch method =
for
> some reason. =A0OTOH, I can easily understand the multiple-branch met=
hod:
> for every remote branch, I have a local branch on which I collect the
> commits that should go to this remote.

It's indeed pretty complicated.  I had much better luck once I finally
separated the two concepts in my mind.  In general, you want to name
local branches after what they *do*; you almost never have a 1:1
mapping between local and remote branches, particularly when using
git-svn (at least, when using git-svn with merges instead of rebases).

Maybe think of it like this: you're not "collecting commits."  You're
simply merging changes from one place to another, and testing them
out.  Once you're happy with what's on your local branch, you want to
merge it (--no-ff) into the remote branch and git svn dcommit it.  svn
will never see the individual commits; it only sees the merge commits.

>> >> >> As long as you "git config merge.summary true" (to make the me=
rge
>> >> >> commit list all the commits it's merging)
[...]
>> In fact, it *only* affects the svn log. =A0Otherwise svn log ends up
>> with a useless commit that says "Merged from commit (giant hex
>> string)", and you can't actually do anything with the giant hex stri=
ng
>> because svn doesn't know what it is.
>
> OK. =A0I just noticed the list is limited to 22 entries. =A0Can this =
be
> configured somehow to contain the complete list?

Ah, that.  I don't think there's an obvious way.  I forgot I did it
until now, but my copy of git is patched to "fix" this.  My patch is
attached below.

>> > The people are not uncooperative. =A0It is just that there's no wa=
y to
>> > completely separate the public and private content.
>>
>> There is, if you're willing to do it. =A0The usual way is two have t=
wo
>> branches: public and private.
>
> Well, my plan was to have one (generic) public repository that contai=
ns
> templates instead of the localized information. =A0Separating the
> repositories is a security measure here.
>
> Whether separate repositories or only different branches, conflicts
> _are_ to be expected in this area.

Conflicts are normal.  But you can simply resolve them, using normal
git mechanisms, when merging from public-svn/trunk to
second-svn/trunk, or whatever.  At least you shouldn't have to
cherry-pick or rebase anything.

Have fun,

Avery


diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index df18f40..96c42ff 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -255,7 +255,7 @@ static void shortlog(const char *name, unsigned cha=
r *sha1,
 }

 int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf =
*out) {
-       int limit =3D 20, i =3D 0, pos =3D 0;
+       int limit =3D 2000, i =3D 0, pos =3D 0;
        char line[1024];
        char *p =3D line, *sep =3D "";
        unsigned char head_sha1[20];
