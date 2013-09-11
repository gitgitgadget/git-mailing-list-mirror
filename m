From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/21] fixup! index-pack: record all delta bases in v4 (tree and ref-delta)
Date: Wed, 11 Sep 2013 13:06:06 +0700
Message-ID: <1378879582-15372-6-git-send-email-pclouds@gmail.com>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 08:07:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdaQ-0005Ho-Ml
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011Ab3IKGH3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:07:29 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:47016 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165Ab3IKGH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:07:27 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so8678324pdi.5
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=133h5KuBz9Mh7/EfUIcDW5c6ugYl7WBWzwV5as89pdE=;
        b=rHo9/mZjOJKx06v7uyub/aHyVETMYZUWmyli705E1EsQmnSimv+P25xhMJ0OtZ0rrw
         mE01a2IpSg63MHspF4ompwUbkzt3T4Ry43Fygmgu7rZ2DD+8XUcBB0+WhX92CT0cZc8k
         UxkDzTXzloHJ68evjKUlh8/tjI6ipthL3qoL9m+5HkLbPEZhKmJ4rK8RmNuOvLTT2/za
         96E8MosJAbQIkVLZBfBtTSKAnldmre736gubRSu7sCtLgFfmDjMnlrvmflahFlJh96WG
         s8jZB/+prhSD4Ql3oIiLWhOUAcQlhxKJGq0yClY62I6bupG5s6qlpMuZE5ZtiT2dOGaB
         YICw==
X-Received: by 10.68.181.132 with SMTP id dw4mr1285073pbc.179.1378879647172;
        Tue, 10 Sep 2013 23:07:27 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id bt1sm27466941pbb.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:07:26 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:07:20 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234529>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 compiler warning fix

 builtin/index-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 89bc708..1895adf 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -776,7 +776,7 @@ static void *unpack_raw_entry(struct object_entry *=
obj,
 	case OBJ_OFS_DELTA:
 		if (packv4)
 			die(_("pack version 4 does not support ofs-delta type (offset %lu)"=
),
-			    obj->idx.offset);
+			    (unsigned long)obj->idx.offset);
 		offset =3D obj->idx.offset - read_varint();
 		if (offset <=3D 0 || offset >=3D obj->idx.offset)
 			bad_object(obj->idx.offset,
--=20
1.8.2.82.gc24b958
