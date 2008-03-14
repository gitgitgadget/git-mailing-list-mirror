From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t/t6000lib.sh: tr portability fix fix
Date: Fri, 14 Mar 2008 17:06:10 -0500
Message-ID: <47DAF6D2.7050808@nrlssc.navy.mil>
References: <20080314205415.GA17728@coredump.intra.peff.net> <47DAED87.1000408@nrlssc.navy.mil> <20080314214550.GA18326@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: armstrong.whit@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 23:07:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaI48-0006KD-VQ
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 23:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbYCNWG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 18:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbYCNWG5
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 18:06:57 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48616 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbYCNWG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 18:06:56 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2EM6O1j006176;
	Fri, 14 Mar 2008 17:06:24 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 14 Mar 2008 17:06:11 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <20080314214550.GA18326@coredump.intra.peff.net>
X-OriginalArrivalTime: 14 Mar 2008 22:06:11.0173 (UTC) FILETIME=[9CBBF150:01C8861F]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15784001
X-TM-AS-Result: : Yes--11.836000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMTE4Mi03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDQ4MS03MDE0NTUtNzAwNzAxLTE4ODAxOS03?=
	=?us-ascii?B?MDc0NTEtNzExNjY0LTEwNTI1MC03MDUxMDItNzAwNjQ4LTcwMTQ2?=
	=?us-ascii?B?MS03MDUzODgtNzA2ODkxLTcwMzE1Ny03MDA5NzAtMTQ4MDM5LTIw?=
	=?us-ascii?B?MDQy?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77293>

Jeff King wrote:
> On Fri, Mar 14, 2008 at 04:26:31PM -0500, Brandon Casey wrote:
> 
>> Here's the version with escaped dashes. If you do the sed version, it's
>> something to compare to for readability.
>>
>> [...]
>>
>> -		   '------------------------------' |
>> +		   '\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-' |
> 
> Ugh. How about:
> 
>   sed 'yA~`!@#$%^&*()_+={}[]|\;:"<>,/? A------------------------------A'

Not working. I get:

*   ok 33: bisection diff --bisect u5 ^U <= 0
sed: -e expression #1, char 64: unterminated `y' command
* FAIL 34: --bisect l5 ^root
        check_output  "git rev-list $_bisect_option l5 ^root"
sed: -e expression #1, char 64: unterminated `y' command
* FAIL 35: --bisect l5 ^root ^c3
        check_output  "git rev-list $_bisect_option l5 ^root ^c3"
sed: -e expression #1, char 64: unterminated `y' command
* FAIL 36: --bisect l5 ^root ^c3 ^b4


But this does:

sed 'yA~`!@#$%^&*()_+={}\[]|\\;:"<>,/? A------------------------------A'

I have to escape open bracket and backslash on my end (linux). :(

Have to leave now, so if that doesn't work for you (which I'm thinking it
won't), I won't be able to test on my end for a while.

-brandon
