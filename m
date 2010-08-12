From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [Q] `git fetch tag NAME' into mirror repo does not update HEAD,
 what to do?
Date: Thu, 12 Aug 2010 13:05:29 +0200
Message-ID: <4C63D579.507@dbservice.com>
References: <201008120954.27648.brian.foster@innova-card.com> <4C63B1C9.6050801@dbservice.com> <201008121238.51983.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 13:05:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjVbR-0000mf-MQ
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 13:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759835Ab0HLLFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 07:05:36 -0400
Received: from office.neopsis.com ([78.46.209.98]:48146 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759811Ab0HLLFf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 07:05:35 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.036,BAYES_00: -1.665,TOTAL_SCORE: -1.629,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 12 Aug 2010 13:05:32 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <201008121238.51983.brian.foster@innova-card.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153365>

On 8/12/10 12:38 PM, Brian Foster wrote:
> On Thursday 12 August 2010 10:33:13 Tomas Carnecky wrote:
> 
> Tom,
>  Thanks for the reply, but I suspect you didn't read
>  the problem correctly ....

I suspect I did but did not explain correctly (though I didn't realize
mirror implies bare, my bad).

> 
>> On 8/12/10 9:54 AM, Brian Foster wrote:
>>>  Bare repository ORIG's master looks like this:
>>> [ ... ] 
>>>  Repository SLAVE is a mirror clone of ORIG which
> NOTE.......................^^^^^^
>> [ ... ] 
>> Fetch only fetches commits. It doesn't update any local refs (other than
>> FETCH_HEAD). If you want to switch HEAD to that new tag, use checkout.

Oh boy, that explanation is really bad -.- What I meant is that if you
don't supply the <dst> part of the refspec it will only update
FETCH_HEAD. So 'git fetch origin master' will not update anything but
FETCH_HEAD.

>  No, a fetch in a mirror, when fetching all the way
>  to the HEAD (e.g., a simple `git fetch origin'),
>  does update the branch.  (You can easily modify the
>  script I included to prove this.)

There are different ways to invoke git fetch. Either way, fetch will
never modify HEAD. However, it can modify the branch that HEAD is
pointing to (in case HEAD is a symref). But you are not fetching a
branch, you are fetching a tag. So you need to use checkout after you
fetch it. Either 'git checkout FETCH_HEAD' or 'git checkout v2'.

tom
