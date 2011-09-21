From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: Possible timestamp problems with diff-files?
Date: Wed, 21 Sep 2011 14:58:41 +0200
Message-ID: <4E79DF81.8090605@syntevo.com>
References: <4E786B5D.40601@syntevo.com> <20110920175458.GA3776@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 21 14:58:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6MO3-0007Sw-Mz
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 14:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab1IUM6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 08:58:46 -0400
Received: from syntevo.com ([85.214.39.145]:46961 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113Ab1IUM6q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 08:58:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTPSA id 58FFDE30018
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <20110920175458.GA3776@sigill.intra.peff.net>
X-Enigmail-Version: 1.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181843>

On 20.09.2011 19:54, Jeff King wrote:
> On Tue, Sep 20, 2011 at 12:30:53PM +0200, Marc Strapetz wrote:
> 
>> For our Git client, we are invoking
>>
>> git diff-files--quiet --ignore-submodules
>>
>> immediately after a commit of *all* changes. Hence, the expected exit
>> code would be 0 (because there are no changes). A user has now reported
>> that for commits with many changes, exit code is sometimes 1. For the
>> last incident, the commit was started at 15:24:11,820 and finished at
>> 15:24:12,329, diff-files was invoked at 15:24:12,455 and failed with
>> exit code 1 at 15:24:21,394. A subsequent diff-files succeeded, so I'm
>> wondering now, if that could be a timestamp problem (maybe related to
>> the Index)?
> 
> diff-files is scriptable plumbing, which means it is up to the script
> writer to decide exactly when the index should be refreshed with respect
> to the working tree files (because doing so could be kind of expensive,
> as it needs to stat every file in the working tree). Have you tried
> running "git update-index --refresh" just before your diff-files?

My point is that "git diff-files --quiet" seems to returns 1 and when
invoked a short time later (without modifying working tree or invoking
any other Git command) it returns 0. This would indicate a bug in Git, I
guess. I think we can add more debug logging to our client to track down
that problem. However, to do that I'd need some input on what to log?

--
Best regards,
Marc Strapetz
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com
