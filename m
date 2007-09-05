From: Steven Grimm <koreth@midwinter.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 11:14:18 -0700
Message-ID: <46DEF1FA.4050500@midwinter.com>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>	<20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Wed Sep 05 20:14:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISzOQ-0002MA-3C
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 20:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbXIESOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 14:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbXIESOR
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 14:14:17 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:36127 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752348AbXIESOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 14:14:16 -0400
Received: (qmail 10266 invoked from network); 5 Sep 2007 18:14:16 -0000
Received: from c-76-21-16-80.hsd1.ca.comcast.net (HELO pinklady.local) (koreth@76.21.16.80)
  by tater.midwinter.com with SMTP; 5 Sep 2007 18:14:16 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <87odgh0zn6.fsf@hades.wkstn.nix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57733>

Nix wrote:
> Indeed. I repack all our git trees in the middle of the night, and our
> incremental backup script drops .keep files corresponding to every
> existing pack before running the backup.
>
> This is probably a good job for cron :)
>   

If you are setting up cron jobs to repack multiple git trees, you are 
not the kind of novice or casual git user who this proposal would 
primarily be aimed at.

But in any event, since you are doing that, your repos will never 
accumulate a high enough percentage of loose objects (whatever the 
threshold is) to trigger the warning and/or automatic launch. So you can 
continue to operate as before, no difference in behavior, while people 
who don't know how / want to set up cron jobs will have their 
repositories cleaned too.

git-gc can leave behind a "last completed" timestamp and we can suppress 
the check for excess loose objects until some minimum amount of time has 
passed since last git-gc. If that amount is greater than the interval 
between your cron jobs, you won't even get any (measurable) overhead 
from the detection to see if the warning is needed.

-Steve
