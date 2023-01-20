Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58101C27C76
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjATWJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjATWJA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:09:00 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BECA25AF
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:08:55 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso5279010wmn.5
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZfvZ8RTcDBAofAevq0+3MPqq1v9AIkhChP91QQElkQ=;
        b=VvPdci32aZJRSYVBnp8rl+QHwGscqKNISgq1bM0hX12REB7xc/UnXVit0fagHSBZLf
         5qn29hvIY8WqEoX51FRFcV5fn9HXplL5tATuQyPwsVk9X8heiG9x7IKz44cYIa/A36QQ
         NkCOKmZYyaeXYp/4+1D8cvwPT5VazIyzdj1k399kWvb7lW5gF/uy0HMveGUIdy82BxV7
         zK246f8xMMZ3Jf4BsBKN5EPJ+n+kEx5IAM3MGN1lq+l4wyg2mehLJXQDmGhhuojciff/
         tVbyuTZB0f0hzxLd99E27mNmuTweYLjfCB0vC/OJoBajNZuYfveu8Iiz5j4flMlmS13i
         nl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZfvZ8RTcDBAofAevq0+3MPqq1v9AIkhChP91QQElkQ=;
        b=iJyDAHL240wU7zSfkwLdYUeBLrRJ+xXaJKS4xVjBahjqB5w3aSZQHcgLD1JLEAXmYe
         HDgJ4HqrNZWh9NRawp8M3kdq/o3tk5h1aw+XdLJHW9YbUnDuWSS+QYqqJ6XXNTiouFAF
         0/Rz96gWr7Cv8IWeCToVaTQTalNsmoGN1Gsucgo0EgI3vx07fkNdUe3mcwgixMcla9ua
         crAFV+Aw9p9A7uXWadlQu5nobmlLWd9YVauvRXsIq8tUShMSdtqAvWh9kk+8WQvtPETJ
         4ZTwjJ7QQKQFb7rAVpHLP67323S9gFrRHwuCQtdF4mkuwvfUjfYIEMoF0LlVMDGlE5k7
         ExbQ==
X-Gm-Message-State: AFqh2krZ6qaIXgb5QqhD1A47C81634jpXlfYYpsQTOcJOU8RaIHizlr8
        pxs9B3jPRUXtnTBv8yY5qtb2WRof4YY=
X-Google-Smtp-Source: AMrXdXsDoUGSVSdtYjK+3sIyY+R0fjBwqmpdjGBNQTiB/AlR6w5auV/r8oYUfRWyu4mNX1vFa5YD0A==
X-Received: by 2002:a05:600c:3488:b0:3d2:370b:97f4 with SMTP id a8-20020a05600c348800b003d2370b97f4mr24157409wmq.16.1674252533491;
        Fri, 20 Jan 2023 14:08:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id he7-20020a05600c540700b003d9fb04f658sm3373388wmb.4.2023.01.20.14.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 14:08:53 -0800 (PST)
Message-Id: <74b0de14185120c9d53d7470e59f57fa20a1927f.1674252531.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Jan 2023 22:08:39 +0000
Subject: [PATCH v7 01/12] daemon: libify socket setup and option functions
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

Extract functions for setting up listening sockets and keep-alive options
from `daemon.c` to new `daemon-utils.{c,h}` files. Remove direct
dependencies on global state by inlining the behaviour at the callsites
for all libified functions.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 Makefile       |   1 +
 daemon-utils.c | 209 +++++++++++++++++++++++++++++++++++++++++++++++
 daemon-utils.h |  23 ++++++
 daemon.c       | 214 +------------------------------------------------
 4 files changed, 237 insertions(+), 210 deletions(-)
 create mode 100644 daemon-utils.c
 create mode 100644 daemon-utils.h

diff --git a/Makefile b/Makefile
index b258fdbed86..2654094dbb5 100644
--- a/Makefile
+++ b/Makefile
@@ -1003,6 +1003,7 @@ LIB_OBJS += credential.o
 LIB_OBJS += csum-file.o
 LIB_OBJS += ctype.o
 LIB_OBJS += date.o
+LIB_OBJS += daemon-utils.o
 LIB_OBJS += decorate.o
 LIB_OBJS += delta-islands.o
 LIB_OBJS += diagnose.o
diff --git a/daemon-utils.c b/daemon-utils.c
new file mode 100644
index 00000000000..b96b55962db
--- /dev/null
+++ b/daemon-utils.c
@@ -0,0 +1,209 @@
+#include "cache.h"
+#include "daemon-utils.h"
+
+void set_keep_alive(int sockfd, log_fn logerror)
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
+static int set_reuse_addr(int sockfd)
+{
+	int on = 1;
+
+	return setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR,
+			  &on, sizeof(on));
+}
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
+static int setup_named_sock(char *listen_addr, int listen_port,
+			    struct socketlist *socklist, int reuseaddr,
+			    log_fn logerror)
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
+		if (reuseaddr && set_reuse_addr(sockfd)) {
+			logerror("Could not set SO_REUSEADDR: %s", strerror(errno));
+			close(sockfd);
+			continue;
+		}
+
+		set_keep_alive(sockfd, logerror);
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
+static int setup_named_sock(char *listen_addr, int listen_port,
+			    struct socketlist *socklist, int reuseaddr,
+			    log_fn logerror)
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
+	if (reuseaddr && set_reuse_addr(sockfd)) {
+		logerror("Could not set SO_REUSEADDR: %s", strerror(errno));
+		close(sockfd);
+		return 0;
+	}
+
+	set_keep_alive(sockfd, logerror);
+
+	if ( bind(sockfd, (struct sockaddr *)&sin, sizeof sin) < 0 ) {
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
+void socksetup(struct string_list *listen_addr, int listen_port,
+	       struct socketlist *socklist, int reuseaddr,
+	       log_fn logerror)
+{
+	if (!listen_addr->nr)
+		setup_named_sock(NULL, listen_port, socklist, reuseaddr,
+				 logerror);
+	else {
+		int i, socknum;
+		for (i = 0; i < listen_addr->nr; i++) {
+			socknum = setup_named_sock(listen_addr->items[i].string,
+						   listen_port, socklist, reuseaddr,
+						   logerror);
+
+			if (socknum == 0)
+				logerror("unable to allocate any listen sockets for host %s on port %u",
+					 listen_addr->items[i].string, listen_port);
+		}
+	}
+}
diff --git a/daemon-utils.h b/daemon-utils.h
new file mode 100644
index 00000000000..6710a2a6dc0
--- /dev/null
+++ b/daemon-utils.h
@@ -0,0 +1,23 @@
+#ifndef DAEMON_UTILS_H
+#define DAEMON_UTILS_H
+
+#include "git-compat-util.h"
+#include "string-list.h"
+
+typedef void (*log_fn)(const char *msg, ...);
+
+struct socketlist {
+	int *list;
+	size_t nr;
+	size_t alloc;
+};
+
+/* Enable sending of keep-alive messages on the socket. */
+void set_keep_alive(int sockfd, log_fn logerror);
+
+/* Setup a number of sockets to listen on the provided addresses. */
+void socksetup(struct string_list *listen_addr, int listen_port,
+	       struct socketlist *socklist, int reuseaddr,
+	       log_fn logerror);
+
+#endif
diff --git a/daemon.c b/daemon.c
index 0ae7d12b5c1..1ed4e705680 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,9 +1,9 @@
 #include "cache.h"
 #include "config.h"
+#include "daemon-utils.h"
 #include "pkt-line.h"
 #include "run-command.h"
 #include "strbuf.h"
-#include "string-list.h"
 
 #ifdef NO_INITGROUPS
 #define initgroups(x, y) (0) /* nothing */
@@ -737,17 +737,6 @@ static void hostinfo_clear(struct hostinfo *hi)
 	strbuf_release(&hi->tcp_port);
 }
 
-static void set_keep_alive(int sockfd)
-{
-	int ka = 1;
-
-	if (setsockopt(sockfd, SOL_SOCKET, SO_KEEPALIVE, &ka, sizeof(ka)) < 0) {
-		if (errno != ENOTSOCK)
-			logerror("unable to set SO_KEEPALIVE on socket: %s",
-				strerror(errno));
-	}
-}
-
 static int execute(void)
 {
 	char *line = packet_buffer;
@@ -759,7 +748,7 @@ static int execute(void)
 	if (addr)
 		loginfo("Connection from %s:%s", addr, port);
 
-	set_keep_alive(0);
+	set_keep_alive(0, logerror);
 	alarm(init_timeout ? init_timeout : timeout);
 	pktlen = packet_read(0, packet_buffer, sizeof(packet_buffer), 0);
 	alarm(0);
@@ -938,202 +927,6 @@ static void child_handler(int signo)
 	signal(SIGCHLD, child_handler);
 }
 
-static int set_reuse_addr(int sockfd)
-{
-	int on = 1;
-
-	if (!reuseaddr)
-		return 0;
-	return setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR,
-			  &on, sizeof(on));
-}
-
-struct socketlist {
-	int *list;
-	size_t nr;
-	size_t alloc;
-};
-
-static const char *ip2str(int family, struct sockaddr *sin, socklen_t len)
-{
-#ifdef NO_IPV6
-	static char ip[INET_ADDRSTRLEN];
-#else
-	static char ip[INET6_ADDRSTRLEN];
-#endif
-
-	switch (family) {
-#ifndef NO_IPV6
-	case AF_INET6:
-		inet_ntop(family, &((struct sockaddr_in6*)sin)->sin6_addr, ip, len);
-		break;
-#endif
-	case AF_INET:
-		inet_ntop(family, &((struct sockaddr_in*)sin)->sin_addr, ip, len);
-		break;
-	default:
-		xsnprintf(ip, sizeof(ip), "<unknown>");
-	}
-	return ip;
-}
-
-#ifndef NO_IPV6
-
-static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
-{
-	int socknum = 0;
-	char pbuf[NI_MAXSERV];
-	struct addrinfo hints, *ai0, *ai;
-	int gai;
-	long flags;
-
-	xsnprintf(pbuf, sizeof(pbuf), "%d", listen_port);
-	memset(&hints, 0, sizeof(hints));
-	hints.ai_family = AF_UNSPEC;
-	hints.ai_socktype = SOCK_STREAM;
-	hints.ai_protocol = IPPROTO_TCP;
-	hints.ai_flags = AI_PASSIVE;
-
-	gai = getaddrinfo(listen_addr, pbuf, &hints, &ai0);
-	if (gai) {
-		logerror("getaddrinfo() for %s failed: %s", listen_addr, gai_strerror(gai));
-		return 0;
-	}
-
-	for (ai = ai0; ai; ai = ai->ai_next) {
-		int sockfd;
-
-		sockfd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
-		if (sockfd < 0)
-			continue;
-		if (sockfd >= FD_SETSIZE) {
-			logerror("Socket descriptor too large");
-			close(sockfd);
-			continue;
-		}
-
-#ifdef IPV6_V6ONLY
-		if (ai->ai_family == AF_INET6) {
-			int on = 1;
-			setsockopt(sockfd, IPPROTO_IPV6, IPV6_V6ONLY,
-				   &on, sizeof(on));
-			/* Note: error is not fatal */
-		}
-#endif
-
-		if (set_reuse_addr(sockfd)) {
-			logerror("Could not set SO_REUSEADDR: %s", strerror(errno));
-			close(sockfd);
-			continue;
-		}
-
-		set_keep_alive(sockfd);
-
-		if (bind(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
-			logerror("Could not bind to %s: %s",
-				 ip2str(ai->ai_family, ai->ai_addr, ai->ai_addrlen),
-				 strerror(errno));
-			close(sockfd);
-			continue;	/* not fatal */
-		}
-		if (listen(sockfd, 5) < 0) {
-			logerror("Could not listen to %s: %s",
-				 ip2str(ai->ai_family, ai->ai_addr, ai->ai_addrlen),
-				 strerror(errno));
-			close(sockfd);
-			continue;	/* not fatal */
-		}
-
-		flags = fcntl(sockfd, F_GETFD, 0);
-		if (flags >= 0)
-			fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
-
-		ALLOC_GROW(socklist->list, socklist->nr + 1, socklist->alloc);
-		socklist->list[socklist->nr++] = sockfd;
-		socknum++;
-	}
-
-	freeaddrinfo(ai0);
-
-	return socknum;
-}
-
-#else /* NO_IPV6 */
-
-static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
-{
-	struct sockaddr_in sin;
-	int sockfd;
-	long flags;
-
-	memset(&sin, 0, sizeof sin);
-	sin.sin_family = AF_INET;
-	sin.sin_port = htons(listen_port);
-
-	if (listen_addr) {
-		/* Well, host better be an IP address here. */
-		if (inet_pton(AF_INET, listen_addr, &sin.sin_addr.s_addr) <= 0)
-			return 0;
-	} else {
-		sin.sin_addr.s_addr = htonl(INADDR_ANY);
-	}
-
-	sockfd = socket(AF_INET, SOCK_STREAM, 0);
-	if (sockfd < 0)
-		return 0;
-
-	if (set_reuse_addr(sockfd)) {
-		logerror("Could not set SO_REUSEADDR: %s", strerror(errno));
-		close(sockfd);
-		return 0;
-	}
-
-	set_keep_alive(sockfd);
-
-	if ( bind(sockfd, (struct sockaddr *)&sin, sizeof sin) < 0 ) {
-		logerror("Could not bind to %s: %s",
-			 ip2str(AF_INET, (struct sockaddr *)&sin, sizeof(sin)),
-			 strerror(errno));
-		close(sockfd);
-		return 0;
-	}
-
-	if (listen(sockfd, 5) < 0) {
-		logerror("Could not listen to %s: %s",
-			 ip2str(AF_INET, (struct sockaddr *)&sin, sizeof(sin)),
-			 strerror(errno));
-		close(sockfd);
-		return 0;
-	}
-
-	flags = fcntl(sockfd, F_GETFD, 0);
-	if (flags >= 0)
-		fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
-
-	ALLOC_GROW(socklist->list, socklist->nr + 1, socklist->alloc);
-	socklist->list[socklist->nr++] = sockfd;
-	return 1;
-}
-
-#endif
-
-static void socksetup(struct string_list *listen_addr, int listen_port, struct socketlist *socklist)
-{
-	if (!listen_addr->nr)
-		setup_named_sock(NULL, listen_port, socklist);
-	else {
-		int i, socknum;
-		for (i = 0; i < listen_addr->nr; i++) {
-			socknum = setup_named_sock(listen_addr->items[i].string,
-						   listen_port, socklist);
-
-			if (socknum == 0)
-				logerror("unable to allocate any listen sockets for host %s on port %u",
-					 listen_addr->items[i].string, listen_port);
-		}
-	}
-}
-
 static int service_loop(struct socketlist *socklist)
 {
 	struct pollfd *pfd;
@@ -1246,7 +1039,8 @@ static int serve(struct string_list *listen_addr, int listen_port,
 {
 	struct socketlist socklist = { NULL, 0, 0 };
 
-	socksetup(listen_addr, listen_port, &socklist);
+	socksetup(listen_addr, listen_port, &socklist, reuseaddr,
+		  logerror);
 	if (socklist.nr == 0)
 		die("unable to allocate any listen sockets on port %u",
 		    listen_port);
-- 
gitgitgadget

