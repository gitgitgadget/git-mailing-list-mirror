From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/7] worktree: avoid 0{40}, too many zeroes, hard to read
Date: Tue, 10 May 2016 21:15:52 +0700
Message-ID: <20160510141553.22967-6-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160510141553.22967-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 16:17:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b08TG-00087u-9I
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 16:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbcEJOQy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 10:16:54 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35710 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbcEJOQv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 10:16:51 -0400
Received: by mail-pa0-f65.google.com with SMTP id zy2so1176891pac.2
        for <git@vger.kernel.org>; Tue, 10 May 2016 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sx9msf4bJ3Je+/e9lGN2Ef9PagWRB/VfZLlVE0gnIfc=;
        b=SSYz201oZMjY+D9wMnie0pN2lzCt7Hn/MZgOMQJ4MgpAe0iC8PoH4rw9GoENStus0F
         qMQErFwW5FCdOjMc46DAJGcauo01MWgxvvTOgaGsankCv8nVsFIDxg8MhjilibEkDHI1
         3NdBdvhtM9kNRUuXjnEiLwiWA+dQ9Iu/li0UjPGec8jYR8MUteEM2UQp34NiGiYJCLpB
         oRlgy3c32U0MuI15HYe+iIHr0BVS7UO0aBIG0L/EXZ+OLWfpu6a1CCFjNqPlEEi+2h/D
         xlww0Dv6Q5cA6y3nbIZWvORvWBublMVjvAZARocsNHkfOAd8Yi4OqWE1XcGWgnfiU4af
         N8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sx9msf4bJ3Je+/e9lGN2Ef9PagWRB/VfZLlVE0gnIfc=;
        b=Y3OuF8VV40W46KL6kQkCKhIjtWWeMftUKjsUYhFnuOCO5Gx13hD3K+8PkC4pXLmRCP
         h04WP8agCpWjZ+dIdLeu28BAAKkcVLeNNYKhLCIpzgXfSY3s1zmgsQZaIpkopmoyX6d9
         TlZAirh9ZSsiR1UaZ/X2XPgsxvEVzh+oZamIrwvJkiF8nuvPEuQXQdAPzffAauApykWr
         Wuql5WgIws1bgrY9lhOghNBtiNs7KT5EDpibEnicAYsshwohRSqX6O1Adshh7qBiOx3H
         hscM2oJ05YSfjiw7YnuGsbAMVqnN4iLFLu1UvLdkSr4A4Wa1XcjKf+GKFDijbhwZyxXA
         unVA==
X-Gm-Message-State: AOPr4FW4ZLddJ5m4R0Od+DfQHsCV8IWbthvmHCnuCBk795GQIEbLZ9emWQA+z8gOzhdDZg==
X-Received: by 10.66.65.133 with SMTP id x5mr59263139pas.108.1462889810513;
        Tue, 10 May 2016 07:16:50 -0700 (PDT)
Received: from lanh ([115.76.164.133])
        by smtp.gmail.com with ESMTPSA id yl5sm4938569pac.38.2016.05.10.07.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 07:16:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 May 2016 21:16:52 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160510141553.22967-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294140>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index aaee0e2..b53f802 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -262,7 +262,7 @@ static int add_worktree(const char *path, const cha=
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
2.8.2.524.g6ff3d78
