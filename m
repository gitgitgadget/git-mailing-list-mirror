From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Mingw: verify both ends of the pipe () call
Date: Thu, 27 Aug 2015 15:55:52 +0000
Message-ID: <0000014f6fdf5839-19f5bc24-80bf-4b9e-a26b-2ef089a28f06-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 18:07:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUziH-0004gs-I6
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 18:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbbH0QHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 12:07:37 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:56737
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751694AbbH0QHh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2015 12:07:37 -0400
X-Greylist: delayed 702 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Aug 2015 12:07:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1440690952;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=oDyK08eegyFy3FfKEz/xWryCContN1OyZrGdl6QDHbI=;
	b=Q/lQKFJH3EAUZvbHhcDfVcgkNHIL8WKEcWjSYzHJPCTsGOuD1A5Z7KeHSukWlzdB
	Ew5gMtxn1Aqv9v64b22J5cQwfUWin6wvkrEGFoF2GVFwj3d0IvO+ZEsLg8OwJanVgnA
	xxNEDbaD+Ot4pNcRjbTYWuIwNxK492c3Ta4Zlan0=
X-SES-Outgoing: 2015.08.27-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276681>

From: jfmc <jfmcjf@gmail.com>

The code to open and test the second end of the pipe clearly imitates
the code for the first end. A little too closely, though... Let's fix
the obvious copy-edit bug.

Signed-off-by: Jose F. Morales <jfmcjf@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 496e6f8..f74da23 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -681,7 +681,7 @@ int pipe(int filedes[2])
 		return -1;
 	}
 	filedes[1] = _open_osfhandle((int)h[1], O_NOINHERIT);
-	if (filedes[0] < 0) {
+	if (filedes[1] < 0) {
 		close(filedes[0]);
 		CloseHandle(h[1]);
 		return -1;

--
https://github.com/git/git/pull/168
