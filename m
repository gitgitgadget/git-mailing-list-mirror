From: Johannes Sixt <j6t@kdbg.org>
Subject: run_hook: why special check for uncaught signal?
Date: Tue, 30 Jun 2009 22:31:45 +0200
Message-ID: <200906302231.45157.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jun 30 22:32:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLjzr-0007zr-D9
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755635AbZF3Ubt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 16:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754492AbZF3Ubt
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 16:31:49 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:62175 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756656AbZF3Ubs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 16:31:48 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A461DCDF8D;
	Tue, 30 Jun 2009 22:31:46 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id A2F694279F;
	Tue, 30 Jun 2009 22:31:45 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122539>

Function run_hook (in run-command.c) has this check:

	ret = finish_command(&hook);
	if (ret == -ERR_RUN_COMMAND_WAITPID_SIGNAL)
		warning("%s exited due to uncaught signal", argv[0]);
	return ret;

The lines were moved to this location by ae98a008 (Move run_hook() from 
builtin-commit.c into run-command.c (libgit), 2009-01-16). Before this 
commit, the check existed in builtin-gc.c. It was introduced by bde30540 
(git-gc --auto: add pre-auto-gc hook, 2008-04-09).

Why is this check necessary?

I'm asking because I'm working on a modification that would remove 
ERR_RUN_COMMAND_WAITPID_SIGNAL.

-- Hannes
