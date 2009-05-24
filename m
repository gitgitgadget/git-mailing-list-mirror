From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 01/18] t5550-http-fetch: test fetching of packed objects
Date: Sun, 24 May 2009 22:19:38 +0800
Message-ID: <20090524221938.48d8b748.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 24 16:22:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Eaj-0005ol-Fp
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 16:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbZEXOVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 10:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbZEXOVZ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 10:21:25 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:48930 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbZEXOVY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 10:21:24 -0400
Received: by mail-px0-f103.google.com with SMTP id 1so2153790pxi.33
        for <git@vger.kernel.org>; Sun, 24 May 2009 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=h+xQ7yjK8rqqXOQDqfcHISCXZzyqq4ElmczYQxNNqKA=;
        b=INTzq3WuPPGMuzVVJ8vJdRUQapzdjOMcQCvAGRgztAjPKFy+D7Kzm2UY3BtULgPg+0
         8BduAFJRmz+Z1fg5nn+RQE1o97AltXqCYHFif+sFaemaDEj49YM4aRXG7qm0QC7aU1Mm
         NwPtVqhvxUtKRL1fVXA3C2vYvQgOzwiBA2pyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=ni5pf0yc/dm83b5Ro8vX2cUMh7fs4jU35LQb/LtV3/JF+TM08TGc0OVeWllWAN3fhP
         gTgVhfAy9z6LSXrvDfzS/gtp5TAim52Wy9kdHWef4OO1QeBs+Bq2VALE6mXx3E22vKog
         LCQV4dLs2vexN9rNSd5oR9m+Rg8jc2UU1gtJU=
Received: by 10.114.37.1 with SMTP id k1mr12263468wak.172.1243174884548;
        Sun, 24 May 2009 07:21:24 -0700 (PDT)
Received: from your-cukc5e3z5n (cm10.zeta148.maxonline.com.sg [116.87.148.10])
        by mx.google.com with ESMTPS id l30sm12234864waf.0.2009.05.24.07.21.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 07:21:23 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119825>


Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5550-http-fetch.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 05b1b62..0e69324 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -53,5 +53,13 @@ test_expect_success 'http remote detects correct HEAD' '
 	)
 '

+test_expect_success 'fetch packed objects' '
+	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo.git "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
+	cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
+	git --bare repack &&
+	git --bare prune-packed &&
+	git clone $HTTPD_URL/repo_pack.git
+'
+
 stop_httpd
 test_done
--
1.6.3.1
