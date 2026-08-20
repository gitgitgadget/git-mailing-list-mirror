Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F863CC32E
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212541; cv=none; b=BFyq5zYpf6BlaflNDwoFwsOALL45l2S4KezMBfc9PYkmgj5h+kOMBo/HQW/VoANQAyrz1pOtuFUAQ204MCU4FlEnFYB2Sd01j03fPZ0qtTWjjWS2noJn5mNV5T/uDsahR0lSis1Hd+avimTxENr0URZ9rRR90UGedMd/LTvlPjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212541; c=relaxed/simple;
	bh=KHfK9P0x11QlnXmU2i0Tia1sbJ6jJZDg1m5yQeCaK0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=htlPq28jKq/7V0l6ZS8k7Y1p6OtVSDSs1qY2FUj7nR0AmQ4SVxII0d7G/gsJROrdnjbqiNwgHvvbehR+O+r0BJddegdfv6QfMTfsbuhO5skCOtp2cMmLL+HCabgifXpOPZW7fIdfwe38wdQDGjFN5y/fYFtD2tYUFmxj2Pmc0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k9oVjvzK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dOVp8sPo; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k9oVjvzK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dOVp8sPo"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 22AF31400112;
	Thu, 20 Aug 2026 03:55:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 20 Aug 2026 03:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787212539;
	 x=1787298939; bh=ZIC3593rpgYXvOdoyc3O3HNCti8OjgJG/XA51zySW0Y=; b=
	k9oVjvzKEf9HYwghjdLl5vNvMTPQn/8FZ7ndN/WvrAiIWDWC1lQ9R/x4oUsgtN+8
	Widx3Me27YIkOKkRePLJqW6EuMuP/uWo4scOxh4VH1+CJlgjLdvzaSo+UXt8gqjk
	g10mNHIlXtj0O1EXefB7JimXKn+B5qyRL8W6XT5T4fCGWCaRuSx5BdWqsbFAsVgJ
	J+SutoMnNVqc4aiIodD01YPA1xoD/fhh3hdX3C30bG1kMlANsOo1HNoadIKnrG6L
	QW7yc7Km9+kv9NU5qdqKqFly9h948+ppn8ywOHmmrQS6aAbu2/czvnxyKwIyrLZp
	Oq2+wx9DMoXifiPL/qgsaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787212539; x=
	1787298939; bh=ZIC3593rpgYXvOdoyc3O3HNCti8OjgJG/XA51zySW0Y=; b=d
	OVp8sPokgmood2RzR6XvUJXKbzNoCvqRSXFRSB5AKXVRRXqe7u9hMLySKR3OAwcm
	33bfDBxYojigxcMroIuxNG9BNw7AKiOg8Jka1FCvtlR02bdZAaMDP7zo1Sta4Fft
	HMC8k2zrpuVLkBjt5TD2RLjDmR5WxlQdtqbwG1sNuMIEfVbWWl4xWOiAjR5zAGO6
	/UUteag6NNfYlPNQMLm4Xg7/G6zl6iC9nO6TF621AE8cRZxKI6zBir/TKy1Io+aP
	vz9r304qF0Xk1boMqhNzaCPhms0RKdwb/cDfGSSspKiMnAVw84Kr0royXwdRiEBl
	Rr0a8uaIRmX6ylaoBvo6Q==
X-ME-Sender: <xms:-7KGal3uJVQIWGdK2si342qXkeyDJYEaoRi_PnZ_pCvZ3w96YMsyZg>
    <xme:-7KGajHMOK-LzZ-SVBvJrrdMYeTY39YdLrwQg_-gswN8mf5grMD63UX19Hg_5FLXD
    n_Lx1ZQR0AjNBmhuRSMly-5_KHSn25-7y9tFZ_qUEO4EcOQBTKnNRI>
X-ME-Received: <xmr:-7KGaq4EucvRzIqeC_P1xDz8AKHuVUvFmDguWQw6nUsPWysczlC14-3WUO8_WBzuLaZo6simiE2pnWEQc3UN_fezNQETWURcxvOVIjcvMw>
X-ME-Proxy-Cause: dmFkZTFf6dj8/8V1XaAc7B1kVMFZTKvMbAEygAXbbhBXRMoJE0Q/MsehWCz6Zsr3VItoGJ
    sSOYPjnsDlfrh3lzEARCv0NJnfuJQJusLASMKcwM9uC/Tbs/YIBauNX4V2AuW+yb3o66jM
    JzMl+gjCx01/1zMiYhH+kC59/ghsfTubikmfaAxgUR/millS0tlPNpkYgp4jFToJY+LVEk
    c6s4D4aztX2xzEJ3LDQqGoLTd3S6W+Hcma/glCPpKbDpT9Cmp60wceni6gyM3ckjl3Tvge
    oRcfTlFV6iALm7ps8/b3emKy+rfSopq+d7NQ4EYMi/B5tNUxYa1zjgIENCda7YAb8Hlkm2
    myKeut5eRI2fdsXSVIJ0S1PCpE8FZttF85jdEy/kuunwNNOh0Co35UZARS7ZqjxXfWSAdP
    POeGExhdP5l/MkcNWqrQy/WvH2UAe3xDKOUpF2ri5X/O5+VxNTp2fXnz7om2qbqLgAblJf
    ZuxMWpjJb5n+tRRyhM/nHBhXbBO56fsCUzRAO5mwNH+q8bsAdxHDQoRrIkTniBn7Z9ePAH
    X68HZZGNzVrsU1ByYs3e5gHnhEAqG/d/DEW7Ubm64+U5r1sGXnDOHzNvg6nAMMNHE4GNVP
    5zb/ZQIUcD05TBxG12BFJVQZ1DQH6nSfzmIgqR4lquwkq4sL/4BQIGPav9rw
X-ME-Proxy: <xmx:-7KGahtggwWKrJcPxGOez4s-aecQY1S8VaCOp9W2OIYAcubZJdfEMg>
    <xmx:-7KGaj5jbRHpmMt23dc1ke0qfqJCY5kEZ5OzvV7ivWgORPqmQuWwqw>
    <xmx:-7KGakVDe0JHVFhDGUTbL6NAAvNFbskxr5mNHUYltGzfVdcMZepJXg>
    <xmx:-7KGat-1cm6f6Cbrv0x3VLZ9uhLaXA7Tu7WW06EEW2DyMlA3-WLVkQ>
    <xmx:-7KGamaQoRh9tnso_byHEoXr9Sy1ObFjFJHg6r7xvQC6E9tcEt1MNmCL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 03:55:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f500fb2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 07:55:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Aug 2026 09:55:25 +0200
Subject: [PATCH v3 1/6] odb: introduce interface to generate packfiles
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-b4-pks-odb-generate-pack-v3-1-bc42252f6169@pks.im>
References: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
In-Reply-To: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Packfiles have two primary use cases:

  - They are used to store objects at rest in a Git repository.

  - They are used on the transport layer to transfer objects between two
    repositories.

The first class is closely tied to a given object database backend, and
as such this use is highly specific to how such a backend decides to
store its data. This shows in git-pack-objects(1), which is used by
git-repack(1) et al to optimize the object database, which supports lots
of options that are closely coupled with how data is stored.

But the second class is quite a lot more generic: we don't care about
specifics of how the object database stores its objects, but to generate
the packfiles we only care about the object graph itself. Still, this
use case is also coupled with git-pack-objects(1).

Unfortunately, because git-pack-objects(1) covers both classes, the
result is that it is very hard to port the whole command to properly
support pluggable object databases. There are simply way too many
options that an alternative implementation will have a very hard time to
support in the first place.

And despite being hard to implement, it's also quite unnecessary to
implement those backend-specific options. Optimizing the object database
has already been made pluggable, and an alternative implementation is
unlikely to care about cruft packs, unpacked objects, keep packs and the
like. But we still need to make at least _parts_ of the packfile
generation pluggable so that backends can generate packfiles for the
transport layer itself.

Introduce a new interface that lets backends generate a new packfile and
implement that interface for the "files" backend. The options supported
by the callback are exactly the set of options that are required for the
transport layer, but nothing more.

This means that git-pack-objects(1) itself cannot be ported over to this
new interface, but as explained above that's a hard feat to pull off due
to the backend-specific features. Ideally though, we should expose the
ability to generate arbitrary packfiles using this interface. The intent
of this is to eventually introduce a git-objects(1) subcommand (similar
to git-refs(1)) that exposes generic interfaces for accessing everything
related to the object database. In that case, we are able to expose only
those options that are generic.

Subsequent commits will convert git-upload-pack(1), git-send-pack(1) and
git-bundle(1) to use this interface.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c              |  21 ++++++++
 odb.h              | 152 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 odb/source-files.c | 149 +++++++++++++++++++++++++++++++++++++++++++++++++++
 odb/source.h       |  33 ++++++++++++
 4 files changed, 355 insertions(+)

diff --git a/odb.c b/odb.c
index caf1d0f542..cd9d5b48bc 100644
--- a/odb.c
+++ b/odb.c
@@ -1046,6 +1046,27 @@ bool odb_optimize_required(struct object_database *odb,
 	return odb_source_optimize_required(odb->sources, opts);
 }
 
+void odb_generate_pack_options_release(struct odb_generate_pack_options *opts)
+{
+	oid_array_clear(&opts->wants);
+	oid_array_clear(&opts->haves);
+	oid_array_clear(&opts->shallows);
+}
+
+int odb_generate_pack(struct object_database *odb,
+		      struct odb_pack_generator **out,
+		      const struct odb_generate_pack_options *opts)
+{
+	if (!odb->sources->generate_pack)
+		return error(_("primary object source does not support generating packfiles"));
+	return odb_source_generate_pack(odb->sources, out, opts);
+}
+
+int odb_pack_generator_finish(struct odb_pack_generator *generator)
+{
+	return generator->finish(generator);
+}
+
 struct object_database *odb_new(struct repository *repo,
 				const char *primary_source,
 				const char *secondary_sources)
diff --git a/odb.h b/odb.h
index fca67e8253..fc1442f243 100644
--- a/odb.h
+++ b/odb.h
@@ -2,6 +2,7 @@
 #define ODB_H
 
 #include "object.h"
+#include "oid-array.h"
 #include "oidset.h"
 #include "oidmap.h"
 #include "string-list.h"
@@ -677,6 +678,157 @@ int odb_write_object_stream(struct object_database *odb,
 			    struct odb_write_stream *stream, size_t len,
 			    struct object_id *oid);
 
+/*
+ * Options for generating a packfile via `odb_generate_pack()`.
+ */
+struct odb_generate_pack_options {
+	/* Tips of the object graph that shall be packed. */
+	struct oid_array wants;
+
+	/*
+	 * Boundary of the object graph. Objects reachable from any of these
+	 * tips are expected to already be available to whoever consumes the
+	 * pack and shall thus not be packed.
+	 */
+	struct oid_array haves;
+
+	/*
+	 * The shallow boundary that shall be used when computing object
+	 * reachability. When set, any shallow information of the repository
+	 * itself shall be ignored in favor of these objects.
+	 */
+	struct oid_array shallows;
+
+	/*
+	 * Pre-expanded object filter specification that limits the set of
+	 * objects that shall be packed. May be `NULL` in case no filter shall
+	 * be applied.
+	 */
+	const char *filter_spec;
+
+	/*
+	 * Protocols that may be used to offload objects via packfile URIs.
+	 * May be `NULL` in case packfile URIs shall not be used.
+	 */
+	const struct string_list *uri_protocols;
+
+	/*
+	 * Hook command that shall be executed instead of the internal
+	 * machinery to generate the pack. It is up to the specific backend
+	 * whether or not this hook is supported. May be `NULL` in case no
+	 * hook shall be executed.
+	 */
+	const char *pack_objects_hook;
+
+	/*
+	 * File descriptor that the generated pack shall be written to. If set
+	 * to `-1`, a pipe will be created and exposed via the pack generator's
+	 * `out` field. If set to `0`, the pack will be written to the standard
+	 * output stream. Otherwise, the provided descriptor will be written to
+	 * and is consumed by the generator.
+	 */
+	int pack_fd;
+
+	/*
+	 * File descriptor that progress output shall be written to. The same
+	 * semantics as for `pack_fd` apply, except that `0` will cause the
+	 * generator to write to stderr instead of stdout.
+	 */
+	int progress_fd;
+
+	/* Whether to print progress or not. */
+	enum {
+		/* Don't print progress output. */
+		ODB_GENERATE_PACK_PROGRESS_NONE,
+
+		/*
+		 * Print progress while computing the packfile, but stop
+		 * printing progress once starting to write it.
+		 */
+		ODB_GENERATE_PACK_PROGRESS_STANDARD,
+
+		/*
+		 * Similar to STANDARD, but also print progress when writing
+		 * the packfile.
+		 */
+		ODB_GENERATE_PACK_PROGRESS_VERBOSE,
+	} progress;
+
+	/* Allow the pack to contain deltas against unpacked objects. */
+	unsigned thin:1;
+
+	/* Use offset deltas instead of reference deltas. */
+	unsigned ofs_delta:1;
+
+	/* Include unasked-for annotated tags of packed objects. */
+	unsigned include_tag:1;
+
+	/* The generated pack is destined for a shallow consumer. */
+	unsigned shallow:1;
+
+	/* Allow objects that may be missing due to a promisor remote. */
+	unsigned missing_allow_promisor:1;
+
+	/* Do not use bitmap indices when computing reachability. */
+	unsigned disable_bitmaps:1;
+};
+
+#define ODB_GENERATE_PACK_OPTIONS_INIT { \
+	.wants = OID_ARRAY_INIT, \
+	.haves = OID_ARRAY_INIT, \
+	.shallows = OID_ARRAY_INIT, \
+	.pack_fd = -1, \
+}
+
+/* Release resources associated with the options. */
+void odb_generate_pack_options_release(struct odb_generate_pack_options *opts);
+
+/*
+ * A handle for an ongoing packfile generation as started via
+ * `odb_generate_pack()`.
+ */
+struct odb_pack_generator {
+	/*
+	 * File descriptor from which the generated pack can be read. Only set
+	 * when the pack generation was started with `pack_fd == -1`. The
+	 * caller is responsible for closing the descriptor.
+	 */
+	int out;
+
+	/*
+	 * File descriptor from which progress output can be read. Only set
+	 * when the pack generation was started with `progress_fd == -1`. The
+	 * caller is responsible for closing the descriptor.
+	 */
+	int err;
+
+	/*
+	 * Callback function to finish this generator. This callback is
+	 * expected to wait for the packfile generation to complete and to then
+	 * free the generator itself.
+	 */
+	int (*finish)(struct odb_pack_generator *);
+};
+
+/*
+ * Start generating a packfile from the object database with the given
+ * options. The pack is generated asynchronously; the caller is expected to
+ * consume the file descriptors exposed via the pack generator and to then
+ * wait for completion via `odb_pack_generator_finish()`.
+ *
+ * Returns 0 on success and populates the `out` pointer with the pack
+ * generator. Returns a negative error code otherwise.
+ */
+int odb_generate_pack(struct object_database *odb,
+		      struct odb_pack_generator **out,
+		      const struct odb_generate_pack_options *opts);
+
+/*
+ * Wait for the packfile generation to complete and free the pack generator.
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int odb_pack_generator_finish(struct odb_pack_generator *generator);
+
 void parse_alternates(const char *string,
 		      int sep,
 		      const char *relative_base,
diff --git a/odb/source-files.c b/odb/source-files.c
index 5a68af7d84..a33e01fbed 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -4,6 +4,7 @@
 #include "chdir-notify.h"
 #include "config.h"
 #include "gettext.h"
+#include "hex.h"
 #include "lockfile.h"
 #include "object-file.h"
 #include "odb.h"
@@ -729,6 +730,153 @@ int odb_source_files_optimize(struct odb_source *source,
 	return ret;
 }
 
+struct odb_pack_generator_files {
+	struct odb_pack_generator base;
+	struct child_process cp;
+};
+
+static int odb_pack_generator_files_finish(struct odb_pack_generator *_generator)
+{
+	struct odb_pack_generator_files *generator =
+		(struct odb_pack_generator_files *)_generator;
+	int ret;
+
+	ret = finish_command(&generator->cp);
+	free(generator);
+
+	if (ret) {
+		/*
+		 * On failure, pack-objects is expected to have written a
+		 * useful error message to its standard error stream already.
+		 * Death by signal is worth mentioning, though, with the
+		 * exception of SIGPIPE: that is a normal occurrence when the
+		 * consumer of the pack hangs up.
+		 */
+		if (ret > 128 && ret - 128 == SIGPIPE)
+			return -1;
+		if (ret > 128)
+			error(_("pack-objects died of signal %d"), ret - 128);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int odb_source_files_generate_pack(struct odb_source *source UNUSED,
+					  struct odb_pack_generator **out,
+					  const struct odb_generate_pack_options *opts)
+{
+	struct odb_pack_generator_files *generator;
+	struct child_process *cp;
+	FILE *in;
+
+	CALLOC_ARRAY(generator, 1);
+	child_process_init(&generator->cp);
+	cp = &generator->cp;
+
+	/*
+	 * The hook is expected to spawn "$hook git pack-objects <args...>"
+	 * and to behave like git-pack-objects(1) would have. This can for
+	 * example be used to serve precomputed packfiles.
+	 */
+	if (opts->pack_objects_hook) {
+		strvec_push(&cp->args, opts->pack_objects_hook);
+		strvec_push(&cp->args, "git");
+		cp->use_shell = 1;
+	} else {
+		cp->git_cmd = 1;
+	}
+
+	/*
+	 * The caller-provided shallow boundary overrides any shallow state
+	 * that the repository itself may have, so the shallow file needs to
+	 * be neutralized.
+	 */
+	if (opts->shallows.nr) {
+		strvec_push(&cp->args, "--shallow-file");
+		strvec_push(&cp->args, "");
+	}
+	strvec_push(&cp->args, "pack-objects");
+	strvec_push(&cp->args, "--revs");
+	strvec_push(&cp->args, "--stdout");
+	if (opts->thin)
+		strvec_push(&cp->args, "--thin");
+	if (opts->shallow)
+		strvec_push(&cp->args, "--shallow");
+	if (opts->ofs_delta)
+		strvec_push(&cp->args, "--delta-base-offset");
+	if (opts->include_tag)
+		strvec_push(&cp->args, "--include-tag");
+	if (opts->missing_allow_promisor)
+		strvec_push(&cp->args, "--missing=allow-promisor");
+	if (opts->disable_bitmaps)
+		strvec_push(&cp->args, "--no-use-bitmap-index");
+	switch (opts->progress) {
+	case ODB_GENERATE_PACK_PROGRESS_NONE:
+		strvec_push(&cp->args, "--quiet");
+		break;
+	case ODB_GENERATE_PACK_PROGRESS_STANDARD:
+		strvec_push(&cp->args, "--progress");
+		break;
+	case ODB_GENERATE_PACK_PROGRESS_VERBOSE:
+		strvec_push(&cp->args, "--all-progress");
+		break;
+	default:
+		BUG("unknown progress option %d", opts->progress);
+	}
+	if (opts->filter_spec)
+		strvec_pushf(&cp->args, "--filter=%s", opts->filter_spec);
+	if (opts->uri_protocols)
+		for (size_t i = 0; i < opts->uri_protocols->nr; i++)
+			strvec_pushf(&cp->args, "--uri-protocol=%s",
+				     opts->uri_protocols->items[i].string);
+
+	cp->in = -1;
+	cp->out = opts->pack_fd;
+	cp->err = opts->progress_fd;
+	cp->clean_on_exit = 1;
+
+	if (start_command(cp)) {
+		free(generator);
+		return error(_("could not spawn pack-objects"));
+	}
+
+	/*
+	 * Feed the objects to pack-objects. This is safe to do synchronously
+	 * because pack-objects consumes all of its standard input before it
+	 * starts to generate the pack.
+	 */
+	in = xfdopen(cp->in, "w");
+	for (size_t i = 0; i < opts->shallows.nr; i++)
+		fprintf(in, "--shallow %s\n", oid_to_hex(&opts->shallows.oid[i]));
+	for (size_t i = 0; i < opts->wants.nr; i++)
+		fprintf(in, "%s\n", oid_to_hex(&opts->wants.oid[i]));
+	fprintf(in, "--not\n");
+	for (size_t i = 0; i < opts->haves.nr; i++)
+		fprintf(in, "%s\n", oid_to_hex(&opts->haves.oid[i]));
+	fprintf(in, "\n");
+	fflush(in);
+	if (ferror(in)) {
+		error(_("error writing to pack-objects"));
+		fclose(in);
+		if (opts->pack_fd < 0)
+			close(cp->out);
+		if (opts->progress_fd < 0)
+			close(cp->err);
+		finish_command(cp);
+		free(generator);
+		return -1;
+	}
+	fclose(in);
+
+	generator->base.out = opts->pack_fd < 0 ? cp->out : -1;
+	generator->base.err = opts->progress_fd < 0 ? cp->err : -1;
+	generator->base.finish = odb_pack_generator_files_finish;
+
+	*out = &generator->base;
+	return 0;
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -756,6 +904,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.write_alternate = odb_source_files_write_alternate;
 	files->base.optimize = odb_source_files_optimize;
 	files->base.optimize_required = odb_source_files_optimize_required;
+	files->base.generate_pack = odb_source_files_generate_pack;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index d69f8e2d1c..e2129766fc 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -278,6 +278,23 @@ struct odb_source {
 	 */
 	bool (*optimize_required)(struct odb_source *source,
 				  const struct odb_optimize_options *opts);
+
+	/*
+	 * This callback is expected to start generating a packfile with the
+	 * given options. The pack shall be generated asynchronously so that
+	 * the caller can consume the pack data and progress output while the
+	 * pack is being generated.
+	 *
+	 * This callback is optional. Sources that cannot generate packfiles
+	 * shall leave it unset.
+	 *
+	 * The callback is expected to return 0 on success and populate the
+	 * `out` pointer with the pack generator, a negative error code
+	 * otherwise.
+	 */
+	int (*generate_pack)(struct odb_source *source,
+			     struct odb_pack_generator **out,
+			     const struct odb_generate_pack_options *opts);
 };
 
 /*
@@ -520,4 +537,20 @@ static inline bool odb_source_optimize_required(struct odb_source *source,
 	return source->optimize_required(source, opts);
 }
 
+/*
+ * Start generating a packfile from the given source with the given options.
+ * The pack is generated asynchronously; the caller is expected to consume the
+ * file descriptors exposed via the pack generator and to then wait for
+ * completion via `odb_pack_generator_finish()`.
+ *
+ * Returns 0 on success and populates the `out` pointer with the pack
+ * generator, a negative error code otherwise.
+ */
+static inline int odb_source_generate_pack(struct odb_source *source,
+					   struct odb_pack_generator **out,
+					   const struct odb_generate_pack_options *opts)
+{
+	return source->generate_pack(source, out, opts);
+}
+
 #endif

-- 
2.55.0.822.g20453c30eb.dirty

