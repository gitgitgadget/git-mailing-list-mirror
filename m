From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/16] parse_object: keep sha1 even when parsing replaced one
Date: Sat, 31 Jul 2010 23:18:12 +0700
Message-ID: <1280593105-22015-4-git-send-email-pclouds@gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:38:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfORH-0002of-T3
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776Ab0HACiG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:38:06 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51622 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585Ab0HACiD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:38:03 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so976611pzk.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=J/shZhvjQDCyy6RD+sNuA17q8Lj76RXKZb22ERl4+EU=;
        b=XJRf+bGGDPjqGl8C3FhdnYMx4zMD+Hme35Ca2het0C2GWbhWEetpEPD6lnZBQcsO5g
         UebEgr0501leMea/Mj3EG5uJyjHn7EoLrhx7irXZZNLwUh1iGafXChLSiRUKD1//yo9n
         +z74rPvhCy9Qi3eI0uJFCGVq31xE5k8aqv1KM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=evdRe+FQUoCNNEUX9QUlRMY/Os54BgM3PZxSGBme+eXsgJPLB4PKqQ+bkLqHMaUzRA
         0LNHVEmGiruQIiSHYPFDH1+JACyP5E+vKTvpQZTmFhlRu9vswyZxHvXGE8zvj5+JLEHR
         HDG2J+qjnuAfE8Oj/fjaA5tDe0PwaRbE2/Zsw=
Received: by 10.114.75.17 with SMTP id x17mr4860379waa.86.1280630283159;
        Sat, 31 Jul 2010 19:38:03 -0700 (PDT)
Received: from dektop ([119.12.238.118])
        by mx.google.com with ESMTPS id q6sm7702227waj.10.2010.07.31.19.37.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:38:02 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 23:18:55 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152350>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 object.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/object.c b/object.c
index 277b3dd..7adfda7 100644
--- a/object.c
+++ b/object.c
@@ -199,7 +199,7 @@ struct object *parse_object(const unsigned char *sh=
a1)
 			return NULL;
 		}
=20
-		obj =3D parse_object_buffer(repl, type, size, buffer, &eaten);
+		obj =3D parse_object_buffer(sha1, type, size, buffer, &eaten);
 		if (!eaten)
 			free(buffer);
 		return obj;
--=20
1.7.1.rc1.69.g24c2f7
