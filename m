From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Document the textconv filter.
Date: Sun, 28 Sep 2008 04:06:57 +0200
Message-ID: <1222567618-22156-5-git-send-email-Matthieu.Moy@imag.fr>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr>
 <1222567618-22156-2-git-send-email-Matthieu.Moy@imag.fr>
 <1222567618-22156-3-git-send-email-Matthieu.Moy@imag.fr>
 <1222567618-22156-4-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 04:11:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjlkM-0004Jm-Rf
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 04:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbYI1CJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 22:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbYI1CJo
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 22:09:44 -0400
Received: from imag.imag.fr ([129.88.30.1]:60051 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbYI1CJm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 22:09:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m8S26xJT026010
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 28 Sep 2008 04:06:59 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KjlgY-0001de-8Q; Sun, 28 Sep 2008 04:06:58 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KjlgY-00060R-5u; Sun, 28 Sep 2008 04:06:58 +0200
X-Mailer: git-send-email 1.6.0.2.312.g1ef81a
In-Reply-To: <1222567618-22156-4-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 28 Sep 2008 04:06:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96936>

---
 Documentation/gitattributes.txt |   43 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e848c94..c4f2b8f 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -325,6 +325,49 @@ patterns are available:
 
 - `tex` suitable for source code for LaTeX documents.
 
+Converting files to text before a diff
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The attribute `textconv` affects 'git diff' in a way similar to the
+`diff` attribute, but with `textconv`, the user provides only a way to
+convert the file into text, and git takes care of doing the diff as
+usual (i.e. other options of 'git diff' such as '--color' remain
+available).
+
+The value of `textconv` must be a string, which is the textconv
+driver.
+
+To tell git to use the `exif` filter for jpeg images, use:
+
+----------------------------------------------------------------
+*.jpg   textconv=exif
+----------------------------------------------------------------
+
+Defining a custom textconv driver
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The definition of the `textconv` driver is done in `gitconfig`. To
+define a driver `exif`, add this to your `$GIT_DIR/config` file (or
+`$HOME/.gitconfig` file):
+
+----------------------------------------------------------------
+[textconv "exif"]
+	command = exiftags
+----------------------------------------------------------------
+
+Git will call the command specified in `command` with the file to
+convert as only argument. The program should write the text on its
+standard output.
+
+Examples of useful filters include:
+
+----------------------------------------------------------------
+[textconv "odt2txt"]
+	command = odt2txt
+[textconv "word"]
+	command = catdoc
+----------------------------------------------------------------
+
 
 Performing a three-way merge
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
1.6.0.2.312.g1ef81a
