From: Andreas Mohr <andi@lisas.de>
Subject: Re: Issue: repack semi-frequently fails on Windows (msysgit) -
 suspecting file descriptor issues
Date: Thu, 16 Apr 2015 13:42:35 +0200
Message-ID: <20150416114235.GB30818@rhlx01.hs-esslingen.de>
References: <20150416100359.GA19951@rhlx01.hs-esslingen.de>
 <552F98AC.5030603@virtuell-zuhause.de>
 <27f1120c2c5231d8c7add8bdac7e3b21@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	Andreas Mohr <andi@lisas.de>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>, git-owner@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 16 13:42:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiiBt-0004ud-HH
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 13:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbbDPLmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 07:42:38 -0400
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:34888 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592AbbDPLmg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 07:42:36 -0400
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 102)
	id 4D0A84A80B; Thu, 16 Apr 2015 13:42:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <27f1120c2c5231d8c7add8bdac7e3b21@www.dscho.org>
X-Priority: none
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267279>

Hi,

On Thu, Apr 16, 2015 at 01:31:02PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On 2015-04-16 13:10, Thomas Braun wrote:
> > I've never had this issue. The error message from unlinking the file
> > means that someone is still accessing the file and thus it can not be
> > deleted (due to the implicit file locking on windows).
> 
> Best guess is that an antivirus is still accessing it. There is a tool called `WhoUses.exe` in msysGit (I do not remember if I included it into Git for Windows 1.x for end users) which could be used to figure out which process accesses a given file still: https://github.com/msysgit/msysgit/blob/master/mingw/bin/WhoUses.exe (maybe that would help you identify the cause of the problem).

Oh my. Botched mail conversation...
I tried to f'up on this messy start ASAP, so I even managed to omit this final *pre-existing* part:
"
Please note that this system is hampered by a crappy virus scanner
dependency (F-Secure),
which could be the culprit for this issue (e.g. by keeping files busy
for longer than expected),
however I really don't think that it takes part in this issue.
"

The reason that I suspect that it's not virus scanner related is:
- standalone git gc --auto works immediately
  (hmm but this might also point at the opposite - namely virus scanner
  still accessing files of a prior operation only in case there *was*
  a prior operation)
- file descriptor scope handling issue in git source code is very easily imaginable
- only a very rebase-heavy workflow of a sufficiently large repo
  is likely to have this issue turn up in a frequently enough manner,
  thus it's quite likely that it's not observed (or reported) all too often

Thanks,

Andreas Mohr

-- 
GNU/Linux. It's not the software that's free, it's you.
