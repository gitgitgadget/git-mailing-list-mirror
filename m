From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [1.8.0] Recursively checkout, merge and reset populated submodules
Date: Mon, 21 Feb 2011 23:54:48 +0100
Message-ID: <4D62ED38.7070408@web.de>
References: <7vwrky5f48.fsf@alter.siamese.dyndns.org> <4D5FF6E7.8090104@web.de> <4D628F21.3050808@xiplink.com> <4D62AF46.8030508@web.de> <4D62C385.90204@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 23:54:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Preed-0002qH-EI
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 23:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863Ab1BUWyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 17:54:50 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:48037 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab1BUWyt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 17:54:49 -0500
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 740D81897DB5A;
	Mon, 21 Feb 2011 23:54:48 +0100 (CET)
Received: from [93.246.36.188] (helo=[192.168.178.43])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PreeW-0003MV-00; Mon, 21 Feb 2011 23:54:48 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D62C385.90204@xiplink.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/U3DmQpqSAdnRVwfa8ePiiFYJGi2piDitcFuch
	6gEuDDyaFEzBfPurGNfls+KhszzZ1WF0MgMKMqyB45BV7i/xWb
	hr6TfB3tIezvyy4cE98g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167508>

Am 21.02.2011 20:56, schrieb Marc Branchaud:
> On 11-02-21 01:30 PM, Jens Lehmann wrote:
>> Am 21.02.2011 17:13, schrieb Marc Branchaud:
> A lot of what I'm confused about is how git would distinguish between 2 things:
> 
>  - How the user specifies submodule recursion within a local repo.
> 
>  - How a repo specifies initial submodule recursion for clones.
> 
> I'm happy to wait for your follow-up work to discuss this.  Cloning aside,
> what you're proposing looks good to me.

Cool. When I'm done with the local repo stuff I'll continue working on the
cloning part, so stay tuned for further discussions on that topic :-)

>> But for plumbing a "respect" option
>> makes sense, using it could tell it to use the same defaults and config
>> that porcelain uses to make writing scripts easier.
> 
> I haven't thought enough about plumbing to tell if it makes sense to
> configure plumbing behavior explicitly.  But at first glance it seems odd...

Plumbing shouldn't care about user config by default because the aim is to
have predictable behavior. But e.g. git gui, which is using plumbing under
the hood to do the actual checkout, should honor user configuration and
porcelain defaults (because it is percieved by the user as being porcelain
itself). So git gui would benefit from being able to simply tell plumbing
"behave like you were porcelain" through an option instead of coding
recursion, user configuration and the safety checks needed before checkout
itself. And this would avoid code duplication too.

>>> * What will happen when I start checked out at commit A, with a populated
>>> submodule, then check out commit B where that submodule doesn't exist, then
>>> return to commit A?  How will whatever recursion settings I had at the start
>>> be preserved?
>>
>> I think the same option that controls the cloning of submodules should
>> control whether a new submodule will be populated or not. For submodules
>> that already existed despite that it might be nice to remember and respect
>> the users choice and restore it if it existed before.
> 
> So, .gitmodules initially controls recursion.  When a submodule gets
> populated, it gets an entry in .git/config which then determines the
> recursion behavior from then on.  Changing branches might change .gitmodules,
> but anything in .git/config will persist so any customizations the user makes
> will also persist.

Yes. Upstream can give sane defaults but the user has the last word.

> Sounds good to me!

Great to hear!
