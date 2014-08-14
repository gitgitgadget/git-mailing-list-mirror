From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] fetch: silence git-gc if --quiet is given
Date: Thu, 14 Aug 2014 18:51:05 +0700
Message-ID: <1408017065-17437-2-git-send-email-pclouds@gmail.com>
References: <1408017065-17437-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mflaschen@wikimedia.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 13:51:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHtZ1-0001fk-6o
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 13:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792AbaHNLvW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2014 07:51:22 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:47355 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563AbaHNLvV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2014 07:51:21 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so1498466pac.31
        for <git@vger.kernel.org>; Thu, 14 Aug 2014 04:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MV1w5gZVPg84cFQn08NCXqlfoQiq1vlLCgoiOtY7pFs=;
        b=pWmm9HUT7KRxjR90bKlT0ysF+1LCzIboUg9aH2T8/speQrDmmFxdZ/Ft2hakGGpDjT
         mtcQlkVkJnsExG1ky0teYihGuVojiGp4GYcE910XjM55wZmQOXLkP4xTMTCWB5sbOgFx
         6v8BuB/Xyn6MGO4/mIF6zZwLB7r4IAZvN1gRe85nkl43B7sn9cKsrbL3hwBvtCwr0RJo
         2KMRKf2Vh3ZJc5tDwJhQjow80aai1t3FkKXeDdRZ+cSUBasbn7zqrM2FY3AZyWtFkA1/
         GvfSKIgjrQN563UNQHKb8L37UCNsNueta2uSs0RfOIrCXbZupEB2WZGZjImFPbfC9YoP
         Dl/A==
X-Received: by 10.66.158.130 with SMTP id wu2mr3745617pab.59.1408017080893;
        Thu, 14 Aug 2014 04:51:20 -0700 (PDT)
Received: from lanh ([115.73.215.84])
        by mx.google.com with ESMTPSA id i3sm7454880pdp.2.2014.08.14.04.51.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Aug 2014 04:51:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 14 Aug 2014 18:51:17 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1408017065-17437-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255261>

Noticed-by: Matthew Flaschen <mflaschen@wikimedia.org>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9394194..4ff4080 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1197,6 +1197,8 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
 	string_list_clear(&list, 0);
=20
 	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
+	if (verbosity < 0)
+		argv_array_push(&argv_gc_auto,"--quiet");
 	run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
=20
 	return result;
--=20
2.1.0.rc0.78.gc0d8480
