From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: svnimport problems (abysmal performance and crash) on Cygwin
Date: Tue, 13 Mar 2007 20:10:28 +0100
Message-ID: <45F6F724.4080704@dawes.za.net>
References: <45F4F58D.2010701@dawes.za.net> <45F50023.9030403@dawes.za.net> <46a038f90703120339j674e15cqe0e0fa587736f9bc@mail.gmail.com> <45F59193.1070608@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, normalperson@yhbt.net
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 20:10:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRCOS-0000R1-5S
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 20:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933059AbXCMTKf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 15:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933044AbXCMTKf
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 15:10:35 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:55444 "EHLO
	spunkymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933054AbXCMTKe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2007 15:10:34 -0400
Received: from [0.0.0.0] (lucas.dreamhost.com [64.111.99.14])
	by spunkymail-a1.g.dreamhost.com (Postfix) with ESMTP id 66439FFA6B;
	Tue, 13 Mar 2007 12:10:32 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <45F59193.1070608@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42144>

Rogan Dawes wrote:
> Martin Langhoff wrote:
>> Rogan,
>>
>> it looks like your connection to the server is dodgy, or maybe the
>> server is being restarted, or has a throttle for "intense" clients.
>>
>> After it failes, you should be able to do
>>
>>   git-checkout -b master
>>
>> and then rerun git-svnimport $params as many times as needed until it
>> completes.
>>
>> cheers,
>>
>>
>> maritn
> 
> Excellent! Thanks, that did it. Although I did need to checkout "origin" 
> first:
> 
> 0 $ git checkout origin
> warning: You appear to be on a branch yet to be born.
> warning: Forcing checkout of origin.
> Switched to branch "origin"
> 0 $ git checkout -b master
> Switched to a new branch "master"
> 0 $ git svnimport -v 
> http://spring-rich-c.svn.sourceforge.net/svnroot/spring-rich-c/trunk/spring-richclient 
> 
> Processing from 106 to 1734 ...
> Fetching from 106 to 1106 ...
> Tree ID 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> Merge parent branch: 4a31e85eda538f8d6ca069ddee11327c25542403
> Committed change 106:/ 2004-08-03 05:49:22)
> Commit ID 449db651234665f17590288370e84b249cad13f4
> Writing to refs/heads/origin
> DONE: 106 origin 449db651234665f17590288370e84b249cad13f4 at Mon Mar 12 
> 17:42:44 2007
> 
> Thanks for the help.
> 
> Rogan

Hmm. Looks like I spoke too soon. In fact, I do not seem to have any 
files, but only have the commits, with no actual files.


0 $ git log | tail

commit f7f6143408ae1db4fa8bf707c49ca1c2156f4461
Author: root <root>
Date:   Tue Jul 6 17:11:30 2004 +0000

     initial checkin

commit 53b1bd87b5b0d4078946446d2cf13b4aaed4e662
Author: unknown <unknown>
Date:   Tue Jul 6 17:11:30 2004 +0000

     New repository initialized by cvs2svn.
0 $ git show --raw f7f6143408ae1db4fa8bf707c49ca1c2156f4461
commit f7f6143408ae1db4fa8bf707c49ca1c2156f4461
Author: root <root>
Date:   Tue Jul 6 17:11:30 2004 +0000

     initial checkin

0 $

I ran it again, and found it quite interesting that the Tree ID was the 
same for all commits:

Tree ID 4b825dc642cb6eb9a060e54bf8d69288fbee4904
Committed change 1197:/ 2006-06-11 18:59:45)
Merge parent branch: 727e7dde19256b711329499e78ae4228c84c012b
Commit ID 255074be6c74c9d256efb180d08a79377827618c
Writing to refs/heads/origin
DONE: 1197 origin 255074be6c74c9d256efb180d08a79377827618c at Tue Mar 13 
19:08:45 2007
Tree ID 4b825dc642cb6eb9a060e54bf8d69288fbee4904
Committed change 1198:/ 2006-06-11 19:32:10)
Merge parent branch: 255074be6c74c9d256efb180d08a79377827618c
Commit ID 7668d58cfc0f0309d2102880d4b480805afaa7fc
Writing to refs/heads/origin
DONE: 1198 origin 7668d58cfc0f0309d2102880d4b480805afaa7fc at Tue Mar 13 
19:08:46 2007
Tree ID 4b825dc642cb6eb9a060e54bf8d69288fbee4904
Committed change 1199:/ 2006-06-14 07:15:59)
Merge parent branch: 7668d58cfc0f0309d2102880d4b480805afaa7fc
Commit ID 4c7db3d8fdd4b33c69008750e0c38d386ad0f9ab
Writing to refs/heads/origin
DONE: 1199 origin 4c7db3d8fdd4b33c69008750e0c38d386ad0f9ab at Tue Mar 13 
19:08:46 2007

I guess what is happening is that the server is not telling svnimport 
about the files, and so the assumption is that there are none, and so we 
commit an empty tree - repeatedly :-(

Any suggestions?

Thanks

Rogan
