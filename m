From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] builtin-symbolic-ref: comment on the use of "resolve_ref"
 with reading == 0
Date: Sat, 6 Sep 2008 09:55:43 +0200
Message-ID: <20080906095543.c627b692.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:53:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbsbe-0001Tc-4n
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 09:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbYIFHwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 03:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbYIFHwI
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 03:52:08 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:52123 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093AbYIFHwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 03:52:08 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 5C73719739;
	Sat,  6 Sep 2008 09:52:05 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g19.free.fr (Postfix) with SMTP id E5D5919782;
	Sat,  6 Sep 2008 09:52:04 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95065>

The following thread:

http://thread.gmane.org/gmane.comp.version-control.git/42469

(the message ID from the first message is:

20070318020645.2444.75365.julian@quantumfyre.co.uk)

explains why "resolve_ref" is used with a "reading" parameter set to 0
instead of 1, but there was no comment saying that near the code.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-symbolic-ref.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

	This comment may save other people some time.

diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index bfc78bb..9490c47 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -12,6 +12,16 @@ static void check_symref(const char *HEAD, int quiet)
 {
 	unsigned char sha1[20];
 	int flag;
+
+	/*
+	 * It doesn't seem logical to use "resolve_ref" with reading == 0
+	 * as we are just checking if a ref exists, but some code depends
+	 * on the following to work:
+	 *
+	 *    $ git init-db
+	 *    $ git symbolic-ref HEAD
+	 *    refs/heads/master
+	 */
 	const char *refs_heads_master = resolve_ref(HEAD, sha1, 0, &flag);
 
 	if (!refs_heads_master)
-- 
1.6.0.1.338.g5e95.dirty
