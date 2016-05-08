From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 11/41] builtin/rm.c: use warning_errno()
Date: Sun,  8 May 2016 16:47:31 +0700
Message-ID: <1462700881-25108-12-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:52:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLLP-0000PO-JK
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbcEHJtj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:49:39 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33471 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbcEHJti (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:49:38 -0400
Received: by mail-pa0-f65.google.com with SMTP id gh9so13694754pac.0
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XTxHNwwR5+3Clj3Ar2DU5h7rjy7NA6mTMeVsLn2uzUY=;
        b=jkksDslC+IE6YhqvsFI02TzBe9OO212U7il6wfep9NpR4Lc/iKaO8ZyeZJN/+la1mA
         SkgsYk5qyKgrRQn/D4y2n+kfybmCVvYCLZycVy9G83bUtbrPgwxkoVwW93xB6Xh09rUT
         ByMIiFZQTVn8l6PziS1sfbNMfNu6v8vmDX2RZuCX3BPU3NIdmaZ2irfvbJ0wh6aHaD7Y
         x/08QBaxs9tRuvlh909u4p3mz9ZMKTsGvhx5gTpmMFgb8dr9vqqhuzFfM7FYJaA5/I6k
         2xjVcu8rgjQz9MXvssIa9jyM9NIs1LS0XweXUYuh7YlDkkub9OQ4SB1rCUTaiMyXSlQD
         pbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XTxHNwwR5+3Clj3Ar2DU5h7rjy7NA6mTMeVsLn2uzUY=;
        b=ewIGeLl8UiiZjUSgdIKfB0k8AfXnlvPysz8OEFrOecLQHEZzHs6gHDPw7jOrmpUu7G
         E+WIK5Q9JawLzr0VA07Zhmt6MUNEnUcS7LtG729WXbvGsiw28lf62Ysd6oz8SGyDz/GA
         ZyJ9XMJYH5XeM4ren35jHZ6r5h6+FYLxdwAIGd5WqZIa6d15UvjiwIxQLJXLUl2Z/gWR
         OiAeZjuTymemm3mRXEfvbmv47oXo8VW+Izrl0EWm7ANAav3TP/+4vh6Y8rfUblpCdLZi
         LJZZmFxHHsNMJwnyC6JKQS+SnGc55T98h4jZvlhUxqL/NJ9/oKRLIj2RRiCsCOwik5rp
         QvlQ==
X-Gm-Message-State: AOPr4FWExNsgyCL2vnLz1q8cUHx6i/I509MA7mAlhUj3A7yDd6Idjl8D5q1B3FpUzUKj9Q==
X-Received: by 10.66.90.196 with SMTP id by4mr42064490pab.117.1462700977380;
        Sun, 08 May 2016 02:49:37 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id z9sm1901021pfa.84.2016.05.08.02.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:49:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:49:37 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293943>

While at there, improve the message a bit (what operation failed?) and
mark it for translation since the format string is now a sentence.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 8829b09..fd47d20 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -152,7 +152,7 @@ static int check_local_mod(unsigned char *head, int=
 index_only)
=20
 		if (lstat(ce->name, &st) < 0) {
 			if (errno !=3D ENOENT && errno !=3D ENOTDIR)
-				warning("'%s': %s", ce->name, strerror(errno));
+				warning_errno(_("failed to stat '%s'"), ce->name);
 			/* It already vanished from the working tree */
 			continue;
 		}
--=20
2.8.0.rc0.210.gd302cd2
