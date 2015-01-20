From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/24] untracked-cache: temporarily disable with $GIT_DISABLE_UNTRACKED_CACHE
Date: Tue, 20 Jan 2015 20:03:26 +0700
Message-ID: <1421759013-8494-18-git-send-email-pclouds@gmail.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 14:05:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDYUy-0003vF-0I
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 14:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130AbbATNF3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 08:05:29 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:47781 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806AbbATNF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 08:05:28 -0500
Received: by mail-pd0-f180.google.com with SMTP id ft15so13701979pdb.11
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 05:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5dnx+EFfh+q2npRkgAdt6YjZS75LpZ8AWOePwDIrwkg=;
        b=JkcCN/yzVoVeMUoRX2VQ1xgujNSlzcsEhTfTMhbBzIz/YhrmY/CnLMr8yMVttyoTXI
         DWX1xifOH8oERbRu3UWAw/8Ux7zD+wBCLL2asRxJ6cCBm7KIBWSeMcj/ZCJAP6rtWZrz
         AQ1tJx8BmYWxY4ktcTjZGgneLLwlLA7JNwVw1u3VTHzCF7KhTPl1Lb6d8bVm9qP0z9Eh
         6Cpoi5RD8kktoWzwlo6MkVl9MVmn9MhI1LHhaGVAxlZiCBxvRYwLpgYTCsJ0dpOfMBdr
         xjd2NQF7b3kAPNgQXuLJau8CAJiro/w5rOM7VTMtj3s9Pp084VjYqWVKC3UvfLjLwskd
         m5uw==
X-Received: by 10.68.203.226 with SMTP id kt2mr52555036pbc.141.1421759127730;
        Tue, 20 Jan 2015 05:05:27 -0800 (PST)
Received: from lanh ([115.73.212.1])
        by mx.google.com with ESMTPSA id k5sm88804pdb.14.2015.01.20.05.05.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2015 05:05:26 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 20 Jan 2015 20:05:37 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262669>

This can be used to double check if results with untracked cache are
correctly, compared to vanilla version. Untracked cache remains in
index, but not used.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 1c3db0b..5b9dd5d 100644
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
2.2.0.84.ge9c7a8a
