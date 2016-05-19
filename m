From: David Turner <dturner@twopensource.com>
Subject: [PATCH v12 14/20] watchman: add a config option to enable the extension
Date: Thu, 19 May 2016 17:45:51 -0400
Message-ID: <1463694357-6503-15-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 23:47:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Vmw-0006yO-Sb
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932882AbcESVrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 17:47:20 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33990 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932484AbcESVqz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:46:55 -0400
Received: by mail-qk0-f178.google.com with SMTP id y126so21163349qke.1
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8GKu5Jdg1IlWDzlO/dIkgQxPPc7PoMPl6wocKRh+smM=;
        b=mP+OptBUk//6glICzQ4qs8ER5xgoh4uEG3qO4y4rDivm9rGCcIuVwa/03n0jwNjVck
         vJraJXgHOdd3N6+5KIp2cqzxLBvyYD2AVmJ7id+N3xzGkmEya589iF+tiui30Z2IHpc2
         k7a1SX8CJGvWKd56OA8tuD4z6wZrWBplAh7KTK1elhqWszpEKQBOunq8g80bxv6ey81V
         4OUS/brd9aEIWH/QfcsFOo0KlkSL/6moJYyCGfehEcSpu1icKNupGYyhYLzkpiH4U7LX
         NMqasiMKVI19pp/pUpVck+m46rhD50sBoPN57PdogPtXk0I1NfkNORC464ZEkSwPP5Hy
         12XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8GKu5Jdg1IlWDzlO/dIkgQxPPc7PoMPl6wocKRh+smM=;
        b=dH0R4Bqu/jogHK+o2f8WK/InNoWntp4lOLUz1/zo+ZIpwC/TBQ2IK9jk4SeTo68O21
         4X2T3HXUQWHTcJZNWr6ey/MCNFokDwqcTC8hh4e1fgmFPDG9bH/1E25muHNVP76wrDnp
         psNN8AZ3LBFE4mThd1BK/lfHcojFRa2KlFb/vSxqCJ9itK2zXqq2uUZPUxCDqV7fXrbk
         avrjYia2Z4sqfJGsUzz2D3yoRXFfGYWtBONFGz7UYb6Z02LvmtPyVzKlX8Z8UbxE5THp
         cSCh2B7JxmFrg1XKqLRlEZRug6xMM5LY0/UReSyud+10KQ0nqTIM1rpGGahDtg1S4sJs
         ISAQ==
X-Gm-Message-State: AOPr4FViP6WPwqqL9fyIGXTVAvAA07yu2OyqsL0qE3GcJOnve8jYMhoFW2x+P6qu8IL5xg==
X-Received: by 10.55.101.20 with SMTP id z20mr17415504qkb.80.1463694413971;
        Thu, 19 May 2016 14:46:53 -0700 (PDT)
Received: from twopensource.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id r124sm7424730qhr.48.2016.05.19.14.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 14:46:52 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295121>

For installations that have centrally-managed configuration, it's
easier to set a config once than to run update-index on every
repository.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 .gitignore                    |  1 +
 Documentation/config.txt      |  4 ++++
 Makefile                      |  1 +
 read-cache.c                  |  6 ++++++
 t/t1701-watchman-extension.sh | 37 +++++++++++++++++++++++++++++++++++++
 test-dump-watchman.c          | 16 ++++++++++++++++
 6 files changed, 65 insertions(+)
 create mode 100755 t/t1701-watchman-extension.sh
 create mode 100644 test-dump-watchman.c

diff --git a/.gitignore b/.gitignore
index b92f122..e6a5b2c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -188,6 +188,7 @@
 /test-dump-cache-tree
 /test-dump-split-index
 /test-dump-untracked-cache
+/test-dump-watchman
 /test-fake-ssh
 /test-scrap-cache-tree
 /test-genrandom
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..15001ce 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1848,6 +1848,10 @@ imap::
 	The configuration variables in the 'imap' section are described
 	in linkgit:git-imap-send[1].
 
+index.addwatchmanextension::
+	Automatically add the watchman extension to the index whenever
+	it is written.
+
 index.version::
 	Specify the version with which new index files should be
 	initialized.  This does not affect existing repositories.
diff --git a/Makefile b/Makefile
index 65ab0f4..5f0a954 100644
--- a/Makefile
+++ b/Makefile
@@ -599,6 +599,7 @@ TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-dump-split-index
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
+TEST_PROGRAMS_NEED_X += test-dump-watchman
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-genrandom
 TEST_PROGRAMS_NEED_X += test-hashmap
diff --git a/read-cache.c b/read-cache.c
index 82d4446..6d3fe71 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2426,6 +2426,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 	int entries = istate->cache_nr;
 	struct stat st;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
+	int watchman = 0;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -2449,6 +2450,11 @@ static int do_write_index(struct index_state *istate, int newfd,
 	if (istate->version == 3 || istate->version == 2)
 		istate->version = extended ? 3 : 2;
 
+	if (!git_config_get_bool("index.addwatchmanextension", &watchman) &&
+	    watchman &&
+	    !the_index.last_update)
+		the_index.last_update = xstrdup("");
+
 	hdr_version = istate->version;
 
 	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
diff --git a/t/t1701-watchman-extension.sh b/t/t1701-watchman-extension.sh
new file mode 100755
index 0000000..71f1d46
--- /dev/null
+++ b/t/t1701-watchman-extension.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='watchman extension smoke tests'
+
+# These don't actually test watchman interaction -- just the
+# index extension
+
+. ./test-lib.sh
+
+test_expect_success 'enable watchman' '
+	test_commit a &&
+	test-dump-watchman .git/index >actual &&
+	echo "last_update: (null)" >expect &&
+	test_cmp expect actual &&
+	git update-index --watchman &&
+	test-dump-watchman .git/index >actual &&
+	echo "last_update: " >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'disable watchman' '
+	git update-index --no-watchman &&
+	test-dump-watchman .git/index >actual &&
+	echo "last_update: (null)" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'auto-enable watchman' '
+	test_config index.addwatchmanextension true &&
+	test_commit c &&
+	test-dump-watchman .git/index >actual &&
+	echo "last_update: " >expect &&
+	test_cmp expect actual
+'
+
+
+test_done
diff --git a/test-dump-watchman.c b/test-dump-watchman.c
new file mode 100644
index 0000000..0314fa5
--- /dev/null
+++ b/test-dump-watchman.c
@@ -0,0 +1,16 @@
+#include "cache.h"
+#include "ewah/ewok.h"
+
+int main(int argc, char **argv)
+{
+	do_read_index(&the_index, argv[1], 1);
+	printf("last_update: %s\n", the_index.last_update ?
+	       the_index.last_update : "(null)");
+
+	/*
+	 * For now, we just dump last_update, since it is not reasonable
+	 * to populate the extension itself in tests.
+	 */
+
+	return 0;
+}
-- 
2.4.2.767.g62658d5-twtrsrc
