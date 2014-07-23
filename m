From: Sergei Organov <osv@javad.com>
Subject: Re: rebase flattens history when it shouldn't?
Date: Wed, 23 Jul 2014 23:33:11 +0400
Message-ID: <8738drj2fc.fsf@osv.gnss.ru>
References: <87k374xkpq.fsf@osv.gnss.ru> <20140723175218.GB12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:33:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA2Hv-0002up-7l
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 21:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932921AbaGWTdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 15:33:15 -0400
Received: from mail.javad.com ([54.86.164.124]:43476 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932674AbaGWTdO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 15:33:14 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 781636184D;
	Wed, 23 Jul 2014 19:33:13 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1XA2Hn-0002Qw-MP; Wed, 23 Jul 2014 23:33:11 +0400
In-Reply-To: <20140723175218.GB12427@google.com> (Jonathan Nieder's message of
	"Wed, 23 Jul 2014 10:52:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254112>

Jonathan Nieder <jrnieder@gmail.com> writes:
> Hi Sergei,
>
> Sergei Organov wrote:
>
>>      --C--
>>     /     \
>>    /   ----M topic,HEAD
>>   /   /
>>  A---B master
>>
>> shouldn't
>>
>> $ git rebase master
>>
>> be a no-op here?
> [...]
>> I'd expect --force-rebase to be required for this to happen:
>>
>> -f, --force-rebase
>>     Force the rebase even if the current branch is a descendant of the
>>     commit you are rebasing onto. Normally non-interactive rebase will
>>     exit with the message "Current branch is up to date" in such a
>>     situation.
> [...]
>> Do you think it's worth fixing?
>
> Thanks for a clear report.
>
> After a successful 'git rebase master', the current branch is always a
> linear string of patches on top of 'master'.  The "already up to date"
> behavior when -f is not passed is in a certain sense an optimization
> --- it is about git noticing that 'git rebase' wouldn't have anything
> to do (except for touching timestamps) and therefore doing nothing.
>
> So I don't think requiring -f for this case would be an improvement.

What actually bothers me is the unfortunate consequence that "git pull"
is not always a no-op when nothing was changed at the origin since the
last "git pull". THIS is really surprising and probably should better be
fixed. Requiring -f is just one (obvious) way to fix this.

> I do agree that the documentation is misleading.  Any ideas for
> wording that could make it clearer?

I can't suggest anything as I don't see why -f is there in the first
place. What are use cases?

-- 
Sergey.
