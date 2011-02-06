From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Sun, 06 Feb 2011 20:35:00 +0100
Message-ID: <4D4EF7E4.7050303@hartwork.org>
References: <4D4DEDC4.4080708@hartwork.org> <20110206051333.GA3458@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 06 20:34:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmANq-0003bh-6D
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 20:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851Ab1BFTev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 14:34:51 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:42424 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652Ab1BFTev (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 14:34:51 -0500
Received: from [85.177.91.128] (helo=[192.168.0.3])
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1PmANk-0004ri-KW; Sun, 06 Feb 2011 20:34:48 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20110109 Thunderbird/3.1.7
In-Reply-To: <20110206051333.GA3458@sigill.intra.peff.net>
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166195>

On 02/06/11 06:13, Jeff King wrote:
> On Sun, Feb 06, 2011 at 01:39:32AM +0100, Sebastian Pipping wrote:
> 
>> I just ran into case where
>>
>>   git add -u
>>
>> repetedly did not update the index.  In contrast, picking stuff using
>>
>>   git add -p
>>
>> works just fine.
>>
>> Could it be "git add -u" is broken in git 1.7.4?
> 
> It could be. However, I can think of one such case where you might see
> that behavior. "git add -u" operates from the current subdirectory,
> whereas "git add -p" operates from the top of the project tree (yes,
> this inconsistency confusing, but it's not as serious as "git add -u
> doesn't work").
> 
> You can demonstrate it with:
> 
>   mkdir repo && cd repo && git init
>   mkdir subdir && echo content >file
>   git add . && git commit -m base
>   echo more >>file
> 
>   mkdir subdir && cd subdir
>   git add -u
>   git status ;# still not staged for commit
> 
>   git add -p ;# finds it
> 
> Might you have been in a subdirectory of the project when you saw this
> behavior?

I was and I can confirm the different behaviour with 1.7.4 over here: it
does work on the root directory of the repo as you supposed.

Is that behavior needed to be as is or could you change it to work from
everywhere?  Could it be it has been working from anywhere before?

Best,



Sebastian
