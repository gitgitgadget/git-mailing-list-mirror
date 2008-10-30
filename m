From: Andreas Ericsson <ae@op5.se>
Subject: Re: Using the --track option when creating a branch
Date: Thu, 30 Oct 2008 15:06:16 +0100
Message-ID: <4909BF58.9010500@op5.se>
References: <18696.32778.842933.486171@lisa.zopyra.com>	<1225343538.10803.9.camel@maia.lan>	<18697.41702.241183.408377@lisa.zopyra.com>	<18697.42140.459170.891195@lisa.zopyra.com> <4909A7C4.30507@op5.se> <2008-10-30-14-52-52+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 15:07:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvYBc-000313-IG
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 15:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590AbYJ3OGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 10:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754588AbYJ3OGa
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 10:06:30 -0400
Received: from mail.op5.se ([193.201.96.20]:44524 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754583AbYJ3OGa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 10:06:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EB4811B80070;
	Thu, 30 Oct 2008 15:01:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lB0TfSwP1iVV; Thu, 30 Oct 2008 15:00:53 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 44F751B80048;
	Thu, 30 Oct 2008 15:00:51 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <2008-10-30-14-52-52+trackit+sam@rfc1149.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99470>

Samuel Tardieu wrote:
>>>>>> "Andreas" == Andreas Ericsson <ae@op5.se> writes:
> 
> Andreas> This particular bikeshed was painted a long time ago, with
> Andreas> the consensus going in favour of "git push" pushing all
> Andreas> *matching* refspecs.
> 
> I still don't understand why this is useful, especially when git push
> already has a "--all" option.
> 

--all pushes all refs, even the non-matching ones, which is very
rarely desirable and only accidentally sometimes the same as "push all
matching refs".

> I know that I've never had the intent to push all the refs without
> thinking about it first. Most of the time, I intend to push only
> the current branch I am in.
> 

Then say so. There's a very simple command syntax for it:
"git push <remote> <current-branch>"

> The current behaviour made me remove the branches I was not actively
> on locally, because I would get errors from "git push" all the time
> saying that I was not up-to-date in those branches.
> 

That's an orthogonal issue, and one that really could be fixed without
anyone complaining. Send a patch that checks if foo is a strict subset
of <remote>/foo before trying to send it, and abort if it is so. This
means that we'll try to push "foo" if upstream rewrote their "foo", but
perhaps that's just as well.

Note though that the patch mustn't try to apply any smarts if a ref is
given explicitly.

> Note that the "git pull" issue is completely different, as it merges
> or fast forwards the current branch only.
> 

"git pull" is actually only vaguely connected with "git push". The
opposite of "push" is "fetch" in git lingo.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
