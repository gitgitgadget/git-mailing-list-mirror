Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B8C18B09
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083101; cv=none; b=ivz07/f3ECg392IXjq9B9a6Udq7l4XdmrnJx3zhxokvSC418Qj6rRV3brVQDpqI4HOp+Az7N9zRdGvXGgReTFYE943RCwAhDFKAA1Wy2XOEt8jYqBRE0pA8UzeVg1S9dcEYihJYqc7giXqlxXCqK2OxIrHNYdtCZtjpjV8llt40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083101; c=relaxed/simple;
	bh=i+S3WXCRhOCDaRYEJWqDYQ2TmzsJ1e2YXB3PaAZNwF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZ19yhB/gwSm7Izk4iXpSLTyoUvJw7twrP8c0EpfczIi4I1eWipl9jGEtmWJ0rgGAYpeQL2OFZ5uiliAJwmaQAMMAktH0oyBOToWb2AVg31MnUaJgd0RaaTJqzNWbYM/NNlrS2e7aUgxFa1z6pC2RYNFIMXg3/n48gCDc2dY7EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0Ts3wYE; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0Ts3wYE"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460c2418e37so15530641cf.0
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 08:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731083098; x=1731687898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mInphgMmoCb67UDTz9Z8D03AQtsoQSsmZGF/7jTct18=;
        b=Y0Ts3wYEg+AQ3nK7x4m3qL1cesoBGrLRlJO4fdA1pyaQpn6iGP+FiW1074fPe0yZsc
         EtKE4wgh2kLPj8IgyZWtXOsA3J5JpwY+irDgb3Al7oFaleiCdAYJ/yyuImCOllKTnaNs
         kOhAzbdY3Qse3YmOLcGMC+m2sWw3UzJnQ+Tc+yD4MqK1BaKRN9nZMpzveFJyxUnJSgNg
         wU9jIzy38rlWWIJ2PPh5JGxx4p6zR01J9LqzpjcJRcUCwpp1ecsdYyTs5y+8IqnstWHc
         uy0XfqWPC8sPzJBiPsVdEHJDesZZx8zzvHIqXx2L4MxJDgmjQkIqWmGesBIZ3jWjaq3v
         7HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731083098; x=1731687898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mInphgMmoCb67UDTz9Z8D03AQtsoQSsmZGF/7jTct18=;
        b=Zb7J24+9cDjFc0EBPgDeM/XO8zqkG1GOXLo0mw0XUCgPKKrYIcRzQsBrsdi0stsDYK
         easGK8D12es9lgxV+c01SAc3NEqYDhrV/xYAF62KN5TMyw0RWx+l1UeV9+BXj3s1Gq7J
         f2jbBd9j/2UMF58JfgHEjxOEnh0HvR6qsk3Qk1zsTW1YCdlx8HyiC0W1jNUuuf5kWbbb
         mpaXs3hXd3Mo86q8NyJXyY+oliAWKPYcRefDDy8fPihCv7YjYxSJA2XmcIi+srNgY9k1
         HEUgFukMg44JRR/cl3sYf/u65OMsHgDzhz+FOsuonM6kAhvX9sgogXXRwwS+Bg2xYGoY
         3TNw==
X-Gm-Message-State: AOJu0YxCZcDSxRMawURaDfzMyRgkz0uOukHs+LCJvvYLh4Q4zcyXAalY
	/T0IEhL/VSqYPo2gbLloZsFzGaMy8pK3qVQ/EKTSynVkpWFhFknwPY76+DR5
X-Google-Smtp-Source: AGHT+IGRAc7tSh1BhM5mvTQw5sYLp6XYJA/sbUECTjTciu2lWShpwOoXrWgM24K5KOLY52+kI1n1LA==
X-Received: by 2002:a05:622a:2986:b0:461:169e:d2de with SMTP id d75a77b69052e-4630942c976mr44828751cf.48.1731083098185;
        Fri, 08 Nov 2024 08:24:58 -0800 (PST)
Received: from localhost.localdomain ([174.95.142.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3ef11esm21928711cf.15.2024.11.08.08.24.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 08 Nov 2024 08:24:57 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v6 0/6] cat-file: add remote-object-info to batch-command
Date: Fri,  8 Nov 2024 11:24:35 -0500
Message-ID: <20241108162441.50736-1-eric.peijian@gmail.com>
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

Changes since V5
================
- Move small changes commit to the very first commit
- Add more detailed description on what changes when moving write_fetch_command_and_capabilities() to connect.c
- Fix indentation problems

Thank you.

Eric Ju

Calvin Wan (4):
  fetch-pack: refactor packet writing
  fetch-pack: move fetch initialization
  serve: advertise object-info feature
  transport: add client support for object-info

Eric Ju (2):
  cat-file: add declaration of variable i inside its for loop
  cat-file: add remote-object-info to batch-command

 Documentation/git-cat-file.txt         |  24 +-
 Makefile                               |   1 +
 builtin/cat-file.c                     | 116 +++-
 connect.c                              |  34 ++
 connect.h                              |   4 +
 fetch-object-info.c                    |  95 ++++
 fetch-object-info.h                    |  18 +
 fetch-pack.c                           |  51 +-
 fetch-pack.h                           |   2 +
 object-file.c                          |  11 +
 object-store-ll.h                      |   3 +
 serve.c                                |   4 +-
 t/lib-cat-file.sh                      |  16 +
 t/t1006-cat-file.sh                    |  13 +-
 t/t1017-cat-file-remote-object-info.sh | 739 +++++++++++++++++++++++++
 transport-helper.c                     |  11 +-
 transport.c                            |  77 ++-
 transport.h                            |  11 +
 18 files changed, 1162 insertions(+), 68 deletions(-)
 create mode 100644 fetch-object-info.c
 create mode 100644 fetch-object-info.h
 create mode 100644 t/lib-cat-file.sh
 create mode 100755 t/t1017-cat-file-remote-object-info.sh

Range-diff against v5:
5:  0e533d6d0a ! 1:  858a864651 cat-file: add declaration of variable i inside its for loop
    @@ Metadata
      ## Commit message ##
         cat-file: add declaration of variable i inside its for loop
     
    -    Some code declares variable i and only uses it
    +    Some code used in this series declares variable i and only uses it
         in a for loop, not in any other logic outside the loop.
     
         Change the declaration of i to be inside the for loop for readability.
    @@ builtin/cat-file.c: static void batch_objects_command(struct batch_options *opt,
      			if (!skip_prefix(input.buf, commands[i].name, &cmd_end))
      				continue;
      
    +
    + ## fetch-pack.c ##
    +@@ fetch-pack.c: static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
    + 	if (advertise_sid && server_supports_v2("session-id"))
    + 		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
    + 	if (server_options && server_options->nr) {
    +-		int i;
    + 		ensure_server_supports_v2("server-option");
    +-		for (i = 0; i < server_options->nr; i++)
    ++		for (int i = 0; i < server_options->nr; i++)
    + 			packet_buf_write(req_buf, "server-option=%s",
    + 					 server_options->items[i].string);
    + 	}
1:  d5c93792d3 ! 2:  51707f08d1 fetch-pack: refactor packet writing
    @@ Metadata
      ## Commit message ##
         fetch-pack: refactor packet writing
     
    -    Refactor write_fetch_command_and_capabilities() to be a more general
    -    purpose function write_command_and_capabilities(), so that it can be
    -    used by both fetch and future commands.
    +    Refactor write_fetch_command_and_capabilities() to a more
    +    general-purpose function, write_command_and_capabilities(), enabling it
    +    to serve both fetch and additional commands.
     
    -    Here "command" means the "operations" supported by Git’s wire protocol
    -    https://git-scm.com/docs/protocol-v2. An example would be a
    -    git's subcommand, such as git-fetch(1); or an operation supported by
    -    the server side such as "object-info" implemented in "a2ba162cda
    -    (object-info: support for retrieving object info, 2021-04-20)".
    +    In this context, "command" refers to the "operations" supported by
    +    Git's wire protocol https://git-scm.com/docs/protocol-v2, such as a Git
    +    subcommand (e.g., git-fetch(1)) or a server-side operation like
    +    "object-info" as implemented in commit a2ba162c
    +    (object-info: support for retrieving object info, 2021-04-20).
     
    -    The new write_command_and_capabilities() function is also moved to
    -    connect.c, so that it becomes accessible to other commands.
    +    Furthermore, write_command_and_capabilities() is moved to connect.c,
    +    making it accessible to additional commands in the future.
    +
    +    To move write_command_and_capabilities() to connect.c, we need to
    +    adjust how `advertise_sid` is managed. Previously,
    +    in fetch_pack.c, `advertise_sid` was a static variable, modified using
    +    git_config_get_bool().
    +
    +    In connect.c, we now initialize `advertise_sid` at the beginning by
    +    directly using git_config_get_bool(). This change is safe because:
    +
    +    In the original fetch-pack.c code, there are only two places that
    +    write `advertise_sid` :
    +    1. In function do_fetch_pack:
    +            if (!server_supports("session-id"))
    +                    advertise_sid = 0;
    +    2. In function fetch_pack_config():
    +            git_config_get_bool("transfer.advertisesid", &advertise_sid);
    +
    +    About 1, since do_fetch_pack() is only relevant for protocol v1, this
    +    assignment can be ignored in our refactor, as
    +    write_command_and_capabilities() is only used in protocol v2.
    +
    +    About 2, git_config_get_bool() is from config.h and it is an out-of-box
    +    dependency of connect.c, so we can reuse it directly.
     
         Helped-by: Jonathan Tan <jonathantanmy@google.com>
         Helped-by: Christian Couder <chriscool@tuxfamily.org>
    @@ connect.c: int server_supports(const char *feature)
      }
      
     +void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
    -+									const struct string_list *server_options)
    ++				    const struct string_list *server_options)
     +{
     +	const char *hash_name;
     +	int advertise_sid;
    @@ connect.h: void check_stateless_delimiter(int stateless_rpc,
      			       const char *error);
      
     +void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
    -+									const struct string_list *server_options);
    ++				    const struct string_list *server_options);
     +
      #endif
     
    @@ fetch-pack.c: static int add_haves(struct fetch_negotiator *negotiator,
     -	if (advertise_sid && server_supports_v2("session-id"))
     -		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
     -	if (server_options && server_options->nr) {
    --		int i;
     -		ensure_server_supports_v2("server-option");
    --		for (i = 0; i < server_options->nr; i++)
    +-		for (int i = 0; i < server_options->nr; i++)
     -			packet_buf_write(req_buf, "server-option=%s",
     -					 server_options->items[i].string);
     -	}
2:  4bf51150c0 = 3:  f02338e90e fetch-pack: move fetch initialization
3:  15b4095e28 = 4:  934bafb1db serve: advertise object-info feature
4:  68794ae57a ! 5:  e2e94d1a32 transport: add client support for object-info
    @@ fetch-object-info.c (new)
     + * and read the results from packets.
     + */
     +int fetch_object_info(const enum protocol_version version, struct object_info_args *args,
    -+					  struct packet_reader *reader, struct object_info *object_info_data,
    -+					  const int stateless_rpc, const int fd_out)
    ++		      struct packet_reader *reader, struct object_info *object_info_data,
    ++		      const int stateless_rpc, const int fd_out)
     +{
     +	int size_index = -1;
     +
    @@ fetch-object-info.h (new)
     +};
     +
     +int fetch_object_info(enum protocol_version version, struct object_info_args *args,
    -+					  struct packet_reader *reader, struct object_info *object_info_data,
    -+					  int stateless_rpc, int fd_out);
    ++		      struct packet_reader *reader, struct object_info *object_info_data,
    ++		      int stateless_rpc, int fd_out);
     +
     +#endif /* FETCH_OBJECT_INFO_H */
     
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
     +		}
      
     -	if (!data->finished_handshake) {
    --		int i;
     +		/*
     +		 * If the code reaches here, it means we can't retrieve object info from
     +		 * packets, and we will fallback to downland the pack files.
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
     +		transport->remote_refs = object_info_refs;
     +
     +	} else if (!data->finished_handshake) {
    + 		int i;
      		int must_list_refs = 0;
    --		for (i = 0; i < nr_heads; i++) {
    -+		for (int i = 0; i < nr_heads; i++) {
    - 			if (!to_fetch[i]->exact_oid) {
    - 				must_list_refs = 1;
    - 				break;
    + 		for (i = 0; i < nr_heads; i++) {
     @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
      			  &transport->pack_lockfiles, data->version);
      
6:  98f8248203 ! 6:  69eb091a6b cat-file: add remote-object-info to batch-command
    @@ Documentation/git-cat-file.txt: info <object>::
      	output of `--batch-check`.
      
     +remote-object-info <remote> <object>...::
    -+	Print object info for object references `<object>` at specified <remote> without
    -+	downloading objects from remote. If the object-info capability is not
    -+	supported by the server, the objects will be downloaded instead.
    ++	Print object info for object references `<object>` at specified <remote>
    ++	without downloading objects from remote. If the object-info capability
    ++	is not supported by the server, the objects will be downloaded instead.
     +	Error when no object references are provided.
     +	This command may be combined with `--buffer`.
     +
    @@ builtin/cat-file.c: struct batch_options {
      
      static struct string_list mailmap = STRING_LIST_INIT_NODUP;
      static int use_mailmap;
    -@@ builtin/cat-file.c: static void batch_one_object(const char *obj_name,
    - 	enum get_oid_result result;
    - 
    - 	result = get_oid_with_context(the_repository, obj_name,
    --				      flags, &data->oid, &ctx);
    -+								  flags, &data->oid, &ctx);
    - 	if (result != FOUND) {
    - 		switch (result) {
    - 		case MISSING_OBJECT:
     @@ builtin/cat-file.c: static void batch_one_object(const char *obj_name,
      	object_context_release(&ctx);
      }
    @@ builtin/cat-file.c: static void parse_cmd_info(struct batch_options *opt,
      }
      
     +static void parse_cmd_remote_object_info(struct batch_options *opt,
    -+			   const char *line,
    -+			   struct strbuf *output,
    -+			   struct expand_data *data)
    ++					 const char *line, struct strbuf *output,
    ++					 struct expand_data *data)
     +{
     +	int count;
     +	const char **argv;
-- 
2.47.0

base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
Merge Request: https://gitlab.com/gitlab-org/git/-/merge_requests/168
