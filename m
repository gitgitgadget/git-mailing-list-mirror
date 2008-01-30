From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] filter-branch: assume HEAD if no revision supplied
Date: Wed, 30 Jan 2008 17:35:03 -0600
Message-ID: <47A109A7.1070502@nrlssc.navy.mil>
References: <47A0D0F0.1020800@nrlssc.navy.mil>	<alpine.LSU.1.00.0801302034310.23907@racer.site> <7vk5lrgh56.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 00:38:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKMVL-0004TB-2D
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 00:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbYA3Xhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 18:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbYA3Xhf
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 18:37:35 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45719 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbYA3Xhd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 18:37:33 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0UNZ4ED011812;
	Wed, 30 Jan 2008 17:35:04 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 30 Jan 2008 17:35:04 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7vk5lrgh56.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 30 Jan 2008 23:35:04.0403 (UTC) FILETIME=[BD694230:01C86398]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15694001
X-TM-AS-Result: : Yes--19.498100-0-2-1
X-TM-AS-Category-Info: : 2:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAzNzMxLTcwMjExMy03MDUxMDItNzA0NDI1LTcwNzM5NS03?=
	=?us-ascii?B?MDIwMzctNzA0NzEyLTcwMjE0My03MDI2MDktNzA2NTYxLTcwMTYw?=
	=?us-ascii?B?NC03MDUwNjEtNzA3NDUxLTExMzIyOC03MDc5MzUtNzA4MjE3LTcw?=
	=?us-ascii?B?MTU4My03MDA5OTktNzAyMzU4LTcxMTQzMi03MDE0NTUtNzA4Njkw?=
	=?us-ascii?B?LTcwNzM2MS0xMDUwNDAtMTA2NDIwLTcwMDQ3Ni03MDM3ODgtNzA0?=
	=?us-ascii?B?MDgzLTcwMTQ2My03MDk1ODQtMTA1NzAwLTcwNDUwNC03MDc0MTAt?=
	=?us-ascii?B?NzAyNTUxLTcwMDc1Ni03MTA1MTItNzAxODM3LTcwMzcxMi03MDQ5?=
	=?us-ascii?B?ODAtNzA2NjQ5LTcwMzA5Ni03MDE0MjgtNzAxOTE0LTcwMDYxOC0x?=
	=?us-ascii?B?MDYyMzAtNzAyNzkxLTcwOTI5MS03MDkwNjUtMTQ4MDM5LTE0ODA1?=
	=?us-ascii?B?MS0yMDA0Mw==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72077>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> On Wed, 30 Jan 2008, Brandon Casey wrote:
>>
>>> filter-branch previously took the first non-option argument as the name 
>>> for a new branch. Since dfd05e38, it now takes a revision or a revision 
>>> range and modifies the current branch. Update to operate on HEAD by 
>>> default to conform with standard git interface practice.
>> FWIW I think the code wanted to let "git filter-branch" without options 
>> print the usage.
> 
> That might be a valid safety concern to some folks.  Previously
> we have seen people say "Whenever I see a command foo that I do
> not know what it does, I type 'foo <Enter>' and expect it gives
> the usage back.  So any new destructive command 'foo' should not
> do a damage by using built-in default." (I think it was about
> "git stash" without parameter).
> 
> By the way, I do not personally think it is worth to be heavily
> supportive to the practice of trying an unknown command without
> understanding, and I do not agree such a safety is necessarily a
> good idea, especially if it makes normal use of the command more
> cumbersome by people who understand what it does.
> 
> Even though "git stash" itself is not destrictive, you need to
> know its "apply" subcommand to undo the action.  In that sense,
> it is destructive to clueless people who blindly type whatever
> command they see.
> 
> That's why we still allow you to say "git stash", but we removed
> its "git stash <randam message>" syntax, which was risky when
> subcommand name was misspelled even by people who know what the
> command does.  I think we struck a good balance between
> usability and safety there.  And I think we can do the same
> here.
>
> Perhaps "git filter-branch <Enter>" can be prevented as in the
> current implementation while "git filter-branch --foo-filter
> foo" can default to HEAD to satisfy both needs.  The command
> without any filter is supposed to be mostly no-op (unless you
> are trying to rewrite the history with grafts).

That's what I was trying to do :)

The goal should be consistency in the user interface. New users will
always get confused. Lack of consistency could cause confusion for
experienced users. I sent a patch because it was intuitive to me for
filter-branch to operate on HEAD based on my git experience, and I was
surprised when it did not. For porcelain that take a revision argument
it seems common to default to HEAD.

I think the stash case is a little bit different because it was
actually causing problems for experienced users. A minor typo would
bite experienced people from time to time.

In that same consistency vein, I wonder if a user would be surprised
that 'git filter-branch' prints usage information but 'git filter-branch --'
operates on HEAD? Maybe the following patch would be better than the
compromise solution. (following in another email)

-brandon

PS. Please s/format-patch/filter-branch/ if I missed any. I keep
doing that.
