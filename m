Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A951C4167B
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiLLVgn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbiLLVgd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:36:33 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B03A1B6
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:36:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so6503394wms.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivi5Q9Uwsih/vMfDfz8elbck+Im+cI6/2ViNodEJxPQ=;
        b=fJM1vAqx7UMu5RSVJuhVY+S/pmRJ+Tx+CpjfAmD+55uQw5Spf9Zt+KHatLeWZw1mYn
         H+uBgDBA1/2k6GKZi5tvECB7NDaqWs7aVNTxI8x8KsizwRbffHo3AzpUIuEvIGwxlTgC
         1R32TBnF1CxkR7sO14MFuN/Lbw3TqDzOguki2AVQ3AbNrx0vYjvO3uetskrc2fyBVPpB
         JshXkOHOIPQXQNpzabaSlzZyA3cQMNCPFJ8vSYtkI2gtPyCOMf2cL+t5GEnrEdGPmijd
         /FWmI/nDH+Sh9aXQWezwzvgxI31KdWouHksrjogTLOPxY9iEZ6CX746r+YbpsVxnuCaD
         0k6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivi5Q9Uwsih/vMfDfz8elbck+Im+cI6/2ViNodEJxPQ=;
        b=y8oMGQx9QYEcSMSz6qY2N1wU4aisHduOGtsi53qth4ou8HDKd6HTCnuakoL5kKIOAI
         7f2obGe+zsIk8zXJQaCbILZcgtf1giVbJvifctdALeHKAiBl2h/rAM75UZFbOBSehJF7
         E7EOjOPyQ+a9aFGOJxKKg3Iu4pnasDNPzemDeiG7VLscTK0PByPVHVXxZZKk8w3YNYIp
         F9r/6S9qkdMoxureGuo7SJmQYVpN3crx2WdOvlSZT9ZC070KQ0IkS7Tgy01b160jL14s
         ODI6Vv8NtCujjtCgscIsYS0t2W5YqpoRb0SlKRg6jVf22VZy46y9nJcy3vTBUjwvzfw9
         x2CQ==
X-Gm-Message-State: ANoB5pnByC46qbyeBE1MbfyXga/I1MxC4ukP63kwK8RVLuXGbzOYmZeE
        65J0nywQjN64d9nybuv40oftiGLQ9ZQ=
X-Google-Smtp-Source: AA0mqf7qy3u1Eu76KmPp+rqzS3DMJ2k5sDc0bzt2UFNs0hHr2YQnDI14Ois3Tb/+yfUJW8BOcq/tyQ==
X-Received: by 2002:a05:600c:4891:b0:3d1:fbf9:3bd4 with SMTP id j17-20020a05600c489100b003d1fbf93bd4mr13396568wmp.10.1670880989224;
        Mon, 12 Dec 2022 13:36:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c3b1100b003c6b7f5567csm58279wms.0.2022.12.12.13.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:36:28 -0800 (PST)
Message-Id: <07a1845ea5693fc8d3716e7f97e65d467f34a40e.1670880984.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
        <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 21:36:18 +0000
Subject: [PATCH v4 3/8] test-http-server: add stub HTTP server test helper
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
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Introduce a mini HTTP server helper that in the future will be enhanced
to provide a frontend for the git-http-backend, with support for
arbitrary authentication schemes.

Right now, test-http-server is a pared-down copy of the git-daemon that
always returns a 501 Not Implemented response to all callers.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 Makefile                            |   2 +
 contrib/buildsystems/CMakeLists.txt |  13 +
 t/helper/.gitignore                 |   1 +
 t/helper/test-http-server.c         | 685 ++++++++++++++++++++++++++++
 4 files changed, 701 insertions(+)
 create mode 100644 t/helper/test-http-server.c

diff --git a/Makefile b/Makefile
index b258fdbed86..1eb795bbfd4 100644
--- a/Makefile
+++ b/Makefile
@@ -1611,6 +1611,8 @@ else
 	endif
 	BASIC_CFLAGS += $(CURL_CFLAGS)
 
+	TEST_PROGRAMS_NEED_X += test-http-server
+
 	REMOTE_CURL_PRIMARY = git-remote-http$X
 	REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 2f6e0197ffa..e9b9bfbb437 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -989,6 +989,19 @@ set(wrapper_scripts
 set(wrapper_test_scripts
 	test-fake-ssh test-tool)
 
+if(CURL_FOUND)
+       list(APPEND wrapper_test_scripts test-http-server)
+
+       add_executable(test-http-server ${CMAKE_SOURCE_DIR}/t/helper/test-http-server.c)
+       target_link_libraries(test-http-server common-main)
+
+       if(MSVC)
+               set_target_properties(test-http-server
+                                       PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/t/helper)
+               set_target_properties(test-http-server
+                                       PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/helper)
+       endif()
+endif()
 
 foreach(script ${wrapper_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index 8c2ddcce95f..9aa9c752997 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -1,2 +1,3 @@
 /test-tool
 /test-fake-ssh
+/test-http-server
diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
new file mode 100644
index 00000000000..18f1f741305
--- /dev/null
+++ b/t/helper/test-http-server.c
@@ -0,0 +1,685 @@
+#include "config.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "string-list.h"
+#include "trace2.h"
+#include "version.h"
+#include "dir.h"
+#include "date.h"
+
+#define TR2_CAT "test-http-server"
+
+static const char *pid_file;
+static int verbose;
+static int reuseaddr;
+
+static const char test_http_auth_usage[] =
+"http-server [--verbose]\n"
+"           [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]\n"
+"           [--reuseaddr] [--pid-file=<file>]\n"
+"           [--listen=<host_or_ipaddr>]* [--port=<n>]\n"
+;
+
+/* Timeout, and initial timeout */
+static unsigned int timeout;
+static unsigned int init_timeout;
+
+static void logreport(const char *label, const char *err, va_list params)
+{
+	struct strbuf msg = STRBUF_INIT;
+
+	strbuf_addf(&msg, "[%"PRIuMAX"] %s: ", (uintmax_t)getpid(), label);
+	strbuf_vaddf(&msg, err, params);
+	strbuf_addch(&msg, '\n');
+
+	fwrite(msg.buf, sizeof(char), msg.len, stderr);
+	fflush(stderr);
+
+	strbuf_release(&msg);
+}
+
+__attribute__((format (printf, 1, 2)))
+static void logerror(const char *err, ...)
+{
+	va_list params;
+	va_start(params, err);
+	logreport("error", err, params);
+	va_end(params);
+}
+
+__attribute__((format (printf, 1, 2)))
+static void loginfo(const char *err, ...)
+{
+	va_list params;
+	if (!verbose)
+		return;
+	va_start(params, err);
+	logreport("info", err, params);
+	va_end(params);
+}
+
+static void set_keep_alive(int sockfd)
+{
+	int ka = 1;
+
+	if (setsockopt(sockfd, SOL_SOCKET, SO_KEEPALIVE, &ka, sizeof(ka)) < 0) {
+		if (errno != ENOTSOCK)
+			logerror("unable to set SO_KEEPALIVE on socket: %s",
+				strerror(errno));
+	}
+}
+
+/*
+ * The code in this section is used by "worker" instances to service
+ * a single connection from a client.  The worker talks to the client
+ * on 0 and 1.
+ */
+
+enum worker_result {
+	/*
+	 * Operation successful.
+	 * Caller *might* keep the socket open and allow keep-alive.
+	 */
+	WR_OK       = 0,
+
+	/*
+	 * Various errors while processing the request and/or the response.
+	 * Close the socket and clean up.
+	 * Exit child-process with non-zero status.
+	 */
+	WR_IO_ERROR = 1<<0,
+
+	/*
+	 * Close the socket and clean up.  Does not imply an error.
+	 */
+	WR_HANGUP   = 1<<1,
+
+	WR_STOP_THE_MUSIC = (WR_IO_ERROR | WR_HANGUP),
+};
+
+static enum worker_result worker(void)
+{
+	const char *response = "HTTP/1.1 501 Not Implemented\r\n";
+	char *client_addr = getenv("REMOTE_ADDR");
+	char *client_port = getenv("REMOTE_PORT");
+	enum worker_result wr = WR_OK;
+
+	if (client_addr)
+		loginfo("Connection from %s:%s", client_addr, client_port);
+
+	set_keep_alive(0);
+
+	while (1) {
+		if (write_in_full(1, response, strlen(response)) < 0) {
+			logerror("unable to write response");
+			wr = WR_IO_ERROR;
+		}
+
+		if (wr & WR_STOP_THE_MUSIC)
+			break;
+	}
+
+	close(0);
+	close(1);
+
+	return !!(wr & WR_IO_ERROR);
+}
+
+/*
+ * This section contains the listener and child-process management
+ * code used by the primary instance to accept incoming connections
+ * and dispatch them to async child process "worker" instances.
+ */
+
+static int addrcmp(const struct sockaddr_storage *s1,
+		   const struct sockaddr_storage *s2)
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
+static int max_connections = 32;
+
+static unsigned int live_children;
+
+static struct child {
+	struct child *next;
+	struct child_process cld;
+	struct sockaddr_storage address;
+} *firstborn;
+
+static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen)
+{
+	struct child *newborn, **cradle;
+
+	newborn = xcalloc(1, sizeof(*newborn));
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
+/*
+ * This gets called if the number of connections grows
+ * past "max_connections".
+ *
+ * We kill the newest connection from a duplicate IP.
+ */
+static void kill_some_child(void)
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
+static void check_dead_children(void)
+{
+	int status;
+	pid_t pid;
+
+	struct child **cradle, *blanket;
+	for (cradle = &firstborn; (blanket = *cradle);)
+		if ((pid = waitpid(blanket->cld.pid, &status, WNOHANG)) > 1) {
+			const char *dead = "";
+			if (status)
+				dead = " (with error)";
+			loginfo("[%"PRIuMAX"] Disconnected%s", (uintmax_t)pid, dead);
+
+			/* remove the child */
+			*cradle = blanket->next;
+			live_children--;
+			child_process_clear(&blanket->cld);
+			free(blanket);
+		} else
+			cradle = &blanket->next;
+}
+
+static struct strvec cld_argv = STRVEC_INIT;
+static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
+{
+	struct child_process cld = CHILD_PROCESS_INIT;
+
+	if (max_connections && live_children >= max_connections) {
+		kill_some_child();
+		sleep(1);  /* give it some time to die */
+		check_dead_children();
+		if (live_children >= max_connections) {
+			close(incoming);
+			logerror("Too many children, dropping connection");
+			return;
+		}
+	}
+
+	if (addr->sa_family == AF_INET) {
+		char buf[128] = "";
+		struct sockaddr_in *sin_addr = (void *) addr;
+		inet_ntop(addr->sa_family, &sin_addr->sin_addr, buf, sizeof(buf));
+		strvec_pushf(&cld.env, "REMOTE_ADDR=%s", buf);
+		strvec_pushf(&cld.env, "REMOTE_PORT=%d",
+				 ntohs(sin_addr->sin_port));
+#ifndef NO_IPV6
+	} else if (addr->sa_family == AF_INET6) {
+		char buf[128] = "";
+		struct sockaddr_in6 *sin6_addr = (void *) addr;
+		inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(buf));
+		strvec_pushf(&cld.env, "REMOTE_ADDR=[%s]", buf);
+		strvec_pushf(&cld.env, "REMOTE_PORT=%d",
+				 ntohs(sin6_addr->sin6_port));
+#endif
+	}
+
+	strvec_pushv(&cld.args, cld_argv.v);
+	cld.in = incoming;
+	cld.out = dup(incoming);
+
+	if (cld.out < 0)
+		logerror("could not dup() `incoming`");
+	else if (start_command(&cld))
+		logerror("unable to fork");
+	else
+		add_child(&cld, addr, addrlen);
+}
+
+static void child_handler(int signo)
+{
+	/*
+	 * Otherwise empty handler because systemcalls will get interrupted
+	 * upon signal receipt
+	 * SysV needs the handler to be rearmed
+	 */
+	signal(SIGCHLD, child_handler);
+}
+
+static int set_reuse_addr(int sockfd)
+{
+	int on = 1;
+
+	if (!reuseaddr)
+		return 0;
+	return setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR,
+			  &on, sizeof(on));
+}
+
+struct socketlist {
+	int *list;
+	size_t nr;
+	size_t alloc;
+};
+
+static const char *ip2str(int family, struct sockaddr *sin, socklen_t len)
+{
+#ifdef NO_IPV6
+	static char ip[INET_ADDRSTRLEN];
+#else
+	static char ip[INET6_ADDRSTRLEN];
+#endif
+
+	switch (family) {
+#ifndef NO_IPV6
+	case AF_INET6:
+		inet_ntop(family, &((struct sockaddr_in6*)sin)->sin6_addr, ip, len);
+		break;
+#endif
+	case AF_INET:
+		inet_ntop(family, &((struct sockaddr_in*)sin)->sin_addr, ip, len);
+		break;
+	default:
+		xsnprintf(ip, sizeof(ip), "<unknown>");
+	}
+	return ip;
+}
+
+#ifndef NO_IPV6
+
+static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
+{
+	int socknum = 0;
+	char pbuf[NI_MAXSERV];
+	struct addrinfo hints, *ai0, *ai;
+	int gai;
+	long flags;
+
+	xsnprintf(pbuf, sizeof(pbuf), "%d", listen_port);
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_family = AF_UNSPEC;
+	hints.ai_socktype = SOCK_STREAM;
+	hints.ai_protocol = IPPROTO_TCP;
+	hints.ai_flags = AI_PASSIVE;
+
+	gai = getaddrinfo(listen_addr, pbuf, &hints, &ai0);
+	if (gai) {
+		logerror("getaddrinfo() for %s failed: %s", listen_addr, gai_strerror(gai));
+		return 0;
+	}
+
+	for (ai = ai0; ai; ai = ai->ai_next) {
+		int sockfd;
+
+		sockfd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
+		if (sockfd < 0)
+			continue;
+		if (sockfd >= FD_SETSIZE) {
+			logerror("Socket descriptor too large");
+			close(sockfd);
+			continue;
+		}
+
+#ifdef IPV6_V6ONLY
+		if (ai->ai_family == AF_INET6) {
+			int on = 1;
+			setsockopt(sockfd, IPPROTO_IPV6, IPV6_V6ONLY,
+				   &on, sizeof(on));
+			/* Note: error is not fatal */
+		}
+#endif
+
+		if (set_reuse_addr(sockfd)) {
+			logerror("Could not set SO_REUSEADDR: %s", strerror(errno));
+			close(sockfd);
+			continue;
+		}
+
+		set_keep_alive(sockfd);
+
+		if (bind(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
+			logerror("Could not bind to %s: %s",
+				 ip2str(ai->ai_family, ai->ai_addr, ai->ai_addrlen),
+				 strerror(errno));
+			close(sockfd);
+			continue;	/* not fatal */
+		}
+		if (listen(sockfd, 5) < 0) {
+			logerror("Could not listen to %s: %s",
+				 ip2str(ai->ai_family, ai->ai_addr, ai->ai_addrlen),
+				 strerror(errno));
+			close(sockfd);
+			continue;	/* not fatal */
+		}
+
+		flags = fcntl(sockfd, F_GETFD, 0);
+		if (flags >= 0)
+			fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
+
+		ALLOC_GROW(socklist->list, socklist->nr + 1, socklist->alloc);
+		socklist->list[socklist->nr++] = sockfd;
+		socknum++;
+	}
+
+	freeaddrinfo(ai0);
+
+	return socknum;
+}
+
+#else /* NO_IPV6 */
+
+static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
+{
+	struct sockaddr_in sin;
+	int sockfd;
+	long flags;
+
+	memset(&sin, 0, sizeof sin);
+	sin.sin_family = AF_INET;
+	sin.sin_port = htons(listen_port);
+
+	if (listen_addr) {
+		/* Well, host better be an IP address here. */
+		if (inet_pton(AF_INET, listen_addr, &sin.sin_addr.s_addr) <= 0)
+			return 0;
+	} else {
+		sin.sin_addr.s_addr = htonl(INADDR_ANY);
+	}
+
+	sockfd = socket(AF_INET, SOCK_STREAM, 0);
+	if (sockfd < 0)
+		return 0;
+
+	if (set_reuse_addr(sockfd)) {
+		logerror("Could not set SO_REUSEADDR: %s", strerror(errno));
+		close(sockfd);
+		return 0;
+	}
+
+	set_keep_alive(sockfd);
+
+	if (bind(sockfd, (struct sockaddr *)&sin, sizeof sin) < 0) {
+		logerror("Could not bind to %s: %s",
+			 ip2str(AF_INET, (struct sockaddr *)&sin, sizeof(sin)),
+			 strerror(errno));
+		close(sockfd);
+		return 0;
+	}
+
+	if (listen(sockfd, 5) < 0) {
+		logerror("Could not listen to %s: %s",
+			 ip2str(AF_INET, (struct sockaddr *)&sin, sizeof(sin)),
+			 strerror(errno));
+		close(sockfd);
+		return 0;
+	}
+
+	flags = fcntl(sockfd, F_GETFD, 0);
+	if (flags >= 0)
+		fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
+
+	ALLOC_GROW(socklist->list, socklist->nr + 1, socklist->alloc);
+	socklist->list[socklist->nr++] = sockfd;
+	return 1;
+}
+
+#endif
+
+static void socksetup(struct string_list *listen_addr, int listen_port, struct socketlist *socklist)
+{
+	if (!listen_addr->nr)
+		setup_named_sock("127.0.0.1", listen_port, socklist);
+	else {
+		int i, socknum;
+		for (i = 0; i < listen_addr->nr; i++) {
+			socknum = setup_named_sock(listen_addr->items[i].string,
+						   listen_port, socklist);
+
+			if (socknum == 0)
+				logerror("unable to allocate any listen sockets for host %s on port %u",
+					 listen_addr->items[i].string, listen_port);
+		}
+	}
+}
+
+static int service_loop(struct socketlist *socklist)
+{
+	struct pollfd *pfd;
+	int i;
+
+	CALLOC_ARRAY(pfd, socklist->nr);
+
+	for (i = 0; i < socklist->nr; i++) {
+		pfd[i].fd = socklist->list[i];
+		pfd[i].events = POLLIN;
+	}
+
+	signal(SIGCHLD, child_handler);
+
+	for (;;) {
+		int i;
+		int nr_ready;
+		int timeout = (pid_file ? 100 : -1);
+
+		check_dead_children();
+
+		nr_ready = poll(pfd, socklist->nr, timeout);
+		if (nr_ready < 0) {
+			if (errno != EINTR) {
+				logerror("Poll failed, resuming: %s",
+				      strerror(errno));
+				sleep(1);
+			}
+			continue;
+		}
+		else if (nr_ready == 0) {
+			/*
+			 * If we have a pid_file, then we watch it.
+			 * If someone deletes it, we shutdown the service.
+			 * The shell scripts in the test suite will use this.
+			 */
+			if (!pid_file || file_exists(pid_file))
+				continue;
+			goto shutdown;
+		}
+
+		for (i = 0; i < socklist->nr; i++) {
+			if (pfd[i].revents & POLLIN) {
+				union {
+					struct sockaddr sa;
+					struct sockaddr_in sai;
+#ifndef NO_IPV6
+					struct sockaddr_in6 sai6;
+#endif
+				} ss;
+				socklen_t sslen = sizeof(ss);
+				int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
+				if (incoming < 0) {
+					switch (errno) {
+					case EAGAIN:
+					case EINTR:
+					case ECONNABORTED:
+						continue;
+					default:
+						die_errno("accept returned");
+					}
+				}
+				handle(incoming, &ss.sa, sslen);
+			}
+		}
+	}
+
+shutdown:
+	loginfo("Starting graceful shutdown (pid-file gone)");
+	for (i = 0; i < socklist->nr; i++)
+		close(socklist->list[i]);
+
+	return 0;
+}
+
+static int serve(struct string_list *listen_addr, int listen_port)
+{
+	struct socketlist socklist = { NULL, 0, 0 };
+
+	socksetup(listen_addr, listen_port, &socklist);
+	if (socklist.nr == 0)
+		die("unable to allocate any listen sockets on port %u",
+		    listen_port);
+
+	loginfo("Ready to rumble");
+
+	/*
+	 * Wait to create the pid-file until we've setup the sockets
+	 * and are open for business.
+	 */
+	if (pid_file)
+		write_file(pid_file, "%"PRIuMAX, (uintmax_t) getpid());
+
+	return service_loop(&socklist);
+}
+
+/*
+ * This section is executed by both the primary instance and all
+ * worker instances.  So, yes, each child-process re-parses the
+ * command line argument and re-discovers how it should behave.
+ */
+
+int cmd_main(int argc, const char **argv)
+{
+	int listen_port = 0;
+	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
+	int worker_mode = 0;
+	int i;
+
+	trace2_cmd_name("test-http-server");
+	setup_git_directory_gently(NULL);
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		const char *v;
+
+		if (skip_prefix(arg, "--listen=", &v)) {
+			string_list_append(&listen_addr, xstrdup_tolower(v));
+			continue;
+		}
+		if (skip_prefix(arg, "--port=", &v)) {
+			char *end;
+			unsigned long n;
+			n = strtoul(v, &end, 0);
+			if (*v && !*end) {
+				listen_port = n;
+				continue;
+			}
+		}
+		if (!strcmp(arg, "--worker")) {
+			worker_mode = 1;
+			trace2_cmd_mode("worker");
+			continue;
+		}
+		if (!strcmp(arg, "--verbose")) {
+			verbose = 1;
+			continue;
+		}
+		if (skip_prefix(arg, "--timeout=", &v)) {
+			timeout = atoi(v);
+			continue;
+		}
+		if (skip_prefix(arg, "--init-timeout=", &v)) {
+			init_timeout = atoi(v);
+			continue;
+		}
+		if (skip_prefix(arg, "--max-connections=", &v)) {
+			max_connections = atoi(v);
+			if (max_connections < 0)
+				max_connections = 0; /* unlimited */
+			continue;
+		}
+		if (!strcmp(arg, "--reuseaddr")) {
+			reuseaddr = 1;
+			continue;
+		}
+		if (skip_prefix(arg, "--pid-file=", &v)) {
+			pid_file = v;
+			continue;
+		}
+
+		fprintf(stderr, "error: unknown argument '%s'\n", arg);
+		usage(test_http_auth_usage);
+	}
+
+	/* avoid splitting a message in the middle */
+	setvbuf(stderr, NULL, _IOFBF, 4096);
+
+	if (listen_port == 0)
+		listen_port = DEFAULT_GIT_PORT;
+
+	/*
+	 * If no --listen=<addr> args are given, the setup_named_sock()
+	 * code will use receive a NULL address and set INADDR_ANY.
+	 * This exposes both internal and external interfaces on the
+	 * port.
+	 *
+	 * Disallow that and default to the internal-use-only loopback
+	 * address.
+	 */
+	if (!listen_addr.nr)
+		string_list_append(&listen_addr, "127.0.0.1");
+
+	/*
+	 * worker_mode is set in our own child process instances
+	 * (that are bound to a connected socket from a client).
+	 */
+	if (worker_mode)
+		return worker();
+
+	/*
+	 * `cld_argv` is a bit of a clever hack. The top-level instance
+	 * of test-http-server does the normal bind/listen/accept stuff.
+	 * For each incoming socket, the top-level process spawns
+	 * a child instance of test-http-server *WITH* the additional
+	 * `--worker` argument. This causes the child to set `worker_mode`
+	 * and immediately call `worker()` using the connected socket (and
+	 * without the usual need for fork() or threads).
+	 *
+	 * The magic here is made possible because `cld_argv` is static
+	 * and handle() (called by service_loop()) knows about it.
+	 */
+	strvec_push(&cld_argv, argv[0]);
+	strvec_push(&cld_argv, "--worker");
+	for (i = 1; i < argc; ++i)
+		strvec_push(&cld_argv, argv[i]);
+
+	/*
+	 * Setup primary instance to listen for connections.
+	 */
+	return serve(&listen_addr, listen_port);
+}
-- 
gitgitgadget

