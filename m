From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 29/41] ident.c: use warning_errno()
Date: Sun,  1 May 2016 18:14:45 +0700
Message-ID: <1462101297-8610-30-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:17:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpNs-0007ro-Ud
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbcEALRx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:17:53 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36123 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcEALRw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:17:52 -0400
Received: by mail-pa0-f67.google.com with SMTP id i5so16179062pag.3
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8bFAMFliUNy6ztMyy8HIKhsZoCTrmJvg5UuqN+SKPFM=;
        b=N21NqQcOH4cqqNRA3wuBIsTF6gkJGA4+qRdyApiyZS3/9eHI4xUUfslDxETyaforO8
         ADEaR5THDmsr0EKZWTO4MtNT8tZTX+6AQnhaPQgtskqiVzBULssYQAvFVrDacQ+iEPXn
         lFBUjG5FXSVZFS8xF61E6GvJZpJ7lZhVSAAEP9qLytPehssVlbwk/jWXFkf4FOfxrfPE
         REHSHAQ9xJEdh2le0P7mK9w6mCPt2M28hSt5AcvNRmKt7uDz3+6Qghgs5JXv2TEzWyiH
         1hmnF9Ni5hyOmf3JIglFz3LE2VfztzvxcdXkxxwk5eYYujRMrviD3Ts9yGme+BOAYQ+W
         K9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8bFAMFliUNy6ztMyy8HIKhsZoCTrmJvg5UuqN+SKPFM=;
        b=Wlk4zKzphxYmPsseeYnCqdNq9tlxWeejDI1D1gppigBJT7rYnY9RVk3fJ7X+gWtvRp
         wGq+pTubqNg3RKy8/G5060OPZtXfZ/PfQ0ohEwiSnu585BboyW59U33PKTob1ltRqo++
         eepTTdiisRcUFJfGRYprW34l7VFjBmk+Qx01VZgUblfdEmllanEWjLMdkPPvV1gasNck
         8ivMMOhK+6enFbY+QQuKBvqVsw5VGSmths2skNg4GeyCO7eufN2SEqsJz8+rG2woUvGO
         uow3XTNeQ6xO1opIlMSbBa0jejQo1AUPb9mT7JEkNdn8n+p7ucBYcsvMYXPgQQplAbDF
         d3lw==
X-Gm-Message-State: AOPr4FXOeJjqJ/JJqDdrlajTAr3kbAU+ayBzf75FVxE04fIHJzMJVwSKMR4KqNAI1H7psw==
X-Received: by 10.66.172.165 with SMTP id bd5mr43905949pac.128.1462101471607;
        Sun, 01 May 2016 04:17:51 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id fn3sm37378106pab.20.2016.05.01.04.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:17:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:17:47 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293179>

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
