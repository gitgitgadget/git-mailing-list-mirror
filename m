From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git does the wrong thing with ambiguous names
Date: Thu, 07 Jun 2007 09:41:54 -0500
Message-ID: <46681932.9060808@nrlssc.navy.mil>
References: <4667319C.9070302@nrlssc.navy.mil> <20070606225826.GC3969@steel.home> <20070606233327.GD3969@steel.home> <20070607000100.GE3969@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 16:42:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwJBf-0008Ka-97
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 16:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbXFGOmF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 10:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbXFGOmF
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 10:42:05 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45781 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbXFGOmD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 10:42:03 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l57EdopT017154;
	Thu, 7 Jun 2007 09:39:53 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 7 Jun 2007 09:41:54 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <20070607000100.GE3969@steel.home>
X-OriginalArrivalTime: 07 Jun 2007 14:41:54.0325 (UTC) FILETIME=[FDEFFC50:01C7A911]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15222001
X-TM-AS-Result: : Yes--9.493400-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE0NzAxOC03MDQ3?=
	=?us-ascii?B?MDktNzAwMDc1LTEzOTAxMC03MDA0MTItNzAxNzQ2LTcwMzAwNy03?=
	=?us-ascii?B?MDE1NzYtNzAwMTA0LTcwMTY5MS03MDQwMzQtMTg4MDE5LTcwNDQy?=
	=?us-ascii?B?NS03MDc3NTAtNzAwMzczLTcwOTA1MC03MDAzMjQtNzAxNDYxLTcw?=
	=?us-ascii?B?NTM4OC03MDU1MDgtNzAzNzg4LTcwNjI0OS03MDA5NzAtMTM2MDcw?=
	=?us-ascii?B?LTcwNDQyMS03MDIwMjAtNzAxNjA0LTE0ODA1MS0yMDA0Mg==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49370>

Alex Riesen wrote:
> Alex Riesen, Thu, Jun 07, 2007 01:33:27 +0200:
>> Alex Riesen, Thu, Jun 07, 2007 00:58:26 +0200:
>>> Brandon Casey, Thu, Jun 07, 2007 00:13:48 +0200:
[snip]
> This one is much shorter and less friendly. Suggested by Junio on irc.
> It makes checkout always prefer a branch.
> 
> diff --git a/git-checkout.sh b/git-checkout.sh
> index 6b6facf..282c84f 100755
> --- a/git-checkout.sh
> +++ b/git-checkout.sh
> @@ -67,6 +67,8 @@ while [ "$#" != "0" ]; do
>  			new_name="$arg"
>  			if git-show-ref --verify --quiet -- "refs/heads/$arg"
>  			then
> +				rev=$(git-rev-parse --verify "refs/heads/$arg^0" 2>/dev/null)
> +				new="$rev"
>  				branch="$arg"
>  			fi
>  		elif rev=$(git-rev-parse --verify "$arg^{tree}" 2>/dev/null)
> 

This doesn't work.

Now the working directory contents are never updated when switching 
branches.

Run my test script, or add an 'echo "some data" > a' in your shell code 
so that the two branches have different contents.

-brandon
