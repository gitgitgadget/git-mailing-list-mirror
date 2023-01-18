Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300F7C00A5A
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 03:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjARDaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 22:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjARDaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 22:30:25 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E015087C
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:23 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e3so23384631wru.13
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QfNUqa5/m+ZSldR0jAxuOmtcZQE1zGK1yQCte9bfm4=;
        b=IbB11nuBw+q+ahHnH7MgLfBVxWymxbbd2DSh4GxRbU8lsFDq6YUzeiRQUolSwc9Mv8
         o+a6fZPXPQ1ly+Y/Mu2ZkQSbcl5oFrR6F48nsHhud83HNobdmdqlz0Xi4CJG7BYEf0K4
         3pYsnhexgB3aKsVbIBKR8WPp3DOEpqf8YvfyM5EO7pFQ03rCwyjlCgKtuDXn2gbFOtt9
         p7vW+Tfa0MNIg3cKDHY3BZvUrcLUEVSq2/cWKx5Av3oAFT8SPvbJp0ZZSpvB1CXwsgqi
         Qa/dKQl4JSinG52JKX7C3GDgGf7XrzufkrvwgowtFJH6bE9ls43o8VhNTrPiW62vLViP
         UIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QfNUqa5/m+ZSldR0jAxuOmtcZQE1zGK1yQCte9bfm4=;
        b=1WVDnsCVKshSu/MAPt2wFAnPcNSW7uSukkFrn4Oz77Q4NVqrl9PdjTfbwuunaa6/vq
         rrabBDPyO2FyaP2ADNeDob18HBTIf6d3TRwNapFUN1+dtWTDtK0/rsX0kqLG3Euh4eT6
         UbueXv7Lka5o5cawQv0ic6zwqKbLJT/LuZ0ypspsDHgOE6JCzUQI1SthtyILeW1Dt949
         iNfud0RIKvbXKroETW4KuDZqSBKvhwWTrrcmPc3jXNvBk8mvKuuJl8q8yxWVJh0ST/9I
         5vb97J6DY2Mj1bpOABRf/o1RDUiJ3U1VmgxH9TgvdCe1ewrp3dXgUC3mzHugxOwSyrGR
         qr1g==
X-Gm-Message-State: AFqh2koksPf/uTjdwVpTnk2nEZE2pO1S6NpGXfwFqAylZ61bz3VZIUXq
        T8kG7ZgVG/7RMZ1iJtaXZC/5titxlCw=
X-Google-Smtp-Source: AMrXdXvGCi7qeuEgmOCGqAS4oM+MG7YqFOs716gQ3WWZMkARdbmY1bI4jI8xU6otpK+nkPl9S0UOfw==
X-Received: by 2002:a5d:5c07:0:b0:2bd:fa1d:5291 with SMTP id cc7-20020a5d5c07000000b002bdfa1d5291mr5214541wrb.67.1674012621925;
        Tue, 17 Jan 2023 19:30:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15-20020adfd20f000000b002be2a4b521fsm1694808wrh.45.2023.01.17.19.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 19:30:21 -0800 (PST)
Message-Id: <b6ba344a671c674d1caf577194eddd66eb7e1415.1674012618.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
        <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Jan 2023 03:30:07 +0000
Subject: [PATCH v6 02/12] daemon: libify child process handling functions
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
        <avarab@gmail.com>, Matthew John Cheetham <mjcheetham@github.com>,
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

