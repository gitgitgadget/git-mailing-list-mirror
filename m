From: Nix <nix@esperi.org.uk>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 19:22:02 +0100
Message-ID: <877in50y7p.fsf@hades.wkstn.nix>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
	<46DEF1FA.4050500@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 20:22:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISzW6-0004lN-45
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 20:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbXIESWM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 14:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbXIESWM
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 14:22:12 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:53569 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672AbXIESWK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 14:22:10 -0400
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id l85IM2E8009188;
	Wed, 5 Sep 2007 19:22:02 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id l85IM2Hp024640;
	Wed, 5 Sep 2007 19:22:02 +0100
Emacs: it's all fun and games, until somebody tries to edit a file.
In-Reply-To: <46DEF1FA.4050500@midwinter.com> (Steven Grimm's message of "Wed, 05 Sep 2007 11:14:18 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.5-b28 (linux)
X-DCC-INFN-TO-Metrics: hades 1233; Body=3 Fuz1=3 Fuz2=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57734>

On 5 Sep 2007, Steven Grimm stated:

> Nix wrote:
>> Indeed. I repack all our git trees in the middle of the night, and our
>> incremental backup script drops .keep files corresponding to every
>> existing pack before running the backup.
>>
>> This is probably a good job for cron :)
>
> If you are setting up cron jobs to repack multiple git trees, you are
> not the kind of novice or casual git user who this proposal would
> primarily be aimed at.

True enough: but the point is that it was only about three lines of code
(a locate and git-gc pipeline). We could just put that in the
documentation...

... which people then won't read. Oh well. Sorry for the mindless
optimism.

> git-gc can leave behind a "last completed" timestamp and we can
> suppress the check for excess loose objects until some minimum amount
> of time has passed since last git-gc. If that amount is greater than
> the interval between your cron jobs, you won't even get any
> (measurable) overhead from the detection to see if the warning is
> needed.

I personally wonder if git-gc shouldn't use a proportional scheme, so
that only some packs get repacked, maybe the smallest ones (and when
they grow to the same size as the next largest one, the two get repacked
into one). This has the singular advantage that you won't have to
carefully drop .keep files everywhere or have to worry about your git-gc
of 50K of loose objects suddenly deciding to repack 100Mb of packfiles
and taking ages.

It's probably not hard to implement, but I don't need it because I keep
everything packed anyway...
