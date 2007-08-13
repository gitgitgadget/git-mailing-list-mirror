From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: msysgit: merge, stat
Date: Mon, 13 Aug 2007 23:31:29 +0200
Message-ID: <AAF0E632-AC7D-49E0-A332-96F78EABB1F6@zib.de>
References: <2C573942-DD22-46EC-AE4A-1334450A7C4D@zib.de> <Pine.LNX.4.64.0708131743360.25989@racer.site> <7vzm0vfbw0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 23:32:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKhWi-0007sr-Dk
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 23:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939733AbXHMVcX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 17:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936719AbXHMVcW
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 17:32:22 -0400
Received: from mailer.zib.de ([130.73.108.11]:44656 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S939615AbXHMVcR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 17:32:17 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7DLUpTV003438;
	Mon, 13 Aug 2007 23:30:55 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10789.pool.einsundeins.de [77.177.7.137])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7DLUgke016778
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 13 Aug 2007 23:30:43 +0200 (MEST)
In-Reply-To: <7vzm0vfbw0.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55787>


On Aug 13, 2007, at 9:54 PM, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Sun, 12 Aug 2007, Steffen Prohaska wrote:
>>
>>> After a 'git merge' in msysgit some stat information of the index
>>> doesn't match the working tree. Thus 'git diff' looks at files,
>>> which it shouldn't look at. I need to do a
>>> 'git update-index --refresh' before everything's in sync.
>>>
>>> Is this a know issue? Do other experience the same?
>>
>> Yes, it is.  The real issue is that the index is out of date, and  
>> the full
>> speed of git is not available until a refresh (which you can have  
>> with a
>> "git status", too).
>
> Wait a minute.
>
> What does the above "After a 'git merge'" exactly mean?  After a
> successful automerge that made a commit, of stopped in the
> middle because of conflicts?  I am getting an impression that
> Steffen is talking about the former, but if that is the case,
> somebody is seriously confused.

Yes. I'm talking about a successful merge that made a commit.


> When "merge-recursive" with a 3-way file level merge in core
> writes the result out to the work tree, it uses a cache entry
> that is stat clean (see merge-recursive.c::make_cache_entry(),
> refresh option is passed and it calls refresh_cache_entry() to
> obtain the cached stat bits).  The traditional "read-tree -m -u"
> followed by merge-one-file of course runs "git update-index"
> inside merge-one-file script and cleanly merged paths should be
> stat clean after a merge.

Well, they are not with msysgit. At least not all, or not always.
I'm not completely sure about the details, but the problem
happens frequently, near to always.

	Steffen
