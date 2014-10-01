From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 21/38] dump_marks(): remove a redundant call to rollback_lock_file()
Date: Wed,  1 Oct 2014 12:28:25 +0200
Message-ID: <1412159322-2622-22-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHA7-0002ef-VR
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbaJAK33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:29 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53417 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751636AbaJAK30 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:26 -0400
X-AuditID: 12074411-f79d86d000006a97-18-542bd785d5e8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id F0.AE.27287.587DB245; Wed,  1 Oct 2014 06:29:25 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6K026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:24 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1G29rh1i8PONpkXXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3BlzXsxiLJjOVvHy5VGWBsZ21i5G
	Tg4JAROJpddPMELYYhIX7q1n62Lk4hASuMwo0XxtHTOEc5xJ4sCOHWAdbAK6Eot6mplAbBEB
	NYmJbYdYQIqYBRYzSUw4tIkNJCEsEC4xZfpCsCIWAVWJpS+ngNm8Ai4STUuWQ62Wk9iw+z/Y
	ak6g+PLLzSwgtpCAs8SOO1+ZJjDyLmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6qXm1mi
	l5pSuokREo6COxhnnJQ7xCjAwajEw6uQoB0ixJpYVlyZe4hRkoNJSZR30SWgEF9SfkplRmJx
	RnxRaU5q8SFGCQ5mJRHe7ANAOd6UxMqq1KJ8mJQ0B4uSOC/fEnU/IYH0xJLU7NTUgtQimKwM
	B4eSBC/DNaBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFB0xBcD4wMkxQO01xmk
	nbe4IDEXKArReorRmKOl6W0vE8e6zm/9TEIsefl5qVLivJkgpQIgpRmleXCLYInoFaM40N/C
	vOEgVTzAJAY37xXQKiagVclrwFaVJCKkpBoYF51W97bccyjj3ZvCww09l3J9T5R8+Shs2azJ
	w7hk8o0Ly7S2XfAtT5r8zGLHkuaKCz9S+xxfSKisz9u9Tj/wnsipjSt5+V97/Uzz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257709>

When commit_lock_file() fails, it now always calls
rollback_lock_file() internally, so there is no need to call that
function here.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 96b0f42..783c684 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1832,10 +1832,8 @@ static void dump_marks(void)
 	}
 
 	if (commit_lock_file(&mark_lock)) {
-		int saved_errno = errno;
-		rollback_lock_file(&mark_lock);
 		failure |= error("Unable to commit marks file %s: %s",
-			export_marks_file, strerror(saved_errno));
+			export_marks_file, strerror(errno));
 		return;
 	}
 }
-- 
2.1.0
