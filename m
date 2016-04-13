From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/25] worktree: avoid 0{40}, too many zeroes, hard to read
Date: Wed, 13 Apr 2016 20:15:40 +0700
Message-ID: <1460553346-12985-20-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:17:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKfr-0004ft-G0
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760678AbcDMNRd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:17:33 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33298 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760672AbcDMNRc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:17:32 -0400
Received: by mail-pf0-f194.google.com with SMTP id e190so4122426pfe.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wkItfEOvMPQRlMyhoJsyeUGcBZO6FAaKRb7qEiaCCok=;
        b=mezd1XVRH5zNVN6EbVq7/QSA1h8k846kFA7kRM4SqUjlon97Du0m0wkMC+HOrL3OnZ
         L9abLK9WY4tbqHu3/h12tWnxdntobpZWofqlgBcirct0WpMpzrfBMQ1oon4+IHX1BBTT
         MmwS2kORMUxvFphplpJTlUPjcgCgO8XX6VQUHM1fIG2MBb4qDzpDx/2xa9bISZ8ghgd9
         t+yWYC/OkcO9kwuhl377Hmx1D0KPCFyCihrYq8L2CaGYxnQN6Uz9+iDQXN2NrNKJtOrp
         4poMEt7wJ474EUnK7cD9jDKPi/KmYmfbKdJvQY8jwt4lhUcUQwEpt2hrifKxqmmLPLP2
         etKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wkItfEOvMPQRlMyhoJsyeUGcBZO6FAaKRb7qEiaCCok=;
        b=e0YOW2g7HDakLZe2dyVjzk74BL/cqp3YhxiEAeqwUW+n62fpY2P5rAZT6cZJO9eBgI
         UHqC4ZKDQEUJSBenq6KQ8DSXBeiyXaU+cnseMBKOuGTeWksia8WgQxJK1XbP3G7eX0bB
         GaLPAj0EVXz0GMi6TxUnqBO1nQWJxcyNsp0XZjODS9R5h9YGjaygxAcfk7wBMcAwZ2l4
         A74wbGcmT+j4E32yjvu1FzuQui5MSfN7ZpqTguciXBDSTatxbVe0rWFRdZMoorSaE/3W
         PNiwpbX4W2Hd70LeGS8A52GjGbYCLdE38pXW8qaP+gU682p0bH6IyYmoCVuOWnds1mgN
         J2zA==
X-Gm-Message-State: AOPr4FX3ZxRGAJDjoGgJQjtTJRDzEaNztEGgtvVUcZIUa7njbnnC5/npbh48lklfNhfEtQ==
X-Received: by 10.98.9.129 with SMTP id 1mr12845315pfj.163.1460553451696;
        Wed, 13 Apr 2016 06:17:31 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id wy7sm51287961pab.5.2016.04.13.06.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:17:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:17:37 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291440>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7ff66fa..e041d7f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -261,7 +261,7 @@ static int add_worktree(const char *path, const cha=
r *refname,
 	 */
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, "0000000000000000000000000000000000000000");
+	write_file(sb.buf, sha1_to_hex(null_sha1));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
--=20
2.8.0.rc0.210.gd302cd2
