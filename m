From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git svn errors out with git-cat-file "usage" message
Date: Thu, 30 Apr 2009 10:46:19 +0200
Message-ID: <49F9655B.6070302@drmicha.warpmail.net>
References: <46a038f90904290811p33332bd5h1d397734907ba9c2@mail.gmail.com>	 <32541b130904291150k75a0433fnb29ea59f654a17f7@mail.gmail.com>	 <49F8B7D1.2090903@drmicha.warpmail.net>	 <46a038f90904291347i2ed158aaya7505e1bd11cd392@mail.gmail.com>	 <49F8C127.4000400@drmicha.warpmail.net> <46a038f90904300018u7101943blef084dc907a04c8d@mail.gmail.com> <49F960A5.5090801@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mihai Sucan <mihai.sucan@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Apr 30 10:46:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzRuf-0004YH-Go
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 10:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761368AbZD3Iqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 04:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760588AbZD3Iqa
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 04:46:30 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49124 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761178AbZD3Iq2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2009 04:46:28 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 0CE51336C88;
	Thu, 30 Apr 2009 04:46:28 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 30 Apr 2009 04:46:28 -0400
X-Sasl-enc: alIoUIpOu94yYAjBxen43grFo2PTzvXlTAzNC1SqW6Xc 1241081187
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0D2352D629;
	Thu, 30 Apr 2009 04:46:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090427 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <49F960A5.5090801@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118003>

Andreas Ericsson venit, vidit, dixit 30.04.2009 10:26:
> Martin Langhoff wrote:
>> On Wed, Apr 29, 2009 at 11:05 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> But I just re-read your original report, and there's some inconsistency:
>>>
>>> git-svn triggers cat-file's usage message which says "git-cat-file ...".
>>> The dash indicates that it is a git cat-file before v1.6.0.1-13-g34baebc
>>> (where the dash was removed), so it's definitely not the current maint
>>> you think you are using.
>>>
>>> Do you have older ubuntu git packages installed in $PATH?
>>
>> Bingo! Yes,
>>
>> ~$ which git-cat-file
>> /usr/bin/git-cat-file
>> ~$ /usr/bin/git version
>> git version 1.5.6.3
>>
>> now that's really weird. git from ~/bin is using git-cat-file from
>> /usr/bin instead of ~/libexec/git-core ... how is the libexec path set
>> in the PATH during the execution of the script?
>>
> 
> If you're executing "git-svn", the "git-svn" found first in your $PATH
> will be used. Same with "git" really, so if you have a $PATH like this:
> 
>   PATH=/usr/bin:$(HOME)/bin
> 
> you will always use the git from /usr/bin (naturally).

But he wrote he executed "git svn", and "git --version" showed the more
current version. So it can't be a PATH issue. It may be PERL5LIB, though.

> 
>> the funny thing is that Ubuntu wants to have git-core in place if
>> you're rebuilding kernel packages. I don't need to rebuild my kernel
>> anymore but I am sure this is an issue for others. What's the trick?
>> Add the libexec/git-core to the PATH before /usr/bin? Should git
>> internally append libexec/git-core earlier in the search path?
>>
> 
> The possibly easiest solution to your particular problem is to just
> remove the files installed by the git-core package and then log out
> and back in (to clear any persistent shell cache). You may need to
> mark git-core as not updateable in your apt config.
> 
