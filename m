From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 27/41] grep.c: use error_errno()
Date: Sun,  1 May 2016 18:14:43 +0700
Message-ID: <1462101297-8610-28-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:17:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpNi-0007mU-Mf
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbcEALRn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:17:43 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36715 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcEALRm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:17:42 -0400
Received: by mail-pf0-f194.google.com with SMTP id p185so18816670pfb.3
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DX0HEM0WeYaxnCaLoffPusj1l/aQS9N/L6XYpbuN3w8=;
        b=OUS1pphGjzJgAJPVuB8CFhNddRy1NfI4DNMG70m1fVGH+nXvMNe4CM2OscEZTiRarg
         qlmuVLmwBUoPbLMNDF6GeS4G+YxEErfWDm2QObQpvkw8LtiR/N10ysHMFMVS05r4+bAT
         8zPRJoYw3MoOKacosCq3KEIDknVbxljIIyQ8cnNIDNZCEyU7C6vbcbyJvLr8IXTQ/Pp3
         gs7eElcgZjbFCZdJYmmFirSZ0/abN9yDZVeCEf9jamAgClu2aFqNYex+qUaXtv8ACz5t
         cJypZp++bDoQ8HDr4w04bWjhPHa99SmHIBg/uoguzJVN1TF4enB6NTkAqNtHbzVsE+ds
         4FoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DX0HEM0WeYaxnCaLoffPusj1l/aQS9N/L6XYpbuN3w8=;
        b=Mr89ZdhN6ZKO+AM+m6AXMmIopshIDt1U18BeQGVKJNaQxlGLtlHBHiO6OGRaKSoJTg
         NjUvQQzDDxfvBrhnQQzXeTcE9GXeKEEAAyQHocSOdaNnbkrlWowjmv2K/AHXiMBn8J5n
         OO4/6VfnOO21EOt0jrmjfYUPc6nwLJHkqhY1QauDfdbI562AtcFKIT9x1tOutKaJPefW
         57wqveyoD/k+RBRJU0RCSvWdMwjtmEC1fDu4boBL/sH7aKFiiwyGjUQyAhEJs2zF1nqK
         UI0d7r2qSyeHtn/sGo7wWeS7u3Pq4LmLMrCBCckzDNj4LnTsx1T61O3MxFEdKG6L7NZK
         r8Ew==
X-Gm-Message-State: AOPr4FUQaJRMrohUlwI8Zdd3cQK7dZ+rRBaSO2pdqgIy4fNdHX2KblruY12pmFaTPbr1+w==
X-Received: by 10.98.14.67 with SMTP id w64mr43490494pfi.154.1462101461505;
        Sun, 01 May 2016 04:17:41 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id zn12sm37407728pab.14.2016.05.01.04.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:17:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:17:37 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293177>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 528b652..87c1890 100644
--- a/grep.c
+++ b/grep.c
@@ -1732,7 +1732,7 @@ static int grep_source_load_file(struct grep_sour=
ce *gs)
 	if (lstat(filename, &st) < 0) {
 	err_ret:
 		if (errno !=3D ENOENT)
-			error(_("'%s': %s"), filename, strerror(errno));
+			error_errno(_("'%s'"), filename);
 		return -1;
 	}
 	if (!S_ISREG(st.st_mode))
@@ -1743,7 +1743,7 @@ static int grep_source_load_file(struct grep_sour=
ce *gs)
 		goto err_ret;
 	data =3D xmallocz(size);
 	if (st.st_size !=3D read_in_full(i, data, size)) {
-		error(_("'%s': short read %s"), filename, strerror(errno));
+		error_errno(_("'%s': short read"), filename);
 		close(i);
 		free(data);
 		return -1;
--=20
2.8.0.rc0.210.gd302cd2
