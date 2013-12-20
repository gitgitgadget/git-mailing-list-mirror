From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] daemon: be strict at parsing parameters --[no-]informative-errors
Date: Fri, 20 Dec 2013 17:53:52 +0700
Message-ID: <1387536832-650-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 20 11:57:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtxlY-0003pK-Or
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 11:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859Ab3LTK5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Dec 2013 05:57:08 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:59859 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab3LTK5G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 05:57:06 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so2448483pbb.31
        for <git@vger.kernel.org>; Fri, 20 Dec 2013 02:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=fGWfpF8P6yoYDpPckbsaA+xUaB+BG/kEdrd6VqIIvNo=;
        b=oy7BTfcTj5OVLIhQmVjpMX2aS0ZqfqOqI+O6b+4aCTjykPKxRGkVEhEmKEUXTIgEAO
         90cQgl4yXK0/fW3QdLZBD1qoHnElzw1xJm5pHbApjAT6bODa+hj2pNUP8ZK4p8momZ1Q
         sUoE7LWUBS5La4XaVAGUUWHT5gy5b9z+aQxSfunas64fGMElPspNKks5h4UGpfITiSel
         MCQzSK62y8Gp0czWlsMwQnPHF2VhRI13+OJFES0Cxpw4acb+JHQZHsOOT8LZb8jv6EDN
         wp0QmXItuv1NC9ciJMdvSa1wfWPayYWPdbnngrcUU9lh5XNJITMLQJStZcQm+Y1PfcmZ
         VwWQ==
X-Received: by 10.66.25.100 with SMTP id b4mr7740307pag.24.1387537026146;
        Fri, 20 Dec 2013 02:57:06 -0800 (PST)
Received: from lanh ([115.73.203.37])
        by mx.google.com with ESMTPSA id ik1sm13592276pbc.9.2013.12.20.02.57.02
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Dec 2013 02:57:05 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 20 Dec 2013 17:57:06 +0700
X-Mailer: git-send-email 1.8.5.1.208.g019362e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239570>

Use strcmp() instead of starts_with() to stop accepting
--informative-errors-just-a-little

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 daemon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index 7bee953..503e039 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1278,11 +1278,11 @@ int main(int argc, char **argv)
 			make_service_overridable(arg + 18, 0);
 			continue;
 		}
-		if (starts_with(arg, "--informative-errors")) {
+		if (!strcmp(arg, "--informative-errors")) {
 			informative_errors =3D 1;
 			continue;
 		}
-		if (starts_with(arg, "--no-informative-errors")) {
+		if (!strcmp(arg, "--no-informative-errors")) {
 			informative_errors =3D 0;
 			continue;
 		}
--=20
1.8.5.1.208.g019362e
