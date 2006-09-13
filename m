From: Andreas Ericsson <ae@op5.se>
Subject: Re: qgit segfaults after b237b00
Date: Wed, 13 Sep 2006 10:45:30 +0200
Message-ID: <4507C52A.6040902@op5.se>
References: <45068577.2020608@op5.se> <e5bfff550609121039h1ef25bc8y25186c321d555b8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 13 10:46:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNQNW-0001Kr-Nu
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 10:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWIMIpe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 04:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWIMIpe
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 04:45:34 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:65508 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750978AbWIMIpd
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 04:45:33 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id C32BA6BD5C; Wed, 13 Sep 2006 10:45:31 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 72B8D6BD5B; Wed, 13 Sep 2006 10:45:30 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550609121039h1ef25bc8y25186c321d555b8e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26909>

Marco Costalba wrote:
> Hi Andreas,
> 
> On 9/12/06, Andreas Ericsson <ae@op5.se> wrote:
>> What subject says, really. Tried cold cache, hot cache, with and without
>> qgit.dat, 3 different repos and 14 different repo-tips. Same result
>> every time. A segfault before anything is drawn.
>>
> 
> Sorry but I am not able to reproduce the bug here. Also from the trace I 
> see
> that the segfault happens in a part of code that has not been touched
> by b237b00.
> And that _should_  not segfault in any way.
> 
> The code there is the same of qgit-1.5.1 so perhaps could be some
> platform related issue,

Probably, yes. Some more digging indicates it comes from trying to fetch 
the system default-font and setting it as the default application-font.

> please write me Qt and gcc versions and processor used and, in case,
> do a complete rebuild with also reconfiguration (autoreconf -i).
> 

Naturally. Forgot it in the first mail *blush*. Mainly running Fedora 
Core 5, except for the kernel which I compile myself.

nox!exon:~/git/qgit$ gcc --version
gcc (GCC) 4.1.1 20060525 (Red Hat 4.1.1-1)
Copyright (C) 2006 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

nox!exon:~/git/qgit$ rpm -q qt
qt-3.3.6-0.4.fc5
nox!exon:~/git/qgit$ uname -a
Linux nox.op5.se 2.6.18-rc6 #1 Wed Sep 6 15:41:35 CEST 2006 i686 i686 
i386 GNU/Linux
nox!exon:~/git/qgit$


Rebuilding with full autoreconf -i does indeed seem to solve the 
problem. I'm guessing some yum update changed the qt-version and the 
configure.cache kept the old settings so that it wasn't checked.

Sorry for the noise.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
