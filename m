From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Mon, 18 Oct 2010 10:47:05 +0530
Message-ID: <20101018051702.GD22376@kytes>
References: <AANLkTimn99ErpLNfX-Jxn2t6cKCOoKFb91g1_m3TypOf@mail.gmail.com>
 <12137268.486377.1287073355267.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 07:19:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7i7g-0004E6-UX
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 07:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942Ab0JRFRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 01:17:52 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56563 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab0JRFRv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 01:17:51 -0400
Received: by gwaa18 with SMTP id a18so169700gwa.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 22:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=g9AZnmJacNopAh2P+Im6tKqWWmarn9+0QpYP//+a5Ag=;
        b=ImD+Uoiw9k2p3NcUr9h7I9IXeGVFFd3N9uM4LcSaLzRE8TgsC6wHWh0Cvb6e73kFoG
         lZfhyZHGEZ+pgFxe18qywg8wHKWREco+xGu19hovM6DdhXpAVAYCECW3e56fZG7Ovsov
         4iUn0kK1wzEyqQj7H/dPR/WfMrlY9kSP8pnqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=adqT2BYncbi2bI2fH3xq4PHvWy0I3Gv0s/kmBADwltDqGN/PZRpbr59pjwX3mWqgHE
         c7eufMLRwXB0T+UgA/umoNT8MqGEvyHK5eYIxclS+SQbO/vKRAwhcGg5JJO3+4JBGUEv
         ey8PGuThNzs0QtcXCQ8D18L8AXgFQ6c/8hFlM=
Received: by 10.236.110.135 with SMTP id u7mr7146256yhg.48.1287379069453;
        Sun, 17 Oct 2010 22:17:49 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id k46sm116748yha.3.2010.10.17.22.17.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 22:17:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <12137268.486377.1287073355267.JavaMail.root@mail.hq.genarts.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159232>

Hi Stephen,

[sorry about the delayed reply; was ill]

Stephen Bash writes:
> Okay, here we go!  I've uploaded the applicable scripts to 
>    https://gist.github.com/f6902cb4e3534f07ba48
> 
> If you (or anyone) finds I describe something here that isn't on
> github, let me know and I'll add to it.  I did a cursory pass
> through the scripts to remove a lot of the specific-to-our-repo
> stuff, so I'm not even sure these scripts will run as is...  But
> most errors should be pretty minor (typos in variable names, etc)
> the overall procedure is unchanged.  (And please be gentle, these
> are not anything approaching production-ready)

Maybe you'd like to fork off the repository we're working on and add
the scripts there for convinience? We'll start working on the mapping
as soon as svn-fe3 is finished.

> As always, these scripts come with ABSOLUTELY NO WARRANTEE, use at
> your own risk, your mileage may vary, etc.
> 
> Converting to Git using svn-fe
> ------------------------------
> Most people who have tried using git-svn to convert a medium to
> large Subversion repository have found it's a slow process.  When I
> asked the Git mailing list about this problem in June 2010, I was
> pointed to David Barr's svn-dump-fast-export tool:
>    http://github.com/barrbrain/svn-dump-fast-export
> svn-fe (as the executable is called) converts an entire svn
> repository to git very quickly (our repository took about 20
> minutes), but the entire svn file system is one branch.  I developed
> the following process to reproduce the svn history in git.

So you used the version that supports dumpfile v2 that's merged into
git.git `master`.

> Initial Thoughts
> ----------------
> 1) Our SVN repository was approximately 20k commits, about 7k files
>    in HEAD, a little less than 400 tags, and about 100-150 branches.
>    It was organized /trunk/project rather than /project/trunk.
>    Branches were /branches/branchName where the branchName directory
>    was a copy of the entire trunk (so /branches/branchName/project
>    is what a user would checkout).  This does affect the scripts,
>    but I think it should be relatively easy to modify (no guarantee
>    though).

This is a relatively simple scenario. When building the actual mapper,
we must also take into account moves like /project -> /trunk/project.

> 2) Our SVN repository originated from cvs2svn, so there are some
>    artifacts from that conversion that affect this conversion.
> 
> 3) I make very little use of Git.pm because while I was developing I
>    ran into a bunch of problems with it (none of which I remember
>    now).  Instead I make use of perl's system call to send commands
>    to Git (where possible I avoid invoking the shell, see perldoc -f
>    exec).  I don't want to imply Git.pm doesn't work, but at the
>    time it didn't work for me (and I was more focused on making my
>    scripts work than improving Git.pm. Sorry!).

I see that you've invoked a lot of Git porcelain command in your
scripts. We must factor these out eventually.

> 4) The vast majority of our history was before SVN introduced
>    merge-info, so I made no attempt to capture SVN merges in Git.
>    Rather I kept all branch heads, but moved most of them to a
>    "hidden" namespace (see hideFromGit.pl for details).  This does
>    mean for a couple merges post-conversion I've had to add
>    temporary grafts to make the merge work, but I haven't bothered
>    making those grafts permanent (hopefully this isn't a problem?)
> 
> 5) I performed this entire process using a local mirror of our SVN
>    repository in about 4 hours.  It is mostly automated, but does
>    require some human monitoring (maybe I'm just paranoid).  Since
>    svn-fe runs off a SVN dump file, creating the local mirror was a
>    trivial additional step.

The mirroring process is painfully slow :(

> 6) To keep what follows a *little* shorter, I'm going to assume you
>    can read Perl to extract the details of what's going on.  I'll
>    try to keep the prose to a high level...
> 
> Extracting SVN's History
> ------------------------
> First we want to understand SVN's branching/tagging history.  Modify
> buildSVNTree.pl as necessary, then run
>    perl buildSVNTree.pl > svnBranches.txt

This looks like the heart of the mapper. You've used the libsvn Perl
bindings to mine data from a local mirror of the repository -- this is
not the way to go. Our current approach is to first get everything
into Git-land and then perform the mapping.

Fundamentally, we get our dumpfile parser (svn-fe) to dump all the
data to a Git object store blindly and then post-process (see
db-svn-filter-root). I'm currently investigating if the dumpfile
parser knows something more that we need to note down before
performing the actual mapping.

Also, since we're aiming for a two-way mapping, it's going to be
significantly more challenging: we will need a mapping function that
can be inverted perfectly.

> buildSVNTree.pl does the following steps:
> 1. Traverses the SVN history chronologically looking for copies.

Unnecessary: the object store doesn't care about being told about
copies explicitly. Then again, we can't produce the exact same
Copyfrom information when we export it back to a dumpfile. The aim of
the two-way mapping:

SVN repository 1 -> dumpfile -> Git repository
Git repository -> dumpfile' -> SVN repository 2

I don't care if dumpfile and dumpfile' don't match. The SVN
repositories must, that's all.

> 2. Records the source path/rev and destination path/rev for (most)
>    copies (see script for details)

Unnecessary again.

> 3. Once all copies are collected, further filters copies based on:
>    * source path is a directory
>    * source and destination are not in trunk
>    * source and destination are not in the same branch or tag
>    * source path is not /vendor (an artifact of cvs2svn)

Interesting. I can't figure out why this is necessary yet (I'll
probably find out later in the email).

> 4. Checks that source path is "shortest" path from it's rev (protect
>    against subdirectories that get added in the same commit)
>
> 5. Checks the source and destination paths match globs for expected
>    paths (non-matching copies that make it this far are printed to
>    STDERR)

Easier in Git-land.

> 6. Creates a Git branch name for destination (note that svn tags are
>    closer to git branches than git tags)

In future, we should give users the flexibility to choose - I'm
thinking of a language for specifying the mapping. And this
information should be persistent: maybe put it in a Git note?

> 7. Search history for the last commit that actually changed the source path
> 8. Find a parent path from the source path (mostly recurse up the SVN tree to a known branch)
> 9. Use the parent path to determine the parent git branch name
> 10. Record parent/child relationships
> 11. Dump output to STDOUT (which you should redirect to a file for later use)

Simplified in Git-land.

> I did run into one place where two SVN branches had the same name
> but different SVN paths (it's complicated).  In this case I just
> manually edited the git branch name in svnBranches.txt.  As long as
> you do that before continuing, everything should be okay.

Another interesting point. I'm thinking of a tool that assumes some
layout and produces something similar to svnBranches.txt that
end-users can edit before the actual mapping occurs.

> There's also some logic in buildSVNTree to determine if a branch/tag
> is deleted in the SVN head.  That information is used by
> hideFromGit.

It'll be in the revision history in Git anyway- it doesn't require
special handling.

> Create the Single Branch Git Repo
> ---------------------------------
> Use svn-fe for what it's designed:
> 1. svnadmin dump /path/to/svn/repo > svn-dump.txt
> 2. git init /path/to/initial/git/repo
> 3. cd /path/to/initial/git/repo
> 4. cat /path/to/svn-dump.txt | svn-fe svnRepoName | git fast-import
> 
> svnRepoName in step 4 can be anything you want, but it has to be
> specified so that svn-fe appends the git-svn style "git-svn-id:
> svnRepoName@svnRevNum svnRepoUUID" line to each commit message.
> This line is required later to map SVN revs to Git commits.
> 
> Create Git Branches and Tags
> ----------------------------
> Now comes the next script, filterBranch.pl.  filterBranch will
> create Git branches and tags out of the single branch repo by
> creating a ton of clones and filtering each one.  While it's doing
> this, it also changes the SVN user names to proper Git user IDs
> (name + email).  fetchSVNNames.pl can be used to get all the svn
> users, then you can edit $authorScript in filterBranch to modify
> names appropriately ($authorScript is a git-filter-branch
> --env-filter, so it gets eval'ed by git).  Per the git-filter-branch
> manpage, you'll want to create/use a RAM disk for temporary files
> (see $tempdir).  And you'll need to set various paths like
> $parentRepo (this is the repo created in step 2 above), etc.

Hm, we need to maintain a persistent author map too -- another note
object? Also, as Tom's earlier notes point, we need a persistent
timestamp mapping too because Git's concept of commit timestamp is
different from SVN's concept.

> Then the script should be (?) relatively automated:
>    perl filterBranch.pl svnBranches.txt
> 
> The fancy logic here is probably figuring out which Git refs go to
> which Git commit, but I'll leave that as an exercise to the
> reader...  Ah, I should probably mention: svn-fe can produce "empty"
> commits, and filterBranch does nothing to remove them.  By "empty" I
> mean there will be a commit object without any content changes.  So
> creating a branch/tag in SVN creates a commit, but doesn't change
> content.  That commit will be part of the new Git history.
> Similarly, filterBranch will create git tags from svn tags, but they
> point to one of these "empty" commits rather than the branch they
> are tagged from.  It's not very git-ish, but it seems to work...

Oh, I didn't realize that fast-import allows the creation of empty
commits. We should probably fix this?

> filterBranch is probably the longest step of the process; there's a
> lot of filtering going on.  It will be very verbose on STDOUT, so I
> recommend tee'ing to a file or a terminal with infinite scroll back.
> It also involves a lot of disk hits (somewhat reduced if $tempdir is
> a RAM disk), and potentially a lot of space (it will create a git
> repo for every branch/tag in your subversion history).  For our
> repository this step took about 1.5-2 hours IIRC.

Wow, this really brute-force.

> Create SVN/Git Revmaps
> ----------------------
> Next step is to create a map that goes from SVN rev to Git commit
> object.  genRevmap.pl and genJointRevmap.pl will be helpful here:
> 1. cd $cleanDir (from filterBranch)
> 2. find . -type d -name "*.git" -exec genRevmap.pl '{}' svnRepoName
>    destDir ';'
> 3. cd destDir
> 4. find . -name "*.revmap" -exec grep . '{}' + | genJointRevMap.pl >
>    jointRevmap.revmap
> 
> genRevmap will respect the directory hierarchy created by
> filterBranch, and destDir must have a similar structure (doesn't
> require the individual Git repos, but any directory that contains a
> git repo must exist in destDir).  genJointRevMap takes individual
> revmaps and creates a big revmap for all the repositories.  These
> scripts aren't doing any real magic, just parsing the Git log
> messages for commit ID and the git-svn-id line to get the SVN rev
> the commit corresponds to.  Note that SVN rev to Git commit can be
> one to many!  (genRevmap just lists the same rev twice if it has
> more than one git commit associated with it, genJointRevMap flags
> those revs specially and lists all commit IDs on a single line).

Unless there's a one-to-one mapping between Git revisions and SVN
revisions, a two-way bridge will become very difficult to build. Can
you think of any scenarios where a one-to-one mapping doesn't make
sense?

> Assembling the Final Git Repo
> -----------------------------
> Now we need to combine all the small git repos into one repo that
> represents the SVN history.  Similar to filterBranch, you'll need to
> edit paths in repoFusion.pl to make sure it finds everything.  Then
> simply:
>    perl repoFusion.pl svnBranches.txt jointRevmap.revmap
> 
> At a high level, repoFusion:
> 1. Clones the trunk repository, this will become the new master branch
> 2. Performs a git-fetch on every other repository created by
>    filterBranch to retrieve the git branch/tags contained there
> 3. Creates grafts to match up git branches with their parents using
>    the revmap
> 4. If manual grafts are required, it will pause so the user can edit
>    the grafts file (search for '*', the message there might be a
>    little cryptic, but using svn log and git log in combination,
>    hopefully you can figure out what the correct SHA is to insert)
> 5. Runs filter-branch one more time to make the grafts permanent.
> 
> This is a bit faster than filterBranch, but still takes on the order
> of an hour for our repository.  It also produces a lot of stuff on
> STDOUT, but I think it's a little easier on the disk.  At the end of
> the filter branch, I found it useful to scan the output for refs
> that weren't updated...  That usually indicates a graft didn't get
> created correctly (although due to SVN conventions, it's unlikely
> the master ref will change) At this point it's also possible to get
> some branch/tag name clashes (I did), so those may require clean up.

Grafts and filter-branch. db-svn-filter-root does this more elegantly.

> Hiding 'Deleted' Branches
> -------------------------
> hideFromGit.pl will use the svnBranches.txt file to move any git
> refs associated with deleted SVN paths to refs/hidden in the new
> repository.  This keeps the objects associated with those refs from
> getting garbage collected, but hides them from most user commands.
> This is entirely a personal preference.  (Just like the other
> scripts, you'll probably have to edit the paths in the script
> itself)

Hm. You didn't include the history of deleted branches in the main
repository. Why? Does it make sense to provide the user an option to
exclude some (deleted) branches in the SVN history? It'll make the
two-way mapping extremely difficult.

> 'Validating' the Conversion
> ---------------------------
> gitValidation.pl is a script I wrote to randomly select revs from
> SVN and try to compare the SVN diffs to the Git diffs.  It uses
> git-patch-id to compute a SHA of the changes in each repository, and
> reports if something doesn't match up.  It's not particularly
> polished, and does find "errors" in our Git repo, but after
> investigating all the discrepancies I'm pretty happy that nothing
> vital is wrong.

Until the Git -> SVN bridge is complete, I don't suppose we can do
much better than this.

> Closing Thoughts
> ----------------
> Do I have any?  This is quite the brain dump, so I'm sure I've been
> incomplete and probably somewhat confusing...  I'm happy to answer
> questions as I can, but again, this is entirely based on my
> experience with our local repo.  YMMV!

Thanks for the interesting and insightful read :)
Do discuss a little more with us on #git-devel or otherwise.

-- Ram
