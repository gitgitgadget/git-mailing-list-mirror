Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE29C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 23:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLNXQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiLNXQt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 18:16:49 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE00D49B71
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:16:46 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id m4so5036381pls.4
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MER03DzXMaj9fTr2Vu+TKEC/ezHowbjOqJZEVbpsdMc=;
        b=UXjJkJL0JKcUTNeKW66WmiO+/8wTHvLRTzoFAUigYOwSYB1+UTApTnZ0ryNJ7NLQXm
         geEaAMEyFuJmoBUrVVcxjitnx5L9tITfSZHoeS8bS/rGQJ2CfXqeXAjQDOeONQKRg52J
         WUcz6FNmgB/4LJ1U4427bLcrLx5usS3wuu/P3NeKr2QMiSasdLWYEUmeQGXbN1o+I/5R
         2s3C6dNoG2eyJRt20Ee8egMiiotD6hFGme8enGwv+cO5tC8ACoxy66AbV1W6GGi+7umm
         Rh6a3Akn9bICghbdXw/pWGAmrie224V8jVo0nx6kjMy6JH8u7156LC1KEHc5OAjFpWTQ
         ZwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MER03DzXMaj9fTr2Vu+TKEC/ezHowbjOqJZEVbpsdMc=;
        b=0VjFL/426D2AuooCv0ypPb2gxydpPOQaKg43B/7DknmzrQ0On3m6C1dqEnA5zDoq8Q
         AblA0r6WMpBM1+CfGU1RUcA+xKO0tS7eebYv3EQzCYT3KdF+TDG0M1aF2xmpdsAPstbQ
         epp8RD032JoWD5h/wCQ7+XLJc/9fanJviK0W/yy+z6HMdKiCvG0nWXGm4Zov19ZSzM9t
         B2yU0l49Yzn/WwnsGXvEHT/FicGini8FfH5qgjg8kXZItFPnu0w11twSCOpkhJVmJ5DX
         SphLFjq3iGNZnUPR89xy3pVDFcXFZY6ALgeEpT+VnrF7ROZnZ2g43wnM+OdRCMoaIylQ
         JSIA==
X-Gm-Message-State: ANoB5pmC4iuGA9K5x7fnNldG7UdoJBhbt5Qu7YXjWkTkiKAv0ITu8Wmp
        5cMXBbp0+YaWQ+TpCUUZkdo0
X-Google-Smtp-Source: AA0mqf4DEfFU3SuD5LUBKptLsHcj85R7I29Hd4J9Phm0ptdkytK7t/FytCKas92fIGXNyZwHpxnkOw==
X-Received: by 2002:a17:903:24e:b0:188:8745:35af with SMTP id j14-20020a170903024e00b00188874535afmr46943859plh.63.1671059806144;
        Wed, 14 Dec 2022 15:16:46 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id x21-20020a17090300d500b00172cb8b97a8sm2398877plc.5.2022.12.14.15.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 15:16:45 -0800 (PST)
Message-ID: <752da6b2-9c75-0f68-e507-cca02bf918ca@github.com>
Date:   Wed, 14 Dec 2022 15:16:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v4 3/8] test-http-server: add stub HTTP server test helper
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
 <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <07a1845ea5693fc8d3716e7f97e65d467f34a40e.1670880984.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <07a1845ea5693fc8d3716e7f97e65d467f34a40e.1670880984.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
> Introduce a mini HTTP server helper that in the future will be enhanced
> to provide a frontend for the git-http-backend, with support for
> arbitrary authentication schemes.

I really like this approach, particularly because it opens up the
possibility of writing more fine-grained tests in other contexts (e.g.,
testing how a bundle-uri client handles different kinds of erroneous server
responses by intercepting and customizing those responses).

> 
> Right now, test-http-server is a pared-down copy of the git-daemon that
> always returns a 501 Not Implemented response to all callers.
> 
> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>  Makefile                            |   2 +
>  contrib/buildsystems/CMakeLists.txt |  13 +
>  t/helper/.gitignore                 |   1 +
>  t/helper/test-http-server.c         | 685 ++++++++++++++++++++++++++++
>  4 files changed, 701 insertions(+)
>  create mode 100644 t/helper/test-http-server.c
> 
> diff --git a/Makefile b/Makefile
> index b258fdbed86..1eb795bbfd4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1611,6 +1611,8 @@ else
>  	endif
>  	BASIC_CFLAGS += $(CURL_CFLAGS)
>  
> +	TEST_PROGRAMS_NEED_X += test-http-server

This works because all usage of 'TEST_PROGRAMS_NEED_X' are either lazily
evaluated (in the case of 'TEST_PROGRAMS') or are assigned later in the
'Makefile' than the addition here (in the case of 'test_bindir_programs'). 

On a related note, I think it would be helpful to mention 'test-http-server'
in the "=== Optional library: libcurl ===" section of the documentation at
the top of the Makefile, to clarify that it (like 'git-http-fetch' and
'git-http-push') are not built.

> +
>  	REMOTE_CURL_PRIMARY = git-remote-http$X
>  	REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
>  	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 2f6e0197ffa..e9b9bfbb437 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -989,6 +989,19 @@ set(wrapper_scripts
>  set(wrapper_test_scripts
>  	test-fake-ssh test-tool)
>  
> +if(CURL_FOUND)
> +       list(APPEND wrapper_test_scripts test-http-server)
> +
> +       add_executable(test-http-server ${CMAKE_SOURCE_DIR}/t/helper/test-http-server.c)
> +       target_link_libraries(test-http-server common-main)
> +
> +       if(MSVC)
> +               set_target_properties(test-http-server
> +                                       PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/t/helper)
> +               set_target_properties(test-http-server
> +                                       PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/helper)
> +       endif()
> +endif()
>  
>  foreach(script ${wrapper_scripts})
>  	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
> diff --git a/t/helper/.gitignore b/t/helper/.gitignore
> index 8c2ddcce95f..9aa9c752997 100644
> --- a/t/helper/.gitignore
> +++ b/t/helper/.gitignore
> @@ -1,2 +1,3 @@
>  /test-tool
>  /test-fake-ssh
> +/test-http-server
> diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
> new file mode 100644
> index 00000000000..18f1f741305
> --- /dev/null
> +++ b/t/helper/test-http-server.c

A lot of the functions in this file are modified versions of ones in
'daemon.c'. It would help reviewers/future readers to mention that in the
commit message. 

My comments are mostly going to be around the similarities/differences from
'daemon.c', hopefully to understand how 'test-http-server' is meant to be
used.

> +static void logreport(const char *label, const char *err, va_list params)
> +{
> +	struct strbuf msg = STRBUF_INIT;
> +
> +	strbuf_addf(&msg, "[%"PRIuMAX"] %s: ", (uintmax_t)getpid(), label);
> +	strbuf_vaddf(&msg, err, params);
> +	strbuf_addch(&msg, '\n');
> +
> +	fwrite(msg.buf, sizeof(char), msg.len, stderr);
> +	fflush(stderr);
> +
> +	strbuf_release(&msg);

This looks like the 'LOG_DESTINATION_STDERR' case of 'logreport()' in
'daemon.c', but adds a "label" to represent the priority. Makes sense; these
logs will be helpful to have in stderr when running tests, and the priority
will be captured as well.

> +}
> +
> +__attribute__((format (printf, 1, 2)))
> +static void logerror(const char *err, ...)
> +{
> +	va_list params;
> +	va_start(params, err);
> +	logreport("error", err, params);
> +	va_end(params);
> +}
> +
> +__attribute__((format (printf, 1, 2)))
> +static void loginfo(const char *err, ...)
> +{
> +	va_list params;
> +	if (!verbose)
> +		return;
> +	va_start(params, err);
> +	logreport("info", err, params);
> +	va_end(params);
> +}

These two functions replace the "priority" int with the "label" string, but
otherwise capture the same information.

> +
> +static void set_keep_alive(int sockfd)

This function is identical to its 'daemon.c' counterpart; its usage in
'test-http-server.c' doesn't indicate any need to differ.

> +
> +/*
> + * The code in this section is used by "worker" instances to service
> + * a single connection from a client.  The worker talks to the client
> + * on 0 and 1.
> + */
> +
> +enum worker_result {
> +	/*
> +	 * Operation successful.
> +	 * Caller *might* keep the socket open and allow keep-alive.
> +	 */
> +	WR_OK       = 0,
> +
> +	/*
> +	 * Various errors while processing the request and/or the response.
> +	 * Close the socket and clean up.
> +	 * Exit child-process with non-zero status.
> +	 */
> +	WR_IO_ERROR = 1<<0,
> +
> +	/*
> +	 * Close the socket and clean up.  Does not imply an error.
> +	 */
> +	WR_HANGUP   = 1<<1,
> +
> +	WR_STOP_THE_MUSIC = (WR_IO_ERROR | WR_HANGUP),

As much as I love the name, I'm not sure having this value defined makes
much sense as its own "state". AFAICT, 'WR_IO_ERROR' means "error AND exit",
but 'WR_HANGUP' just means "exit", so the latter is a superset of the
former. Even if you interpret 'WR_HANGUP' as "*no* error and exit", that
makes it and 'WR_IO_ERROR' mutually exclusive, so the "combined" state
doesn't represent anything "real".

> +};
> +
> +static enum worker_result worker(void)
> +{
> +	const char *response = "HTTP/1.1 501 Not Implemented\r\n";

Here's the hardcoded 501 error, as mentioned in the commit message.

> +	char *client_addr = getenv("REMOTE_ADDR");
> +	char *client_port = getenv("REMOTE_PORT");
> +	enum worker_result wr = WR_OK;
> +
> +	if (client_addr)
> +		loginfo("Connection from %s:%s", client_addr, client_port);
> +
> +	set_keep_alive(0);
> +
> +	while (1) {
> +		if (write_in_full(1, response, strlen(response)) < 0) {
> +			logerror("unable to write response");
> +			wr = WR_IO_ERROR;
> +		}

This tries to write the response out to stdout (optional nit: you could use
'STDOUT_FILENO' instead of '1' to make this clearer), and sets 'WR_IO_ERROR'
if it fails. 

> +
> +		if (wr & WR_STOP_THE_MUSIC)
> +			break;

This will trigger if 'wr' is 'WR_HANGUP' *or* 'WR_IO_ERROR'. Is that
intentional? If it is, I think 'wr != 'WR_OK' might make that more obvious?

> +	}
> +
> +	close(0);
> +	close(1);
> +
> +	return !!(wr & WR_IO_ERROR);

Then finish by closing out 'stdin' and 'stdout', and returning '0' for "no
error", '1' for "error".

> +}
> +
> +/*
> + * This section contains the listener and child-process management
> + * code used by the primary instance to accept incoming connections
> + * and dispatch them to async child process "worker" instances.
> + */
> +
> +static int addrcmp(const struct sockaddr_storage *s1,


Identical to 'daemon.c'.

> +static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen)
> +{
> +	struct child *newborn, **cradle;
> +
> +	newborn = xcalloc(1, sizeof(*newborn));
> +	live_children++;
> +	memcpy(&newborn->cld, cld, sizeof(*cld));
> +	memcpy(&newborn->address, addr, addrlen);
> +	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
> +		if (!addrcmp(&(*cradle)->address, &newborn->address))
> +			break;
> +	newborn->next = *cradle;
> +	*cradle = newborn;
> +}

This is mostly the same as 'daemon.c', but uses 'xcalloc()' instead of
'CALLOC_ARRAY()'. The latter is an alias for the former, so this is fine.

> +static void kill_some_child(void)

...

> +static void check_dead_children(void)
Both of these are identical to 'daemon.c'.

> +
> +static struct strvec cld_argv = STRVEC_INIT;
> +static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)

This matches 'daemon.c' except for the addition of:

> +	if (cld.out < 0)
> +		logerror("could not dup() `incoming`");

The extra context provided by this message could be helpful in debugging. If
nothing else, it doesn't hurt.

> +	else if (start_command(&cld))
> +		logerror("unable to fork");
> +	else
> +		add_child(&cld, addr, addrlen);
> +}
> +
> +static void child_handler(int signo)

...

> +static int set_reuse_addr(int sockfd)

...

> +static const char *ip2str(int family, struct sockaddr *sin, socklen_t len)

...

> +#ifndef NO_IPV6
> +
> +static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
...

> +#else /* NO_IPV6 */
> +
> +static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)

All of these functions match 'daemon.c' (save for some whitespace fixups).

> +
> +static void socksetup(struct string_list *listen_addr, int listen_port, struct socketlist *socklist)
> +{
> +	if (!listen_addr->nr)
> +		setup_named_sock("127.0.0.1", listen_port, socklist);

This is the only difference in this function from 'daemon.c' (there, the
first arg is 'NULL', which ends up mapping to 'INADDR_ANY'). Why the change
in default?

> +	else {
> +		int i, socknum;
> +		for (i = 0; i < listen_addr->nr; i++) {
> +			socknum = setup_named_sock(listen_addr->items[i].string,
> +						   listen_port, socklist);
> +
> +			if (socknum == 0)
> +				logerror("unable to allocate any listen sockets for host %s on port %u",
> +					 listen_addr->items[i].string, listen_port);
> +		}
> +	}
> +}
> +
> +static int service_loop(struct socketlist *socklist)

This function differs from 'daemon.c' by using removal of the 'pid_file' to
force a graceful shutdown of the server.

> +{
> +	struct pollfd *pfd;
> +	int i;
> +
> +	CALLOC_ARRAY(pfd, socklist->nr);
> +
> +	for (i = 0; i < socklist->nr; i++) {
> +		pfd[i].fd = socklist->list[i];
> +		pfd[i].events = POLLIN;
> +	}
> +
> +	signal(SIGCHLD, child_handler);
> +
> +	for (;;) {
> +		int i;
> +		int nr_ready;
> +		int timeout = (pid_file ? 100 : -1);
> +
> +		check_dead_children();
> +
> +		nr_ready = poll(pfd, socklist->nr, timeout);

Setting a timeout here (if 'pid_file' is present) allows us to operate in a
mode where the removal of a 'pid_file' indicates that the server should shut
down.

> +		if (nr_ready < 0) {

'nr_ready < 0' indicates an error [1]; handle the same way as 'daemon.c'.

[1] https://man7.org/linux/man-pages/man2/poll.2.html

> +			if (errno != EINTR) {
> +				logerror("Poll failed, resuming: %s",
> +				      strerror(errno));
> +				sleep(1);
> +			}
> +			continue;
> +		}
> +		else if (nr_ready == 0) {

'nr_ready == 0' indicates a polling timeout (see [1] above)...

> +			/*
> +			 * If we have a pid_file, then we watch it.
> +			 * If someone deletes it, we shutdown the service.
> +			 * The shell scripts in the test suite will use this.
> +			 */
> +			if (!pid_file || file_exists(pid_file))
> +				continue;
> +			goto shutdown;

...and that timeout exists so that we can check whether the 'pid_file' still
exists and, if so, shut down gracefully.

> +		}
> +

Otherwise, 'nr_ready > 1', so handle the polled events.

> +		for (i = 0; i < socklist->nr; i++) {
> +			if (pfd[i].revents & POLLIN) {
> +				union {
> +					struct sockaddr sa;
> +					struct sockaddr_in sai;
> +#ifndef NO_IPV6
> +					struct sockaddr_in6 sai6;
> +#endif
> +				} ss;
> +				socklen_t sslen = sizeof(ss);
> +				int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
> +				if (incoming < 0) {
> +					switch (errno) {
> +					case EAGAIN:
> +					case EINTR:
> +					case ECONNABORTED:
> +						continue;
> +					default:
> +						die_errno("accept returned");
> +					}
> +				}
> +				handle(incoming, &ss.sa, sslen);
> +			}
> +		}
> +	}
> +
> +shutdown:
> +	loginfo("Starting graceful shutdown (pid-file gone)");
> +	for (i = 0; i < socklist->nr; i++)
> +		close(socklist->list[i]);
> +
> +	return 0;

This addition logs the shutdown and closes out sockets. Looks good!

> +}
> +
> +static int serve(struct string_list *listen_addr, int listen_port)
> +{
> +	struct socketlist socklist = { NULL, 0, 0 };
> +
> +	socksetup(listen_addr, listen_port, &socklist);
> +	if (socklist.nr == 0)
> +		die("unable to allocate any listen sockets on port %u",
> +		    listen_port);
> +
> +	loginfo("Ready to rumble");

I thought this was a leftover debug printout, but it turns out that
'serve()' in 'daemon.c' has the same message. :) 

> +
> +	/*
> +	 * Wait to create the pid-file until we've setup the sockets
> +	 * and are open for business.
> +	 */
> +	if (pid_file)
> +		write_file(pid_file, "%"PRIuMAX, (uintmax_t) getpid());
> +
> +	return service_loop(&socklist);
> +}
> +
> +/*
> + * This section is executed by both the primary instance and all
> + * worker instances.  So, yes, each child-process re-parses the
> + * command line argument and re-discovers how it should behave.
> + */
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +	int listen_port = 0;
> +	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
> +	int worker_mode = 0;
> +	int i;
> +
> +	trace2_cmd_name("test-http-server");
> +	setup_git_directory_gently(NULL);

Since this isn't part of 'test-tool', it needs to do its own trace2 setup,
but it seems to be missing some of the relevant function calls. Could you
include 'trace2_cmd_list_config()' and 'trace2_cmd_list_env_vars()' as well? 

> +
> +	for (i = 1; i < argc; i++) {

Can this loop be replaced with 'parse_options()' and the appropriate 'struct
option[]'? Newer test helpers ('test-bundle-uri', 'test-cache-tree',
'test-getcwd') have been using it, and it generally seems much easier to
work with/more flexible than a custom 'if()' block (handling option
negation, interpreting both '--option=<value>' and '--option value' syntax
etc.).

That said, it looks this was mostly pulled from 'daemon.c' (which might
predate 'parse_options()'), so I'd also understand if you want to keep it as
similar to that as possible. Up to you!

> +	/* avoid splitting a message in the middle */
> +	setvbuf(stderr, NULL, _IOFBF, 4096);
> +
> +	if (listen_port == 0)
> +		listen_port = DEFAULT_GIT_PORT;
> +
> +	/*
> +	 * If no --listen=<addr> args are given, the setup_named_sock()
> +	 * code will use receive a NULL address and set INADDR_ANY.
> +	 * This exposes both internal and external interfaces on the
> +	 * port.
> +	 *
> +	 * Disallow that and default to the internal-use-only loopback
> +	 * address.
> +	 */
> +	if (!listen_addr.nr)
> +		string_list_append(&listen_addr, "127.0.0.1");
> +
> +	/*
> +	 * worker_mode is set in our own child process instances
> +	 * (that are bound to a connected socket from a client).
> +	 */
> +	if (worker_mode)
> +		return worker();
> +
> +	/*
> +	 * `cld_argv` is a bit of a clever hack. The top-level instance
> +	 * of test-http-server does the normal bind/listen/accept stuff.
> +	 * For each incoming socket, the top-level process spawns
> +	 * a child instance of test-http-server *WITH* the additional
> +	 * `--worker` argument. This causes the child to set `worker_mode`
> +	 * and immediately call `worker()` using the connected socket (and
> +	 * without the usual need for fork() or threads).
> +	 *
> +	 * The magic here is made possible because `cld_argv` is static
> +	 * and handle() (called by service_loop()) knows about it.
> +	 */
> +	strvec_push(&cld_argv, argv[0]);
> +	strvec_push(&cld_argv, "--worker");
> +	for (i = 1; i < argc; ++i)
> +		strvec_push(&cld_argv, argv[i]);
> +
> +	/*
> +	 * Setup primary instance to listen for connections.
> +	 */
> +	return serve(&listen_addr, listen_port);

The rest of the function is "new", but is well-documented and appears to
work as intended.

> +}

One last note/suggestion - while a lot of the functions in
'test-http-server.c' are modified from those in 'daemon.c', there are a fair
number of identical functions as well. Would it be possible to libify some
of 'daemon.c's functions (mainly by creating a 'daemon.h' and making the
functions non-static) so that they don't need to be copied?

