From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 35/41] server-info.c: use error_errno()
Date: Sun,  1 May 2016 18:14:51 +0700
Message-ID: <1462101297-8610-36-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:18:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpOP-0008BI-Tw
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbcEALS0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:18:26 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35360 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbcEALSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:18:25 -0400
Received: by mail-pf0-f193.google.com with SMTP id r187so19012405pfr.2
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vly83QwcpYrGbLNNi9RJDItsyngo4LD2zBDVuDNKLwA=;
        b=vgRhEJlDlaGogV4z2EH5M2sDRs4RAtKvuKPi6UyDlQBP4x3hHBlb1GJptBkQqCaW+D
         g24227XgaKhSIiH0v43DyvW35tLBRPamKQg9PS5FF14T3tRVId20NBIjFQ8n3r/Wi7Kv
         OSOJ2LjaDu4AfQ/OvKiWfoYRA1PSIqDlABoe1jck3abm7iHGggXqg0cQtNKLJFTv4nax
         XAVBMquFhE9RL4pTOkuHhxjMb3uhWZvLm2nmU9vh/AL0wrx/BqwIDz853GE0vzYNR7km
         93jf3CVqHZhGZ9UFnAi5jpwWVQnRbEbPo6HGdGcHx3NxzOBlf1qiUFXksI+IjmRc7ZYA
         2TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vly83QwcpYrGbLNNi9RJDItsyngo4LD2zBDVuDNKLwA=;
        b=IbAhaGjWjkSgWnZMLXqCLyEPfY6hwa288bcIn4NK4+wCb+bUCVeoOL6iuVLnXOPweD
         lFO+Ctlzq27b672Y6rC7aIk9uEUiodTJ3r75EI6/3dvDt+waV/b+HfScV7LMkoraXVWv
         N2AvAC2Uk3OnSmUc5ay+EnJoMRfzMEOSOddo8f5jz0F+CbYmlI9PMjgM6vuo+wDLRIBx
         34m/BFyihrsRm9F+5fpGKI3HasHwgXWJ93IanDwar3nVkDtHYloL+37wf/HUNws9ZLed
         7WS0RbhVr5awD3fOVhOPlL73Y6YoYz6dc377PwecA147ErPZGUQ/N4LlFgHaHYiJGnbs
         F/TA==
X-Gm-Message-State: AOPr4FW5C46XlUjABNQQtAHQDI5LZF5zOs64AFznD8vi9+GNxbzEWqLkiGFUJGjq8YR5lg==
X-Received: by 10.98.98.1 with SMTP id w1mr43583106pfb.117.1462101504422;
        Sun, 01 May 2016 04:18:24 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id x123sm11613684pfb.54.2016.05.01.04.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:18:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:18:19 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293185>

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
