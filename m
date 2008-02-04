From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Mon, 04 Feb 2008 16:44:17 -0600
Message-ID: <47A79541.6070900@nrlssc.navy.mil>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com> <1201975757-13771-1-git-send-email-hjemli@gmail.com> <alpine.LSU.1.00.0802021815510.7372@racer.site> <alpine.LSU.1.00.0802021825220.7372@racer.site> <47A78104.9050909@nrlssc.navy.mil> <alpine.LSU.1.00.0802042128170.8543@racer.site> <47A78CF9.6040001@nrlssc.navy.mil> <alpine.LSU.1.00.0802042218280.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 23:45:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMA3l-0001TB-RZ
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 23:45:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755634AbYBDWoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 17:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755081AbYBDWod
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 17:44:33 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42387 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731AbYBDWod (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 17:44:33 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m14MiH5B013660;
	Mon, 4 Feb 2008 16:44:18 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 4 Feb 2008 16:44:17 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LSU.1.00.0802042218280.8543@racer.site>
X-OriginalArrivalTime: 04 Feb 2008 22:44:17.0851 (UTC) FILETIME=[799710B0:01C8677F]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15706001
X-TM-AS-Result: : Yes--14.633500-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAxNDU1LTcwNzExOS03MTE5NTMtNzA0NzEyLTE4ODAxOS03?=
	=?us-ascii?B?MDIwNDQtNzA5NTg0LTcwMTkxNC03MDIwMjAtMTIxMTE2LTcwNjcx?=
	=?us-ascii?B?OS03MDQ3ODItNzA0NDI1LTEzNjA3MC03MDkwNjUtNzA1Mzg4LTcw?=
	=?us-ascii?B?NDk4MC03MDM3ODgtNzA2MTU5LTcwNzgwMC03MDE3MTktNzA0OTM0?=
	=?us-ascii?B?LTcwMTAwNS03MDI3MjYtMTQ4MDM5LTE0ODA1MS0yMDA0Mw==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72586>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 4 Feb 2008, Brandon Casey wrote:
> 
>> Johannes Schindelin wrote:
>>> On Mon, 4 Feb 2008, Brandon Casey wrote:
>>>> Have you thought about using git-clone instead?
>>> Briefly.  But this is not about cloning the repository.  It is about 
>>> having an additional working directory for the current repository.
>> I think that is true at the low level, but from a high level it feels 
>> similar to me.
>>
>> [...]
>>
>>> I _want_ the original repository to know that there is another working 
>>> directory.
>> Yes, your ideas are much better than simply adding the functionality of 
>> the git-new-workdir script (which is what I was planning on doing btw :)
> 
> Somehow these two statements do not work together.  Either you have a 
> clone, or you accept that a new working directory is actually working on 
> the _same_ repository.

When we talk about clones we are not always talking about a strict "full"
clone. We have at least:

	1) Full clone repository (with/without hardlinks, each is completely
	   independent)
	2) --shared/--reference (dependent on original repo, fragile)
	3) shallow repository (mostly independent)

If your statement above is rephrased to "I _want_ the original repository to
know that it has conjoined siblings.", then we have a new repository type:

	4) conjoined repository (it has multiple sibling repositories each
	   with their own working directory, but they all share and modify the
	   same .git directory)

-brandon
