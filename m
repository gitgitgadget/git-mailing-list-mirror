From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/6] upload-pack: remove unused variable "backup"
Date: Thu,  5 Mar 2015 17:28:12 +0700
Message-ID: <1425551295-28653-4-git-send-email-pclouds@gmail.com>
References: <70A3994196D94205B75660D9DEFF0A12@PhilipOakley>
 <1425551295-28653-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: philipoakley@iee.org
X-From: git-owner@vger.kernel.org Thu Mar 05 11:29:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTT1b-0003Z6-Tj
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 11:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbbCEK26 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2015 05:28:58 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:37812 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396AbbCEK2z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 05:28:55 -0500
Received: by paceu11 with SMTP id eu11so27604081pac.4
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 02:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ypL1ogIX4e8Q+9HqSWLIaRo4aKyeWhJBHgB/llIGpYo=;
        b=Ys9GqDL9K3WzspRKVIZcFt5DN1EmhZj+yT9lnBKxOkkasavPVMEHEQVIlh2IJW3vmN
         vzxOOrFoHg8lUKu+9J3jmS5c4lvfgsU38FAzHO8XDdTdUDNhdsJImro9/3JWFaBRHYhJ
         QTrqr1jZyxuunnLNPsJl3/4ctyp4Qt+IbZkfPvN8I1+oHS3kIKsBi+ts6WDvfGEmyHjc
         B+sZqbyqJRvyiLX0qE0OW1i1JYCFztTq5TBqYQFHb+rsS/hk3h/LG8Ar/FGzNPX2500+
         9oLBZ+sfGs8xMrHb02tQ0i7LihxOfdQtT72OiEYElYlEpLDegg40TB5F8czBhMl8wriO
         0WCA==
X-Received: by 10.68.248.74 with SMTP id yk10mr15023602pbc.26.1425551335274;
        Thu, 05 Mar 2015 02:28:55 -0800 (PST)
Received: from lanh ([115.73.230.115])
        by mx.google.com with ESMTPSA id om6sm6551445pdb.40.2015.03.05.02.28.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2015 02:28:54 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Mar 2015 17:29:26 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425551295-28653-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264822>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index ea030f3..79f5525 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -547,7 +547,7 @@ static void send_shallow(struct commit_list *result=
)
=20
 static void deepen(int depth, const struct object_array *shallows)
 {
-	struct commit_list *result =3D NULL, *backup =3D NULL;
+	struct commit_list *result =3D NULL;
 	int i;
 	if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
 		for (i =3D 0; i < shallows->nr; i++) {
@@ -555,11 +555,11 @@ static void deepen(int depth, const struct object=
_array *shallows)
 			object->flags |=3D NOT_SHALLOW;
 		}
 	else
-		backup =3D result =3D
+		result =3D
 			get_shallow_commits(&want_obj, depth,
 					    SHALLOW, NOT_SHALLOW);
 	send_shallow(result);
-	free_commit_list(backup);
+	free_commit_list(result);
 	for (i =3D 0; i < shallows->nr; i++) {
 		struct object *object =3D shallows->objects[i].item;
 		if (object->flags & NOT_SHALLOW) {
--=20
2.3.0.rc1.137.g477eb31
