From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/21] list-files: add -1 short for --no-column
Date: Sun,  8 Feb 2015 16:01:31 +0700
Message-ID: <1423386099-19994-14-git-send-email-pclouds@gmail.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:03:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNmI-0006F2-Gd
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755753AbbBHJDf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 04:03:35 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:42058 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708AbbBHJDb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:03:31 -0500
Received: by pdjz10 with SMTP id z10so6998339pdj.9
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KG36pcxrGY7j0hPRDBrP+ToMd2afn0mPchSHzrq+GTQ=;
        b=lJXzem4OAcB1qI3FPDHNZx9hETuAL+5lMgxfHYA9qi2Y0ZNrVsSJ31nxcZWR6cj78M
         NnZobTf1J2O/1Dpl3Iz8HdVJo60FhBdsx7lA/FfbSJhSM32a+8Vx0D0W9Jqgv2DxDzWu
         vxHyHhxPdVh1Do+TBEv1qPrACO/Aja6ROBw2uoXhR452ZBErVG4P+eyK8UWnZpsmrsPq
         2Gnuln3251EL2xNlLc6sagHn+ERABJpDpPjj5SZ4yICSJb7I9Ep0bkqYFcqBKNNpf4oz
         FQRDVo6R/fAEhnrTV+CmXDHvUfqnJuhv6wpUMaBY8+hEfuYXKfvNdD1iUMqAhgUZGoA5
         wM8w==
X-Received: by 10.70.25.4 with SMTP id y4mr3043254pdf.5.1423386210805;
        Sun, 08 Feb 2015 01:03:30 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id uc2sm12919942pbc.56.2015.02.08.01.03.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:03:30 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:03:38 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263500>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-list-files.txt | 3 +++
 builtin/ls-files.c               | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/git-list-files.txt b/Documentation/git-list-=
files.txt
index 8d285c1..1c0c877 100644
--- a/Documentation/git-list-files.txt
+++ b/Documentation/git-list-files.txt
@@ -50,6 +50,9 @@ OPTIONS
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
index adc31f6..62aa64f 100644
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
2.3.0.rc1.137.g477eb31
