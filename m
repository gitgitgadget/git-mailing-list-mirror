From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Interdiff between amended commits
Date: Thu, 14 Apr 2011 10:47:42 +0200
Message-ID: <4DA6B4AE.1090701@drmicha.warpmail.net>
References: <4DA69D7F.5050304@drmicha.warpmail.net> <1jzpkig.1g2zjmtgv7a68M%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Thu Apr 14 10:47:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAIDP-0003Xf-JD
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 10:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684Ab1DNIrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 04:47:46 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42172 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755949Ab1DNIro (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 04:47:44 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B373F20D39;
	Thu, 14 Apr 2011 04:47:43 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 14 Apr 2011 04:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=y5lrEG4IG4KgCjVvVAQrAjgHqPw=; b=uaC+TXVPKqG07cNZOJsdmu4YyhGLp+dGasFp3mz1oWxZFLuAMQJ8Z2fArLsfGaZo5j9ebNCYQ/pqUMofD8LDVIQc1VWoJo+QJo4yPLtY8Uj7l2J+8YBi5rvt4KxFdU1QYYf1K/OJsrM5CFRPfnr90azibFrSqFFYJAOYnmC1U+Q=
X-Sasl-enc: E9c102/UsZsrJGYJrcsG8K5iXYlggHT/GwxsbQSwHsj6 1302770863
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3B141448CED;
	Thu, 14 Apr 2011 04:47:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <1jzpkig.1g2zjmtgv7a68M%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171509>

Stefan Haller venit, vidit, dixit 14.04.2011 10:09:
> Michael J Gruber <git@drmicha.warpmail.net> wrote:
> 
>>> So one thing I came up with is this:
>>>
>>>   git checkout commit1^
>>>   git cherry-pick --no-commit commit2
>>>   git diff --cached
>>
>> That does something completely different. It compares the tree of
>> commit1^ with the tree of (commit1^ with commit2's patch applied). I
>> don't see how commit1's patch plays any role here.
> 
> Sorry, that was just a typo.  I meant
> 
>   git diff --cached commit1
> 
> as the last line, of course.
> 
> Alternatively, I could do it the other way round, by saying
> 
>   git checkout commit2^
>   git cherry-pick --no-commit commit1
>   git diff --cached -R commit2
> 
> That should produce the same result (except maybe for the line numbers
> in the hunk headers), as long as the cherry-pick didn't have conflicts.
> 
>> Depending on what your actual use case, you may be happier with "git
>> diff commit1 commit2"
> 
> No, that's not what I want (except when commit1 and commit2 have the
> same parent).  This would also show the differences between the parents
> of commit1 and commit2; I don't want to include those.
> 
> My actual use case is that I have a central repository that sends out
> commit emails; when someone does an interactive rebase and amends a
> commit in the middle of a branch, I want to match up corresponding
> commits based on their subject line, and then send an email showing how
> the diff for that commit changed.

In that case, "git diff --no-index" on the two patches (i.e. the alias
you found with "interdiff" replaced) may be worth a try. We should be
able to teach our diff machinery about our diffs :) I mean, see userdiff
and funcname.

Michael
