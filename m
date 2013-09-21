From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/17] fixup! index-pack: record all delta bases in v4 (tree and ref-delta)
Date: Sat, 21 Sep 2013 20:57:47 +0700
Message-ID: <1379771883-10278-2-git-send-email-pclouds@gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:55:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNeH-00083I-Mk
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103Ab3IUNyy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:54:54 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:55214 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab3IUNys (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:54:48 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so1481588pdj.31
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TUoYPPkcMoIHJZZV5WrJW0Ns0nqrmfXxQgxHjzlLxr4=;
        b=KfDg2Jqt1nGSTdOr/ti31LmVck8yZyIYGvBN7gJMv/YFljzdCEsWCPPMq01QN+d0MS
         wArZ49dwB+4ILTweBVpd70+NHOfAONgrfHDBWsZMy+iYqV9AeG0k/tugcYaUqRcd+aGa
         YRFCOBg3rkEtOX9vP6htrN0Hf5VOoih8uvNSP0T07Us8nwVW7xyIsnSYohjPvFreSZaA
         O62ilxut2deBs3HIsvW2YAYw5BZhXQP7Saa8UCQJulhB7AQQe/vDgzA7nxOjmlORe4e0
         yEeNIkVxlvOM4JncNNlWxqpZIPxRSfRQhRfOUDSYhvd9LZs0zco5o0uEstRluJt274o/
         I0lQ==
X-Received: by 10.67.4.197 with SMTP id cg5mr14442800pad.10.1379771688237;
        Sat, 21 Sep 2013 06:54:48 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id ye1sm25678298pab.19.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:54:47 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:58:11 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235103>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f071ed9..fbf97f0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -775,8 +775,8 @@ static void *unpack_raw_entry(struct object_entry *=
obj,
 		break;
 	case OBJ_OFS_DELTA:
 		if (packv4)
-			die(_("pack version 4 does not support ofs-delta type (offset %lu)"=
),
-			    (unsigned long)obj->idx.offset);
+			bad_object(obj->idx.offset,
+				   _("pack version 4 does not support ofs-delta type"));
 		offset =3D obj->idx.offset - read_varint();
 		if (offset <=3D 0 || offset >=3D obj->idx.offset)
 			bad_object(obj->idx.offset,
--=20
1.8.2.83.gc99314b
