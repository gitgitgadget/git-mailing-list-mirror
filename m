From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
 to
Date: Wed, 25 Jun 2008 12:12:58 +0300
Message-ID: <48620C1A.6000509@panasas.com>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 11:14:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBR52-0003oc-Bq
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 11:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbYFYJNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 05:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754113AbYFYJNY
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 05:13:24 -0400
Received: from gw-colo-pa.panasas.com ([66.238.117.130]:1694 "EHLO
	natasha.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753968AbYFYJNX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 05:13:23 -0400
Received: from daytona.int.panasas.com (daytona.int.panasas.com [172.17.28.41])
	by natasha.panasas.com (8.13.1/8.13.1) with ESMTP id m5P9DHi3023644;
	Wed, 25 Jun 2008 05:13:17 -0400
Received: from bh-buildlin2.bhalevy.com ([172.17.28.123]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 25 Jun 2008 05:13:01 -0400
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <7vwskea2ik.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 25 Jun 2008 09:13:02.0202 (UTC) FILETIME=[AB4CF5A0:01C8D6A3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86259>

Junio C Hamano wrote:
> Steven Walter <stevenrwalter@gmail.com> writes:
> 
>> @@ -225,6 +243,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>>  	if (reset_type == HARD && is_bare_repository())
>>  		die("hard reset makes no sense in a bare repository");
>>  
>> +        if (reset_type == HARD && !force && index_is_dirty()) {
>> +                die("Uncommitted changes; re-run with -f to trash them");
>> +        }
>> +
> 
> Please don't.  With your change, does the testsuite even pass?
> 
> "reset --hard" has *ALWAYS* meant to be destructive --- discarding
> potential local cruft is the whole point of the operation.
> 

I was under the impression that --hard means working-directory-also
as opposed to tree-and-index-only. Nothing to do with 
destructive-discarding. If it is then something is missing.
I need 2 distinct functions. You combine to functions under
one command.

> Learn the lingo, and get over it.
> 

I did lern the lingo and got bitten. I wanted to do one thing
also got the other one.

there is:
git-reset --clean - destructive-discarding any local changes
git-reset --hard - move tree index and working directory to new head

How can I separate between them, Please

Boaz
