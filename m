From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 23/41] editor.c: use error_errno()
Date: Sun,  8 May 2016 16:47:43 +0700
Message-ID: <1462700881-25108-24-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:51:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLMX-0001ba-9b
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbcEHJuy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:50:54 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34405 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbcEHJuw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:50:52 -0400
Received: by mail-pa0-f68.google.com with SMTP id yl2so13705285pac.1
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQQvbPgpDADclqRFs6G0rC4KFjtucsT1ykBQJaYgYmM=;
        b=uhEu88yFngYpfWo00HSM6SzIaBgB6HIfT+aGD34PiZ8IhKPjZmkDqOGtZvcGstB1/U
         QMDCD9svDLeNuwP+AmGLYtjKUKy7oFAAQBtaKlSGe1bWQVNl/cJp+aQkJUE92hf0KB5E
         JfTg9HmMMqlV6pC6HOyL34BP3kPMqeUhhJLFjdjZ+wpvHSUm9ktIIyI3k+5HSFUR2OVO
         ssaTHEyxUTPRWcuRBwTA188JeymlUkB/ysbCWDErrn0gOAOHhAfBtjTnQVZShtEh2Xx2
         EMyVZ15yVupY0cV/tn6R0YBGR2wdulUIUtYg4Nz3DFYccmF5fjBdL0eJVb+d3A/LHdmT
         2ccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQQvbPgpDADclqRFs6G0rC4KFjtucsT1ykBQJaYgYmM=;
        b=HoBDliiPaR2a2DaqiEumfKjdhlp9zoYmDaQFNITXt5syTPx1Jj6KIA0y+iWdSkA/ab
         iV1mzAEvJ7CSqQxENp32HlksznHnsUjj6+6kOoEJPvQckc3PskOd5+QVJ/fKgHB+bjBI
         KveDb+XUXDYsAXO7ro7FTd1Pv/4WKmXpqZNOQObFhjPUIGb2YLkgZ4SDk813JkjaB9Ya
         Sn0mY1qvAa1IqCTHqc/4eLgM7IkHHWGhTkQeH7jY/7Vl08CleVEXbM5m5wsHKq0SR+Kk
         d7AKp4Z0WN09Ucei11XtHDyhtCi9xXC3zj+w3KxzDjmtveBiOMyCdALMjy1u6VjMq/fh
         rmvA==
X-Gm-Message-State: AOPr4FXoJCYRyC5f6QtF3HlAoo/BMr5XAi1fbZDBUhC0zNcjpNg3V6TVGDmQDFafUN2J6g==
X-Received: by 10.66.119.177 with SMTP id kv17mr42030896pab.57.1462701052336;
        Sun, 08 May 2016 02:50:52 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id f67sm1318417pff.62.2016.05.08.02.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:50:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:50:51 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293930>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 editor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/editor.c b/editor.c
index 01c644c..7519ede 100644
--- a/editor.c
+++ b/editor.c
@@ -63,7 +63,6 @@ int launch_editor(const char *path, struct strbuf *bu=
ffer, const char *const *en
 	if (!buffer)
 		return 0;
 	if (strbuf_read_file(buffer, path, 0) < 0)
-		return error("could not read file '%s': %s",
-				path, strerror(errno));
+		return error_errno("could not read file '%s'", path);
 	return 0;
 }
--=20
2.8.0.rc0.210.gd302cd2
