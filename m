Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC44C46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 22:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbjAKWNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbjAKWNR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 17:13:17 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2443E0E1
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:15 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso9380331wms.0
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rsb9nNGK6aVNwlCaEC3jjexZfnZ8WeFAlLgzTSFgXug=;
        b=l7g9Zmx1AhK/bfwzU1c4vfF+xyGFFIsMUoYkDtN7CjbZSH2HsQD2/8Bz5S2TdIzts/
         My9TnB1JIe/cNfvJMDHv++V++bIO3J96+R0ydCYdhk8zqYXuqD7Yju2fTEBi3k4JWLIL
         /qFUBeHnGjyGqPhDRcV8pyX3NNWv98yL/iKPPsXySCNz7o3DHbi9OpozrlxTMdxmynTY
         4YPbh41IkXYVHgGKhBJTUC3TlheSwzRkuNBLFyNSOlt4+9QD3FVZjPhMFDDS5TmKVUZI
         VrfV6qf9nyk7YsSOg01YNnoVafT47lQNVQVb0ydMG2Sa+HuVknJDoN8ZKeTEXOmahAMv
         pmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rsb9nNGK6aVNwlCaEC3jjexZfnZ8WeFAlLgzTSFgXug=;
        b=k0BDqN6uFfrpsnbdM0QNcKz677joYN9b3rM8AEQ4NKRgU6o8+Hrv8Xdq3+tS0LVY4E
         hzvzrnHLpwsJUkL/bOZiXYVCngvg2PmMCKeG376uUbnRxXz92xy6uiTmqx9eO4dZGrRu
         D4hVoD9zUtbRoovth9bQvyxairO/1nvhzSId6RJR7yVj4eIAzMze7aw0kc+ABjqk2N5r
         D2gxMJDNJERxsISNCZws4GSNiezDU7TgBf0FCNlUVjMPGzJvUA75hl+kHoLup0AF1jsY
         g0UPfd7jqazMcifjUVGRAyFyxqZMafNNlk78LeFkLEsa12+WieE3dSNVfw1WDJXXHyeL
         iQeQ==
X-Gm-Message-State: AFqh2kqcVdQE7eiA+v2Mbas8H2XFOWLvsoUNMrA0sxjtXPynI4vR5Xr9
        GcNEkVV4qna/c1JbfqEag6N+nVHnTJE=
X-Google-Smtp-Source: AMrXdXsDnJLKgB6zzwIXGoAkVjz8iKCHKMwfBQaTs0z6AJkSsUvQPJLrJQeEYCS8zIgqdX00Xr2yGA==
X-Received: by 2002:a05:600c:358f:b0:3d9:7847:96e2 with SMTP id p15-20020a05600c358f00b003d9784796e2mr43905081wmq.2.1673475194258;
        Wed, 11 Jan 2023 14:13:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003da0b75de94sm3271396wmq.8.2023.01.11.14.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 14:13:13 -0800 (PST)
Message-Id: <bc972fc8d3d3a028d3d160aac354d2a13bad37ae.1673475190.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
        <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Jan 2023 22:13:02 +0000
Subject: [PATCH v5 02/10] daemon: libify child process handling functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Extract functions and structures for managing child processes started
from the parent daemon-like process from `daemon.c` to the new shared
`daemon-utils.{c,h}` files.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 daemon-utils.c | 77 ++++++++++++++++++++++++++++++++++++++++++
 daemon-utils.h | 15 ++++++++
 daemon.c       | 92 +++-----------------------------------------------
 3 files changed, 97 insertions(+), 87 deletions(-)

diff --git a/daemon-utils.c b/daemon-utils.c
index b96b55962db..3804bc60973 100644
--- a/daemon-utils.c
+++ b/daemon-utils.c
@@ -207,3 +207,80 @@ void socksetup(struct string_list *listen_addr, int listen_port,
 		}
 	}
 }
+
+static int addrcmp(const struct sockaddr_storage *s1,
+    const struct sockaddr_storage *s2)
+{
+	const struct sockaddr *sa1 = (const struct sockaddr*) s1;
+	const struct sockaddr *sa2 = (const struct sockaddr*) s2;
+
+	if (sa1->sa_family != sa2->sa_family)
+		return sa1->sa_family - sa2->sa_family;
+	if (sa1->sa_family == AF_INET)
+		return memcmp(&((struct sockaddr_in *)s1)->sin_addr,
+		    &((struct sockaddr_in *)s2)->sin_addr,
+		    sizeof(struct in_addr));
+#ifndef NO_IPV6
+	if (sa1->sa_family == AF_INET6)
+		return memcmp(&((struct sockaddr_in6 *)s1)->sin6_addr,
+		    &((struct sockaddr_in6 *)s2)->sin6_addr,
+		    sizeof(struct in6_addr));
+#endif
+	return 0;
+}
+
+void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen,
+	       struct child *firstborn , unsigned int *live_children)
+{
+	struct child *newborn, **cradle;
+
+	CALLOC_ARRAY(newborn, 1);
+	live_children++;
+	memcpy(&newborn->cld, cld, sizeof(*cld));
+	memcpy(&newborn->address, addr, addrlen);
+	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
+		if (!addrcmp(&(*cradle)->address, &newborn->address))
+			break;
+	newborn->next = *cradle;
+	*cradle = newborn;
+}
+
+void kill_some_child(struct child *firstborn)
+{
+	const struct child *blanket, *next;
+
+	if (!(blanket = firstborn))
+		return;
+
+	for (; (next = blanket->next); blanket = next)
+		if (!addrcmp(&blanket->address, &next->address)) {
+			kill(blanket->cld.pid, SIGTERM);
+			break;
+		}
+}
+
+void check_dead_children(struct child *firstborn, unsigned int *live_children,
+			 log_fn loginfo)
+{
+	int status;
+	pid_t pid;
+
+	struct child **cradle, *blanket;
+	for (cradle = &firstborn; (blanket = *cradle);)
+		if ((pid = waitpid(blanket->cld.pid, &status, WNOHANG)) > 1) {
+			if (loginfo) {
+				const char *dead = "";
+				if (status)
+					dead = " (with error)";
+				loginfo("[%"PRIuMAX"] Disconnected%s",
+					(uintmax_t)pid, dead);
+			}
+
+			/* remove the child */
+			*cradle = blanket->next;
+			live_children--;
+			child_process_clear(&blanket->cld);
+			free(blanket);
+		} else
+			cradle = &blanket->next;
+}
diff --git a/daemon-utils.h b/daemon-utils.h
index 6710a2a6dc0..fe8d9d05256 100644
--- a/daemon-utils.h
+++ b/daemon-utils.h
@@ -2,6 +2,7 @@
 #define DAEMON_UTILS_H
 
 #include "git-compat-util.h"
+#include "run-command.h"
 #include "string-list.h"
 
 typedef void (*log_fn)(const char *msg, ...);
@@ -20,4 +21,18 @@ void socksetup(struct string_list *listen_addr, int listen_port,
 	       struct socketlist *socklist, int reuseaddr,
 	       log_fn logerror);
 
+struct child {
+	struct child *next;
+	struct child_process cld;
+	struct sockaddr_storage address;
+};
+
+void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen,
+	       struct child *firstborn, unsigned int *live_children);
+
+void kill_some_child(struct child *firstborn);
+
+void check_dead_children(struct child *firstborn, unsigned int *live_children,
+			 log_fn loginfo);
+
 #endif
diff --git a/daemon.c b/daemon.c
index 1ed4e705680..ec3b407ecbc 100644
--- a/daemon.c
+++ b/daemon.c
@@ -785,93 +785,11 @@ static int execute(void)
 	return -1;
 }
 
-static int addrcmp(const struct sockaddr_storage *s1,
-    const struct sockaddr_storage *s2)
-{
-	const struct sockaddr *sa1 = (const struct sockaddr*) s1;
-	const struct sockaddr *sa2 = (const struct sockaddr*) s2;
-
-	if (sa1->sa_family != sa2->sa_family)
-		return sa1->sa_family - sa2->sa_family;
-	if (sa1->sa_family == AF_INET)
-		return memcmp(&((struct sockaddr_in *)s1)->sin_addr,
-		    &((struct sockaddr_in *)s2)->sin_addr,
-		    sizeof(struct in_addr));
-#ifndef NO_IPV6
-	if (sa1->sa_family == AF_INET6)
-		return memcmp(&((struct sockaddr_in6 *)s1)->sin6_addr,
-		    &((struct sockaddr_in6 *)s2)->sin6_addr,
-		    sizeof(struct in6_addr));
-#endif
-	return 0;
-}
-
 static int max_connections = 32;
 
 static unsigned int live_children;
 
-static struct child {
-	struct child *next;
-	struct child_process cld;
-	struct sockaddr_storage address;
-} *firstborn;
-
-static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen)
-{
-	struct child *newborn, **cradle;
-
-	CALLOC_ARRAY(newborn, 1);
-	live_children++;
-	memcpy(&newborn->cld, cld, sizeof(*cld));
-	memcpy(&newborn->address, addr, addrlen);
-	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
-		if (!addrcmp(&(*cradle)->address, &newborn->address))
-			break;
-	newborn->next = *cradle;
-	*cradle = newborn;
-}
-
-/*
- * This gets called if the number of connections grows
- * past "max_connections".
- *
- * We kill the newest connection from a duplicate IP.
- */
-static void kill_some_child(void)
-{
-	const struct child *blanket, *next;
-
-	if (!(blanket = firstborn))
-		return;
-
-	for (; (next = blanket->next); blanket = next)
-		if (!addrcmp(&blanket->address, &next->address)) {
-			kill(blanket->cld.pid, SIGTERM);
-			break;
-		}
-}
-
-static void check_dead_children(void)
-{
-	int status;
-	pid_t pid;
-
-	struct child **cradle, *blanket;
-	for (cradle = &firstborn; (blanket = *cradle);)
-		if ((pid = waitpid(blanket->cld.pid, &status, WNOHANG)) > 1) {
-			const char *dead = "";
-			if (status)
-				dead = " (with error)";
-			loginfo("[%"PRIuMAX"] Disconnected%s", (uintmax_t)pid, dead);
-
-			/* remove the child */
-			*cradle = blanket->next;
-			live_children--;
-			child_process_clear(&blanket->cld);
-			free(blanket);
-		} else
-			cradle = &blanket->next;
-}
+static struct child *firstborn;
 
 static struct strvec cld_argv = STRVEC_INIT;
 static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
@@ -879,9 +797,9 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 	struct child_process cld = CHILD_PROCESS_INIT;
 
 	if (max_connections && live_children >= max_connections) {
-		kill_some_child();
+		kill_some_child(firstborn);
 		sleep(1);  /* give it some time to die */
-		check_dead_children();
+		check_dead_children(firstborn, &live_children, loginfo);
 		if (live_children >= max_connections) {
 			close(incoming);
 			logerror("Too many children, dropping connection");
@@ -914,7 +832,7 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 	if (start_command(&cld))
 		logerror("unable to fork");
 	else
-		add_child(&cld, addr, addrlen);
+		add_child(&cld, addr, addrlen, firstborn, &live_children);
 }
 
 static void child_handler(int signo)
@@ -944,7 +862,7 @@ static int service_loop(struct socketlist *socklist)
 	for (;;) {
 		int i;
 
-		check_dead_children();
+		check_dead_children(firstborn, &live_children, loginfo);
 
 		if (poll(pfd, socklist->nr, -1) < 0) {
 			if (errno != EINTR) {
-- 
gitgitgadget

