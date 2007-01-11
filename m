From: Andreas Ericsson <ae@op5.se>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 11 Jan 2007 10:20:43 +0100
Message-ID: <45A6016B.4030800@op5.se>
References: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net> <7v3b6i75i5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701102241230.4964@xanadu.home> <20070111080035.GA28222@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 10:20:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4w7B-0003Vo-Kj
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 10:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965341AbXAKJUt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 04:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965343AbXAKJUt
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 04:20:49 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:50664 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965341AbXAKJUs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 04:20:48 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 68C116BCBC; Thu, 11 Jan 2007 10:20:46 +0100 (CET)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070111080035.GA28222@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36562>

Shawn O. Pearce wrote:
> Nicolas Pitre <nico@cam.org> wrote:
>> On Wed, 10 Jan 2007, Junio C Hamano wrote:
>>> * sp/describe (Wed Jan 10 06:39:47 2007 -0500) 1 commit
>>>  - Chose better tag names in git-describe after merges.
>>>
>>> Slowing it down by 4x is very unfortunate.  I think there is a
>>> better way to walk the ancestry than doing one at a time to
>>> count the commits, but I did not have enough time to look at
>>> this today.
>> However git-describe is certainly not a frequent and speed critical 
>> operation, and 
>> even if it cannot be sped up then waiting 300 ms more won't really 
>> affect one's workflow that badly.
> 
> My thoughts exactly.  I spent a few hours trying to determine
> an algorithm that produced the right answer and did not require
> generating the revlist between the tag and the requested commit
> for every possibly matching tag.  I did not come up with one.
> If someone else does it would obviously be a welcome replacement
> to my own patch.  :-)
> 
> There is almost no additional penalty for a simple strand of pearls
> with the tag placed along that strand; only one possible tag will be
> found.  But my code does an unnecessary revision list in this case.
> 
> Where we really get hit is the large number of possible tags.  The
> master branch is turning up 14 tags, some dating back to v1.4.1-rc1.
> I do try to abort the revision list as soon as one of those tags
> cannot give me a better selection than the one I have currently,
> but I still had to generate a revision list to reach that point.
> 

It could be worth skipping tags more than 6 months older than current 
branch-head. That would, at least for the git case, cut the number of 
tags down by a considerable amount.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
