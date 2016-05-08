From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 35/41] server-info.c: use error_errno()
Date: Sun,  8 May 2016 16:47:55 +0700
Message-ID: <1462700881-25108-36-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:54:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLNl-000329-SG
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbcEHJwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:52:09 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36660 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbcEHJwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:52:08 -0400
Received: by mail-pf0-f194.google.com with SMTP id p185so16156196pfb.3
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vly83QwcpYrGbLNNi9RJDItsyngo4LD2zBDVuDNKLwA=;
        b=kefDmk3Pf4t5tsIb4If34Nfz9MleXv3khWcQ0qEgzH6F13TPpXvQfXZyWXBLqaRPGx
         cjVNSY0IwCgJJpZFf7itSa6dxaUG23RMoQCt3kwP6w6i/BMvY0kbcBGH06unR7hA85wo
         N2LeN9tToS6zDf3U+3NFBqHMJALpGG3jdHh+eg9xOlKbrzOIFAzMtxSiTAGbXs+/N49D
         4zWoLs0SlXv9aweXOyphAYGYPaJGSDIaCzmVHxFZ/6PL2xzz0LcpQ+CMgoy37TxcR7Jr
         jqh38c0m/bQT4cw5E3w8VSLZ2kcHiFUMFdJvqzzeU+6S0RehnWh/HWjEsds7iu5cGVIP
         q4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vly83QwcpYrGbLNNi9RJDItsyngo4LD2zBDVuDNKLwA=;
        b=Szk9wbSRrHZpxmkMjeT6ssU/ILvsE9JwiW7Nxs508QsMTA2ZENY8JneToJ6CfQQeGc
         5LfBseg/OEX6P9g8L/xSbGIGteYtM1wHz5zYSI8Q9TrY88rAD/dAVqUqX007WE+eLROl
         bcKjw9WFchyUo3G8q9BEibmaZfAvddFFxGUOa3BlqhfONerlxwRaEeweSJhCAlPgUyx8
         RpgimDmllz9sfaCkTFfdPoNREsj2BkJHy9Vd0SQlCKBwfChW0X9oNMqExCm17AGj4jRL
         tCYUOO3kLY5RnzMnXta8FbT3/dtZT6dlCXXZj66euQo9JmID6DQBqzCfXvVdJW9VsJCm
         S3IA==
X-Gm-Message-State: AOPr4FXpDeLLmyoPb35SI8vGZna7CX+yFvTsh+UlHHJ4xPDyinQfpcoIgAaDJNMk4i48PA==
X-Received: by 10.98.10.20 with SMTP id s20mr42544821pfi.109.1462701127787;
        Sun, 08 May 2016 02:52:07 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id rw2sm32857349pab.30.2016.05.08.02.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:52:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:52:07 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293956>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 server-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/server-info.c b/server-info.c
index 5a86e29..75dd677 100644
--- a/server-info.c
+++ b/server-info.c
@@ -36,7 +36,7 @@ static int update_info_file(char *path, int (*generat=
e)(FILE *))
=20
 out:
 	if (ret) {
-		error("unable to update %s: %s", path, strerror(errno));
+		error_errno("unable to update %s", path);
 		if (fp)
 			fclose(fp);
 		else if (fd >=3D 0)
--=20
2.8.0.rc0.210.gd302cd2
