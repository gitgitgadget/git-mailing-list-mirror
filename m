From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/21] fixup! index-pack: parse v4 header and dictionaries
Date: Wed, 11 Sep 2013 13:06:05 +0700
Message-ID: <1378879582-15372-5-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Sep 11 08:07:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdaI-000576-I4
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764Ab3IKGHV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:07:21 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:60910 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165Ab3IKGHU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:07:20 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so8743220pde.37
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=m7iFIlvcawkSDDPwz6Fv0pkEHc1xgJTPVaZ92chfpE0=;
        b=K2zA8AgJ7k7ivtvMhcd5HZRY8vnQW6lhahFOb/F4RIMdNUCkd0Z0f1daXdLbANccWf
         mVgtrNbVBIZNF4oJZeWCuIIl3S6Yoak7S5hbyukohYX9QM5dps7V6kB7Lt8WN9MseTNn
         Be8GpLZwt1qY7Yo1YU6fmAWbbMEFFacTivlLIHh8Guxh+YSyogxgZV1Vx+U0bHvxf4SP
         9XTqHbLAhJy0pMsdgx4TS1EjYfQw9EgHSYkxa6x/h2Ta+BAd49m2BtcKtspjnicFdDee
         DSWpRlQb04lUPIlbQQ4LSy1mwQsGk4SMDXO0Fp9rXBIG2mQ73Fg4+wyDmrs+t0r4twjD
         3hHQ==
X-Received: by 10.68.217.196 with SMTP id pa4mr18987493pbc.117.1378879639661;
        Tue, 10 Sep 2013 23:07:19 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id ye1sm1069957pab.19.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:07:19 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:07:12 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234528>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 empty pack case

 builtin/index-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8a6e2a3..89bc708 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1474,7 +1474,8 @@ static void parse_dictionaries(void)
 		return;
=20
 	sha1_table =3D xmalloc(20 * nr_objects_final);
-	hashcpy(sha1_table, fill_and_use(20));
+	if (nr_objects_final)
+		hashcpy(sha1_table, fill_and_use(20));
 	for (i =3D 1; i < nr_objects_final; i++) {
 		unsigned char *p =3D sha1_table + i * 20;
 		hashcpy(p, fill_and_use(20));
--=20
1.8.2.82.gc24b958
