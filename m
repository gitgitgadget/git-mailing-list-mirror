From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: howto to run git without a master branch
Date: Sun, 09 Mar 2014 15:16:23 -0700
Message-ID: <531CE837.1080504@gmail.com>
References: <531B8D91.6020800@ist.utl.pt> <531C1C69.6080809@web.de> <531CC6FE.2040803@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos Pereira <jose.carlos.pereira@ist.utl.pt>,
	=?ISO-8859-1?Q?Torst?= =?ISO-8859-1?Q?en_B=F6gershausen?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 09 23:16:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMm1R-0000Mx-3G
	for gcvg-git-2@plane.gmane.org; Sun, 09 Mar 2014 23:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbaCIWQh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Mar 2014 18:16:37 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:34293 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbaCIWQg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2014 18:16:36 -0400
Received: by mail-pb0-f54.google.com with SMTP id ma3so6398705pbc.41
        for <git@vger.kernel.org>; Sun, 09 Mar 2014 15:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+lACMzmA5e8ydNpRcramNK9UVLBwdqXhfrYACM6wST8=;
        b=KmiEViKkvWfiNpCAsM5k4ItDeZajUPzVI0/Vt1XYEgcE1/D1M9rwB+pH3yjnyx/3Dt
         jKCbOk84WqCJgx+kDnrouMYLkd8dGZbPR+cuYYPLQDPhlx36Is6BlXVt1h5S5eL0auqN
         rJ5iGsltlLc5Cuw8i5hc2bdl3YGxs74asRirEY6rTxNK6QEh731uquEtXcJMbA65xREa
         ON/cf6BJz298IllDIID8kW4VmmNrtKuqwpdkpgbVI1RF4Z3NveQPLYI9SG+o1SHwMrpN
         1OR2X0fnUtY2sasIonhR0Vr+n6/wUzXN7FOKREwzy0bDPohWgYT8vg9Md7B+aFu4fdu9
         jrPw==
X-Received: by 10.67.14.231 with SMTP id fj7mr35644706pad.115.1394403395969;
        Sun, 09 Mar 2014 15:16:35 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id x9sm17471487pbu.1.2014.03.09.15.16.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Mar 2014 15:16:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <531CC6FE.2040803@ist.utl.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243701>

On 3/9/2014 12:54 PM, Carlos Pereira wrote:
> On 03/09/2014 07:46 AM, Torsten B=F6gershausen wrote:
>>> After creating a local repository with these two branches, and a=20
>>> server repository with git init --bare, and pushing the two branche=
s:
>>> >  >  git remote add originfoo@bar:~/path/test.git
>>> >  git push origin master-g
>>> >  git push origin master-x
>>> >  >  everything seems fine, but cloning:
>>> >  git clonefoo@bar:~/path/test.git
>>> >  terminates with a warning: remote HEAD refers to nonexistent ref=
,=20
>>> unable to checkout.
>> This is because Git is trying to be nice:
>> When you clone, it tries to checkout a branch for you.
>>
>> What happens when you only have 1 branch, lets say master-x?
>> If I clone the bare repo here, with only 1 branch, this branch
>> is automatically checked out (tested on 1.8.5.2)
>>
>> What happens when you have 2 branches on the server?
>> Git really can not make a decision which one is the right one to=20
>> check out for
>> you, so if you have 2 branched like "master" and "develop", it check=
s=20
>> out the
>> "master" branch for you.
>>
>> But if you have "master-x" and "master-g" then Git has no clue, whic=
h=20
>> one could
>> be you favorite one (and neither have I)
> The problem is on the server repo, the cloned repo is just a=20
> consequence. After initializing the server repo and pushing two=20
> branches master-g and master-x there is no master branch. Therefore=20
> the HEAD file should not point to a master branch that does not exist=
:=20
> ref: refs/heads/master
>
> It could point to master-g (the first branch to be pushed) or master-=
x=20
> (the last branch to be pushed), depending of the criterion used by=20
> git, but pointing to something that does not exist seems weird and is=
=20
> the cause of the further complaints when the whole repository is=20
> cloned...

There is a "git remote set-head" to manipulate HEAD in a remote reposit=
ory.

The fact that it is not set when you push master-x and master-y could b=
e=20
justified to some extent.
I think that this only applies to a case when you are pushing into a=20
repository that have no branches.
Consider that you do not have to push only one branch, you may push any=
=20
set of branches you want.  And I do not think that branches in the set=20
have any meaningful order.
Also, your local HEAD does not necessary point to the "most reasonable=20
branch to checkout when you clone".  It is just your current branch.
Now the questions is, how should the remote repository determine what t=
o=20
change HEAD to?

I agree that this might be viewed as a user experience issue.
But I can not come up with a possible solution.  Can you?

> I forgot to say that the git version is 1.7.2.5 in both the initial=20
> repo and the server repo (probably this issue was fixed in newer=20
> versions?)
>
> As I said, editing directly the HEAD text file on the server, and=20
> replacing master by master-g (or master-x) seems to solve the problem=
=2E=20
> My question is: is that enough? or shall I expect further issues down=
=20
> the road?

I do not think there should be any issues.
Basically if your repository is not using master as the "most reasonabl=
e=20
branch to checkout when you clone" you need to do "git remote set-head"=
=20
when you are preparing the shared repository.
I guess that in most setups there will be just one shared repository.
