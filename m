From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: (unknown)
Date: Fri, 10 Feb 2012 00:58:37 +0100
Message-ID: <1328831921-27272-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 01:25:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RveIP-0004jJ-1x
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 01:25:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758521Ab2BJAYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 19:24:51 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52320 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767Ab2BJAYr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 19:24:47 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RvdtF-0001gR-V6; Fri, 10 Feb 2012 00:59:03 +0100
Subject: 
X-Mailer: git-send-email 1.7.9.rc2.127.gcb239
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190353>

Hi,

this is a patch series to make 'git diff --stat' use full terminal
width instead of hard-coded 80 columns.

This is quite useful when working on projects with nested directory
structure, e.g. Java:
 .../{ => workspace/tasks}/GetTaskResultAction.java |   10 +-
 .../tasks}/RemoveAllAbortedTasksAction.java        |    7 +-
 .../tasks}/RemoveAllFailedTasksAction.java         |    7 +-
is changed to display full paths if the terminal window is wide
enough.

Git usually uses the full terminal width automatically, so it should
do so with --stat too.

The "big" functional change in the patch series is s/80/term_columns()/
in show_stats(). The fourth patch also changes the partitioning of
available columns to dedicate more space to file names.
