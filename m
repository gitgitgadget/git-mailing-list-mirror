From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: "git pull . <branch>" versus "git merge <branch>"
Date: Wed, 11 Jun 2008 16:01:57 -0500
Message-ID: <kpNEshc02wSu18FDnzOIvMAjQu_lmbk4tK_T_9HGh38@cipher.nrlssc.navy.mil>
References: <484F2174.9020508@keyaccess.nl> <alpine.LNX.1.00.0806111340570.19665@iabervon.org> <XZoDb2arIiMts-bX6jjK15wC9cOn5lPGgCOQYbY9YIyNm_nfcDf5gQ@cipher.nrlssc.navy.mil> <alpine.LNX.1.00.0806111513380.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Rene Herman <rene.herman@keyaccess.nl>, git <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 23:04:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6XTQ-0006H9-Md
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 23:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbYFKVCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 17:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbYFKVCW
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 17:02:22 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56790 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbYFKVCV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 17:02:21 -0400
Received: by mail.nrlssc.navy.mil id m5BL1wCW021601; Wed, 11 Jun 2008 16:01:58 -0500
In-Reply-To: <alpine.LNX.1.00.0806111513380.19665@iabervon.org>
X-OriginalArrivalTime: 11 Jun 2008 21:01:57.0748 (UTC) FILETIME=[62ADB340:01C8CC06]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84662>

Daniel Barkalow wrote:
> On Wed, 11 Jun 2008, Brandon Casey wrote:
> 
>> Daniel Barkalow wrote:
>>> On Wed, 11 Jun 2008, Rene Herman wrote:
>>>
>>>> Good day.
>>>>
>>>> The manpages seem to be making somewhat of a point of mentioning "git pull .
>>>> <branch>" as the way to merge a local branch into the current one but a simple
>>>> "git merge <branch>" seems to work well. Is there a difference?
>>> Those manpage sections predate the existance of "git merge <branch>". If 
>>> you're not planning to use git before November 2006, there's no reason to 
>>> use the "git pull ." form. They should probably be replaced with more 
>>> helpful examples at this point.
>> Was there some past discussion of the ui merits of a separate 'merge' command
>> for dealing with local merges and a 'pull' command for remote merges? I
>> understand merge is the backend. The question has to do with the high-level
>> user interface: one command or two? Why wasn't git-pull enough?
> 
> "git pull . <branch>" does "git fetch . <branch>" and then merges it. Of 
> course, "git fetch . <branch>" does nothing at all, and it's weird as a 
> user interface to have the only (simple) way of selecting something to 
> merge be to fetch it as if from a remote repository, but from the local 
> repository. After all, no other purely local operation requires you to 
> first fetch the thing you're interesting in from yourself.

I don't agree with this paragraph. I think it _would_ be weird if you had
to type 'git fetch' and then 'git merge' (or git pull) when operating on
a local repository, but that is not necessary. It is only necessary to
type 'git pull'. There is symmetry between operating on a remote repository
and operating on a local repository. The user does not need to know that
a noop fetch is first performed, or whether the pull command detects that
it is operating on a local repository and just skips the fetch, any more than
the user is required to know the exact sequence of events that allows an ssh
session to succeed.

>> I ask because elsewhere in this thread Miklos suggests that git-merge should
>> be preferred over git-pull when dealing with a local repostory and you suggest
>> here that the documentation should be updated to use the 'git merge' method
>> instead of 'git pull'. I had the impression that git-merge was only used by
>> those who had not yet gotten their mind around the pull methodology. So it
>> was more of an 'ease the transition from other SCMs' rather than the recommended
>> way of doing things.
> 
> I think everybody uses "git merge" instead of "git pull ." these days. 
> It's shorter and less fiddly to type, and doesn't polute your bash reverse 
> search for "git pull<tab>" with local things. And, if you've got a bunch 
> of local branches, which is not uncommon and very much native to git, the 
> intuitive thing is to merge them with "git merge" instead of treating them 
> as if they weren't local.

Not sure about this one either. I think git-merge is intuitive to those who are
familiar with the operation of git-pull, specifically those that understand how
to use git-fetch and that git-pull does a fetch and then a merge. For those new
to git, I think git-fetch takes a little while to get a handle on.

git-pull allows treating all branches as equal for merging purposes. A user does
not have to differentiate between a local and a remote branch by using different
commands. So I did not see it as 'treating [a local branch] as if they weren't local',
but instead as a single command to merge branches regardless of whether they are
local or remote.

Suggesting git-merge is what requires the user to make a distinction between local
and remote branches.

> It's also now pretty common to want to do "git fetch <remote>", inspect 
> it, decide whether this is something you want to merge (and depend on), 
> and do "git merge <tracking>" to include it in your branch if you want it. 
> (And being able to fetch stuff from a remote location, and later do a 
> merge without any non-local information is also very git-style.)

Yes, I agree that it is common to fetch and inspect before merging. The
'git merge <tracking>' could have been 'git pull . <tracking>', which only
requires typing one additional character. The user _must_ know how to use
git-pull, and the concept of '.' as a placeholder for the local repository
takes only a moment to digest. git-merge is an additional command that the
user must know when to use and when not to use. Well maybe that exaggerates
the point a little, git-merge is not that complicated, but it is an additional
command to learn with little benefit that I see.

To summarize my point, I think the recommended advertised merge command could
be one single command 'git-pull' and that it should be used in the documentation
in preference to 'git-merge'. It seems to me that this simplifies the user
interface and requires the user to master fewer commands before becoming productive.

Also, I thought this was already the status-quo and so I have been surprised by the
increasing suggestions to use git-merge on the mailing list. I saw it as something
similar to suggestions I've seen to use git-reflog (not porcelain) rather than
'git-log -g' (porcelain).

-brandon
