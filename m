From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2] Mingw: verify both ends of the pipe () call
Date: Fri, 28 Aug 2015 09:43:37 +0000
Message-ID: <0000014f73b0e4ef-12b105a6-5f9c-4131-956f-97a1bd85e072-000000@eu-west-1.amazonses.com>
References: <0000014f6fdf5839-19f5bc24-80bf-4b9e-a26b-2ef089a28f06-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 11:51:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVGJt-0002Wl-3d
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 11:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbbH1Jvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 05:51:33 -0400
Received: from a6-245.smtp-out.eu-west-1.amazonses.com ([54.240.6.245]:58384
	"EHLO a6-245.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751505AbbH1Jvc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Aug 2015 05:51:32 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Aug 2015 05:51:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1440755017;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=UG0XPY0bg8NrrqGOnK44Cea3MiAk6ESTUXLToXETY+M=;
	b=lYRiARnUezuXNzFaeLAgmFaLrh2CfdEUMBQVg+UJkBzENqNmi3GzPZlu+FJLTgeN
	d5hfcRqdAj5osYDgRIxc08Swb1X8lLFej0ANMMRviqzLL56Vw0EcfaETaEo8SOGVij4
	4o2jglJKRnFsYASWD4HrUJy1jk0RyLxqGUukwxKs=
In-Reply-To: <0000014f6fdf5839-19f5bc24-80bf-4b9e-a26b-2ef089a28f06-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2015.08.28-54.240.6.245
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276712>

From: Jose F. Morales <jfmcjf@gmail.com>

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
