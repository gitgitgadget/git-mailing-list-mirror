From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/41] check-racy.c: use error_errno()
Date: Sun,  1 May 2016 18:14:31 +0700
Message-ID: <1462101297-8610-16-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:16:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpMf-0007GM-3M
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbcEALQg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:16:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33849 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbcEALQf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:16:35 -0400
Received: by mail-pf0-f193.google.com with SMTP id 145so16225456pfz.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2DfWrWJ5ZGArRqWu2+m5QsYuoP4vyioNntB5jJS7CwU=;
        b=YRPCy1I2p1ZiKBFitGkTQYCsC5N2U7cArEXM4INEzkEzjGbe/LS5keOn2jB9jc9wLa
         7QFgT0BC54WZKxAL7+RGKYY1kr8pu2WllhWFFr2tEHehe5HDLnEYHkWxeGUBRs1YA0pJ
         dHgp8RETEm3zlysx+buUQcaOcd/nRA8NMfHd6onyNHLHDR5WXx9A13IfPvxGjAP0McUK
         E409UANzEjCh1g9ytLvtKuYESe96LIccgx2ryaCZ8r3gY3j41r3h80z/yvhgl7Jsa59m
         /kD9EqxCB222qY9s3/N50EYeXy9bARoOxnmnibGafNJZpNOELbuyT2YIx6phTMSPlL0n
         FslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2DfWrWJ5ZGArRqWu2+m5QsYuoP4vyioNntB5jJS7CwU=;
        b=G4u2wCYJn4CwAIHKzRmLnvbfdAC0xsWpVVpxO/Ia8xGPFDNCocbTpdp6pNj2ySyRf6
         dqr3UDIV06CHN5g8OobYGXEkX4F78wLd4Z/sArRsainF2C+406TwUiDp7JUDwz3vmSMM
         pCtF/vw4SJTWNYgQ1mrcJoKMrk9gVyf6Ew5wVAnsF41MxVh5zR8I1hXcwb2Oxd2rY3ke
         EV9w+eeP7VAwKnOa2lQmTGhvYezL3jPAmdrWUB+8ld4gJktHaapfL5wrttTMZbERWBSq
         5FQNkyT3fC5eweCZvf8oezXVwKxjS2W7oq/JOnPBpn3gCvaLfw6XVln7ALjnAHmuLwqd
         0aYg==
X-Gm-Message-State: AOPr4FWvxUGWciFbmAnEsEMBn6v9wynVsmeT1I8ylC/e8AzBEpsiGBAIGZvmaN+po8Cm0w==
X-Received: by 10.98.31.65 with SMTP id f62mr24474636pff.83.1462101395273;
        Sun, 01 May 2016 04:16:35 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id 28sm37091010pfs.1.2016.05.01.04.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:16:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:16:30 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293166>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 check-racy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check-racy.c b/check-racy.c
index 00d92a1..24b6542 100644
--- a/check-racy.c
+++ b/check-racy.c
@@ -12,7 +12,7 @@ int main(int ac, char **av)
 		struct stat st;
=20
 		if (lstat(ce->name, &st)) {
-			error("lstat(%s): %s", ce->name, strerror(errno));
+			error_errno("lstat(%s)", ce->name);
 			continue;
 		}
=20
--=20
2.8.0.rc0.210.gd302cd2
