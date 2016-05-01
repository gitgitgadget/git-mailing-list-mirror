From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/41] connected.c: use error_errno()
Date: Sun,  1 May 2016 18:14:35 +0700
Message-ID: <1462101297-8610-20-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:17:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpN0-0007Pw-Eu
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbcEALQ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:16:59 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33911 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcEALQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:16:58 -0400
Received: by mail-pf0-f193.google.com with SMTP id 145so16225789pfz.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cy8w2To31+I1tcXrcelmFf06S0W6OU/b4PxmzLEBa8w=;
        b=qxaczIZO0xHf3R0+K3TANL0evIJGx1oJJAsXZPxnD/bqna5j1ZDMTqzZi5PS1JRoFP
         aPi+nTBuOMKzWO3XTNfatoa4UldEw1QiQzTFV+/Ru2HK3bkwWtylEO5Fezi4MJC7NDyB
         BqPf++t8RWZAkZyokNTOrVfX2RNoOVBasY39BpKOxRTpPoHtDi/q+jqEXowvz1sBaOxd
         qOPvQ7vWw38IWriKljRVaVd1AZY9te61ZDvBb5CZnixxuPjWECNdvret1NcjIHgG6CJW
         PRDdGKxFJ34TLuIIyJNu+T/L+NSFzuQq10+nJgE0IlWFrDRYxr2mTZF6LTsJYrrc92SZ
         cuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cy8w2To31+I1tcXrcelmFf06S0W6OU/b4PxmzLEBa8w=;
        b=dMjsGduKNc1v1yea6mwYqrNzD/v2HqvTIXnTsgYL9uuSPfRw3BH9Yrxi+J/BPS56+0
         7KAs3XwKMs79cevgvccGcUy5l3/jeaNO2hkkTYV+0WjrWlKzvnBxlp8uzZ86pL8d3hTW
         m3ugAzGIIXelKGWLKY6Z4GV+ckGFvdXN+XX4Y3DPgycC1YmjyEgmh2KdUmFd7bnbml88
         IWk9Koci06YTRnnIxLLkVm+9aAnvlCkmBRdnnJowolx3Ogyxh2y6SH/syZCIWjv7p00K
         Lvi/LNhHzYYaEzOhcctUZYb5JAf7tg1x+XOpu03f8i+NOGX9A6eFa1lX7uBe9uxbJQZZ
         EihA==
X-Gm-Message-State: AOPr4FXBgygW3AnnmTPOVQCgdT7J6K9RzCRn0/na0vwk0wAakPgzrOrhkkLiUMWmLuG1HQ==
X-Received: by 10.98.31.65 with SMTP id f62mr24476908pff.83.1462101417498;
        Sun, 01 May 2016 04:16:57 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id w187sm18882263pfw.50.2016.05.01.04.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:16:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:16:52 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293169>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 connected.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/connected.c b/connected.c
index 299c560..bf1b12e 100644
--- a/connected.c
+++ b/connected.c
@@ -86,17 +86,14 @@ static int check_everything_connected_real(sha1_ite=
rate_fn fn,
 		memcpy(commit, sha1_to_hex(sha1), 40);
 		if (write_in_full(rev_list.in, commit, 41) < 0) {
 			if (errno !=3D EPIPE && errno !=3D EINVAL)
-				error(_("failed write to rev-list: %s"),
-				      strerror(errno));
+				error_errno(_("failed write to rev-list"));
 			err =3D -1;
 			break;
 		}
 	} while (!fn(cb_data, sha1));
=20
-	if (close(rev_list.in)) {
-		error(_("failed to close rev-list's stdin: %s"), strerror(errno));
-		err =3D -1;
-	}
+	if (close(rev_list.in))
+		err =3D error_errno(_("failed to close rev-list's stdin"));
=20
 	sigchain_pop(SIGPIPE);
 	return finish_command(&rev_list) || err;
--=20
2.8.0.rc0.210.gd302cd2
