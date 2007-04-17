From: Rene Herman <rene.herman@gmail.com>
Subject: Re: git branch --switch?
Date: Tue, 17 Apr 2007 17:41:30 +0200
Message-ID: <4624EAAA.6040000@gmail.com>
References: <4624CD58.90103@gmail.com> <C940520E-732A-4F6E-A7F2-0215FD534455@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 17:43:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdpqA-0002ar-NO
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 17:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030678AbXDQPnb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 11:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030684AbXDQPnb
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 11:43:31 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:36344 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030678AbXDQPna (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 11:43:30 -0400
Received: from [213.51.130.189] (port=48436 helo=smtp2.groni1.gr.home.nl)
	by smtpq2.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1Hdpq5-000378-GQ; Tue, 17 Apr 2007 17:43:29 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:34776 helo=[192.168.0.3])
	by smtp2.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1Hdpq3-0003sF-Cd; Tue, 17 Apr 2007 17:43:27 +0200
User-Agent: Thunderbird 1.5.0.10 (X11/20070221)
In-Reply-To: <C940520E-732A-4F6E-A7F2-0215FD534455@silverinsanity.com>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44782>

On 04/17/2007 04:31 PM, Brian Gernhardt wrote:

>> Is it possible to switch the current branch without checking it out? 
>> Not really essential, but I'm happily flaundering around with git and 
>> still start from scratch fairly regularly; to speed this up I've found 
>> the -n switch to git clone useful and would like something similar 
>> when reconstructing my "branch hierarchies".
>>
>> Upto now I only know about "git checkout" (with or without -b) to 
>> switch the current branch. As said it's not really essential, but I 
>> was expecting there would be something like a "branch --switch". Did I 
>> overlook it?
> 
> Perusing git-checkout points me to git-symbolic-ref to update the HEAD 
> ref to a new branch:
> 
> git symbolic-ref HEAD refs/heads/<branch>
> 
> However, I'm somewhat confused as to why you'd want HEAD and the working 
> directory to get out of sync.

Thank you for the answer. Well, as said, it's not essential, but I was just 
now rebuilding a repo and have a few branches that I all want to be based on 
the same revision. Say, branch a, b and c, based on v2.6.20.

git clone -l -s -n <a local linux repo> local
git checkout -b v20 v2.6.20
git branch a
git branch b
git branch c

Step 1, 3, 4 and 5 of this are nearly instantaneous but 2 isn't -- this repo 
sits on a P1 with 64M of memory and a disk doing 8 M/s which is probably the 
only reason I thought asking about it was a good idea in the first place...

You'd be quite right in saying that there isn't much point; if I want to now 
start populating branch a, I have to "git checkout a" anyway, and that 
action _will_ now be instantaneous. If I'd replaced 2 with:

git branch --create-and-set-as-current v20 v2.6.20

then I will not have won any time until that 6th "git checkout a" step.

The checkout of v20 was superfluous in this though, and I just expected I 
should be able to skip that. It fitted my mental model...

Rene.
