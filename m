From: Daniel Thomas <drt24@cam.ac.uk>
Subject: Re: [GSoC Proposal/RFC] Rolling commit message writing
Date: Tue, 30 Mar 2010 23:34:37 +0100
Organization: Cambridge University
Message-ID: <1269988477.17964.49.camel@dell-desktop.example.com>
Reply-To: drt24@cam.ac.uk
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-uYTFnoKYSuxBaZgunZZZ"
Cc: Avery Pennarun <apenwarr@gmail.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 31 00:34:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwk1N-0001xr-Vh
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 00:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360Ab0C3Wel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 18:34:41 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:45224 "EHLO
	ppsw-1.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab0C3Wek (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 18:34:40 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from [95.145.194.214] (port=56447 helo=[192.168.1.71])
	by ppsw-1.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.151]:465)
	with esmtpsa (PLAIN:drt24) (SSLv3:DHE-RSA-AES256-SHA:256)
	id 1Nwk18-0007F9-5m (Exim 4.70)
	(return-path <drt24@cam.ac.uk>); Tue, 30 Mar 2010 23:34:39 +0100
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143613>


--=-uYTFnoKYSuxBaZgunZZZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I reworked my proposal a bit before submitting it based on feedback I
got in #git. The version I submitted is included at the end. First I
will try and address the points raised.

        On Sun, Mar 28, 2010 at 3:32 PM, Daniel Thomas <drt24@srcf.ucam.org=
> wrote:
        > Currently it is fairly easy to write good commit messages but the=
 effort
        > that this requires of developers can be reduced still further.
        >
        > This would be achieved by adding a built in system for working on=
 a commit
        > message during the stage of adding changes.
        >
        > Currently this can be done manually using "-F <file>, --file=3D<f=
ile>" in git
        > commit but we can do better than that. Specifically changes to gi=
t add
        > [--interactive | -i] to add an 'am' or similar command to allow a=
dding a
        > file and then prompting for a message about the changes to that f=
ile. Also
        > changes to git add [--patch | -p] to add 'm' and 'c' options to g=
it add
        > --patch to allow the addition of a message for the current hunk (=
'm') and to
        > do a commit (prompting for review) before returning to the hunk c=
urrently in
        > focus ('c').
       =20
        The extra prompting seems to me like it would slow down the process=
 of
        'git add -p' by making it take too many steps.  Normally when I cre=
ate
        a commit, I like to think of "which lines will I commit?" and "what=
 is
        the description of the whole commit?" as separate questions, wherea=
s
        this workflow would interweave the two and confuse me.

This would only optionally interleave the two as this would be adding
new options and not changing old ones.
       =20
        Secondly, I'm concerned that if you can't remember the description =
of
        your entire commit by the time you commit it, then your commit is t=
oo
        big.  The usual solution is to create multiple, smaller commits tha=
t
        are easy to describe.  If at the end you find yourself with too man=
y
        commits, you can always join them together with git rebase.
       =20
Yes however if each commit is endeavouring to ensure that it takes the
source tree from one consistent state to another then occasionally
commits have to be slightly larger. Of course a series of small
inconsistent commits can be made and then git rebase can be used to
stick them together and to write a new commit message. This would offer
another method of doing it which would hopefully be useful in some cases
such as when as Jonathan Nieder mentioned the user wants "I like =E2=80=98g=
it
diff --cached=E2=80=99 and =E2=80=98git diff=E2=80=99 to show the entire li=
st of staged and
unstaged changes.". However I can see how it could be considered wrong
to not commit early and often and that my desire for atomic commits
could be a hangover from older VCSs.
       =20
        You might also like 'git commit -v', which shows the actual diff to=
 be
        committed as part of your default commit message.  Then you can wri=
te
        your message while looking at it, making it easy to describe exactl=
y
        what you changed.

Though useful, this doesn't work so well when the diff is larger as
looking at the diff while writing the commit would result in a lot of
scrolling.

        Given these existing capabilities, is it still worth adding the
        feature you propose?
       =20
I would hope that it is, however see below.
               =20
        On Tue, Mar 30, 2010 at 10:32 AM, Jonathan Nieder <jrnieder@gmail.c=
om> wrote:
        > I like =E2=80=98git diff --cached=E2=80=99 and =E2=80=98git diff=
=E2=80=99 to show the entire
        list
        > of staged and unstaged changes.  I don=E2=80=99t consider this =
=E2=80=9Cwrong=E2=80=9D
        at all.
       =20
        On a related note, my workflow is somewhat similar: I just use
        Magit
        within Emacs, which essentially does the same thing. The staging
        area in Git really helps me organize my work, and I wouldn't
        mind attaching a small note to it that I can refer to while
        writing my commit message (much like Jonathan's idea). However,
        I don't think this task is large enough for an entire GSoC.
       =20
Ahh.
       =20
        Also, I'm positively opposed to the idea of a complex
        interactive
        command-line interface. If someone *did* want that kind of
        complexity/interactivity, they ought to use something like
        Magit: a cli can't even come close.
       =20
I changed the focus in my revised proposal so that the cli interfaces
are emphasised less with the focus being on the backend for storing and
modifying the in progress commit message. The CLIs just test the API and
provide mechanisms which some people might find useful.

On Tue, 2010-03-30 at 13:27 -0400, Jeff King wrote:=20
> However, I am really concerned with it as a GSoC project. It just
> doesn't seem like a big enough feature to take the whole summer. In the
> schedule, there is a week of implementing "git add -p
> --add-with-message". It seems like that should be hours, not days.
>=20
> I wonder if it could be rolled into a more comprehensive proposal
> concerning commit workflows (though I admit, I don't personally have any
> other ideas in the area).
>=20
> -Peff

Ahh ok, I will do something else then.

> PS Daniel (and other potential GSoC'ers who are reading), please don't
> take this as discouragement of presenting proposals that aren't on the
> ideas wiki. I really really like the concept of somebody working on
> their own itch, as I think they tend to have a clearer idea of what the
> solution should look like. I'm just concerned this particular proposal
> isn't big enough.

Thank you. Maybe if I don't find something else to do this summer I will
implement this instead outside of GSoC.


Thank you everybody who commented on my proposal, it was a good learning
experience.

Thank you everybody who has contributed to git for making it so awesome.


Best regards,

Daniel


Begin proposal:

=3D=3D Project Goals =3D=3D

=3D=3D=3D What is the goal of your project? =3D=3D=3D
To make it easier for developers to write good commit messages.=20

=3D=3D=3D What you are going to try to accomplish with your project? =3D=3D=
=3D
Currently it is fairly easy to write good commit messages but the effort
that this requires of developers can be reduced still further.

This would be achieved by adding a built in system for working on a
commit message before the commit itself.

Currently this can be done manually using "-F <file>, --file=3D<file>" in
git commit but we can do better than that. This projects involves making
a built in system for persistently storing commit messages while they
are in the process of being written. Then modifying various git commands
to use this specifically changes to git add [--interactive | -i] to add
an 'am' or similar command to allow adding a file and then prompting for
a message about the changes to that file. Also changes to git add
[--patch | -p] to add 'm' and 'c' options to git add --patch to allow
the addition of a message for the current hunk ('m') and to do a commit
(prompting for review) before returning to the hunk currently in focus
('c').

=3D=3D=3D How would you measure its success or failure? =3D=3D=3D
* The creation of a good persistent storage mechanism for storing commit
messages while they are being edited=20
* The creation of a good API for editing commit messages for work that
is in the process of being added for commit.
* The integration of this API with currently existing CLI tools such as
git add so that it fits seamlessly with developer's workflow.
* The modification of existing documentation to properly reflect this
change.
* The addition of any additional documentation on how to use this new
feature.
* The addition of thorough testing of this feature to 'git.git/t'.
* Compliance with SubmittingPatches and CodingGuidelines.
* Work should be undertaken with careful communication with the
community.

=3D=3D=3D The project in more detail. =3D=3D=3D
A backend for storing the commit message that is being worked on,
probably using a file called COMMIT_NEXTMSG in .git/ (following the
standard set by COMMIT_EDITMSG). With a file format for describing the
commit message, this would be a normal text file but with the use of
"/path/to/file.extension:[line number | line-range:] <detail about this
part of the commit>" to store the various bits of commit message as they
are added. Since using a simple COMMIT_NEXTMSG file would not work
across 'git stash' and branch-switching it would probably need to be
attached to a object using git notes. Fortunately it is probably
possible to use the current HEAD when branch switching and to use the
'W' commit of the working tree when using git stash.

Teaching 'git commit' about this so that it appends the contents of this
file to the commit message supplied at the next commit if '-m' is used
or if [-n | --nextmsg] is used then it just uses the contents of the
file (of course [-e| --edit] would allow this to be subsequently edited.

Teaching 'git commit' --rolling or something similar which would open
COMMIT_NEXTMSG in $GIT_EDITOR.

Teaching 'git add [-i | --interactive]' an 'am' or similar command for
'add and prompt for message' (with care to not spoil the current
interface.

Teaching 'git add [-p | --patch]' the 'm' and 'c' commands for adding a
message about the changes in the current hunk and for committing changes
added so far after being shown 'git status' being prompted as to whether
the user wishes to continue (y/n) where 'y' shows the commit message in
GIT_EDITOR such that writing from that commits and returns the user to
the hunk they were looking at and 'n' takes them straight back to the
hunk. This makes it easier to separate out multiple atomic changes from
a file.

=3D=3D=3D=3D Use cases =3D=3D=3D=3D
Philip is making an atomic commit that touches several files and wants
to be able to add to the commit message for each one while the changes
he made are still fresh in his memory but doesn't want to do a commit
for each change as then the project won't compile for some commits.

Andrew has been hacking on a file and made lots of changes in various
places in the file. These changes should be split up into atomic commits
which 'git add --patch' makes easy, however it would be even faster if
when looking at hunks to add them the commit message could be edited as
this is faster than the two pass add hunks, exit 'git add --patch', run
'git diff --cached' and in a separate terminal write the commit message.
Hopefully this means that Andrew will be more likely to split his
changes into atomic commits rather than just adding the file containing
multiple sets of changes.

=3D=3D=3D Schedule =3D=3D=3D
Create a mechanism for persistently storing the commit message which is
currently being written and an API for modifying it and then write three
different mechanisms which use it in order to ensure that the API works
properly. Having ensured that it works properly from an editing point of
view modify git commit to use it.
* 3rd June begin work in earnest: (my last exam is on this day).
* 9th June finish first version of backend and API.
* 15th June finish writing tests on backend and API and any changes
suggested by the testing or after reveiw.
* 22nd June finish teaching git commit --rolling
* 28th June finish teaching git add [-i | --interactive] the 'am' (add
with message) command.
* 9th July finish teaching git add [-p | --patch] the 'm' (add with
message) command.
* 12th July mid term evaluation
* 16th July finish teaching git add [-p | --patch] the 'c' (commit with
edit returning here) command.
* 26th July finish teaching git commit [-n | --nextmsg] and to use the
COMMIT_NEXTMSG if available.
* 2nd August write lots more tests on everything implemented so far.
Ensure that all known bugs are properly fixed. Make any changes
suggested.
* 9th August check all the documentation and make all the necessary
changes. Write any more additional pieces of documentation necessary
e.g. tutorials.
* 9th August suggested pencils down deadline.
* 16th August firm pencils down deadline, finish rechecking all code,
documentation, tests and submitting patches to the mailing lists. Write
final evaluation.
* 20th August final evaluation deadline.
* Continuing: provide any necessary support for these changes and fix
any bugs that are found subsequently. Continue lurking on the mailing
list and #git. Help with the continued development of git.

=3D=3D Interfaces =3D=3D

=3D=3D=3DWhat parts of Git will you need to call?=3D=3D=3D
* editor.c
* strbuf.c
* string-list.c
* git show
* git notes
* Those files which I am also modifying, see below.

=3D=3D=3D What parts of Git might you need to change? =3D=3D=3D
* git-add--interactive.perl
* commit.c
* builtin/{add.c,commit.c}
* Documentation/{git-commit.txt,git-add.txt}
* t/{t750?-commit*,t370?-add*} (probably just adding new files)

=3D=3D About You =3D=3D

=3D=3D=3D Projects that I have worked on =3D=3D=3D

Last term I worked on the quebec project for my group project which is
part of my University course. This can be seen here:
https://www.srcf.ucam.org/quebec/tomcat/quebec/ and the code is here:
https://www.srcf.ucam.org/quebec/quebec-0.1.tar.gz though it is not
really in a fit state for use by anyone else and we never got around to
talking about licenses. I wrote the User Management system, and ran the
server (tomcat), version control (SVN after a vote by the group which
had in general not used VCSs before) and unit testing (junit4). I also
rewrote part of the comms system and wrote a test client for it. This
project was also in Java. We did a lot of communication in person but we
also used Google wave and Google docs. There were five developers in my
group and we had a client from IBM.

Last summer (2009) I worked on the second iteration of the
ReadYourMeter.org project (which is still in development) I wrote
8.7ksloc of Java and GWT. This code is available under the GPL v2 but
since we haven't done a release yet it isn't linked to from anywhere. I
was the only developer on this project, I communicated with my
supervisor both in person and via email.

In Christmas 2008 I wrote a simple command line
[https://www.srcf.ucam.org/~drt24/blog/2008/12/10-release-of-fractals/
fractal image generator] in SML for my own amusement.

In February 2007 I contributed a couple of minor patches to the
Worldforge.org project (in python). Most communication was done on
#lounge on irc.worldforge.org, but I also used the mailing list
(particularly for the submission of patches). I had CVS commit rights
but they have subsequently moved to Git and I have only been lurking on
their mailing list since the summer of 2007.

[https://www.srcf.ucam.org/~drt24/onlineCVdrt24.pdf My CV.]

=3D=3D=3DDo you have any prior Git experience?  Have you started to get
involved?=3D=3D=3D

I have been using Git for over a year for various personal projects
ranging from academic work and projects to websites I have worked on for
various people. I have 18 repositories on my local machine. I haven't
used it in a multi-user manner as in general it has been just me working
on these projects in git.
I have pulled git.git and successfully compiled and installed it (which
was pleasantly easy), I also ran the tests in git.git/t which seemed to
go as well as it was supposed to.

I have been lurking on #git for a few days now and I have tried to
provide support where I could for those questions which were asked when
I was watching. I have joined the git mailing list and while I haven't
been reading all the emails I have been reading a selection of them.

If accepted I would send a weekly progress report to the mailing list
(unless people would object to that). I would ensure that I regularly
pushed my changes to somewhere public so that anyone interested could
look at them. I would ensure that I listened to advice given to me and
acted upon it. I would start submitting patches to the mailing list as
[PATCH/RFC] once I have finished a section of work to allow anyone to
make suggestions on how to do it better early on in the project. I would
also remain on #git and increase the proportion of mailing list emails
which I read.

=3D=3D=3D Prior contact with the Git community =3D=3D=3D

I talked to
[http://colabti.org/irclogger/irclogger_log/git?date=3D2010-03-23#l2369
'Paradox' and 'charon' about this on #git] after 'Paradox' had asked if
something similar was available.
'charon' mentioned that 'git commit --amend' can be used to amend the
last commit message and that 'git commit --amend --only' can be used to
amend the last commit message even once the index has become dirty due
to preparation for the next commit. Alternatively 'git rebase
--interactive's squash feature could be used to do something similar
however I prefer to avoid rewriting history unnecessarily and I think
that this project would make it far easier than using git commit --amend
--only and avoids problems with changes which have been pushed to a
remote repository.

I posted a link to this proposal to the mailing list on the
[http://article.gmane.org/gmane.comp.version-control.git/143418 28th
March] and to #git on the
[http://colabti.org/irclogger/irclogger_log/git?date=3D2010-03-28#l1863
28th] and
[http://colabti.org/irclogger/irclogger_log/git?date=3D2010-03-29#l2266
29th] of March.

--=-uYTFnoKYSuxBaZgunZZZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkuyfHMACgkQsvsUzxjrg7ErrwCfeA+XanCecW7RHHsQr/2LpJAW
mAUAn0cTPIkdPaq7F49kgtQJVewtrUbE
=wC3K
-----END PGP SIGNATURE-----

--=-uYTFnoKYSuxBaZgunZZZ--
