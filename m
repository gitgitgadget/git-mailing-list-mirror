From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 01:44:04 +0100
Message-ID: <200801180144.06253.robin.rosenberg.lists@dewire.com>
References: <478E1FED.5010801@web.de> <alpine.LSU.1.00.0801171556170.5731@racer.site> <2010BC03-E5AE-4333-96CA-4A9B700AD720@sb.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Mitch Tishmack <mitcht.git@gmail.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 01:44:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFfLX-0005l4-6k
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 01:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756857AbYARAoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 19:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756662AbYARAoG
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 19:44:06 -0500
Received: from [83.140.172.130] ([83.140.172.130]:6658 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756597AbYARAoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 19:44:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C643E8030D9;
	Fri, 18 Jan 2008 01:44:02 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XK-Td5EZ3oi2; Fri, 18 Jan 2008 01:44:01 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id C342D80264C;
	Fri, 18 Jan 2008 01:44:01 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <2010BC03-E5AE-4333-96CA-4A9B700AD720@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70942>

torsdagen den 17 januari 2008 skrev Kevin Ballard:
> On Jan 17, 2008, at 10:57 AM, Johannes Schindelin wrote:
> 
> > On Thu, 17 Jan 2008, Kevin Ballard wrote:
> >
> >> On Jan 17, 2008, at 5:22 AM, Wincent Colaiuta wrote:
> >>
> >>> While it's a nice workaround, it really is just that (a workaround)
> >>> because performance will be suboptimal in a repository running on a
> >>> disk image (and many of switched to Git because of its speed).
> >>
> >> Not only is it suboptimal, it's also not acceptable, plain and  
> >> simple.
> >
> > If it's not acceptable, do something about it (and I don't mean  
> > writing 50
> > emails). If you don't want to do something about it, I have to  
> > assume that
> > you accept it as-is.
> 
> I never said I don't want to do anything about it. However, I do  
> believe that it will take a significant investment of time and energy  
> to learn all the gooey details of how git handles filenames and how  
> the index works and all that jazz, which is knowledge that other  
> people already have. I believe that, for me to solve this problem  
> independently, it may require so much time that it never gets done  
> (after all, I am fairly busy). However, if other people who already  
> have this knowledge are willing to help, that would make this task far  
> easier, especially given that if nobody else even acknowledges that  
> this is a problem I don't have much hope of getting a patch accepted.
> 
> So again, I'm certainly going to try, but working by myself it simply  
> may never get done.

(This is only for those that think the problem should be solved somehow. The
rest can move on - nothing to see here)

You may look at http://rosenberg.homelinux.net/cgi-bin/gitweb/gitweb.cgi?p=GIT.git;a=log;h=i18n
for inspiration. It's pretty obsolete by now and only a "proof of concept", i.e.
it can be done, not that it necessarily should be done exactly this way.

Basically it intercepts the user's access to git, i.e. certain commands
and how files are named (since those names represent a user interface). Then
it assumes the internal encoding is UTF-8 (or garbage) converting to and
from the user's local encoding. The heuristics is based on the assumption that
a string (even random onesthat looks like UTF-8, with a very high probablity
actually is UTF-8 encoded.

The test cases might be usable almost as is.

-- robin
