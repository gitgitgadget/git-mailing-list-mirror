From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 28/31] refs.c: make struct ref_lock private to refs.c
Date: Wed, 14 May 2014 15:13:27 -0700
Message-ID: <1400105610-21194-29-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:14:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhR1-0006WZ-Gq
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbaENWNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:13:47 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:46788 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbaENWNm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:42 -0400
Received: by mail-vc0-f202.google.com with SMTP id hr9so442036vcb.3
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zgi5TRJKQDvizABH2uRFu8gpoRHGizk/cHTbDftD5go=;
        b=TaJ8wWC+6GWRqZNoKMG6/BYYzGW7U75RarDTJfFCNXeCoCpoZeitEjS7WzcQzwiAoZ
         LH9L/ZnLTsT5/kMliQmMbuLvRgUO8ULexWzmNFHeJg3wZ7Wce6+v+J56pU9aJgR7da0n
         K2F8keUCTGM9Q9ltCbsnuEQ5BG0E/VeSyD0BswjDiGeUOGncTiE33ZRBKngYXf1px0AM
         iYGvhZDpCWd4/DQPVtrFoQTLUWQviOXQTFgTNLh6zMLJ0XdvHYbLMmgj5sdA7+TNLGUu
         v7fknjOjMowYH0tsyF2+HJ9ymmIhm+ubTaJ+z8KwueOy5GwXqkS1vb85gOCV41FtK0kz
         m9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zgi5TRJKQDvizABH2uRFu8gpoRHGizk/cHTbDftD5go=;
        b=Ir29lFVYBQNTii0htRXRBnVP5bcjDbKZFWkNrynM0lqY/E7A0VWzSUdjW/sLqVh/gP
         sot9WlbPoukjCWZKc79b3qwC2xZPA34dy+S2IGSkFf98jF0RMLb6zTTdgnFu5zxlkYv0
         3frEZvhviG9v3pkSxlsmLV9jnT8FP5PTU7P20A2yMkf987cttbwFWHeP8BsEBn/luTD1
         2hJNbH1NZJUqeCxQg/fbp8xvkbpy+sEcUSRhE6QSj8m9xw8TG7mGHggMlNIXpz8f3xzV
         ps7MNuKdBqvAxHlQJBOc2wYUUNtG2P1CXV+hphKqbAoxHGnZLObcxZp0UgEMH2nx+MQj
         +azA==
X-Gm-Message-State: ALoCoQlOhrRvN7iIa3rLFzdsA4UvPBbW8o1ctbrF5w+gfI9kW6F9uv6MWPFvxYhxfiPFaK6VUVa1
X-Received: by 10.236.31.40 with SMTP id l28mr2727679yha.34.1400105622011;
        Wed, 14 May 2014 15:13:42 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si151878yhk.4.2014.05.14.15.13.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:42 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id DA0865A41E5;
	Wed, 14 May 2014 15:13:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9EDABE0973; Wed, 14 May 2014 15:13:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249014>

We no longer need to expose the ref_lock structure to any external callers.
Make it private to refs.c.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 9 +++++++++
 refs.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 918cda3..8129b20 100644
--- a/refs.c
+++ b/refs.c
@@ -5,6 +5,15 @@
 #include "dir.h"
 #include "string-list.h"
 
+struct ref_lock {
+	char *ref_name;
+	char *orig_ref_name;
+	struct lock_file *lk;
+	unsigned char old_sha1[20];
+	int lock_fd;
+	int force_write;
+};
+
 /*
  * Make sure "ref" is something reasonable to have under ".git/refs/";
  * We do not like it if:
diff --git a/refs.h b/refs.h
index 1e89187..558a711 100644
--- a/refs.h
+++ b/refs.h
@@ -1,15 +1,6 @@
 #ifndef REFS_H
 #define REFS_H
 
-struct ref_lock {
-	char *ref_name;
-	char *orig_ref_name;
-	struct lock_file *lk;
-	unsigned char old_sha1[20];
-	int lock_fd;
-	int force_write;
-};
-
 struct ref_transaction;
 
 /*
-- 
2.0.0.rc3.506.g3739a35
