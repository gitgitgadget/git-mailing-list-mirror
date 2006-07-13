From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 3/5] upload-pack: ignore write errors to stderr
Date: Thu, 13 Jul 2006 13:07:59 +0200
Message-ID: <E1G0znB-0002IT-77@moooo.ath.cx>
References: <E1G0zj7-0001c1-8q@moooo.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jul 13 13:55:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0znJ-0007Iu-L3
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 13:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWGMLzr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 07:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWGMLzq
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 07:55:46 -0400
Received: from moooo.ath.cx ([85.116.203.178]:15833 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932509AbWGMLzn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 07:55:43 -0400
To: git@vger.kernel.org
In-Reply-To: <E1G0zj7-0001c1-8q@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23831>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 upload-pack.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index b18eb9b..94aa0da 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -51,6 +51,10 @@ static ssize_t send_client_data(int fd, 
 		if (fd == 3)
 			/* emergency quit */
 			fd = 2;
+		if (fd == 2) {
+			xwrite(fd, data, sz);
+			return sz;
+		}
 		return safe_write(fd, data, sz);
 	}
 	p = data;
-- 
1.4.1.gb16f
