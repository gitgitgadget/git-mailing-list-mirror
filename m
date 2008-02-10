From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Upcoming memcached releases + rambling.
Date: Sun, 10 Feb 2008 16:39:49 +0100
Organization: At home
Message-ID: <fon5s6$kff$1@ger.gmane.org>
References: <47AAC7DA.2010604@rydia.net> <4422C0B2-6874-41EA-B4A0-4F3414F385FC@spy.net> <47AB3DBD.60004@rydia.net> <3897B3FD-4DCB-4150-8A07-7F8868A70A93@spy.net> <47AD2D1F.7030807@rydia.net> <5222C3B4-5E2C-45D2-8DF3-A85D69DDA2CF@spy.net> <20080210110504.GA27314@coredump.intra.peff.net> <m31w7khmhq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: memcached@lists.danga.com, mercurial@selenic.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 16:41:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOEJW-0008Fd-M5
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 16:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbYBJPkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 10:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbYBJPkT
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 10:40:19 -0500
Received: from main.gmane.org ([80.91.229.2]:45078 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753083AbYBJPkH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 10:40:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JOEHf-0000bX-0A
	for git@vger.kernel.org; Sun, 10 Feb 2008 15:39:59 +0000
Received: from abxf105.neoplus.adsl.tpnet.pl ([83.8.255.105])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 15:39:58 +0000
Received: from jnareb by abxf105.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 15:39:58 +0000
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git,gmane.comp.web.cache.memcached
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abxf105.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73360>

[I hate subscribe-only default-DROP mailing lists for a OSS project,
 where you don't get even: waiting for moderator approval for not
 subscribed. I'm trying to resend it via GMane. I'm not subscribed
 to memcached mailing list]

Jeff King <peff@peff.net> writes:

> [I'm not on the list, so please cc me in replies]
> 
> On Fri, Feb 08, 2008 at 09:21:16PM -0800, Dustin Sallings wrote:
> 
> > I've seen lots of people using git for their own work, but not enough
> > using it in a distributed fashion.  I've been asking questions about how
> > to collaborate with git, but I can't seem to find any git experts who will
> > answer questions.
> 
> Please, if you have git questions, feel free to ask them on the git list
> (which I am cc'ing here).

Did they at least asked (tried to ask) on #git channel on FreeNode?
 
> > serve, bundle, export, import, incoming, and outgoing don't seem
> > to have equivalences in git.

> I don't know hg well at all, but I will attempt to translate (please
> correct me if I'm wrong on any hg behavior).

I have tried to follow hg(1), from
  http://www.selenic.com/mercurial/hg.1.html

> "hg serve" runs a web repo browser and a pull server. In git, these
> duties are split. Depending on what you want, you can:
>   - for allowing people to pull from you, you can use git-daemon
>   - for repository browsing, run an instance of gitweb. There is a
>     git-instaweb script for doing one-off "I just need to set this up
>     for a minute" versions.

Or you can use one of the history viewers: gitk (Tcl/Tk), qgit (Qt),
Giggle or GitView (GTK+), or tig (ncurses).

>   - you can also allow people to pull via http; just copy your '.git'
>     directory somewhere that is accessible by the web server

Note that you have to run git-update-server-info to update auxiliary
info file to help dumb servers (which includes HTTP server),
preferably in 'update' (for publishing repos) or 'post-commit' (for
working repos) hook.

>   - you can also allow people to pull via ssh; just give them an ssh
>     account and point them to host:/path/to/repo

You can use git-shell as shell to lomit access to only pulling /
pushing changes.

IMHO it is better to leave serving web pages to web server, instead of
trying to do that in an SCM... even if Python has support for creating
basic HTTP server easily. (We could add bare-bones gitweb and git
only, written in Perl HTTP server in gitweb/, but what for...).


> "hg bundle" has an equivalent in git: "git bundle"

Minor difference: it is "git bundle create" and "git bundle unbundle"
(or "git pull <bundle>") versus "hg bundle" and "hg unbundle".

> "hg export" seems to generate the commit message + patch for a set of
> commits. The git equivalent is "git format-patch" which puts each patch
> in its own mbox file (you can also use "git format-patch --stdout >mbox"
> to put them all in one mbox.

It looks like there is no exact equivalent. "git format-patch" is used
to generate series of patches, but it doesn't for example saves
parent(s) of a commit; not that it makes much sense. It is meant to
send patches for review (and then applying).

By the way, for binary files git would send binary diff, which can be
applied _only_ if you have exact preimage, so this is no problem:

hg export:

    Without the -a option, export will avoid generating diffs of files
    it detects as binary. With -a, export will generate a diff anyway,
    probably with undesirable results.

> "hg import" presumably applies the results of "hg export". In git, this
> is "git am" (where am stands for apply mailbox), which applies the
> changes from an entire mbox one by one.

Note that "git format-patch" / "git am" is meant for mail driven
workflow, with patches send for _review_ to maintainer or [public]
mailing list, and applied by maintainer on case by case basis. This
means for example that commit from patch might be applied in different
place of revision graph than original; "git am --3way" fallbacks on
3-way merge (based on embedded original pre-image blob (file)
identifier) if patch cannot be applied cleanly.

It is not meant as a transport mechanism: use interactive protocols
(ssh, git, http) for that, or git-bundle if it is impossible.

> "incoming" and "outgoing" seem to basically be diffs against remote
> repositories (i.e., "what do I have that he doesn't" and vice versa). In
> git, you would do a "git fetch" to say "contact the remote repository
> and get what he has, but don't update any of my branches" followed by
> "git log origin..HEAD" (what does I have that he doesn't) or "git log
> HEAD..origin" (the opposite). You can also use the symmetric difference
> with a graphical browser like gitk: "gitk origin...HEAD" which will show
> everything that he has and everything you have, down to the point where
> the two histories last diverged.

Here (and in neighbour post about diff between branches) we come to
the main difference between Git and Mercurial, namely that Git uses
multiple-branches in repository workflow extensively[*1*], while in
Mercurial multiple branches in single repository are still (from what
I have read) secondary citizens; main workflow is still one branch per
repository.

(I'm not sure if Mercurial gets correctly the difference between tags
and branches, but that is just me spreading FUD ;-)).

Git uses concept of remote tracking branches to track changes in
remote repository. By default after cloning repository which has for
example branches 'master' (stable branch) and 'next' (development
branch) you have local branch 'master' (fullname: refs/heads/master)
for your own work, and 'origin/master' and 'origin/next' (where
'origin' is default name for origin-al repository you by default fetch
from) remote tracking branches (fullname: refs/remotes/origin/master,
refs/remotes/origin/next). You have also symbolic ref 'HEAD' which
denotes current branch; points which branch you are currently work
with, and ref 'origin' (fullname: refs/remotes/origin/HEAD) denoting
default branch on remote repository.

In Git "pull" consists of two steps: 'fetch' which downloads objects
(changes) and updates refs, and 'merge' which joins the histories (or
does fast-forward) and updates current branch. From what I understand
from Mercurial documentation hg it has those actions split in a
different way: "hg incoming" to examine changes, and "hg pull;
hg update" to join histories.

So to examine some defined repository one would do a "git fetch <repo>", 
where <repo> is shortcut repository name, and then examine
<repo>/<branch> remote tracking branches. Note that it looks like
"hg incoming" can deal sensibly only with one branch per repository
repositories (further FUD spreading ;-)). If you want to preview some
foreign repo you can use "git fetch <URL>" or "git fetch <URL>
<branch>" and examine FETCH_HEAD.

Note that the fact that some branch in remote repository and
respective remote-tracking branch differ might mean many things:
 a.) remote repository has avanced wrt. our repository
 b.) remote repository lags behind our repository
     (e.g. both are sister repositories cloned from the same repo)
 c.) histories diverged, or were rewound / rewritten
I wonder how Mercurial deals with cases b.) and c.) (further anti-hg
FUD ;-))

Now to examine what changed you can use _generic_ revision list
specification in some history browser (git-log, gitk, git-show-branch,
etc.). Here you can use "A..B" syntax (what's in B, excluding what is
in A, which in the case of linear history is: what is between A and
B), and "A...B" syntax (what's in A and B, excluding what's in common
ancestor (merge base) of both of them). A and/or B can be: HEAD
(current branch), 'origin' or <repo> for default remote repository
branch, FETCH_HEAD for what was just fetched, or even
origin@{1}..origin to show what fetch brought to 'origin/HEAD'.

If Git ever would want to have a command which would show which
branches differ in some remote repository, I think it would be added
to "git remote" (which I recommend checking).

> >     I've contributed changes to both git and hg projects and haven't had  
> > good luck submitting changes upstream.   I'd be interesting in talking to 
> > people who collaborate on projects using git both as first and  
> > second-level contributors to see if their experiences are any better than 
> > mine.  I don't doubt that I may be doing it wrong.
> 
> Again, if you have specific questions, please feel free to ask on the
> git list. We are more than happy to help out if we can.

Well, there are around 250 contributors to git which have more than
one commit to his/her name. Even excluding some fuzz factor due to
wrong / changed credentials.

Masukomi (Kate Rhodes) wrote in her blog in "Some thoughts about Git"
http://weblog.masukomi.org/2008/2/4/some-thoughts-about-git

  And then I joined the Git mailing list. Linus mentioned that it had
  a high signal to noise ratio but... *holy shit*. I have been on a
  lot of mailing lists for open source projects over the years and I
  have never seen anything like this. Almost every e-mail is a patch,
  or a good discussion of a patch, or a good discussion of some new
  feature and how to go about implementing it.

> >     Should memcached choose git, it may be as simple as putting up a page  
> > that says, ``this is how you clone, this is how you work, this is how you 
> > submit your changes back.''
> 
> I don't know hg very well, but my impression is that the implementation
> is quite similar to git and that writing a document "translating"
> commands from one system to the other would be feasible.

Actualy while ideas and workflows might be similar, implementation
differs quite a bit.

Git is snapshot based[*2*]; in git repository is object database, with
commits being points in DAG (Directed Acyclic Graph) of revisions,
pointing to their parent commits and to snapshot of a repository state
at given revision. Branches, remote tracking branches and tags are
[named] pointers to points (staring points) in DAG of revisions. There
HEAD which is pointer to pointer, or simply something which names
current branch (symbolic reference to current branch name). File
structure is reflected in object database using hierchical tree object
structure; file name and parts of permissions are stored in tree
objects. This structure allows for fast merges (and fast warm-cache
performance, supposedly).

Mercurial I know only secondhand, from the discussion on #revctrl IRC
channel, and from Mercurial documentation. It is AFAICT
changeset-based, with changesets stored "hashed" in per [current]
filename buckeds, tied together in flat manifest like file which ties
files together, tied together in revlog changeset-log file which
stores commits. Branches and tags are stored as in-tree file (inside
working directory of repository), similarly to .gitignore / .hgignore
file, with (for tags at least) some complicated rule of updating it
when switching branches and going to given revision (further anti-hg
FUD; I hope that changed...). The pref-file-bucket structure allows
for fast patch applying (and fast cold-cache performance, supposedly).


Footnotes:
==========
[*1*] Junio C Hamano (current git maintainer), wrote in his blog
in "FLOSS weekly #19 follow-up (3)" entry:
  http://gitster.livejournal.com/9970.html 

  "The very basic structure and idea behind git has not changed since
   Linus wrote the initial implementation".

  Well, while that is not _untrue_, that statement itself may lead to
  confusion unless clarified.

  [...]

  * We did not envision that multiple branches in a single repository
    would turn out to be such a useful way to work, and did not have
    support for switching branches;


[*2*] Even if in packed form it is stored as delta chains; but that is
      just [transparent] engine.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
