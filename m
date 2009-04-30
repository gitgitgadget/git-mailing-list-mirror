From: Andreas Ericsson <ae@op5.se>
Subject: Re: git svn errors out with git-cat-file "usage" message
Date: Thu, 30 Apr 2009 10:26:13 +0200
Message-ID: <49F960A5.5090801@op5.se>
References: <46a038f90904290811p33332bd5h1d397734907ba9c2@mail.gmail.com>	 <32541b130904291150k75a0433fnb29ea59f654a17f7@mail.gmail.com>	 <49F8B7D1.2090903@drmicha.warpmail.net>	 <46a038f90904291347i2ed158aaya7505e1bd11cd392@mail.gmail.com>	 <49F8C127.4000400@drmicha.warpmail.net> <46a038f90904300018u7101943blef084dc907a04c8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Avery Pennarun <apenwarr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mihai Sucan <mihai.sucan@gmail.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 10:26:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzRbR-0004o2-89
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 10:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758127AbZD3I0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 04:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761047AbZD3I0U
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 04:26:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:60820 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760129AbZD3I0P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 04:26:15 -0400
Received: by fg-out-1718.google.com with SMTP id 16so531064fgg.17
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 01:26:14 -0700 (PDT)
Received: by 10.86.1.1 with SMTP id 1mr1605959fga.0.1241079974622;
        Thu, 30 Apr 2009 01:26:14 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 4sm3073066fgg.28.2009.04.30.01.26.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Apr 2009 01:26:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <46a038f90904300018u7101943blef084dc907a04c8d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118000>

Martin Langhoff wrote:
> On Wed, Apr 29, 2009 at 11:05 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> But I just re-read your original report, and there's some inconsistency:
>>
>> git-svn triggers cat-file's usage message which says "git-cat-file ...".
>> The dash indicates that it is a git cat-file before v1.6.0.1-13-g34baebc
>> (where the dash was removed), so it's definitely not the current maint
>> you think you are using.
>>
>> Do you have older ubuntu git packages installed in $PATH?
> 
> Bingo! Yes,
> 
> ~$ which git-cat-file
> /usr/bin/git-cat-file
> ~$ /usr/bin/git version
> git version 1.5.6.3
> 
> now that's really weird. git from ~/bin is using git-cat-file from
> /usr/bin instead of ~/libexec/git-core ... how is the libexec path set
> in the PATH during the execution of the script?
> 

If you're executing "git-svn", the "git-svn" found first in your $PATH
will be used. Same with "git" really, so if you have a $PATH like this:

  PATH=/usr/bin:$(HOME)/bin

you will always use the git from /usr/bin (naturally).

> the funny thing is that Ubuntu wants to have git-core in place if
> you're rebuilding kernel packages. I don't need to rebuild my kernel
> anymore but I am sure this is an issue for others. What's the trick?
> Add the libexec/git-core to the PATH before /usr/bin? Should git
> internally append libexec/git-core earlier in the search path?
> 

The possibly easiest solution to your particular problem is to just
remove the files installed by the git-core package and then log out
and back in (to clear any persistent shell cache). You may need to
mark git-core as not updateable in your apt config.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
