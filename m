From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/2] RUNTIME_PREFIX enhancements
Date: Wed, 18 Feb 2009 20:38:42 +0100
Message-ID: <499C63C2.3050405@kdbg.org>
References: <cover.1234969572u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 20:41:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZsHQ-0008Oa-UT
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 20:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbZBRTi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 14:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbZBRTi4
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 14:38:56 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:8839 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbZBRTi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 14:38:56 -0500
Received: from [77.119.118.150] (77.119.118.150.wireless.dyn.drei.com [77.119.118.150])
	by bsmtp.bon.at (Postfix) with ESMTP id BFCB2CDF92;
	Wed, 18 Feb 2009 20:38:46 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <cover.1234969572u.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110570>

Johannes Schindelin schrieb:
> When I ran "make" in msysGit's /git/, I was greeted by a pretty unfriendly 
> message about a RUNTIME_PREFIX that could not be determined.

;)

I have a patch in my private tree that removes the warning.

Actually I wouldn't mind the warning because it is only visible for 
developers. Unfortunately, it is poison for gitk (you know, Tcl/Tk 
treats any output on stderr as program failure...)

> The real meat comes in patch 2/2:
> 
> The problem is that Windows will look in the current directory before 
> looking in the PATH when it tries to execute a program.  So it will find 
> the executable C:\msysgit\git\git.exe and be unable to strip the suffices 
> "libexec/git-core" or "bin".
> 
> I just added "git" (which should not hurt other users, but instead help 
> them if they did not install Git but run it in-place).

This only silences the warning, but there is no guarantee that the 
resulting git suite works because your msysgit developer may not have 
installed stuff in C:\msysgit\libexec\git-core, yet. What the patch does 
is exactly the same as if the compiled-in prefix that the warning 
mentions were used, which in the msysgit case on your machine happens to 
be C:\msysgit. Or am I missing something?

I think that the better solution is to remove the warning instead of 
introducing this special case suffix "git".

-- Hannes
