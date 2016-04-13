From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/25] worktree.c: add is_main_worktree()
Date: Wed, 13 Apr 2016 20:15:36 +0700
Message-ID: <1460553346-12985-16-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:17:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKfi-0004bM-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932930AbcDMNRN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:17:13 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:32898 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932878AbcDMNRK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:17:10 -0400
Received: by mail-pa0-f68.google.com with SMTP id vv3so3901642pab.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GY5CvLkF1V6J19vd8oKVdkkDNobmSW+t//NMdx0nKjg=;
        b=ZSNTWJai3p9TrBjCNFuBdsiUOkqzVUNQKIylsfcDd0XZUYOVBoL1vlRO6QSMsYfoX6
         aGA01hvWPfWnTnFpmAtyY32j9Txg12kD+oCbcxIcV/whVEcBr7LO7KVOnVzJT21akTWd
         B3DvoVSAfrwI6xrtZMVNBfEe59/WyLP4AEPHVk8FbFHa9ezy0kHGMxuKSpnD0dfW1ugn
         YV4DJpaagGmugjsLR9hrbqBkq46+jTPSw3xKOK80XdyeRLHsj3+3J6cdMQ0PKLTcwTlI
         +SlQyTxSkx91b5C+p7k8ZVXoomDfqB5Qw70djzQs+P15ZS+gphcUEbDl/4PP7e22+0Vl
         rvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GY5CvLkF1V6J19vd8oKVdkkDNobmSW+t//NMdx0nKjg=;
        b=S97BMkeRDOoQkYU+3yVu89/FXGtd1xSRTDmkFaaqTFFCSgEcWdns7Md/kIDlnHp2WA
         a7hTAZ3WwutUJbJ4bDkLE9jMy3GjefJk/Y8yQDKbQfCZhTz7BW+R576Y+r0XkEv4o9kn
         +0YUjTgKX1C38jkvUbkt+vuQTmiFUehmYJiNnOk5lnrKkNEVaxgywJs0175sLyBA4AC7
         +Fd6dkyLO3kn1aQBEkGa7L4sHB5uOLRaa1Qq9x5s9usHiq1L0jyutu+5m/jQch4kuNcw
         ujdUmpwfOOZ+oUoEleCSsvHtjEmX4fDa9oATQAIuYPcW1DBQzLvNWcG/IGnpLjyhlTDU
         0ojg==
X-Gm-Message-State: AOPr4FVb0ZgdCp5bT6Qu1EaRIgYGEXZCwqLezItlnPXU5UmmBENRL4xd81Aw3ncp9dEd6w==
X-Received: by 10.66.101.35 with SMTP id fd3mr12738442pab.7.1460553429583;
        Wed, 13 Apr 2016 06:17:09 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id d19sm51119817pfj.92.2016.04.13.06.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:17:08 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:17:15 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291436>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 5 +++++
 worktree.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/worktree.c b/worktree.c
index e444ad1..e878f49 100644
--- a/worktree.c
+++ b/worktree.c
@@ -214,6 +214,11 @@ struct worktree *find_worktree_by_path(struct work=
tree **list,
 	return wt;
 }
=20
+int is_main_worktree(const struct worktree *wt)
+{
+	return wt && !wt->id;
+}
+
 char *find_shared_symref(const char *symref, const char *target)
 {
 	char *existing =3D NULL;
diff --git a/worktree.h b/worktree.h
index c163b6b..c7a4d20 100644
--- a/worktree.h
+++ b/worktree.h
@@ -34,6 +34,11 @@ extern struct worktree *find_worktree_by_path(struct=
 worktree **list,
 					      const char *path_);
=20
 /*
+ * Return true if the given worktree is the main one.
+ */
+extern int is_main_worktree(const struct worktree *wt);
+
+/*
  * Free up the memory for worktree
  */
 extern void clear_worktree(struct worktree *);
--=20
2.8.0.rc0.210.gd302cd2
