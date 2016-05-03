From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 29/41] ident.c: use warning_errno()
Date: Tue,  3 May 2016 19:04:02 +0700
Message-ID: <1462277054-5943-30-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:09:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ8i-000104-2e
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933180AbcECMJP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:09:15 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33960 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbcECMJN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:09:13 -0400
Received: by mail-pf0-f179.google.com with SMTP id y69so9205366pfb.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8bFAMFliUNy6ztMyy8HIKhsZoCTrmJvg5UuqN+SKPFM=;
        b=ySGk+eAfVkYX4qtW71GKUVixd6enfcnHCrnwf6LJSNWLRG3/8O9q+92mKwWcy0DrXP
         elDdwyKJ2qDFticPL5K4Wvw3d1phbwQD5ItHIWQTt6Gl237CYi5/XprVlm0cku7HjVzO
         Smaa8K0FWYRBlk5dVeQsVkIouf2ui7zkO3F1hPSDyi8DZThgGerdEscdw1MO+H+fJAmX
         7XpO3+CdrUHvf4mIx9Mn9N3J8EhB3F8bWEAj74hsKtFWZhDa2+gzNgJCnK4SqFplHB/w
         BcRMSSKHdJwxdmHg0WQcOdFEDfIKnkghy/eg62LysJh6RNCavAV2rNuMSb/l44jcCbY9
         XwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8bFAMFliUNy6ztMyy8HIKhsZoCTrmJvg5UuqN+SKPFM=;
        b=VR1y18oluuqQTDszUSgj1rTJR8XRykn2/yyi7Tfn6EC9K3xZIOtnWgTCg/xxpSwKMF
         X97TdYaUbDY3neOvuBPuTJuPaFKziczJFd1FISjikItvFAkQ8C9LqkIs4mgGuoc3nPKw
         rf7KAoXtxEjhHY7QAkpzF9t3ZH9+OzDK4N5WF3wpliUnf67P+baWAgUQ3BCx74ydR7J6
         oHkrpW92lWqkCAcNE2j6GZta7fKLTtU9uyQGSzs/XbasPRZNt1VKVQ+Ya79A0PQD1TJW
         JS3xnI5Xdxxp6QCgqJdFPFkMBexkM/h5uWpcKyhNqmnwavgNPf80PKh9CRsBlCamFdCz
         BP6Q==
X-Gm-Message-State: AOPr4FUoj4BaT4psBc0/EsdCdDkMhgHV058ThGkMYpFBqPi1eVT2kd4pVckYC6dQj0xryQ==
X-Received: by 10.98.67.150 with SMTP id l22mr2864201pfi.85.1462277353128;
        Tue, 03 May 2016 05:09:13 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id h1sm5510822pfh.49.2016.05.03.05.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:09:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:09:08 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293382>

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
