From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 17/23] untracked-cache: temporarily disable with $GIT_DISABLE_UNTRACKED_CACHE
Date: Mon,  8 Dec 2014 21:05:01 +0700
Message-ID: <1418047507-22892-19-git-send-email-pclouds@gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 14:56:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxynT-00054Z-PA
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525AbaLHN4O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 08:56:14 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:42451 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376AbaLHN4N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:56:13 -0500
Received: by mail-pa0-f42.google.com with SMTP id et14so5299483pad.29
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Tf782Ke6ZtCA8YDH+vPJDN8G/W8REWj88WHLJNuFXuM=;
        b=Yek+fdoS8aZoDNT5cu5hvqsY/NxqGH6t0ApJDz6iylbBVCFz4l2ukkXcwU2oJssWoo
         xs2IgukBCa/aKehta/C7Y6AjnuVvS8XfSWCZcx7NKy0t8xO94UP5XvC/FYU9MlWr4MJN
         /3E0lw/z5Pin/SXTMeTALxIrLcn2xFV9Rrk+nRD5U6q2HS+fdXnaZu1uydCHI7XYrnDO
         Z73/amcfqiF8GAFVw3SYLq6FpqcRIvq8SJGr2noiFeqjr5fxSdzbrYZl9HMynfmwYbdu
         d8844F0t+0h6QrtNwKFvj4jW2oc5V3TODSeZHLZ8APQGhV0nc+cqXfr91xfA1cFuUemv
         iKVw==
X-Received: by 10.68.254.99 with SMTP id ah3mr61554088pbd.58.1418046972786;
        Mon, 08 Dec 2014 05:56:12 -0800 (PST)
Received: from lanh ([115.73.205.130])
        by mx.google.com with ESMTPSA id qc8sm36612913pdb.70.2014.12.08.05.56.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 05:56:12 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Dec 2014 21:06:48 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261035>

This can be used to double check if results with untracked cache are
correctly, compared to vanilla version. Untracked cache remains in
index, but not used.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 9b0e1a1..916f1ed 100644
--- a/dir.c
+++ b/dir.c
@@ -1800,7 +1800,7 @@ static struct untracked_cache_dir *validate_untra=
cked_cache(struct dir_struct *d
 	struct untracked_cache_dir *root;
 	int i;
=20
-	if (!dir->untracked)
+	if (!dir->untracked || getenv("GIT_DISABLE_UNTRACKED_CACHE"))
 		return NULL;
=20
 	/*
--=20
2.2.0.60.gb7b3c64
