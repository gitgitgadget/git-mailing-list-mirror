From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: cherry-pick --since ?
Date: Mon, 23 Apr 2007 12:52:35 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0704231208490.4667@torch.nrlssc.navy.mil>
References: <Pine.LNX.4.64.0704201100050.4667@torch.nrlssc.navy.mil>
 <7v647qy7dn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 19:52:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg2iR-0002QR-Qi
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 19:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbXDWRwl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 13:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161151AbXDWRwl
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 13:52:41 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34296 "EHLO
	mail1.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161113AbXDWRwk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 13:52:40 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail1.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l3NHqlhG026251
	for <git@vger.kernel.org>; Mon, 23 Apr 2007 12:52:50 -0500
Received: from torch.nrlssc.navy.mil ([128.160.25.59]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Apr 2007 12:52:35 -0500
In-Reply-To: <7v647qy7dn.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 23 Apr 2007 17:52:35.0979 (UTC) FILETIME=[2D1B15B0:01C785D0]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15128001
X-TM-AS-Result: : Yes--12.660800-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY2OC0xNDcw?=
	=?us-ascii?B?MTgtNzAwMDc1LTEzOTAxMC03MDAxNjAtNzAzNzMxLTcwOTU4NC03?=
	=?us-ascii?B?MDQ3ODItMTA1MDQwLTcwMTU3Ni03MDI5MDAtMTg4MDE5LTcwNTM4?=
	=?us-ascii?B?OC03MDA0ODEtNzAyMzU4LTcwMzcxMi03MDQ0MzAtNzA1MTc4LTcw?=
	=?us-ascii?B?MzUyOS03MDE2MTgtNzAxNDU1LTcwMjAxNi03MDA2NjAtNzAxNzM4?=
	=?us-ascii?B?LTE4NzA2Ny03MDM0MTctNzAxNDM3LTcwNTU4NC03MDEyMzYtNzEx?=
	=?us-ascii?B?NDMyLTcwMjAyMC03MDQxMDItNzAwMzAwLTcwNTE2Ny03MDU2MDgt?=
	=?us-ascii?B?NzAyNzkxLTcwNDcwOS03MDQ3MTQtNzAxODM3LTE0ODA1MC0yMDA0?=
	=?us-ascii?B?Mw==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45345>

On Fri, 20 Apr 2007, Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
>
>> Is there functionality to allow something akin to
>> a
>>    git cherry-pick --since <commit>
>>
>> or maybe syntax similar to git cherry where the upstream, head,
>> and limit can be specified. Or the .. syntax would work.
>>
>>
>> Here's my use case:
>>
>> Two branches, 'A' and 'B'.
>> 'A' is the master branch.
>> 'B' was forked some time ago and is in bug fix only mode.
>> Much of 'A' and 'B' are still the same, but there have been
>>   some intrusive changes made to 'A' that should not go into 'B'.
>
> You forgot to say "My objective is to make sure all the good
> fixes in B are forward ported to A" but I am assuming that is
> the case.

Yes, that is the case, but the flow is both ways. Other developers
may implement fixes in 'A', which must be backported to 'B'. They
don't care about 'B'.

>>   This is also why I can't just pull from 'B'. rebase may work,
>>   but then of course all of the commit id's change.
>
> I do not understand why you cannot merge 'B' into 'A'.  From the
> commit ancestry perspective, merging is exactly the right thing
> to do if your goal is to forward port all fixes in B to A.

I thought I recalled having problems with a different tree and a
similar situation, where a merge did not do what I expected. I'll
have to take a look at that one again and post a scenario if I
find one.

I just tried a pull from 'B' into 'A' with this tree, and it worked.
The need to cherry-pick from 'A' into 'B' still exists though. The
work around using format-patch that Alex suggested does work. Being
able to cherry-pick a range in a more direct way seems like it would
be useful though.

-brandon
