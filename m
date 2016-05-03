From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 31/41] reachable.c: use error_errno()
Date: Tue,  3 May 2016 19:04:04 +0700
Message-ID: <1462277054-5943-32-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:09:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ8t-00018V-E0
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933104AbcECMJ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:09:27 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34849 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbcECMJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:09:26 -0400
Received: by mail-pa0-f49.google.com with SMTP id iv1so8875886pac.2
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sptAnTVgqTWhli92LdRfu18uo8C7gDdNccorqSAaOVE=;
        b=CIOuKTdB+LcCb9chSgZ/nCZP3SwAQ9SGUJrz4lH3P5yPRIUDF9jS4aTceDp+T7W/63
         NnaU8/H+4PczXf668zzHeIdd1/HXcy7Q0+OQepHnbcZ9EN/tU/z9bDrZXX0pOf7wULjH
         R153a1FksjRY6XlrrDLSDYKVAJuBNZc70UlaEQKpclAu0C5jVppA3/KiVbnLS05McO5L
         YN8JXuitwgFPRfLbjtsJGqo4VhvtQKy6WnnQNJvlOjKWUetntmA6q4IJ51s/EoNcZxtD
         WtAHyrU488JS994Zo4I/aYtHoT9RDDrzHHJzqJ6/pSu5YIRWETzoQhBXrkZxTNtHalzs
         0HJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sptAnTVgqTWhli92LdRfu18uo8C7gDdNccorqSAaOVE=;
        b=d5R8N4BXQcNnFmTFlPBalLjcTg0pZdauVgPhPWhHw3UGWr0qjbflTHY75AkwX+oQgY
         5gPk+d5W0acniPpjVBKdme1+mNK8t4eC1aTsG8XXB1LumIZwoF1V3ri68rb/OFxeza5M
         ao11VT5PJ6HbgPrcw6JQH2J99rGor0iKEzCUhbCmnujBL50tIEDPuOGgBNwD8sBX0pbw
         zBZZBCydjqpdwCu99t3id6iQfFwW0ULE/K2BEYIT5n2TIt81fcLv14/W5Ghuc3AaM87A
         TLzct4QT1Sq7xhSK+mIs0RRloiSwv5F4UqQ5eCcTIr3pSQCM1bU9Q+mEhKSZ23Oz85Uj
         rNIw==
X-Gm-Message-State: AOPr4FV2Qy03NVFppKrqz2hH45dJddhQIiGfKO4HB6RQk3MXhaYGHdDmY9q7ZJCIXnmdFg==
X-Received: by 10.66.160.201 with SMTP id xm9mr2896600pab.68.1462277365698;
        Tue, 03 May 2016 05:09:25 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id d78sm5507273pfb.59.2016.05.03.05.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:09:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:09:21 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293384>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 reachable.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/reachable.c b/reachable.c
index ed35201..d0199ca 100644
--- a/reachable.c
+++ b/reachable.c
@@ -119,8 +119,7 @@ static int add_recent_loose(const unsigned char *sh=
a1,
 		 */
 		if (errno =3D=3D ENOENT)
 			return 0;
-		return error("unable to stat %s: %s",
-			     sha1_to_hex(sha1), strerror(errno));
+		return error_errno("unable to stat %s", sha1_to_hex(sha1));
 	}
=20
 	add_recent_object(sha1, st.st_mtime, data);
--=20
2.8.0.rc0.210.gd302cd2
