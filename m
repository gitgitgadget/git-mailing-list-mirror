From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 15:17:26 +0200
Message-ID: <200610201517.26702.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610201151.13199.jnareb@gmail.com> <a7e835d40610200342ibc56fd9t542a60230ebe0020@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Carl Worth" <cworth@cworth.org>, "Andreas Ericsson" <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 15:18:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GauG0-0000hB-Rr
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 15:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946127AbWJTNR2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 09:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946145AbWJTNR2
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 09:17:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:40077 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946127AbWJTNR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 09:17:26 -0400
Received: by ug-out-1314.google.com with SMTP id o38so739535ugd
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 06:17:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dOOb5Lm8Dfnj9NPE3sLt3Fe8EkcRI9zGTprNmrKSKAbZx6vIXwVX9xnTFVNgq63xuE4yPeXoYLC0eLxvKVLx9bv+ygsFWi4TYIWylrBAwbgmG4W1s8zaXG889C4Q94I5+RccaSvYpcUzyiRp+llR9JX+uMmY78R/ZUPx+zUBu4o=
Received: by 10.66.224.19 with SMTP id w19mr1833112ugg;
        Fri, 20 Oct 2006 06:17:24 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id i39sm1550599ugd.2006.10.20.06.17.22;
        Fri, 20 Oct 2006 06:17:23 -0700 (PDT)
To: "James Henstridge" <james@jamesh.id.au>
User-Agent: KMail/1.9.3
In-Reply-To: <a7e835d40610200342ibc56fd9t542a60230ebe0020@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29460>

James Henstridge wrote:
> On 20/10/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> James Henstridge wrote:
>>> On 20/10/06, Carl Worth <cworth@cworth.org> wrote:
>>>> On Thu, 19 Oct 2006 19:01:58 -0400, Aaron Bentley wrote:

>>> With this sort of setup, I would publish my branches in a directory
>>> tree like this:
>>>
>>>     /repo
>>>         /branch1
>>>         /branch2
>>>
>>> I make "/repo" a Bazaar repository so that it stores the revision data
>>> for all branches contained in the directory (the tree contents,
>>> revision meta data, etc).
>>
>> And here we have a feature which is as far as I see unique to git,
>> namely to have persistent branches with _separate namespace_. It means
>> that we can have hierarchical branch names (including names like
>> "remotes/<remotename>/<branch of remote>", or "jc/diff"), and we don't
>> have to guess where repository name ends and branch name begins.
> 
> With the above layout, I would just type:
>     bzr branch http://server/repo/branch1

With Cogito (you can think of it either as alternate Git UI, or as SCM
built on top of Git) you would use

   $ cg clone http://server/repo#branch

for example

   $ cg clone git://git.kernel.org/pub/scm/git/git.git#next

to clone _single_ branch (in bzr terminology, "heavy checkout" of branch).
But you can also clone _whole_ repository, _all_ published branches with

   $ cg clone git://git.kernel.org/pub/scm/git/git.git

With core Git it is the same, but we don't have the above shortcut
for checking only one branch; branches to checkout are in separate
arguments to git-clone.

In bzr it seems that you cannot distinguish (at least not only
from URL) where repository ends and branch begins.

*Sidenote:* In current version of gitweb you can get file
in given repository in given branch using the following
notation:

   http://path/to/gitweb.cgi/repo/sitory/branch/name:file/name

gitweb can detect where branch name ends and repository name
begins; usually (by convention) "bare" git repositories uses
<project>.git name, "clothed" git repositories uses
<project>/.git


See also below.

> This command behaves identically whether the repository data is in
> /repo or in /repo/branch1.  Someone pulling from the branch doesn't
> have to care what the repository structure is.  Having a separate
> namespace for branch names only really makes sense if the user needs
> to care about it.
> 
> As for hierarchical names, there is nothing stopping you from using
> deaper directory structures with Bazaar too.  Bazaar just checks each
> successive parent directory til it finds a repository for the branch.
> 
>> The idea of "branches (and tags) as directories" was if I understand
>> it correctly introduced by Subversion, and from what can be seen from
>> troubles with git-svn (stemming from the fact that division between
>> project name and branch name is the matter of _convention_) at least
>> slightly brain-damaged.
> 
> I think you are a bit confused about how Bazaar works here.  A Bazaar
> repository is a store of trees and revision metadata.  A Bazaar branch
> is just a pointer to a head revision in the repository.  As you can
> probably guess, the data for the branch is a lot smaller than the data
> for the repository.
> 
> You can store the repository and branch in the same directory to get a
> standalone branch.  The layout I described above has a repository in a
> parent directory, shared by multiple branches.
> 
> If you are comparing Subversion and Bazaar, a Bazaar branch shares
> more properties with a full Subversion repository rather than a
> Subversion branch.

Oh, that explained yet another difference between Bazaar-NG (and other
SCM which uses similar model) and Git.

In Git branch is just a pointer to head (top) commit (hence they are stored
under .git/refs/heads/) in given line of development. Git also stores
information (in .git/HEAD) about which branch we are currently on, which
means on which branch git puts new commits. Nothing more (well, there
can be log of changes to head in .git/logs/refs/heads/ but that is optional
and purely local information). In Bazaar-NG you have to store (if I
understand it correctly) mapping from revnos to revisions.
 
By default (it means for example default behavior of git-clone, if we don't
use --bare option) git repository is _embedded_ in working area. We have

   .git/
   .git/HEAD
   ...
   .git/refs/heads/
   ...
   <working area files, e.g.>

So repo/branch wouldn't work, because 'branch' would conflict with working
area files. GIT doesn't follow the CVS model of separate storage area
(CVSROOT) and having only pointer to said area (files in CVS/ 
subdirectories) in working directory.

In GIT to work on some repository you don't (like from what I understand
in Bazaar-NG) "checkout" some branch (which would automatically copy some
data in case of "heavy checkout" or just save some pointer to repository
in "lightweight checkout" case). You clone whole repository; well you can
select which branches to clone. "Checkout" in GIT terminology means to
populate working area with given version (and change in repository which
branch is current, usually).

How checked out working area looks like in Bazaar-NG?

[...]
>>> For similar reasons, the cost of publishing 20 related Bazaar branches
>>> on my web server is generally not 20 times the cost of publishing a
>>> single branch.
>>>
>>> I understand that you get similar benefits by a GIT repository with
>>> multiple head revisions.
>>
>> You can get similar benefits by a GIT repository with shared object
>> database using alternates mechanism. And that is usually preferred
>> over storing unrelated branches, i.e. branches pointing to disconnected
>> DAG (separate trees in BK terminology) of revision, if that you mean by
>> multiple head revisions (because in GIT there is no notion of "mainline"
>> branch, only of current (HEAD) branch).
> 
> I may have got the git terminology wrong. I was trying to draw
> parallels between the .git/refs/... files in a git repository and the
> way multiple branches can be stored in a Bazaar repository.

Yes, but using Git that way has serious disadvantages. For example
there is only one current branch pointer and only one index (dircache)
per git repository.

> I am not claiming that you'll get bandwidth or disk space benefits for
> storing unrelated branches in a single Bazaar repository.  But if the
> branches are related, then there will be space savings (which is what
> the great-grandparent post was asking about).

So it is way better to use one repository per project, and use alternates
mechanism to save space.

But I agree that saving "old fork" info as separate branch doesn't lead
to that much inefficiency as might be thought.

But after saving "old fork" as a branch revno based revision identifiers
change from http://old.host/old/repo:127 to http://host/repo/old.fork:127
That is maybe minimal change, but this is change!


P.S. In two separate git repositories, even if they exchange information
with each other, the branch names can be different.
-- 
Jakub Narebski
Poland
