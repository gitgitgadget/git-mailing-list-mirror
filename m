From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Wed, 21 Jul 2010 17:09:17 -0400
Message-ID: <AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bryan Larsen <bryan.larsen@gmail.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 23:09:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObgY1-0000aV-35
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 23:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758338Ab0GUVJk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 17:09:40 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43412 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941Ab0GUVJi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 17:09:38 -0400
Received: by wyf19 with SMTP id 19so37980wyf.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gnNuwfQbaqCdMx4kzPGa5ung+192PbUayv8Pc9+nT5c=;
        b=OIiboJ9iQtuWKKjuYYq0HlImn9/p58yaLz+VoAOKaWxFmKDWKkNYjl/PnlAuCMSTWF
         5StRu+T9RUFb6WiL4f2RP6t0142CP6NmO3Zf0sTG4pX8BnGJbyRYq7gOE7HO7ZbYx7pT
         Vuuu1KSKuT7TfGSk2ItrxYLrOi67Sdfe9BNmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kNj7Hdi9ZW+GMp44Ymw+yY6/G4p3i0g0sqcQbX69ZUeE+cVCwA2h7JsmH30VPUixc5
         5e5JC2n0r6z7G8QXdpiODmYO50NXkYSI0CnoFL/KJ7Je7FziDD2DP494KFnFp21arojx
         qzAKfH4QnG5arcn63zO4o+sSpIE/mwGYMttEs=
Received: by 10.227.147.79 with SMTP id k15mr766090wbv.128.1279746577233; Wed, 
	21 Jul 2010 14:09:37 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Wed, 21 Jul 2010 14:09:17 -0700 (PDT)
In-Reply-To: <AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151418>

On Wed, Jul 21, 2010 at 4:36 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Jul 21, 2010 at 19:56, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
>> No amount of bugfixing in git submodule can fix this workflow, becau=
se
>> it's not a result of bugs. =A0(The bugs, particularly the
>> disconnected-by-default HEADs on submodule checkouts, do make it a b=
it
>> worse :( ) =A0It would require a fundamental redesign to make this w=
ork
>> nicely with submodules.
> [...]
> I think most of those can be fixed, actually. The only requirement
> that the git plumbing imposes on git-submodules is that a "commit"
> entry exist in your tree, the rest is just (ugly plumbing).

Sure.  But this commit object (and the objects it points to) are never
automatically pushed, fetched, or fsck'd.  They're second class
citizens.  As it turns out, this was a major design mistake in
implementing the submodule commit objects.

All the behaviour people *currently* get from submodules could have
been obtained without using a new 'commit' object type at all.  Just
add a commitid to the horrible junk (including repo URLs, argh) that
already needs to get pasted into .gitmodules, and have git-commit at
the top level update .gitmodules automatically (as it currently
updates the 'commit' tree entries).  Problem solved (at least, solved
to exactly the extent that it is today).

What we *really* want is a way to have git actually recurse through
commit objects when doing *any* operation, as if they were tree
objects.  If we had that, submodules could be beautiful (because you'd
push them to the same repo, etc and users would see none of the
complexity).  But this doesn't exist.  And for backward compatibility
at this point, we'd probably need to introduce an entirely new kind of
tree entry to support such a thing.

> Thus, we could:
>
> =A0 * Hack git-submodule (or its replacement) to check import the tre=
e
> =A0 =A0 that contains that "commit" into one central .git

This part is relatively easy, I think - at least in concept, although
I bet there would be widespread implementation tweaks - and would
clean up a lot of the mess.  However it would require a change to the
=2Egit/index file format to remember when a subdir is a commit and not =
a
"normal" tree so that it doesn't silently commit the next thing as a
tree instead.

> =A0 * Fix git status / git commit so that you could commit into
> =A0 =A0 submodules, i.e.:
>
> =A0 =A0 for each submodule in this-commit:
> =A0 =A0 =A0 =A0 chdir $submodule && commit
> =A0 =A0 done && cd $root && commit -m"bumping submodules"

After making the earlier change to get rid of the extra .git subdirs,
this next requirement would actually be considerably more work,
because 'git commit' would need to know how to update a subcommit
without changing HEAD.  You certainly couldn't just code it up as a
recursive "git commit" as you imply (and as you could do right now).

> =A0 * Make git-push push the submodule contents and the
> =A0 =A0 superprojects. You'd just need to have commit access to the u=
rl
> =A0 =A0 listed in .gitmodules.

This is really a *killer* problem, and you're making it sound easy.
Let's imagine that my app has 25 different submodules - not
unreasonable at all in a world with dozens of ever-changing ruby gems
and suchlike.

Now, if I want to branch my project, I might have to branch 25
projects just so I can push my changes?  It's totally awful.  And the
awfulness is multiplied many times over if .gitmodules has hard-coded
repo paths, because then I have to update the repo path in my branch
but not the other branch, and merging will have conflicts.  You might
think that my .git/config could just override .gitmodules, but then
some guy trying to fetch my branch will fail to fetch the submodules
from my branch and get errors and have no idea what's going on.

And you might think that using relative repo paths in .gitmodules
would work, but that's only if I branched all 25 submodules in the
*first* place.  In real life, most subprojects point at the original
project's home repo by default (because nobody thinks they'll be
patching 25 subprojects when they start, and they're probably right),
but then you have to individually change the URLs when you decide you
need to patch them, and life gets complicated and ugly, especially
when the next guy goes to fork your project and now needs to fork some
subprojects but not others.

There is no good solution to the submodule problem if each submodule
has to go in its own repo.  I've been thinking about this for years
now, and watching lots of discussions about it on the git mailing
list, and I just can't see any other option.  All the submodules have
to get pushed to and fetched from the same repo by default.  Anything
else is insane.

One option might be to store the submodule commit refs as refs in your
superproject.  That wouldn't actually be so bad, except for the
aforementioned problem that fetch/push/clone/etc don't actually trace
through commit objects when deciding what objects to send you, so
fetching the ref of the superproject wouldn't autofetch the subproject
refs.  Also, you could accidentally delete one of the subproject refs
and lose tons of history without ever realizing it.  That's error
prone and confusing... and clutters up your repo refs list with
administrative stuff you didn't actually want in the first place.

> What's missing from that (which would be nice) is the ability to chec=
k
> out a subdirectory from another repository. That could (I think) be
> done by just adding a normal "tree" entry, and then specifying that
> that tree can be found in git://... instead of the main tree.

Actually that's already easy with submodules (and git-subtree makes it
easy too, though slightly different).  Just fetch the commit from the
other repo, and do:

   git checkout FETCH_HEAD -- subdirname

>> If we can get some kind of consensus in principle that git-subtree i=
s
>> a good idea to merge into git core, I can prepare some patches and w=
e
>> can talk about the details.
>
> From having looked at it briefly it looks very nice. But it looks to
> me as if the main differences between git-submodule and git-subtree
> are in the porcelain, not the plumbing.

No.  The fundamental difference is exactly one: git-subtree uses
normal 'tree' entries (rather than commits) in its trees, so that all
the git tools recurse through them like any other tree.  Thus you
don't need any extra refs, extra .git dirs, etc.  That allows you to
bypass all the useless behaviour git has around 'commit' entries.
This is very much a plumbing difference.

The git-submodule porcelain happens to independently be kind of
annoying and inconvenient, but that would be much easier to fix if it
weren't for the plumbing-related problems.

> It would be a lot less confusing to users of Git in the long term if
> we would at least try to unify these two approaches instead of having
> two mutually incompatible ways of doing essentially the same thing.

True.  But I don't have the time, and implementing the new 'commit'
entry semantics sounds like a lot of work (as opposed to arguing about
them, which I guess I'm good at but which seems unproductive).

In productive terms: git-subtree is solving problems for real users
right now.  It might solve more problems for more users if it were
integrated into the core and thus made "official."  Nothing precludes
making submodules better later.

Have fun,

Avery
