From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 0/5] replacement for the part of js/more-win that is in
 pu
Date: Tue, 15 Jul 2008 09:59:48 +0200
Message-ID: <487C58F4.9050000@viscovery.net>
References: <1216025226.487b128a031fd@webmail.eunet.at> <1216071689-14823-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 10:00:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIfSv-0008IN-Rx
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 10:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbYGOH7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 03:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbYGOH7z
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 03:59:55 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:38832 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbYGOH7y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 03:59:54 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KIfRs-00070j-Ka; Tue, 15 Jul 2008 09:59:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 579D954D; Tue, 15 Jul 2008 09:59:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1216071689-14823-1-git-send-email-johannes.sixt@telecom.at>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88536>

Johannes Sixt schrieb:
> The interdiff to js/more-win is below. It is mostly the changes
> of 1/5.
> 
> Johannes Sixt (5):
>       Makefile: Normalize $(bindir) and $(gitexecdir) before comparing
>       Record the command invocation path early
>       Fix relative built-in paths to be relative to the command
>          invocation
>       Allow the built-in exec path to be relative to the command
>          invocation path
>       Allow add_path() to add non-existent directories to the path

I retract this series and also the earlier version (the part that is in pu).

If I had done due diligence, I could have found out earlier that it does
not solve the problem it tried to solve. Appologies for the noise. :-(

The series tries to derive the exec-path from argv[0] (if the built-in
path is relative). But if a command is invoked from CMD on Windows,
argv[0] doesn't have a path, there is only the program name, "git.exe". In
the past, we relied on the global variable _pgmptr (only Windows's C
runtime has this), which does contain the full path, and if we set

   gitexecdir = $(bindir)

in the Makefile, then we get a working git.exe, but we put back all
commands into $PATH.

-- Hannes
