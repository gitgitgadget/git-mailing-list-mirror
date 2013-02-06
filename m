From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/4] Allow contrib/ to use Git's Makefile for perl code
Date: Wed,  6 Feb 2013 19:11:28 +0100
Message-ID: <1360174292-14793-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqobfxwg2q.fsf@grenoble-inp.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 06 19:12:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U39UQ-0008Kw-Aj
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 19:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756925Ab3BFSMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 13:12:36 -0500
Received: from mx1.imag.fr ([129.88.30.5]:46787 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756774Ab3BFSMf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 13:12:35 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r16IBYC9007429
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Feb 2013 19:11:36 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U39T6-0005kM-2P; Wed, 06 Feb 2013 19:11:36 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U39T5-0003ra-Ty; Wed, 06 Feb 2013 19:11:35 +0100
X-Mailer: git-send-email 1.8.1.2.526.gf51a757
In-Reply-To: <vpqobfxwg2q.fsf@grenoble-inp.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 06 Feb 2013 19:11:37 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r16IBYC9007429
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1360779100.28634@fmL1Wxmp50kGU2dd+io6tg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215610>

The very final goal is to be able to move painlessly (credential) code
from git-remote-mediawiki to Git.pm, but then it's nice for the user
to be able to say just "cd contrib/mw-to-git && make install" and let
the Makefile set perl's library path just like other Git commands
written in perl.

This series does this while trying to minimize code duplication, and
to make it easy for future other tools in contrib to do the same.

Matthieu Moy (4):
  Makefile: extract perl-related rules to make them available from other
    dirs
  perl.mak: introduce $(GIT_ROOT_DIR) to allow inclusion from other
    directories
  Makefile: factor common configuration in git-default-config.mak
  git-remote-mediawiki: use Git's Makefile to build the script

 Makefile                                           | 108 +--------------------
 contrib/mw-to-git/.gitignore                       |   1 +
 contrib/mw-to-git/Makefile                         |  45 ++++++---
 ...-remote-mediawiki => git-remote-mediawiki.perl} |   0
 default-config.mak                                 |  61 ++++++++++++
 perl.mak                                           |  52 ++++++++++
 6 files changed, 145 insertions(+), 122 deletions(-)
 create mode 100644 contrib/mw-to-git/.gitignore
 rename contrib/mw-to-git/{git-remote-mediawiki => git-remote-mediawiki.perl} (100%)
 create mode 100644 default-config.mak
 create mode 100644 perl.mak

-- 
1.8.1.2.526.gf51a757
