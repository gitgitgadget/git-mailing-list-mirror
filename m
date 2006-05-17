From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Git glossary: 'branch' and 'head' description
Date: Wed, 17 May 2006 21:13:51 +0200
Organization: At home
Message-ID: <e4fsla$oth$1@sea.gmane.org>
References: <e4f1ta$e07$1@sea.gmane.org> <7viro4ecao.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed May 17 21:14:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgRTa-0001bL-QH
	for gcvg-git@gmane.org; Wed, 17 May 2006 21:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWEQTO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 15:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWEQTO2
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 15:14:28 -0400
Received: from main.gmane.org ([80.91.229.2]:60549 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750995AbWEQTO1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 15:14:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FgRT8-0001SU-Rd
	for git@vger.kernel.org; Wed, 17 May 2006 21:14:02 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 May 2006 21:14:02 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 May 2006 21:14:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20227>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:

>> In 'Documentation/glossary.txt' we have:
>> ----  
>> branch::
>>         A non-cyclical graph of revisions, i.e. the complete history of
>>         a particular revision, which is called the branch head. The
>>         branch heads are stored in `$GIT_DIR/refs/heads/`.
>> ---- 
> 
> While technically it might be correct, the above description for
> "branch" completely misses the point in the context of other
> entries.  I do not recall when this entry was first written, but
> I suspect it probably predates other entries that talk about the
> same thing.

[cut long description]

The description you gave is nice, but it belongs in Tutorial rather than in
Glossary. Additionally it mainly deals with branches fron the 'revision
history' point of view, although the 'commit' point of view can also be
seen.

Glossary entry should be short, up to the point, and encompass al three
points of view: 

 a.) conceptual point of view, i.e. "branch is separate line of
development" (be it stable or development direction, introducing new
feature aka. 'topic', or following aka. 'tracking' changes in other
repository),

 b) revision history point of view, i.e. "on branch means, roughly,
reachable from branch head aka. tip", or "branch is lineage of history of
project" (somewhat mudded by merges[*1*], fork points[*2*] and multiple
roots). This is what current glossary entry tries to present,

 c) commit point of view, i.e. "branch tip is where we do commit
changes" (branch tip is [one of] parent(s) of current commit, and branch
tip is advanced to new commit).


[*1*] Problem with merges:
   
   ---.---.---A-\--.---.---.---B-- branch1
                 \
   ---.---.---C---*D---.---.---E-- branch2   
   
Does A belong to branch2? It is one of parents of commit D. We can assume
that only first parent in merges continues branch. But what if we have the
following history:

   ---.---.---A-\  <---- there was branch1 here
                 \
   ---.---.---C---*D---.---.---E-- branch2 

To which branch belongs A then?


[*2*] Problem with fork point

           /--1---2---3-- maintenance/stable/fixes branch  
          /
  ---A---B----C---D---E-- master/development branch

Following the ancestry chain we get that commit A is on branch 'maint' (it
is also on branch 'master'); git does not record fork points. Perhaps the
branch logging and/or per branch configuration could be used to resolve
this issue.

-- 
Jakub Narebski
Warsaw, Poland
