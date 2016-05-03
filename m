From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 21/41] credential-cache--daemon.c: use warning_errno()
Date: Tue,  3 May 2016 19:03:54 +0700
Message-ID: <1462277054-5943-22-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:08:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ7z-0000dk-8N
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805AbcECMI3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:08:29 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35973 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932545AbcECMI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:08:27 -0400
Received: by mail-pf0-f176.google.com with SMTP id c189so9678452pfb.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8KpiPtnYMV+UpotVKa/Dy5aIZrExOkIAmVS6xXS605w=;
        b=ipMTPzDlQf1thXUj3d7pYF1BvLAqEVNxx7/RdWUbW+uSMt/DRS0QPsDyhu5lPwtrsW
         6JG6UeANelWNZIm42O7dfBKDkAl6kSyd1Dy8gurdPzG3swz/HIYZbEhSCdnFESrTt7EH
         NajTJikm/x+FrUgsuef/gOgiuMpy78hgYBHlpAuuN/wy1mxsxyFsHPyIi2RduISZEbw5
         euGs3A9IBJzvHptxWaVWEX8QmYo1l4fyAduEyTguwKUYnXdOVbs5SWo0mqqo0wiKPOsr
         ioIeKkxrSF9rvaQJH/YCbmW10Heba9R0L9iuCXd+TDMUM2CHLVkG6o+5+MdpTxTm0hgN
         wO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KpiPtnYMV+UpotVKa/Dy5aIZrExOkIAmVS6xXS605w=;
        b=SaihDqASKhpYzr9nQ7EHthv3YwNoOuMW4eUoD0wTWWgJ6oga4EjOHD3at8VSPz83te
         uqfnacBbvystg6cZnQXDCnSZxha6NoPPR/KRK3DFcrw2o+NNo4O0QGEjZaXUvAr8tSRR
         dLrGIF0FdOhh5EBsHWVOB5iEub/2tY8nwCIN6BK+BZ3SnYRuY1b4XXAVf/EmZDwpqISV
         PzljP3iYznLomWXdjspLgW+WIX4wrOEkVXDSVceYD4gg54f/XlAFMjjg3nq61NgbPAqx
         Z6AJwNoroa+FVgWH3MxKq2uCejtilesihuMGc0ryYtcJ5r208qlT9hpcShTh2plJG40p
         0HLg==
X-Gm-Message-State: AOPr4FV09+Ax/1yVPAKKi+aJOPVntv6JLprmPTXcsyWkGpifRlKCACmJsU0Yg6shop5m5w==
X-Received: by 10.98.51.2 with SMTP id z2mr2922066pfz.118.1462277302150;
        Tue, 03 May 2016 05:08:22 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id we8sm5495584pac.29.2016.05.03.05.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:08:21 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:08:18 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293374>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 credential-cache--daemon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 291c0fd..1f14d56 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -179,12 +179,12 @@ static int serve_cache_loop(int fd)
=20
 		client =3D accept(fd, NULL, NULL);
 		if (client < 0) {
-			warning("accept failed: %s", strerror(errno));
+			warning_errno("accept failed");
 			return 1;
 		}
 		client2 =3D dup(client);
 		if (client2 < 0) {
-			warning("dup failed: %s", strerror(errno));
+			warning_errno("dup failed");
 			close(client);
 			return 1;
 		}
--=20
2.8.0.rc0.210.gd302cd2
