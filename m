Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45050C25B50
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjATWJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjATWJB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:09:01 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E426FA500B
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:08:57 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q8so5063054wmo.5
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/fKd4Jtqfa/YFl4PxGgOhCP4o4uTXtc+mEJ6ZoI0h8=;
        b=dyJ2xPpi0surGE1bB1lV3D4cERsM2zNoLmAQrC/vyPGlbvgHPFbV+skxEuI9Wc0YD0
         hLEBsxgFTIhsDY2UaUsVW3YEGL7gmH0+K628X3PcGxo6FtNWQch8bPCrWkOJHTjH3keO
         xUBGQSfyRyFaCUhwm9kH/kb3glQI35NDS5R+o0s/TJHCBQ1d17MfowsWC0/P9L6uP+1R
         gr+L+JqD8PmZSHS7t4wYsRvmXlDwJpX8/9FesMWqCqnxkBmyLgmAuKf8I6U6pOfobgq6
         Ivh0QY6zzxgZnkkat+79R+six+FhmjJFJC6dH+uuKElY075P3oXy56z9oAIzXFXVaD7/
         XZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/fKd4Jtqfa/YFl4PxGgOhCP4o4uTXtc+mEJ6ZoI0h8=;
        b=cztCgGhPJ6gGJZPkS/G7PaL9UuvdiR8Ew2A5Ixw1xyufYiBvRYNPy6mMXdzpSU/9Ud
         hGMIytT3taBrwvsuNsR4EZqOEYv+9k8S6xNmWCFE33mpv9Wl5MRskwQ4TLIh5KlvVl7T
         M82I+y4/zLzAgsNtp9lPoRn04bLFbIhGNGNFAnPGXR1hTvMytd8Tgzb7qnxkvHG8XDn7
         2VHhziWod6e9dOJ4Cs1bzxRueJf6Oy2hfqDxyNc9IGBwwE4y6oULlkRoghuEYVoWDC0R
         enZRo0d6KEw9t8kumyw0OdSbAst/2KpxZuKmlhNgWC7408Ks8f+TFsIIRAFi02jNyxjf
         U4ig==
X-Gm-Message-State: AFqh2kqt9sONAaDslqLY+AQttebOL/TRqnuo3qmF4Ql09iG+K3t+kxmv
        J+hFQVogZtJO4RsSPQUk73cwk6Y0yEQ=
X-Google-Smtp-Source: AMrXdXuvp1qSxuQav59HbhRlsy9MoYR4vULJwEPoS0bs3n4wsZ38vvtOAMMb3C5IkWC41tEW75rSQQ==
X-Received: by 2002:a05:600c:3c86:b0:3da:2a59:8a4f with SMTP id bg6-20020a05600c3c8600b003da2a598a4fmr15861835wmb.38.1674252536159;
        Fri, 20 Jan 2023 14:08:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b003db012d49b7sm14069692wms.2.2023.01.20.14.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 14:08:55 -0800 (PST)
Message-Id: <17c890ee1080abc81267e44a1eaff4609ee41690.1674252531.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Jan 2023 22:08:42 +0000
Subject: [PATCH v7 04/12] test-http-server: add stub HTTP server test helper
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
 t/helper/test-http-server.c         | 381 ++++++++++++++++++++++++++++
 4 files changed, 392 insertions(+), 2 deletions(-)
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
index 00000000000..6e9a1c479ce
--- /dev/null
+++ b/t/helper/test-http-server.c
@@ -0,0 +1,381 @@
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
+ * a single connection from a client. The worker talks to the client
+ * on stdin and stdout.
+ */
+
+enum worker_result {
+	/*
+	 * Operation successful.
+	 * Caller *might* keep the socket open and allow keep-alive.
+	 */
+	WR_OK = 0,
+
+	/*
+	 * Fatal error that is not recoverable.
+	 * Close the socket and clean up.
+	 * Exit child-process with non-zero status.
+	 */
+	WR_FATAL_ERROR = 1,
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
+			wr = WR_FATAL_ERROR;
+		}
+
+		if (wr != WR_OK)
+			break;
+	}
+
+	close(STDIN_FILENO);
+	close(STDOUT_FILENO);
+
+	/* Only WR_OK should result in a non-zero exit code */
+	return wr != WR_OK;
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

