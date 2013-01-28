From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 3/4] branch: give a more helpful message on redundant arguments
Date: Mon, 28 Jan 2013 08:18:15 +0700
Message-ID: <1359335896-24406-3-git-send-email-pclouds@gmail.com>
References: <1359118225-14356-1-git-send-email-pclouds@gmail.com>
 <1359335896-24406-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 02:19:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzdNu-0008TD-Dk
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 02:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757192Ab3A1BTH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jan 2013 20:19:07 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:53121 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757163Ab3A1BTE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 20:19:04 -0500
Received: by mail-pa0-f47.google.com with SMTP id fa10so1195358pad.6
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 17:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=EHUTuzGuA6f5U8rq+ROWraoMH1Z3RD4eAF4EBEvL8lY=;
        b=xlbmAM0jc59vCnipm9VINPW9OcMPWbBB5Udb2MsQzCOLPRuKaWj+z2Jqu8XCCESqHH
         Ks3nPUQif9AlNrhPL3sqDyNxfrnyKWJIx/MkPw0CzMXdB3O03sc+lIiO9Q3xrOutPdwD
         KIqoeR7drPWeLQjHqJdJf2OTn1t3fsMaglN8WJ6u5+0nczq7P+mvLDIN357MeZ3YmyjQ
         gYU8V3llja1JEBBTiAeie6NPuqQCPIiD43KSVQWQvWzlwvKG3kj/0bvTTG+vG3UYOAAc
         aQzdaaUMTIBxURLN4z95ZbATyGHN52HXqzA0lXwNpvQBvLRkrKQkPcH4sWLKe70zd45T
         b4dA==
X-Received: by 10.68.238.39 with SMTP id vh7mr33851016pbc.6.1359335944143;
        Sun, 27 Jan 2013 17:19:04 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id se8sm1864138pbb.69.2013.01.27.17.19.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 17:19:03 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 Jan 2013 08:18:38 +0700
X-Mailer: git-send-email 1.8.1.1.459.g5970e58
In-Reply-To: <1359335896-24406-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214776>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/branch.c  | 4 ++--
 t/t3200-branch.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 30c4545..ca61c5b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -859,7 +859,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 		} else if (argc =3D=3D 1)
 			branch_name =3D argv[0];
 		else
-			usage_with_options(builtin_branch_usage, options);
+			die(_("cannot edit description of more than one branch"));
=20
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
 		if (!ref_exists(branch_ref.buf)) {
@@ -881,7 +881,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 		else if (argc =3D=3D 2)
 			rename_branch(argv[0], argv[1], rename > 1);
 		else
-			usage_with_options(builtin_branch_usage, options);
+			die(_("too many branches for a rename operation"));
 	} else if (new_upstream) {
 		struct branch *branch =3D branch_get(argv[0]);
=20
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 80e6be3..f3e0e4a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -73,8 +73,8 @@ test_expect_success \
=20
 test_expect_success \
     'git branch -m dumps usage' \
-       'test_expect_code 129 git branch -m 2>err &&
-	test_i18ngrep "[Uu]sage: git branch" err'
+       'test_expect_code 128 git branch -m 2>err &&
+	test_i18ngrep "too many branches for a rename operation" err'
=20
 test_expect_success \
     'git branch -m m m/m should work' \
--=20
1.8.1.1.459.g5970e58
