From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] i18n: leave \n out of translated diffstat
Date: Sun, 24 Jun 2012 19:41:31 +0700
Message-ID: <1340541692-10834-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 14:46:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SimCo-0004M0-RL
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 14:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209Ab2FXMqP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jun 2012 08:46:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39734 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416Ab2FXMqO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2012 08:46:14 -0400
Received: by dady13 with SMTP id y13so4187920dad.19
        for <git@vger.kernel.org>; Sun, 24 Jun 2012 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=FUpmGKnJdolU5klZK7NVZo0b/ATtsgCmf/6Ys8qJrWg=;
        b=Ad7G+24MsjTNdP8hLi8dG3tQZB5nS7XEzlC040kYoRsceMNlfHF5SZ2yWPNYznP933
         Ibsf0jNVcuel2wgp0dfA4iADJevdhrbKZh0LJfvAit/WwIhMBRSC9gjAInwKC3j/O2lh
         QQeqECXqRSAmhk72C+75HjcqxgyfKBlcUt0qv4lYaBijDFoRhnOKYri7aM8FT7PiZSVr
         S6Ia85vLGG85yud+yIuZm2a6repMVt0P91F3wQQ2OBDJNiOmVP/gRRLX1frA2w3b7ODa
         Stq5DkpW4CyQQtyohohREwm7pR5tp0WJYUJjHawF0VTig9dbG3SCSbeQsMURPYoE3lCf
         aIZg==
Received: by 10.68.229.2 with SMTP id sm2mr29602278pbc.57.1340541974073;
        Sun, 24 Jun 2012 05:46:14 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.50.32])
        by mx.google.com with ESMTPS id qp9sm5272558pbc.9.2012.06.24.05.46.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jun 2012 05:46:13 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Jun 2012 19:41:32 +0700
X-Mailer: git-send-email 1.7.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200526>

GETTEXT_POISON scrapes everything in translated strings, including \n.
t4205.12 however needs this \n in matching the end result. Keep this
\n out of translation to make t4205.12 happy.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 1a594df..923b6aa 100644
--- a/diff.c
+++ b/diff.c
@@ -1397,7 +1397,7 @@ int print_stat_summary(FILE *fp, int files, int i=
nsertions, int deletions)
=20
 	if (!files) {
 		assert(insertions =3D=3D 0 && deletions =3D=3D 0);
-		return fputs(_(" 0 files changed\n"), fp);
+		return fprintf(fp, "%s\n", _(" 0 files changed"));
 	}
=20
 	strbuf_addf(&sb,
--=20
1.7.8
