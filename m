From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Thu, 07 May 2009 14:09:11 +0200
Message-ID: <4A02CF67.1010401@drmicha.warpmail.net>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de> <4A02CAD9.9080808@drmicha.warpmail.net> <op.utj6ikav1e62zd@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 07 14:09:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M22Pr-0000cW-EI
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 14:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbZEGMJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 08:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754480AbZEGMJX
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 08:09:23 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:50125 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753028AbZEGMJW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 08:09:22 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 6DF3E34162C;
	Thu,  7 May 2009 08:09:19 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 07 May 2009 08:09:19 -0400
X-Sasl-enc: XVP2jojjUp6t05e48IEqhosV616fM4jp65745UWigBEJ 1241698159
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C378B5A986;
	Thu,  7 May 2009 08:09:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090506 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <op.utj6ikav1e62zd@balu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118467>

Matthias Andree venit, vidit, dixit 07.05.2009 14:04:
> Am 07.05.2009, 13:49 Uhr, schrieb Michael J Gruber  
> <git@drmicha.warpmail.net>:
> 
>> Matthias Andree venit, vidit, dixit 07.05.2009 11:22:
>> ...
>>> The underlying problem flow is:
>>>
>>> 1 - Makefile has "include GIT-VERSION-FILE", thus gmake builds
>>>     GIT-VERSION-FILE early.
>>> 2 - GIT-VERSION-FILE depends on a .PHONY target  
>>> (.FORCE-GIT-VERSION-FILE)
>>> 3 - Thus, GNU make *always* executes GIT-VERSION-GEN
>>> 4 - GIT-VERSION-GEN now, under the stripped $PATH, cannot find "git" and
>>>     sees a different version number.
>>> 5 - GIT-VERSION-GEN notes the difference in versions and regenerates
>>>     GIT-VERSION-FILE, with up-to-date timestamp.
>>> 6 - GNU make rebuilds everything because GIT-VERSION-FILE is new.
>>>
>>> The patch makes GIT-VERSION-GEN look for the current built git$X  
>>> executable,
>>> and in $(prefix)/bin/git, before falling back to plain "git" and thus  
>>> to the
>>> default version in GIT-VERSION-GEN.
>>
>> Thanks for the detailed analysis, now I g[oi]t it!
>> According to the analysis, the problem would also appear with a standard
>> make run (without configure) as long as git is not in the sudoer's $PATH
>> ($prefix isn't, no distro git in /usr).
> 
> I am not sure how useful /this/ example is -- prefix=$HOME is default, no  
> sudo required. make prefix=/opt/git might be a point though.

That's what I meant by my admittedly fuzzy "$prefix isn't".

I just wanted to point out that your PATCH fixes an easy which also
"ordinary" make usage (with prefix and sudo) has, because
autoconf/configure is considered a 2nd class citizen.

>> [commit/diff]
>> Looks good to me. So, untested but reviewed by me.
> 
> Thanks.
> 

Cheers,
Michael
