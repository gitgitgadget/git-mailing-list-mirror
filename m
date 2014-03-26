From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 13/17] ls: add -1 short for --no-column in the spirit of GNU ls
Date: Wed, 26 Mar 2014 20:48:13 +0700
Message-ID: <1395841697-11742-14-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 14:49:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSoCc-0000Xr-H0
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 14:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834AbaCZNtF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 09:49:05 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:41373 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178AbaCZNtD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 09:49:03 -0400
Received: by mail-pd0-f176.google.com with SMTP id r10so1888345pdi.7
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 06:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=n/YmqTY4OJtO//ERZJtJO4lks7fXrwxTvOVmRGEGigE=;
        b=tIWrxXzM6exmjBZJGNDIKtoFyWnEeG48ztT67dKo+GMQ8/vLNmkfSHM94eD+N0S139
         HQO+fUtn/uLjm8otGGKwukTGkc+5dgl17FctGWNvcD1z25n1JDVBQqp4cr/T6IFICPg+
         cReCgL1OHJxm9DffoM3cZ9ni96HUDhRuXyAqkxXtU3/T4llpC54kB4tw3PDRJEGKhhH1
         j7DtnOCUObO9e0FipNxXmz/ThYGJxyC00ZzniKXNGl+lVUjOxT/nfBDp7QHbfAsuD2Pd
         fecYXaF4cctcKF46bAB72wFpSH40Uv5d1WakxghOPzWIOBjIfeC/NfOImFPhuGBdA/mb
         5ieA==
X-Received: by 10.67.5.233 with SMTP id cp9mr4752466pad.147.1395841743407;
        Wed, 26 Mar 2014 06:49:03 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id qw8sm58544614pbb.27.2014.03.26.06.49.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 06:49:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 26 Mar 2014 20:49:56 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245192>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-ls.txt | 3 +++
 builtin/ls-files.c       | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/git-ls.txt b/Documentation/git-ls.txt
index 10df6b0..0480c42 100644
--- a/Documentation/git-ls.txt
+++ b/Documentation/git-ls.txt
@@ -51,6 +51,9 @@ OPTIONS
 --recursive::
 	Equivalent of --max-depth=3D-1 (infinite recursion).
=20
+-1::
+	Equivalent of --no-column.
+
 --color[=3D<when>]::
 	Color file names. The value must be always (default), never,
 	or auto.
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 772a6ce..014de05 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -729,6 +729,8 @@ int cmd_ls(int argc, const char **argv, const char =
*cmd_prefix)
 			    N_("shortcut for --max-depth=3D-1"), -1),
 		OPT__COLOR(&use_color, N_("show color")),
 		OPT_COLUMN(0, "column", &colopts, N_("show files in columns")),
+		OPT_SET_INT('1', NULL, &colopts,
+			    N_("shortcut for --no-column"), COL_PARSEOPT),
 		{ OPTION_INTEGER, 0, "max-depth", &max_depth, N_("depth"),
 			N_("descend at most <depth> levels"), PARSE_OPT_NONEG,
 			NULL, 1 },
--=20
1.9.1.345.ga1a145c
