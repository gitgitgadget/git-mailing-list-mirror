From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 05/23] http-push: fix missing "#ifdef USE_CURL_MULTI" around
 "is_running_queue"
Date: Sat, 6 Jun 2009 00:04:38 +0800
Message-ID: <20090606000438.298aeddb.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbzB-00053w-EQ
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944AbZFEQIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754781AbZFEQIZ
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:08:25 -0400
Received: from mail-px0-f202.google.com ([209.85.216.202]:50429 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570AbZFEQIY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:08:24 -0400
Received: by pxi40 with SMTP id 40so80522pxi.33
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=CKaXDGhX7Tzs33lVbYZk+s4E0ljd2Y1XR9rkV5vHYq0=;
        b=OWhPZD2kF4OnPyo/juFibWe+2cPp1FaQ6+gira0DnIcn1fgQqc/+xlbc0PG2n1EX+Y
         mMbzoQicP3dHCZYj22BD36syjdxsJ+Hy0PaCali020sAhFyqYQn5yv7Wr1mihXLuSDjO
         Swf8xPVo9/UOAfDPI/gCngRKZcmmCwTiuqlCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=KWjbRpfTYndoaPCATY6bg4As3616WWNmXPzsNPvCiLVqzYsVxifwp/8yoAJAY/XK3t
         hnWO5TVSUg+eiFg5cLMMeET7B/lI7LSlH8N8ct68QYTq4Fmc2FDMC4mwP5DQyOEYyuWY
         iaHrQ2bOHKAFX6JP7VfzquR7ve3DRWnfMgHmE=
Received: by 10.142.113.17 with SMTP id l17mr1217782wfc.299.1244218105968;
        Fri, 05 Jun 2009 09:08:25 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 22sm417558wfd.39.2009.06.05.09.08.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:08:25 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120785>

As it is breaking the build when USE_CURL_MULTI is not defined.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index 218e263..1d84f3b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2298,7 +2298,9 @@ int main(int argc, char **argv)
 		repo->url = rewritten_url;
 	}

+#ifdef USE_CURL_MULTI
 	is_running_queue = 0;
+#endif

 	/* Verify DAV compliance/lock support */
 	if (!locking_available()) {
--
1.6.3.1
