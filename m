From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 00:50:31 +0200
Message-ID: <200610210050.32254.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610201517.26702.jnareb@gmail.com> <a7e835d40610200759h49859a20k8a409fe34f68630a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: bazaar-ng@lists.canonical.com,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Carl Worth" <cworth@cworth.org>, "Andreas Ericsson" <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 00:50:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb3CD-0002Ud-SD
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 00:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992725AbWJTWua (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 18:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992741AbWJTWua
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 18:50:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:55073 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S2992725AbWJTWu3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 18:50:29 -0400
Received: by ug-out-1314.google.com with SMTP id z34so747872ugc
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 15:50:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=sim0bcpebkJAbRsMVfW3BkQA04U/ovutxdKNu2ms5SAW/iBSOgd4kl6hX1ChlBF9asojf23m9pdczSFwN/ucPb04JeQkTWrucobMhrZMQEhXqLSdMUSpg2GIPjkTgOcvrMZFlWvkqnXFv4GbitvVhFKAq4snZK4st0+0KKeeoYQ=
Received: by 10.66.220.17 with SMTP id s17mr2829756ugg;
        Fri, 20 Oct 2006 15:50:27 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id e23sm2056833ugd.2006.10.20.15.50.25;
        Fri, 20 Oct 2006 15:50:26 -0700 (PDT)
To: "James Henstridge" <james@jamesh.id.au>
User-Agent: KMail/1.9.3
In-Reply-To: <a7e835d40610200759h49859a20k8a409fe34f68630a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29549>

On 20-10-2006, James Henstridge wrote:
> On 20/10/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> James Henstridge wrote:

>>> With the above layout, I would just type:
>>>     bzr branch http://server/repo/branch1
>>
>> With Cogito (you can think of it either as alternate Git UI, or as SCM
>> built on top of Git) you would use
>>
>>    $ cg clone http://server/repo#branch
>>
>> for example
>>
>>    $ cg clone git://git.kernel.org/pub/scm/git/git.git#next
>>
>> to clone _single_ branch (in bzr terminology, "heavy checkout" of branch).
> 
> My understanding of git is that this would be equivalent to the "bzr
> branch" command.  A checkout (heavy or lightweight) has the property
> that commits are made to the original branch.

Not exactly (my mistake in explaining it). "cg clone git://host/repo@branch"
clones only part of history DAG of commits reachable from given branch.
Still it is full repository. You can add branches to it later with
cg-branch-add and fetch changes with cg-fetch.

>> But you can also clone _whole_ repository, _all_ published branches with
>>
>>    $ cg clone git://git.kernel.org/pub/scm/git/git.git
> 
> I suppose that'd be useful if you want a copy of all the branches at
> once.  There is no builtin command in Bazaar to do that at present.

That is _very_ useful. And that is default option for Git. For
example with git.git repository I'm interested both in 'master'
branch (main line of development), and in 'next' branch (development
branch). For example I send some patches, based on 'master', they
get accepted but in 'next' (to cook for a while for example), and
I want to do further work in this direction I have to base my
new work on 'next' branch.

It looks like the Bazaar-NG "branches" are equivalent of the
one-branch-clone of Git.

And if there is no command to clone whole repository, how
you do public repository?

See below.

[...] 
> Two points:
> (1) if we are publishing branches, we wouldn't include working trees
> -- they are not needed to pull or merge from such a branch.

Same with Git. Public repositories are usually "bare" clones, i.e.
without working directory. We can clone/fetch from "clothed" repo
without problem - we just have to point to .git.

> (2) if we did have working trees, they'd be rooted at /repo/branch1
> and /repo/branch2 -- not at /repo (since /repo is not a branch).

That's explains it.

> In case (2) there is a potential for conflicts if you nest branches,
> but people don't generally trigger this problem with the way they use
> Bazaar.

There is no problem in Git to have git repository nested within
working area: of course you better ignore .git directory; you can
ignore files in this embedded repository or not.

[...]
>> How checked out working area looks like in Bazaar-NG?
> 
> The layout of a standalone branch would be:
>   .bzr/repository/ -- storage of trees and metadata
>   .bzr/branch/ -- branch metadagta (e.g. pointer to the head revision)
>   .bzr/checkout/ -- working tree book-keeping files
>   source code

The layout of git repository (git clone, as it is equivalent of bzr branch)
you have the following layout:
  .git/objects/ -- repository objects database
  .git/refs/ -- heads (branches) and tags
  .git/index -- staging area for commit (adding files, merge resolving)
  .git/HEAD -- which branch is current branch
  source code

> If we use a shared repository, the contained branches would lack the
> .bzr/repository/ directory.  The parent directory would instead have a
> .bzr/repository/, but usually wouldn't have .bzr/branch/ (unless there
> is a branch rooted at the base of the repository).

The equivalent of shared repository would be having .git/objects/
to be symlink to some directory which would serve as common area
to store object database.

You can use alternates file: .git/objects/info/alternates can have
list of absolute pathnames (one per line) where objects can be found
instead. If I understand correctly new objects gets commited to current
repository object database, therefore to have equivalent of symlinking
.git/objects directory you would have for every repository which you
want to share object database to have in alternates file all repositories
except self. 

Or you can use GIT_ALTERNATE_OBJECT_DIRECTORIES environmental variable.

Repository using any kind of alternates mechanism is not suitable
to publish using "dumb" (non-git-aware) transports.

> if we are publishing a branch to a web server, we'd skip the working
> tree, so the source code and .bzr/checkout/ directory would be
> missing.

For "bare" clone only 'source files' would be missing. Well, perhaps
also '.git/index' but I'm not sure.

> In the case of a checkout, the .bzr/branch/ directory has a special
> format and acts as a pointer to the original branch.  If the checkout
> is lightweight, the .bzr/repository/ directory would be missing, and
> bzr would need to contact the original branch for the data.

There is no equivalent for bzr "checkout" (and could you please use
other name for that, like "lazy branch"?) in Git. There was some talk
about how to do "lazy clone"/"remote alternates" in Git, but no consensus
was reached about how to do this effectively, and for both "dumb"
(http, https, ftp, rsync) transports and git-aware (local, git, ssh+git)
transports. From what I've read Bazaar-NG doesn't try the "effective"
part...

[...]
>> Yes, but using Git that way has serious disadvantages. For example
>> there is only one current branch pointer and only one index (dircache)
>> per git repository.
> 
> Okay.  So using Bazaar terminology, this seems to be an issue of the
> working tree being associated with the repository rather than the
> branch?
 
From the point of view of Git users, there is (in Bazaar-NG) an issue
of working tree being associated with the individual branch rather than
repository.

In git to work on some project you clone its repository; in bzr to
work on some project you get one of its branches.


IMVHO if "Cheap Branching Anywhere" was changed to "Lightweight Branches"
then Bazaar-NG would have to put "Partial" in there. Unless you setup
your branches to share data, branches are not cheap (in the sense of
disk space). That's probably the cause for _need_ for "checkouts".
Bazaar-NG doesn't encourage using temporary branches, with
lifespan no longer than day. Can you ever switch between branches
using only one working area; can you do it fast?

It looks somewhat like bzr started without permanent branches, and
they were added later (sharing repository data). But I might be mistaken.

P.S. what Git lacks at least now is a way to generate diff between
two different local repositories, but you can always setup alternates
file and fetch the other repository into some tag.
-- 
Jakub Narebski
Poland
