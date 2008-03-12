From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 14:55:30 -0500
Message-ID: <47D83532.70103@nrlssc.navy.mil>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site>	<7vskywadum.fsf@gitster.siamese.dyndns.org>	<alpine.LFD.1.00.0803112234470.2947@xanadu.home>	<alpine.LSU.1.00.0803121833210.1656@racer.site>	<47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 20:56:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZX4G-0007PR-6R
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 20:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbYCLT4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 15:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbYCLT4N
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 15:56:13 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41546 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbYCLT4M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 15:56:12 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2CJtU6G001696;
	Wed, 12 Mar 2008 14:55:30 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 12 Mar 2008 14:55:30 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <m3prtzyens.fsf@localhost.localdomain>
X-OriginalArrivalTime: 12 Mar 2008 19:55:30.0430 (UTC) FILETIME=[067601E0:01C8847B]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15778001
X-TM-AS-Result: : Yes--5.026000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDcwNC0xNTA2?=
	=?us-ascii?B?NjgtNzAwMDc1LTEzOTAxMC03MDAxNjAtNzAzNzMxLTcwMzc4OC03?=
	=?us-ascii?B?MDIzNTgtNzAyMDQ0LTcwNDkyNy0xMTAwNTMtNzA3NDUxLTcwMDEw?=
	=?us-ascii?B?NC03MDAzNzMtNzA2ODkxLTcwNTg2MS0xMDU3MDAtNzAwNzgyLTcw?=
	=?us-ascii?B?MjExMy03MDIxNjMtNzA0NDEwLTcwNTM4OC03MDcwODAtNzA5MDY1?=
	=?us-ascii?B?LTcwMTE2My03MDIzNzYtNzAwNTczLTcwNjU2MS03MDc4NTYtNzAx?=
	=?us-ascii?B?MjAyLTcwNDQyNS03MDU0MzEtMTQ4MDM5LTE0ODA1MS0yMDA0MA==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76981>

Jakub Narebski wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> Is 'git-gc --prune' still useful to end users when those in-the-know can use
>> git-prune when they really want all loose unreferenced objects to be removed?
> 
> It is one command less to remember (just like with "git tag --verify"
> and "git verify-tag"), so I'm all for "git gc --prune" to remain.

I think the issue here is that the prune behavior of git-gc is more complex when
both 'git-gc' does prune and 'git-gc --prune' does prune, but only one of them
is controlled by gc.pruneExpire. From a high level perspective, this is
non-obvious and so has to be explicitly outlined in the help text _and_ users
have to remember it. The git-gc command and the documentation and suggested work
flows can all be simplified by just always doing a safe prune.

I think git-prune is seldomly used by normal users for the reasons Dscho
described, and I think once the behavior implemented by his patch becomes
standard it will never be used by normal users (except the ones who always use
--prune for the reasons Geert Bosch described, and they'll probably want the
new behavior). So I think git-prune will sink a little lower into plumbing and
common users won't need to know anything about pruning, and only sophisticated
users will need to know git-prune.

-brandon
