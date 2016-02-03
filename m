From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/20] worktree: avoid 0{40}, too many zeroes, hard to read
Date: Wed,  3 Feb 2016 16:35:45 +0700
Message-ID: <1454492150-10628-16-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:37:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtsM-0006Q5-7R
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbcBCJhU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:37:20 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36760 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbcBCJhR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:37:17 -0500
Received: by mail-pf0-f178.google.com with SMTP id n128so10959271pfn.3
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JWk7BuQU/d4xb+o+xEOi4Ai+N9x1yvlyPLHYjZsFrZI=;
        b=mlB320/JrFhKF5TQNy3dgHJZPzP0tKyuA1+eOIm4jF4vZXW09fdG+yysS1sJluOdWl
         miMB/hPE5pBolQ8OuEfwUKehJLzCGMkVtnhOjR0sUmJLySjgr93G7kw3X6t8PyEXqLVk
         /0GeEFT+gNsXkdfMNo4xe2PmKF8CjEZke3tW1CCc2IZFYAtB4kScP7ULShXGGdH2wKOf
         ermre5NLVOvZ/iyRjfkUnF7HYzU7r89F1sZErsJDVQBZsnyKZzF5GFzwh7JGOl+sOnaE
         D1In/UG+fkQaDx6TlmBeN6nCNXqy+3jKPW+uIMdz7SHkaxbng2dspoTyN2CUOyHJyinr
         AeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=JWk7BuQU/d4xb+o+xEOi4Ai+N9x1yvlyPLHYjZsFrZI=;
        b=A90D4BeAsQaqBbMQjSA8y/apmFOP3kjOeb/edf3nhXQZJEaI9WcVve1h+ANxYfmaDJ
         ojElKEJ+ahwLXd0+fC2Hca/zEFi+r2jENsq5mGZxvRCjsqoUK+iokwX3aO0eSjVxMY2F
         jlNsS2IOU0j8GI1WhAPlOeOB+C0aJ5/Yw1pHU4+FV5cf7rIlgmJvLIrc0AeiS6iM9m9u
         sI8/Wn1iK484+8UM/3iwiXizl3b/Ts30dC5cXXdPjbnYTMJYBi6KJIkCgqIMKvsZah7z
         gqL11OrzZxwUz9qGkDhkOvRP0dx78XKGKuw/dfXWwze1+6aT5IFuecwJSo06zXt5c9DU
         7xwg==
X-Gm-Message-State: AG10YOQEgdh03P7c9odaoOBvwpguFKgawe4ulm0LeYYPMxqDxOmB8E/JwHvsgYtk/z1c6A==
X-Received: by 10.98.87.80 with SMTP id l77mr694372pfb.101.1454492237399;
        Wed, 03 Feb 2016 01:37:17 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id h66sm8319657pfd.91.2016.02.03.01.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:37:16 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:37:29 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285358>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7b217fb..f490ca3 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -263,7 +263,7 @@ static int add_worktree(const char *path, const cha=
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
2.7.0.377.g4cd97dd
