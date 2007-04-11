From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Wed, 11 Apr 2007 16:30:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704111628240.28394@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org><Pi
 ne.LNX.4.64.0704092115020.6730@woody.linux-foundation.org><461D6432.90205@v
 ilain.net>   <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org><461D6858.4090
 007@vilain.net>  <Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org><Pine.LNX.4.63
 .0704111600390.28394@qynat.qvtvafvgr.pbz> <Pine.LNX.4.64.0704111646000.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 02:01:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbmkM-0000aO-BD
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 02:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161410AbXDLABB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 20:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161412AbXDLABB
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 20:01:01 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:38582 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1161410AbXDLABA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 20:01:00 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Wed, 11 Apr 2007 17:01:00 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Wed, 11 Apr 2007 17:00:55 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.64.0704111646000.6730@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44286>

On Wed, 11 Apr 2007, Linus Torvalds wrote:

> On Wed, 11 Apr 2007, David Lang wrote:
>>
>> would it make sense to have a --multiple-project option for fsck that would
>> let you specify multiple 'projects' that share a object set and have the
>> default checking not do the reachability checks that cause problems in this
>> case?
>
> Well, the thing is, sharing object directories actually makes things
> *harder* to check, rather than easier.
>
> It can be a nice space optimization, and yes, if there really is a lot of
> shared state, it can make it much cheaper to do some of the checks, but
> right now we have absolutely *no* way for fsck to then do the reachability
> check, because there is no way to tell fsck where all the refs are (since
> now the refs come in from multiple repositories!)

this is why I was suggesting a --multiple-project option to let you tell fsck 
about all of the repositories that it needs to look for refs in.

> So the individual objects get cheaper to fsck (no need to fsck shared
> objects over and over again), but the reachability gets much harder to
> fsck.

agreed.

> It's not an insurmountable problem, or even necessarily a very large one,
> but it boils down to one very basic issue:
>
> - nobody seems to actually *use* the shared object directory model!
>
> The thing is, with pack-files and alternates directories, a lot of the
> original reasons for shared object directories simply don't exist..

I suspect that if it coudl be checked it would be used more, especially with the 
subproject support.

David Lang
