From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: [GIT-P4] usage under Windows
Date: Sat, 01 Mar 2008 12:44:39 +0100
Message-ID: <B929D1FF-BAF7-4595-9DAF-07E62B90D767@gmail.com>
References: <96c268400802212244g7fd2de2bj6c1b7022885c8e89@mail.gmail.com>
 <47C5E4EC.1060003@trolltech.com>
 <96c268400802291048u31a2d8b6ub1726ade941afb8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7BIT
Cc: Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Maxim Gordienko <mgordienko@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 13:46:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVR7A-0007Nn-Hq
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 13:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366AbYCAMqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 07:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754299AbYCAMqU
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 07:46:20 -0500
Received: from smtp.getmail.no ([84.208.20.33]:48622 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753784AbYCAMqT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 07:46:19 -0500
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Mar 2008 07:46:19 EST
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JX10060DVCWU000@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 01 Mar 2008 12:46:08 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JX100JZBVAEJ550@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 01 Mar 2008 12:44:38 +0100 (CET)
Received: from cm-84.215.103.33.getinternet.no ([84.215.103.33])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JX100KZZVAE6OB0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 01 Mar 2008 12:44:38 +0100 (CET)
In-reply-to: <96c268400802291048u31a2d8b6ub1726ade941afb8c@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75662>

On 29. feb.. 2008, at 19.48, Maxim Gordienko wrote:

> Thank you, Marius for detailed instructions!
> Now everything except submitting back to perforce works like a charm.
> Perforce complains about git-p4 checkout is not under it's root
>
> Synchronizing p4 checkout...
> executing p4 sync ...
> Path 'c:/tmp/p42/main\...' is not under client's root 'c:\p4'.

I have seen it too. I'm not sure, but it seems to me like even though  
the git-p4 script does a chdir(<perforce_dir>) before calling "p4  
<command> <args>" the chdir is "not seen by" p4 on windows.

I have a patch on my machine where i simply change all the p4 calls,  
like so:

system("p4 sync ...") --> system("p4 sync %s..." % self.clientPath)

This seems to work in all cases, and also in Mac OS X... I can  
probably clean the patch up a bit, and submit it later today or  
tomorrow if you're interested.

      -- Tor Arvid
