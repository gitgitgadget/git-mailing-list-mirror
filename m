Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89635430306
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099545; cv=none; b=EqDkhB6ypVJ29s9ITOrU9kqT612bpGpSHqwsj6lTosbLKt6/jAUya7eVIQP2vRG9ZHvhbDwHePRtNvKgabLGnAyLb/oFcdddUdOqZIVWF2sVj8MVgebNfYxqrXlBnqKjSwjq2C4sH/Zk9LATYaLbbToxO12B7TUijnjDJ1z1CTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099545; c=relaxed/simple;
	bh=F+HSAPQha9MyFGfvkZn75/uQCuAdrk5UR7qCwHGPCHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jKtVRsdLxMuMDU1hXioj5gMzl9QeoZPGgbz8mjZI8vunz8gHYn3i95n4fPc/YMHkoDZ4vlJbunoWQiiIC4K8bHps1KDyDkLaZ4agnLFtKJv4vo3TWpKQYJw+O7Yeh87SywN0pdrsdW565GMOu0GOL2u1SlRkqYeViJ8hHqsn0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bLLGnVi7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gzjzNZVY; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bLLGnVi7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gzjzNZVY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96FB614000F0
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:45:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 07 Aug 2026 06:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786099542;
	 x=1786185942; bh=rT6X0vxNO6qfwwMO1kSGLgzcFrgfRcbVwYYkEBREbQw=; b=
	bLLGnVi7uMHKpjjgaXWfMY8yEYIjpcBg5rcOOeDlJY5MdTxsWFqUtAu6DADttgEA
	BrECyEUYTzxyx2g6d1H9rnwIQQGgMCoN5UrDiEg0VF/jkNkL3AWJZQi+5bi3F3rC
	93FQAwKRtkhSMUYKcgNAbNe1zpSFwA6wPV6dia/fUMXT9NWt/46TN0FNHKOKaWdQ
	PuSzv64KSl0ndqNLv6ylC+Ci7xeelF9cTkJ7VtJZSsIa6EC4G4gtOHVYhX3z/tAs
	ShCDlkRJFtPBdMPb/JpE2y95A0qRBnfr4VzUw5I22esNBVKVT9tdmRMZcQbIzA5R
	x/4ubo8xwuBV7YpeYCHOMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786099542; x=
	1786185942; bh=rT6X0vxNO6qfwwMO1kSGLgzcFrgfRcbVwYYkEBREbQw=; b=g
	zjzNZVY/S+JR35u0wFaIW6WyOmjrCpAM6eRs2BtKSPN9D8NNE20IXfKyLFDzHO1x
	zhH4zmmGv1RYOaqHKGlBwrs9QnzRdfr0xdDH07m9WDo+jU6GkYLuKpklVjkVIze7
	nh5O+v1sh1eHCNFj9Nx/dBrQfwMfeAu/kquQlVqMsahO8O6qflLBKE7FefhT6Ul8
	HPlZIKrghTu613vU6M7ZXpvaLh3SDAkZMQ6u/1GJa6u51inG7rFfTE0lRzDoDQQ7
	p5ML2gn0HFXkzSGd6+i/PgA5f8vPkx2GaMhqxoags5KH4rRqoqg/epi/2McZmHgc
	YzMqwBYEVTm9CCN0ap6PA==
X-ME-Sender: <xms:Vrd1as6jMqGzr5WF6LhPxvnAVVOwx2YcSXvwj1kLHpxA9JVVN-i7NA>
    <xme:Vrd1ak3nQm5eVNlqYVjx632BB5hX1n5NnMSOpuexrDkoXM8aBn74UTbbHCKaKK0MN
    YRsPG7D9B8NShGdGMQlGMHsvIu4p5fMuQ9z7I7pyQEcH2MxjpXFGA>
X-ME-Received: <xmr:Vrd1ahEVaovBRJUAapcGsnkbHE0mcqvF25ynFvDCHH8mZXplvBunyWXf4JXfnLR9jPli-oAmAKmoJQaEZigXy5zZYVRV5GguuZu4Pi43AqOSSQ>
X-ME-Proxy-Cause: dmFkZTGNsvSFSUECcu2Nh0FGOfZ19l5LxGfcGph13wKJT4TAzUBJREfYOszHqXAiQ3n7iU
    lqzIMoX63uJA32W3RBYcZ1/RyQqX26JNaPlBXTGD/ls9dTd0VZhbyytEvDxvkaEG0PK67L
    JGkzA9lNwINefEzvYZKwdjhramO6e3IPfqAJZG0u2o9u3xqlHWQV4mjs6csBpBWYeIfq6t
    8Z7hNK95Hh9RzVMFiF3lT8k+1IfFEkOfZOp6vFPBbw6UfNt0jStcDh7rvbhnMOCy09Xr8t
    YSyUhF+HhFTVABaqOv1R5YNe4ByqU5empe4W0yKQu/SyfLZzc4QHCbGw1hYoAGreUqXRtv
    4bS66GL1wDnZ0ZeOIE2ZPMsnG+eLvE3fX/Z4RFOdSzubaxprsAaW9uCRMrEqEUZb0grqJO
    T11+Y0Imahqy7QGucJf9dQ/9bcd0Yeln/5ls4AiEOEDT6ePujj8XaM3Ofy88darKEkUh4h
    U6OkOe4D+FPH7/KclCmvlPh4gtmoir5xVe/V2RImMFgVCPKlVi5dFoYE516to7KmsfA5sW
    FaVt/08vTO08M2jACMJu3CfhJ3RQ7PWVRR/qLQpoyP+VMtSrnLvXE8TcRvhR0UzwC8eA28
    wbevQ8cGvbSfqx3xfVhVI9JLCZwvhKSaqDFAlBvXbUmjm16aZyk+4Pu689QQ
X-ME-Proxy: <xmx:Vrd1amS_OT0eaGz1zTUC_ck29kj-3OmWPsQtP4FOREnm_RhZxcnJIA>
    <xmx:Vrd1agBL37wWfA7p3F-_dGQqogQ8Tcscbum_2s1jLTiWiUXk5Mrjww>
    <xmx:Vrd1au3bH-4P4AUTI5xaZovuS0JbsKxZVrelqOPQmX8T9k20ugba2Q>
    <xmx:Vrd1amWbolaREy_oiwT0bNUzrQbHfR2qYM56OVpHsGZ6kYyMRXF5Lw>
    <xmx:Vrd1atavbJrmu6TrdbrN6Rd3oB1OQt5C7aVck8Y2pr9BDBYZfaqo8QjP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 7 Aug 2026 06:45:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a4dfc6a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 7 Aug 2026 10:45:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 12:45:07 +0200
Subject: [PATCH 1/5] odb: introduce interface to generate packfiles
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-b4-pks-odb-generate-pack-v1-1-7dec431ae7cd@pks.im>
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
In-Reply-To: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
To: git@vger.kernel.org
Cc: 
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
 odb/source-files.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++
 odb/source.h       |  33 ++++++++++++
 4 files changed, 350 insertions(+)

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
index 5a68af7d84..64a0417be7 100644
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
@@ -729,6 +730,148 @@ int odb_source_files_optimize(struct odb_source *source,
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
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct odb_pack_generator_files *generator;
+	FILE *in;
+
+	/*
+	 * The hook is expected to spawn "$hook git pack-objects <args...>"
+	 * and to behave like git-pack-objects(1) would have. This can for
+	 * example be used to serve precomputed packfiles.
+	 */
+	if (opts->pack_objects_hook) {
+		strvec_push(&cp.args, opts->pack_objects_hook);
+		strvec_push(&cp.args, "git");
+		cp.use_shell = 1;
+	} else {
+		cp.git_cmd = 1;
+	}
+
+	/*
+	 * The caller-provided shallow boundary overrides any shallow state
+	 * that the repository itself may have, so the shallow file needs to
+	 * be neutralized.
+	 */
+	if (opts->shallows.nr) {
+		strvec_push(&cp.args, "--shallow-file");
+		strvec_push(&cp.args, "");
+	}
+	strvec_push(&cp.args, "pack-objects");
+	strvec_push(&cp.args, "--revs");
+	strvec_push(&cp.args, "--stdout");
+	if (opts->thin)
+		strvec_push(&cp.args, "--thin");
+	if (opts->shallow)
+		strvec_push(&cp.args, "--shallow");
+	if (opts->ofs_delta)
+		strvec_push(&cp.args, "--delta-base-offset");
+	if (opts->include_tag)
+		strvec_push(&cp.args, "--include-tag");
+	if (opts->missing_allow_promisor)
+		strvec_push(&cp.args, "--missing=allow-promisor");
+	if (opts->disable_bitmaps)
+		strvec_push(&cp.args, "--no-use-bitmap-index");
+	switch (opts->progress) {
+	case ODB_GENERATE_PACK_PROGRESS_NONE:
+		strvec_push(&cp.args, "--quiet");
+		break;
+	case ODB_GENERATE_PACK_PROGRESS_STANDARD:
+		strvec_push(&cp.args, "--progress");
+		break;
+	case ODB_GENERATE_PACK_PROGRESS_VERBOSE:
+		strvec_push(&cp.args, "--all-progress");
+		break;
+	default:
+		BUG("unknown progress option %d", opts->progress);
+	}
+	if (opts->filter_spec)
+		strvec_pushf(&cp.args, "--filter=%s", opts->filter_spec);
+	if (opts->uri_protocols)
+		for (size_t i = 0; i < opts->uri_protocols->nr; i++)
+			strvec_pushf(&cp.args, "--uri-protocol=%s",
+				     opts->uri_protocols->items[i].string);
+
+	cp.in = -1;
+	cp.out = opts->pack_fd;
+	cp.err = opts->progress_fd;
+	cp.clean_on_exit = 1;
+
+	if (start_command(&cp))
+		return error(_("could not spawn pack-objects"));
+
+	/*
+	 * Feed the objects to pack-objects. This is safe to do synchronously
+	 * because pack-objects consumes all of its standard input before it
+	 * starts to generate the pack.
+	 */
+	in = xfdopen(cp.in, "w");
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
+			close(cp.out);
+		if (opts->progress_fd < 0)
+			close(cp.err);
+		finish_command(&cp);
+		return -1;
+	}
+	fclose(in);
+
+	CALLOC_ARRAY(generator, 1);
+	generator->base.out = opts->pack_fd < 0 ? cp.out : -1;
+	generator->base.err = opts->progress_fd < 0 ? cp.err : -1;
+	generator->base.finish = odb_pack_generator_files_finish;
+	generator->cp = cp;
+
+	*out = &generator->base;
+	return 0;
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -756,6 +899,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
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
2.55.0.679.g6767b8d81c.dirty

