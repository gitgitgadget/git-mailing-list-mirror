From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/6] worktree: make core.sparseCheckout and core.ignoreStat per-worktree
Date: Sun, 27 Dec 2015 10:14:37 +0700
Message-ID: <1451186079-6119-5-git-send-email-pclouds@gmail.com>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
 <1451186079-6119-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@drmicha.warpmail.net, max@max630.net, Jens.Lehmann@web.de,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 04:15:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aD1nq-0003YR-K7
	for gcvg-git-2@plane.gmane.org; Sun, 27 Dec 2015 04:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbbL0DPV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2015 22:15:21 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33251 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509AbbL0DPR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 22:15:17 -0500
Received: by mail-pa0-f44.google.com with SMTP id cy9so93826805pac.0
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 19:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3FGMoiukSDZL+tS4689d+c+iQF79DtYX63KyD0LLn5k=;
        b=1IL2R0uBNGw9mBTLdjJbvZA5gbKJCNopScWRMYGqrkL3tQ3xmVgssFyyTbiIJJqLsQ
         b9a/Zb5pb98vAQbqmyZet2JoupVAfA9yqrCxKyF1R/xxqqbIf4DM09WaesEmwnOGY/4q
         qvqLZBTJevWdZzqCbhpR+IGb9OITwz0h9gjv1IP6BIy/fDhljn9rzAXia8f+H0Ds8MJE
         rXB1no5PYBZ7zRgBTyMM4Y2LZZ+d3L6M3jbDbGAfqiohfxniGn1ohIYVWH1OdC6eAZao
         KbQK1QJ21hh1tZC0UvVEDwvQAbbfHnkub4d7Sh4Scdb27U6GdcygU1zaBiTTFtKmHNIY
         uvYw==
X-Received: by 10.66.192.42 with SMTP id hd10mr67850218pac.111.1451186117549;
        Sat, 26 Dec 2015 19:15:17 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id ud10sm72722421pab.27.2015.12.26.19.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Dec 2015 19:15:16 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 27 Dec 2015 10:15:23 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283012>

The first one must be per-worktree because info/sparse-checkout
already is. The second one shares the same nature and should also be
per-worktree.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt                 | 2 +-
 Documentation/technical/repository-version.txt | 2 +-
 config.c                                       | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 087b35e..bc6a26e 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -157,7 +157,7 @@ $GIT_COMMON_DIR/worktrees/X/config. Even though per=
-working tree
 variables for the main working tree are in the default config place,
 they are invisible from all linked working trees. The following
 configuration variables are per working directory:
-core.bare, core.worktree.
+core.bare, core.ignorestat, core.sparsecheckout, core.worktree.
=20
 LIST OUTPUT FORMAT
 ------------------
diff --git a/Documentation/technical/repository-version.txt b/Documenta=
tion/technical/repository-version.txt
index fc2cdb9..4fc113b 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -94,4 +94,4 @@ Define behavior in multiple worktree setup. The value=
 specifies the
 version. Default version is zero.
=20
 In version 1, the following config variables are per-worktree:
-core.bare, core.worktree.
+core.bare, core.ignorestat, core.sparsecheckout, core.worktree.
diff --git a/config.c b/config.c
index c2ea91b..5aa1379 100644
--- a/config.c
+++ b/config.c
@@ -49,6 +49,8 @@ static int zlib_compression_seen;
=20
 static struct config_pattern worktree_v1[] =3D {
 	{ 0, 0, "core.bare" },
+	{ 0, 0, "core.ignorestat" },
+	{ 0, 0, "core.sparsecheckout" },
 	{ 0, 0, "core.worktree" },
 	{ 0, 0, NULL }
 };
--=20
2.3.0.rc1.137.g477eb31
