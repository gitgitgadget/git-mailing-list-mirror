From: Andreas Ericsson <ae@op5.se>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 15:40:41 +0200
Message-ID: <488734D9.9070703@op5.se>
References: <20080723130518.GA17462@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jul 23 15:42:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLec3-0004Rv-TL
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 15:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbYGWNlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 09:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbYGWNlk
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 09:41:40 -0400
Received: from mail.op5.se ([193.201.96.20]:44857 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463AbYGWNlj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 09:41:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 96B5A1B8040B;
	Wed, 23 Jul 2008 15:42:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Hu23ytGK5a2; Wed, 23 Jul 2008 15:42:32 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.194])
	by mail.op5.se (Postfix) with ESMTP id AF72A1B80409;
	Wed, 23 Jul 2008 15:42:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080723130518.GA17462@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89650>

Ingo Molnar wrote:
> I've got the following, possibly stupid question: is there a way to 
> merge a healthy number of topic branches into the master branch in a 
> quicker way, when most of the branches are already merged up?
> 
> Right now i've got something like this scripted up:
> 
>   for B in $(git-branch | cut -c3- ); do git-merge $B; done 
> 
> It takes a lot of time to run on even a 3.45GHz box:
> 
>   real    0m53.228s
>   user    0m41.134s
>   sys     0m11.405s
> 
> I just had a workflow incident where i forgot that this script was 
> running in one window (53 seconds are a _long_ time to start doing some 
> other stuff :-), i switched branches and the script merrily chugged away 
> merging branches into a topic branch i did not intend.
> 
> It iterates over 140 branches - but all of them are already merged up.
> 

With the builtin merge (which is in next), this should be doable with
an octopus merge, which will eliminate the branches that are already
fully merged, resulting in a less-than-140-way merge (thank gods...).
It also doesn't have the 24-way cap that the scripted version suffers
from.

If it does a good job at your rather extreme use-case, I'd say it's
good enough for 'master' pretty soon :-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
