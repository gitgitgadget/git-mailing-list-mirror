Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5045C3081C5
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567320; cv=none; b=iSaMNXKk8G3h25CAOVRfFEI+QG18UtSbdXfY/Rgy6pNFUXHhD7MFos1flyKi4hKrChEzsaQxqqVxYIEQEjR/J25b8LCEAFuZXEUxxRobhHDStv/lC/9k6J+b+63qBcegcWEZORQ1AldtxcDkCnH+ykXO9R24ccEQoERs6rM/PRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567320; c=relaxed/simple;
	bh=RN3Rt7SSTBwT0lIEMnfJ6Hl7zGKjEAUVtZr05U+pBSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPwpq/w7+z+FtMeoY9AHLnBmFwjFh+Ibwo8tShgkn3lgd3u8tBTsIvrR5EGewSQtsR7bZrCrKNDAxpBnJ2jZ1yw0yVKyqxnzvwbsCRPjaN5a7+OTQ+r85s3Sao852t4+EOzd1n/awyRAi5AU0YofNk81mHT6WDoNM08ZWobPulU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=FJyAcza0; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="FJyAcza0"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-780fe73e339so519637b3.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567317; x=1761172117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjkBOwfEx4mVXQDQdNSK2HOYll+j2T16lsw/wGj+AK0=;
        b=FJyAcza0+8fqbdvqVS/XQCuG3+1OcpZEvRpsa2e+ZGtDeE54gxQSKWqf0EY2jLRKMn
         woYP3THwtryep8c/xKeaTYW8YO96Olb4DIHyuZc+JKisNgWa2GbQXv/OhGgC5OVKn0Kk
         PZiZzwv/wYkoo79Cqy75Juzb4QU9wDn+TCp1MVPUScBOYZvnIwhK/CZjIH2Ah8Q3Irls
         bIgukfjG9cHdcJUkFqe+HWcJO2ynaI0LVwbNyBoeFOklwXPQLbajjt3E3xVXJ1SwkwV2
         LIjO+71YoJBQFT+f1h4Mil0b44o6Vt5MMBQNsxNfTlfajY7Z0lwaChpIxyq7aFStC5Hn
         xC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567317; x=1761172117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjkBOwfEx4mVXQDQdNSK2HOYll+j2T16lsw/wGj+AK0=;
        b=HI+pfaUP4dYfqbphWKi5swoGi2dGRJ5PRaiGBAy6Z/W90/h8oaDyjYH+ICCgj9sziB
         XjNHAeB6KUOgApxDtVQN6SlIJhszUG3S1iKtmeJkAya+nE4ig8wsLCg7oMXt+enYDeIw
         EyWyZm7DVwDE1Bt/6hpI7dsevK+xa0uJVAR7hjr363zaWjT6CwMhIXGcwr0MEy9Q905l
         t5vw754L5IoOKk9iWOwoiUHCc+LozihgeUV5mF03zSehnX6ZMLZnlO546apXUWMqzWsD
         0Q4Zbjm9rGn9jr2C/ccvIT13vUXu4bOaQDZiAGt5R7Lc6jqq5O0kNm1F4hEU1BviRAWf
         wQrw==
X-Gm-Message-State: AOJu0YwGHbYQfh79x5cc/nau00j3O3PUh9Ne5FKZMJxkcuDJoXU5Yx6T
	+MKMNn1q+exa4bV49KnSaPnmpj96JlV/WX9wyy4jmt7T+r64LlWghChjYmeg8NwWdYe3aWXmHae
	VNmYZjt8tuxRf
X-Gm-Gg: ASbGncsy6CfexmmLqhqvaCISAgHhlVC5iJWgferf4gEAU4coQpPXX3/x0dPIgccCZFD
	oUs3jKMqRJz9oYD4jsZthnuwbYvwDLSSfhOOdK5dlpbK66GuY+siiuXuX3dl9/XO/NQf1/VfJdp
	VumfzUzi7n95fRVFC9QSJaJhR8/RV2cWZnkEqHXkK2xlXNbKVj7WXUn4d10FOor4CMAbU83KkSr
	Uxi+eEJf5W2btsHAMroHy32tFUOC+U6H232NC3ubNpVsnYd9m8RazF7j+ibpolbDiMAAUWe4YRG
	UJvlOaRb3ElNxlLzaf60LeXSvdrIavIOQ8FLtoN0Z4BYNsdQks+9ekQQza17/kcaX1ULiAFImq1
	5SxrMXW/BNofnFFyOavH1HvQLz+pDoTS3KkUyWPmwv3mGEBkvU8cGjz7p4YgGNV0806BQ3DCsVh
	jjZE9o8VBsWTSzE3fwaxwB4G5fd86rQw4N7PsLEZ5qgQ+cwCEsOu/7OpPNgiUZMnQBwx44HVN89
	wqv4drnTw/1uZ6tQA==
X-Google-Smtp-Source: AGHT+IFGBRegE2ckH7ETUq96Gvy4VfQyOSOjOIrogWJfxzgm6vnQXkgF1RpC68758bk+MdqPBoSMqg==
X-Received: by 2002:a05:690c:3392:b0:736:9b6b:b60 with SMTP id 00721157ae682-782a90b3336mr8270477b3.1.1760567317109;
        Wed, 15 Oct 2025 15:28:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-782931f5d47sm2583987b3.43.2025.10.15.15.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:36 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 26/49] builtin/repack.c: remove
 "repack_promisor_objects()" from the builtin
Message-ID: <1050b856a5414a79cca49d3beb569c85734c7f89.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

Now that we have properly factored the portion of the builtin which is
responsible for repacking promisor objects, we can move that function
(and associated dependencies) out of the builtin entirely.

Similar to previous extractions, this function is declared in repack.h,
but implemented in a separate repack-promisor.c file. This is done to
separate promisor-specific repacking functionality from generic repack
utilities (like "existing_packs", and "generated_pack" APIs).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile          |   1 +
 builtin/repack.c  |  95 ------------------------------------------
 meson.build       |   1 +
 repack-promisor.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++
 repack.h          |   4 ++
 5 files changed, 108 insertions(+), 95 deletions(-)
 create mode 100644 repack-promisor.c

diff --git a/Makefile b/Makefile
index 58fc05030b..01597af359 100644
--- a/Makefile
+++ b/Makefile
@@ -1250,6 +1250,7 @@ LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += refspec.o
 LIB_OBJS += remote.o
 LIB_OBJS += repack.o
+LIB_OBJS += repack-promisor.o
 LIB_OBJS += replace-object.o
 LIB_OBJS += repo-settings.o
 LIB_OBJS += repository.o
diff --git a/builtin/repack.c b/builtin/repack.c
index 2c67111b33..24b5e5049b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -107,101 +107,6 @@ static int repack_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
-struct write_oid_context {
-	struct child_process *cmd;
-	const struct git_hash_algo *algop;
-};
-
-/*
- * Write oid to the given struct child_process's stdin, starting it first if
- * necessary.
- */
-static int write_oid(const struct object_id *oid,
-		     struct packed_git *pack UNUSED,
-		     uint32_t pos UNUSED, void *data)
-{
-	struct write_oid_context *ctx = data;
-	struct child_process *cmd = ctx->cmd;
-
-	if (cmd->in == -1) {
-		if (start_command(cmd))
-			die(_("could not start pack-objects to repack promisor objects"));
-	}
-
-	if (write_in_full(cmd->in, oid_to_hex(oid), ctx->algop->hexsz) < 0 ||
-	    write_in_full(cmd->in, "\n", 1) < 0)
-		die(_("failed to feed promisor objects to pack-objects"));
-	return 0;
-}
-
-static void repack_promisor_objects(struct repository *repo,
-				    const struct pack_objects_args *args,
-				    struct string_list *names,
-				    const char *packtmp)
-{
-	struct write_oid_context ctx;
-	struct child_process cmd = CHILD_PROCESS_INIT;
-	FILE *out;
-	struct strbuf line = STRBUF_INIT;
-
-	prepare_pack_objects(&cmd, args, packtmp);
-	cmd.in = -1;
-
-	/*
-	 * NEEDSWORK: Giving pack-objects only the OIDs without any ordering
-	 * hints may result in suboptimal deltas in the resulting pack. See if
-	 * the OIDs can be sent with fake paths such that pack-objects can use a
-	 * {type -> existing pack order} ordering when computing deltas instead
-	 * of a {type -> size} ordering, which may produce better deltas.
-	 */
-	ctx.cmd = &cmd;
-	ctx.algop = repo->hash_algo;
-	for_each_packed_object(repo, write_oid, &ctx,
-			       FOR_EACH_OBJECT_PROMISOR_ONLY);
-
-	if (cmd.in == -1) {
-		/* No packed objects; cmd was never started */
-		child_process_clear(&cmd);
-		return;
-	}
-
-	close(cmd.in);
-
-	out = xfdopen(cmd.out, "r");
-	while (strbuf_getline_lf(&line, out) != EOF) {
-		struct string_list_item *item;
-		char *promisor_name;
-
-		if (line.len != repo->hash_algo->hexsz)
-			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
-		item = string_list_append(names, line.buf);
-
-		/*
-		 * pack-objects creates the .pack and .idx files, but not the
-		 * .promisor file. Create the .promisor file, which is empty.
-		 *
-		 * NEEDSWORK: fetch-pack sometimes generates non-empty
-		 * .promisor files containing the ref names and associated
-		 * hashes at the point of generation of the corresponding
-		 * packfile, but this would not preserve their contents. Maybe
-		 * concatenate the contents of all .promisor files instead of
-		 * just creating a new empty file.
-		 */
-		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
-					  line.buf);
-		write_promisor_file(promisor_name, NULL, 0);
-
-		item->util = generated_pack_populate(item->string, packtmp);
-
-		free(promisor_name);
-	}
-
-	fclose(out);
-	if (finish_command(&cmd))
-		die(_("could not finish pack-objects to repack promisor objects"));
-	strbuf_release(&line);
-}
-
 struct pack_geometry {
 	struct packed_git **pack;
 	uint32_t pack_nr, pack_alloc;
diff --git a/meson.build b/meson.build
index 4a985ce77e..b37e3d192d 100644
--- a/meson.build
+++ b/meson.build
@@ -463,6 +463,7 @@ libgit_sources = [
   'reftable/writer.c',
   'remote.c',
   'repack.c',
+  'repack-promisor.c',
   'replace-object.c',
   'repo-settings.c',
   'repository.c',
diff --git a/repack-promisor.c b/repack-promisor.c
new file mode 100644
index 0000000000..ee6e0669f6
--- /dev/null
+++ b/repack-promisor.c
@@ -0,0 +1,102 @@
+#include "git-compat-util.h"
+#include "repack.h"
+#include "hex.h"
+#include "pack.h"
+#include "packfile.h"
+#include "path.h"
+#include "repository.h"
+#include "run-command.h"
+
+struct write_oid_context {
+	struct child_process *cmd;
+	const struct git_hash_algo *algop;
+};
+
+/*
+ * Write oid to the given struct child_process's stdin, starting it first if
+ * necessary.
+ */
+static int write_oid(const struct object_id *oid,
+		     struct packed_git *pack UNUSED,
+		     uint32_t pos UNUSED, void *data)
+{
+	struct write_oid_context *ctx = data;
+	struct child_process *cmd = ctx->cmd;
+
+	if (cmd->in == -1) {
+		if (start_command(cmd))
+			die(_("could not start pack-objects to repack promisor objects"));
+	}
+
+	if (write_in_full(cmd->in, oid_to_hex(oid), ctx->algop->hexsz) < 0 ||
+	    write_in_full(cmd->in, "\n", 1) < 0)
+		die(_("failed to feed promisor objects to pack-objects"));
+	return 0;
+}
+
+void repack_promisor_objects(struct repository *repo,
+			     const struct pack_objects_args *args,
+			     struct string_list *names, const char *packtmp)
+{
+	struct write_oid_context ctx;
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	FILE *out;
+	struct strbuf line = STRBUF_INIT;
+
+	prepare_pack_objects(&cmd, args, packtmp);
+	cmd.in = -1;
+
+	/*
+	 * NEEDSWORK: Giving pack-objects only the OIDs without any ordering
+	 * hints may result in suboptimal deltas in the resulting pack. See if
+	 * the OIDs can be sent with fake paths such that pack-objects can use a
+	 * {type -> existing pack order} ordering when computing deltas instead
+	 * of a {type -> size} ordering, which may produce better deltas.
+	 */
+	ctx.cmd = &cmd;
+	ctx.algop = repo->hash_algo;
+	for_each_packed_object(repo, write_oid, &ctx,
+			       FOR_EACH_OBJECT_PROMISOR_ONLY);
+
+	if (cmd.in == -1) {
+		/* No packed objects; cmd was never started */
+		child_process_clear(&cmd);
+		return;
+	}
+
+	close(cmd.in);
+
+	out = xfdopen(cmd.out, "r");
+	while (strbuf_getline_lf(&line, out) != EOF) {
+		struct string_list_item *item;
+		char *promisor_name;
+
+		if (line.len != repo->hash_algo->hexsz)
+			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
+		item = string_list_append(names, line.buf);
+
+		/*
+		 * pack-objects creates the .pack and .idx files, but not the
+		 * .promisor file. Create the .promisor file, which is empty.
+		 *
+		 * NEEDSWORK: fetch-pack sometimes generates non-empty
+		 * .promisor files containing the ref names and associated
+		 * hashes at the point of generation of the corresponding
+		 * packfile, but this would not preserve their contents. Maybe
+		 * concatenate the contents of all .promisor files instead of
+		 * just creating a new empty file.
+		 */
+		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
+					  line.buf);
+		write_promisor_file(promisor_name, NULL, 0);
+
+		item->util = generated_pack_populate(item->string, packtmp);
+
+		free(promisor_name);
+	}
+
+	fclose(out);
+	if (finish_command(&cmd))
+		die(_("could not finish pack-objects to repack promisor objects"));
+	strbuf_release(&line);
+}
diff --git a/repack.h b/repack.h
index f37eb49524..19dc4fd738 100644
--- a/repack.h
+++ b/repack.h
@@ -74,4 +74,8 @@ int generated_pack_has_ext(const struct generated_pack *pack, const char *ext);
 void generated_pack_install(struct generated_pack *pack, const char *name,
 			    const char *packdir, const char *packtmp);
 
+void repack_promisor_objects(struct repository *repo,
+			     const struct pack_objects_args *args,
+			     struct string_list *names, const char *packtmp);
+
 #endif /* REPACK_H */
-- 
2.51.0.540.ga7423965ad8

