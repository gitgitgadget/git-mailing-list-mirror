From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 27 Sep 2011 08:59:24 +0100
Message-ID: <2ad152520590530dd1bdcfae9941ef9d@quantumfyre.co.uk>
References: <4DF6A8B6.9030301@op5.se>
 <201109261552.04946.mfick@codeaurora.org>
 <ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk>
 <201109261812.31738.mfick@codeaurora.org>
 <97c45128ddeb8269273a4431b3941478@quantumfyre.co.uk>
 <3539dab7-0fb2-4759-baaf-8e22efab2904@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 09:59:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8SZh-0002Jf-Sr
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 09:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542Ab1I0H73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 03:59:29 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:52812 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751195Ab1I0H72 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2011 03:59:28 -0400
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id 6C90CC060C;
	Tue, 27 Sep 2011 08:59:27 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 67CE236A831;
	Tue, 27 Sep 2011 08:59:26 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 13FLl89fpJXr; Tue, 27 Sep 2011 08:59:25 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 7E92F36A6DD;
	Tue, 27 Sep 2011 08:59:25 +0100 (BST)
In-Reply-To: <3539dab7-0fb2-4759-baaf-8e22efab2904@email.android.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: Roundcube Webmail/0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182218>

On Mon, 26 Sep 2011 20:34:02 -0600, Martin Fick wrote:
>> Julian Phillips <julian@quantumfyre.co.uk> wrote:
>>On Mon, 26 Sep 2011 18:12:31 -0600, Martin Fick wrote:
>>That sounds a lot better.  Hopefully other commands should be faster
>>now too.
>
> Yeah, I will try this in a few other places to see.
>
>>> Thanks way much!!!
>>
>>No problem.  Thank you for all the time you've put in to help chase
>>this down.  Makes it so much easier when the person with original
>>problem mucks in with the investigation.
>>Just think how much time you've saved for anyone with a large number 
>> of
>>
>>those Gerrit change refs ;)
>
>  Perhaps this is a naive question, but why are all these refs being
> put into a list to be sorted, only to be discarded soon thereafter
> anyway?  After all, git branch knows that it isn't going to print
> these, and the refs are stored precategorized, so why not only grab
> the refs which matter upfront?

I can't say that I am aware of a specific decision having been taken on 
the subject, but I'll have a guess at the reason:

The extra code it would take to have an API for getting a list of only 
a subset of the refs has never been considered worth the cost.  It would 
take effort to implement, test and maintain - and it would have to be 
done separately for packed and unpacked cases to avoid still loading and 
discarding unwanted refs.  All that to not do something that no-one has 
noticed taking any time?  Until now, I doubt anyone has considered it 
something that was a problem - and now that even with 100k refs it takes 
less than a second, I doubt anyone will feel all that inclined to have a 
crack at it now either.

-- 
Julian
