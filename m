From: Sanjiv Gupta <sanjiv.gupta@microchip.com>
Subject: Re: Pulling one commit at a time.
Date: Mon, 24 Aug 2009 11:52:07 +0530
Message-ID: <4A92318F.6050105@microchip.com>
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com>	<4A9172D0.6030507@microchip.com> <20090824060710.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 08:22:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfSwl-0007on-Hz
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 08:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbZHXGWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 02:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbZHXGWP
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 02:22:15 -0400
Received: from smtp02.microchip.com ([198.175.253.48]:35960 "EHLO
	smtp02.microchip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbZHXGWP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 02:22:15 -0400
Received: from CHN-CL-MAIL01.mchp-main.com ([10.10.76.21]) by smtp02.microchip.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 23 Aug 2009 23:22:17 -0700
Received: from [10.41.200.168] ([10.41.200.168]) by CHN-CL-MAIL01.mchp-main.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 23 Aug 2009 23:22:15 -0700
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <20090824060710.6117@nanako3.lavabit.com>
X-OriginalArrivalTime: 24 Aug 2009 06:22:16.0303 (UTC) FILETIME=[39D497F0:01CA2483]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126910>

Nanako Shiraishi wrote:
> Quoting Sanjiv Gupta <sanjiv.gupta@microchip.com>
>
>   
>> I just wanted to know how can I pull one commit at a time from public
>> repository.
>> e.g.
>> when I first cloned from the public repo, it was at X. now it has
>> reached Y. I just want to pull x+1.
>>     
>
> When your histories look like this:
>
>       A                 your 'master'
>      /
>  ---X---U---V---W---Y   public 'master' (your 'origin')
>
> instead of creating a single merge like this with "git pull":
>
>       A---------------M your 'master' (fully merges 'origin')
>      /               / 
>  ---X---U---V---W---Y   public 'master'
>
> you want to create a history like this?
>
>       A---J             your 'master' (lacks V, W and Y)
>      /   /
>  ---X---U---V---W---Y   public 'master'
>
> For that, you can fetch first.
>
>  git fetch origin
>
> Then look at the history in gitk
>
>  gitk master origin
>
> And find the commit you are interested in merging (U in the above picture). And merge it.
>
>  git merge origin~3
>
> Replace "origin~3" in the example above with whatever commit you want to merge the entire history leading to it.
>
> You can repeat this final step as many times you want. For example, if you want create a history like this:
>
>       A---J---K---L---M your 'master'
>      /   /   /   /   / 
>  ---X---U---V---W---Y   public 'master'
>
> you can do so by repeating the last step for V, W and Y in turn.
>
> In general the public history isn't necessarily a single straight line like this picture and it doesn't make sense to merge one at a time for all the commits on the public branch, but if that is what you really want to do, you can do so.
>
>   
Excellent description. Thanks for that. I want to merge commits one by 
one because I want to run a regression suite on each commit and 
therefore know if any one is causing failures.

- Sanjiv
