Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410813CFA6
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732513000; cv=none; b=q4bu5ywBhtAtv907Cl/2J0278kMg6+fXzjdtBp6YpNwDV54zruHUlENZgbBn9VilKeXea6Je71qsvYoklzQrGRMsKoZ4sP5MtcgritDCeshXqiM1EPZJuY6/ZbGuYcPqYKweYTizb3lDFCOrqe2IsyUR1uG8IUbJv9DjGLcpuEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732513000; c=relaxed/simple;
	bh=ktGy5Uj/b8z7JUZs3I7pa8bJXPVoIMHkMR/vkAD8rDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiXFs+zxgFZPxU4tG03bbMotS/T1uMKLWA+sSHFFP1y6SAGnelvkpCsQ8EJnbbuRFxZE5qNrO5mSFGl60gCjVrD6wc86D0vGK39Wz9kiRBvetgyFrc+LNNJpRIvccqFK0BrYj30K3XgDvTOqyfYk8m6i5PlQglnnvgABwVFE8Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mU9mT/Iy; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU9mT/Iy"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6648e25e3so75542185a.2
        for <git@vger.kernel.org>; Sun, 24 Nov 2024 21:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732512997; x=1733117797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs7JyOq2Qdhb/zq/Lhlb4tp4ou3ko5Sr2vcgO6jBpl4=;
        b=mU9mT/IyXrGAo/EVZc9955qx4K29k+xNEaT0fbVud/KUL7mrBcAKnB/QYsZSqdE+bR
         uXLKBJER5TIHDCA8/XwKT7gZFNxHAXVExJ0ezSxSC+EbNyo6A05gq1TlRCYrUorKicad
         iffffQcrdI0IK3WnKAYA5aPACvvI4Uso5AQUXBX4IFf73zmacIeROGQyHmulV+iOgFOR
         NgdvY31cQkl+qqckJaNQ6GR9nWCadVVVOhr92dXNA9hbLFXF4PsrK8JwhxLlwRy++sku
         25IYgB+DpsjLceDTZPSCH9h8wnelNubgB43rJS8NGvYyGTjBa8Ar6nyN2cKULqEAlUyG
         +3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732512997; x=1733117797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xs7JyOq2Qdhb/zq/Lhlb4tp4ou3ko5Sr2vcgO6jBpl4=;
        b=hgvG22w9A/StxZsyJVIGmvIfudHJmItJXkZUJVq44p0VnxxjdM7Oiq0WTlx8JgeHig
         IqdfJAUnU+q/f1tKzs8AjVawOmL6VeWFogITkq1ZurmYF9tkq/6shzdm4yGhi5Gbl++8
         pZrP+MT17A1obpDYjM4cniBMXs9jGcJuHImisz85xCt/+sR7O+Lrb1bRXMxmhgKGfKDo
         BfUdP1WseI7UeHVJCen2OKpgHAz5ncJTwHAcPpN6tK/mHSAYZNFCXzT7evaHzNRz4Tej
         30orGxrMWI8uBuzWNrOdxy572J769fpHPbGSUMUPs4ff2VuAqROSx02PnuE674wFeCKh
         ECTQ==
X-Gm-Message-State: AOJu0YzITH/uhJMEt4cCp/mzA8eCO27Vr5sdme+jN05ZUVTJyf6BnIXs
	X5Xk/IRbTDjSgEeLyiSWW3fi83JQjSnRQuRFRVMwXu1G9HayE7Dg/xfLh8R8
X-Gm-Gg: ASbGncvjUgjAGJtcjNPgzou4rezEbJJnFMo3FDvBXUsFiqs56dm5KAo/03X+E6PgADx
	O/mmBodF8yXTFvP/A7xxcV6X5suPXByYV8bzB8K6zSyqEPTaCvJSa8sgst/HtzbdQ5BxL8j+ZZQ
	tUbLwrTeCG+19uEnuuBWgM03hugTJEuzE3qzUffM0BgS1i1DleGfW4YHQOrqdf2Z1qF3HjdUYiG
	BJEOWprEePg5ld6SsVMXpVG9voOESsU83q4Mj04NY845ZzD2sOKl9U0HSulnmuxtbRBExyUqUD5
	Fg==
X-Google-Smtp-Source: AGHT+IGBVNkT2ynZP+GQH5hgQl6TrL8APb6OqOTc32Q8n2y27OAiLQhjIDay0I3BfInG6aE+viWSlw==
X-Received: by 2002:a05:620a:2552:b0:7b1:3c0e:b7ea with SMTP id af79cd13be357-7b51453eea6mr1578472785a.45.1732512996929;
        Sun, 24 Nov 2024 21:36:36 -0800 (PST)
Received: from localhost.localdomain ([184.146.186.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b513f90534sm320522585a.25.2024.11.24.21.36.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 Nov 2024 21:36:36 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v7 0/6] cat-file: add remote-object-info to batch-command
Date: Mon, 25 Nov 2024 00:36:10 -0500
Message-ID: <20241125053616.25170-1-eric.peijian@gmail.com>
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

Currently, only the size is supported in this implementation. If the batch
command format contains objecttype objectsize:disk or deltabase, it will die.

The default format is set to %(objectname) %(objectsize) when remote-object-info
is used. When "%(objecttype)" is supported, the default format will be unified.

[1] https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.com/#t
[2] https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2ba162cda2acc171c3e36acbbc854792b093cb7

Changes since V6
================
- Removal of “Fetch and Inspect” Fallback. In the previous patch series, if the
  object-info capability was not supported (i.e., transfer.advertiseobjectinfo
  was set to false), the remote-object-info command would fall back to fetching
  the object locally and inspecting it. This “fetch and inspect” behavior has
  been removed. Instead, the client will now error and exit if the object-info
  capability is not supported by the server. For more details, refer to the
  discussion at this thread
  https://lore.kernel.org/git/CAN2LT1Dm17-mmoMQr457fb5ta-TxG6Fj3Ma-gPh4YRJV9rRDrw@mail.gmail.com/.

- Test Updates. Adjusted tests to cover cases where the object-info capability
  is not supported by the server.

- Documentation Updates. Removed references to the “fetch and inspect” fallback
  mechanism.

- Typos and Formatting Fixes.

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
 builtin/cat-file.c                     | 110 ++++-
 connect.c                              |  34 ++
 connect.h                              |   8 +
 fetch-object-info.c                    |  92 ++++
 fetch-object-info.h                    |  18 +
 fetch-pack.c                           |  51 +-
 fetch-pack.h                           |   2 +
 object-file.c                          |  11 +
 object-store-ll.h                      |   3 +
 serve.c                                |   4 +-
 t/lib-cat-file.sh                      |  16 +
 t/t1006-cat-file.sh                    |  13 +-
 t/t1017-cat-file-remote-object-info.sh | 652 +++++++++++++++++++++++++
 transport-helper.c                     |  11 +-
 transport.c                            |  28 +-
 transport.h                            |  11 +
 18 files changed, 1021 insertions(+), 68 deletions(-)
 create mode 100644 fetch-object-info.c
 create mode 100644 fetch-object-info.h
 create mode 100644 t/lib-cat-file.sh
 create mode 100755 t/t1017-cat-file-remote-object-info.sh

Range-diff against v6:
1:  0998382d5e = 1:  92feca4218 cat-file: add declaration of variable i inside its for loop
2:  26b861f416 ! 2:  58a24a4b92 fetch-pack: refactor packet writing
    @@ connect.h: void check_stateless_delimiter(int stateless_rpc,
      			       struct packet_reader *reader,
      			       const char *error);
      
    ++/**
    ++ * write_command_and_capabilities writes a command along with the requested
    ++ * server capabilities/features into a request buffer.
    ++ */
     +void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
     +				    const struct string_list *server_options);
     +
3:  044d0ec46c = 3:  6bd0f945c2 fetch-pack: move fetch initialization
4:  09b4a2c081 = 4:  000c82b681 serve: advertise object-info feature
5:  4782211b31 ! 5:  97c03a9c2c transport: add client support for object-info
    @@ Metadata
      ## Commit message ##
         transport: add client support for object-info
     
    -    Sometimes it is useful to get information about an object without having
    -    to download it completely. The server logic has already been implemented
    -    in “a2ba162cda (object-info: support for retrieving object info,
    -    2021-04-20)”.
    +    Sometimes, it is beneficial to retrieve information about an object
    +    without downloading it entirely. The server-side logic for this
    +    functionality was implemented in commit "a2ba162cda (object-info:
    +    support for retrieving object info, 2021-04-20)."
     
    -    Add client functions to communicate with the server.
    +    This commit introduces client functions to interact with the server.
     
    -    The client currently supports requesting a list of object ids with
    -    feature 'size' from a v2 server. If a server does not
    -    advertise the feature, then the client falls back
    -    to making the request through 'fetch'.
    +    Currently, the client supports requesting a list of object IDs with
    +    the ‘size’ feature from a v2 server. If the server does not advertise
    +    this feature (i.e., transfer.advertiseobjectinfo is set to false),
    +    the client will return an error and exit.
     
         Helped-by: Jonathan Tan <jonathantanmy@google.com>
         Helped-by: Christian Couder <chriscool@tuxfamily.org>
    @@ fetch-object-info.c (new)
     +	switch (version) {
     +	case protocol_v2:
     +		if (!server_supports_v2("object-info"))
    -+			return -1;
    -+		if (unsorted_string_list_has_string(args->object_info_options, "size")
    -+				&& !server_supports_feature("object-info", "size", 0))
    -+			return -1;
    ++			die(_("object-info capability is not enabled on the server"));
     +		send_object_info_request(fd_out, args);
     +		break;
     +	case protocol_v1:
    @@ transport.c
      #include "remote.h"
      #include "connect.h"
      #include "send-pack.h"
    -@@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
    - 	struct ref *refs = NULL;
    - 	struct fetch_pack_args args;
    - 	struct ref *refs_tmp = NULL, **to_fetch_dup = NULL;
    -+	struct ref *object_info_refs = NULL;
    - 
    - 	memset(&args, 0, sizeof(args));
    - 	args.uploadpack = data->options.uploadpack;
     @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
      	args.server_options = transport->server_options;
      	args.negotiation_tips = data->options.negotiation_tips;
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
     +	if (transport->smart_options
     +		&& transport->smart_options->object_info
     +		&& transport->smart_options->object_info_oids->nr > 0) {
    -+		struct ref *ref_itr = object_info_refs = alloc_ref("");
     +		struct packet_reader reader;
     +		struct object_info_args obj_info_args = { 0 };
     +
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
     +		data->version = discover_version(&reader);
     +		transport->hash_algo = reader.hash_algo;
     +
    -+		if (!fetch_object_info(data->version, &obj_info_args, &reader,
    -+			data->options.object_info_data, transport->stateless_rpc,
    -+			data->fd[1])) {
    -+			/*
    -+			 * If the code reaches here, fetch_object_info is successful and
    -+			 * remote object info are retrieved from packets (i.e. without
    -+			 * downloading the objects).
    -+			 */
    -+			goto cleanup;
    -+		}
    ++		ret = fetch_object_info(data->version, &obj_info_args, &reader,
    ++					data->options.object_info_data, transport->stateless_rpc,
    ++					data->fd[1]);
    ++		goto cleanup;
      
     -	if (!data->finished_handshake) {
    -+		/*
    -+		 * If the code reaches here, it means we can't retrieve object info from
    -+		 * packets, and we will fallback to downland the pack files.
    -+		 * We set quiet and no_progress to be true, so that the internal call to
    -+		 * fetch-pack is less verbose.
    -+		 */
    -+		args.object_info_data = data->options.object_info_data;
    -+		args.quiet = 1;
    -+		args.no_progress = 1;
    -+
    -+		/*
    -+		 * Allocate memory for object info data according to oids.
    -+		 * The actual results will be retrieved later from the downloaded
    -+		 * pack files.
    -+		 */
    -+		for (size_t i = 0; i < transport->smart_options->object_info_oids->nr; i++) {
    -+			ref_itr->old_oid = transport->smart_options->object_info_oids->oid[i];
    -+			ref_itr->exact_oid = 1;
    -+			if (i == transport->smart_options->object_info_oids->nr - 1)
    -+				/* last element, no need to allocate to next */
    -+				ref_itr->next = NULL;
    -+			else
    -+				ref_itr->next = alloc_ref("");
    -+
    -+			ref_itr = ref_itr->next;
    -+		}
    -+
    -+		transport->remote_refs = object_info_refs;
    -+
     +	} else if (!data->finished_handshake) {
      		int i;
      		int must_list_refs = 0;
      		for (i = 0; i < nr_heads; i++) {
    -@@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
    - 			  &transport->pack_lockfiles, data->version);
    - 
    - 	data->finished_handshake = 0;
    -+
    -+	/* Retrieve object info data from the downloaded pack files */
    -+	if (args.object_info) {
    -+		struct ref *ref_cpy_reader = object_info_refs;
    -+		for (int i = 0; ref_cpy_reader; i++) {
    -+			oid_object_info_extended(the_repository, &ref_cpy_reader->old_oid,
    -+				&args.object_info_data[i], OBJECT_INFO_LOOKUP_REPLACE);
    -+			ref_cpy_reader = ref_cpy_reader->next;
    -+		}
    -+	}
    -+
    - 	data->options.self_contained_and_connected =
    - 		args.self_contained_and_connected;
    - 	data->options.connectivity_checked = args.connectivity_checked;
    -@@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
    - 		ret = -1;
    - 
    - cleanup:
    -+	free_refs(object_info_refs);
    - 	close(data->fd[0]);
    - 	if (data->fd[1] >= 0)
    - 		close(data->fd[1]);
     
      ## transport.h ##
     @@
    @@ transport.h: struct git_transport_options {
      	unsigned connectivity_checked:1;
      
     +	/*
    -+	 * Transport will attempt to pull only object-info. Fallbacks
    -+	 * to pulling entire object if object-info is not supported.
    ++	 * Transport will attempt to retrieve only object-info.
    ++	 * If object-info is not supported, the operation will error and exit.
     +	 */
     +	unsigned object_info : 1;
     +
6:  91689c0d0d ! 6:  7d1936591d cat-file: add remote-object-info to batch-command
    @@ Commit message
         Since the `info` command in cat-file --batch-command prints object info
         for a given object, it is natural to add another command in cat-file
         --batch-command to print object info for a given object from a remote.
    +
         Add `remote-object-info` to cat-file --batch-command.
     
    -    While `info` takes object ids one at a time, this creates overhead when
    -    making requests to a server so `remote-object-info` instead can take
    -    multiple object ids at once.
    +    While `info` takes object ids one at a time, this creates
    +    overhead when making requests to a server.So `remote-object-info`
    +    instead can take multiple object ids at once.
     
         cat-file --batch-command is generally implemented in the following
         manner:
    @@ Documentation/git-cat-file.txt: info <object>::
      	output of `--batch-check`.
      
     +remote-object-info <remote> <object>...::
    -+	Print object info for object references `<object>` at specified <remote>
    -+	without downloading objects from remote. If the object-info capability
    -+	is not supported by the server, the objects will be downloaded instead.
    ++	Print object info for object references `<object>` at specified
    ++	`<remote>` without downloading objects from the remote.
    ++	Error when the `object-info` capability is not supported by the server.
     +	Error when no object references are provided.
     +	This command may be combined with `--buffer`.
     +
    @@ builtin/cat-file.c: static void parse_cmd_info(struct batch_options *opt,
     +		data->oid = object_info_oids.oid[i];
     +
     +		if (remote_object_info[i].sizep) {
    -+			data->size = *remote_object_info[i].sizep;
    -+		} else {
     +			/*
    -+			 * When reaching here, it means remote-object-info can't retrieve
    -+			 * information from server without downloading them, and the objects
    -+			 * have been fetched to client already.
    -+			 * Print the information using the logic for local objects.
    ++			 * When reaching here, it means remote-object-info can retrieve
    ++			 * information from server without downloading them.
     +			 */
    -+			data->skip_object_info = 0;
    ++			data->size = *remote_object_info[i].sizep;
    ++			opt->batch_mode = BATCH_MODE_INFO;
    ++			batch_object_write(argv[i+1], output, opt, data, NULL, 0);
     +		}
    -+
    -+		opt->batch_mode = BATCH_MODE_INFO;
    -+		batch_object_write(argv[i+1], output, opt, data, NULL, 0);
    -+
     +	}
     +	opt->use_remote_info = 0;
     +	data->skip_object_info = 0;
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +
     +# Test --batch-command remote-object-info with 'git://' and
     +# transfer.advertiseobjectinfo set to false, i.e. server does not have object-info capability
    -+
    -+test_expect_success 'remote-object-info fallback git://: fetch objects to client' '
    ++test_expect_success 'batch-command remote-object-info git:// fails when transfer.advertiseobjectinfo=false' '
     +	(
     +		git -C "$daemon_parent" config transfer.advertiseobjectinfo false &&
     +		set_transport_variables "$daemon_parent" &&
    -+		cd "$daemon_parent/daemon_client_empty" &&
    -+
    -+		# Prove object is not on the client
    -+		echo "$hello_oid missing" >expect &&
    -+		echo "$tree_oid missing" >>expect &&
    -+		echo "$commit_oid missing" >>expect &&
    -+		echo "$tag_oid missing" >>expect &&
     +
    -+		# These results prove remote-object-info can retrieve object info
    -+		echo "$hello_oid $hello_size" >>expect &&
    -+		echo "$tree_oid $tree_size" >>expect &&
    -+		echo "$commit_oid $commit_size" >>expect &&
    -+		echo "$tag_oid $tag_size" >>expect &&
    -+
    -+		# These results are for the info command
    -+		# They prove objects are downloaded
    -+		echo "$hello_oid $hello_size" >>expect &&
    -+		echo "$tree_oid $tree_size" >>expect &&
    -+		echo "$commit_oid $commit_size" >>expect &&
    -+		echo "$tag_oid $tag_size" >>expect &&
    -+
    -+		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
    -+		info $hello_oid
    -+		info $tree_oid
    -+		info $commit_oid
    -+		info $tag_oid
    ++		test_must_fail git cat-file --batch-command="%(objectname) %(objectsize)" 2>err <<-EOF &&
     +		remote-object-info $GIT_DAEMON_URL/parent $hello_oid $tree_oid $commit_oid $tag_oid
    -+		info $hello_oid
    -+		info $tree_oid
    -+		info $commit_oid
    -+		info $tag_oid
     +		EOF
    ++		test_grep "object-info capability is not enabled on the server" err &&
     +
     +		# revert server state back
    -+		git -C "$daemon_parent" config transfer.advertiseobjectinfo true &&
    ++		git -C "$daemon_parent" config transfer.advertiseobjectinfo true
     +
    -+		test_cmp expect actual
     +	)
     +'
     +
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +
     +# Test --batch-command remote-object-info with 'file://' and
     +# transfer.advertiseobjectinfo set to false, i.e. server does not have object-info capability
    -+
    -+test_expect_success 'remote-object-info fallback file://: fetch objects to client' '
    ++test_expect_success 'batch-command remote-object-info file:// fails when transfer.advertiseobjectinfo=false' '
     +	(
     +		set_transport_variables "server" &&
     +		server_path="$(pwd)/server" &&
     +		git -C "${server_path}" config transfer.advertiseobjectinfo false &&
    -+		cd file_client_empty &&
     +
    -+		# Prove object is not on the client
    -+		echo "$hello_oid missing" >expect &&
    -+		echo "$tree_oid missing" >>expect &&
    -+		echo "$commit_oid missing" >>expect &&
    -+		echo "$tag_oid missing" >>expect &&
    -+
    -+		# These results prove remote-object-info can retrieve object info
    -+		echo "$hello_oid $hello_size" >>expect &&
    -+		echo "$tree_oid $tree_size" >>expect &&
    -+		echo "$commit_oid $commit_size" >>expect &&
    -+		echo "$tag_oid $tag_size" >>expect &&
    -+
    -+		# These results are for the info command
    -+		# They prove objects are downloaded
    -+		echo "$hello_oid $hello_size" >>expect &&
    -+		echo "$tree_oid $tree_size" >>expect &&
    -+		echo "$commit_oid $commit_size" >>expect &&
    -+		echo "$tag_oid $tag_size" >>expect &&
    -+
    -+		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
    -+		info $hello_oid
    -+		info $tree_oid
    -+		info $commit_oid
    -+		info $tag_oid
    ++		test_must_fail git cat-file --batch-command="%(objectname) %(objectsize)" 2>err <<-EOF &&
     +		remote-object-info "file://${server_path}" $hello_oid $tree_oid $commit_oid $tag_oid
    -+		info $hello_oid
    -+		info $tree_oid
    -+		info $commit_oid
    -+		info $tag_oid
     +		EOF
    ++		test_grep "object-info capability is not enabled on the server" err &&
     +
     +		# revert server state back
    -+		git -C "${server_path}" config transfer.advertiseobjectinfo true &&
    -+		test_cmp expect actual
    ++		git -C "${server_path}" config transfer.advertiseobjectinfo true
     +	)
     +'
     +
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +	)
     +'
     +
    -+test_expect_success 'remote-object-info fails on server with legacy protocol fallback' '
    ++test_expect_success 'remote-object-info fails on server with legacy protocol' '
     +	(
     +		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
     +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +	)
     +'
     +
    -+test_expect_success 'remote-object-info fails on malformed OID fallback' '
    ++test_expect_success 'remote-object-info fails on malformed OID with default filter' '
     +	(
     +		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
     +		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
    @@ t/t1017-cat-file-remote-object-info.sh (new)
     +	)
     +'
     +
    ++
     +# Test --batch-command remote-object-info with 'http://' transport and
     +# transfer.advertiseobjectinfo set to false, i.e. server does not have object-info capability
    -+
    -+test_expect_success 'remote-object-info fallback http://: fetch objects to client' '
    ++test_expect_success 'batch-command remote-object-info http:// fails when transfer.advertiseobjectinfo=false ' '
     +	(
     +		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
     +		git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config transfer.advertiseobjectinfo false &&
    -+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
    -+
    -+		# Prove object is not on the client
    -+		echo "$hello_oid missing" >expect &&
    -+		echo "$tree_oid missing" >>expect &&
    -+		echo "$commit_oid missing" >>expect &&
    -+		echo "$tag_oid missing" >>expect &&
     +
    -+		# These results prove remote-object-info can retrieve object info
    -+		echo "$hello_oid $hello_size" >>expect &&
    -+		echo "$tree_oid $tree_size" >>expect &&
    -+		echo "$commit_oid $commit_size" >>expect &&
    -+		echo "$tag_oid $tag_size" >>expect &&
    -+
    -+		# These results are for the info command
    -+		# They prove objects are downloaded
    -+		echo "$hello_oid $hello_size" >>expect &&
    -+		echo "$tree_oid $tree_size" >>expect &&
    -+		echo "$commit_oid $commit_size" >>expect &&
    -+		echo "$tag_oid $tag_size" >>expect &&
    -+
    -+		git cat-file --batch-command >actual <<-EOF &&
    -+		info $hello_oid
    -+		info $tree_oid
    -+		info $commit_oid
    -+		info $tag_oid
    ++		test_must_fail git cat-file --batch-command="%(objectname) %(objectsize)" 2>err <<-EOF &&
     +		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid $tree_oid $commit_oid $tag_oid
    -+		info $hello_oid
    -+		info $tree_oid
    -+		info $commit_oid
    -+		info $tag_oid
     +		EOF
    ++		test_grep "object-info capability is not enabled on the server" err &&
     +
     +		# revert server state back
    -+		git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config transfer.advertiseobjectinfo true &&
    -+
    -+		test_cmp expect actual
    ++		git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config transfer.advertiseobjectinfo true
     +	)
     +'
     +
-- 
2.47.0

Information Footer:
base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
Merge Request: https://gitlab.com/gitlab-org/git/-/merge_requests/168
