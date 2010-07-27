From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/4] Allow detached forms (--option arg) for git log and friends
Date: Tue, 27 Jul 2010 23:21:55 +0200
Message-ID: <1280265719-30968-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 27 23:31:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdrkL-0006CN-2X
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637Ab0G0Vb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 17:31:28 -0400
Received: from imag.imag.fr ([129.88.30.1]:50281 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388Ab0G0Vb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:31:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o6RLM2iB003213
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Jul 2010 23:22:02 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Odrb8-00025e-08; Tue, 27 Jul 2010 23:22:02 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Odrb7-00084j-VF; Tue, 27 Jul 2010 23:22:01 +0200
X-Mailer: git-send-email 1.7.2.25.g9ebe3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 27 Jul 2010 23:22:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152005>

After discssion on the early RFC, I decided that a migration to
parse-option would be too much work given my git time budget and the
expected benefits. I'm accomplishing the same goal with very simple
macros, and one can now do e.g.

  git log -S foo
  git log --grep bar

Options with optional arguments do not accept this form.

To ease review, I'm splitting the serie into 4 batches of applications
of the same pattern.

Matthieu Moy (4):
  Allow detached form (e.g. "-S foo" instead of "-Sfoo") for diff
    options
  Allow detached form for git diff --stat-name-width and --stat-width.
  Allow detached form (e.g. "git log --grep foo") in log options.
  Allow detached form for --glob, --branches, --tags and --remote.

 diff.c                       |   75 +++++++++++++++++++++------
 diff.h                       |   15 +++++
 revision.c                   |  117 +++++++++++++++++++++++++++---------------
 t/t4013-diff-various.sh      |    1 +
 t/t4013/diff.log_-S_F_master |    7 +++
 t/t4202-log.sh               |   12 ++++
 t/t6018-rev-list-glob.sh     |    6 ++
 7 files changed, 176 insertions(+), 57 deletions(-)
 create mode 100644 t/t4013/diff.log_-S_F_master

-- 
1.7.2.25.g9ebe3
