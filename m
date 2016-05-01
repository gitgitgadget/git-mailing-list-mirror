From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/41] combine-diff.c: use error_errno()
Date: Sun,  1 May 2016 18:14:32 +0700
Message-ID: <1462101297-8610-17-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:16:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpMk-0007HW-0e
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbcEALQm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:16:42 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34980 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbcEALQl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:16:41 -0400
Received: by mail-pf0-f195.google.com with SMTP id r187so19010348pfr.2
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t2u5nQO3KDMy5bdZifRGPS5giGlr5MNQmeOmuk0Z0pc=;
        b=kgW/cjv7+yU264c8VwFmhjkLCRu6JyB/VguX6ZXioIOqYWlW4YAKZzrDvCXLe0mso4
         kqj6ic9d4AgH34ufKNxODhtgEiqR4UDEROK2GQREuTLs8143SE3RbTiTkeZaUQlLQREo
         cq26PnujBtc1wW1OhEWTMRYJlLI+JMjJfBtmpS7K85zf/1RazpOt8woUCcJakSwocWax
         xTYGrPBbZs+f9ix2+OY6fgn261jZeEnyLzjyYwIvy0c5SsRfW2njzJSrgaMQHnl+cV3S
         To/CSW50XTgDgVz/O5LOsvVD0BiSoZtdlE8bCdpiJTsnZNLAOnHMCVIwUMRTaBEh86px
         B3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t2u5nQO3KDMy5bdZifRGPS5giGlr5MNQmeOmuk0Z0pc=;
        b=Pofzk8CYro5StpWF+1F2+Tnjc+pFZcPfm0y1RR7KntN7jcUFEL87Som6QqGE/NaHcE
         eE657B8gyBvyaU25TqkqdJB2agVTkFtw4Y3+nn3Z+GPdCkl/2LkpzOOMVy2mws7jPu+0
         ZLTZOHBJvt0O2Fx+aDg0/NH5YKoQV5K1gaYg8xe2KF7xaORMb7Ymdrnvo1CTRumnkJ9+
         mKGn0PBoagmhB2wOab9+36OHGItQr1R1Y0sD6p4Y/+NWnoDJZzpO+9kbPguYfZIVibdV
         TDfjJ2AORpv0YMzPghSON4xQHY51sWW+KaIyAwnEnyUrKccDQN6QwTPK7DqHJz/xTn1K
         wfvg==
X-Gm-Message-State: AOPr4FXzMR4A98fImqC9XESHcUVB5fz2W0i+5uXuIsJEmzzdx55GBhWIwRr4Mp1uQAexZA==
X-Received: by 10.98.26.205 with SMTP id a196mr42611010pfa.46.1462101400711;
        Sun, 01 May 2016 04:16:40 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id m12sm37066899pfi.5.2016.05.01.04.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:16:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:16:36 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293165>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 combine-diff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 0e1d4b0..8f2313d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1005,8 +1005,7 @@ static void show_patch_diff(struct combine_diff_p=
ath *elem, int num_parent,
 			struct strbuf buf =3D STRBUF_INIT;
=20
 			if (strbuf_readlink(&buf, elem->path, st.st_size) < 0) {
-				error("readlink(%s): %s", elem->path,
-				      strerror(errno));
+				error_errno("readlink(%s)", elem->path);
 				return;
 			}
 			result_size =3D buf.len;
--=20
2.8.0.rc0.210.gd302cd2
