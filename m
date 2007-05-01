From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn failure when symlink added in svn
Date: Tue, 01 May 2007 10:49:54 -0700
Message-ID: <m2wszsigcd.fsf@ziti.local>
References: <alpine.LFD.0.98.0704271100321.9964@woody.linux-foundation.org>
	<loom.20070428T144858-521@post.gmane.org>
	<7virbgjthr.fsf@assigned-by-dhcp.cox.net>
	<m2odl8fjv1.fsf@ziti.fhcrc.org>
	<7v7irwjql6.fsf@assigned-by-dhcp.cox.net>
	<m2k5vwfbf6.fsf@ziti.fhcrc.org>
	<7vwszwi0h2.fsf@assigned-by-dhcp.cox.net> <m2irbfqlze.fsf@ziti.local>
	<20070429182649.GD12375@untitled> <m24pmxrkgt.fsf@ziti.local>
	<20070430154359.GD1800@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 01 19:50:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiwUG-0000Ud-7I
	for gcvg-git@gmane.org; Tue, 01 May 2007 19:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094AbXEARt7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 13:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755161AbXEARt7
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 13:49:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:46216 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755094AbXEARt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 13:49:58 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1970575wra
        for <git@vger.kernel.org>; Tue, 01 May 2007 10:49:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=oqHRr2hd6xGftn1sLjWw9wpno0p/z6P850UIsYQjKFvOkigDXXDe0LDdpGkTan4xBdFwGf3d78QFyjI1FwFZ1ptGA4SA1v3W916E0jV0V5lQvglB1HDBIYDCQXJDfB+QkbJz8jCqin5pS0a0sZvQAr3foSMlr6x4m6lbw9HAQkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=hMp6iJ5YlkHsRWFGA+UlSa5puZK2/k/39u42NkmGP9EqXp5MnuLa8B9X9shAUFrNQYJ/kXXlMCwzFJR7c3vFjiWOWDzhDG1grrY6Q8+EVjsnLE7q1XCn8U6fq2jzs7ltbyQMRpO8sbUBtpNlHrM7WMj+bCCMNiyM6Rug2KUGNRU=
Received: by 10.114.180.1 with SMTP id c1mr2450052waf.1178041796542;
        Tue, 01 May 2007 10:49:56 -0700 (PDT)
Received: from ziti.local ( [140.107.181.228])
        by mx.google.com with ESMTP id q20sm5251319pog.2007.05.01.10.49.55;
        Tue, 01 May 2007 10:49:55 -0700 (PDT)
In-Reply-To: <20070430154359.GD1800@untitled> (Eric Wong's message of "Mon, 30 Apr 2007 08:43:59 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45964>

Eric Wong <normalperson@yhbt.net> writes:

> Seth Falcon <sethfalcon@gmail.com> wrote:
>> Eric Wong <normalperson@yhbt.net> writes:
>> 
>> > Seth Falcon <sethfalcon@gmail.com> wrote:
>> >> Eric: is there any way to undo some of the svn revs that have been
>> >> retrieved using git-svn fetch and then refetch them? 
>> 
>> > Assuming you're not using something crazy like noMetadata, you can just
>> > use update-ref on the remote heads to the last known good revisions and
>> > remove the associated .rev_db files.
>> >
>> > Otherwise you'll have to delete entries from the .rev_db files, the
>> > format is one line per-revision, the revision is the line number of the
>> > file.
>> 
>> Hmm, not sure I understood.  Here's what I tried:
>> 
>> I'm tracking two branches via git-svn.  For each, I used git log
>> remotes/<branch> to find a revision that I expect to be ok and noted
>> the sha1.  Then I did: 
>> 
>>     git-update-ref remotes/git-svn a27b11c1
>
> You may need to specify "refs/": "refs/remotes/git-svn".
> Is there a .git/remotes/git-svn ref file now?

Yes.  I removed those and redid the git-update-ref specifying
refs/remotes/git-svn and the branch I have.

>> Did I miss a step or misunderstand how to undo?  What's strange is
>> that if I do git show 0f12c8c, I see a patch that is looks like it came
>> from a fetch using the my broken version of git-svn -- do I need to
>> clear out objects before refetching?
>
> I might have left some steps (I've been all over the place lately :/).
> You probably need to do all that and also need to edit
> .git/svn/.metadata and set the {branches,tags}-maxRev fields to the last
> known good revisions if you use globs.

I ran git-gc --prune.  I also took a look at .git/svn/.metadata, but
all I have there is:

    ; This file is used internally by git-svn
    ; You should not have to edit it
    [svn-remote "svn"]
            uuid = 00db46b3-68df-0310-9c12-caf00c1e9a41

So I left that alone.  I tried refetching and end up with the
following error after the rev dbs were rebuilt:

    error: invalid object 67e31e0ada47e8e9d15547ff1a48298869b3907b
    fatal: git-write-tree: error building trees
    write-tree: command returned error: 128

I found a backup of this repository and will use that.  Since I have a
backup, it isn't worth the effort.  I think the obvious lesson is to
use a copy of a repos when testing git-svn so you can throw it away if
things go awry.

+ seth
