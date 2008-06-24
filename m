From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 00:54:38 -0700 (PDT)
Message-ID: <m3mylbl0xb.fsf@localhost.localdomain>
References: <alpine.LFD.1.10.0806232356340.2979@xanadu.home>
	<1978205964779154253@unknownmsgid>
	<32541b130806232220r292d691cn5bf5f9976126aa29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David Jeske" <jeske@google.com>, "Nicolas Pitre" <nico@cam.org>,
	git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 09:55:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB3NI-00061Z-Lg
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 09:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbYFXHyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 03:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbYFXHyl
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 03:54:41 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:36700 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbYFXHyk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 03:54:40 -0400
Received: by an-out-0708.google.com with SMTP id d40so676502and.103
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 00:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=Sww+UscuRBghnLkl+fusU/GVow4INoiVvBdMK4Ci5Ts=;
        b=RcY7wWMO4K7+iKy74YynXJexq+Z4nxvtfEXed6nRwzj8tLdcLQrUJC6zCqK1dgt0p6
         9hxdqyU/MkhKgF1NDUvu+AyKilXV77xN1uM4AHkYRugwzsGQUfmafsZEPkega1RysYzE
         lHuCwwNiF+PTUWqsBJWptmE+Np4LwjPLFrZZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=deDScgVQxMJFhWfhDSY+AGpQtHP/pBUZK9T0g+VAirSxuh/kwAYCwfoiOFW1fS3ZLP
         Xw/cOVDPCFnMLMZYkhtJI85gvfeExh4s5ZmVe4DuKsJdEQmo2YbKQVhe3RengeievPg3
         tNUxayaU/5Cg+50J6iUFpf+eRe+uxhgo9F8fA=
Received: by 10.100.152.15 with SMTP id z15mr15234401and.138.1214294079516;
        Tue, 24 Jun 2008 00:54:39 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.195.249])
        by mx.google.com with ESMTPS id b37sm13719087ana.33.2008.06.24.00.54.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 00:54:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5O7wAOU005496;
	Tue, 24 Jun 2008 09:58:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5O7w87A005493;
	Tue, 24 Jun 2008 09:58:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <32541b130806232220r292d691cn5bf5f9976126aa29@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86005>

It looks like for some reason not all messages made it to git mailing
list, at least when using GMane to read git mailing list.  Strange...

"Avery Pennarun" <apenwarr@gmail.com> writes:
> On 6/24/08, David Jeske <jeske@google.com> wrote:

>> I moved a branch around and then deleted it, and I don't see any
>> record in the reflog of where it was, or that it ever was.

Deleting branch (BTW. git prints warning when deleting branch can
result in [temporary] loss of [easy access to] some commits) deletes
its reflog[*1*], but you can still use HEAD reflog ("what was checked
out" reflog).

>> Am I missing something about how branches are used? I see some
>> language in "git tag" about how attempts are made to assure that
>> others can't move around semi-immutable tags during push, but I
>> don't see any such language about branches. What prevents someone
>> from accidentally deleting an old branch that nobody is watching,
>> but is important to the history and then not noticing as gc
>> silently deletes the old deltas?

BTW. branches _deletions_ are not by default transferred (even if
using globbing refspecs, which is not default); you have to use 
"git remote prune <remote nick>" to remove remote-tracking branches
which track branches that got deleted on remote.

Besides nobody and nothing can fully protect you from your stupidity.
You can "accidentally" do 'rm -rf .git' for example :-/

>> I've had need to pull out versions several years old multiple times
>> in my career, so this is the kind of thing I'm thinking about.

The answer is: don't delete branches accidentally ;-).

Seriously, in any sane workflow you have several long lasting
branches, be it 'maint', 'master', 'next' or be it 'maintenance',
'stable'/'mainline'/'trunk', 'devel', into whose you merge in
[temporary, short lived] topic branches when topic is ready for
inclusion.  And you NEVER delete such branches (git can't protect you
from deletion any more than Linux can protect you if you do "rm -rf ~"). 

Any commit for whose there is parentage line from one of those
long-lived "development" branches would be protected from pruning
during git-gc run.

> git branches are actually a very different concept from branches in,
> say, subversion.
> 
> In subversion, a branch is normally created so that you can do
> parallel development, and then you merge whole batches of changes
> (with 'svn merge') from one branch into another.  When you do this,
> you create a single new commit in the destination branch that contains
> *all* the changes.  So if you want to look back in history to see who
> did which part of the change for what reason, you have to go back to
> the branch you merged *from*.  Thus, it's very important in subversion
> that old branches never disappear.
> 
> git's philosophy is different.  Branches are really just "temporary
> tags".

I'd rather say thay branches (refs/heads branches) are "growth points"
of graph (diagram) of revisions (versions).  (This graph is called DAG
in git documentation, because it is Directed Acyclic Graph).

But it is true that in git branches are just _pointers_ to the DAG
of commits.  All data is kept in the content addressed object database
which is git repo storage, and parentage links are contained in commit
objects.

> A merge operation doesn't just copy data from one branch to
> another: it actually joins the two histories together, so you can then
> trace back through the exact history of the merged branches, commit by
> commit.  "git log" will show each checkin to *either* branch
> individually, instead of just one big "merge" checkin.

Let me help explain that using some ASCII-art diagram.  You need to
use fixed-width (non-proportional) font to view it correctly.  Time
flows from the left to right.

Let's assume that we have the following state: some history on branch
'master': 

       object database              refs information
    /-------------------\        /---------------------\
   
     .<---.<---.<---A             <--- master <=== HEAD

For the commits the "<---" arrow means that commit on the right side
of arrow has commit on the left hand side of arrow as its parent
(saved in the multi-valued "parent" field in the commit object).  For
the references "<---" arrow means that branch master points to given
commit, and "<===" means symbolic reference, i.e. that ref points to
given branch (you can think of it as symlink, and it was some time ago
implemented as such).

Now assume that we created new branch 'test', and we have comitted
some revisions being on it:

     .<---.<---.<---A             <--- master
                     \
                      \-B<---C    <--- test     <=== HEAD

Let's assume that we, or somebody else, did some work on 'master'
branch (to not confuse you with the "fast-formward" issue):

     .<---.<---.<---A<---X<---Y    <--- master
                     \
                      \--B<---C    <--- test     <=== HEAD

Now we have finished feature which we tried to develop in 'test', so
we merge changes back to 'master':

     .<---.<---.<---A<---X<---Y<---M       <--- master <=== HEAD
                     \            /
                      \--B<---C<-/         <--- test

Note how merge commit 'M' has two parents.

Now if we were to delete branch 'test' now:

     .<---.<---.<---A<---X<---Y<---M       <--- master [<=== HEAD]
                     \            /
                      \--B<---C<-/

it is only pointer that gets deleted (and reflog[*1*]).  All commits
which were on this branch are 'reachable', so they never would get
deleted, even if [HEAD] reflog expires[*2*].

> The end result is that even if you delete the source branch after
> doing a merge, nothing is actually lost.  Thus, there's no reason for
> git to try to make branches impossible to lose, as they are in svn.
> In the event that you really needed that branch pointer, it's in the
> reflog, as a few people have pointed out.

s/in the reflog/in the HEAD reflog/.

See above for explanation with pictures (or if you want some graphics,
take a look at presentations linked from GitLinks page and/or
GitDocumentation page on git wiki, http://git.or.cz/gitwiki/).

HTH

Footnotes:
==========
[*1*] There was an effort to create some sort of 'Attic' / 'trash can'
for deleted reflogs, but I guess it got stalled.  There is techical
issue caused by the fact that reflogs are stored as files, and you can
have so caled file<->directory conflict, when you deleted branch
'foo', and created branch 'foo/bar'.

[*2*] You can always write "never" as time to expire, and it even
works now ;-)
-- 
Jakub Narebski
Poland
ShadeHawk on #git
