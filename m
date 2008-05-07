From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Make rebase save ORIG_HEAD if using current branch
Date: Wed, 07 May 2008 10:14:46 +0200
Message-ID: <482164F6.4010205@viscovery.net>
References: <20080506051920.GA9165@Hermes.local> <481FFB62.9090804@viscovery.net> <54536F65-3A06-482E-9806-2E4F643C1024@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed May 07 10:16:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JteoZ-0005V2-Ex
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 10:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbYEGIPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 04:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754931AbYEGIPA
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 04:15:00 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:64358 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445AbYEGIO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 04:14:57 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jtenb-0007AC-8F; Wed, 07 May 2008 10:14:52 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B32E869F; Wed,  7 May 2008 10:14:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <54536F65-3A06-482E-9806-2E4F643C1024@silverinsanity.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81413>

Brian Gernhardt schrieb:
> On May 6, 2008, at 2:32 AM, Johannes Sixt wrote:
>> Brian Gernhardt schrieb:
>>> +    echo "$branch" > "$GIT_DIR/ORIG_HEAD"
>>
>> 1. You should be using 'git update-ref' here, I think.
>> 2. You should detect errors.
> 
> This is exactly how git-merge.sh does it.  While that's not a good
> argument for adding this, perhaps merge should be updated as well.  And
> presumably update-ref will make detecting errors easy.  But is being
> unable to set ORIG_HEAD an error that should stop the entire process?

Probably not.

>> 3. Should ORIG_HEAD better be set at the end of the rebase, not at the
>> beginning? Because if the rebase stops for some reason, and then you do a
>> 'git reset', you'll have overwritten the ORIG_HEAD that you have set
>> here.
> 
> I put it where I did because I thought it would only make sense when
> rebasing the current HEAD (instead of the two argument version that
> switches first).  Duplicating the logic to determine that later seemed
> wasteful.  Also, might you want to access the original HEAD during a
> rebase conflict?  (Although that would argue that ORIG_HEAD should be
> set for all rebases, to $upstream.)

Well, I can't think of a use-case where ORIG_HEAD would be extremly useful
for _me_, but you argued for one (git pull --rebase), so you make it so
that it suits you. I'm just drawing a scenario where ORIG_HEAD possibly is
not what you expect.

-- Hannes
