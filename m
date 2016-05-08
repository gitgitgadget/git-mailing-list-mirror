From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 26/41] gpg-interface.c: use error_errno()
Date: Sun,  8 May 2016 16:47:46 +0700
Message-ID: <1462700881-25108-27-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:52:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLMr-0001zv-1H
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbcEHJvN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:51:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36463 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbcEHJvL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:51:11 -0400
Received: by mail-pf0-f196.google.com with SMTP id p185so16154911pfb.3
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0LxuSCppRXjmPrqdmtGSKkSmFbTboXw2fK+aByx6rE=;
        b=Y03WhY7ykitph84WSQiJ22tSUiInBh3uobZ6aqyhVQFa0LyIPAiGtjUQu//M4bLaFd
         fHhDGtyyKjQBfFIrUyleOKKvrSwFIkI5zGO9zzECsy9Is8t3630kkoJscZfeLZsuQRb2
         Ka9LXXKi9sveoIoPanPkI0QdV+J+m/+/9bfSkthnAHemo0yupLQDoNaS2iRzeb5XUTLK
         zxdz5qv4dvKQS49QoVvJH4y4fTN6yCh3cBLSDKdYuy/1gV1OBB7PHY/ckzEpu/q7XCEn
         lATrEdpH0KEBQkKfBrLWbVg7I9Hvn+9H/vVJ2aKld+u143btSJkHBZFTJuc2dvntd7aW
         juqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0LxuSCppRXjmPrqdmtGSKkSmFbTboXw2fK+aByx6rE=;
        b=Ux1/0tvHvJvkB1EYH7sBWcuGDONmCJbhluw0gUf6fkOTfZHtxHvuoLnNmH2iReG2sQ
         6YC67AagEtQNG6Su2jfVBmWtmxXWiIZG7WLWswKLu3LilZ24aOi+OyOk4bywp6+SmJqn
         F9/FxQS+wFe8Fj1EIbSVviOuRV3dGVVHfygiuKq0M3uUSnSdh11bkO4GisM6tDstmqbN
         G3Ms8wnujE3jDOgeTx2mRwKwHjymQ2BDBRysoLbX0zBWdqz87a//hULpG1dwAqJTAHm6
         119EoIqzC5z9iVrkU5SHTR9jAElcHFbqpqVDIt2LE2+pw9CChUbdA1WTOjm4bRpe+jur
         JYPA==
X-Gm-Message-State: AOPr4FVORd140KuGDRRcKT1TUxJfBoe2/E6CxDwBOlV+LnXCFI59xHToVE2X1bdcBKG3ZQ==
X-Received: by 10.98.29.137 with SMTP id d131mr41953219pfd.2.1462701071049;
        Sun, 08 May 2016 02:51:11 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id x123sm32750968pfb.54.2016.05.08.02.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:51:09 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:51:10 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293938>

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
