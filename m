From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Possible timestamp problems with diff-files?
Date: Tue, 20 Sep 2011 12:30:53 +0200
Message-ID: <4E786B5D.40601@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 12:40:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5xkG-0003qz-RQ
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 12:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442Ab1ITKkC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 06:40:02 -0400
Received: from syntevo.com ([85.214.39.145]:36375 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814Ab1ITKkB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 06:40:01 -0400
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Sep 2011 06:40:00 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTPSA id 881F7E30018
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
X-Enigmail-Version: 1.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181750>

For our Git client, we are invoking

git diff-files--quiet --ignore-submodules

immediately after a commit of *all* changes. Hence, the expected exit
code would be 0 (because there are no changes). A user has now reported
that for commits with many changes, exit code is sometimes 1. For the
last incident, the commit was started at 15:24:11,820 and finished at
15:24:12,329, diff-files was invoked at 15:24:12,455 and failed with
exit code 1 at 15:24:21,394. A subsequent diff-files succeeded, so I'm
wondering now, if that could be a timestamp problem (maybe related to
the Index)?

Note that there are a couple of threads running in the client itself, so
I guess actual running time of diff-files was much shorter than 9
seconds and chances are that some parts of diff-files were run in the
same second 15:24:12.

System configuration is:
Linux splitter 2.6.38-11-server #48-Ubuntu SMP Fri Jul 29 19:20:32 UTC
2011 x86_64 x86_64 x86_64 GNU/Linux

git version 1.7.4.1

--
Best regards,
Marc Strapetz
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com
