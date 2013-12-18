From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/12] environment.c: replace starts_with() in strip_namespace() with skip_prefix()
Date: Wed, 18 Dec 2013 21:53:55 +0700
Message-ID: <1387378437-20646-11-git-send-email-pclouds@gmail.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 15:55:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtIWn-0004Cg-JJ
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 15:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205Ab3LROzG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 09:55:06 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:58965 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab3LROzF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 09:55:05 -0500
Received: by mail-pb0-f51.google.com with SMTP id up15so8592264pbc.10
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 06:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9BZ0shv4nyPNdxilyuA+HU1h1IFnxWZ95MpD6KBv75A=;
        b=R5MvkGLqg9rFHLJnLwZ/EoHdukSFvfU2zwog0eHAPFb2XrmWC9Kso88zvjQbKilnl6
         dPNdhx4Rlef0n2LFCV9iC+I6iy+c2jOPjgwE/0s2GtevG4dqBIvCqbbda/iHFx5q3+nq
         tuL1Xm+lEy9HWCTHNIW+6v1tJFeE8Zcy9xMlIM0eb7JlYrDLLQpZtfT5Gc+/2qsqCGEE
         NqGjC3nK2ZuFnLUk2ZJAcpQfXpAGAFlVOHj6lvgPySDyZvWZIqcnJPdy8Jfgi7GvgoJ5
         uvWMxPwR7CtTcQ0CTNpdXrz1pUXZmhXZwlGt8CgH1yOpOnwQNRT7uuQ62IEA4gOHl31T
         x0mg==
X-Received: by 10.66.149.231 with SMTP id ud7mr34912849pab.8.1387378504821;
        Wed, 18 Dec 2013 06:55:04 -0800 (PST)
Received: from lanh ([115.73.220.136])
        by mx.google.com with ESMTPSA id oa3sm558613pbb.15.2013.12.18.06.55.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 06:55:04 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Dec 2013 21:55:01 +0700
X-Mailer: git-send-email 1.8.5.1.208.g019362e
In-Reply-To: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239447>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 environment.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/environment.c b/environment.c
index 3c76905..bc2d916 100644
--- a/environment.c
+++ b/environment.c
@@ -171,9 +171,7 @@ const char *get_git_namespace(void)
=20
 const char *strip_namespace(const char *namespaced_ref)
 {
-	if (!starts_with(namespaced_ref, get_git_namespace()))
-		return NULL;
-	return namespaced_ref + namespace_len;
+	return skip_prefix(namespaced_ref, get_git_namespace());
 }
=20
 static int git_work_tree_initialized;
--=20
1.8.5.1.208.g019362e
