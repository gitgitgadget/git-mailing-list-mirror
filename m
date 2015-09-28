From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] ls-remote.txt: delete unsupported option
Date: Mon, 28 Sep 2015 19:30:17 +0700
Message-ID: <1443443417-20235-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 28 14:30:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgXZB-0003sj-3i
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 14:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757157AbbI1M34 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Sep 2015 08:29:56 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32785 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756727AbbI1M3z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 08:29:55 -0400
Received: by pacex6 with SMTP id ex6so173730335pac.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 05:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=gvXS08AMSCThvyND83HMEhGYOzKxifhH9RTRvai8fdQ=;
        b=v64m0EZnLvD8qulrt6KYArLIs4+Zo9jzmL2zylGB9CTjmM73C9jjBytqg3bonSsP7h
         nLiG85FyPHuS7d6fXy+181VO1hwWGCwxXGZ1rhu2c1GG8wRrMV3/qeNCxtx6wySfadz9
         tK0KIBOQ8IMbnV2mXzm1g2Kr3o5Yl+wlP2d1g5RL3AXo5GGc0wmg38hm84MoLM84M7fo
         3CgYwrAQgFvU+2WoSsSG8btz54yymT2NHInTG75G9phPelq5vbX5RwvMqZo5Sldh/8Wy
         n6gcQ8qjbS83CkO6mtD1zsyZoyrr0AkaID62Wz3DgyEoAr2pPDPLP+R/bgXcrHxyC5+8
         EX+w==
X-Received: by 10.68.129.198 with SMTP id ny6mr26457543pbb.42.1443443395352;
        Mon, 28 Sep 2015 05:29:55 -0700 (PDT)
Received: from lanh ([171.232.94.118])
        by smtp.gmail.com with ESMTPSA id on5sm6194171pbb.65.2015.09.28.05.29.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2015 05:29:54 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Sep 2015 19:30:30 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278714>

-u <exec> has never been supported, but it was mentioned since
0a2bb55 (git ls-remote: make usage string match manpage -
2008-11-11). Nobody has complained about it for seven years, it's
probably safe to say nobody cares. So let's remove "-u" in documents
instead of adding code to support it.

While at there, fix --upload-pack syntax too.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-ls-remote.txt | 3 +--
 builtin/ls-remote.c             | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-rem=
ote.txt
index 2e22915..d510c05 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -9,7 +9,7 @@ git-ls-remote - List references in a remote repository
 SYNOPSIS
 --------
 [verse]
-'git ls-remote' [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]
+'git ls-remote' [--heads] [--tags]  [--upload-pack=3D<exec>]
 	      [--exit-code] <repository> [<refs>...]
=20
 DESCRIPTION
@@ -29,7 +29,6 @@ OPTIONS
 	both, references stored in refs/heads and refs/tags are
 	displayed.
=20
--u <exec>::
 --upload-pack=3D<exec>::
 	Specify the full path of 'git-upload-pack' on the remote
 	host. This allows listing references from repositories accessed via
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 4554dbc..5e9d545 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -4,7 +4,7 @@
 #include "remote.h"
=20
 static const char ls_remote_usage[] =3D
-"git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]\=
n"
+"git ls-remote [--heads] [--tags]  [--upload-pack=3D<exec>]\n"
 "                     [-q | --quiet] [--exit-code] [--get-url] [<repos=
itory> [<refs>...]]";
=20
 /*
--=20
2.3.0.rc1.137.g477eb31
