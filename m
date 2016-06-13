From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 2/6] worktree.c: add is_main_worktree()
Date: Mon, 13 Jun 2016 19:18:22 +0700
Message-ID: <20160613121826.21631-3-pclouds@gmail.com>
References: <20160603121944.28980-1-pclouds@gmail.com>
 <20160613121826.21631-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 14:19:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCQpq-0004My-9I
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 14:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbcFMMTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2016 08:19:13 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35584 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965049AbcFMMTM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 08:19:12 -0400
Received: by mail-pa0-f65.google.com with SMTP id hf6so2625597pac.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35sqWj7b+gL1KYfHfnFEmbH+78MmdwLp35wE7Jr1nG8=;
        b=ZX9w2c/b/rQEelkxTeQzWB80i4pX80Eiewq2I00oUhCh0IUndS6KbgJ55T42+E7NCQ
         c4W9enosDL9xFyPnnKRRBXGa93p8mqs3bB8NEnPjHhLwOf03aIs+TsU8hhAMOfcgPP3j
         WEIGebNkr6f4QttNdGpdFxICNJYgPZ8qTITKB6Q9hyjzqm8yHC75HxqtsJyrxH0FUT0F
         F4N+FR34Bm3Ue6Nk/fGfhj1hndJr7oUrCNoVxdSnzUi99oT9i3kWHFRrAQMPBOQr80s5
         iRtU8OL2jazWB6i6B2c6naJo5XjV2eFrep5wShlVco1rN7fHQ2/95lnTq7u1kMtjXZHZ
         lHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35sqWj7b+gL1KYfHfnFEmbH+78MmdwLp35wE7Jr1nG8=;
        b=Ej/12qAHaLnyi04UtiH3ud+LY7vVUOEm9Q821Lfc8CxYoMZTE1vWVDLZIBrSIRXqG+
         oGKzFH6VwTMNQe5OfhJCa48VcVtwyq9J8tzLUBMvDZdn1dnO7R6F2xEK9AX0eh3BXRCb
         TOZgloq/7bzgAhKU+eOQOabUWy30m+xkLDb4GDBFY1pmkIGyoXUGRWaDYKMfDY99jlmy
         4O7li9hpojwLGnRnI1vovjakqAHvfbxhcQ9aIEKuhfFo9b75olTzuK06NeVy8y/S7flj
         WXfCH4zzCv475ERRMGmVHKyvq9H8R6drkvE7buswfYu5YLEdxqNlQ2Zx4zRqQwO51W++
         YRqA==
X-Gm-Message-State: ALyK8tJcejLQc/QrN10HSoTIIuW/Z9y7cJMcTaXo+fniRkQyc1/zWpu61kdcoN9evoComw==
X-Received: by 10.66.81.70 with SMTP id y6mr21324434pax.121.1465820350387;
        Mon, 13 Jun 2016 05:19:10 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id vx4sm4764590pac.35.2016.06.13.05.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jun 2016 05:19:09 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Jun 2016 19:19:05 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160613121826.21631-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297182>

Main worktree _is_ different. You can lock (*) a linked worktree but no=
t
the main one, for example. Provide an API for checking that.

(*) Add the file $GIT_DIR/worktrees/xxx/locked to avoid worktree xxx
from being removed or moved.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 5 +++++
 worktree.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/worktree.c b/worktree.c
index 0782e00..12a766a 100644
--- a/worktree.c
+++ b/worktree.c
@@ -229,6 +229,11 @@ struct worktree *find_worktree(struct worktree **l=
ist,
 	return *list;
 }
=20
+int is_main_worktree(const struct worktree *wt)
+{
+	return !wt->id;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index 7ad15da..e1c4715 100644
--- a/worktree.h
+++ b/worktree.h
@@ -37,6 +37,11 @@ extern struct worktree *find_worktree(struct worktre=
e **list,
 				      const char *prefix,
 				      const char *arg);
=20
+/*
+ * Return true if the given worktree is the main one.
+ */
+extern int is_main_worktree(const struct worktree *wt);
+
 /*
  * Free up the memory for worktree(s)
  */
--=20
2.8.2.524.g6ff3d78
