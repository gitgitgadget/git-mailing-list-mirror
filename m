Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CD7C129
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 03:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721447036; cv=none; b=BVH7qjPWtuV0mCYvHHRqSO/eMrg4EnchjDVOFyaiQKCUXKapaxxdn5nCsm3IFZFz67YQstaQLZu6RsqqVjHSrAUIkzPTM9zajW2KQ44iSlkxUCsrOLlLjWhHVE5/Fcgr911121IFdbG/tDAqNLhTYhvxJSiuKCbItM+a/L6ES/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721447036; c=relaxed/simple;
	bh=TPBqQFwYkoKuYXP4d+PPSO+fqrY9+Y6IJzab55v+f/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4FKeuGoy2cSqhYOKu7HSFCJMuncpO7gvgEMrkrJGmbCiyZ8G3Xc+9Eql9F6DH/7Hu985kDM+Dxh36Gq35pEwkOSlYZV5t6BpmwsRefLIPSQFSd4E5NGbwLzpUsgXXtOAPlzBen8gIig2aYwiI65rMcgY6AHOAPoaL6I5ny9Zm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efRXUkip; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efRXUkip"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-79ef810bd4fso132042385a.2
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 20:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721447033; x=1722051833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jb/u8D1WXtJC68dU4YTTrERdIZr4rkp79VRoTjQW/G4=;
        b=efRXUkipXMZd+VF/hrNShFOutlYViIa85e0GyGL2EO5Amvs5K4sUGVbYRZQ7QHW3G6
         ZIIaLcej/xI3mSGnjqBercn/peMk4E/Sva9Ik9C/q1BxeSQlvPIa+6IFmIdlf52AIcDq
         Y7shb8hJUcfH3BYmX48Y+/Fk9Ty3oT7zIDGrlbIdaXl+mVacLM4Gi2BRavf1ULQis1e3
         o/Jk7WcI4nPGkpLCoQz4+kdaltsO9rW1wJ7TQMBeDlJ59p34MTtgYBvQCAcYbv5b6JNG
         9cilUG+cfMEksPKylM9GnZuC1JoDYkUyZE9qrAF+9b5hMa8RBrlubak2dxvkSHu3vL1P
         rIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721447033; x=1722051833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb/u8D1WXtJC68dU4YTTrERdIZr4rkp79VRoTjQW/G4=;
        b=L6i/eDUeGV8FUN+5oCr3vcujugiZeTXZX+KdF2vOq5xzxDCTBmzj5ABgVJ3oqp8rEo
         YPC5TlvuZNdxLK3eKXkCZkV6+3nV2NR1iA72/Pqtsp6RFfDRTT/cwurAOUgYrDdxuLAU
         zMbUn7iuX2rD+fB4fX1wCXUHusIgKPQ9SHeFc+p7fxTsso0FqO21WoujMqSb2IpxVxs4
         845J7c28XoXDYy88nlknZ8dV3nVH6kErGjHG1abU+B/ha6wU+I1CHrm24xj9yEyRXBGm
         3wwEdAXdD9e7FSvtX742l1qAQqEV1nFIH8mbtRGWqc76oVrIMwTBLaINqLB1w6Ljgus7
         /Yug==
X-Gm-Message-State: AOJu0YzjKX9IsJchTm7vwJq+rdLJ701pXdqo9+v693Yc+xLeOBR0fEqZ
	otzMTk6KATNYofYqhAwc5UzoaPuBKoghCHn6X9f6+yHIbR0H78WNbPkgP0Wziz8=
X-Google-Smtp-Source: AGHT+IEjMucEDANvoHYYYgHz8LWR8u7zM+IeXJCSRhJw70KYD/w0yEqbdTlErwp9mXIVfTjQVSr5/w==
X-Received: by 2002:a05:620a:4688:b0:79d:535f:b777 with SMTP id af79cd13be357-7a1a65fc35fmr39502585a.52.1721447032664;
        Fri, 19 Jul 2024 20:43:52 -0700 (PDT)
Received: from localhost.localdomain (bras-base-unvlon5586w-grc-14-76-71-94-205.dsl.bell.ca. [76.71.94.205])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a199073b49sm150487385a.100.2024.07.19.20.43.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jul 2024 20:43:52 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v2 0/6] cat-file: add remote-object-info to batch-command
Date: Fri, 19 Jul 2024 23:43:31 -0400
Message-ID: <20240720034337.57125-1-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628190503.67389-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a continuation of Calvin Wan's (calvinwan@google.com)
patch series [PATCH v5 0/6] cat-file: add --batch-command remote-object-info command at [1].

Sometimes it is useful to get information about an object without having to download
it completely. The server logic for retrieving size has already been implemented and merged in
"a2ba162cda (object-info: support for retrieving object info, 2021-04-20)"[2].
This patch series implement the client option for it.

This patch series add the `remote-object-info` command to `cat-file --batch-command`.
This command allows the client to make an object-info command request to a server
that supports protocol v2. If the server is v2, but does not have
object-info capability, the entire object is fetched and the
relevant object info is returned.

A few questions open for discussions please:

1. In the current implementation, if a user puts `remote-object-info` in protocol v1,
   `cat-file --batch-command` will die. Which way do we prefer? "error and exit (i.e. die)"
   or "warn and wait for new command".

2. Right now, only the size is supported. If the batch command format
   contains objectsize:disk or deltabase, it will die. The question
   is about objecttype. In the current implementation, it will die too.
   But dying on objecttype breaks the default format. We have changed the
   default format to %(objectname) %(objectsize) when remote-object-info is used.
   Any suggestions on this approach?

[1] https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.com/#t
[2] https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2ba162cda2acc171c3e36acbbc854792b093cb7

V1 of the patch series can be found here:
https://lore.kernel.org/git/20240628190503.67389-1-eric.peijian@gmail.com/


Changes since V1
================

- The function parse_remote_info() has been renamed to
  parse_cmd_remote_object_info() and its signature has been modified to comply
  with parse_cmd_fn_t. This function now serves as the mapped function for the
  remote-object-info command.

  This change simplifies the code by avoiding command name comparisons and
  reusing logic that fits parse_cmd_fn_t.

- Added more tests to cover fallbacks. When the server does not support the
  object-info capability, remote-object-info will fetch the objects locally and
  print out the information.

- Fixed a logic issue that could lead to a potential heap-buffer-overflow error.
  The alloc_ref function is now used to initialize a ref struct instead of xcalloc.

- Refactored some logic for improved readability, such as how to initialize the
  transport->remote_refs linked list.

Thank you.

Eric Ju

Calvin Wan (5):
  fetch-pack: refactor packet writing
  fetch-pack: move fetch initialization
  serve: advertise object-info feature
  transport: add client support for object-info
  cat-file: add remote-object-info to batch-command

Eric Ju (1):
  cat-file: add declaration of variable i inside its for loop

 Documentation/git-cat-file.txt         |  23 +-
 builtin/cat-file.c                     | 127 ++++-
 fetch-pack.c                           |  48 +-
 fetch-pack.h                           |  10 +
 object-file.c                          |  11 +
 object-store-ll.h                      |   3 +
 serve.c                                |   4 +-
 t/t1017-cat-file-remote-object-info.sh | 748 +++++++++++++++++++++++++
 transport-helper.c                     |   8 +-
 transport.c                            | 118 +++-
 transport.h                            |  11 +
 11 files changed, 1075 insertions(+), 36 deletions(-)
 create mode 100755 t/t1017-cat-file-remote-object-info.sh

Range-diff against v1:
1:  fdd44b16b5 ! 1:  97871cb75e fetch-pack: refactor packet writing
    @@ Metadata
      ## Commit message ##
         fetch-pack: refactor packet writing
     
    -    A subsequent patch need to write capabilities for another command.
    -    Refactor write_fetch_command_and_capabilities() to be used by both
    -    fetch and future command.
    +    A subsequent patch needs to write capabilities for another command.
    +    Refactor write_fetch_command_and_capabilities() to be a more general
    +    purpose function write_command_and_capabilities(), so that it can be
    +    used by both fetch and future command.
    +
    +    Here "command" means the "operations" supported by Git’s wire protocol
    +    https://git-scm.com/docs/protocol-v2. An example would be a
    +    git's subcommand, such as git-fetch(1); or an operation supported by
    +    the server side such as "object-info" implemented in "a2ba162cda
    +    (object-info: support for retrieving object info, 2021-04-20)".
     
    -    Signed-off-by: Calvin Wan <calvinwan@google.com>
    -    Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
         Helped-by: Jonathan Tan <jonathantanmy@google.com>
         Helped-by: Christian Couder <chriscool@tuxfamily.org>
    +    Signed-off-by: Calvin Wan <calvinwan@google.com>
    +    Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
     
      ## fetch-pack.c ##
     @@ fetch-pack.c: static int add_haves(struct fetch_negotiator *negotiator,
2:  890219ce6a ! 2:  301047c574 fetch-pack: move fetch initialization
    @@ Commit message
         from the beginning of the first state to just before the execution of
         the state machine.
     
    -    Signed-off-by: Calvin Wan <calvinwan@google.com>
    -    Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
         Helped-by: Jonathan Tan <jonathantanmy@google.com>
         Helped-by: Christian Couder <chriscool@tuxfamily.org>
    +    Signed-off-by: Calvin Wan <calvinwan@google.com>
    +    Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
     
      ## fetch-pack.c ##
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
3:  6844095b26 ! 3:  5d83c4f5b2 serve: advertise object-info feature
    @@ Commit message
         client to decide whether to query the server for object-info or fetch
         as a fallback.
     
    -    Signed-off-by: Calvin Wan <calvinwan@google.com>
    -    Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
         Helped-by: Jonathan Tan <jonathantanmy@google.com>
         Helped-by: Christian Couder <chriscool@tuxfamily.org>
    +    Signed-off-by: Calvin Wan <calvinwan@google.com>
    +    Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
     
      ## serve.c ##
     @@ serve.c: static void session_id_receive(struct repository *r UNUSED,
4:  c940cb1657 ! 4:  a7210b7169 transport: add client support for object-info
    @@ Commit message
     
         Sometimes it is useful to get information about an object without having
         to download it completely. The server logic has already been implemented
    -    as “a2ba162cda (object-info: support for retrieving object info,
    +    in “a2ba162cda (object-info: support for retrieving object info,
         2021-04-20)”.
     
         Add client functions to communicate with the server.
     
         The client currently supports requesting a list of object ids with
    -    features 'size' and 'type' from a v2 server. If a server does not
    -    advertise either of the requested features, then the client falls back
    +    feature 'size' from a v2 server. If a server does not
    +    advertise the feature, then the client falls back
         to making the request through 'fetch'.
     
    -    Signed-off-by: Calvin Wan <calvinwan@google.com>
    -    Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
         Helped-by: Jonathan Tan <jonathantanmy@google.com>
         Helped-by: Christian Couder <chriscool@tuxfamily.org>
    +    Signed-off-by: Calvin Wan <calvinwan@google.com>
    +    Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
     
      ## fetch-pack.c ##
     @@ fetch-pack.c: static void write_command_and_capabilities(struct strbuf *req_buf,
    @@ fetch-pack.h: struct fetch_pack_args {
      	const struct string_list *deepen_not;
      	struct list_objects_filter_options filter_options;
      	const struct string_list *server_options;
    -+	struct object_info **object_info_data;
    ++	struct object_info *object_info_data;
      
      	/*
      	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
    @@ transport.c: static struct ref *handshake(struct transport *transport, int for_p
      	return refs;
      }
      
    -+static int fetch_object_info(struct transport *transport, struct object_info **object_info_data)
    ++static int fetch_object_info(struct transport *transport, struct object_info *object_info_data)
     +{
     +	int size_index = -1;
     +	struct git_transport_data *data = transport->data;
    -+	struct object_info_args args;
    ++	struct object_info_args args = { 0 };
     +	struct packet_reader reader;
     +
    -+	memset(&args, 0, sizeof(args));
     +	args.server_options = transport->server_options;
     +	args.object_info_options = transport->smart_options->object_info_options;
     +	args.oids = transport->smart_options->object_info_oids;
    @@ transport.c: static struct ref *handshake(struct transport *transport, int for_p
     +			return -1;
     +		}
     +		if (unsorted_string_list_has_string(args.object_info_options, reader.line)) {
    -+			if (!strcmp(reader.line, "size"))
    ++			if (!strcmp(reader.line, "size")) {
     +				size_index = i;
    ++				for (size_t j = 0; j < args.oids->nr; j++) {
    ++					object_info_data[j].sizep = xcalloc(1, sizeof(long));
    ++				}
    ++			}
     +			continue;
     +		}
     +		return -1;
    @@ transport.c: static struct ref *handshake(struct transport *transport, int for_p
     +			if (!strcmp(object_info_values.items[1 + size_index].string, ""))
     +				die("object-info: not our ref %s",
     +					object_info_values.items[0].string);
    -+			*(*object_info_data)[i].sizep = strtoul(object_info_values.items[1 + size_index].string, NULL, 10);
    ++
    ++			*object_info_data[i].sizep = strtoul(object_info_values.items[1 + size_index].string, NULL, 10);
    ++
     +		}
    ++
    ++		string_list_clear(&object_info_values, 0);
     +	}
     +	check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless delimiter expected");
     +
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
      	struct ref *refs = NULL;
      	struct fetch_pack_args args;
      	struct ref *refs_tmp = NULL;
    -+	struct ref *object_info_refs = xcalloc(1, sizeof (struct ref));
    ++	struct ref *object_info_refs = NULL;
      
      	memset(&args, 0, sizeof(args));
      	args.uploadpack = data->options.uploadpack;
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
      	args.server_options = transport->server_options;
      	args.negotiation_tips = data->options.negotiation_tips;
      	args.reject_shallow_remote = transport->smart_options->reject_shallow;
    --
    --	if (!data->finished_handshake) {
    --		int i;
     +	args.object_info = transport->smart_options->object_info;
     +
    -+	if (transport->smart_options && transport->smart_options->object_info) {
    -+		struct ref *ref = object_info_refs;
    ++	if (transport->smart_options
    ++		&& transport->smart_options->object_info
    ++		&& transport->smart_options->object_info_oids->nr > 0) {
    ++		struct ref *ref_itr = object_info_refs = alloc_ref("");
     +
     +		if (!fetch_object_info(transport, data->options.object_info_data))
     +			goto cleanup;
    ++
     +		args.object_info_data = data->options.object_info_data;
     +		args.quiet = 1;
     +		args.no_progress = 1;
     +		for (size_t i = 0; i < transport->smart_options->object_info_oids->nr; i++) {
    -+			struct ref *temp_ref = xcalloc(1, sizeof (struct ref));
    -+			temp_ref->old_oid = *(transport->smart_options->object_info_oids->oid + i);
    -+			temp_ref->exact_oid = 1;
    -+			ref->next = temp_ref;
    -+			ref = ref->next;
    ++			ref_itr->old_oid = transport->smart_options->object_info_oids->oid[i];
    ++			ref_itr->exact_oid = 1;
    ++			if (i == transport->smart_options->object_info_oids->nr - 1)
    ++				/* last element, no need to allocat to next */
    ++				ref_itr -> next = NULL;
    ++			else
    ++				ref_itr->next = alloc_ref("");
    + 
    +-	if (!data->finished_handshake) {
    +-		int i;
    ++			ref_itr = ref_itr->next;
     +		}
    -+		transport->remote_refs = object_info_refs->next;
    ++
    ++		transport->remote_refs = object_info_refs;
    ++
     +	} else if (!data->finished_handshake) {
      		int must_list_refs = 0;
     -		for (i = 0; i < nr_heads; i++) {
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
      
      	data->finished_handshake = 0;
     +	if (args.object_info) {
    -+		struct ref *ref_cpy_reader = object_info_refs->next;
    ++		struct ref *ref_cpy_reader = object_info_refs;
     +		for (int i = 0; ref_cpy_reader; i++) {
    -+			oid_object_info_extended(the_repository, &ref_cpy_reader->old_oid, &(*args.object_info_data)[i], OBJECT_INFO_LOOKUP_REPLACE);
    ++			oid_object_info_extended(the_repository, &ref_cpy_reader->old_oid, &args.object_info_data[i], OBJECT_INFO_LOOKUP_REPLACE);
     +			ref_cpy_reader = ref_cpy_reader->next;
     +		}
     +	}
    ++
      	data->options.self_contained_and_connected =
      		args.self_contained_and_connected;
      	data->options.connectivity_checked = args.connectivity_checked;
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
      		ret = -1;
      	if (report_unmatched_refs(to_fetch, nr_heads))
      		ret = -1;
    -@@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
    + 
    + cleanup:
    ++	free_refs(object_info_refs);
    + 	close(data->fd[0]);
    + 	if (data->fd[1] >= 0)
    + 		close(data->fd[1]);
    + 	if (finish_connect(data->conn))
    + 		ret = -1;
    + 	data->conn = NULL;
    +-
      	free_refs(refs_tmp);
      	free_refs(refs);
      	list_objects_filter_release(&args.filter_options);
    -+	free_refs(object_info_refs);
    - 	return ret;
    - }
    - 
     
      ## transport.h ##
     @@
    @@ transport.h: struct git_transport_options {
      	struct oidset *acked_commits;
     +
     +	struct oid_array *object_info_oids;
    -+	struct object_info **object_info_data;
    ++	struct object_info *object_info_data;
     +	struct string_list *object_info_options;
      };
      
5:  6526e24aa4 ! 5:  2787327782 cat-file: add declaration of variable i inside its for loop
    @@ Commit message
     
         Change the declaration of i to be inside the for loop for readability.
     
    -    Signed-off-by: Eric Ju <eric.peijian@gmail.com>
         Helped-by: Christian Couder <chriscool@tuxfamily.org>
    +    Signed-off-by: Eric Ju <eric.peijian@gmail.com>
     
      ## builtin/cat-file.c ##
     @@ builtin/cat-file.c: static void dispatch_calls(struct batch_options *opt,
    @@ builtin/cat-file.c: static void dispatch_calls(struct batch_options *opt,
      		die(_("flush is only for --buffer mode"));
      
     -	for (i = 0; i < nr; i++)
    -+	for (int i = 0; i < nr; i++)
    ++	for (size_t i = 0; i < nr; i++)
      		cmd[i].fn(opt, cmd[i].line, output, data);
      
      	fflush(stdout);
    @@ builtin/cat-file.c: static void batch_objects_command(struct batch_options *opt,
      			die(_("whitespace before command: '%s'"), input.buf);
      
     -		for (i = 0; i < ARRAY_SIZE(commands); i++) {
    -+		for (int i = 0; i < ARRAY_SIZE(commands); i++) {
    ++		for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
      			if (!skip_prefix(input.buf, commands[i].name, &cmd_end))
      				continue;
      
6:  5cd1a1dbd2 < -:  ---------- cat-file: add remote-object-info to batch-command
-:  ---------- > 6:  cb114765cf cat-file: add remote-object-info to batch-command
-- 
2.45.2

