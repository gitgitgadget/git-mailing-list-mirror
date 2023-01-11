Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AC9C54EBC
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 22:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbjAKWNb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbjAKWNU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 17:13:20 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E1A36337
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:18 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id az7so16420408wrb.5
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKNlkhSdZ7ACwMk9ugShnF1r2+k5RVjpgvl5Ij8APwY=;
        b=o0dJJYuiPalsIkQndb78UlPmoX+HyRgm4j6wSkALFKg8is5CmsC82aryHJIMZlo5aR
         VKgStqNidXzcZP6V8UariwposaKyOyr2WEwvjpPpid3+rwT4qdNJ14ZcL6Micwgl+IUj
         tEBTHH+qluOqlWjBdwrBfe71vEeXBBgxKph8ZyV9GyniLZhpX3LfLUSrMUlBy0O3q1Kz
         CZWZQVo/6B/DGMtjVxCrBz9+r7VDivnMp7Ws2GJo+VPNBmSLyRLvSJB6dZvESHcjesZE
         boMsciJDT78iozpjmTcurI+YqGJoMHDaIHFQ2bC+iJWW3Rq9QmdvC1kgmKQ48OIVWKHY
         3DxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKNlkhSdZ7ACwMk9ugShnF1r2+k5RVjpgvl5Ij8APwY=;
        b=tLbj90IIEt8fwcMbcy2z2MlgJWe2zVoq/+XehHabzYqLw/IXpMO1xM+6msyo81gG0a
         Efyd07rO1wpzwYFvuDbk4T/KXBTpfd3mnRNG5iMwRR/VavZnYip5GemGiZ6w5lWiZcgF
         iYO6DlTrJLN76tJo+XzWvX2Ot3bneeSXvtURXziitjH/6F8jyWWZq4baPgIlKmw1ENDO
         DPMzjgDqv8Uj9Nh5//6a1QxYpUwLT+Rzp2Al92atHAyk8i8IUUzXJ990qUNJnK48IXV6
         k0bHWtssdNFkkale2Z4LiqAvmAAQuw4YAoKf1ohNG17t7dQOxLIv3s8bXJBzJ9n/jTpV
         X49Q==
X-Gm-Message-State: AFqh2kqL/FCLB2IScjTnQQRXKMxuEC3E0FVC28INxcG0BKdcKqDNIlAc
        veeP/XF2vmm3TaCr00eNQ2XvKLuuNtQ=
X-Google-Smtp-Source: AMrXdXutfjvH0W1FSNmrnkZ9P4zZwY8C2w6cMZeVz3c+4EcGs+52Rkm2x7Ib6YNKn9sq7Wo4ypnsOw==
X-Received: by 2002:adf:e383:0:b0:267:b8df:932b with SMTP id e3-20020adfe383000000b00267b8df932bmr57048404wrm.23.1673475196344;
        Wed, 11 Jan 2023 14:13:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8-20020a0560001b0800b002423edd7e50sm14688805wrz.32.2023.01.11.14.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 14:13:15 -0800 (PST)
Message-Id: <706fb3781bd383380a7b1fd30495eb2da970b5ec.1673475190.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
        <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Jan 2023 22:13:04 +0000
Subject: [PATCH v5 04/10] test-http-server: add stub HTTP server test helper
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

Introduce a mini HTTP server helper that in the future will be enhanced
to provide a frontend for the git-http-backend, with support for
arbitrary authentication schemes.

Right now, test-http-server is a pared-down copy of the git-daemon that
always returns a 501 Not Implemented response to all callers.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 Makefile                            |   1 +
 contrib/buildsystems/CMakeLists.txt |  11 +-
 t/helper/.gitignore                 |   1 +
 t/helper/test-http-server.c         | 385 ++++++++++++++++++++++++++++
 4 files changed, 396 insertions(+), 2 deletions(-)
 create mode 100644 t/helper/test-http-server.c

diff --git a/Makefile b/Makefile
index 2654094dbb5..3cd61c792ac 100644
--- a/Makefile
+++ b/Makefile
@@ -865,6 +865,7 @@ TEST_BUILTINS_OBJS += test-xml-encode.o
 # Do not add more tests here unless they have extra dependencies. Add
 # them in TEST_BUILTINS_OBJS above.
 TEST_PROGRAMS_NEED_X += test-fake-ssh
+TEST_PROGRAMS_NEED_X += test-http-server
 TEST_PROGRAMS_NEED_X += test-tool
 
 TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 2f6e0197ffa..5d949dcb16c 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -961,6 +961,9 @@ if(BUILD_TESTING)
 add_executable(test-fake-ssh ${CMAKE_SOURCE_DIR}/t/helper/test-fake-ssh.c)
 target_link_libraries(test-fake-ssh common-main)
 
+add_executable(test-http-server ${CMAKE_SOURCE_DIR}/t/helper/test-http-server.c)
+target_link_libraries(test-http-server common-main)
+
 #reftable-tests
 parse_makefile_for_sources(test-reftable_SOURCES "REFTABLE_TEST_OBJS")
 list(TRANSFORM test-reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
@@ -980,6 +983,11 @@ if(MSVC)
 				PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/t/helper)
 	set_target_properties(test-fake-ssh test-tool
 				PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/helper)
+
+	set_target_properties(test-http-server
+			PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/t/helper)
+	set_target_properties(test-http-server
+			PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/helper)
 endif()
 
 #wrapper scripts
@@ -987,8 +995,7 @@ set(wrapper_scripts
 	git git-upload-pack git-receive-pack git-upload-archive git-shell git-remote-ext scalar)
 
 set(wrapper_test_scripts
-	test-fake-ssh test-tool)
-
+	test-http-server test-fake-ssh test-tool)
 
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
index 00000000000..11071b1dd89
--- /dev/null
+++ b/t/helper/test-http-server.c
@@ -0,0 +1,385 @@
+#include "daemon-utils.h"
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
+"           [--timeout=<n>] [--max-connections=<n>]\n"
+"           [--reuseaddr] [--pid-file=<file>]\n"
+"           [--listen=<host_or_ipaddr>]* [--port=<n>]\n"
+;
+
+static unsigned int timeout;
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
+	set_keep_alive(0, logerror);
+
+	while (1) {
+		if (write_in_full(STDOUT_FILENO, response, strlen(response)) < 0) {
+			logerror("unable to write response");
+			wr = WR_IO_ERROR;
+		}
+
+		if (wr != WR_OK)
+			break;
+	}
+
+	close(STDIN_FILENO);
+	close(STDOUT_FILENO);
+
+	return !!(wr & WR_IO_ERROR);
+}
+
+static int max_connections = 32;
+
+static unsigned int live_children;
+
+static struct child *first_child;
+
+static struct strvec cld_argv = STRVEC_INIT;
+static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
+{
+	struct child_process cld = CHILD_PROCESS_INIT;
+
+	if (max_connections && live_children >= max_connections) {
+		kill_some_child(first_child);
+		sleep(1);  /* give it some time to die */
+		check_dead_children(first_child, &live_children, loginfo);
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
+		add_child(&cld, addr, addrlen, first_child, &live_children);
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
+		check_dead_children(first_child, &live_children, loginfo);
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
+	socksetup(listen_addr, listen_port, &socklist, reuseaddr, logerror);
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
+	trace2_cmd_list_config();
+	trace2_cmd_list_env_vars();
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

