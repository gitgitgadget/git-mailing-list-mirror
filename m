From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 05/23] http-push: fix missing "#ifdef USE_CURL_MULTI" around
 "is_running_queue"
Date: Sat, 6 Jun 2009 16:43:31 +0800
Message-ID: <20090606164331.1aa6bdf6.rctay89@gmail.com>
References: <cover.1244277116.git.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:49:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCraL-0003k7-Hj
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbZFFIs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754032AbZFFIs5
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:48:57 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:29204 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972AbZFFIs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 04:48:56 -0400
Received: by wf-out-1314.google.com with SMTP id 26so882191wfd.4
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=CKaXDGhX7Tzs33lVbYZk+s4E0ljd2Y1XR9rkV5vHYq0=;
        b=P7BoTCzDucl6oxVkhbAEdlOr3fHwBJLtJmDcDRoKG6l3YAPgrgZh4WMv+q936SXOBR
         4JvGpLhdKr5Vn6Y7kjDYfjhcL/xThHGG2qPLgqz5Fc2WJSZh+xyI+7Pl8YdISzwGRni6
         Ip5+udQu/4NGuRbm3aaHt/GWqVa50YSToTNfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=p7v1GPPaaSprcl4wMn1pOBrFQG1qHwcQjOBh6BQR4APSQS7CX7zxEqCI0o90KjaJhB
         MC/JDHtJECqxeFAhuSCnQSqFsb0WKF+W4+NMz1QTaMdGdpAVLJhfXqhXeXFPEbT5uwBM
         BYhXz8fhW2NinjGq+vqPiQnGB+8SCG+OcNqBo=
Received: by 10.142.116.12 with SMTP id o12mr1490425wfc.332.1244278138715;
        Sat, 06 Jun 2009 01:48:58 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 32sm2781647wfc.34.2009.06.06.01.48.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 01:48:58 -0700 (PDT)
In-Reply-To: <cover.1244277116.git.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120886>

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
