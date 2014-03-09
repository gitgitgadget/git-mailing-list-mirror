From: Kevin <ikke@ikke.info>
Subject: Re: howto to run git without a master branch
Date: Sun, 9 Mar 2014 21:00:25 +0100
Message-ID: <CAO54GHCALveaT9XSE+SvQLp7a09dy8NvqDc6ajC5TZsFGmFJ_A@mail.gmail.com>
References: <531B8D91.6020800@ist.utl.pt> <531C1C69.6080809@web.de> <531CC6FE.2040803@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git <git@vger.kernel.org>
To: Carlos Pereira <jose.carlos.pereira@ist.utl.pt>
X-From: git-owner@vger.kernel.org Sun Mar 09 21:01:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMjuQ-0007xI-1T
	for gcvg-git-2@plane.gmane.org; Sun, 09 Mar 2014 21:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbaCIUAr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Mar 2014 16:00:47 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:40462 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbaCIUAq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Mar 2014 16:00:46 -0400
Received: by mail-yh0-f53.google.com with SMTP id i57so3281513yha.40
        for <git@vger.kernel.org>; Sun, 09 Mar 2014 13:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=Yhwov3+TXs4Ftn7N5cRzgO1X7GTAdm4FZiDnxwwfqiA=;
        b=pUsXs4VV0rBsHKPhXaZy9rd+o6jnkNe2sS/K+HCzuhwZIgFXZ/CJRGuj0sR7WVTzMq
         pHiP86tugkSY4xcKZszKuXjru5fjx81hJcY9e9Y8sWkymVuieuMeKPT4uLxD8hWSjPWh
         6x7Jjsvl+u7XNZhpcvBJIEaNjzpDHO3kVFUO8d2OrFRCnpYyZ8i0WiqomkYs9j0iFM4l
         iXaHh+FwSOy90ucIfnyDMabwQW9kIw6u9wKxwF58D4WfpvUFyVCC0nYzmmLStH0+MOGw
         WBHru7a5PCEjzmwNmE2mT3rXlYxLprv5SHmEZxBNhxgcaHrmOA/ayzjAIbpXLy70x4vx
         gbQQ==
X-Received: by 10.236.159.165 with SMTP id s25mr37339220yhk.24.1394395245871;
 Sun, 09 Mar 2014 13:00:45 -0700 (PDT)
Received: by 10.170.170.133 with HTTP; Sun, 9 Mar 2014 13:00:25 -0700 (PDT)
In-Reply-To: <531CC6FE.2040803@ist.utl.pt>
X-Google-Sender-Auth: ToutkryUqEo9DkhV_t0K--jSqjs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243700>

HEAD on the remote repo is indeed used to determine what to check out
when cloning. It's quite normal to change it to anything you like. To
change it, you usually use git symbolic-ref HEAD master-x instead of
directly editing that file.

On Sun, Mar 9, 2014 at 8:54 PM, Carlos Pereira
<jose.carlos.pereira@ist.utl.pt> wrote:
> On 03/09/2014 07:46 AM, Torsten B=C3=B6gershausen wrote:
>>>
>>> After creating a local repository with these two branches, and a se=
rver
>>> repository with git init --bare, and pushing the two branches:
>>> >  >  git remote add originfoo@bar:~/path/test.git
>>>
>>> >  git push origin master-g
>>> >  git push origin master-x
>>> >  >  everything seems fine, but cloning:
>>> >  git clonefoo@bar:~/path/test.git
>>>
>>> >  terminates with a warning: remote HEAD refers to nonexistent ref=
,
>>> > unable to checkout.
>>>
>>
>> This is because Git is trying to be nice:
>> When you clone, it tries to checkout a branch for you.
>>
>> What happens when you only have 1 branch, lets say master-x?
>> If I clone the bare repo here, with only 1 branch, this branch
>> is automatically checked out (tested on 1.8.5.2)
>>
>> What happens when you have 2 branches on the server?
>> Git really can not make a decision which one is the right one to che=
ck out
>> for
>> you, so if you have 2 branched like "master" and "develop", it check=
s out
>> the
>> "master" branch for you.
>>
>> But if you have "master-x" and "master-g" then Git has no clue, whic=
h one
>> could
>> be you favorite one (and neither have I)
>>
>
> The problem is on the server repo, the cloned repo is just a conseque=
nce.
> After initializing the server repo and pushing two branches master-g =
and
> master-x there is no master branch. Therefore the HEAD file should no=
t point
> to a master branch that does not exist: ref: refs/heads/master
>
> It could point to master-g (the first branch to be pushed) or master-=
x (the
> last branch to be pushed), depending of the criterion used by git, bu=
t
> pointing to something that does not exist seems weird and is the caus=
e of
> the further complaints when the whole repository is cloned...
>
> I forgot to say that the git version is 1.7.2.5 in both the initial r=
epo and
> the server repo (probably this issue was fixed in newer versions?)
>
> As I said, editing directly the HEAD text file on the server, and rep=
lacing
> master by master-g (or master-x) seems to solve the problem. My quest=
ion is:
> is that enough? or shall I expect further issues down the road?
>
> Thank you very much,
>
> Carlos
>
>> What does "git branch" say?
>> (I think nothing)
>> What does "git branch -r" say?
>> (I think "origin/master-g" and "origin/master-x")
>>
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
