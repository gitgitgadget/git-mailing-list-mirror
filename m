From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 26/41] gpg-interface.c: use error_errno()
Date: Tue,  3 May 2016 19:03:59 +0700
Message-ID: <1462277054-5943-27-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:09:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ8U-0000pJ-0h
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933175AbcECMI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:08:56 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33137 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932634AbcECMIy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:08:54 -0400
Received: by mail-pa0-f43.google.com with SMTP id xk12so8991879pac.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0LxuSCppRXjmPrqdmtGSKkSmFbTboXw2fK+aByx6rE=;
        b=pARCBAZ2/Moe6rVp3vafGbZV1x1Rqrayq5HsXWbpnYJRzEOCbyXNVwY8mCxzOi9lRp
         B2pBAoaRAe2jptoLPgBK2BmeE4szLRq3dgCFNw/8c/fPY3Aup1CF4VxzzIBItIEnImWO
         E8oDF46qFPafBmJDs0NHh6LYPuaYhKCbDAx38jJxsMlaHVWsKocZ8BpyPnNEm1tXFPj1
         Pl72UOW0kQVV3eAtqPKzbDhvy/gEJg9x6Ex8tiC13F/4oPTTWAHcgUMmgs5gFOybfAY0
         nYTQnwX7B/9+b3f0TGsIWgHvpy+o9iJVMgx5LOfTVg0owSCk6zJkr9zuFK75huZsFZ2d
         OKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0LxuSCppRXjmPrqdmtGSKkSmFbTboXw2fK+aByx6rE=;
        b=ev6uOvLoN0wZDOr2sc49AfP2FHD81th8fo/zxatpwKtd2XqkGjLWbTlGHEWi5XE9aS
         4FQZaoqoSw+VTfm08wT4Qq/0wnwyU6ElcjWEJ22yxeewVT46RAoqHrjH7B5zYgafa7n+
         lAOJu3AoNC7RZcQCV844OH/GaZgS9niffzIz05ZBhvazY3H2VpBcfEDA9uRoRxuUQ4jI
         GHR/rqOmL3oBi2zoa4kVh8jHfiWikPjtnTcemY0HYV2q6TCLFMjNBnfuHPuixo6y6DXH
         a40M+JkFX6yaLG7BLQWeaGb+BVWAGLLejTLtHTgfty1xH9Wy/FJisRdTzMoM0tMuZHdJ
         YpuQ==
X-Gm-Message-State: AOPr4FVpD8/lk9HMJh2YfHvbYo4i4GWhgtdW4qFDOHDqW3jcpEM63XCiCVSYJmKoPp3yiA==
X-Received: by 10.66.222.39 with SMTP id qj7mr2854385pac.7.1462277334146;
        Tue, 03 May 2016 05:08:54 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id zs16sm5527408pab.13.2016.05.03.05.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:08:53 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:08:50 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293379>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 gpg-interface.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 2259938..c4b1e8c 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -219,11 +219,9 @@ int verify_signed_buffer(const char *payload, size=
_t payload_size,
 	args_gpg[0] =3D gpg_program;
 	fd =3D git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
 	if (fd < 0)
-		return error(_("could not create temporary file '%s': %s"),
-			     path, strerror(errno));
+		return error_errno(_("could not create temporary file '%s'"), path);
 	if (write_in_full(fd, signature, signature_size) < 0)
-		return error(_("failed writing detached signature to '%s': %s"),
-			     path, strerror(errno));
+		return error_errno(_("failed writing detached signature to '%s'"), p=
ath);
 	close(fd);
=20
 	gpg.argv =3D args_gpg;
--=20
2.8.0.rc0.210.gd302cd2
