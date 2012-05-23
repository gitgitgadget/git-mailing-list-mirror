From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 6/6] sha1_loose_object_info: do not complain out loud on non-existent objects
Date: Wed, 23 May 2012 21:09:51 +0700
Message-ID: <1337782191-10091-6-git-send-email-pclouds@gmail.com>
References: <1337172630-23679-1-git-send-email-pclouds@gmail.com>
 <1337782191-10091-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 16:14:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXCKu-0002uF-RX
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 16:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221Ab2EWOOn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 10:14:43 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59120 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab2EWOOm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 10:14:42 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so9808350dad.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 07:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tTvIXrs1Je7TFuJYN5US0IXJFY8ITWDIUvOC7ECYuz4=;
        b=U0+GoX6LzdhNDJTAFzyPRBCr4FkAOdVszGZlJPfd8vZAW+X6reTsu+UY2bs2nxl0gX
         VyUm5izRBVKiWg0wFIN2cxE3c2y2azrWC+GcqxVHGy0/kADDTrD/HpwtHKZGLon2ZOBZ
         5S9dQYaJ7GWWWkq5CuRvSyMqAuPgVe0OBAX2B0VsMQW8L164QtP1AJgQYeCi7yEeYHCA
         BrQBE13Usmz06v133Q+pGsiZ2kTuu+yFCpNqceKNxYKNe9TRhLUYJdZaTR1q0mP7fWmA
         89NfZER9OdXfXqEkCFPHyBWYVJFHzca44XpZD8490MmiVKD3U0Zgp1iDKQPFjOmuRqwN
         5DJg==
Received: by 10.68.225.170 with SMTP id rl10mr10938435pbc.13.1337782482598;
        Wed, 23 May 2012 07:14:42 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.52.77])
        by mx.google.com with ESMTPS id vp4sm1969187pbc.61.2012.05.23.07.14.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 May 2012 07:14:41 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 May 2012 21:10:44 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1337782191-10091-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198291>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 makes sense to me, but I might have overlooked something

 sha1_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index 3c4f165..520b41e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2133,6 +2133,8 @@ static int sha1_loose_object_info(const unsigned =
char *sha1, unsigned long *size
 	git_zstream stream;
 	char hdr[32];
=20
+	if (!has_loose_object(sha1))
+		return -1;
 	map =3D map_sha1_file(sha1, &mapsize);
 	if (!map)
 		return error("unable to find %s", sha1_to_hex(sha1));
--=20
1.7.10.2.549.g9354186
