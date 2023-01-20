Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7987C25B50
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjATWJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjATWJA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:09:00 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EADA314C
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:08:56 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso4662020wms.3
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QfNUqa5/m+ZSldR0jAxuOmtcZQE1zGK1yQCte9bfm4=;
        b=nZQSbD0FWZnQGAa/ezbE8WXiWiqn75fuXFvDbJKaaVPhFTNXA593uCTH5iGQsFtqg2
         dFl/HEedhhB4bslm3b4LKLXC+d3RAHtVpHlMf4LFn7XO+I/7oDpMsLv+9dpgk6EHBGiC
         4rFLnKoYNbOExiSQNQBF15A8k4zI59wFLOBCPoCaRoNmTSpF9W2d/nAINAU2w0HEHYLw
         M6eBxVjd9CS4FHrDyjn9MCvF0hpUBZPI9q3F26KZkk/8QnZfJIQXZbpEa6OtJ89B8y1z
         OwG0feuMxQg3JDkV7Fol6fiTFhKssHhssPjTi11fB1PJ3L9+HGP8AZAnDM92XicjeCGo
         lzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QfNUqa5/m+ZSldR0jAxuOmtcZQE1zGK1yQCte9bfm4=;
        b=eozYWs8G6MkIHzBJGJmXzjJfybUgGH47J2NvtoeCVTA2uL5bbgxCx+DRBT5G/yFbOF
         ZPe2ZWecu9o9at5UPwCDmcMX6jHarNhzwc7NhBcN237Ougd7t7ctc8FU2HRrSW8IVifp
         Q8Kz3L0LBjCUcs9EhoPcoPocqDF6voAI4i7gfAFwYsK2LmNbIqXV5ctjIPuB4r7NcCX2
         Hru1fGLcEuaQyKv5AHuwRSz13XvMcSK2/aJymAHvD784hpondnkGTr8Bnvh6oUwk14Q+
         WCWRWT/cUaTfj72lWIkh/k+9W80y3FsMKfVZqgneIUoh964gycoRAN5iPHiKgkgdPsWF
         HzPg==
X-Gm-Message-State: AFqh2kqn5zHh0Gv/MWGpQL6cLM99FACHfJ0hhL3YDkd/tgqH3OQomV+B
        7MMSAwtQUPe/9xAJiNYVXB8Fd3yxzqI=
X-Google-Smtp-Source: AMrXdXtyeWR/XZdqUSFwgv+0KN5sNLYv7u7jTjFsUj0RoO5z0fYOVcgTZ6fhigTAXLJK8zbSkOThYA==
X-Received: by 2002:a05:600c:34d1:b0:3db:1434:c51a with SMTP id d17-20020a05600c34d100b003db1434c51amr10538590wmq.40.1674252534381;
        Fri, 20 Jan 2023 14:08:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10-20020a1c7c0a000000b003da119d7251sm3308460wmc.21.2023.01.20.14.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 14:08:54 -0800 (PST)
Message-Id: <b6ba344a671c674d1caf577194eddd66eb7e1415.1674252531.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Jan 2023 22:08:40 +0000
Subject: [PATCH v7 02/12] daemon: libify child process handling functions
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Matthew John Cheetham <mjcheetham@outlook.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Extract functions and structures for managing child processes started
from the parent daemon-like process from `daemon.c` to the new shared
`daemon-utils.{c,h}` files.

One minor functional change is introduced to `check_dead_children()`
where the logging of a dead/disconnected child is now optional. With the
'libification' of these functions we extract the call to `loginfo` to a
call to a function pointer, and guard the log message creation and
logging behind a `NULL` check. Callers can now skip logging by passing
`NULL` as the `log_fn loginfo` argument.
The behaviour of callers in `daemon.c` remains the same (save one extra
NULL check)  however as a pointer to `loginfo` is always passed.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 daemon-utils.c | 77 ++++++++++++++++++++++++++++++++++++++++++
 daemon-utils.h | 32 ++++++++++++++++++
 daemon.c       | 92 +++-----------------------------------------------
 3 files changed, 114 insertions(+), 87 deletions(-)

diff --git a/daemon-utils.c b/daemon-utils.c
index b96b55962db..8506664b440 100644
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
+	(*live_children)++;
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
+			(*live_children)--;
+			child_process_clear(&blanket->cld);
+			free(blanket);
+		} else
+			cradle = &blanket->next;
+}
diff --git a/daemon-utils.h b/daemon-utils.h
index 6710a2a6dc0..97e5cae20b8 100644
--- a/daemon-utils.h
+++ b/daemon-utils.h
@@ -2,6 +2,7 @@
 #define DAEMON_UTILS_H
 
 #include "git-compat-util.h"
+#include "run-command.h"
 #include "string-list.h"
 
 typedef void (*log_fn)(const char *msg, ...);
@@ -20,4 +21,35 @@ void socksetup(struct string_list *listen_addr, int listen_port,
 	       struct socketlist *socklist, int reuseaddr,
 	       log_fn logerror);
 
+struct child {
+	struct child *next;
+	struct child_process cld;
+	struct sockaddr_storage address;
+};
+
+/*
+ * Add the child_process to the set of children and increment the number of
+ * live children.
+ */
+void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen,
+	       struct child *firstborn, unsigned int *live_children);
+
+/*
+ * Kill the newest connection from a duplicate IP.
+ *
+ * This function should be called if the number of connections grows
+ * past the maximum number of allowed connections.
+ */
+void kill_some_child(struct child *firstborn);
+
+/*
+ * Check for children that have disconnected and remove them from the
+ * active set, decrementing the number of live children.
+ *
+ * Optionally log the child PID that disconnected by passing a loginfo
+ * function.
+ */
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

