From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: howto to run git without a master branch
Date: Sun, 09 Mar 2014 08:46:49 +0100
Message-ID: <531C1C69.6080809@web.de>
References: <531B8D91.6020800@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Carlos Pereira <jose.carlos.pereira@ist.utl.pt>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 09 08:47:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMYRq-0003jh-T7
	for gcvg-git-2@plane.gmane.org; Sun, 09 Mar 2014 08:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbaCIHqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2014 03:46:55 -0400
Received: from mout.web.de ([212.227.15.4]:65429 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbaCIHqz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2014 03:46:55 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LgpNC-1WzksP0BdO-00oF8a; Sun, 09 Mar 2014 08:46:51
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <531B8D91.6020800@ist.utl.pt>
X-Provags-ID: V03:K0:6PJWFVMfEsr7Moo6Jnc3e0CUWTYe/Nw75OQEcnzqje4K/kf+sI2
 ZpPegU5WccyO+Z/f7bBn7vqGip/8XppPhkVDk8M4sPq4vf2HEh1xJ1vY23NnkGj/nxD/IEk
 Nq/yQvLPF7qpOul7NtyX8jd/B3HfkWbyo1YjQsQacWGZVrONGQXd3ZMN0ywhay5ZpyEf07N
 iVvxdrjYEQYfkk0C8bAdw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243689>

On 2014-03-08 22.37, Carlos Pereira wrote:
> Hi,
> git newbie here.
> 
> I would like to work with two main branches: master-g and master-x, instead of the usual master, and apparently git does not like this.
> 
> After creating a local repository with these two branches, and a server repository with git init --bare, and pushing the two branches:
> 
> git remote add origin foo@bar:~/path/test.git
> git push origin master-g
> git push origin master-x
> 
> everything seems fine, but cloning:
> git clone foo@bar:~/path/test.git
> terminates with a warning: remote HEAD refers to nonexistent ref, unable to checkout.
This is because Git is trying to be nice:
When you clone, it tries to checkout a branch for you.

What happens when you only have 1 branch, lets say master-x?
If I clone the bare repo here, with only 1 branch, this branch
is automatically checked out (tested on 1.8.5.2)

What happens when you have 2 branches on the server?
Git really can not make a decision which one is the right one to check out for
you, so if you have 2 branched like "master" and "develop", it checks out the
"master" branch for you.

But if you have "master-x" and "master-g" then Git has no clue, which one could
be you favorite one (and neither have I)

What does "git branch" say?
(I think nothing)
What does "git branch -r" say?
(I think "origin/master-g" and "origin/master-x")
  
> 
> On the original local repository, I have:
>>cat HEAD
> ref: refs/heads/master-x
> 
> But on the server repository or the clone repository, HEAD points to master branch, that does not exist:
>>cat HEAD
> ref: refs/heads/master
> 
> Replacing in the HEAD file, master by master-g (on the server before cloning, or on the clone after cloning) seems to solve the problem.
> 
> Shall I worry about this? does my fix (editing directly HEAD on the server) fixes really the problem? 

No

>what would be the correct procedure to avoid this?
(Don't worry if there is a warning, when Git tries to be nice)
(Or feel free to send a patch to this list which improves the user experience)

> 
> Thank you!
> Carlos Pereira,
