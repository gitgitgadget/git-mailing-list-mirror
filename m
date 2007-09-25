From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] rebase -i: commit when continuing after "edit"
Date: Tue, 25 Sep 2007 16:17:29 +0200
Message-ID: <46F91879.6030301@viscovery.net>
References: <20070923224502.GB7249@potapov> <Pine.LNX.4.64.0709240121080.28395@racer.site> <7vlkav71bv.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709251249450.28395@racer.site> <46F90C95.5060903@viscovery.net> <Pine.LNX.4.64.0709251439070.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 25 16:18:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaBEn-0008Ks-8i
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 16:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbXIYORe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 10:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753161AbXIYORd
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 10:17:33 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:4948 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbXIYORd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 10:17:33 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IaBE9-0001Ff-Ck; Tue, 25 Sep 2007 16:17:29 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3F75F546; Tue, 25 Sep 2007 16:17:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0709251439070.28395@racer.site>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59126>

Johannes Schindelin schrieb:
> Hi,
> 
> On Tue, 25 Sep 2007, Johannes Sixt wrote:
>> How about:
>>
>> 	eval "$author_script"
>> 	GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
>> 	GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
>> 	GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
>> 	$USE_OUTPUT git commit -F "$MSG" $EDIT_COMMIT
>>
>> and if you dislike that, put the two questionable lines in parenthesis.
> 
> That looks ugly.  I'd rather have something like
> 
> 	eval "$USE_OUTPUT $author_script git commit -F \"$MSG\" $EDIT_COMMIT"
> 
> but I'm not quite certain if that is enough, what with the funny 
> characters people put into path names these days ($MSG points to 
> "$DOTEST"/message).

I, too, find it ugly, but I think it's the most readable way to do it. Your 
version is certainly underquoted.

I poked around a bit, but one major obstacle is that the assignments in 
$author_script are on separate lines, which you would have to splice into a 
single line before you can insert them in the eval.

-- Hannes
