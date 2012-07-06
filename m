From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 00/12] git-remote-mediawiki: tests and optimizations
Date: Fri,  6 Jul 2012 12:03:03 +0200
Message-ID: <1341568995-12467-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqhatl9t4a.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 06 12:03:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn5Nt-0005UF-HM
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 12:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108Ab2GFKD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 06:03:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60760 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab2GFKD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 06:03:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q66A2AeM007958
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Jul 2012 12:02:10 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sn5Nk-0003Q3-49; Fri, 06 Jul 2012 12:03:24 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sn5Nj-0003H3-VA; Fri, 06 Jul 2012 12:03:23 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
In-Reply-To: <vpqhatl9t4a.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 06 Jul 2012 12:02:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q66A2AeM007958
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342173730.93245@Wziua5SLFC7ld41lCfiFRw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201095>

This should fix the whitespaces issues reported by Junio.

This is now based on 6df7e0d (git-remote-mediawiki: improve support
for non-English Wikis), in pu.

Guillaume Sasdy (4):
  git-remote-mediawiki: scripts to install, delete and clear a
    MediaWiki
  git-remote-mediawiki: test environment of git-remote-mediawiki
  git-remote-mediawiki (t9360): test git-remote-mediawiki clone
  git-remote-mediawiki (t9361): test git-remote-mediawiki pull and push

Matthieu Moy (6):
  git-remote-mediawiki: support for uploading file in test environment
  git-remote-mediawiki: change return type of get_mw_pages
  git-remote-mediawiki: refactor loop over revision ids
  git-remote-mediawiki: extract revision-importing loop to a function
  git-remote-mediawiki: more efficient 'pull' in the best case
  git-remote-mediawiki: be more defensive when requests fail

NGUYEN Kim Thuat (1):
  git-remote-mediawiki (t9363): test 'File:' import and export

Simon Cathebras (1):
  git-remote-mediawiki (t9362): test git-remote-mediawiki with UTF8
    characters

 contrib/mw-to-git/Makefile                         |  47 +++
 contrib/mw-to-git/git-remote-mediawiki             | 149 +++++--
 contrib/mw-to-git/t/.gitignore                     |   4 +
 contrib/mw-to-git/t/Makefile                       |  31 ++
 contrib/mw-to-git/t/README                         | 124 ++++++
 contrib/mw-to-git/t/install-wiki.sh                |  45 +++
 contrib/mw-to-git/t/install-wiki/.gitignore        |   1 +
 contrib/mw-to-git/t/install-wiki/LocalSettings.php | 129 ++++++
 contrib/mw-to-git/t/install-wiki/db_install.php    | 120 ++++++
 contrib/mw-to-git/t/push-pull-tests.sh             | 144 +++++++
 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh       | 257 ++++++++++++
 contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh   |  24 ++
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh        | 301 ++++++++++++++
 .../mw-to-git/t/t9363-mw-to-git-export-import.sh   | 198 ++++++++++
 contrib/mw-to-git/t/t9364-pull-by-rev.sh           |  17 +
 contrib/mw-to-git/t/test-gitmw-lib.sh              | 435 +++++++++++++++++++++
 contrib/mw-to-git/t/test-gitmw.pl                  | 225 +++++++++++
 contrib/mw-to-git/t/test.config                    |  35 ++
 18 files changed, 2260 insertions(+), 26 deletions(-)
 create mode 100644 contrib/mw-to-git/Makefile
 create mode 100644 contrib/mw-to-git/t/.gitignore
 create mode 100644 contrib/mw-to-git/t/Makefile
 create mode 100644 contrib/mw-to-git/t/README
 create mode 100755 contrib/mw-to-git/t/install-wiki.sh
 create mode 100644 contrib/mw-to-git/t/install-wiki/.gitignore
 create mode 100644 contrib/mw-to-git/t/install-wiki/LocalSettings.php
 create mode 100644 contrib/mw-to-git/t/install-wiki/db_install.php
 create mode 100644 contrib/mw-to-git/t/push-pull-tests.sh
 create mode 100755 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
 create mode 100755 contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh
 create mode 100755 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
 create mode 100755 contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
 create mode 100755 contrib/mw-to-git/t/t9364-pull-by-rev.sh
 create mode 100755 contrib/mw-to-git/t/test-gitmw-lib.sh
 create mode 100755 contrib/mw-to-git/t/test-gitmw.pl
 create mode 100644 contrib/mw-to-git/t/test.config

-- 
1.7.11.1.147.g47a574d
