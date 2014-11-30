From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/19] list-files: add -1 short for --no-column
Date: Sun, 30 Nov 2014 15:56:00 +0700
Message-ID: <1417337767-4505-13-git-send-email-pclouds@gmail.com>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:58:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv0KN-00036Q-E5
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbaK3I5z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:57:55 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:61318 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbaK3I5z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:57:55 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so9127344pab.35
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XUweYjUEvieAzTeWh/VdJ42DNu90jO8j0BAyPmKgugg=;
        b=F3wduFodsNNiXJuhCTgNvaQRWoighP5U5m0kjk2A6xllNVThjkqSXRKDaXuPi6c6j1
         udXr6NZ3DCU4ue4UUFIJXxNW8CXyWXt2/KdLE0R1vNf4VzmIsphEZRluaEIVeMEubyi2
         p/PM8tTlGitZ/2q3b6AZG8Lbd0zVRSG00LGCRtBJI4+K3ESzjdp8Du6h6M1upXK1AOmF
         k0cfciFKSlKiBnrkfuJ55CvemtF34ewq1nx8tG/HjYrF249QmLINFakulgBKLfkPek0E
         E0w2+9cBAXNUWAXeSCqzH4+snrGroorrK5DRBEZKu4IvLRoxU2hFTVwf23i8FynvmWNO
         bXyg==
X-Received: by 10.66.119.105 with SMTP id kt9mr88324529pab.113.1417337874793;
        Sun, 30 Nov 2014 00:57:54 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id hj2sm14294662pbc.69.2014.11.30.00.57.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:57:54 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:57:52 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260435>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-list-files.txt | 3 +++
 builtin/ls-files.c               | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/git-list-files.txt b/Documentation/git-list-=
files.txt
index 5dccbbc..725a236 100644
--- a/Documentation/git-list-files.txt
+++ b/Documentation/git-list-files.txt
@@ -49,6 +49,9 @@ OPTIONS
 --recursive::
 	Equivalent of `--max-depth=3D-1` (infinite recursion).
=20
+-1::
+	Equivalent of --no-column.
+
 --color[=3D<when>]::
 --no-color::
 	Color file names. The value must be `always`, `never`, or
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d0d39bd..be9a39c 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -603,6 +603,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 			N_("show unmerged files")),
 		OPT__COLOR(&use_color, N_("show color")),
 		OPT_COLUMN(0, "column", &colopts, N_("show files in columns")),
+		OPT_SET_INT('1', NULL, &colopts,
+			    N_("shortcut for --no-column"), COL_PARSEOPT),
 		{ OPTION_INTEGER, 0, "max-depth", &max_depth, N_("depth"),
 			N_("descend at most <depth> levels"), PARSE_OPT_NONEG,
 			NULL, 1 },
--=20
2.2.0.60.gb7b3c64
