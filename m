From: Ittay Dror <ittay.dror@gmail.com>
Subject: Re: switching upstream tips
Date: Wed, 13 May 2009 10:33:44 +0300
Message-ID: <4A0A77D8.3030000@gmail.com>
References: <4A0A6BD1.7050907@gmail.com> <81b0412b0905130019x114d53d1v86833217bff613bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 09:34:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M48yX-00027e-QW
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 09:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbZEMHdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 03:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbZEMHdw
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 03:33:52 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:1716 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbZEMHdv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 03:33:51 -0400
Received: by qw-out-2122.google.com with SMTP id 5so379490qwd.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 00:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=gKeNOEH8WgvQ46bCJHEoioBUiUuTxUTQ4Nb0OeK6pSE=;
        b=tJU3X3Lu6nUvyaYU4CKYvhkYgjYm3e7HOXLdQHM+W7u8BlAz6mltp2gpXAAoiY4324
         Npk6YnHcfXTw+ov7Ex786pHhb2n3nwFJIMObSfS1ZzAgYrHdmP7WB9rtVOHfEn+EZeA1
         Da3FaaU+RbTyOSVRDBQZY9pcZZ5Q56C6GCLBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=uNSFbYRnL4iZM1hMfzRCcyK8+Q5cCq+Wa4r0ZKNHHo8Tp5MbBu2rEWd6MkQPCzLq6g
         yzFIf9K9Bw9khVm4F5lcvsPBB65KtThvxn6lrP5G8GjIdFQDX11vHefGCXuVbdBdcYgI
         NuhbMIQ2Gy9KeNagAzWudpvNvdnnD5ZBBY0Oc=
Received: by 10.220.75.73 with SMTP id x9mr382783vcj.56.1242200031714;
        Wed, 13 May 2009 00:33:51 -0700 (PDT)
Received: from ?10.10.2.8? ([212.143.191.180])
        by mx.google.com with ESMTPS id 4sm2558293yxj.17.2009.05.13.00.33.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 00:33:51 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <81b0412b0905130019x114d53d1v86833217bff613bc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118993>



Alex Riesen wrote:

> 2009/5/13 Ittay Dror <ittay.dror@gmail.com>:
>   
>> I'm working on a repository in github that is forked from another
>> repository. I've committed several times and pulled (merged) from the
>> upstream a few times (so the committs are interleaved). The upstream
>> repository is a clone of an SVN repository (in apache). The project has
>> switched svn repositories (moved from incubation to top level project) and
>> so created a new repository in github.
>>     
>
> That's evil.
>
>   
>> * Reorder my history so that my commits are on top of the tip of the old
>> upstream repository.
>>     
>
> Look at "git rebase -i" (interactive rebase)
>   
well, i was hoping for something more automatic. git rebase will list 
all commits without author, so i'll have to manually figure which of 
them is mine from the commend and reorder
>   
>> * Change the upstream repository reference so it points to the new
>> repository
>>     
>
> Just edit your .git/config and re-fetch.
>   
but then git suddenly sees a bunch of new objects (because of the svn 
changes) and i get a lot of conflicts. note that it is not the directory 
structure that changed, just the svn repository which is included in the 
commit comment (by git-svn) and so changes the commit sha1.
>   
>> * Apply my commits on top of the new upstream repository
>>     
>
> You can try to cherry-pick your commits (git cherry-pick).
> Maybe rename detection will be enough to apply your changes
> as is. But as far as I understand, the path names in the new
> upstream are now all different (moved a level up?).
> You can save your commits in a mbox:
>
>    git format-patch -o mbox old-upstream..your-last-commit
>
> Edit the paths in the mbox and try to apply the result:
>
>    git am -3 result.mbox
>
> Or, you can use git filter-branch to modify the old history as if it
> was always operating on the directory structure of the new
> upsteam (assuming it is possible, of course). See manpage
> of git filter-branch, there is an example (look for "move the whole
> tree into a subdirectory").
>   
