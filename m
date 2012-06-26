From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/5] git-remote-mediawiki: don't "use encoding 'utf8';"
Date: Tue, 26 Jun 2012 18:04:30 +0200
Message-ID: <1340726673-25496-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1340726673-25496-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Pavel.Volek@ensimag.imag.fr, Kim-Thuat.Nguyen@ensimag.imag.fr,
	roucherj@ensimag.imag.fr, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 26 18:05:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjYGU-0006S9-RJ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 18:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758616Ab2FZQFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 12:05:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47097 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758527Ab2FZQFL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 12:05:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5QG4SmC013694
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 26 Jun 2012 18:04:28 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SjYGG-0008KZ-OT; Tue, 26 Jun 2012 18:05:04 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SjYGG-0006eY-NK; Tue, 26 Jun 2012 18:05:04 +0200
X-Mailer: git-send-email 1.7.11.5.g0c7e058.dirty
In-Reply-To: <1340726673-25496-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 26 Jun 2012 18:04:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5QG4SmC013694
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1341331470.47143@iYQsR//jMko9b3nq64uOig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200654>

The use of this statement is generally discouraged, and is too intrusive
for us: it forces the HTTP requests made by the API to contain only valid
UTF-8 characters. This would break the upload of binary files.
---
 contrib/mw-to-git/git-remote-mediawiki | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index a8e6287..ed06ff7 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -36,11 +36,10 @@
 use strict;
 use MediaWiki::API;
 use DateTime::Format::ISO8601;
-use encoding 'utf8';
 
-# use encoding 'utf8' doesn't change STDERROR
-# but we're going to output UTF-8 filenames to STDERR
+# By default, use UTF-8 to communicate with Git and the user
 binmode STDERR, ":utf8";
+binmode STDOUT, ":utf8";
 
 use URI::Escape;
 use IPC::Open2;
-- 
1.7.11.5.g0c7e058.dirty
