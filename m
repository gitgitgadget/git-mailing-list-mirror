From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH 1/2]  Add p4 read_pipe and write_pipe wrappers
Date: Thu, 14 Aug 2008 23:40:38 +0100
Message-ID: <1218753639-32716-1-git-send-email-wildfire@progsoc.org>
References: <g829vo@ger.gmane.org>
Cc: simon@lst.de, torarvid@gmail.com,
	Anand Kumria <wildfire@progsoc.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 01:03:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTlqR-0005FO-9c
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 01:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbYHNXB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 19:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbYHNXB7
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 19:01:59 -0400
Received: from 133.105.233.220.exetel.com.au ([220.233.105.133]:46065 "EHLO
	giskard.kumria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbYHNXB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 19:01:58 -0400
Received: from caliban.kumria.com ([203.7.227.146] helo=eve.kumria.com)
	by giskard.kumria.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <wildfire@progsoc.uts.edu.au>)
	id 1KTlXj-00045I-4e; Fri, 15 Aug 2008 08:43:45 +1000
Received: from anand by eve.kumria.com with local (Exim 4.69)
	(envelope-from <wildfire@progsoc.uts.edu.au>)
	id 1KTlUl-0008W2-Af; Thu, 14 Aug 2008 23:40:39 +0100
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <g829vo@ger.gmane.org>
In-Reply-To: <g829vo@ger.gmane.org>
References: <g829vo@ger.gmane.org>
X-Spam-Score: -2.3
X-Spam-Score-Int: -22
X-Spam-Bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92434>

 Two additional wrappers to cover 3 places where we utilise p4
 in piped form. Found by Tor Arvid Lund.

Signed-off-by: Anand Kumria <wildfire@progsoc.org>
---
 contrib/fast-import/git-p4 |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 6c64224..3e9df70 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -69,6 +69,10 @@ def write_pipe(c, str):
 
     return val
 
+def p4_write_pipe(c, str):
+    real_cmd = p4_build_cmd(c)
+    return write_pipe(c, str)
+
 def read_pipe(c, ignore_error=False):
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % c)
@@ -80,6 +84,9 @@ def read_pipe(c, ignore_error=False):
 
     return val
 
+def p4_read_pipe(c, ignore_error=False):
+    real_cmd = p4_build_cmd(c)
+    return read_pipe(real_cmd, ignore_error)
 
 def read_pipe_lines(c):
     if verbose:
-- 
1.5.6.3
