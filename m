X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: git pull and merging.
Date: Thu, 07 Dec 2006 12:16:24 +0530
Message-ID: <4577B8C0.3060200@gmail.com>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com> <Pine.LNX.4.63.0612061019350.28348@wbgn013.biozentrum.uni-wuerzburg.de> <cc723f590612060205p1fd26cd7u3c7efc723b0177de@mail.gmail.com> <200612061744.31213.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 06:46:57 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:newsgroups:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=m5+iKOqImtiSrb7lMpM5/4ssruCCND01w8wRyyggjGN70MdETHo+IhmqvoIPaSN4kzHV7+PPGMDMsGzJ3SgVvE5XC2lsUpu6uTHrgCQM8AaQpde3jcbSqKuhuBF2DitGftF0c3xbniduG42bVn/P/vvg16wakuQFudpBL6Qhshs=
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <200612061744.31213.Josef.Weidendorfer@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33555>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsD1t-0001Gr-Lv for gcvg-git@gmane.org; Thu, 07 Dec
 2006 07:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031732AbWLGGqq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 01:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031733AbWLGGqq
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 01:46:46 -0500
Received: from nz-out-0506.google.com ([64.233.162.226]:41151 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1031732AbWLGGqp (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec
 2006 01:46:45 -0500
Received: by nz-out-0102.google.com with SMTP id s1so284475nze for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 22:46:44 -0800 (PST)
Received: by 10.65.185.13 with SMTP id m13mr2897766qbp.1165474004381; Wed, 06
 Dec 2006 22:46:44 -0800 (PST)
Received: from ?217.236.224.183? ( [156.153.255.234]) by mx.google.com with
 ESMTP id e14sm320588qbe.2006.12.06.22.46.40; Wed, 06 Dec 2006 22:46:43 -0800
 (PST)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer wrote:
> On Wednesday 06 December 2006 11:05, Aneesh Kumar wrote:
>> [branch "devel"]
>>         remote = origin
>>         merge = devel
>>
>> [....]
>> Now i thought merge should be local reference. So i changed it to
>> merge = remotes/origin/devel.
>>
>> That also didn't work.
>>
>> Then i tried the name of the branch should be indicated as
>> "refs/heads/devel" . That also didn't work.
>>
>> So i guess i am missing something.
> 
> See man page of git-repo-config:
> 
>  branch.<name>.merge
>   When in branch <name>, it tells git fetch the default
>   remote branch to be merged.
> 
> I assume that the "devel" branch on the remote repo you cloned from
> is also "devel", more exactly "refs/heads/devel".
> 
> Now, instead of "git pull", git should default to
> 
> 	git pull origin refs/heads/devel:refs/remotes/origin/devel



this means the remote reference is refs/heads/devel and local tracking branch for that is refs/remotes/origin/devel.




> 
> ie. it should update the local tracking branch "refs/remotes/origin/devel"
> with the remote branch "refs/heads/devel".
> The tracking branch "refs/remotes/origin/devel" will be merged with current
> branch afterwards.
> 


That will be merged is the tricky part. 



> Now looking at the documentation for branch.<name>.merge, it talks
> about the remote branch, which is "refs/heads/devel" in your case, ie.
> the first part of the refspec of the full "git pull" command above.
> 

This is most confusing part. What merge indicate is not about refs/heads/devel
should track refs/remotes/origin/devel. That is specfied in the remote config option.

What merge indicate is that when in a local branch ( not the tracking one under remotes/origin)
which branch from remote need to be used to merge to the local branch.




> So, as you already posted (without explanation, therefore this mail),
> the config should be
> 
>  [branch "devel"]
>          remote = origin
>          merge = refs/heads/devel
> 
> However, "devel" alone should work here, as it can be matched with remote
> "refs/heads/devel". Seems to be a bug, as branch.<name>.merge seems to only
> being compared with the full canonical name in the implementation.


I guess we need to have a standard way of saying the branches. 

May be we want to document it in repo-config.

local branch on which changes can be made <branch-name>
local tracking branch refs/remotes/<remote-name>/<branch-name>
remote branch refs/heads/<branch-name>


