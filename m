From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH v2] git checkout -b: unparent the new branch with -o
Date: Fri, 12 Mar 2010 13:45:17 -0300
Message-ID: <55bacdd31003120845kc980d16s1e6006d56d6f923a@mail.gmail.com>
References: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com> 
	<7vr5nqrpyg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 17:45:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq7zc-0005zg-5D
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 17:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757843Ab0CLQpj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Mar 2010 11:45:39 -0500
Received: from mail-px0-f198.google.com ([209.85.216.198]:38916 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756976Ab0CLQph convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Mar 2010 11:45:37 -0500
Received: by pxi36 with SMTP id 36so728707pxi.21
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 08:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SAxCG3cLsqu5E/Iq5M8Rs6UtbqvfHKzBSllzmA3zqJc=;
        b=ommO7QzcreDImi53k51+hMoKk/9/dOPZl2ncWmtJP//bmSIKAtpU4dH98MNvthoYSP
         62NNosvaTaWNfFUT5KEAuwNOYbRTb7RAYWLJwygb1yMZ85f649GtNMnKf8n7EBm4dVha
         g0AivZ85JBTaX4eqxQhxnbixLwe2u8UOctCUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dX4sQ1OCN9BLIc3TiPg2hb6oM+uuPip2BoYPokNBVUhh3ZYxJ/oTi6lx91PZqzmQZH
         z/pl9gr/Z/971k+02OePoFQqNkXnXqxM0XHzbeF7lBCtPTJE3HTe3j5gSiQwuNIAoYHP
         4MkbwbQ7COK17TzT8FfRXIciwTkC/rUvwM2Tk=
Received: by 10.140.255.13 with SMTP id c13mr3245685rvi.152.1268412337389; 
	Fri, 12 Mar 2010 08:45:37 -0800 (PST)
In-Reply-To: <7vr5nqrpyg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142041>

Hi,

Thanks for answering.
I had to write a little in reply so I beg for you patience to read it.

This is a new option and before we start talking about the
implementation we should agree about its usefulness and the subjects
addressed by it.

This is something that probably you haven't needed so I understand
your resistance.=C2=A0 In a intense merging software development work f=
low
it would be quite rare to have a merge of an unrelated branch.

But not all of the software developments happen under this work flow.
There is a lot of very small projects.=C2=A0 Being developed by a few
people or even by one person.=C2=A0 And those softwares count too.=C2=A0=
 They
could become very important for everyone some day.

=46or those it is very common to:

* Do some parallel development.
* Working under unrelated parts before merging the start point of the
new software.
* Recreate history.=C2=A0 It is not published yet so it is not being wi=
dely
cloned and people just
  want to have a good repository before publishing;
* Adding files which is not meant to be part of anything in a temporary=
 fashion;
* Have different approaches starting different sources from those
software versions until you
  find out the best one.

Git is becoming much more used than it was planned to be.=C2=A0 It is e=
ven
being used nowadays for other exotic jobs like regular file
versioning.

Those needs are nothing new.=C2=A0 If you query Google for "new empty
branch git" you will find that people have been querying it for.

There are a lot of ways to have the unrelated branch: you could start
a new repository and import from it; you could foresee that you will
need something like that and start all development with an empty
commit, ...

But the proposed solution is the best approach.=C2=A0 And it is the one=
 I
use when needed.

This new option is not a new solution.=C2=A0 Just a direct implementati=
on
so people will not need to know this hack.=C2=A0 See it:

Git SCM Wiki:
http://git.wiki.kernel.org/index.php/GitTips#How_to_create_a_new_branch=
_that_has_no_ancestor

Git Book:
http://book.git-scm.com/5_creating_new_empty_branches.html

After all said let's face the implementation.

2010/3/12 Junio C Hamano <gitster@pobox.com>
>
> Erick Mattos <erick.mattos@gmail.com> writes:
>
> > @@ -25,6 +26,10 @@ linkgit:git-branch[1] were called; in this case =
you can
> > =C2=A0use the --track or --no-track options, which will be passed t=
o `git
> > =C2=A0branch`. =C2=A0As a convenience, --track without `-b` implies=
 branch
> > =C2=A0creation; see the description of --track below.
> > +When using -b, it is possible to use the option -o to set the new =
branch
> > +as unparented thus unrelated to the previous branch. =C2=A0The new=
 code will
> > +be committed by using 'git add' and 'git commit' as if it was an i=
nitial
> > +commit.
>
> This says what the option does, but it is hard to guess why it would =
be a
> good thing to do in the first place from the above description.

So you would like to have some examples on it?
I was trying to let people know how to use it not=C2=A0why to use it.

> The use case in your commit log message wasn't convincing either. =C2=
=A0If such
> a new branch will be merged later, especially if the trees of the com=
mits
> in newly rooted history resemble the trees in the original history (I=
 am
> guessing that is the intended use case, as you do not seem to be remo=
ving
> anything from the working tree---how is the user expected to use them=
 by
> the way?), not having a common merge base will make the merge harder,=
 not
> easier, and later examination of the history (think "bisect") also
> harder.

Are you talking about the commit log message of the previous version
patch? =C2=A0If that is the case I replied to your message explaining i=
t
better (but not trying to convince you).

I am not wiping the tree by default because I am not deciding for
people if they are going to use anything from it=C2=A0as a template (ev=
en
the directory structure only).

I am not trying to make decisions for the user. =C2=A0I think he would =
be
capable of deciding it himself. =C2=A0That is my way of thinking so I
normally prefer to advice, alert, inform not to impose.

We should remember git users are normally programers not some wind... l=
amers.

The intended uses of this option was explained up there.

As it is a new fresh development branch it is not normally expected to
have anything in common with original branch so the future merge is
going to be very easy. =C2=A0Anything exotic is up to the user to solve=
=2E

> This looks like a "because we can" feeping creaturism, without any
> "because it is beneficial if users can do this for this reason"
> justification.
>
> And what it can do "because we can" doesn't look very useful, safe, n=
or
> sane either, with this particular implementation.

Benefits explained up there already.

It is not=C2=A0creaturism. =C2=A0People need this option at various lev=
els.

> > @@ -509,8 +510,13 @@ static void update_refs_for_switch(struct chec=
kout_opts *opts,
> > =C2=A0 =C2=A0 =C2=A0 struct strbuf msg =3D STRBUF_INIT;
> > =C2=A0 =C2=A0 =C2=A0 const char *old_desc;
> > =C2=A0 =C2=A0 =C2=A0 if (opts->new_branch) {
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create_branch(old->name=
, opts->new_branch, new->name, 0,
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 opts->new_branch_log, opts->track);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (opts->new_branch_or=
phan) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 discard_cache();
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 remove_path(get_index_file());
>
> I don't think we want to see "remove_path()" here. =C2=A0The function=
 is about
> the files in the work tree, and not about the files under .git/.
> Currently the codepath to create and write out the index is abstracte=
d
> like this:
>
> =C2=A0 =C2=A0fd =3D hold_locked_index();
> =C2=A0 =C2=A0... populate the_index structure ...
> =C2=A0 =C2=A0write_cache(fd);
> =C2=A0 =C2=A0commit_locked_index();
>
> and by only changing the implementation of these three functions, we =
could
> store the index somewhere other than on the filesystem (say, database=
 or
> memcache). =C2=A0By using remove_path() on the return value of get_in=
dex_file()
> in a random codepath like this one, you are pre-seeding a bug for oth=
er
> people who may ant to make changes like that in the future.

I see your point but what we will be doing is just wiping the index
out. =C2=A0So I did it in a direct fashion.

Please let me know after you read this whole reply if you still
consider this way as inadequate.

> But the above is just an advice on the coding, assuming that what is =
being
> coded is sane, which unfortunately is not. =C2=A0You are nuking the i=
ndex but
> without doing anything to the working tree files. =C2=A0Why? =C2=A0Th=
e user manually
> has to remove them? =C2=A0Or re-add them? =C2=A0I don't think you wou=
ld want to call
> discard_cache() _nor_ remove the index file here. =C2=A0This is proba=
bly even
> more so if you think about a case where the user is using a sparse
> checkout. =C2=A0Some random set of files are still in the working tre=
e but
> other files aren't, and the index used to keep track of which is what=
, but
> you lost that information by discarding the cache.

I have already replied that but let me state it: we will be leting
people start an unrelated branch, unrelated work, fresh new stuff.
And leting them do anything they want with the files in the work tree.
=C2=A0Deleting them as easy as 'git clean -df'.

>
> If you are going to leave the files in the working tree intact, you s=
hould
> make it the user's responsibility to run "git rm -f" after "checkout =
-o",
> if the user wants to start from an empty index. =C2=A0That would also=
 make it
> safer; a mistaken "checkout -o" would be easier to recover from by ru=
nning
> reset without --hard, if it does not touch the index.

It is already very safe and easy to recover by just doing a 'git
checkout PREVIOUS_BRANCH'.

>
> By the way, the worst part of this patch is that I didn't see any saf=
ety
> checks tested in the test script. =C2=A0What prevents the users from =
typing an
> extra -o by mistake, while having some changes to the index and/or th=
e
> files in the working tree? =C2=A0Even if you change it not to touch t=
he index,
> it would probably make sense to make sure this "feature" is a lot har=
der
> to invoke by mistake. =C2=A0In a sane workflow you wouldn't be creati=
ng root
> commits left and right. =C2=A0Perhaps by not giving it a '-o' shortha=
nd would
> be a good start.

I don't quite see your point here. =C2=A0Not letting people use it when
they don't want to use it?!

Like protecting him from typing a letter 'o' at keyboard when creating
a branch with -b and pressing enter after this mistake?!

I really have not get it. =C2=A0Could you please explain it from what w=
e
have to protect him?

>
> In the above I assumed (by guessing from the fact that you are not
> touching files in the working tree) that the tree eventually committe=
d by
> the user on this newly rooted history would have some resemblance to =
the
> trees in the original history. =C2=A0But if -o is intended to be used=
 for
> really "starting from void" with an empty tree, then I think the opti=
on
> should instead do this:

The user could probably use something from the work tree as template
so I am not making assuptions. =C2=A0Just leting him know that with a '=
git
clean -df' =C2=A0everything would be vanished.

>
> This is just style, but I find it easier to read if you have one SP b=
efore
> redirect and no SP between redirect and the filename, i.e.:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo initial >"$TEST_FILE" &&

You are the one that must demand the style so I am going to change it.

>
> > + =C2=A0 =C2=A0 test "alpha" =3D "$(git branch | sed -n "/*/s/\* //=
p")" &&
>
> Don't read from "git branch" in scripts; use symbolic-ref on HEAD.

All right then.

Thanks for you patience to read this email and I hope this effort will
worth something.

Regards
