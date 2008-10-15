From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH try 2] t1301-shared-repo.sh: don't let a default ACL 
  interfere with the test
Date: Wed, 15 Oct 2008 08:13:00 +0200
Message-ID: <48F589EC.6050307@viscovery.net>
References: <1224022020.2699.4.camel@mattlaptop2.local> <1224022216.2699.5.camel@mattlaptop2.local> <7vzll66c5u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 08:14:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpzeJ-00011p-Ag
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 08:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbYJOGNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 02:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbYJOGNH
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 02:13:07 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19030 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbYJOGNG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 02:13:06 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kpzcy-0004vZ-MZ; Wed, 15 Oct 2008 08:13:01 +0200
Received: from [127.0.0.1] (unknown [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5499069F; Wed, 15 Oct 2008 08:13:00 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vzll66c5u.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98234>

Junio C Hamano schrieb:
> Matt McCutchen <matt@mattmccutchen.net> writes:
>> diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
>> index dc85e8b..2275caa 100755
>> --- a/t/t1301-shared-repo.sh
>> +++ b/t/t1301-shared-repo.sh
>> @@ -7,6 +7,9 @@ test_description='Test shared repository initialization'
>>  
>>  . ./test-lib.sh
>>  
>> +# Remove a default ACL from the test dir if possible.
>> +setfacl -k . 2>/dev/null
>> +
> 
> Makes me wonder why this is _not_ inside test-lib.sh where it creates the
> test (trash) directory.  That way, you would cover future tests that wants
> to see a saner/simpler POSIX permission behaviour, wouldn't you?

But that would also paper over unanticipated bad interactions with strange
ACLs that people might set, wouldn't it? By not placing this into
test-lib.sh there is a higher chance that such an interaction is revealed,
and we can react on it (educate users or fix the code).

-- Hannes
