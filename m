Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E183E9584
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203327; cv=none; b=OD9rbVQIzoc2uIuZJSgEQSy94z1STq3NxnPi7nviYxYmT2czXMoDU6OOWyLcIixxfJ7r0TaV4w5XCyeI6GKVzEeWXQtLd45Kv1jgY+k6E/s8Io3J578HgXPu7IRZfiWRW9he2HVqOLDKvh+iaJpMrCZQDZYb/G4ML+0FPlVwngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203327; c=relaxed/simple;
	bh=L5DQsvF2RnoL3oQdYtGQO+XdOc3UoHw8bHXYobs/muY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIr+UZ3JdoloRPExUEYrioLLLPxTudDGJaL2/TQCpwu4ewy6u/vUxtAJj5fBP+ExI5KxPZm8nVjSLKEsCFm8Bw1eux5uxJbW5ED1mDkOotvWygSCbgGZHG2InDZGMeZHn8UpRqJ4D3F5Hzlru88TgDlp/EJSjXeyioaGS0hXJOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUXBdXy2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUXBdXy2"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4359228b7c6so4709714f8f.2
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 03:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770203325; x=1770808125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7qxTMYDcHRN9CLCWzqGzkO0Bv+oDkl1bQP3Kk5ZHkw=;
        b=FUXBdXy2DqpErbM6l3ZTYyroGbsy55i5z/6nLaes94Z9V23MiNyr5Hc36JMDwUFD2k
         Ja1Pj+UkSeGqEMFWiG2cllXAmAB4lI2/q+jKUWX2Q6mJY/dYa4GqvntptMywaTVrF+ja
         bUPpZPiWERDhssCCxLOJLu4wZ/LmmWjCRk4vSZWE0T3byjrTrW2Qw8iSxGDHx99neyx9
         hqfh+w5D6YvNoeKQqKwT61pK6ntDg2eZrdUaZMeV08dgVc+KYHXq56YodVPZvLAOFAlt
         UhN74WUERDuvO/ZgzJs0rMM8TlatuuClFB2OHEkA77c7DKHmEs4r5eRw/caK/1JY0/lf
         6VPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203325; x=1770808125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e7qxTMYDcHRN9CLCWzqGzkO0Bv+oDkl1bQP3Kk5ZHkw=;
        b=BNx7AiA4WERBvx1T75hpdE1rNlptXm9INGkuv08OGwjYcyUjAJnwzvRlExT2tYo9aZ
         V7okN+/8+KoukZ78riLK2FTk0RfrHOMxXbbInMOEGvX4V7dnlR3keBfqu44rDjH992jh
         ztCKHEulMd3f2WVQ4mPOVfB1cAGBtd6dDx6b3HfSfnZtm0n2GObj/w9NRfcHsnrtKuWC
         SXjp5Ljhfwzlt4oPmPQX8ayTCFxoRW2oUM3TnfiAzV9mB+qZNy9Cwm+k3TUJ6EZrodaD
         nKp9Nlunqqwhzmsee0QoB3oP3NzMkuOArlTXn9xbRnZ4mosZb3bt3nG2qQRGNMWz2N5r
         XkTg==
X-Gm-Message-State: AOJu0Yx8w3VZP+RxlxZT8sIpei72TbJhtvlAKyP0HR2IjU5lgJQda9XC
	u89BvBALBYQmaEDJodJedQNpJpVNdRP7uTeRLF4Xtci3xXknIxZ9WX8Nly/IvA==
X-Gm-Gg: AZuq6aJ9LS5vc0D+XlHUThzyiAVRKAj9wNpT/Wr7gQMHhY7GHHIaoE/DYnx4CuUtr4R
	tTWDU3h7qjDXruiyiGvx9IfMNyiTHzI8d55vIP3abtN9kKNN0dvpaXzbJx0SWPgh5lNaGICPGZJ
	DN/E7lrj+NfZTcGUkPSMeAxocg22+iXN7dB0bLIDqWBd2cW3PKPiciaNm5JyfAVUg0mgteqitWw
	ajnPr09vFzwWmLNN9/CCStFeQtbbD43ozk9AnU24egR1hBv2ig5MtF3/UGlPNy3i0AvIIg2OqHC
	s+7cVdggHv4DWo/GFaWVdNTPxeJcDTO5uNGP8J226ZX/Ye+UpSBzpeMTRvG9wtQtXX5vpCZMDQ1
	EGJglDSE6WRRrO/mUTIpkIZrbqB3g2fCm5CKfkKVuJysns3m8ST/AdJ5kpOJGDVMNJsaUIc2ao7
	5eRzir7bLD+Gwvi63sbcuZC1Rj5SOn/uEooUXf082AhXZ61BoolMS0LyFXObX8PH/pJXB1hNAqm
	qLykDeET0wB9Dp402+APZEYhuRuhOV9+6uLkw==
X-Received: by 2002:a05:6000:601:b0:431:104:6db7 with SMTP id ffacd0b85a97d-43617e41bd6mr3815715f8f.26.1770203324625;
        Wed, 04 Feb 2026 03:08:44 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436180640f2sm5340096f8f.39.2026.02.04.03.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:08:43 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 8/8] fetch-pack: wire up and enable auto filter logic
Date: Wed,  4 Feb 2026 12:08:13 +0100
Message-ID: <20260204110818.2919273-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.10.g12663a1c75.dirty
In-Reply-To: <20260204110818.2919273-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260204110818.2919273-1-christian.couder@gmail.com>
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
 fetch-pack.c                          | 28 +++++++++++++
 t/t5710-promisor-remote-capability.sh | 60 +++++++++++++++++++++++++++
 transport.c                           |  1 +
 8 files changed, 138 insertions(+), 15 deletions(-)

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
index 51f4b5809d..67c7db104f 100644
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
index b984173447..ddc30a0d30 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2439,6 +2439,8 @@ int cmd_fetch(int argc,
 		OPT_END()
 	};
 
+	filter_options.allow_auto_filter = 1;
+
 	packet_trace_identity("fetch");
 
 	/* Record the command line for the reflog */
diff --git a/fetch-pack.c b/fetch-pack.c
index 40316c9a34..5e9a969e31 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -35,6 +35,7 @@
 #include "sigchain.h"
 #include "mergesort.h"
 #include "prio-queue.h"
+#include "promisor-remote.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -1661,6 +1662,33 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
 	int i;
 	struct strvec index_pack_args = STRVEC_INIT;
+	const char *promisor_remote_config;
+
+	if (server_feature_v2("promisor-remote", &promisor_remote_config)) {
+		char *remote_name = promisor_remote_reply(promisor_remote_config);
+		free(remote_name);
+	}
+
+	if (args->filter_options.choice == LOFC_AUTO) {
+		struct strbuf errbuf = STRBUF_INIT;
+		char *constructed_filter = promisor_remote_construct_filter(r);
+
+		list_objects_filter_release(&args->filter_options);
+		/* The result of resolving an 'auto' filter must not be 'auto' */
+		args->filter_options.allow_auto_filter = 0;
+
+		if (constructed_filter)
+			gently_parse_list_objects_filter(&args->filter_options,
+							 constructed_filter,
+							 &errbuf);
+
+		if (errbuf.len > 0)
+			die(_("couldn't resolve 'auto' filter '%s': %s"),
+			    constructed_filter, errbuf.buf);
+
+		free(constructed_filter);
+		strbuf_release(&errbuf);
+	}
 
 	negotiator = &negotiator_alloc;
 	if (args->refetch)
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index a726af214a..21543bce20 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -409,6 +409,66 @@ test_expect_success "clone with promisor.storeFields=partialCloneFilter" '
 	check_missing_objects server 1 "$oid"
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
2.53.0.rc2.10.g12663a1c75.dirty

