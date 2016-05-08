From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 29/41] ident.c: use warning_errno()
Date: Sun,  8 May 2016 16:47:49 +0700
Message-ID: <1462700881-25108-30-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:54:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLN8-0002K1-Ui
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbcEHJvb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:51:31 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36529 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbcEHJva (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:51:30 -0400
Received: by mail-pa0-f68.google.com with SMTP id i5so13723949pag.3
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8bFAMFliUNy6ztMyy8HIKhsZoCTrmJvg5UuqN+SKPFM=;
        b=xgPEgdSER1ml8NnERgzxk8TRKfRFPHalG5R++5ySUNEIVwx8/Q2ezvliRir8+qLAfL
         SBUR/Om7OW9jh/upPzSzcGI3cw4llwpemycjhHbHcc8VWwjJzdnSQcQdEH0T5qDGyw75
         w5urUJk74zLyz+hGiBlozfwLNZaCddRv2fq4QfURP0iY7gC813Pj43Jw0UZRWeIRTb94
         TQNI67n1GToX6GdXYUug4uD54ueXMJ2jbRfI/p+on2vMawb3GljD3NqPoe0r001X4DyI
         UKRhyhYEH98DTIbLJkSrmYwGXCA47hyQ4jjHl0X2vfX/m1aaQOPgzEfFfnwETtmv1YvE
         XZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8bFAMFliUNy6ztMyy8HIKhsZoCTrmJvg5UuqN+SKPFM=;
        b=Ao3thiE0W2IcYtAo8+o0XXzHxM3UCeO5Zam6SLBXXzLvwlA0AI1w64kux0EKZ1+nT4
         r7PKdYQC0Q7vt1LZOebNLH7GsRZHc9QImq6BcyMdwBVr6cwMIhRdMNSozJaalD2eAg6u
         bXSpEAWr2tBrWu1wg4LrMJtuArHkeGfCdq3W8w0chUabxwtISETeFXXlsBeAKtPtpmPm
         PKHnELmz7qLUedwguqjio3XiZeAAHIdboV2g/nyg41bPbfwVAnPTxVILE/dhUsBUXY1v
         rWLUOsjr9IVj6NPRftWbBHuoiHQjinLloB15nxSqfh+Tc6TA5pDHlYKb4M+KMC0QpDYJ
         ipqQ==
X-Gm-Message-State: AOPr4FUmSReqY+BUxUB2TXyG5xo7Z0pKLCGtIxriYXbytMwKl2seckdwO+za0+QPwNkDGA==
X-Received: by 10.67.22.129 with SMTP id hs1mr42009837pad.105.1462701090004;
        Sun, 08 May 2016 02:51:30 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id b64sm32752786pfa.48.2016.05.08.02.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:51:28 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:51:29 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293955>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 ident.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/ident.c b/ident.c
index 4fd82d1..139c528 100644
--- a/ident.c
+++ b/ident.c
@@ -75,14 +75,12 @@ static int add_mailname_host(struct strbuf *buf)
 	mailname =3D fopen("/etc/mailname", "r");
 	if (!mailname) {
 		if (errno !=3D ENOENT)
-			warning("cannot open /etc/mailname: %s",
-				strerror(errno));
+			warning_errno("cannot open /etc/mailname");
 		return -1;
 	}
 	if (strbuf_getline(&mailnamebuf, mailname) =3D=3D EOF) {
 		if (ferror(mailname))
-			warning("cannot read /etc/mailname: %s",
-				strerror(errno));
+			warning_errno("cannot read /etc/mailname");
 		strbuf_release(&mailnamebuf);
 		fclose(mailname);
 		return -1;
@@ -125,7 +123,7 @@ static void add_domainname(struct strbuf *out, int =
*is_bogus)
 	char buf[1024];
=20
 	if (gethostname(buf, sizeof(buf))) {
-		warning("cannot get host name: %s", strerror(errno));
+		warning_errno("cannot get host name");
 		strbuf_addstr(out, "(none)");
 		*is_bogus =3D 1;
 		return;
--=20
2.8.0.rc0.210.gd302cd2
