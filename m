From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git-branch -m interprets first argument differently when two
 are   supplied
Date: Thu, 14 Feb 2008 10:30:06 -0600
Message-ID: <47B46C8E.5030905@nrlssc.navy.mil>
References: <47B3497A.9050703@nrlssc.navy.mil> <47B3EFC4.1020808@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 17:31:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPgzG-0006dM-Dy
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 17:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276AbYBNQa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 11:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753608AbYBNQa0
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 11:30:26 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58711 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbYBNQaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 11:30:25 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1EGU7lj031963;
	Thu, 14 Feb 2008 10:30:07 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 14 Feb 2008 10:30:06 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47B3EFC4.1020808@viscovery.net>
X-OriginalArrivalTime: 14 Feb 2008 16:30:06.0715 (UTC) FILETIME=[DBCD14B0:01C86F26]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15722001
X-TM-AS-Result: : Yes--11.091000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDU5OC03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMjExMy03MDUxMDItNzAxNjE4LTcxMDk4OS03?=
	=?us-ascii?B?MDI3MjYtNzAyMDUwLTcwODE3OS03MDE1MDAtMTA2NjQwLTcwNDk4?=
	=?us-ascii?B?MC03MDM3MTItNzA1OTI3LTcwMzE1Ny03MDA0NzYtNzAwNzU2LTcw?=
	=?us-ascii?B?ODQ0MC03MDQ0MjUtNzAwNzgyLTcwNjg5MS03MDIxODctNzA2NjM5?=
	=?us-ascii?B?LTcwMDE1MS0xMDY0MjAtNzA3OTk3LTcwNDc4Mi03MDEwMDUtNzAy?=
	=?us-ascii?B?Mzc2LTE0ODAzOS0xNDgwNTEtMjAwNDI=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73884>

Johannes Sixt wrote:
> Brandon Casey schrieb:
>> The first non-option argument is interpreted differently depending on
>> whether one argument or two arguments have been supplied.
>>
>> 	git-branch -m [<oldbranch>] <newbranch>
>>
>> Has anyone considered whether this is inconsistent with how other
>> commands operate?
> 
> Funny, I fell into this trap just yesterday and accidentally renamed
> my master branch to something else. IMO git-branch -m should take two
> arguments. Full stop.

Actually, I think the single argument case is unambiguous and I would
rather not give it up.

It's the two argument case that both expects its arguments in a different
order than other commands _and_ is dangerous in the case of -M.

I was thinking that -M should print a message describing what it is going
to do, and prompt the user for confirmation. A new option could be added
to suppress this behavior like -q. Or we could reuse -f, but see below.

While I'm looking at git-branch, I think the capital forms are unnecessary.
We have a -f (force) option, so I think it makes more sense to deprecate
the captital forms(not remove them), and interpret -f along with -m or -d to
provide the same functionality. Again, with the behavior described above
for confirmation with something like -q.

Oh, and I wouldn't mind switching the arguments around after we have the
confirmation implemented. :)

-brandon
