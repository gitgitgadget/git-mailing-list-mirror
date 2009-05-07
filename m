From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Thu, 07 May 2009 14:04:59 +0200
Message-ID: <op.utj6ikav1e62zd@balu>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de>
 <4A02CAD9.9080808@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 07 14:05:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M22Le-000707-Nn
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 14:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbZEGMFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 08:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755231AbZEGMFD
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 08:05:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:42166 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753706AbZEGMFB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 08:05:01 -0400
Received: (qmail invoked by alias); 07 May 2009 12:05:00 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu) [131.234.21.37]
  by mail.gmx.net (mp009) with SMTP; 07 May 2009 14:05:00 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX19THe4ZO2pT1VmXCL4GlphhiAcT/QJWU3iMe43xh1
	OiGgrnkPZus77J
In-Reply-To: <4A02CAD9.9080808@drmicha.warpmail.net>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118466>

Am 07.05.2009, 13:49 Uhr, schrieb Michael J Gruber  
<git@drmicha.warpmail.net>:

> Matthias Andree venit, vidit, dixit 07.05.2009 11:22:
> ...
>> The underlying problem flow is:
>>
>> 1 - Makefile has "include GIT-VERSION-FILE", thus gmake builds
>>     GIT-VERSION-FILE early.
>> 2 - GIT-VERSION-FILE depends on a .PHONY target  
>> (.FORCE-GIT-VERSION-FILE)
>> 3 - Thus, GNU make *always* executes GIT-VERSION-GEN
>> 4 - GIT-VERSION-GEN now, under the stripped $PATH, cannot find "git" and
>>     sees a different version number.
>> 5 - GIT-VERSION-GEN notes the difference in versions and regenerates
>>     GIT-VERSION-FILE, with up-to-date timestamp.
>> 6 - GNU make rebuilds everything because GIT-VERSION-FILE is new.
>>
>> The patch makes GIT-VERSION-GEN look for the current built git$X  
>> executable,
>> and in $(prefix)/bin/git, before falling back to plain "git" and thus  
>> to the
>> default version in GIT-VERSION-GEN.
>
> Thanks for the detailed analysis, now I g[oi]t it!
> According to the analysis, the problem would also appear with a standard
> make run (without configure) as long as git is not in the sudoer's $PATH
> ($prefix isn't, no distro git in /usr).

I am not sure how useful /this/ example is -- prefix=$HOME is default, no  
sudo required. make prefix=/opt/git might be a point though.

> [commit/diff]
> Looks good to me. So, untested but reviewed by me.

Thanks.

-- 
Matthias Andree
