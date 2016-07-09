Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7575E1F744
	for <e@80x24.org>; Sat,  9 Jul 2016 00:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbcGIAbg (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 20:31:36 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35246 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756299AbcGIAbe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 20:31:34 -0400
Received: by mail-pf0-f180.google.com with SMTP id c2so17298478pfa.2
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 17:31:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7NOaC2du07oKTqaV+SXI0WMGIo9zNtge4dN7ncgu3LU=;
        b=jwN2nHNPb8reskRGfKNem0hN8sUJRtVz0pJYAeRYY2nCTGg4Qq2oXm04GYHXKVUNaE
         x7an/jSKDsLJZAfx1da+FYRys/nzcYJxEVNMPC445Zcq4FSMeFPZSuk48J7twLA/oFnl
         OogULALk9DviupiuvkjfKfPfCXeab52Mzt9weo0st3xzOjwFhzs0KEdgc+kA9sXDu/0Z
         T8cU8T/4WAhgIwot882Pjj8OcvTbV1VzsqqDfI7/HP6D18HfGmGX749MIGgDt9T5bGeJ
         3qWaq0YewInxjF6zDnRf2dYsOoKbNkJBIkABZG6JCsr9FbOJSmhosnlvAu1tsMurwzMS
         wpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7NOaC2du07oKTqaV+SXI0WMGIo9zNtge4dN7ncgu3LU=;
        b=NMsXEFQr1MI6ldbpnfOwpa00SRCcE8+iZaIYRh7C2JiQJAg+QG1CHoCeabM8suNmvH
         L0YfYQ/AKK00YA5m4fY9IPAN3AfwwyqD6TO7jiwSknJsEesyqBG8KwkFLKrKTbDphCmH
         ehgRG6k7DICx/jNkSCzX0gfdvgZnyGhYIkhhxhWFaTc8J6KJdiijt43FbCh1AAs11JuM
         DDk/hpi48NfZSI2byjmyxEJZ8+8KRmmm3WSWw9OXacNveX+CGd0BNrJIQaGOrkIc0R4K
         sUwGEhqXgfQi1xH+h+42BVSuYi7N/pmisFw27UxA4U3ddAArHVNe76TO/UYP+AgGI0UJ
         Z5rQ==
X-Gm-Message-State: ALyK8tIHoEpWv4Cis8Pv2O+HnBnZBgAsh4H09822CTNWb0Rt+IIw6g4yp8sbYfLoRID0QyEX
X-Received: by 10.98.7.22 with SMTP id b22mr14481898pfd.56.1468024281490;
        Fri, 08 Jul 2016 17:31:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ccd7:b4ac:db99:b698])
        by smtp.gmail.com with ESMTPSA id z127sm6939244pfz.20.2016.07.08.17.31.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 08 Jul 2016 17:31:20 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, e@80x24.org, peff@peff.net, dwwang@google.com,
	dennis@kaarsemaker.net, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 0/4] Push options
Date:	Fri,  8 Jul 2016 17:31:09 -0700
Message-Id: <20160709003113.26930-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.247.g176c4f7
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Thanks Junio, Jeff, Jonathan for discussion and feedback!

I went over the emails again and we seem to agree that the initial design (in v3)
was sane and the error messages and reporting for corner cases were to be
dismissed as "it happens as often as 'BUG:' messages appear, so let's not care
too deeply now".

Thanks,
Stefan

This is a diff against a modified v3 (it's actually origin/sb/push-options):
diff --git a/Documentation/config.txt b/Documentation/config.txt
index df1b314..25b5db1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2410,13 +2410,13 @@ rebase.instructionFormat
 
 receive.advertiseAtomic::
 	By default, git-receive-pack will advertise the atomic push
-	capability to its clients. If you don't want this capability
-	to be advertised, set this variable to false.
+	capability to its clients. If you don't want to advertise this
+	capability, set this variable to false.
 
 receive.advertisePushOptions::
-	By default, git-receive-pack will advertise the push options capability
-	to its clients. If you don't want this capability
-	to be advertised, set this variable to false.
+	By default, git-receive-pack will advertise the push options
+	capability to its clients. If you don't want to advertise this
+	capability, set this variable to false.
 
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index b0b1273..e960258 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -156,11 +156,11 @@ already exists on the remote side.
 	Either all refs are updated, or on error, no refs are updated.
 	If the server does not support atomic pushes the push will fail.
 
--L::
+-o::
 --push-option::
 	Transmit the given string to the server, which passes them to
-	the pre-receive as well as the post-receive hook. Only C strings
-	containing no new lines are allowed.
+	the pre-receive as well as the post-receive hook. The given string
+	must not contain a NUL or LF character.
 
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index c875cde..9565dc3 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -247,8 +247,14 @@ Both standard output and standard error output are forwarded to
 'git send-pack' on the other end, so you can simply `echo` messages
 for the user.
 
-The number of push options are available in the variable GIT_PUSH_OPTION_COUNT
-and the options itself are in GIT_PUSH_OPTION_{0,1,...}.
+The number of push options given on the command line of
+`git push --push-option=...` can be read from the environment
+variable `GIT_PUSH_OPTION_COUNT`, and the options themselves are
+found in `GIT_PUSH_OPTION_0`, `GIT_PUSH_OPTION_1`,...
+If it is negotiated to not use the push options phase, the
+environment variables will not be set. If the client selects
+to use push options, but doesn't transmit any, the count variable
+will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
 
 [[update]]
 update
@@ -325,8 +331,14 @@ a sample script `post-receive-email` provided in the `contrib/hooks`
 directory in Git distribution, which implements sending commit
 emails.
 
-The number of push options are available in the variable GIT_PUSH_OPTION_COUNT
-and the options itself are in GIT_PUSH_OPTION_{0,1,...}.
+The number of push options given on the command line of
+`git push --push-option=...` can be read from the environment
+variable `GIT_PUSH_OPTION_COUNT`, and the options themselves are
+found in `GIT_PUSH_OPTION_0`, `GIT_PUSH_OPTION_1`,...
+If it is negotiated to not use the push options phase, the
+environment variables will not be set. If the client selects
+to use push options, but doesn't transmit any, the count variable
+will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
 
 [[post-update]]
 post-update
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index b71eda9..4c28d3a 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -256,10 +256,11 @@ updated or none.
 push-options
 ------------
 
-If the server sends the 'push-options' capability it is capable to accept
-push options after the update commands have been sent. If the pushing client
-requests this capability, the server will pass the options to the pre and post
-receive hooks that process this push request.
+If the server sends the 'push-options' capability it is able to accept
+push options after the update commands have been sent, but before the
+packfile is streamed. If the pushing client requests this capability,
+the server will pass the options to the pre- and post- receive hooks
+that process this push request.
 
 allow-tip-sha1-in-want
 ----------------------
diff --git a/builtin/push.c b/builtin/push.c
index 1b5d205..3bb9d6b 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -508,6 +508,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int rc;
 	const char *repo = NULL;	/* default repository */
 	static struct string_list push_options = STRING_LIST_INIT_DUP;
+	static struct string_list_item *item;
 
 	struct option options[] = {
 		OPT__VERBOSITY(&verbosity),
@@ -573,6 +574,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		set_refspecs(argv + 1, argc - 1, repo);
 	}
 
+	for_each_string_list_item(item, &push_options)
+		if (strchr(item->string, '\n'))
+			die(_("push options must not have new line characters"));
+
 	rc = do_push(repo, flags, &push_options);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e71041a..754db6e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -214,12 +214,12 @@ static void show_ref(const char *path, const unsigned char *sha1)
 			      "report-status delete-refs side-band-64k quiet");
 		if (advertise_atomic_push)
 			strbuf_addstr(&cap, " atomic");
-		if (advertise_push_options)
-			strbuf_addstr(&cap, " push-options");
 		if (prefer_ofs_delta)
 			strbuf_addstr(&cap, " ofs-delta");
 		if (push_cert_nonce)
 			strbuf_addf(&cap, " push-cert=%s", push_cert_nonce);
+		if (advertise_push_options)
+			strbuf_addstr(&cap, " push-options");
 		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
 		packet_write(1, "%s %s%c%s\n",
 			     sha1_to_hex(sha1), path, 0, cap.buf);
@@ -584,7 +584,7 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 	proc.argv = argv;
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
-	if (feed_state && feed_state->push_options) {
+	if (feed_state->push_options) {
 		int i;
 		for (i = 0; i < feed_state->push_options->nr; i++)
 			argv_array_pushf(&proc.env_array,
@@ -592,7 +592,8 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 				feed_state->push_options->items[i].string);
 		argv_array_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT=%d",
 				 feed_state->push_options->nr);
-	}
+	} else
+		argv_array_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT");
 
 	if (use_sideband) {
 		memset(&muxer, 0, sizeof(muxer));
@@ -1498,7 +1499,7 @@ static struct command *read_head_info(struct sha1_array *shallow)
 	return commands;
 }
 
-static struct string_list *read_push_options()
+static struct string_list *read_push_options(void)
 {
 	int i;
 	struct string_list *ret = xmalloc(sizeof(*ret));
@@ -1526,18 +1527,28 @@ static struct string_list *read_push_options()
 		if (!line)
 			break;
 
-		if (len > max_size)
-			die("protocol error: server configuration allows push "
-			    "options of size up to %d bytes", max_size);
+		if (len > max_size) {
+			/*
+			 * NEEDSWORK: The error message in die(..) is not
+			 * transmitted in call cases, so ideally all die(..)
+			 * calls are prefixed with rp_error and then we can
+			 * combine rp_error && die into one helper function.
+			 */
+			rp_error("protocol error: server configuration allows push "
+				 "options of size up to %d bytes", max_size);
+			die("protocol error: push options too large");
+		}
 
 		len = strcspn(line, "\n");
 		line[len] = '\0';
 
 		string_list_append(ret, line);
 	}
-	if (i == max_options)
-		die("protocol error: server configuration only allows up "
+	if (i == max_options) {
+		rp_error("protocol error: server configuration only allows up "
 		    "to %d push options", max_options);
+		die("protocol error: push options too large");
+	}
 
 	return ret;
 }
diff --git a/send-pack.c b/send-pack.c
index c943560..3a842ac 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -277,13 +277,10 @@ static int generate_push_cert(struct strbuf *req_buf,
 	}
 	if (push_cert_nonce[0])
 		strbuf_addf(&cert, "nonce %s\n", push_cert_nonce);
-	strbuf_addstr(&cert, "\n");
-
-	if (args->push_options) {
+	if (args->push_options)
 		for_each_string_list_item(item, args->push_options)
 			strbuf_addf(&cert, "push-option %s\n", item->string);
-		strbuf_addstr(&cert, "\n");
-	}
+	strbuf_addstr(&cert, "\n");
 
 	for (ref = remote_refs; ref; ref = ref->next) {
 		if (check_to_send_update(ref, args) < 0)
diff --git a/templates/hooks--pre-receive.sample b/templates/hooks--pre-receive.sample
index e4d3edc..a1fd29e 100644
--- a/templates/hooks--pre-receive.sample
+++ b/templates/hooks--pre-receive.sample
@@ -6,13 +6,15 @@
 #
 # To enable this hook, rename this file to "pre-receive".
 
-if test -n "$GIT_PUSH_OPTION_COUNT"; then
+if test -n "$GIT_PUSH_OPTION_COUNT"
+then
 	i=0
-	while test "$i" -lt "$GIT_PUSH_OPTION_COUNT"; do
+	while test "$i" -lt "$GIT_PUSH_OPTION_COUNT"
+	do
 		eval "value=\$GIT_PUSH_OPTION_$i"
 		case "$value" in
 		echoback=*)
-			echo "echo from the pre-receive-hook ${value#*=}" >&2
+			echo "echo from the pre-receive-hook: ${value#*=}" >&2
 			;;
 		reject)
 			exit 1


Cover letter v3:
================

This is not marked for RFC any more, as I do not recall any open points
left for discussion. This addresses the only reply from Eric Wong on patch 3:

diff to v2:
diff --git a/send-pack.c b/send-pack.c
index e328276..c943560 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -536,7 +536,8 @@ int send_pack(struct send_pack_args *args,
 
                for_each_string_list_item(item, args->push_options)
                        packet_buf_write(&sb, "%s", item->string);
-                       write_or_die(out, sb.buf, sb.len);
+
+               write_or_die(out, sb.buf, sb.len);
                packet_flush(out);
                strbuf_release(&sb);
        }
diff --git a/transport.c b/transport.c
index 598bd1f..0298be1 100644
--- a/transport.c
+++ b/transport.c
@@ -641,7 +641,6 @@ struct transport *transport_get(struct remote *remote, const char *url)
        struct transport *ret = xcalloc(1, sizeof(*ret));
 
        ret->progress = isatty(2);
-       ret->push_options = NULL;
 
        if (!remote)
                die("No remote provided to transport_get()");

Cover letter v2:
================

Allow a user to pass information along a push to the pre/post-receive hook
on the remote.

Jeff writes on v1:
> Whereas in Dennis's patches, it was about specific information directly
> related to the act of pushing.

This allows to transmit arbitrary information as the backends of $VENDOR
may have different options available related to the direct act of pushing.

Thanks,
Stefan

Cover letter v1:
================

Allow a user to pass information along a push to the pre/post-receive hook
on the remote.

When using a remote that is more than just a plain Git host (e.g. Gerrit,
Git{hub/lab}, etc) this may become more obvious: The (server backend specific)
push options can instruct the server to:
* open a pull request
* send out emails asking for review
* (un)trigger continuous integration
* set priority for continuous integration (i.e. bots pushing may ask to be
  treated with lower priority compared to humans)
* ... 

Most of these actions can be done on the client side as well,
but in these remote-centric workflows it is easier to do that on the remote,
which is why we need to transport the information there.

More concrete examples:
* When you want a change in Gerrit to be submitted to refs/heads/master, you
  push instead to a magic branch refs/for/master and Gerrit will create a change
  for you (similar to a pull request). Instead we could imagine that you push
  to a magical refs/heads/master with a push option "create-change".
  
* When pushing to Gerrit you can already attach some of this information by
  adding a '%' followed by the parameter to the ref, i.e. when interacting with
  Gerrit it is possible to do things like[1]:
    
    git push origin HEAD:refs/for/master%draft%topic=example%cc=jon.doe@example.org
  
  This is not appealing to our users as it looks like hacks upon hacks to make
  it work. It would read better if it was spelled as:
  
  git push origin HEAD:refs/for/master \
      --push-option draft \
      --push-option topic=example \
      --push-option cc=jon.doe@example.org
      
  (with a short form that is even easier to type,
   but this is is more intuitive already)

This is a patch series to Git core, which is developed at the same time
as a change is proposed to JGit by Dan Wang, see [2].

This code is also available at [3].

Thanks,
Stefan

[1] Not all Gerrit '%' options are documented, so here is a link to source code instead :(
https://gerrit.googlesource.com/gerrit/+/refs/heads/master/gerrit-server/src/main/java/com/google/gerrit/server/git/ReceiveCommits.java#1141

[2] https://git.eclipse.org/r/#/c/74570/ 
 
[3] https://github.com/stefanbeller/git/tree/pushoptions

Stefan Beller (4):
  push options: {pre,post}-receive hook learns about push options
  receive-pack: implement advertising and receiving push options
  push: accept push options
  add a test for push options

 Documentation/config.txt                          |  7 +-
 Documentation/git-push.txt                        |  8 ++-
 Documentation/githooks.txt                        |  4 ++
 Documentation/technical/pack-protocol.txt         | 10 +--
 Documentation/technical/protocol-capabilities.txt |  8 +++
 builtin/push.c                                    | 16 ++++-
 builtin/receive-pack.c                            | 85 +++++++++++++++++++----
 send-pack.c                                       | 29 ++++++++
 send-pack.h                                       |  3 +
 t/t5544-push-options.sh                           | 85 +++++++++++++++++++++++
 transport.c                                       |  2 +
 transport.h                                       |  7 ++
 12 files changed, 242 insertions(+), 22 deletions(-)
 create mode 100755 t/t5544-push-options.sh

-- 
2.9.0.141.gdd65b60

