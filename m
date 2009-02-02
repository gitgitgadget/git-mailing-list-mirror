From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: Comments on "Understanding Version Control" by Eric S. Raymond
Date: Mon, 2 Feb 2009 15:24:24 -0500
Message-ID: <20090202202424.GG14762@mit.edu>
References: <200902021948.54700.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 21:26:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU5Mj-0002AA-Ig
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 21:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbZBBUYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 15:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbZBBUYb
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 15:24:31 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:56763 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753159AbZBBUY3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Feb 2009 15:24:29 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n12KOPXX026891;
	Mon, 2 Feb 2009 15:24:26 -0500 (EST)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n12KOOCg019811
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 2 Feb 2009 15:24:25 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1LU5LE-0005DP-DF; Mon, 02 Feb 2009 15:24:24 -0500
Content-Disposition: inline
In-Reply-To: <200902021948.54700.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108117>

On Mon, Feb 02, 2009 at 07:48:53PM +0100, Jakub Narebski wrote:
> In my opinion the most important issue is concentrating on "container
> identity" instead of on the underlying issue of renames in version
> control, which includes intelligent, rename-aware merge; talk about
> issues and not about possible solution.  I will concentrate on this
> issue for now, and leave for example issue of workflows, and of VCS
> history for possible later posts (it is long enough as is).

This was discussed in no small amount of detail on the mailing list
uvc-reviewers, which used to be hosted here:

	http://thyrsus.com/mailman/listinfo/uvc-reviewers

Unfortunately, it looks like Eric has taken down his mailman instance
on thyrsus.com.  I have personal archives of the list, and the list
used to be have public archives, so I don't feel any hesitation
sharing it with interested parties.

> Below you can find my comments; quoted fragments of "Understanding
> Version Control' essay are prefixed with 'UVC> '.  'TODO' refers to
> http://www.catb.org/esr/writings/version-control/TODO.html
> 
> Please do participate in this discussion, especially if you have
> something to say with respect to rename detection versus rename
> tracking issue.  Thanks in advance.

Heh.  A lot of this has been said already.  I think one of the reasons
why Eric kept things short in his paper, and did *not* say a lot about
whether or not container identity tracking was fundamentally needed or
not was because we didn't come to any real consensus on the
uvc-reviewers mailing list.  I believe it is extremely difficult to do
so given that it's very hard to avoid the slippery slope of advocating
for one SCM system versus another.

I'll include some of my writings on the subject from the uvc-reviewers
mailing list so folks can see where some of this discussion went last
time...  (All of this dates from January, 2008, when Eric was last
aggressively updating the paper in question.)  BTW, when I referred to
SCM's being a horrible hack and "guessing" and "fit only to be used by
amateurs" if they didn't record function-level identity tracking,
there were those who were seriously arguing that any SCM (i.e., like
git) that didn't track container identity was fundamentally a "hack".
Yes, there are people who seriously take that view, some of which were
very bitter that their DSCM didn't win the market/popularity wars, and
so their pet projects overtaken by SCM's such as git, describing
$THEIR_PET_SCM_WITH_PROVABLY_CORRECT_SEMANTICS as Betamax, and git as
VHS.  The argument that without rename-tracking, if git was used to
development an software for Air Traffic Control application, airplanes
could be dropping out of the sky was also made by these advocates, no
kidding.  (So was the argument that using a DSCM that didn't do
container identity tracking might be considered Programming
Malpractice.)

So be careful about wanting to reopen this discussion; if the some of
the wrong people join in, you may be very sorry!   :-)

   	     	       	       	    	       	    	 - Ted


> Here then are some types of identity  
> tracking one might imagine:
> 
>    * File identity tracking: tracks the identity of a file through  
> renames and moves.
>    * Simple file content tracking: tracks the identity of content  
> using adds and deletes within a single file.  (Note, there is a  
> question that could be asked here about the resolution of the  
> tracking.  Most current systems that track do so on a line-by-line  
> basis, but one could imagine tracking bytes.  I wont say any more  
> about this in this email.)
>    * Movement of content within a file: tracks the identity of  
> content within a file when lines are moved.
>    * Movement of content between files: tracks the identity of  
> content when lines are moved between files.

One obvious one which isn't in this list is "Directory Identity
Tracking", that is when you move a directory, new files which are
created in one branch at the original directory location will be moved
when you merge with another branch where the directory has been moved.

In private conversations with Tom Lord, he tells me that he had also
played with the concept of "Function/variable (more generally,
programming structure identifier) identity tracking".  That is,
suppose you had an editor like Eclipse which has as a primitive,
"Rename Java identifier (class/method function/variable)", and this
information was passed into the SCM so it could be tracked.  Then in
one branch, a Java identifier could be renamed, and then in another
branch, the use of that same Java identifier could be added in 20
different places --- and since the SCM knows, at a deep semantic
level, that a rename had taken place in Branch A, when it is merged
with Branch B, it could DTRT and change the newly added uses of the
renamed identifier to its new name.

And like with Directory Identity Tracking, it's not hard to come up
with scenarios where without this level of tracking, something
horribly wrong could take place as a result of the SCM not tracking
function identities and using them when doing merges.  At the very
least, the program would fail to compile, and if the example involved
an Air Traffic Control system and multiple function renames taking
place, you could even come up with a contrived horror scenario where
planes would be falling out of the sky --- that is, if you ignore
regression testing, and simple coding practices that would prevent
something like this from happening.

Of course, the flip argument by people who are trying to promote their
brand-spanking new SCM that did function identity tracking (FIT) is
critical since SCM's are all about ACCOUNTING, and without FIT,
systems that try to merges are just GUESSING, and *obviously* a system
which did FIT is far superior to a SCM that didn't; in fact, a SCM
that didn't do FIT is just a Horrible Hack Done By Amateurs.
Furthermore, using an SCM without this feature would (according to
promotors of this hypothetical new SCM), be Programming Malpractice.

And if this sounds silly, I'm just repeating the exact same arguments
that proponents of systems like arch, Bk, et.al, which store the user
intention information of file and directory renames, have recently
advanced against git since it doesn't store this sort of information.
(It may reconstruct rename information in a lazy fashion when it is
needed, but it doesn't store it.)  But if file and directory renames
is a type of user intention which MUST be stored in order for an SCM
not to be a hack, why not function, variable, and class renames?  That
too would be another type of user intention.

	 	     	    	     	  - Ted

---------------------------

> The second could be called "location".  Which file should this patch  
> be applied to?  Which lines within a file should this hunk be applied  
> to?  I argue in [2] that Darcs does strictly better at the task of  
> location than do SVN or GNU diff3.  (I think that SCCS, BK and CDV do  
> as well, but I don't understand them well enough to be sure.)  I  
> argue that Darcs does strictly better in the sense that its answers  
> to the location question are often better and never worse, and that  
> it does so *not* by having a more sophisticated heuristic or by  
> getting lucky more often, but by a simple, provably-correct algorithm  
> which uses valuable information that other algorithms overlook.

How are you defining "provably correct"?  In order to show
correctness, you need to define what correctness means.  

One approach is that you force the user to tell you --- and if you are
in the middle of applying a series of 500 patches, you throw up the
Annoying GUI Dialog Box which stops the application of patches dead in
its tracks, and force the user to confirm whether this is a rename, or
a delete followed by an add of remarkably similar content.  Or, if
patch removes all the files from one directory, and created them all
in another directory, that what was the user intention was a directory
rename, and the SCM records it as such.  Here, you are *assuming* that
what the user tells you is correct, and that's part of the lemma you
use for proving correctness.  If the user, who is seriously annoyed at
the popup boxes, says, "Yeah, yeah, yeah", and dismisses the dialog
box without changing the defaults (which were selected via a
hueristics and which were wrong), well, it's not the SCM's fault since
the user told it what it wanted, and the user was wrong.  GIGO.

In your case, you're saying that Darcs is using "valuable information"
that other algorithms overlook.  OK, so the Darcs people were more
clever about designing a hueristic which tries to approximate user
intention, and having designed the hueristic which uses said "valuable
information" you can prove whether or not Darcs' algorithm correctly
implemented said hueristic.

But at the end of the day, it's still a hueristic, and the use of
words "provably correct" is just a semantic trick.  Even svn's lack of
directory rename support could be considered "provably correct", if
the definition of "correct" is an algorithm which determinically
creates new files in their original location, even if all other files
in that directory were deleted and new files with the same name and
same content were created somewhere else.  It's still an algorithm,
and you can prove whether or not it meets its design specs, but to the
extent that it is less likely to approximate user intenions, people
would say that svn might be less useful in such cases than some other
SCM.

> Let's be careful not to lump these three things together, say "All  
> merging involves guessing.", and thus overlook the interesting fact  
> that some merge algorithms involve strictly more guessing than do  
> others.

Part of the problem is that words like "guessing" and claims of some
algorithm being "provably correct" are basically marketing words.
They are generally used to denigrate one SCM, and promote someone's
favorite SCM as being **better**.

Fundamentally, the goal of merging is to Do The Right Thing --- from a
semantic point of view, which means that the user's intentions is
what's important at the end of the day.  The question then is whether
you record the user's intentions, or try to determine it in from a
hueristics point of view.

The people who claim that recording the user's intentions is superior
will claim that you can never know for sure what the user meant, so
you have to ask him or her to provide that information.  In some cases
that's relatively easy; you require the user to use commands like "bk
mv" and "bk cp" and "bk rm" which not only performs the function, but
also records the user's intention.  Unfortunately, if you are applying
a patch, and the patch file hasn't been enhanced to carry this kind of
information, you have to use hueristics and then somehow get the user
to confirm them --- hence the use of the Annoying Popup Dialog Box.

In other cases, you can't determine it easily, such as the "rename a
Java method function" case, unless you have a specialized editor which
has this as a primitive, or, alternatively, even more Annoying Dialog
Boxes that pop up as you try to commit a change.  Once you have
recorded this information, using it in the merge is relatively easy
--- or if not easy, at least relatively easy to specify and then show
whether or not the information was used correctly.

What then tends to happen is that people whose SCM does one kind of
user intention recording (such as file renaming) will use this as a
huge club to say their system is better than another system, and that
a system which doesn't record this information is "Guessing".  They
will also say that their system is "Provably Correct".  So both of
these words are really Red Meat Marketing words, which get used when
people try to say that Their SCM Is Superior.

On the flip side, the people who don't do any recording of this
information will point out that trying to record the information is
hard, especially when changesets go through a lossy medium, such as
patch files which are e-mailed around, which doesn't record this kind
of user intention.  This may or may not applicable for a particular
project, but for some projects, it is extremely important, especially
for those where e-mail is the primary communication channel and how
patches get reviewed and passed around.

The other point which people on "we don't record user intentions; we
just record content" tend to use is that you can always add more
hueristics later, but in practice, if you didn't record the user
intention when you made the commit, it's almost impossible to add it
later.  So for example, suppose git, which doesn't have function
rename support today, has a new merge engine added later which works
specifically for Java files that correctly intuits and deals with
method function renames.  (Maybe some crazy Java programming
methodology does this all the time, so people get motivated to write
such a thing.)  A SCM which works on recorded user intentions will
need to add that support, in a way which doesn't break backwards
compatibility of their distributed repository, *OR* accept the fact
that for function renaming, it will have to use hueristics that are
run at merge time.

So this seems to be fundamentally a tradeoff.  The two *objective*
things that can be said is how many user intentions are recorded at
commit time (file rename?  directory rename?  function/variable
rename?), and what sort of information is used at merge time via
hueristics to determine user intention.  And if you want to call those
hueristics an "algorithm" because it sounds more mathy and provable,
sure, whatever.  The fact is, the algorithm is still an approximation
on trying to determine user intent, with the goal of making the merge
do the right thing from a Semantic Point of View.

				* * *

>From a project point of view, how often you actually *do* merges is an
interesting one.  If merges requiring complicated user intention
tracking is necessary don't happen very often, maybe focusing on
this issue to the extent that SCM geeks tend to do isn't very
productive.  In my opinion, the overall usability of the system is
*far* more important.  In the OSS world, every project is competing
for programmers, and if the tool is easier to use, the more likely it
will be that you can get people to contribute to your project.  Even
if they aren't bright enough to work on the core algorithms for your
project, they could at least improve the documentation.  That was what
drove my decision to switch to Mercurial back in 2005.  Last year, I
moved my projects to git because of various features that worked well
with my development workflow and which generally improved programmer
productivity.  Whether or not file or directory renames were being
tracked in the SCM had *no* bearing on my decision to switch, because
merges happen rarely, and I have an extensive regression test suite
which I run after almost every commit, and *definitely* after every
merge.  So if a merge doesn't do the right thing, that's OK; I'll fix
it up, and use "git commit --amend" correct the merge commit.

And yet, people seem to focus on recording of user intention because
it reflects some holy grail of Perfection and Correctness.  And maybe,
because it is easily measurable, whereas usability and improving
programmer productivty are inherently more subjective measures.
What's very sad are the people who are feel profoundly hurt that they
spent a huge amount of their life working on SCM Correctness, only to
find that people chose other SCM's based on other metrics and other
issues other than the one that they felt was most important.
Unfortunately there's not a lot that can be done about that.

		      	       	      - Ted
