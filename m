From: Carlos Pereira <jose.carlos.pereira@ist.utl.pt>
Subject: Re: howto to run git without a master branch
Date: Sun, 09 Mar 2014 19:54:38 +0000
Message-ID: <531CC6FE.2040803@ist.utl.pt>
References: <531B8D91.6020800@ist.utl.pt> <531C1C69.6080809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 09 20:41:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMjbN-0001Xn-BJ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Mar 2014 20:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbaCITld convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Mar 2014 15:41:33 -0400
Received: from smtp2.ist.utl.pt ([193.136.128.22]:40985 "EHLO smtp2.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbaCITlc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2014 15:41:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id F1D467000395;
	Sun,  9 Mar 2014 19:41:30 +0000 (WET)
X-Virus-Scanned: by amavisd-new-2.6.4 (20090625) (Debian) at ist.utl.pt
Received: from smtp2.ist.utl.pt ([127.0.0.1])
	by localhost (smtp2.ist.utl.pt [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id ulp9-X5batpN; Sun,  9 Mar 2014 19:41:30 +0000 (WET)
Received: from mail2.ist.utl.pt (mail.ist.utl.pt [IPv6:2001:690:2100:1::8])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id 58A85700039C;
	Sun,  9 Mar 2014 19:41:30 +0000 (WET)
Received: from [IPv6:2001:690:2100:1c0:7aac:c0ff:feff:eff7] (unknown [IPv6:2001:690:2100:1c0:7aac:c0ff:feff:eff7])
	(Authenticated sender: ist12604)
	by mail2.ist.utl.pt (Postfix) with ESMTPSA id 515C52003FD9;
	Sun,  9 Mar 2014 19:41:30 +0000 (WET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20121215 Icedove/3.0.11
In-Reply-To: <531C1C69.6080809@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243699>

On 03/09/2014 07:46 AM, Torsten B=F6gershausen wrote:
>> After creating a local repository with these two branches, and a ser=
ver repository with git init --bare, and pushing the two branches:
>> > =20
>> >  git remote add originfoo@bar:~/path/test.git
>> >  git push origin master-g
>> >  git push origin master-x
>> > =20
>> >  everything seems fine, but cloning:
>> >  git clonefoo@bar:~/path/test.git
>> >  terminates with a warning: remote HEAD refers to nonexistent ref,=
 unable to checkout.
>>     =20
> This is because Git is trying to be nice:
> When you clone, it tries to checkout a branch for you.
>
> What happens when you only have 1 branch, lets say master-x?
> If I clone the bare repo here, with only 1 branch, this branch
> is automatically checked out (tested on 1.8.5.2)
>
> What happens when you have 2 branches on the server?
> Git really can not make a decision which one is the right one to chec=
k out for
> you, so if you have 2 branched like "master" and "develop", it checks=
 out the
> "master" branch for you.
>
> But if you have "master-x" and "master-g" then Git has no clue, which=
 one could
> be you favorite one (and neither have I)
>   =20
The problem is on the server repo, the cloned repo is just a=20
consequence. After initializing the server repo and pushing two branche=
s=20
master-g and master-x there is no master branch. Therefore the HEAD fil=
e=20
should not point to a master branch that does not exist: ref:=20
refs/heads/master

It could point to master-g (the first branch to be pushed) or master-x=20
(the last branch to be pushed), depending of the criterion used by git,=
=20
but pointing to something that does not exist seems weird and is the=20
cause of the further complaints when the whole repository is cloned...

I forgot to say that the git version is 1.7.2.5 in both the initial rep=
o=20
and the server repo (probably this issue was fixed in newer versions?)

As I said, editing directly the HEAD text file on the server, and=20
replacing master by master-g (or master-x) seems to solve the problem.=20
My question is: is that enough? or shall I expect further issues down=20
the road?

Thank you very much,

Carlos
> What does "git branch" say?
> (I think nothing)
> What does "git branch -r" say?
> (I think "origin/master-g" and "origin/master-x")
>
>   =20
