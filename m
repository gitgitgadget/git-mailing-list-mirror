From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git range merge (cherry-pick a range)
Date: Thu, 16 Jul 2009 14:44:00 +0200
Message-ID: <4A5F2090.8090004@drmicha.warpmail.net>
References: <Pine.LNX.4.64.0704201100050.4667@torch.nrlssc.navy.mil>	 <24512201.post@talk.nabble.com> <4A5F10A6.80003@drmicha.warpmail.net> <6efe9a9b0907160516o75641919wd1eecf5229aea895@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Babak S. H." <babak.sayyid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 14:44:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRQK4-0007Ou-Di
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 14:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543AbZGPMoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 08:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755096AbZGPMoS
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 08:44:18 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51942 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755373AbZGPMoS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 08:44:18 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id B46023B1412;
	Thu, 16 Jul 2009 08:44:17 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 16 Jul 2009 08:44:17 -0400
X-Sasl-enc: IflYA3B5lv6w7kCct4wsGAc/96P0zdPD36tPs45N14xN 1247748257
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0A9288656;
	Thu, 16 Jul 2009 08:44:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090712 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <6efe9a9b0907160516o75641919wd1eecf5229aea895@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123400>

Babak S. H. venit, vidit, dixit 16.07.2009 14:16:
> Hello Micheal,
> thank you for the response... I will try to answer inline as I read...
...
> 
>     Did you use a monospaced font when composing this e-mail? All graphs
>     come out disconnect/distorted when reading your e-mail with a monospaced
>     font.
> 
> 
> 
> What a pity. I pasted the text out of the editor (vi | Font: lucida
> console 8) in the web form.
> Anyway I attach my original posting in a file to this email. I hope you
> can open that undistorted.

Yep, it's fine.

> 
>  
> 
> 
> 
>     I assume that above, a is the first additional commit of B1 which
>     branches off o.
> 
> 
> 
> Correct.
> 
>  
> 
> 
> 
>     >
>     > Commit B:
>     > ---------
>     > FluidSolver::FluidSolver(int argc, char* argv[]) {
>     >     init(argc, argv);
>     >     // test edit 1: a + b
>     > }
>     >
>     > Commit C:
>     > --------
>     > FluidSolver::FluidSolver(int argc, char* argv[]) {
>     >     init(argc, argv);
>     >     // test edit 1: a + b
>     >     // test edit 2: a - b
>     > }
>     >
>     > Commit D:
>     > --------
>     > FluidSolver::FluidSolver(int argc, char* argv[]) {
>     >     init(argc, argv);
>     >     // test edit 1: a + b
>     >     // test edit 2: a - b
>     >     // test edit 3: a * b
>     > }
>     >
>     > Commit E:
>     > --------
>     > FluidSolver::FluidSolver(int argc, char* argv[]) {
>     >     init(argc, argv);
>     >     // test edit 1: a + b
>     >     // test edit 2: a - b
>     >     // test edit 3: a * b
>     >     // test edit 4: a / b
>     > }
>     >
>     >
>     > Range merge (the GIT way):
>     > =========================
>     >
>     > 1) Switch to Branch B1
>     >
>     > 2) Create a temporary branch which does not contain anything
>     beyond commit D
>     >
>     >    $ git checkout -b volatileBranch D
>     >
>     >     Master:                 o-
>     >                                   \
>     >     Branch B1:              A-B-C-D-E
>     >                                                  \
>     >     Branch volatileBranch:              (A)-(B)-(C)-(D)
>     >
>     > 3) Rebase volatile branch to master from commit (B) to master's HEAD
>     >    git rebase --onto master (A)
>     >
>     >
>     >     Branch volatileBranch:   (B)-(C)-(D)
>     >                                        /
>     >     Master:                      o-
>     >                                        \
>     >     Branch B1:                    A-B-C-D-E
>     >
>     >
>     > Rebasing output:
>     > ----------------
>     >
>     > First, rewinding head to replay your work on top of it...
>     > Applying: test edit 2: a - b
>     > error: patch failed: fluidsolver.cpp:28
>     > error: fluidsolver.cpp: patch does not apply
>     > Using index info to reconstruct a base tree...
>     > Falling back to patching base and 3-way merge...
>     > Auto-merging fluidsolver.cpp
>     > CONFLICT (content): Merge conflict in fluidsolver.cpp
>     > Failed to merge in the changes.
>     > Patch failed at 0001 test edit 2: a - b
>     >
>     >
>     > When you have resolved this problem run "git rebase --continue".
>     > If you would prefer to skip this patch, instead run "git rebase
>     --skip".
>     > To restore the original branch and stop rebasing run "git rebase
>     --abort".
>     >
>     >
>     > Conflicts:
>     > ----------
>     > FluidSolver::FluidSolver(int argc, char* argv[]) {
>     >     init(argc, argv);
>     > <<<<<<< HEAD:fluidsolver.cpp
>     > =======
>     >     // test edit 1: a + b
>     >     // test edit 2: a - b
>     >>>>>>>> test edit 2: a - b:fluidsolver.cpp
>     > }
>     >
>     >
>     > After manually resolving the conflict and continuing the rebasing
>     > with git rebase --continue, we are finally finished.
>     >
>     > Since we only had updates in branch 1, it is astonishing that we get a
>     > conflict at all.
>     > Same situation works like a charme in subversion.
> 
>     Ahem, how could /anything/ work like a charm in subversion? (I've been
>     using it myself.)
> 
> 
> 
> Please let's try not to start a belief war. Every version control
> systems has its quirks and we just
> try to figure out what the problem in the above described scenario is.

Agreed. (Which is why I started the next paragraph with "Seriously,".)

> 
> 
>  
> 
> 
> 
>     Seriously, if, in subversion, you merge -rA:D onto master then
>     subversion only computes the diff between A and D and applies it to
>     master. You an do this in git as well, of course, but that's not a merge
>     and does not preserve individual commit messages.
> 
> 
> 
> Subversion does preserve individual commit messages.
> Try to pass the --use-merge-history parameter to svn log.

I have to admit that I've ever used svn 1.4x. I do belief though that
even 1.5 makes a single commit in that situation and reconstructs the
merge history from the metadata.

> 
>  
> 
> 
> 
>     > We would be happy to get an explanation for this merge bahaviour,
>     since
>     > many edits in large projects could as a matter of principle result
>     a lot of
>     > merge conflicts
>     > which all have to be treated manually.
>     >
>     > We believe that GIT's interface for range merges needs to get more
>     user
>     > friendly.
>     > Since steps 1) - 3) use already developed components of GIT, there
>     should be
>     > a layer above 'em
>     > which performs a range merge by internally calling 1) - 3).
>     >
>     > Example: git cherry-pick $from_branch@startCommitHash
>     > $to_branch@endCommitHash
>     >
> 
>     If I read you graphs correctly you could just as well fast-forward
>     master to D (using reset or merge) and then "rebase -i" in order to
>     remove A.
> 
>     Alternatively, you can use "git format-patch --stdout revrange | git
>     am".
> 
> 
> Yes applying a patch is an alternative.
> But don't you think git needs to provide a more user friendly interface
> for range merges?

Sometimes it's only a matter of workflow. Have you tried the suggestion
above?

In general, in git it's preferable to have merges of feature branches
rather than cherry picks. So you would rebase the feature branch first
(rebase -i to remove A) and then merge the result to master. Have you
tried whether you get conflicts that way? It's really one rebase -i and
one merge.

If you want to use a patch approach then "git format-patch|git am" and
"git cherry" are your options. Currently, git cherry-pick accepts only a
single commit, but if you want to pick the range B through D that would
be B^..D in git lingo, so

git rev-list --reverse --topo-order B^..D | while read rev
do
  git cherry-pick $rev || break
done

should do the job (untested!).

Cheers,
Michael
