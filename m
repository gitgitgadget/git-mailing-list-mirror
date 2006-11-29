X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Joseph Wakeling <joseph.wakeling@webdrake.net>
Subject: Re: git and bzr
Date: Wed, 29 Nov 2006 03:23:45 +0100
Message-ID: <456CEF31.8080600@webdrake.net>
References: <45357CC3.4040507@utoronto.ca> <20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com> <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com> <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com> <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com> <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr> <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net> <Pine.LNX.4.64.0611271834090.30076@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 29 Nov 2006 02:24:21 +0000 (UTC)
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
In-Reply-To: <Pine.LNX.4.64.0611271834090.30076@woody.osdl.org>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32606>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpF7H-00013V-OH for gcvg-git@gmane.org; Wed, 29 Nov
 2006 03:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758438AbWK2CXz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 21:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758443AbWK2CXz
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 21:23:55 -0500
Received: from alf.nbi.dk ([130.225.212.55]:44813 "EHLO alf.nbi.dk") by
 vger.kernel.org with ESMTP id S1758438AbWK2CXy (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 21:23:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by alf.nbi.dk
 (8.9.3/8.9.3) with ESMTP id DAA07776; Wed, 29 Nov 2006 03:23:46 +0100 (MET)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Thanks to everyone for your very detailed responses. :-)

On the subject of blame and pulling patches from unrelated branches,

Jakub Narebski wrote:
> In git repository can have unrelated branches. So you can fetch unrelated
> repository into your repository, and merge/cherry-pick from there
> if needed.

Sean wrote:
> The Git cherry-pick command lets you grab specific commits from
> other branches in your repo.  But cherry-pick works at the commit
> level, there is no easy way to grab a single function for instance
> and merge just its history into another branch.

Linus Torvalds wrote:
> pickaxe wasn't in the released version back when the discussions were 
> raging, but it's there now. Except it's really called "git blame" these 
> days (and "git annotate") since it's taken over both of those duties.
> 
> However...
> 
>> A frustration with bzr is that pulling or
>> merging patches from another branch or repo requires them to share the
>> same HEAD.  Is this a requirement in git or can I say, "Hey, I like that
>> particular function in project XXX, I'm going to pull that individual
>> bit of code and its development history into project YYY"?
> 
> ... it's not _quite_ that smart. It will only look for sources to new 
> functions from existing sources in the tree that preceded the commit that 
> added the function, so it will _not_ see it coming from another branch or 
> another project entirely.
> 
> So when you ask for code annotations (use the "-C" flag to see code moved 
> across from other files), it will still limit itself to just a particular 
> input set, and not go gallivating over all possible branches and projects 
> you might have in your repository.

So ... if I understand correctly, I can get patches from somewhere else,
but in the branch history, I will not be able to tell the difference
from having simply newly created them?

With regards to git blame/pickaxe/annotate, the idea of tracking *code*
rather than files was one thing that really excited me when I read about
it in the earlier discussion, and is probably the main reason I'm trying
out git.  I'd like to understand this properly so is there a simple
exercise I can do to demonstrate its capabilities?  I tried an
experiment where I created one file with two lines, then cut one of the
lines, pasted it into a new file, and committed both changes at the same
time.  But git blame -C on the second file just gives me the
time/date/sha1 of its creation, and no indication that the line was
taken from elsewhere.

Back to the more basic queries ... one more difference I've observed
from bzr, after playing around for a while, involves the commands to
undo changes and commits.  It looks like git reset combines the
capabilities of both bzr uncommit and bzr revert: I can undo changes
since the last commit by resetting to HEAD, and I can undo commits by
resetting to HEAD^ or earlier.

Some things here I'm not quite sure about:
(1) the difference between git reset --soft and git reset --mixed,
probably because I don't understand the way the index works, the
difference between changed, updated and committed.
(2) How to remove changes made to an individual file since the last commit.

Last, could someone explain the git merge command?  git pull seems to do
many things which I would need to use bzr merge for---I can "pull"
between branches which have diverged, for example.  I don't understand
quite what git merge does that's different, and when to use one or the
other.

Many thanks again to everyone,

