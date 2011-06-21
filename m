From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: Preserve merge changes with rebase -p
Date: Tue, 21 Jun 2011 10:44:48 -0400
Message-ID: <4E00AE60.5000801@sohovfx.com>
References: <201106211411.31739.mcy@lm7.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matteo Cypriani <mcy@lm7.fr>
X-From: git-owner@vger.kernel.org Tue Jun 21 16:45:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ2CK-0002g3-8k
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 16:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554Ab1FUOow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 10:44:52 -0400
Received: from smtp04.beanfield.com ([76.9.193.173]:62438 "EHLO
	smtp04.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab1FUOov (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 10:44:51 -0400
X-Spam-Status: No
X-beanfield-mta04-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta04-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta04-MailScanner: Found to be clean
X-beanfield-mta04-MailScanner-ID: 1QZ2C8-000Ks0-OA
Received: from [66.207.196.114] (helo=[192.168.1.112])
	by mta04.beanfield.com with esmtpa (Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1QZ2C8-000Ks0-OA; Tue, 21 Jun 2011 10:44:48 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101026 SUSE/3.0.10 Thunderbird/3.0.10
In-Reply-To: <201106211411.31739.mcy@lm7.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176159>

On 06/21/2011 08:11 AM, Matteo Cypriani wrote:
> The thing is, my M was not a "simple merge commit", but contained some changes 
> needed for the code in master and topic to work together. In that case, git 
> rebase -i -p recreates a merge commit, but it does not keep the changes 
> introduced in M.
>
> Is there any way to keep the M's changes in my case (except to manually patch 
> & amend the re-created merge commit) ?
>   
Unfortunately, I don't think there's any nice way to do it right now. I
think what you could do for now is make the "pick <M>" into a "edit
<M>", together with other changes you want to make. And then when you
get to "edit M", do a "git cherry-pick -n -m 1 <M>", or "-m 2" depending
on how your merge was done. That should bring your changes over. Then
you just need resolve and add any conflicts, and do a "rebase --continue".

I've only tried it on a simple case and that seems to work.

> If not, maybe it would be a nice functionnality to implement ?
>   
I imagine this is pretty useful feature to have too. I could look into
adding this support when I got a chance. I haven't given it much thought
yet though, so I don't know how feasible it is.
