From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: cogito-0.10 broken for cg-commit < logmessagefile
Date: Wed, 08 Jun 2005 17:28:22 +0100
Message-ID: <tnxhdg8g6e1.fsf@arm.com>
References: <20050608144632.A28042@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-From: git-owner@vger.kernel.org Wed Jun 08 18:30:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg3Pk-0004Ms-5F
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 18:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVFHQbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 12:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVFHQan
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 12:30:43 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:37095 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261396AbVFHQ2h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2005 12:28:37 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j58GSGjd022956
	for <git@vger.kernel.org>; Wed, 8 Jun 2005 17:28:16 +0100 (BST)
Received: from localhost.localdomain (cmarinas@pc1117.cambridge.arm.com [10.1.69.144])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id RAA25490
	for <git@vger.kernel.org>; Wed, 8 Jun 2005 17:28:34 +0100 (BST)
To: git@vger.kernel.org
In-Reply-To: <20050608144632.A28042@flint.arm.linux.org.uk> (Russell King's
 message of "Wed, 8 Jun 2005 14:46:32 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--=-=-=

Russell King <rmk@arm.linux.org.uk> wrote:
> The command in the subject prepends the log message with a blank line.
> This ain't good because it messes up commit messages as per Linus'
> requirements (the first line must be a summary.)

The patch below should fix the problem. There is no point in writing
the status information in a file which is read from stdin.

-- 
Catalin


--=-=-=
Content-Disposition: inline; filename=cogito-stdin.diff

Fix the log file when read from stdin

Log messages read from stdin shouldn't have additional lines.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -215,7 +215,7 @@ if tty -s; then
 		fi
 	fi
 else
-	cat >>$LOGMSG2
+	cat >$LOGMSG2
 fi
 # Remove heading and trailing blank lines.
 grep -v ^CG: $LOGMSG2 | git-stripspace >$LOGMSG

--=-=-=--

