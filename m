From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 82/83] environment: add set_index_file()
Date: Sun, 24 Apr 2016 15:39:48 +0200
Message-ID: <1461505189-16234-3-git-send-email-chriscool@tuxfamily.org>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:40:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKGk-0001qZ-QU
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbcDXNkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:40:10 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35006 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbcDXNkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:40:06 -0400
Received: by mail-wm0-f44.google.com with SMTP id e201so60599739wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3c+XZrcR71IbLTXjHLNjTVnoc3FZfSSEYUcTpzNrHj0=;
        b=fjRmHzDe49VzMcszqVMVb6RImikwBrXp11r3LU8qTdMo2DG+K9zP6GiI0KSgEOWoyD
         9pzvuvqsByrDMKQ9+0dzh+CK8wLf6fE2b8BDyLBcAtTYikg8tIKa4Hyz2ehxNsqRkmL0
         phHZL7OveFSWVKhqq14WDWAi5gB4cBWKRFs3N8KJ7VSgU9WEvJ61XoHI1hiGnFZXhVuO
         teS7IIWeJXRKVVuEb6N+OaQ1T09qCZDR2MxG3vQ5bgg+ZhHJKh6jgGj508KP5JXlacon
         oZe8ysr3yM6TOuLLR3XCHFQcPATurX8SJTnbOJSzR8TAK+YjBasYexBS4/sdgS9rFbCI
         4EkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3c+XZrcR71IbLTXjHLNjTVnoc3FZfSSEYUcTpzNrHj0=;
        b=duBrasmDSwq+f+Coj2EndmPSkf2Qbyc1UCjkcGLbg1Znger7QeyWhBEvRqNOSHk8g/
         wEamSvxxi2ITildjWw7uFP+iLNAQ/YRfbiyZzCQYu7b3lEhLMRhqoKcQ2qFHhsMhIoXY
         qJWNhIADrJZA6XSpXATzjRLjgs4qTuQs8P7h8GJDY3nA6XgX7pPxMfNnzkNCPpfqyUH3
         2gDkLRaBEBTL8iCzXx0ZsJZxFtc1qPKjBksIsvdJtSLZ82R5aZWj0q6bdjvDL8W803xp
         4tOcob03jC33zXNWk7/DhRDUP6vmhsgJVjOeDgJLYAqrdv/SoraqP6eYst7hDizJg7zF
         IA0A==
X-Gm-Message-State: AOPr4FWw1Vf7sY9ElEJC+TF75TGPBF8K/IiT+Bj3GokiCn4WoWLUqPxs/dVKBLYhUqrETg==
X-Received: by 10.28.113.218 with SMTP id d87mr7463491wmi.52.1461505205349;
        Sun, 24 Apr 2016 06:40:05 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id by7sm18530771wjc.18.2016.04.24.06.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:40:04 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292404>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h       | 1 +
 environment.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/cache.h b/cache.h
index 2711048..7f36aa3 100644
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
index 57acb2f..5a57822 100644
--- a/environment.c
+++ b/environment.c
@@ -290,6 +290,11 @@ int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1)
 	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 }
 
+void set_index_file(char *index_file)
+{
+	git_index_file = index_file;
+}
+
 char *get_index_file(void)
 {
 	if (!git_index_file)
-- 
2.8.1.300.g5fed0c0
