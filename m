Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AE919B586
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 18:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361480; cv=none; b=h44C1BUuO7v36kWaxjbYKe4tpTctWoxuaaIAM2+0KcG4/lpZxIypkIoA7oQMslmk526ejELMNkXvaVPW2f8JR7mdvH+0lOOrZQz6QWKBbj8drcyT0UVWMh+B1GP5DFvHGcrlGeokJ8DqSGmX3boweWLVLXt5QoxcyCfsGl2OMCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361480; c=relaxed/simple;
	bh=EUtjkxccSNsYAs2Bd6cd4rSoTkDRU1atTnWDm5IQ+58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MELI2hQBb9gXEkeR0D+oFdanvrhRiaBPr6bboJinJR7lWaLYtj60x1CjKetuVzMidir/MZYUHuYGPZE/lqx08x09ao8i3A7WhJCu8xOUqAgWVujb0jdLFcj7sW63+BA/rDV5A8YpioIAgXKdYFfo+tI3Ox2X1FsWcRq222ughxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOnDws06; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOnDws06"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d8a3e99e32so1388566d6.2
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 10:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736361477; x=1736966277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MS/hvL0txM5VNNlebJVUExcD4Ns/vp/IhXrC8aJXFEM=;
        b=HOnDws06yTg6x/ckeDRU1Li2ZBVTQ1mA9DqQsaTCTK/LZ1jVBGJtaZJuDcsj4hCvyt
         wmZOGGgqPi6ey9JJdzHeGU7g6QNVc75qX2u6lyMNetjYJHeVS34EXinAOj7ZSzgtwX5d
         gHnBFOMDKObUiOXLrTzhP5xpStWb4qu5iMV6HThuo47UE3bXnIA2nEEsaDiA1uUFby98
         b92SKw42DjMMlXxQyAOZOzP+FOjJTSmIMZkxBWuYIvJmcfMSJUjdumJqvA37Yo14hTtn
         6h2WD4W6UMyEEPm+zuG9MLYQT6mOisykuMJCCKLidTQEHdhrAqIud0ihZJZJqU22dK6V
         S2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736361477; x=1736966277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MS/hvL0txM5VNNlebJVUExcD4Ns/vp/IhXrC8aJXFEM=;
        b=YCbHqEby9HK+hVJj9npW6JvmSPG1hNqLpbI6nstWL3c/B1rrWWTy6erGvbsMn84ii5
         wrbxrIR/NtbemIP2K1ufDLrKPiAJYN2KPexla4FnD1ut0HPfEt97O6Tfp2JjonC0dd43
         doPpIMf53NNKyDIgUXp/G0/3CHTbl5RXm1iMj4LqZwcQOVxr6yoKyEtfeyVXHcfzJ1BJ
         jVpX2T5N6RmmbrtOrQneHKfHRDOq/Yft5d4EkZ+LXdYWYyTG19qZM0jqs+f0ZCEb0fen
         YQqF75xZLpAnKVHKF1pmnNFx31fHQW2ez2qNx+lRLszsfN2G/m9jyLqJsCJsV9s7pi1B
         N5sQ==
X-Gm-Message-State: AOJu0Yy2iZOE2NY5vHecE/xD35j/JMDvrJ4/UXGp+lw6Xw0zgPtBdTID
	X0fRguVEpPwgOfujDILfE9Pf+1Tb0RqLvJE5OYJ6aud9xiAF0bl81+6IXFw20U0=
X-Gm-Gg: ASbGncs/GjteycVqjAta1T6E0gqZ4xrPQsY+JsoP1h3wVb33xV0tYGYeTTeOj5fAbn5
	8BMJGSIZbf+Qt3QK+RGjYmr6dBiSJLSg4NRUOkIYKKa9EXkZkTmc5dPqIqKgZ0EWJs+OziLhF30
	unSuPSYvYEG+vt1TeVZVktjmobmxYmGIYoRnKCNyP3tonwKQcaY5vtFgoemM9X7WY1V/vow4oSu
	mT8efdASbP8TiKW1iaN5Nd2wkGV/kceXeDyGcQWL2EC+p8vN2nn2YnDfy+9GwA4jDzGDuck1NLY
	8F9D5HCcMQ==
X-Google-Smtp-Source: AGHT+IFmU0NCEYICKj6/Tsej42fww6uCr3z0aSTzPCqbBPTcpi1FA6uzOVaP+iZeV5kZ1WhXgAG/lA==
X-Received: by 2002:a05:6214:4890:b0:6d8:9d56:2d10 with SMTP id 6a1803df08f44-6df9b1c4f47mr70300226d6.7.1736361477442;
        Wed, 08 Jan 2025 10:37:57 -0800 (PST)
Received: from localhost.localdomain ([184.148.194.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea74bsm193228036d6.25.2025.01.08.10.37.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jan 2025 10:37:57 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v9 0/8] cat-file: add remote-object-info to batch-command
Date: Wed,  8 Jan 2025 13:37:31 -0500
Message-ID: <20250108183740.67022-1-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
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

Because I mistakenly sent a wrong range-diff in v8, please consider this v9 as
both an update addressing new comments from Calvin Wan at
https://lore.kernel.org/git/CAFySSZAqh6J14+r9JLM3LmRmV02ZvPRf5dB3rWVnUZS_5XaHcQ@mail.gmail.com/
and a resend of the corrected range-diff for v8.

This patch series is a continuation of Calvin Wan’s (calvinwan@google.com)
patch series [PATCH v5 0/6] cat-file: add --batch-command remote-object-info
command at [1].

Sometimes it is beneficial to retrieve information about an object without
having to download it completely. The server logic for retrieving size has
already been implemented and merged in "a2ba162cda (object-info: support for
retrieving object info, 2021-04-20)"[2]. This patch series implement the client
option for it.

This patch series add the `remote-object-info` command to
`cat-file --batch-command`. This command allows the client to make an
object-info command request to a server that supports protocol v2.

If the server uses protocol v2 but does not support the object-info capability,
`cat-file --batch-command` will die.

If a user attempts to use `remote-object-info` with protocol v1,,
`cat-file --batch-command` will die.

Currently, only the size (%(objectsize)) is supported in this implementation.
The type (%(objecttype)) is not included in this patch series, as it is not yet
supported on the server side either. The plan is to implement the necessary
logic for both the server and client in a subsequent series.

The default format for remote-object-info is set to %(objectname) %(objectsize).
Once %(objecttype) is supported, the default format will be unified accordingly.

If the batch command format includes unsupported fields such as %(objecttype),
%(objectsize:disk), or %(deltabase), the command will terminate with an error.

Changes since V7 (v8 had an incorrect range-diff)
================
- Introduced strtoul_ul() in git-compat-util.h to ensure proper error handling
  using strtoul from the standard library.
- Separated the test library into its own commit for better clarity
  and organization.
- Use string_list_has_string() instead of unsorted_string_list_has_string() to
  avoid quadratic runtime behaviour
- Added a documentation link to the wire format in the commit message to
  provide additional context.
- New test case "remote-object-info fails on not providing OID"
- Fixed typos and formatting issues for improved readability.
- Flattened the memory allocation logic of sizep in object_info_data for better
  intuitiveness and readability.

Calvin Wan (4):
  fetch-pack: refactor packet writing
  fetch-pack: move fetch initialization
  serve: advertise object-info feature
  transport: add client support for object-info

Eric Ju (4):
  git-compat-util: add strtoul_ul() with error handling
  cat-file: add declaration of variable i inside its for loop
  cat-file: split test utility functions into a separate library file
  cat-file: add remote-object-info to batch-command

 Documentation/git-cat-file.txt         |  24 +-
 Makefile                               |   1 +
 builtin/cat-file.c                     | 110 +++-
 connect.c                              |  34 ++
 connect.h                              |   8 +
 fetch-object-info.c                    |  85 ++++
 fetch-object-info.h                    |  22 +
 fetch-pack.c                           |  51 +-
 fetch-pack.h                           |   2 +
 git-compat-util.h                      |  18 +
 object-file.c                          |  11 +
 object-store-ll.h                      |   3 +
 serve.c                                |   4 +-
 t/lib-cat-file.sh                      |  16 +
 t/t1006-cat-file.sh                    |  13 +-
 t/t1017-cat-file-remote-object-info.sh | 664 +++++++++++++++++++++++++
 transport-helper.c                     |  11 +-
 transport.c                            |  28 +-
 transport.h                            |  11 +
 19 files changed, 1048 insertions(+), 68 deletions(-)
 create mode 100644 fetch-object-info.c
 create mode 100644 fetch-object-info.h
 create mode 100644 t/lib-cat-file.sh
 create mode 100755 t/t1017-cat-file-remote-object-info.sh

Range-diff against v7:
-:  ---------- > 1:  63997081d1 git-compat-util: add strtoul_ul() with error handling
1:  5181e849eb ! 2:  f188962f05 cat-file: add declaration of variable i inside its for loop
    @@ fetch-pack.c: static void write_fetch_command_and_capabilities(struct strbuf *re
     -		int i;
      		ensure_server_supports_v2("server-option");
     -		for (i = 0; i < server_options->nr; i++)
    -+		for (int i = 0; i < server_options->nr; i++)
    ++		for (size_t i = 0; i < server_options->nr; i++)
      			packet_buf_write(req_buf, "server-option=%s",
      					 server_options->items[i].string);
      	}
-:  ---------- > 3:  71250a03d2 cat-file: split test utility functions into a separate library file
2:  0c6acf58c2 ! 4:  0ab26e6cd5 fetch-pack: refactor packet writing
    @@ connect.c: int server_supports(const char *feature)
     +		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
     +	if (server_options && server_options->nr) {
     +		ensure_server_supports_v2("server-option");
    -+		for (int i = 0; i < server_options->nr; i++)
    ++		for (size_t i = 0; i < server_options->nr; i++)
     +			packet_buf_write(req_buf, "server-option=%s",
     +					 server_options->items[i].string);
     +	}
    @@ connect.c: int server_supports(const char *feature)
      	PROTO_FILE,
     
      ## connect.h ##
    -@@
    - #ifndef CONNECT_H
    - #define CONNECT_H
    - 
    -+#include "string-list.h"
    - #include "protocol.h"
    - 
    - #define CONNECT_VERBOSE       (1u << 0)
     @@ connect.h: void check_stateless_delimiter(int stateless_rpc,
      			       struct packet_reader *reader,
      			       const char *error);
      
    -+/**
    -+ * write_command_and_capabilities writes a command along with the requested
    ++/*
    ++ * Writes a command along with the requested
     + * server capabilities/features into a request buffer.
     + */
    ++struct string_list;
     +void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
     +				    const struct string_list *server_options);
     +
    @@ fetch-pack.c: static int add_haves(struct fetch_negotiator *negotiator,
     -		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
     -	if (server_options && server_options->nr) {
     -		ensure_server_supports_v2("server-option");
    --		for (int i = 0; i < server_options->nr; i++)
    +-		for (size_t i = 0; i < server_options->nr; i++)
     -			packet_buf_write(req_buf, "server-option=%s",
     -					 server_options->items[i].string);
     -	}
3:  28ef74980c = 5:  8b381b4bdc fetch-pack: move fetch initialization
4:  cb5bf65b88 = 6:  a0a15e1e4f serve: advertise object-info feature
5:  79eab87dd2 ! 7:  e1aad1ec30 transport: add client support for object-info
    @@ Commit message
         Sometimes, it is beneficial to retrieve information about an object
         without downloading it entirely. The server-side logic for this
         functionality was implemented in commit "a2ba162cda (object-info:
    -    support for retrieving object info, 2021-04-20)."
    +    support for retrieving object info, 2021-04-20)." And the wire
    +    format is documented at
    +    https://git-scm.com/docs/protocol-v2#_object_info.
     
         This commit introduces client functions to interact with the server.
     
         Currently, the client supports requesting a list of object IDs with
    -    the ‘size’ feature from a v2 server. If the server does not advertise
    +    the 'size' feature from a v2 server. If the server does not advertise
         this feature (i.e., transfer.advertiseobjectinfo is set to false),
         the client will return an error and exit.
     
    +    Notice that the entire request is written into req_buf before being
    +    sent to the remote. This approach follows the pattern used in the
    +    `send_fetch_request()` logic within fetch-pack.c.
    +    Streaming the request is not addressed in this patch.
    +
         Helped-by: Jonathan Tan <jonathantanmy@google.com>
         Helped-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Calvin Wan <calvinwan@google.com>
    @@ fetch-object-info.c (new)
     +#include "fetch-object-info.h"
     +#include "string-list.h"
     +
    -+/**
    -+ * send_object_info_request sends git-cat-file object-info command and its
    -+ * arguments into the request buffer.
    -+ */
    ++/* Sends git-cat-file object-info command and its arguments into the request buffer. */
     +static void send_object_info_request(const int fd_out, struct object_info_args *args)
     +{
     +	struct strbuf req_buf = STRBUF_INIT;
    @@ fetch-object-info.c (new)
     +	if (unsorted_string_list_has_string(args->object_info_options, "size"))
     +		packet_buf_write(&req_buf, "size");
     +
    -+	if (args->oids) {
    ++	if (args->oids)
     +		for (size_t i = 0; i < args->oids->nr; i++)
     +			packet_buf_write(&req_buf, "oid %s", oid_to_hex(&args->oids->oid[i]));
    -+	}
     +
     +	packet_buf_flush(&req_buf);
     +	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
    @@ fetch-object-info.c (new)
     +	strbuf_release(&req_buf);
     +}
     +
    -+/**
    -+ * fetch_object_info sends git-cat-file object-info command into the request buf
    -+ * and read the results from packets.
    -+ */
     +int fetch_object_info(const enum protocol_version version, struct object_info_args *args,
     +		      struct packet_reader *reader, struct object_info *object_info_data,
     +		      const int stateless_rpc, const int fd_out)
    @@ fetch-object-info.c (new)
     +		break;
     +	case protocol_v1:
     +	case protocol_v0:
    -+		die(_("wrong protocol version. expected v2"));
    ++		die(_("unsupported protocol version. expected v2"));
     +	case protocol_unknown_version:
     +		BUG("unknown protocol version");
     +	}
    @@ fetch-object-info.c (new)
     +			check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
     +			return -1;
     +		}
    -+		if (unsorted_string_list_has_string(args->object_info_options, reader->line)) {
    -+			if (!strcmp(reader->line, "size")) {
    -+				size_index = i;
    -+				for (size_t j = 0; j < args->oids->nr; j++)
    -+					object_info_data[j].sizep = xcalloc(1, sizeof(long));
    -+			}
    -+			continue;
    ++		if (!string_list_has_string(args->object_info_options, reader->line))
    ++			return -1;
    ++		if (!strcmp(reader->line, "size")) {
    ++			size_index = i;
    ++			for (size_t j = 0; j < args->oids->nr; j++)
    ++				object_info_data[j].sizep = xcalloc(1, sizeof(*object_info_data[j].sizep));
     +		}
    -+		return -1;
     +	}
     +
     +	for (size_t i = 0; packet_reader_read(reader) == PACKET_READ_NORMAL && i < args->oids->nr; i++){
    @@ fetch-object-info.c (new)
     +				die("object-info: not our ref %s",
     +					object_info_values.items[0].string);
     +
    -+			*object_info_data[i].sizep = strtoul(object_info_values.items[1 + size_index].string, NULL, 10);
    ++			if (strtoul_ul(object_info_values.items[1 + size_index].string, 10, object_info_data[i].sizep))
    ++				die("object-info: ref %s has invalid size %s",
    ++					object_info_values.items[0].string,
    ++					object_info_values.items[1 + size_index].string);
     +		}
     +
     +		string_list_clear(&object_info_values, 0);
    @@ fetch-object-info.h (new)
     +	struct oid_array *oids;
     +};
     +
    ++/*
    ++ * Sends git-cat-file object-info command into the request buf and read the
    ++ * results from packets.
    ++ */
     +int fetch_object_info(enum protocol_version version, struct object_info_args *args,
     +		      struct packet_reader *reader, struct object_info *object_info_data,
     +		      int stateless_rpc, int fd_out);
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
      	args.reject_shallow_remote = transport->smart_options->reject_shallow;
     +	args.object_info = transport->smart_options->object_info;
     +
    -+	if (transport->smart_options
    -+		&& transport->smart_options->object_info
    -+		&& transport->smart_options->object_info_oids->nr > 0) {
    ++	if (transport->smart_options && transport->smart_options->object_info
    ++	    && transport->smart_options->object_info_oids->nr > 0) {
     +		struct packet_reader reader;
     +		struct object_info_args obj_info_args = { 0 };
     +
     +		obj_info_args.server_options = transport->server_options;
    -+		obj_info_args.object_info_options = transport->smart_options->object_info_options;
     +		obj_info_args.oids = transport->smart_options->object_info_oids;
    ++		obj_info_args.object_info_options = transport->smart_options->object_info_options;
    ++		string_list_sort(obj_info_args.object_info_options);
     +
     +		connect_setup(transport, 0);
     +		packet_reader_init(&reader, data->fd[0], NULL, 0,
6:  b60863aa5b ! 8:  0795ad53fe cat-file: add remote-object-info to batch-command
    @@ builtin/cat-file.c: static void batch_one_object(const char *obj_name,
     +			die(_("Not a valid object name %s"), argv[i]);
     +		oid_array_append(&object_info_oids, &oid);
     +	}
    -+
    ++	if (object_info_oids.nr == 0) {
    ++		die(_("remote-object-info requires objects"));
    ++	}
     +	gtransport = transport_get(remote, NULL);
     +	if (gtransport->smart_options) {
     +		CALLOC_ARRAY(remote_object_info, object_info_oids.nr);
    @@ builtin/cat-file.c: static void parse_cmd_info(struct batch_options *opt,
     +	opt->use_remote_info = 1;
     +	data->skip_object_info = 1;
     +	for (size_t i = 0; i < object_info_oids.nr; i++) {
    -+
     +		data->oid = object_info_oids.oid[i];
    -+
     +		if (remote_object_info[i].sizep) {
     +			/*
     +			 * When reaching here, it means remote-object-info can retrieve
    @@ object-store-ll.h: int for_each_object_in_pack(struct packed_git *p,
     +
      #endif /* OBJECT_STORE_LL_H */
     
    - ## t/lib-cat-file.sh (new) ##
    -@@
    -+# Library of git-cat-file related tests.
    -+
    -+# Print a string without a trailing newline
    -+echo_without_newline () {
    -+	printf '%s' "$*"
    -+}
    -+
    -+# Print a string without newlines and replaces them with a NULL character (\0).
    -+echo_without_newline_nul () {
    -+	echo_without_newline "$@" | tr '\n' '\0'
    -+}
    -+
    -+# Calculate the length of a string removing any leading spaces.
    -+strlen () {
    -+	echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
    -+}
    -
    - ## t/t1006-cat-file.sh ##
    -@@
    - test_description='git cat-file'
    - 
    - . ./test-lib.sh
    -+. "$TEST_DIRECTORY"/lib-cat-file.sh
    - 
    - test_cmdmode_usage () {
    - 	test_expect_code 129 "$@" 2>err &&
    -@@ t/t1006-cat-file.sh: do
    - 	'
    - done
    - 
    --echo_without_newline () {
    --    printf '%s' "$*"
    --}
    --
    --echo_without_newline_nul () {
    --	echo_without_newline "$@" | tr '\n' '\0'
    --}
    --
    --strlen () {
    --    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
    --}
    --
    - run_tests () {
    -     type=$1
    -     oid=$2
    -
      ## t/t1017-cat-file-remote-object-info.sh (new) ##
     @@
     +#!/bin/sh
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +	)
     +'
     +
    -+test_expect_success 'remote-object-info fails on server with legacy protocol' '
    ++test_expect_success 'remote-object-info fails on server with legacy protocol with default filter' '
     +	(
     +		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
     +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'remote-object-info fails on not providing OID' '
    ++	(
    ++		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
    ++		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
    ++
    ++		test_must_fail git cat-file --batch-command="%(objectname) %(objectsize)" 2>err <<-EOF &&
    ++		remote-object-info "$HTTPD_URL/smart/http_parent"
    ++		EOF
    ++		test_grep "remote-object-info requires objects" err
    ++	)
    ++'
    ++
     +
     +# Test --batch-command remote-object-info with 'http://' transport and
     +# transfer.advertiseobjectinfo set to false, i.e. server does not have object-info capability
-- 
2.47.0

