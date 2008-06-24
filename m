From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: git-fetch remote tag to local branch fails
Date: Tue, 24 Jun 2008 16:57:02 +0200
Message-ID: <g3r1vv$7dr$1@ger.gmane.org>
References: <33f4f4d70806240517h5e3ae420h263dd0c2d6bae459@mail.gmail.com>	 <8aa486160806240638o221b01d2i2f46cc8f0f3760a3@mail.gmail.com> <33f4f4d70806240701o1c00cef2g688a188970964b0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 16:58:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB9yP-0006vg-Rw
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 16:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760408AbYFXO5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 10:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760385AbYFXO5V
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 10:57:21 -0400
Received: from main.gmane.org ([80.91.229.2]:43309 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760329AbYFXO5U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 10:57:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KB9xM-0004Wy-4s
	for git@vger.kernel.org; Tue, 24 Jun 2008 14:57:16 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 14:57:16 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 14:57:16 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <33f4f4d70806240701o1c00cef2g688a188970964b0f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86067>

Klas Lindberg venit, vidit, dixit 24.06.2008 16:01:
> Hello
> 
>> git tag -l
> foo_tag
> test_tag
> 
>> git branch -a
>>
> 
> At this point, I can create the branch "b" from "foo_tag", so the
> fetch did get me a remote tag. It just didn't update a local branch
> with the contents (or create a new one).
> 
> Something that also confuses me is that if branch "b" already exists, then
> 
>> git-pull bogustree refs/tags/foo_tag:refs/heads/b
> 
> actually does update branch "b". I find the behaviour quite inconsistent.

You tell git to fetch everything up to the tag you specify, to store 
those refs into branch b, and then to merge into the current branch. 
This is what git did (assuming you see the merge in the current branch; 
if it's b then it has been fast forwarded already).

> Unfortunately it isn't a solution for me to fetch tags and then create
> branches from the tags. I need to be able to update existing branches,
> and I have to do that without first making such a branch the current
> branch.

If I try what you described (using git 1.5.6) in a fresh repo (with one 
empty commit) I get:

git fetch ../fromrepo refs/tags/testtag:refs/heads/newbranch
warning: no common commits
remote: Counting objects: 18, done.
remote: Compressing objects: 100% (18/18), done.
remote: Total 18 (delta 9), reused 0 (delta 0)
Unpacking objects: 100% (18/18), done.
 From ../fromrepo
  * [new branch]      testtag    -> newbranch
  * [new tag]         testtag    -> testtag

I see a new branch, disconnected from master (no common commits), and a 
new tag pointing to the head of newbranch. All is well here. Maybe you 
can set-up a minimal example or share a repo which exposes your problem?

Michael
