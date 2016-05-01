From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/41] builtin/worktree.c: use error_errno()
Date: Sun,  1 May 2016 18:14:30 +0700
Message-ID: <1462101297-8610-15-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:16:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpMY-0007Bf-VZ
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbcEALQb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:16:31 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36478 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbcEALQa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:16:30 -0400
Received: by mail-pf0-f194.google.com with SMTP id p185so18815335pfb.3
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aKLEVrD+0v5e5XIVY9tJEs+9ZFOYejn6v1Ggnnn7Lbg=;
        b=NTekKMLRLjS0QXMNbXW5AkIaeGgxEdQkj0R8K5KvSGWy5COW0tWOa2Lr5PJM9sKddc
         xNzG6feg5/sAuQ4eLlR7MItnU4cua90otCYsFV1+0raKvyCxqe9cfynW/f8gsB0uaBkG
         u9PKspfsdQy0BI4ViDI26jwarwPOxOu1eBAbrydQawsjSyBzY6Qj5iA6oNtuK+QoY5SC
         xOzqwK5vaScWE2uwd/d/0vv4uX+oH1KBrrkN/QR/iqJxsnICth4JYV/C3Xx4qVDBKxWz
         taPDKH7op72DobCwAPL3fRjcBByx3oQvYveeIbwN6VpQx/DZ+DL54H4g1mrroRF7MQmE
         KJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKLEVrD+0v5e5XIVY9tJEs+9ZFOYejn6v1Ggnnn7Lbg=;
        b=Q1hz1F5T2Q30xbe7h18f4dBqNtPh/DvbkHkgdYURce081WP9Z+M2gGPdk+/1nfXxEN
         +7Tv4eNPp9dRRzxKEQlvEcXfyQbxn2kDDE63aYV9HrNQUD3Flq2WJ6nP+n9ym9HuLRDs
         4OZkVAb+JxaLZIzJwonsOs8gC6EZ81Fz4ltPXJN/JtVmUHs7E1e6XPd8kpR25K4OTqgc
         I4RPvDsoutpnh0rDJnBPZZp9YlpG9wpY2RUnFEwT0sTh2xZwUByDrLjvNP2rLfDDHQSh
         ucJFFciy426jhSDkeJCXbjc92xgKM3QfXl7IupL4KcqVTDoJ3XHHVGlJPM/eIypC5u00
         WQLw==
X-Gm-Message-State: AOPr4FU+fvUc+rBh3gyWowbg5cv1pSgE1j2gYiA7lqGUVIV9HPaugaEUW48cFWGLn9w1pA==
X-Received: by 10.98.41.65 with SMTP id p62mr42685206pfp.29.1462101390038;
        Sun, 01 May 2016 04:16:30 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id 8sm37041772pfk.69.2016.05.01.04.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:16:28 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:16:25 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293164>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d8e3795..331ecf6 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -110,7 +110,7 @@ static void prune_worktrees(void)
 		if (ret < 0 && errno =3D=3D ENOTDIR)
 			ret =3D unlink(path.buf);
 		if (ret)
-			error(_("failed to remove: %s"), strerror(errno));
+			error_errno(_("failed to remove '%s'"), path.buf);
 	}
 	closedir(dir);
 	if (!show_only)
--=20
2.8.0.rc0.210.gd302cd2
