From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to add daily tags for a central repo?
Date: Tue, 01 Jun 2010 10:05:07 +0200
Message-ID: <4C04BF33.70300@drmicha.warpmail.net>
References: <1275369711233-5124575.post@n2.nabble.com>	<4C04AC1E.7040502@drmicha.warpmail.net> <AANLkTim02FQ3BfV88iylMqbHA5sBbJvp5TmWg52OXCzn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Roy Lee <roylee17@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 10:05:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJMTh-0002p4-7Y
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 10:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015Ab0FAIFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 04:05:31 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:57953 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752028Ab0FAIFa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 04:05:30 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4A317F6D11;
	Tue,  1 Jun 2010 04:05:29 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 01 Jun 2010 04:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=pw7teHcnBnoyQmpnM6koUhM6KoQ=; b=uOQtPbM0uL+eOmSyj8TX22ERW50SRg+BhvpKWaIHNSVWssmVC1KEEv1ddmuza4Nqki5dpHu6nd6vrfMymyPYCR5d/3FHFtiGZC1XcCU/PHaW2y0haYM2a64Ah6KGKtfG8gMReA3XFci0pkFI87peX3/S4nGFxYTe9R2tXSVpJIk=
X-Sasl-enc: ynypQMMJ/w7xb1wdej7mcAtnqsFkyJBWhZpRYg6nRy31 1275379529
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BA5281A445;
	Tue,  1 Jun 2010 04:05:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100526 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTim02FQ3BfV88iylMqbHA5sBbJvp5TmWg52OXCzn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148089>

Roy Lee venit, vidit, dixit 01.06.2010 09:55:
> Hi Michael,
> 
>>
>> Having these tags seems strange to me. Imagine someone pushing a patch
>> series one-by-one around midnight, or pushing a commit and, shortly
>> after, a fixup. You'll end up with a tag pointing to a commit in the middle.
>>
>> The commit time is totally unreliable, as you noticed, also because
>> authors may commit locally, then push later.
>>
>> That being said, if you're really interested in the state of a branch on
>> the central server at a certain point in time it's easiest to enable
>> reflogs on the central repository (by setting core.logAllRefUpdates or
>> enabling individually) and to tag the commit HEAD@{datetimespec} (or
>> branchname@...). No need for cloning.
>>
>> Cheers,
>> Michael
>>
> 
> This is what I'm looking for. Thanks a lot.
> 
> But I have another question:
> How to use the refspec to refer to the reflogs?

Well, as I wrote: HEAD@{datetimespec} for the HEAD,
branchname@{datetimespec} for a branch "branchname". datetimespec is
decribed in git rev-parse's manpage but can be what you'd think (e.g.
"date time") and more ("yesterday").
If you really want to inspect the reflog (not the commits listed in the
reflog) use "git log -g" or, unsurprisingly, "git reflog".

> Or any alternatives for developer to query this information.

The reflog is local to the repo, which is why you would create tags on
the central repo based on the reflog there, if that is your "trusted
time and push reference source".

Cheers,
michael
