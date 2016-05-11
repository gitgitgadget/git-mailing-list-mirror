From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 83/94] environment: add set_index_file()
Date: Wed, 11 May 2016 15:17:34 +0200
Message-ID: <20160511131745.2914-84-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:21:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U4w-0004oo-52
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbcEKNVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33166 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932369AbcEKNVT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id r12so9419227wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3pDI6Blz6i3nQ8nR+rkT5wR8xQm97VynuvQ/0V+cS3Y=;
        b=ULeyTjRlF7gZxgp3+vtgtfe3mP/J3fBq/DN5rurreZizxXeox5k7zhsJiVw2+UJFCs
         Ycdrb+T7SLHpe4HHg0B80CRn+2QCRljqhSwPaC5pq3lM36NwBbq75Ains0WEeAD4APBg
         47kF2apfqUE6u5HdH+F/2Lssdl2FnyZJi/MmAjtYy8wNKxsOncxoFjeotv8b5NsRY151
         1eYK5j+Rwi5/4Th3NYWeBuhhoE42RGnN0UpnzViHnbLsclTazVyr751CPwOpTdffjN42
         mUw7EGPen5B6QckbEPECpAB7t04ak7jCmPzbcBEbzhTILiUiZASo4aVLdwxpW79+rKhn
         veyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3pDI6Blz6i3nQ8nR+rkT5wR8xQm97VynuvQ/0V+cS3Y=;
        b=BznblHKN5ys7h9kriSHHeMcQi1LMWRYnH21SJ6L6AkxlGDqM9i3j/M2p6IAUNTRC1g
         fmyStbueviTFEL4SMMSqrMnInO25gdEBaB5IJJZ0tywViZlXDymtD+kyHrYDGbuzszev
         L4qrT96gaTYqyrjxHF6SGBafd5Ds9Tw/xKYWXYppNClR16I6B6gt7zaZg+xaKJCex36R
         KXv9KrsrnuCQw8hLLJovrsaCwrKBdUZBascHw0t66cA/jHmlJy+UHoQih7VGMZMXChZd
         cKd2soriaNEiyE7Ekl7hwYnxF2yLjNr8sGMuVA0ItWRbONAyekSnFCgh/toOUoG63C6p
         uQcw==
X-Gm-Message-State: AOPr4FUehJEE4w5iKYHFDXgqw0sx2RqSkqfC79mC8eP5LAji6u9Mewoht2OPhEls0SZ84A==
X-Received: by 10.194.3.84 with SMTP id a20mr3749631wja.77.1462972878582;
        Wed, 11 May 2016 06:21:18 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:17 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294298>

Introduce set_index_file() to be able to temporarily change the index file.

It should be used like this:

    /* Save current index file */
    old_index_file = get_index_file();
    set_index_file((char *)tmp_index_file);

    /* Do stuff that will use tmp_index_file as the index file */
    ...

    /* When finished reset the index file */
    set_index_file(old_index_file);

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h       |  1 +
 environment.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/cache.h b/cache.h
index 160f8e3..452d0ec 100644
--- a/cache.h
+++ b/cache.h
@@ -461,6 +461,7 @@ extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
 extern const char *get_git_common_dir(void);
 extern char *get_object_directory(void);
+extern void set_index_file(char *index_file);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
diff --git a/environment.c b/environment.c
index 57acb2f..9676d2a 100644
--- a/environment.c
+++ b/environment.c
@@ -290,6 +290,16 @@ int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1)
 	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 }
 
+/*
+ * Temporarily change the index file.
+ * Please save the current index file using get_index_file() before changing
+ * the index file. And when finished, reset it to the saved value.
+ */
+void set_index_file(char *index_file)
+{
+	git_index_file = index_file;
+}
+
 char *get_index_file(void)
 {
 	if (!git_index_file)
-- 
2.8.2.490.g3dabe57
