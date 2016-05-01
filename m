From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/41] credential-cache--daemon.c: use warning_errno()
Date: Sun,  1 May 2016 18:14:37 +0700
Message-ID: <1462101297-8610-22-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:17:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpND-0007W2-4P
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbcEALRK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:17:10 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33941 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcEALRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:17:09 -0400
Received: by mail-pf0-f195.google.com with SMTP id 145so16225949pfz.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8KpiPtnYMV+UpotVKa/Dy5aIZrExOkIAmVS6xXS605w=;
        b=oiUbU6/LtIt3ntX0NK7tCf53fczPycCpKVaYKxZMyxsMfSeZOqyLU7cUgf8RhNG+Nw
         cL7OeycCl7YgdlLTNAoXKIoZTG+rIbW2ojwOzt/q6h2d0edylLaL2X978OmLMEAkQ/Yv
         cLK9FVNCxX44r3e2GZMX3loWPECIPcrRGe7KPBWlUtYIkfYvGJVswQYDfwuk1psI2MJX
         0yIqlpL31pMQsXLRHkfBUA2psAI5t+KLJA7Lt1/oF2CkwGHTnXFKUGYnf1RZQvxKdlBu
         uy8HabLzECQbfMxEDSaSWZLTHsN4r/t4mQl0FZLKz3D8HVW6GxPYPoKvXvPZJ7l5vLnz
         vZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KpiPtnYMV+UpotVKa/Dy5aIZrExOkIAmVS6xXS605w=;
        b=lUAI5sluXPPkKw+fVuG6MoxH/3DyuRlsX8ze+qC3SC4gJ8j/QJUkCmVvj4g8ii4AhJ
         FF7POikEXv2FwGWH/eOuUKn5/4xFO2vUFRdTVEcCoNrR9YjAyTTGunXXzkSLRyzsuAt8
         /g9oUNRQKfSn1ZVzOoyBsiRy2TaP2u7JyhFHbWy1WVOMgqHqFXX83DgH76DRZR71Ziuv
         yFCgn70TICmR0jl++tR0UFVrPBpPbf+kEe1bn1PWyPR+w2ibukOuwvAuODbpdys1b7P+
         apoNDFn4q6L7xubtZnwwTulww9mvPT5ONSulAnrBZq++bAoOs12yXRbNXLVNg+APJXVu
         dePw==
X-Gm-Message-State: AOPr4FWF//EOZyLUsevzIJvubFUxZZD6KVw1cPB4Bj+wEPXxafD2H4wNAaRGVZzCDrmGfQ==
X-Received: by 10.98.82.208 with SMTP id g199mr43429685pfb.113.1462101428639;
        Sun, 01 May 2016 04:17:08 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id s64sm37053322pfi.77.2016.05.01.04.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:17:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:17:03 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293171>

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
