From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/5 v3] log and diff: accept detached forms (--option value)
Date: Thu, 29 Jul 2010 10:20:24 +0200
Message-ID: <1280391629-30017-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 29 10:21:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeOMy-0004hy-6C
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 10:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab0G2IVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 04:21:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57831 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754391Ab0G2IV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 04:21:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6T8IgjX022195
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Jul 2010 10:18:42 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OeOLu-0004Mt-Nl; Thu, 29 Jul 2010 10:20:30 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OeOLu-0004IA-KC; Thu, 29 Jul 2010 10:20:30 +0200
X-Mailer: git-send-email 1.7.2.21.ge9796
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 29 Jul 2010 10:18:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6T8IgjX022195
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1280996323.72515@rsJo9e+uGB4AcFBsLw8/Og
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152165>

Since last version :

* I had missed several optional arguments, for which detached form
  should not be allowed (otherwise, --option --other-option is
  ambiguous). In most cases, my changes were harmless since the code
  had already checked for the parameterless form before reaching mine,
  but that was definitely bad anyway.

* One missing "return optarg;" (that even Jonathan had missed ;-) )

* One more test for "git log -S" failure (no argument to -S)

* Refactoring by Jonathan Nieder for --stat-*

* Rewording of commit messages.

Jonathan Nieder (1):
  diff: split off a function for --stat-* option parsing

Matthieu Moy (4):
  diff: parse detached options like -S foo
  diff: parse detached options --stat-width n, --stat-name-width n
  log: parse detached options like git log --grep foo
  log: parse detached option for --glob

 diff.c                       |  167 +++++++++++++++++++++++++++++++-----------
 diff.h                       |    7 ++
 revision.c                   |   79 +++++++++++++-------
 t/t4013-diff-various.sh      |    5 +
 t/t4013/diff.log_-S_F_master |    7 ++
 t/t4202-log.sh               |   19 +++--
 t/t6018-rev-list-glob.sh     |    6 ++
 7 files changed, 211 insertions(+), 79 deletions(-)
 create mode 100644 t/t4013/diff.log_-S_F_master

-- 
1.7.2.21.ge9796
