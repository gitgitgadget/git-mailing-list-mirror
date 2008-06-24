From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 20:19:44 +0300
Message-ID: <48612CB0.2070303@panasas.com>
References: <jeske@willow=01l5V7waFEDjChmh>	<willow-jeske-01l5PFjPFEDjCfzf-01l5V7wbFEDjCX7V> <willow-jeske-01l5cKsCFEDjC=91MX> <48612ABE.6000104@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 19:21:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBCCY-0005hS-IW
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 19:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758875AbYFXRUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 13:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758552AbYFXRUJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 13:20:09 -0400
Received: from gw-colo-pa.panasas.com ([66.238.117.130]:4322 "EHLO
	natasha.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758282AbYFXRUI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 13:20:08 -0400
Received: from daytona.int.panasas.com (daytona.int.panasas.com [172.17.28.41])
	by natasha.panasas.com (8.13.1/8.13.1) with ESMTP id m5OHK2bW012476;
	Tue, 24 Jun 2008 13:20:02 -0400
Received: from bh-buildlin2.bhalevy.com ([172.17.28.119]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Jun 2008 13:19:46 -0400
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <48612ABE.6000104@panasas.com>
X-OriginalArrivalTime: 24 Jun 2008 17:19:46.0622 (UTC) FILETIME=[80140DE0:01C8D61E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86092>

Boaz Harrosh wrote:
> David Jeske wrote:
>> As a new user, I'm finding git difficult to trust, because there are operations
>> which are destructive by default and capable of inadvertently throwing hours or
>> days of work into the bit bucket.
>>
>> More problematic, those commands have no discernible pattern that shows their
>> danger, and they need to be used to do typical everyday things. I'm starting to
>> feel like I need to use another source control system on top of the git
>> repository in case I make a mistake.  My philosophy is simple, I never never
>> never want to throw away changes, you shouldn't either. Disks are cheaper than
>> programmer hours. I can understand wanting to keep things tidy, so I can
>> understand ways to correct the 'easily visible changes', and also avoid pushing
>> them to other trees, but I don't understand why git needs to delete things.
>>
>> For example, the following commands seem capable of totally destroying hours or
>> days of work. Some of them need to be used regularly to do everyday things, and
>> there is no pattern among them spelling out danger.
>>
>> git reset --hard          : if another branch name hasn't been created
> 
> git reset --hard is special see below
> 
>> git rebase
>> git branch -D <branch>    : if branch hasn't been merged
>> git branch -f <new>       : if new exists and hasn't been merged
>> git branch -m <old> <new> : if new exists and hasn't been merged
>>
> The rest of the commands are recoverable from the log as people said
> but "git reset --hard" is not and should be *fixed*!
> 
> I use git reset --hard in to separate and distinct functions.
> One - to move current branch head around from place to place.
> Two - Throw away work I've edited
> 
> It has happened to me more then once that I wanted the first
> and also got the second as an un-warned bonus, to the dismay 
> of my bosses. (What do I care if I need to write all this code
> again)
> 
> I would like git-reset --hard to refuse if a git-diff HEAD
> (both staged and unstaged) is not empty. with a -f / -n logic
> like git-clean. (like git-clean none default config file override)
> 
> Now I know that the first usage above could be done with
> git-branch -f that_branch the_other_branch. But that can
> not be preformed on the current branch and local changes
> are not lost.
> 
> Lots of other potentially destructive git-commands check for local
> changes and refuse to operate. To remedy them git-reset --hard
> is recommended. I would prefer if there was a git-reset --clean -f/-n
> for the first case and git reset --hard only for the second usage
> case.
Sorry
git-reset --clean -f/-n for removing local changes
git reset --hard for moving HEAD on a clean tree only
> 
> My $0.017
> Boaz
> 
