Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9367A20196
	for <e@80x24.org>; Thu, 14 Jul 2016 17:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbcGNRjl (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 13:39:41 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35036 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbcGNRjj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 13:39:39 -0400
Received: by mail-pa0-f53.google.com with SMTP id dx3so30780304pab.2
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 10:39:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/Vcm3ZXyhYvKaADu3MFrN7fhmlb6H9FJtLlseS5fN5k=;
        b=WPZWMI5G87EZqHPkLv5tcUQQrghvUUAOUcYnKLsjN2GoOQM3h5PJ3h8fPkJxnX3fGT
         z3LEzhs0p3CwzCGfUZaJjyk+F9xgmtI3qNfVFMkHQrlNjRn3/hp6URUkQb0EmTLlmGYa
         GnS+l8K/4uzRkjb4Mkf32Fja3nk+eGRcWcEfu+X1zQU6flGmRzJ9UnCqmw18qxb/NtZP
         e57DFrHR4jFFp+6Yu8IJtrAUIQYBqG939sHAmdLDfcpbotzpzRZ6ba+R9Hs5IEicIEWF
         MxV7qGThbwL2Zt9Z2If0NBIYrG2zItp1EQqzl7z8nOjf+NXuFNrpYtx+XrbaIoECgS7K
         klgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/Vcm3ZXyhYvKaADu3MFrN7fhmlb6H9FJtLlseS5fN5k=;
        b=VEgTtyPHXievUwERvUkOCCJEgcMJAYNXl/Az0BBKCR3j9SC9pHUI0GAexfgJBJQWLn
         coux0iVV0UkMfQSo14nWlI3ZsTG3ljHldefRIBJDkz8uREeUCVMn4nU4w1EeXtnxv9bY
         qTd7jYMZGy0XBazsmkrGoJTHYUcw46sB20b4UwesLkSAfkSU5+O3fVAALbpoYCLXTdxd
         VHxA3uDkXsPdX6fhotLBq9TjZWBp/635j5WZtyvnZEvZepJalGtrR7SG+uM4JwXDu9cN
         wfJ23IPXR+CtuC+H7+MyOFFFUMN2Vx9RR6d+QVkKrJcadxlj1InM9ZEnqP+wk9h3KjMd
         vnww==
X-Gm-Message-State: ALyK8tLCseIGigEEAoTHmHW/OejEI5zhzF5casdCfXeUdXXa54fFLdCl/3/7wYG2+0kkX4YG
X-Received: by 10.66.146.69 with SMTP id ta5mr20104456pab.157.1468517977986;
        Thu, 14 Jul 2016 10:39:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c041:4809:7eab:7652])
        by smtp.gmail.com with ESMTPSA id ot2sm6234536pac.29.2016.07.14.10.39.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Jul 2016 10:39:37 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org, gitster@pobox.com
Cc:	dwwang@google.com, e@80x24.org, peff@peff.net,
	dennis@kaarsemaker.net, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 0/4] Push options
Date:	Thu, 14 Jul 2016 10:39:16 -0700
Message-Id: <20160714173920.22001-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.247.gf748855.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff wrote:
> Junio wrote:
>> I think those extra knobs can come later.  If we are not going to
>> limit with max_options in the end, however, wouldn't it be more
>> natural for the initial iteration without any configuration not to
>> have hard-coded max_options at all?
>
> Yeah, I am OK with adding restrictive knobs later as a separate topic.
> As Stefan notes, upstream does not have the other knobs anyway, and IIRC
> the push-options feature is not even enabled by default.
>
> -Peff

* now it actually is not a default. ;)
* removed knobs, but instead we only reject at > LARGE_PACKET_MAX - 1,

Thanks,
Stefan

v5:
git diff origin/sb/push-options:
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4d8041a..917ac18 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -44,7 +44,7 @@ static struct strbuf fsck_msg_types = STRBUF_INIT;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int advertise_atomic_push = 1;
-static int advertise_push_options = 1;
+static int advertise_push_options;
 static int unpack_limit = 100;
 static int report_status;
 static int use_sideband;
@@ -1501,24 +1501,11 @@ static struct command *read_head_info(struct sha1_array *shallow)
 
 static struct string_list *read_push_options(void)
 {
-	int i;
 	struct string_list *ret = xmalloc(sizeof(*ret));
-	/* NEEDSWORK: expose the limitations to be configurable. */
-	int max_options = 32;
-
-	/*
-	 * NEEDSWORK: expose the limitations to be configurable;
-	 * Once the limit can be lifted, include a way for payloads
-	 * larger than one pkt, e.g allow a payload of up to
-	 * LARGE_PACKET_MAX - 1 only, and reserve the last byte
-	 * to indicate whether the next pkt continues with this
-	 * push option.
-	 */
-	int max_size = 1024;
-
 	string_list_init(ret, 1);
-	for (i = 0; i < max_options; i++) {
-		char *line;
+
+	while (1) {
+		char *line, *lf;
 		int len;
 
 		line = packet_read_line(0, &len);
@@ -1526,7 +1513,14 @@ static struct string_list *read_push_options(void)
 		if (!line)
 			break;
 
-		if (len > max_size) {
+		/*
+		* NEEDSWORK: expose the limitations to be configurable;
+		* Once the limit can be lifted, include a way for payloads
+		* larger than one pkt, e.g use last byte to indicate if
+		* the push option continues in the next packet or implement
+		* larger packets.
+		*/
+		if (len > LARGE_PACKET_MAX - 1) {
 			/*
 			 * NEEDSWORK: The error message in die(..) is not
 			 * transmitted in call cases, so ideally all die(..)
@@ -1534,20 +1528,17 @@ static struct string_list *read_push_options(void)
 			 * combine rp_error && die into one helper function.
 			 */
 			rp_error("protocol error: server configuration allows push "
-				 "options of size up to %d bytes", max_size);
+				 "options of size up to %d bytes",
+				 LARGE_PACKET_MAX - 1);
 			die("protocol error: push options too large");
 		}
 
-		len = strcspn(line, "\n");
-		line[len] = '\0';
+		lf = strchr(line, '\n');
+		if (lf)
+			*lf = '\0';
 
 		string_list_append(ret, line);
 	}
-	if (i == max_options) {
-		rp_error("protocol error: server configuration only allows up "
-		    "to %d push options", max_options);
-		die("protocol error: push options too large");
-	}
 
 	return ret;
 }
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 8dd3c8e..ea813b9 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -57,6 +57,7 @@ test_refs () {
 
 test_expect_success 'one push option works for a single branch' '
 	mk_repo_pair &&
+	git -C upstream config receive.advertisePushOptions true &&
 	(
 		cd workbench &&
 		test_commit one &&
@@ -85,6 +86,7 @@ test_expect_success 'push option denied by remote' '
 
 test_expect_success 'two push options work' '
 	mk_repo_pair &&
+	git -C upstream config receive.advertisePushOptions true &&
 	(
 		cd workbench &&
 		test_commit one &&



cover letter v4:

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

