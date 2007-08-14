From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 1/2] Introduces xmkstemp()
Date: Tue, 14 Aug 2007 16:44:53 -0300
Organization: Mandriva
Message-ID: <20070814164453.400b9c55@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 21:45:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL2Kd-0002Cj-ID
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 21:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062AbXHNTpP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 15:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753102AbXHNTpO
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 15:45:14 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:53496 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbXHNTpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 15:45:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 8F8781AB57;
	Tue, 14 Aug 2007 16:45:09 -0300 (BRT)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 2YyGq1Lp16kO; Tue, 14 Aug 2007 16:45:03 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 65A571AB4D;
	Tue, 14 Aug 2007 16:44:54 -0300 (BRT)
X-Mailer: Claws Mail 2.10.0 (GTK+ 2.11.6; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55851>


This is a wrapper for mkstemp() that performs error checking and
calls die() when an error occur.

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
---
 git-compat-util.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 362e040..ca0a597 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -303,6 +303,16 @@ static inline FILE *xfdopen(int fd, const char *mode)
 	return stream;
 }
 
+static inline int xmkstemp(char *template)
+{
+	int fd;
+
+	fd = mkstemp(template);
+	if (fd < 0)
+		die("Unable to create temporary file: %s", strerror(errno));
+	return fd;
+}
+
 static inline size_t xsize_t(off_t len)
 {
 	return (size_t)len;
-- 
1.5.3.GIT



-- 
Luiz Fernando N. Capitulino
