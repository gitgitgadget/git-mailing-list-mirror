From: Soham Mehta <soham@box.net>
Subject: Re: Finding a commit
Date: Thu, 22 Oct 2009 01:32:50 -0700
Message-ID: <4AE018B2.2010408@box.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 10:33:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0t6W-0008Gl-5H
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 10:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147AbZJVIcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 04:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754163AbZJVIcy
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 04:32:54 -0400
Received: from mailrelay.ve.box.net ([209.249.140.142]:58353 "EHLO
	corpmail.ve.box.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754087AbZJVIcx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 04:32:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by corpmail.ve.box.net (Postfix) with ESMTP id C3CDE3B1968
	for <git@vger.kernel.org>; Thu, 22 Oct 2009 01:32:58 -0700 (PDT)
Received: from corpmail.ve.box.net ([127.0.0.1])
	by localhost (mail.box.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mzzAzzx3-cj3 for <git@vger.kernel.org>;
	Thu, 22 Oct 2009 01:32:58 -0700 (PDT)
Received: from [192.168.1.102] (c-98-234-177-226.hsd1.ca.comcast.net [98.234.177.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by corpmail.ve.box.net (Postfix) with ESMTP id 784BD3B1953
	for <git@vger.kernel.org>; Thu, 22 Oct 2009 01:32:58 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131008>


Thanks for all the answers! Sorry for the delayed reply.

Like Douglas Campos suggested, git-cherry (which uses git-patch-id like 
Thomas Rast suggests) works for me. Here is what I tried:

from first repo$: git fetch second-repo
from first repo$: git cherry -v second-repo/branch-in-question sha1 sha1^
- sha1 <commit message>


Outputs the sha1 with a minus sign in front, which means the change is 
already present in second-repo/branch-in-question, and is what I expect.

-Soham



thus spake Daniele Segato , On 10/21/2009 6:55 AM:
> On Wed, Oct 21, 2009 at 2:37 PM, Thomas Rast <trast@student.ethz.ch> wrote:
>   
>>> Commit -> Tree ---> Blob1, Blob2, Blob3
>>>
>>> Commit, Trees and Blobs are all identified by sha1
>>> the commit should keep information on the author, the "parent"
>>> commit(s) and so on..
>>> the tree should just keep the "snapshot" of the data..
>>>
>>> so I think that if you search for the SHA-1 of the tree you should be fine..
>>>       
>> Not if you really want to find out if X was cherry-picked into this
>> repository, because the tree is the *final state* at that commit,
>> which of course includes all preceding changes.
>>
>> So suppose you have two patches A.diff and B.diff introducing files of
>> the same name; then if you combine them into history as
>>
>>  A -- B
>>
>> the tree state at B has both files, and hence is different from the
>> tree state of B' in
>>
>>  B' -- A'
>>
>> because there it only has the file B.
>>     
>
> Yes... obviously...
> the tree is the snapshot of a complete data set: so if you apply the
> same patch to different data set you get different trees...
> thanks for pointing it out.. :)
>
> Regards,
> Daniele
>   
