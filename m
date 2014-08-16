From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/2] fetch: silence git-gc if --quiet is given
Date: Sat, 16 Aug 2014 08:19:28 +0700
Message-ID: <1408151968-30294-2-git-send-email-pclouds@gmail.com>
References: <1408017065-17437-1-git-send-email-pclouds@gmail.com>
 <1408151968-30294-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mflaschen@wikimedia.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 03:19:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XISet-0002e1-Fd
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 03:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbaHPBTo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2014 21:19:44 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:43151 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbaHPBTn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 21:19:43 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so4202656pdj.21
        for <git@vger.kernel.org>; Fri, 15 Aug 2014 18:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pbscOb8pc4vCBab+r6Nj2IQjV4fvt+yZyEi8i9LREpw=;
        b=pFPa+/WOn9q0/HQ47VDpo5IyB/2BlmXKFvOfFPJ0fMN0Rc9rEO4ybPNFJ3uAyZcrn4
         jP9OwMKxFlTp4P1W5MIStNoUbX+d+CRluNCI+/dQf+AADq2V3nCoT58moLmGGsApZSrx
         kVL7UEaueSvDIIjvYnyVoHR8RdutRdwc/20DRpC2BR2MFgpWEh+eXyvDOrPU8qicjrc1
         rYSKHmhUHCPu03q58ODhq8zND2UH38ZmLodcPsnSLjI9I/NkbATj0KUSAWLEZANqL0J1
         nAofsbMvt5ySDS13dcH0a+QdRtbGhqNRX8JgVzfknCOpzHMV52KUebCdVu4MZBvfFpmN
         mRuw==
X-Received: by 10.70.37.33 with SMTP id v1mr3706006pdj.155.1408151982740;
        Fri, 15 Aug 2014 18:19:42 -0700 (PDT)
Received: from lanh ([115.73.215.192])
        by mx.google.com with ESMTPSA id v8sm13923607pdr.45.2014.08.15.18.19.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Aug 2014 18:19:42 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Aug 2014 08:19:40 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1408151968-30294-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255312>

Noticed-by: Matthew Flaschen <mflaschen@wikimedia.org>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f06114..159fb7e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1197,6 +1197,8 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
 	string_list_clear(&list, 0);
=20
 	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
+	if (verbosity < 0)
+		argv_array_push(&argv_gc_auto, "--quiet");
 	run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
 	argv_array_clear(&argv_gc_auto);
=20
--=20
2.1.0.rc0.78.gc0d8480
