From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/20] upload-pack: tighten number parsing at "deepen" lines
Date: Tue, 29 Dec 2015 19:10:31 +0700
Message-ID: <1451391043-28093-9-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:11:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt7z-0006ZJ-Us
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbbL2MLp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:11:45 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:32885 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbbL2MLn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:11:43 -0500
Received: by mail-pa0-f47.google.com with SMTP id cy9so123707739pac.0
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=07GVOVOnLQK2sExekqU4DrJn5Kt4jO+dHt2EOtL4mKM=;
        b=Xx3218Yy1RR23bvL7GnMI+9d+XOEDmQQElrVhoxEaRRnsjIHJZYhrVws8cRbgXbwpu
         aUaVKhiS5aANvYiAYPzkAkV7We7nXTaNSPNpAQ6Yn0sXQkmzEfrjjbjME23DyJLoSed6
         08Zg0Tc/Lu9f9Sv7KBLCbppjYk9LxNrwKN8bqRE7NsuaYuQ8B/kKTS9Yo1hvKCJxTnAz
         se9cxRLyGa4b0FqGOw2ie/w3n72bvtod8Miwf5yiqyOJVrGPM8e00U8KjvDNd3SCtwXI
         xoEn4iUB097woqRtmHTavUvyROUUVYi3uqD0cxV/W0gWiyG8x8S0Ia0a5nGY/TKBZ3I4
         n8Dg==
X-Received: by 10.66.140.39 with SMTP id rd7mr85537143pab.86.1451391103082;
        Tue, 29 Dec 2015 04:11:43 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id x75sm21100810pfi.95.2015.12.29.04.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:11:42 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:11:38 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283118>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index e9594d1..573ffa2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -648,9 +648,9 @@ static void receive_needs(void)
 			continue;
 		}
 		if (skip_prefix(line, "deepen ", &arg)) {
-			char *end;
+			char *end =3D NULL;
 			depth =3D strtol(arg, &end, 0);
-			if (end =3D=3D arg || depth <=3D 0)
+			if (!end || *end || depth <=3D 0)
 				die("Invalid deepen: %s", line);
 			continue;
 		}
--=20
2.3.0.rc1.137.g477eb31
