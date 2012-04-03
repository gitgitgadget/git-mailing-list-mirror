From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] parse_commit_buffer: rename a confusing variable name
Date: Tue,  3 Apr 2012 13:55:07 +0700
Message-ID: <1333436109-16526-2-git-send-email-pclouds@gmail.com>
References: <53707c0a-3782-47a4-8a35-da7136ff4822@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 08:56:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SExf3-0004Di-7I
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 08:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772Ab2DCG4I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Apr 2012 02:56:08 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52178 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab2DCG4H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 02:56:07 -0400
Received: by pbcun15 with SMTP id un15so5260485pbc.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 23:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ayQecsj/iPYIvmGcts3xzSr0ArV4ljMpYdEtGw+yhgQ=;
        b=uReeqJfqP5TDkxUqcPdxAqj1lhYruMvQfEon/jF/KhY1+AHzKRMBu+qBjAQT7G8mV4
         FEJBFk7pTf1FE7k1BHP5rqq7v7OhrUc/rIcBl/d2dxzsKdQOSipRKEis6kJnf6uFuXE8
         fHQ776hLvr0JtKIy3lLsmKvxqzx+FqN5gJRSTQp+/ctTGpB2u/HZOwv3f9Nq3BBr8TbM
         u7gnC2KYuRTBGXT0hyx4nagG3mpYuZjs36qFmT3Wk/i/XvgDyXZEDUJUnjTazJ67en81
         DBcWsYQLcf1N1E+mt1KoLiNDM9LsLFqkyrBa5h+ksuC+S9+K2jQxe9BNG6dPhwmVp6GJ
         D01g==
Received: by 10.68.129.74 with SMTP id nu10mr26312866pbb.157.1333436165588;
        Mon, 02 Apr 2012 23:56:05 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id f8sm15684898pbe.42.2012.04.02.23.56.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 Apr 2012 23:56:04 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 03 Apr 2012 13:55:22 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <53707c0a-3782-47a4-8a35-da7136ff4822@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194597>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index 4b39c19..946ea70 100644
--- a/commit.c
+++ b/commit.c
@@ -252,7 +252,7 @@ int parse_commit_buffer(struct commit *item, const =
void *buffer, unsigned long s
 {
 	const char *tail =3D buffer;
 	const char *bufptr =3D buffer;
-	unsigned char parent[20];
+	unsigned char sha1[20];
 	struct commit_list **pptr;
 	struct commit_graft *graft;
=20
@@ -262,10 +262,10 @@ int parse_commit_buffer(struct commit *item, cons=
t void *buffer, unsigned long s
 	tail +=3D size;
 	if (tail <=3D bufptr + 46 || memcmp(bufptr, "tree ", 5) || bufptr[45]=
 !=3D '\n')
 		return error("bogus commit object %s", sha1_to_hex(item->object.sha1=
));
-	if (get_sha1_hex(bufptr + 5, parent) < 0)
+	if (get_sha1_hex(bufptr + 5, sha1) < 0)
 		return error("bad tree pointer in commit %s",
 			     sha1_to_hex(item->object.sha1));
-	item->tree =3D lookup_tree(parent);
+	item->tree =3D lookup_tree(sha1);
 	bufptr +=3D 46; /* "tree " + "hex sha1" + "\n" */
 	pptr =3D &item->parents;
=20
@@ -274,7 +274,7 @@ int parse_commit_buffer(struct commit *item, const =
void *buffer, unsigned long s
 		struct commit *new_parent;
=20
 		if (tail <=3D bufptr + 48 ||
-		    get_sha1_hex(bufptr + 7, parent) ||
+		    get_sha1_hex(bufptr + 7, sha1) ||
 		    bufptr[47] !=3D '\n')
 			return error("bad parents in commit %s", sha1_to_hex(item->object.s=
ha1));
 		bufptr +=3D 48;
@@ -284,7 +284,7 @@ int parse_commit_buffer(struct commit *item, const =
void *buffer, unsigned long s
 		 */
 		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
 			continue;
-		new_parent =3D lookup_commit(parent);
+		new_parent =3D lookup_commit(sha1);
 		if (new_parent)
 			pptr =3D &commit_list_insert(new_parent, pptr)->next;
 	}
--=20
1.7.3.1.256.g2539c.dirty
