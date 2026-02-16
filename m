Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C7330596D
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248233; cv=none; b=Hk2O/WNihzI12a01h9xHjxwOW1o08SO6B/FZsPO+M8axVaksXviAIgyGeLf4s3nj70h3843++xfBhqhOd2Pngr+Lew4KOWd/htBLwD4iIDCCWVxfvvXBUxfYhAGQ290RbgQuQp9+/BSf2QddD2qAvqHdAVEDspVwVABqE8mUXLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248233; c=relaxed/simple;
	bh=dZl1bl06IIyOmCrBN9GuAeCdZH2wqW+AdYqDRbUhCAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cE7NyQAiI66DtabO8oesFlOOH9hD35+7n8LV1+XvF5uQYqIdHQGllAfRr4zl94FeCtjv3X4DLdbO5+FAHXj2dXPyYjrJouQbQgXgbpdWFxW44JsefGVWa2SSxYTVmhI/LSRMi5B7e7EKDQnkxz+vLcZzlWuUYGEX8zOK51v4vg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdB3pt7C; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdB3pt7C"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483770e0b25so26357355e9.0
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 05:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771248229; x=1771853029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkPIJh3cNzbwXIvJfHIfCyN+SUUgBexEggaSPQ7Dz8k=;
        b=fdB3pt7CGzIywqh26Mho57EqrU2wG5+TrtBq0MvDIGM7vR3TKB5OEvzRKesNHGtRHW
         4EmrhrjV34Uok8GVXeX6ImZnjG4vF1RDtx26U29SxC81fLTOaI3RN3u5SYo/HdkLqO5R
         vg6boltI7y7UsRsiPLkvXT/cj5BYhKtshwJI3iyL4ZqHwbNTkZXmF8ULBtwXdyxm56xN
         1HmiRLVODCFDIGH3vkCy1Iq8ChfVqfqJl0pOXnk/RIuipIqQimuuh9k7SHR2YQ4tDQGg
         LWMloL+p6+lQN9f9ETMZzODQsfVrP2LTyuzM5YAbAlJpM6hjzCwoO5XQ839qTwNE/YX6
         vSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771248229; x=1771853029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BkPIJh3cNzbwXIvJfHIfCyN+SUUgBexEggaSPQ7Dz8k=;
        b=rU0UCiRkjvOdfeHqxxwgryNwShUQqFtOUKNXud4iU6n6qHcQ1NjhNSwct/8ed4ebHz
         uchjwSkMq+ovFdJmA8AqNTVxeBzNv2WUOvNd+ukcP/8dfHTuY++GoMa7BxgifNEeixq8
         LeudORkC+Svw4s+GOGtugenskshrWqN0BORKgSHxz8zdJhJG9MGDw63YEV19LpMPSeDC
         ijGM0AjxTt0I5eFi5PpzDoZ3ZKD842tM1wf7K0DNsYSvMidEO5KGz2tPGXRxmH1CxSDS
         r/HMAHjggKJ5s4o+JgfM7BzJ5yEMOe+Cpd9sUTYODW2PKmCrZRl5Y2iIGRflNuJAu9J7
         1E9g==
X-Gm-Message-State: AOJu0Yzarwo8M5QLG/2X5/EZe+FK9osnHK4yjopoJm04W7cGWUT5iIUA
	FVa8m7O9dAe5oFizy9dMcEU2tMqhIaTdkICW3ngO7mhFis2HyUMI0xDhaQ/ckg==
X-Gm-Gg: AZuq6aL5HmOkHXkEPiGBpDMTtWJWvGSkU/8qeJYMNEvnugg0hn5fQvzE3OfO5fXKLAb
	hqAC9bbzKOEphVhOYSsqbO4hICglNxkeGpLi4kx1BJOm2D8XSr1wPKvZOJrWjVZzTFlJdu/+O1Q
	H2+ZXPM8H1h9halFaq1hp6OFjR6ObC4EYijTDgbhQdwtt7cjrQjWnJ4nG98e0HbQVYvEv7j0RpW
	SIT1w80WusBk3A5d0yWut+xuvHqPoJLjwQOAQvm+noEk3fI50twm/E+/nft90fMzK1ThK4niJ/g
	zE789fFhk1QZChRqOM5FwqTy/t6hh6rv66NvnMHDXT2qlCBVRNyXM/LtBkeg6DJ4RIOMvj+b9Rh
	SYaPCNbANNtvOLsrXEGJawsO3pw6uK2lVZPMK1fKEAnrimRPls+YJvjBkGpjkdYtAfvZajk4VXZ
	cXNqN+KA6gosyFEDnHmUe9+OH1W0eTcxaXHdlY2+pufmdDpV4kMu+lgWn9HTVOPdF9zR/C51TF1
	on7ZQ7cVL+brqVRYKE7R32DPBZISoXkDtgNcLQ=
X-Received: by 2002:a05:600c:1547:b0:477:6d96:b3c8 with SMTP id 5b1f17b1804b1-48371085837mr187739305e9.23.1771248229320;
        Mon, 16 Feb 2026 05:23:49 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370ac3564sm235688025e9.5.2026.02.16.05.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 05:23:48 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 9/9] fetch-pack: wire up and enable auto filter logic
Date: Mon, 16 Feb 2026 14:23:15 +0100
Message-ID: <20260216132317.15894-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.77.g4627d513d6
In-Reply-To: <20260216132317.15894-1-christian.couder@gmail.com>
References: <20260212100843.883623-1-christian.couder@gmail.com>
 <20260216132317.15894-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous commits have set up an infrastructure for `--filter=auto` to
automatically prepare a partial clone filter based on what the server
advertised and the client accepted.

Using that infrastructure, let's now enable the `--filter=auto` option
in `git clone` and `git fetch` by setting `allow_auto_filter` to 1.

Note that these small changes mean that when `git clone --filter=auto`
or `git fetch --filter=auto` are used, "auto" is automatically saved
as the partial clone filter for the server on the client. Therefore
subsequent calls to `git fetch` on the client will automatically use
this "auto" mode even without `--filter=auto`.

Let's also set `allow_auto_filter` to 1 in `transport.c`, as the
transport layer must be able to accept the "auto" filter spec even if
the invoking command hasn't fully parsed it yet.

When an "auto" filter is requested, let's have the "fetch-pack.c" code
in `do_fetch_pack_v2()` compute a filter and send it to the server.

In `do_fetch_pack_v2()` the logic also needs to check for the
"promisor-remote" capability and call `promisor_remote_reply()` to
parse advertised remotes and populate the list of those accepted (and
their filters).

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/fetch-options.adoc      | 19 ++++++---
 Documentation/git-clone.adoc          | 25 ++++++++---
 Documentation/gitprotocol-v2.adoc     | 16 ++++---
 builtin/clone.c                       |  2 +
 builtin/fetch.c                       |  2 +
 fetch-pack.c                          | 24 +++++++++++
 t/t5710-promisor-remote-capability.sh | 60 +++++++++++++++++++++++++++
 transport.c                           |  1 +
 8 files changed, 134 insertions(+), 15 deletions(-)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 1ef9807d00..a0cfb50d89 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -92,11 +92,20 @@ precedence over the `fetch.output` config option.
 	Use the partial clone feature and request that the server sends
 	a subset of reachable objects according to a given object filter.
 	When using `--filter`, the supplied _<filter-spec>_ is used for
-	the partial fetch. For example, `--filter=blob:none` will filter
-	out all blobs (file contents) until needed by Git. Also,
-	`--filter=blob:limit=<size>` will filter out all blobs of size
-	at least _<size>_. For more details on filter specifications, see
-	the `--filter` option in linkgit:git-rev-list[1].
+	the partial fetch.
++
+If `--filter=auto` is used, the filter specification is determined
+automatically by combining the filter specifications advertised by
+the server for the promisor remotes that the client accepts (see
+linkgit:gitprotocol-v2[5] and the `promisor.acceptFromServer`
+configuration option in linkgit:git-config[1]).
++
+For details on all other available filter specifications, see the
+`--filter=<filter-spec>` option in linkgit:git-rev-list[1].
++
+For example, `--filter=blob:none` will filter out all blobs (file
+contents) until needed by Git. Also, `--filter=blob:limit=<size>` will
+filter out all blobs of size at least _<size>_.
 
 ifndef::git-pull[]
 `--write-fetch-head`::
diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
index 57cdfb7620..0db2d1e5f0 100644
--- a/Documentation/git-clone.adoc
+++ b/Documentation/git-clone.adoc
@@ -187,11 +187,26 @@ objects from the source repository into a pack in the cloned repository.
 	Use the partial clone feature and request that the server sends
 	a subset of reachable objects according to a given object filter.
 	When using `--filter`, the supplied _<filter-spec>_ is used for
-	the partial clone filter. For example, `--filter=blob:none` will
-	filter out all blobs (file contents) until needed by Git. Also,
-	`--filter=blob:limit=<size>` will filter out all blobs of size
-	at least _<size>_. For more details on filter specifications, see
-	the `--filter` option in linkgit:git-rev-list[1].
+	the partial clone filter.
++
+If `--filter=auto` is used the filter specification is determined
+automatically through the 'promisor-remote' protocol (see
+linkgit:gitprotocol-v2[5]) by combining the filter specifications
+advertised by the server for the promisor remotes that the client
+accepts (see the `promisor.acceptFromServer` configuration option in
+linkgit:git-config[1]). This allows the server to suggest the optimal
+filter for the available promisor remotes.
++
+As with other filter specifications, the "auto" value is persisted in
+the configuration. This ensures that future fetches will continue to
+adapt to the server's current recommendation.
++
+For details on all other available filter specifications, see the
+`--filter=<filter-spec>` option in linkgit:git-rev-list[1].
++
+For example, `--filter=blob:none` will filter out all blobs (file
+contents) until needed by Git. Also, `--filter=blob:limit=<size>` will
+filter out all blobs of size at least _<size>_.
 
 `--also-filter-submodules`::
 	Also apply the partial clone filter to any submodules in the repository.
diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index d93dd279ea..f985cb4c47 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -812,10 +812,15 @@ MUST appear first in each pr-fields, in that order.
 After these mandatory fields, the server MAY advertise the following
 optional fields in any order:
 
-`partialCloneFilter`:: The filter specification used by the remote.
+`partialCloneFilter`:: The filter specification for the remote. It
+corresponds to the "remote.<name>.partialCloneFilter" config setting.
 Clients can use this to determine if the remote's filtering strategy
-is compatible with their needs (e.g., checking if both use "blob:none").
-It corresponds to the "remote.<name>.partialCloneFilter" config setting.
+is compatible with their needs (e.g., checking if both use
+"blob:none"). Additionally they can use this through the
+`--filter=auto` option in linkgit:git-clone[1]. With that option, the
+filter specification of the clone will be automatically computed by
+combining the filter specifications of the promisor remotes the client
+accepts.
 
 `token`:: An authentication token that clients can use when
 connecting to the remote. It corresponds to the "remote.<name>.token"
@@ -828,8 +833,9 @@ future protocol extensions.
 
 The client can use information transmitted through these fields to
 decide if it accepts the advertised promisor remote. Also, the client
-can be configured to store the values of these fields (see
-"promisor.storeFields" in linkgit:git-config[1]).
+can be configured to store the values of these fields or use them
+to automatically configure the repository (see "promisor.storeFields"
+in linkgit:git-config[1] and `--filter=auto` in linkgit:git-clone[1]).
 
 Field values MUST be urlencoded.
 
diff --git a/builtin/clone.c b/builtin/clone.c
index bb27472020..45d8fa0eed 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1001,6 +1001,8 @@ int cmd_clone(int argc,
 		NULL
 	};
 
+	filter_options.allow_auto_filter = 1;
+
 	packet_trace_identity("clone");
 
 	repo_config(the_repository, git_clone_config, NULL);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8fbf3557ce..573c295241 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2580,6 +2580,8 @@ int cmd_fetch(int argc,
 		OPT_END()
 	};
 
+	filter_options.allow_auto_filter = 1;
+
 	packet_trace_identity("fetch");
 
 	/* Record the command line for the reflog */
diff --git a/fetch-pack.c b/fetch-pack.c
index 40316c9a34..9f8f980516 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -35,6 +35,7 @@
 #include "sigchain.h"
 #include "mergesort.h"
 #include "prio-queue.h"
+#include "promisor-remote.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -1661,6 +1662,29 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
 	int i;
 	struct strvec index_pack_args = STRVEC_INIT;
+	const char *promisor_remote_config;
+
+	if (server_feature_v2("promisor-remote", &promisor_remote_config))
+		promisor_remote_reply(promisor_remote_config, NULL);
+
+	if (args->filter_options.choice == LOFC_AUTO) {
+		struct strbuf errbuf = STRBUF_INIT;
+		char *constructed_filter = promisor_remote_construct_filter(r);
+
+		list_objects_filter_release(&args->filter_options);
+		/* Disallow 'auto' as a result of the resolution of this 'auto' filter below */
+		args->filter_options.allow_auto_filter = 0;
+
+		if (constructed_filter &&
+		    gently_parse_list_objects_filter(&args->filter_options,
+						     constructed_filter,
+						     &errbuf))
+			die(_("couldn't resolve 'auto' filter '%s': %s"),
+			    constructed_filter, errbuf.buf);
+
+		free(constructed_filter);
+		strbuf_release(&errbuf);
+	}
 
 	negotiator = &negotiator_alloc;
 	if (args->refetch)
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 6ef6431bd7..532e6f0fea 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -423,6 +423,66 @@ test_expect_success "clone with promisor.storeFields=partialCloneFilter" '
 	test_grep "'\''blob:limit=8k'\'' -> '\''blob:limit=7k'\''" err
 '
 
+test_expect_success "clone and fetch with --filter=auto" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client trace" &&
+
+	git -C server config remote.lop.partialCloneFilter "blob:limit=9500" &&
+	test_config -C server promisor.sendFields "partialCloneFilter" &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
+		-c remote.lop.promisor=true \
+		-c remote.lop.url="file://$(pwd)/lop" \
+		-c promisor.acceptfromserver=All \
+		--no-local --filter=auto server client 2>err &&
+
+	test_grep "filter blob:limit=9500" trace &&
+	test_grep ! "filter auto" trace &&
+
+	# Verify "auto" is persisted in config
+	echo auto >expected &&
+	git -C client config remote.origin.partialCloneFilter >actual &&
+	test_cmp expected actual &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid" &&
+
+	# Now change the filter on the server
+	git -C server config remote.lop.partialCloneFilter "blob:limit=5678" &&
+
+	# Get a new commit on the server to ensure "git fetch" actually runs fetch-pack
+	test_commit -C template new-commit &&
+	git -C template push --all "$(pwd)/server" &&
+
+	# Perform a fetch WITH --filter=auto
+	rm -rf trace &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch --filter=auto &&
+
+	# Verify that the new filter was used
+	test_grep "filter blob:limit=5678" trace &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid" &&
+
+	# Change the filter on the server again
+	git -C server config remote.lop.partialCloneFilter "blob:limit=5432" &&
+
+	# Get yet a new commit on the server to ensure fetch-pack runs
+	test_commit -C template yet-a-new-commit &&
+	git -C template push --all "$(pwd)/server" &&
+
+	# Perform a fetch WITHOUT --filter=auto
+	# Relies on "auto" being persisted in the client config
+	rm -rf trace &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch &&
+
+	# Verify that the new filter was used
+	test_grep "filter blob:limit=5432" trace &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
 test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
 	git -C server config promisor.advertise true &&
 
diff --git a/transport.c b/transport.c
index c7f06a7382..cde8d83a57 100644
--- a/transport.c
+++ b/transport.c
@@ -1219,6 +1219,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		 */
 		struct git_transport_data *data = xcalloc(1, sizeof(*data));
 		list_objects_filter_init(&data->options.filter_options);
+		data->options.filter_options.allow_auto_filter = 1;
 		ret->data = data;
 		ret->vtable = &builtin_smart_vtable;
 		ret->smart_options = &(data->options);
-- 
2.53.0.77.g4627d513d6

