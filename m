From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH try 2] t1301-shared-repo.sh: don't let a default ACL 
 interfere with the test
Date: Wed, 15 Oct 2008 09:18:00 +0200
Message-ID: <48F59928.5040502@viscovery.net>
References: <1224022020.2699.4.camel@mattlaptop2.local> <1224022216.2699.5.camel@mattlaptop2.local> <7vzll66c5u.fsf@gitster.siamese.dyndns.org> <48F589EC.6050307@viscovery.net> <7vmyh64bgy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 09:19:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq0f9-0001bD-5R
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 09:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbYJOHSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 03:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbYJOHSG
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 03:18:06 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:49327 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbYJOHSF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 03:18:05 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kq0ds-0006el-R9; Wed, 15 Oct 2008 09:18:01 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 95D4369F; Wed, 15 Oct 2008 09:18:00 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vmyh64bgy.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98244>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Junio C Hamano schrieb:
>> ...
>>>> +# Remove a default ACL from the test dir if possible.
>>>> +setfacl -k . 2>/dev/null
>>>> +
>>> Makes me wonder why this is _not_ inside test-lib.sh where it creates the
>>> test (trash) directory.  That way, you would cover future tests that wants
>>> to see a saner/simpler POSIX permission behaviour, wouldn't you?
>> But that would also paper over unanticipated bad interactions with strange
>> ACLs that people might set, wouldn't it? By not placing this into
>> test-lib.sh there is a higher chance that such an interaction is revealed,
>> and we can react on it (educate users or fix the code).
> 
> What do you exactly mean by "educate users or fix the code"?  For example,
> by not putting this setfacl in test-lib.sh, t1301 revealed that with a
> default ACL higher up, "git init --shared" would not work as expected.
> 
> Then what?
> 
>  - Do you mean, by "educate users", that we teach users not to play fun
>    games with ACL in a git controled working tree?

Correct. In the case of a shared repository we can educate users not to
play with ACLs.

>  - Do you mean, by "fix the code", that we teach adjust_shared_perm() to
>    deal with ACL?

Correct in principle, but we need not go this route in the case of shared
repositories because we better educate users.

-- Hannes
