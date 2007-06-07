From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git does the wrong thing with ambiguous names
Date: Thu, 07 Jun 2007 17:51:08 -0500
Message-ID: <46688BDC.6000506@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 08 00:51:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwQpA-0000eU-S7
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 00:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932857AbXFGWvO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 18:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936640AbXFGWvN
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 18:51:13 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46855 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936617AbXFGWvM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 18:51:12 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l57Mn2mS020987
	for <git@vger.kernel.org>; Thu, 7 Jun 2007 17:49:05 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 7 Jun 2007 17:51:09 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
X-OriginalArrivalTime: 07 Jun 2007 22:51:09.0114 (UTC) FILETIME=[56C151A0:01C7A956]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15222001
X-TM-AS-Result: : Yes--5.164400-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE0NzAxOC03MDEy?=
	=?us-ascii?B?OTgtMTg4MDE5LTcwMDA3NS0xMzkwMTAtNzA0NzA5LTcwMDQxMi03?=
	=?us-ascii?B?MDE3NDYtNzAzMDA3LTcwMTU3Ni03MDAxMDQtNzAxNjkxLTcwNDAz?=
	=?us-ascii?B?NC03MDQ0MjUtNzA3NzUwLTcwMDM3My03MDkwNTAtNzAwMzI0LTcw?=
	=?us-ascii?B?MTQ2MS03MDUzODgtNzAwOTQ5LTcwNTY4My0xMTMyODktNzA1NTU0?=
	=?us-ascii?B?LTEzNjA3MC03MDM3ODgtNzAwNzgyLTcwMzE3OS03MDAzMTUtNzA0?=
	=?us-ascii?B?NDczLTcwODE3OS03MTAwNzgtNzA2MjQ5LTcwMTMwNS0xNDgwNTEt?=
	=?us-ascii?B?MjAwNDM=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49398>


Didn't hit reply-all...

Brandon Casey wrote:
> Alex Riesen wrote:
>> Alex Riesen, Thu, Jun 07, 2007 01:33:27 +0200:
>>> Alex Riesen, Thu, Jun 07, 2007 00:58:26 +0200:
>>>> Brandon Casey, Thu, Jun 07, 2007 00:13:48 +0200:
> [snip]
>> This one is much shorter and less friendly. Suggested by Junio on irc.
>> It makes checkout always prefer a branch.
>>
>> diff --git a/git-checkout.sh b/git-checkout.sh
>> index 6b6facf..282c84f 100755
>> --- a/git-checkout.sh
>> +++ b/git-checkout.sh
>> @@ -67,6 +67,8 @@ while [ "$#" != "0" ]; do
>>              new_name="$arg"
>>              if git-show-ref --verify --quiet -- "refs/heads/$arg"
>>              then
>> +                rev=$(git-rev-parse --verify "refs/heads/$arg^0" 
>> 2>/dev/null)
>> +                new="$rev"
>>                  branch="$arg"
>>              fi
>>          elif rev=$(git-rev-parse --verify "$arg^{tree}" 2>/dev/null)
>>
> 
> This doesn't work.

sorry, scratch that. It does work.

Thunderbird turned $arg _hat_ 0 into $arg _superscript_ 0, which became
$arg0 when I copy/pasted. And I didn't catch it. Again, apologies.

I think this is the intuitive behavior, prefer branch over tag. though I
think a warning or refusal to switch would be better (but more
complicated, and I don't know how to do it).

A quick run through of some other porcelain commands shows they prefer tag:
git log
git show
git diff

-brandon
