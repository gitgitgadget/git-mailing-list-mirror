From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 13/41] builtin/upload-archive.c: use error_errno()
Date: Sun,  8 May 2016 16:47:33 +0700
Message-ID: <1462700881-25108-14-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:51:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLLW-0000bP-PF
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbcEHJtv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:49:51 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36224 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbcEHJtu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:49:50 -0400
Received: by mail-pa0-f68.google.com with SMTP id i5so13722037pag.3
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8jdWZmsUdmtOBkS5F/vUlz14XqOWbgdFAH22e0jkqc=;
        b=BjlzvJg0djP/e1/Ksma+Q9K1gQjUjmmC8VID+eX/0gvdU4I63nwxNCpfFUpohz2MMR
         UgBg4MmWgKaCSm2qtrRVbBr67UP4enh2GJo/qz/1jlUJkPY32KyEE1vWiG5cKzK12qbT
         bFfD5uNEbQEpLvVf/+ENj92YjzgGMogP/QgEe8qVSuB60reqUnQ41YigizNyUrBjliXC
         LoC9BA7RiLSI1ZZp7j5jeMckYfgdcXnupQx2FjqU3s+6Ue0euo0BHaNASAg5jIt2jI0V
         jIkVr+7Ab4OyOB/UevvlliRasuoYtlXvnNr8WFvdB8t0HUWi2DfrWqMQNUxntubMwXQI
         DM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8jdWZmsUdmtOBkS5F/vUlz14XqOWbgdFAH22e0jkqc=;
        b=CLVke9CaMjiWynMf6x8cnwh5MH2jTd9ciPJzKl6bVl/gWEGid4t9+4RXk8EXx3V7w3
         W2JBofO0o7yjPcI2xzAwXJDjnnKjBGmkE+lhBrATvGWClGwanJSbrPdZ35ZSRwFzJ1y9
         btawVGvqq73LUcrqQ9p7EMUFwt11GXhdx+wMUA4fAQjgTkJbM84fkklKJlyhU+7ZTlWh
         zy5cdJ2zXcQA2cddOmSXigAvBGwc3azsSgEoQqI4joFXiikRrsbcbbonxI6bG+wHjHUK
         Mq+8FGCs/Xtjq+D68xjA7QNU8bXMLNHQ5w+eW0jtxVbEFpkwEIa0hTf1h1L4vjAqe/qf
         pcSg==
X-Gm-Message-State: AOPr4FUfEyJw9gRzEyM32DWdSoByM5WhFHxT47rZi1eeP5LgEo55NsMEXdQnW5KMPrfauA==
X-Received: by 10.66.180.111 with SMTP id dn15mr41394289pac.69.1462700989668;
        Sun, 08 May 2016 02:49:49 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id u2sm32741058pfi.26.2016.05.08.02.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:49:48 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:49:49 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293927>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/upload-archive.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index dbfe14f..2caedf1 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -104,8 +104,7 @@ int cmd_upload_archive(int argc, const char **argv,=
 const char *prefix)
 		pfd[1].events =3D POLLIN;
 		if (poll(pfd, 2, -1) < 0) {
 			if (errno !=3D EINTR) {
-				error("poll failed resuming: %s",
-				      strerror(errno));
+				error_errno("poll failed resuming");
 				sleep(1);
 			}
 			continue;
--=20
2.8.0.rc0.210.gd302cd2
