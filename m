From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Tue, 03 Mar 2009 12:56:47 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0903031254440.3702@perkele.intern.softwolves.pp.se>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
 <37fcd2780903030143t7abe33d5sb7d8163c3c9bf505@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:59:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeTHP-0002S5-1E
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 12:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245AbZCCL5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 06:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbZCCL5y
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 06:57:54 -0500
Received: from smtp.getmail.no ([84.208.20.33]:61688 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754133AbZCCL5y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 06:57:54 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KFX00D0BIKG1Z00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 03 Mar 2009 12:57:52 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFX001ULIINRE30@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 03 Mar 2009 12:56:47 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFX00KG5IINADB0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 03 Mar 2009 12:56:47 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id 3B516189B20; Tue,
 03 Mar 2009 12:56:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 37E5A1A97FE; Tue, 03 Mar 2009 12:56:47 +0100 (CET)
In-reply-to: <37fcd2780903030143t7abe33d5sb7d8163c3c9bf505@mail.gmail.com>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112063>

Dmitry Potapov:

> IMHO, you grossly underestimate what is needed to enable UTF-8 encoding in 
> Windows. AFAIK, Microsoft C runtime library does not support UTF-8, so you 
> have to wrap all C functions taking 'char*' as an input parameter.

I have to wrap all file-related functions, at least.

> For example, think about what is going to happen if Git tries to print a 
> simple error message: fprintf (stderr, "unable to open %s", path);

Yeah. That's a problem. That might be solvable by setting the thread locale 
to something UTF-8 based and have the console window convert to the output 
codepage (that is what it does when you use wprintf and friends).

> And the command-line is not the only source of file names. Some Git 
> commands read list of files from stdin usually though the pipe. In what 
> encoding are they going to be?

Indeed. Pipes are a problem.

-- 
\\// Peter - http://www.softwolves.pp.se/
