From: SungHyun Nam <goweol@gmail.com>
Subject: Re: git pull/merge master on other branch
Date: Fri, 09 May 2008 17:28:13 +0900
Message-ID: <g011ve$8ln$1@ger.gmane.org>
References: <g00nb3$dlm$1@ger.gmane.org> <200805090824.12772.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 10:29:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuNz1-00009q-Qy
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 10:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbYEII2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 04:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbYEII2u
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 04:28:50 -0400
Received: from main.gmane.org ([80.91.229.2]:41461 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752164AbYEII2r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 04:28:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JuNy4-0005Ep-II
	for git@vger.kernel.org; Fri, 09 May 2008 08:28:41 +0000
Received: from 203.238.196.197 ([203.238.196.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 May 2008 08:28:40 +0000
Received: from goweol by 203.238.196.197 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 May 2008 08:28:40 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 203.238.196.197
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <200805090824.12772.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81608>

Johan Herland wrote, at 5/9/2008 3:24 PM:
> On Friday 09 May 2008, SungHyun Nam wrote:
>> Hello,
>>
>> If I am on a branch (reguarly rebased), I don't want to switch to
>> master branch, but merge origin into master.
>> If I switch to master and pull and switch to branch, I have to
>> rebuild almost of sources.
>>
>> How I can pull origin into master without switching to master
>> branch?
> 
> You can't; merging requires use of the working tree (to resolve conflicts).
> 
> However, what you can do is make a local clone of your project (cheap,
> because it just hardlinks files from the original repo), and checkout the
> master branch in the clone, perform the merge (after having set up the same
> origin and retrieved its contents), and then fetch (or push) the result back
> into the original repo (remember: "fetch" instead of "pull", since the
> latter will initiate a merge with your current branch).

I tested and it seems work fine.

$ mkdir repo; cd repo; git init; echo 'aaa' > a; git add .; git ci -m 
'aaa'; cd ..
$ git clone repo t; cd t; git co -b test; cd ..
$ cd repo; echo 'bbb' >> a; git ci -m 'bbb' a; cd ..
$ git clone t t2; cd t2; git remote add central ../repo; git pull 
central master; git push origin; cd ..
$ cd t; git log; git log master; git rebase master

Did I do correctly?

Thanks,
namsh
