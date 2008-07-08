From: Robert Shearman <robertshearman@gmail.com>
Subject: [PATCH 1/4] git-imap-send: Allow the program to be run from subdirectories of a git tree.
Date: Tue,  8 Jul 2008 23:18:13 +0100
Message-ID: <1215555496-21335-1-git-send-email-robertshearman@gmail.com>
Cc: Robert Shearman <robertshearman@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 00:19:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGLWy-0000Y0-NI
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 00:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbYGHWSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 18:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753608AbYGHWSa
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 18:18:30 -0400
Received: from gv-out-0910.google.com ([216.239.58.190]:10588 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbYGHWS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 18:18:29 -0400
Received: by gv-out-0910.google.com with SMTP id e6so474282gvc.37
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 15:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=eEQ5NZemkvtN+UcWb38H5jg2LRYMO3UorBBWII6RMzE=;
        b=kjIAZI+tRP+2AXYjXatRTj8jO8jeb3H2sFa9ZZC+3JoFNVM0CoOhTqSn3shZf8Z7Sv
         mmsDl/Z9YwSgvTiXS1V4OQPqlmZfoPXSsrJMdGmYbG6U8eoI7XKHcP1MKdXqdHZyxMC8
         voFApbhM8n1dEAWAARg2li9edrkiRZUcpd2T8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=I1kw8xXTFu8yHE+HxyCZ7p1wTFlUFei4+hFx8OwLcC9J9LwyqlbmdCz5DUT9ugS11u
         fYm0xNqa1Zj6KcrHVp36xosd4UfZIwwIiJ5nOYlUO/qBtGMr+noNjZDwBOTmpqURB1aA
         islNRtwJPeJl9LMoUadpF7v+Rbl5aU5PkroHI=
Received: by 10.125.113.7 with SMTP id q7mr1615747mkm.129.1215555507630;
        Tue, 08 Jul 2008 15:18:27 -0700 (PDT)
Received: from localhost.localdomain ( [86.155.123.155])
        by mx.google.com with ESMTPS id p9sm12934768fkb.5.2008.07.08.15.18.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jul 2008 15:18:26 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.2.224.g26efb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87801>

Call setup_git_directory_gently to allow git-imap-send to be used from subdirectories of a git tree.
---
 imap-send.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 1ec1310..89a1532 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1296,6 +1296,7 @@ main(int argc, char **argv)
 	/* init the random number generator */
 	arc4_init();
 
+	setup_git_directory_gently( NULL );
 	git_config(git_imap_config, NULL);
 
 	if (!imap_folder) {
-- 
1.5.6.GIT
