From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 05/13] worktree.c: mark current worktree
Date: Fri, 22 Apr 2016 20:01:28 +0700
Message-ID: <1461330096-21783-6-git-send-email-pclouds@gmail.com>
References: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
 <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 15:02:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atair-0007DM-O2
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 15:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbcDVNCI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 09:02:08 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34429 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbcDVNCH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 09:02:07 -0400
Received: by mail-pf0-f195.google.com with SMTP id 145so2503787pfz.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 06:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CfpMnSjEbq6xOMby3cVO5dmhTIcq1qFFOHg4teyqMPA=;
        b=ZHDfJIjLtMdA3IETeuWW2jQLwG9nkwmN236EIMZUpLL7XHugIIW/BZiBAErBPh0rmo
         BplLSVx01Y5LOEP3JrBLyy/y9f+EvpjL3zOzNwhCg+vIImFBcpz7GpZuPy9KUVbVYGIR
         6GsCY9V1J9OR03pUrMeSjoJ4XOh9vfhnS9Enos7ejBRGvYcWdvPFmIL+GoPj0akhHIrN
         7+MfVTGdHcckMLQuu6MtnzOal1A+PzX3FWY/IlEUcLxsGGmz3spAxcHcBy4HFD/T1XJl
         eCSY1FdI9T2t0ua8KvS4FyHBl8vvtHM4hXElMYYC3v6cLrXOeHjgSTq0rbX13keG3OPr
         pznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CfpMnSjEbq6xOMby3cVO5dmhTIcq1qFFOHg4teyqMPA=;
        b=KyVX+fR10QyGiu62GG8QrLXCsd2b0+fe2gNg/z2c6CkHn/wHNz72HpLbAFgPdUXFDZ
         Oz241Lw3gz26nrfJ6ywtCev+cqwTwokHTmI9CzZKvyeu3/+Vw7U7TuSAEg+dqXbvXniW
         /IfKNEjx5876UCh8s46odJbdatnmVHe9BlKdvymutN0+bee7OqbUsaI/mqIXOX6pybyx
         asUU0tMGVXDVJjfjY5QPIhl+yQdL+8Xb+i7wfydmzya/4szdYjPasGFEhvI6Pk8eMNQq
         W+8jbiVQE2MAztmzKn85B45ulITb4oPe0DfzbCcllyYkFkzDMJ6W4nD6mYDoWDJs8QdU
         BMGw==
X-Gm-Message-State: AOPr4FX+8JdOM8tT4TR53+bF9Wxx3I3SxQwqnamEgg0vDGtEvvI+Gwis8YBHj9w0uII29w==
X-Received: by 10.98.76.216 with SMTP id e85mr28326563pfj.121.1461330126428;
        Fri, 22 Apr 2016 06:02:06 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id a77sm8503187pfj.2.2016.04.22.06.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 06:02:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Apr 2016 20:02:18 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292194>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 24 ++++++++++++++++++++++++
 worktree.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/worktree.c b/worktree.c
index 360ba41..dc092a7 100644
--- a/worktree.c
+++ b/worktree.c
@@ -2,6 +2,7 @@
 #include "refs.h"
 #include "strbuf.h"
 #include "worktree.h"
+#include "dir.h"
=20
 void free_worktrees(struct worktree **worktrees)
 {
@@ -94,6 +95,7 @@ static struct worktree *get_main_worktree(void)
 	worktree->is_bare =3D is_bare;
 	worktree->head_ref =3D NULL;
 	worktree->is_detached =3D is_detached;
+	worktree->is_current =3D 0;
 	add_head_info(&head_ref, worktree);
=20
 done:
@@ -138,6 +140,7 @@ static struct worktree *get_linked_worktree(const c=
har *id)
 	worktree->is_bare =3D 0;
 	worktree->head_ref =3D NULL;
 	worktree->is_detached =3D is_detached;
+	worktree->is_current =3D 0;
 	add_head_info(&head_ref, worktree);
=20
 done:
@@ -147,6 +150,25 @@ done:
 	return worktree;
 }
=20
+static void mark_current_worktree(struct worktree **worktrees)
+{
+	struct strbuf git_dir =3D STRBUF_INIT;
+	struct strbuf path =3D STRBUF_INIT;
+	int i;
+
+	strbuf_addstr(&git_dir, absolute_path(get_git_dir()));
+	for (i =3D 0; worktrees[i]; i++) {
+		struct worktree *wt =3D worktrees[i];
+		strbuf_addstr(&path, absolute_path(get_worktree_git_dir(wt)));
+		wt->is_current =3D !fspathcmp(git_dir.buf, path.buf);
+		strbuf_reset(&path);
+		if (wt->is_current)
+			break;
+	}
+	strbuf_release(&git_dir);
+	strbuf_release(&path);
+}
+
 struct worktree **get_worktrees(void)
 {
 	struct worktree **list =3D NULL;
@@ -178,6 +200,8 @@ struct worktree **get_worktrees(void)
 	}
 	ALLOC_GROW(list, counter + 1, alloc);
 	list[counter] =3D NULL;
+
+	mark_current_worktree(list);
 	return list;
 }
=20
diff --git a/worktree.h b/worktree.h
index ca50e73..ccdf69a 100644
--- a/worktree.h
+++ b/worktree.h
@@ -8,6 +8,7 @@ struct worktree {
 	unsigned char head_sha1[20];
 	int is_detached;
 	int is_bare;
+	int is_current;
 };
=20
 /* Functions for acting on the information about worktrees. */
--=20
2.8.0.rc0.210.gd302cd2
