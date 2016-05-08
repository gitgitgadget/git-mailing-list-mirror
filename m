From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 14/41] builtin/worktree.c: use error_errno()
Date: Sun,  8 May 2016 16:47:34 +0700
Message-ID: <1462700881-25108-15-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:52:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLLc-0000fb-UI
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbcEHJt5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:49:57 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33527 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbcEHJt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:49:56 -0400
Received: by mail-pa0-f66.google.com with SMTP id gh9so13695075pac.0
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k3ghtVFB8CZfpNRzFAql3xrI+UHCtB447A2FQxONOUI=;
        b=ahv++wE0EAZEiGUvT0GX17xr+0KBR3Uu77o4vDHliflEKguYIDbz2SX7XJbluL3zng
         2aAYTYarqr+e6xBOotxje0B3uU5YQRQjVS4/+wL6KLqXCVF0VNX7HXp3jgfkmycVaA+T
         M7OUcN3fuLapCPVf5I4l3+6yJjaD/uOSz4TusmACVGrIjgac9AVbmkTY2PLwQzR9htXo
         Lvn1JZT5pl3QP+Gb06Rk08aXVFErYdSxP8t+FxzQT3IdiYQJbvEEwcIZ//+o/Bwfp0/o
         XyXqGAgxwWQJ/B1qBckOJ1P6soq2JVoKkMr5P/rVmkOJxjJe0AIfBu5bsEmplLAcbvgK
         MRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k3ghtVFB8CZfpNRzFAql3xrI+UHCtB447A2FQxONOUI=;
        b=DMF4TCKuaYO+33F2kw59eUsBxPB09qdCdL1pz6zx/BpjydKVm2LRTA6KZrfThQhD5k
         A/myOPp/fq0MKqgPTMN3ap4VCfacokLseRirx+0qxUKXJYkEwfWr4Jr0wxtXxW1XiPsy
         H0hssWxOrBTUMQKTvvUurl3EqQWpc2aZVMiN46ebX2X1lD/PjMfY1nOOseWRDkZevwMG
         xhmiCB2cdXvG+cdl0G4UaBb9yUfu+TZgQ3tfKbNsfUS7p/2Ea4VlxHros+P6x3etE9b5
         9/JLsCX4JOn1iRJiu75tHQqD3cxWaijGj3l5srLSZOSyL0AefLlOEJxCIXBdwB89Z1jq
         afxw==
X-Gm-Message-State: AOPr4FXFEmRhQ/tkuPJcIol7Ba+oE4ySTvM/iteIf0hxFuchm+n935lmcs168PZibetkDQ==
X-Received: by 10.66.14.198 with SMTP id r6mr42412871pac.48.1462700996004;
        Sun, 08 May 2016 02:49:56 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id t62sm32742099pfa.38.2016.05.08.02.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:49:54 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:49:55 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293942>

While at there, improve the error message to say _what_ failed to
remove.

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
