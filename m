From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/41] editor.c: use error_errno()
Date: Sun,  1 May 2016 18:14:39 +0700
Message-ID: <1462101297-8610-24-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:17:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpNM-0007bc-Sw
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbcEALRU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:17:20 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35487 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcEALRT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:17:19 -0400
Received: by mail-pa0-f68.google.com with SMTP id zy2so19086716pac.2
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQQvbPgpDADclqRFs6G0rC4KFjtucsT1ykBQJaYgYmM=;
        b=0uo9FxlTVk2WNDoFBnUlBF9+OH7JZSeNu+Zw/EIgX17fMPOECoTa/hi7G1ZiCiIO+n
         /dGr/Wq8Aq3X/sjzHKdRXNFXMeOPNbeB0Zjg450tFB85VgnzS7OOfhF2HNsDJzkDZI7u
         luF8SHGcB24MRZxwwwYh9KNAR3QMDoDJFntDDFthMDM1Vx9DY0diK/Riq3azQ6V3nlsi
         ZAVQdYmH6Uq9Wcn3ka2DmLrWqnO57+ZSDjr5IaKH52N3+0C64hKCX2efeftE5nvctw8V
         kgRobL9ZKHE5swG/W1Me1ZR13zWeFkk2GEIdeiUGxxflm/drjVn2Wy7cVm+iazHrbGO1
         lbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQQvbPgpDADclqRFs6G0rC4KFjtucsT1ykBQJaYgYmM=;
        b=Xhl+tQZvnXe5cN5MY7WDO/9gY72SvN7yRIfg2NYZyqAx4zgFAgyeMH9XCWlMoSOg5Y
         uFvzVXkAcScUjF3NJYDXVQBa1JRBPWOGHRop6H4nHZP3xzQrOR5hnCQkLwSe4O1cFqcZ
         T2e68vmLYQ+2tMjmDmvmAwuG+1sm/8SDyqCsWVaq6dgvKUY1EWkqggp0pbTpmX94u+IB
         BZ7XkIk6xOpp3txI1MDaezm7UZywDC3o0DvQGzSPxaGCf+eGL1nCzSNEvVVaT6ZVxojv
         83lCDWdY79ZMAEOmHK+psAeGCsTrnkJDYCsOy9/tn+mHdimdUNVbS5ao6Nv11x0z4zul
         aRzQ==
X-Gm-Message-State: AOPr4FVU84hiUI24R8y6Vyov/YFpy3Z0funonYtnMbOez/L/9uKSS6uQJFTFEzArxTD/iw==
X-Received: by 10.66.250.132 with SMTP id zc4mr43862449pac.130.1462101439283;
        Sun, 01 May 2016 04:17:19 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id q26sm37073469pfi.57.2016.05.01.04.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:17:18 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:17:14 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293173>

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
