From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] attr.c: rename global var attr_nr to git_attr_nr
Date: Tue,  9 Dec 2014 20:53:22 +0700
Message-ID: <1418133205-18213-2-git-send-email-pclouds@gmail.com>
References: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 14:53:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyLEU-0001Wl-Pi
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 14:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030AbaLINxh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2014 08:53:37 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:37361 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbaLINxg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 08:53:36 -0500
Received: by mail-pa0-f44.google.com with SMTP id et14so589533pad.31
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 05:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=M6nHVd440/oi1DN4OichAcT1XcjOt9UEVJ5qrUmFJwc=;
        b=IkTDcdGYkCCFRWN81Cx2Z7j8bQOtNYLggo1OWNSF62FSYsKGOXKyf76g7DEGWxAbQp
         jYjSb2QLHeKeWktCcN7WoGzvMTSu6YWw/VtF47eiAVpXxaLMrCM++f+hiZos3ZdWkJuz
         KQeF/J39aVvWRpMwDujKz8XJd0/bjxULIgiOQNJn5tkYPRLeLf/Qkp8ms/1rTVW0dyxW
         CIzc2vNVArlt4VBWgnnMaVY0pitQZMUueCvdQ4+p57zv80UDcKj/szVcMRViZnhyqyHe
         nuw7X+Gu+mJL4vW14YmCp7c5/gNgAv0P5CgvKB5fin6SK2jRzb2RVkcZwC3LxqxWwjxv
         5Vrg==
X-Received: by 10.70.88.164 with SMTP id bh4mr3740872pdb.96.1418133215892;
        Tue, 09 Dec 2014 05:53:35 -0800 (PST)
Received: from lanh ([115.73.216.238])
        by mx.google.com with ESMTPSA id fu1sm1555740pbb.91.2014.12.09.05.53.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Dec 2014 05:53:35 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 09 Dec 2014 20:53:32 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261122>

This name "attr_nr" is used elsewhere as local variable, shadowing the
global one. Let's rename the global one into something else to avoid
accidents due to shadow in future.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/attr.c b/attr.c
index cd54697..583d36a 100644
--- a/attr.c
+++ b/attr.c
@@ -34,7 +34,7 @@ struct git_attr {
 	int attr_nr;
 	char name[FLEX_ARRAY];
 };
-static int attr_nr;
+static int git_attr_nr;
=20
 static struct git_attr_check *check_all_attr;
 static struct git_attr *(git_attr_hash[HASHSIZE]);
@@ -94,10 +94,10 @@ static struct git_attr *git_attr_internal(const cha=
r *name, int len)
 	a->name[len] =3D 0;
 	a->h =3D hval;
 	a->next =3D git_attr_hash[pos];
-	a->attr_nr =3D attr_nr++;
+	a->attr_nr =3D git_attr_nr++;
 	git_attr_hash[pos] =3D a;
=20
-	REALLOC_ARRAY(check_all_attr, attr_nr);
+	REALLOC_ARRAY(check_all_attr, git_attr_nr);
 	check_all_attr[a->attr_nr].attr =3D a;
 	check_all_attr[a->attr_nr].value =3D ATTR__UNKNOWN;
 	return a;
@@ -730,10 +730,10 @@ static void collect_all_attrs(const char *path)
 	}
=20
 	prepare_attr_stack(path, dirlen);
-	for (i =3D 0; i < attr_nr; i++)
+	for (i =3D 0; i < git_attr_nr; i++)
 		check_all_attr[i].value =3D ATTR__UNKNOWN;
=20
-	rem =3D attr_nr;
+	rem =3D git_attr_nr;
 	for (stk =3D attr_stack; 0 < rem && stk; stk =3D stk->prev)
 		rem =3D fill(path, pathlen, basename_offset, stk, rem);
 }
@@ -762,7 +762,7 @@ int git_all_attrs(const char *path, int *num, struc=
t git_attr_check **check)
=20
 	/* Count the number of attributes that are set. */
 	count =3D 0;
-	for (i =3D 0; i < attr_nr; i++) {
+	for (i =3D 0; i < git_attr_nr; i++) {
 		const char *value =3D check_all_attr[i].value;
 		if (value !=3D ATTR__UNSET && value !=3D ATTR__UNKNOWN)
 			++count;
@@ -770,7 +770,7 @@ int git_all_attrs(const char *path, int *num, struc=
t git_attr_check **check)
 	*num =3D count;
 	*check =3D xmalloc(sizeof(**check) * count);
 	j =3D 0;
-	for (i =3D 0; i < attr_nr; i++) {
+	for (i =3D 0; i < git_attr_nr; i++) {
 		const char *value =3D check_all_attr[i].value;
 		if (value !=3D ATTR__UNSET && value !=3D ATTR__UNKNOWN) {
 			(*check)[j].attr =3D check_all_attr[i].attr;
--=20
2.2.0.84.ge9c7a8a
