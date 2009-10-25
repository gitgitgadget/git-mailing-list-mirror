From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/7] http-push: fix check condition on
 http.c::finish_http_pack_request()
Date: Sun, 25 Oct 2009 23:18:09 +0800
Message-ID: <20091025231809.15b470fa.rctay89@gmail.com>
References: <20091025231651.18c75559.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 16:20:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N24su-0000zx-Nw
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 16:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbZJYPSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 11:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbZJYPSN
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 11:18:13 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:65142 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbZJYPSK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 11:18:10 -0400
Received: by yxe17 with SMTP id 17so9151462yxe.33
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 08:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=3iZT43scmqohfu6mu7+rH69z6DLEO5IObf6MLGaBaU0=;
        b=S1vHBrc5aDMEO2YwzQc+ikfq/KpkDr10mnThCebWPv+sIeMH0p1ZHolfov6gQHtio4
         44uuXEbT3Cum8d9zAc5Tlh6WK1BEHdxZy81pdPL+Umm4ltRrFBoqcY+ER0vSDwNCCQel
         u0B3AsN4VONvT2VOfH0POYNB2CVnvRzZdSB88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=sptfrSCLJgW6X3E7YMMBad5n2YPoryXSjuOcyW4wbsmFrZg2dvUnlKwHPS3oz2+F3k
         35JBbi8bQ/nz2BbHfvQ+8oi2Pk5yA3hNNgGSsUPiZvzm9rlon98U96EF1oxyFIcCvbUg
         0Xc2fvrJk1u2JAqG+/6g62+F1ycpbRldTbWxI=
Received: by 10.151.2.5 with SMTP id e5mr21942676ybi.114.1256483895032;
        Sun, 25 Oct 2009 08:18:15 -0700 (PDT)
Received: from your-cukc5e3z5n (cm73.zeta152.maxonline.com.sg [116.87.152.73])
        by mx.google.com with ESMTPS id 22sm881307ywh.30.2009.10.25.08.18.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:18:14 -0700 (PDT)
In-Reply-To: <20091025231651.18c75559.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131209>

Check that http.c::finish_http_pack_request() returns 0 (for success).

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index 9010ccc..24eec73 100644
--- a/http-push.c
+++ b/http-push.c
@@ -605,7 +605,7 @@ static void finish_request(struct transfer_request *request)
 			preq = (struct http_pack_request *)request->userData;

 			if (preq) {
-				if (finish_http_pack_request(preq) > 0)
+				if (finish_http_pack_request(preq) == 0)
 					fail = 0;
 				release_http_pack_request(preq);
 			}
--
1.6.4.4
