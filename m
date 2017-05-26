Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAECD209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969451AbdEZDfk (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:35:40 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36642 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946827AbdEZDf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:35:28 -0400
Received: by mail-pf0-f194.google.com with SMTP id n23so43015007pfb.3
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uz0VxB+oN/qW5QGKe0N9xjugbB5YeSXTnTxNbS89bLw=;
        b=EvEa0lS3yOHI+oI/EI0mT7m99mP1GyykYFylLonWqvdSTwf2FSt9GSThzZ/L5U/ty1
         Hsj8VPfP5glaNxm9AD8zEqzLmjO6eALdXFDqWlOab3p319vARC8mCs5OdxwmURVzqizy
         r5HOKC8UYl4GriPoK6Qblk1wTq6cq1PJ4nVyXMb+zoWElOGThO45xL4xrLC/RuQPYKCv
         QNuY2tN2Lr982yu3idgMuWu2AkXJsgZUlZTK1sbIFOP74uvqHMJC1a070jgmON/+rRkS
         s/gkxXibRSpQC2SZvieW5YrN5A+tJ5j6sAeAZYFS4foyXoNWXq1nkTjdyPlMDwCGeY8C
         i5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Uz0VxB+oN/qW5QGKe0N9xjugbB5YeSXTnTxNbS89bLw=;
        b=psMK+uG9Sf7TzrBs2DCwA/Pj6pxbcCWUGmaYt4zskxfXXQB3M2G9Q6ZoVImlkbgN+R
         OFmeQwZE7luNk6br5Z8XZOAgwI5F6ZLWYW+mVwxyR9dff7hAlwyvm0AwMk7nZwGCV29K
         3pWlgka/gLx9IxrKXPGu0iexdmqu9wDnNQPcDVGcstvO+8LGnBhOtB6YigG9u6OCvucS
         WkOO1Fqt8XRMy+EF4dwMKBkNn0f36yDwaTzlzX+gL9dkPQy9fyhVx+cOVO3/eQW32DeS
         sZJSSg5dbxrn9uQIrocTvImItyDDHyS1+Qq3tND4oC1DOctf10mj8UiwRG2gJrra3Zhe
         2wLA==
X-Gm-Message-State: AODbwcD+U38oMZ03gOtpXTsX2rByadkKgS3KeIcUhnWjRbxQLghK8Nb/
        5iPU3FYS/7VdtQ==
X-Received: by 10.99.181.11 with SMTP id y11mr48457300pge.54.1495769722287;
        Thu, 25 May 2017 20:35:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id f63sm15206491pgc.63.2017.05.25.20.35.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 20:35:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 08/13] wrapper.c: make warn_on_inaccessible() static
Date:   Fri, 26 May 2017 12:35:05 +0900
Message-Id: <20170526033510.1793-9-gitster@pobox.com>
X-Mailer: git-send-email 2.13.0-491-g71cfeddc25
In-Reply-To: <20170526033510.1793-1-gitster@pobox.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

After the last patch, this function is not used outside anymore. Keep it
static.

Noticed-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h |  2 --
 wrapper.c         | 10 +++++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index f74b401810..87f47828a5 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1100,8 +1100,6 @@ int remove_or_warn(unsigned int mode, const char *path);
 int access_or_warn(const char *path, int mode, unsigned flag);
 int access_or_die(const char *path, int mode, unsigned flag);
 
-/* Warn on an inaccessible file that ought to be accessible */
-void warn_on_inaccessible(const char *path);
 /* Warn on an inaccessible file if errno indicates this is an error */
 int warn_on_fopen_errors(const char *path);
 
diff --git a/wrapper.c b/wrapper.c
index 6e513c904a..b117eb14a4 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -418,6 +418,11 @@ FILE *fopen_for_writing(const char *path)
 	return ret;
 }
 
+static void warn_on_inaccessible(const char *path)
+{
+	warning_errno(_("unable to access '%s'"), path);
+}
+
 int warn_on_fopen_errors(const char *path)
 {
 	if (errno != ENOENT && errno != ENOTDIR) {
@@ -597,11 +602,6 @@ int remove_or_warn(unsigned int mode, const char *file)
 	return S_ISGITLINK(mode) ? rmdir_or_warn(file) : unlink_or_warn(file);
 }
 
-void warn_on_inaccessible(const char *path)
-{
-	warning_errno(_("unable to access '%s'"), path);
-}
-
 static int access_error_is_ok(int err, unsigned flag)
 {
 	return err == ENOENT || err == ENOTDIR ||
-- 
2.13.0-491-g71cfeddc25

