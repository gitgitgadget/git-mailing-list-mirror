From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv2 0/4] git-p4: small fixes to branches and labels; tests
Date: Wed, 30 Nov 2011 19:14:34 +0000
Message-ID: <4ED6809A.9020703@diamand.org>
References: <1322643817-13051-1-git-send-email-luke@diamand.org> <loom.20111130T155409-599@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 30 20:14:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVpcJ-0004gh-R5
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 20:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958Ab1K3TOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 14:14:36 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48213 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab1K3TOe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 14:14:34 -0500
Received: by eaak14 with SMTP id k14so1093026eaa.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 11:14:32 -0800 (PST)
Received: by 10.227.209.9 with SMTP id ge9mr1501860wbb.1.1322680471868;
        Wed, 30 Nov 2011 11:14:31 -0800 (PST)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id a27sm3085943wbp.16.2011.11.30.11.14.29
        (version=SSLv3 cipher=OTHER);
        Wed, 30 Nov 2011 11:14:30 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <loom.20111130T155409-599@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186137>

On 30/11/11 14:55, Vitor Antunes wrote:
> Luke Diamand<luke<at>  diamand.org>  writes:
>
>> In adding the test case for labels I also found and fixed a few other
>> small bugs in the label handling:
>>
>>   - labels missing a description or "EOT" in their text cause problems;
>>   - labels without an owner cause problems.
>>
>> I also noticed, but did not fix, that you can't have more than one label
>> per commit (the others are silently dropped) and the documentation for
>> branch import could be improved. I've added a (failing) test case for
>> the multiple label problem.
>
> Hi Luke,
>
> Seeing that you have some experience using labels, could I kindly ask you to
> include some description of it in git-p4.txt?

OK, if you can help me understand what's going on...

The label-detection bug that I've described, on further investigation, 
looks to be a fundamental limitation.

With perforce, I can check out the head revision, and then tag just a 
single file. If I then check out on that tag, I get just that one file.

I think I can't do that with git; certainly fast-import can't do it.

So the code in git-p4 that is checking the file vs label counts (git-p4 
around line 1496) is actually trying to say "this label can't be 
imported into git".

If my understanding is correct, I can then fix my test and update the 
docs and the code to explain this.

As an aside, git-p4.txt currently has quite good information on the 
config variables, but nothing on the command line variables. Possibly 
that should be fixed.

Cheers!
Luke
