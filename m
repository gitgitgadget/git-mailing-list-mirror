From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 35/41] server-info.c: use error_errno()
Date: Tue,  3 May 2016 19:04:08 +0700
Message-ID: <1462277054-5943-36-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:09:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ9H-0001Gu-G4
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933188AbcECMJw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:09:52 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33352 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932930AbcECMJv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:09:51 -0400
Received: by mail-pa0-f41.google.com with SMTP id xk12so9002614pac.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vly83QwcpYrGbLNNi9RJDItsyngo4LD2zBDVuDNKLwA=;
        b=Rf4dukrOh5eyhQLaokNlYoxmEihpKcM0OGpYvZrOxknX5W4O8srQ1i1YoLFq5239L2
         yHv2jLQnjB63XFfJKvByuurI9Ca0CM3zGELRffn/vPvqs84TaKN0Kc60Fi2No/qebmMj
         dIWvAqSxw3H6fGJXFjp3BZs3pqXvuc/ulVbEJEyZvcvTdPHPHq4NE4L8JhZultSU9is+
         J1LqJyaTY3qYOIskC05E8t+cWAiZ8sET1gN4znj6JHqJMmkbz+jHz7dOIds6aVemopNJ
         bcPd4dprZZvUCgJHvEW+CY3kQZh41+LKncoGSLOse+gkBZBBR7drVudhseMvVi19ZgUx
         8lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vly83QwcpYrGbLNNi9RJDItsyngo4LD2zBDVuDNKLwA=;
        b=QbKzxXpkqo/KGFHgqGQhlFIobe2L9zoPAA6HpVhjx9XMR2+poXRr7ott3e7a77Jl/B
         qGZq9wxqE1Tygnh+PpW9WbIEWia8FdUTYgOz4+WlqWN849s/d4ij4ct57lSzzwCpqx5Q
         6cuavK4unjRjBHPedxOzk/fn7cYW6ISpSBnV9SWq18xYP/FFMjO4N5pXtglb7kf9U/5j
         ++ZJguM/C0ibbewoz6tRk6wEIztZzxa+epmlwZPdtO/TX1sKRzwdPb1UCGhNJTuBE7R5
         cm/mkY9uTwvS9VT83c/IlaAxYOFU2jM5WxW3wfvvvX6eqCe20MYIdb8RdEAyGyRfQg1+
         /hZA==
X-Gm-Message-State: AOPr4FVALXWnFTETKHDqWMdQALMZEWlJLeppkmwh+ROEHhgGNG1VthmdNju7jA6izG1tBg==
X-Received: by 10.66.63.98 with SMTP id f2mr2883208pas.123.1462277390577;
        Tue, 03 May 2016 05:09:50 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id vg9sm5494069pab.35.2016.05.03.05.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:09:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:09:46 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293388>

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
