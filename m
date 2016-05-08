From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 21/41] credential-cache--daemon.c: use warning_errno()
Date: Sun,  8 May 2016 16:47:41 +0700
Message-ID: <1462700881-25108-22-git-send-email-pclouds@gmail.com>
References: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
 <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 11:52:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLMK-0001R9-M3
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbcEHJul convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:50:41 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36349 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbcEHJuk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:50:40 -0400
Received: by mail-pf0-f194.google.com with SMTP id p185so16154085pfb.3
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8KpiPtnYMV+UpotVKa/Dy5aIZrExOkIAmVS6xXS605w=;
        b=iBuKl2UiUgeCmCOzvStUP6xhMWVMmKHaqkdewOF5JFEzSuQDaTJ1AxZg6Lxa87VpIR
         f62cmw/mrg/fUz0Fzv34nI9QN765Dgxnr/FT1WnaO59R2avpPKRJJ2gb8SiCP35gJO+z
         ehGVzQCmWiKNIupHJq3uIUMgqoJnI+RO/GW5u96+Z+PvZbVJh+Z8IoJ54QlQSoGLJFZF
         3CJdcGNEw8Z9hNCOQTYIfI9fgmnOVhj8aZt+9QZte+wdnBPSq4BLVeD6p0PCX1jcqUfx
         ucEuzchTJhTp+Xh60v4gKbUF8b36wzipRQSMuD8MDg9LEsC9lRGkGnUSVRTMXwK29f2r
         0c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KpiPtnYMV+UpotVKa/Dy5aIZrExOkIAmVS6xXS605w=;
        b=RhZz1Zd+VNuBBCmSLJX8DN9Bi2HXP6OZ6PvvfTnGLyCmdgTQOYmrpEi4Kk83kZ0W0j
         hv7lGlq53UzCdZNhNFe9Pchgs+9uipgepFKMpxmnPM5f1vGltqKkm3k6hKpnHr70FGVD
         gxGOZWxxxcUpVSz7Ph7LMzlPN4vZ6uyaYA6C7BiCu77BewlYiPd1V3rQaK3YGp2n4amg
         mClG5O6yTagltT7WSCucMomAidC/bTVXI1TqovwwdyEl+i9CHsJ3qv/CuMdP+bG8gcnf
         FrYircTqtJVpZX/i3No5zls8UXQRuKa+RS3NQYJUfVfN054eIxw1zBTyyyoNORGtQ0/y
         cH8g==
X-Gm-Message-State: AOPr4FWAbqyWrhHGqusbaIZ06/139OXvpTYEQKWw7dQZl57650L3J6IWsP3hBl5jkKOfIw==
X-Received: by 10.98.44.149 with SMTP id s143mr3518165pfs.31.1462701039597;
        Sun, 08 May 2016 02:50:39 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id w187sm32746756pfw.50.2016.05.08.02.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:50:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:50:39 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293934>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 credential-cache--daemon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 291c0fd..1f14d56 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -179,12 +179,12 @@ static int serve_cache_loop(int fd)
=20
 		client =3D accept(fd, NULL, NULL);
 		if (client < 0) {
-			warning("accept failed: %s", strerror(errno));
+			warning_errno("accept failed");
 			return 1;
 		}
 		client2 =3D dup(client);
 		if (client2 < 0) {
-			warning("dup failed: %s", strerror(errno));
+			warning_errno("dup failed");
 			close(client);
 			return 1;
 		}
--=20
2.8.0.rc0.210.gd302cd2
