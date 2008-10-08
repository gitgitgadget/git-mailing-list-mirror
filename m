From: Knut Eldhuset <knut@3d-radar.com>
Subject: Re: Different svn-id URLs in history
Date: Wed, 08 Oct 2008 11:23:04 +0200
Message-ID: <48EC7BF8.9010707@3d-radar.com>
References: <48EB40E1.40506@3d-radar.com> <48EB79D8.6090908@drmicha.warpmail.net> <48EC546F.7060106@3d-radar.com> <48EC7022.7030707@drmicha.warpmail.net> <48EC7B52.4000100@3d-radar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 11:26:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnVHg-00031n-Fj
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 11:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339AbYJHJXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 05:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754334AbYJHJXU
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 05:23:20 -0400
Received: from epost.nunatak.no ([193.200.93.202]:38743 "EHLO epost.nunatak.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754069AbYJHJXT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 05:23:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by epost.nunatak.no (Postfix) with ESMTP id 0BA20121C9D2
	for <git@vger.kernel.org>; Wed,  8 Oct 2008 11:23:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.423
X-Spam-Level: 
X-Spam-Status: No, score=-2.423 tagged_above=-10 required=6.6
	tests=[AWL=0.076, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from epost.nunatak.no ([127.0.0.1])
	by localhost (epost.nunatak.no [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2VsEI-pqeSS3 for <git@vger.kernel.org>;
	Wed,  8 Oct 2008 11:23:06 +0200 (CEST)
Received: from [192.168.169.42] (unknown [194.19.26.200])
	by epost.nunatak.no (Postfix) with ESMTP id 68D58121C965
	for <git@vger.kernel.org>; Wed,  8 Oct 2008 11:23:06 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <48EC7B52.4000100@3d-radar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97789>

Knut Eldhuset wrote:
> Michael J Gruber wrote:
>> Knut Eldhuset venit, vidit, dixit 08.10.2008 08:34:
>>> Michael J Gruber wrote:
>>>> Knut Eldhuset venit, vidit, dixit 07.10.2008 12:58:
>>>>> Hi,
>>>>>
>>>>> After cloning my svn repository, I notice that the svn-id URL is 
>>>>> different when going back in history:
>>>>>
>>>>> git-svn-id: https://server/trunk@300
>>>>>
>>>>> vs
>>>>>
>>>>> git-svn-id: https://server/trunk/some_folder/project/src@250
>>>>>
>>>> I take this is as an invitation for guesswork (given the amount of
>>>> details)...
>>> Sorry about that... I'm confused.
>>>> You probably have commits which don't follow your usual svn repo layout
>>>> (trunk/some_folder/project/src) but commit to trunk/ directly. The 
>>>> output of
>>>>
>>>> svn log -v -r300 https://server/trunk@300
>>>> svn log -v -r250 https://server/trunk/some_folder/project/src@250
>>>>
>>>> should give some clues.
>>>>
>>> Svn log shows that the same path has been modified in both cases. I see 
>>
>> Does "same path" mean:
>> - same relative to the above paths or
>> - same absolute path?
> 
> Both say "/trunk/some_folder/project/src/some_file".
> 
>>
>>> something strange in git, though. Our svn repository has about 6500 
>>> commits, but git shows over 10.000. Further investigation shows that 
>>> a lot of svn commits have two entries in git. Some branches off of 
>>> trunk do not start at r1, but off of a duplicate rNNNN. Could this be 
>>> due to our unhealthy practice of creating branches off of subtrees in 
>>> svn? By this I mean create a branch off of 
>>> https://server/trunk/some_folder/project/src instead of 
>>> https://server/trunk. If so, what can be done to fix this?
>>>
>>> As a sidenote, during git svn clone, I noticed that each time a new 
>>> branch or tag was discovered, the "scanning" started back at r1. Is 
>>> this normal? I would think the history before the branch was already 
>>> imported. Of course, this could maybe be due to the bad branching 
>>> practice described above.
>>
>> svn is typically "abused" in the sense that one svn repo is used for
>> separate projects (your subtrees). git-svn can deal with non-standard
>> repo layouts.
>>
>> I assume you can't share the svn repo publically, can you?
> 
> Sorry, no.
> 
>> So, in order to help you, we would need to know
>>
>> - the layout of your svn repo: where are trunk, branches and tags, how
>> did you create branches and tags in svn, are "projects" entirely separate
> 
> https://server/trunk
> https://server/branches
> https://server/tags
> 
> We really only have one "project" source tree at 
> https://server/trunk/some_folder/project/src
> 
> However, once the sources were at
> https://server/trunk/some_folder/project/old_source
> 
> Therefore we have the following:
> 
> $ svn log -v -r4871 https://server/
> ------------------------------------------------------------------------
> r4871 | nn | 2007-09-25 13:36:25 +0200 (Tue, 25 Sep 2007) | 3 lines
> Changed paths:
>    M /trunk/project
>    D /trunk/project/old_source/some_file
>    A /trunk/project/src/client/some_file (from 
> /trunk/project/old_source/some_file:4795)
> 
>  commit-message
> ------------------------------------------------------------------------
> 
> $ svn log -v -r4869 https://server/
> ------------------------------------------------------------------------
> r4869 | nn | 2007-09-25 13:14:34 +0200 (Tue, 25 Sep 2007) | 3 lines
> Changed paths:
>    M /trunk/project
>    A /trunk/project/src
>    A /trunk/project/src/client
> 
>  commit-message
> 
> ------------------------------------------------------------------------
> 
> $ svn log -v -r4868 https://server/
> ------------------------------------------------------------------------
> r4868 | nn | 2007-09-25 13:14:28 +0200 (Tue, 25 Sep 2007) | 3 lines
> Changed paths:
>    M /trunk/project
> 
>  commit-message
> 
> ------------------------------------------------------------------------
> 
> $ svn log -v -r4867 https://server/
> ------------------------------------------------------------------------
> r4867 | nn | 2007-09-25 12:04:58 +0200 (Tue, 25 Sep 2007) | 3 lines
> Changed paths:
>    M /trunk/project
>    A /trunk/project/some_file
> 
>  commit-message
> ------------------------------------------------------------------------
> 
> r4868 appears twice in git. One commit is on master/trunk and has parent 
> and child, while the other is on a branch and has no parent.
> 

Sorry, that should be r4869.

>> - your incarnation of git-svn
>>
> 
> # git --version
> git version 1.6.0.2
> 
> 

Regards,
Knut
