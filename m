From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git svn errors out with git-cat-file "usage" message
Date: Thu, 30 Apr 2009 11:28:10 +0200
Message-ID: <49F96F2A.5020108@drmicha.warpmail.net>
References: <46a038f90904290811p33332bd5h1d397734907ba9c2@mail.gmail.com>	 <32541b130904291150k75a0433fnb29ea59f654a17f7@mail.gmail.com>	 <49F8B7D1.2090903@drmicha.warpmail.net>	 <46a038f90904291347i2ed158aaya7505e1bd11cd392@mail.gmail.com>	 <49F8C127.4000400@drmicha.warpmail.net>	 <46a038f90904300018u7101943blef084dc907a04c8d@mail.gmail.com> <46a038f90904300153v22aa3e9fo407ff5084b58b5fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mihai Sucan <mihai.sucan@gmail.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 11:28:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzSZ8-0005h4-Ew
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 11:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbZD3J2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 05:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbZD3J2T
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 05:28:19 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40034 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751115AbZD3J2S (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2009 05:28:18 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 609A63312C4;
	Thu, 30 Apr 2009 05:28:18 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 30 Apr 2009 05:28:18 -0400
X-Sasl-enc: E5fPy23WGHv8MgJ7YyNxyfRF0+2+KHtgbC8n+S25zMyp 1241083698
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8F05A32AC0;
	Thu, 30 Apr 2009 05:28:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090427 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <46a038f90904300153v22aa3e9fo407ff5084b58b5fc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118009>

Martin Langhoff venit, vidit, dixit 30.04.2009 10:53:
> On Thu, Apr 30, 2009 at 9:18 AM, Martin Langhoff
> <martin.langhoff@gmail.com> wrote:
>> Bingo! Yes,
>>
>> ~$ which git-cat-file
>> /usr/bin/git-cat-file
>> ~$ /usr/bin/git version
>> git version 1.5.6.3
> 
> Actually, after removing the git-core package and all its dependencies...
> 
> # same git version that succeeds on Fedora 9, here says:
> $ git svn  clone  -T trunk  http://paintweb.googlecode.com/svn paintweb.git
> usage: git-cat-file [-t|-s|-e|-p|<type>] <sha1>
> error closing pipe: Broken pipe at
> /home/martin/libexec/git-core/git-svn line 3252
> cat-file --batch: command returned error: 129
> 
> error closing pipe: Bad file descriptor at
> /home/martin/libexec/git-core/git-svn line 0
> error closing pipe: Bad file descriptor at
> /home/martin/libexec/git-core/git-svn line 0
> $ git version
> git version 1.6.0.6
> 
> # a newer git says...
> $ git svn clone -T trunk --ignore-paths releases
> http://paintweb.googlecode.com/svn paintweb.git
> usage: git-cat-file [-t|-s|-e|-p|<type>] <sha1>

That one is definitely not from a newer git. What do you do in between
the two steps above and below, where the same command "git version"
returns different results? You must have some older parts lying around
somewhere, whether they get picked up by on old or new git svn or Git.pm.

What do the following say:

which git-cat-file
which git
git --exec-path
#desperate last attemtp
find / -name git-cat-file | xargs -n 1 sh -c

> Unexpected result returned from git cat-file at
> /home/martin/libexec/git-core/git-svn line 3526
> Failed to read object 4b90eef95225bb9e34000e050d0cac8b84ab36f6 at
> /home/martin/libexec/git-core/git-svn line 3527.
> 
> $ git version
> git version 1.6.2.4.10.g2254d
> 
> ... the plot thickens...
> 
> There is nothing in my env that would confuse git -- and my PATH has
> ~/bin as the first entry, trumping everything else. So perhaps the
> debian package had nothing to do with this?
> 
> Perl SVN bindings? How do I debug that side of things?
> 
> cheers,
> 
> 
> 
> m
