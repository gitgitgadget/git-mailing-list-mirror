Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE682882B7
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097336; cv=none; b=Bsbvnz7W22prKROa+LCJdhFw/kTKYZ6bSTl3ZRwZcUDrl67w5cR9IpIqiQkvVeJjDHhGilsSv4aMWq29WPM9SpuCcXZ13dMbDWlHKEU9DrUfVGkhN0Jsr4rsZds/rdngytlZNYvS1NNb2ZotUSp8m8D9+QgKe7b0kO6yf9mx+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097336; c=relaxed/simple;
	bh=eVP7aRNBW38reVpRBMDmwRgm69G5XJYZWQQJ/39VWwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVEtehgWt5nedcXjuKGENlvMfVyt1+0HFYdc7J7VBQwVUyZVfuFIXCYJ1ktnaMqUvk5UdG+hzjFRHXJrsoZI6lsNi1RLdSvXj6oytNIgc+7xae4KYto7ZfnPLKR/5WRe/z3fdSxV2O4kVTxIjD5WchtTDyYtfBwPfQGBXFx0oVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=DODBZuOe; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="DODBZuOe"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-72ce9790ab3so42297867b3.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097333; x=1759702133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PjR3hjy6kCq1om0VSzBFl/Hm5fmViX3Y8uqYi0jOSN4=;
        b=DODBZuOe+Gmona0CKTk9XH28uIlpECUV4JhkbhNsTNre6aUKGCsu2VKYrvqU5Y46zY
         0Zuup6x5OksKooo1G4PBRlROwZcZi+OxibtEF0hRQPfxqYhFUPoaH+8T4H34pZ8Pp8wn
         wXNKcOk8iRpBBvJ+bgBUNF97nyv3VOi9pn3oHLxJwsZqt7bmOtbCnk7179ivumO0kjFY
         BrfUvyces1AQJTcFGW7sb4xFMhfXfkXgATvqQnEovMvU6/STbHPHuXAyHQY9vj12XWpG
         iIDcYpKskH1bZ0o9sAVEHz1tWIh2OLbBXYkOzuf25sV+EWDmGgFyW1KpgTUE4Upf7j0L
         VKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097333; x=1759702133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjR3hjy6kCq1om0VSzBFl/Hm5fmViX3Y8uqYi0jOSN4=;
        b=XVIItf4fsEIntUqHPQnmBLRghimeUGwtIFl9JR4U5/afkK/qK7SbnzEmC5ubVWOQzx
         +chPDAvhpBt7uC6NUjHqg8bl+IytdwNvtaZEX3Yg5jEeoNOVJn7qSMdgYjAapTyJb5tL
         DYQ+OGOvwmgiWF+XeDcNySilScRdJ72v5gNmAnZAkXbBRrhtXIuS9JlsvpJ6aJK+g1Gr
         EFRi0mcMIJHkmqv3SSlKtr8Exo9MwQ8TgIeSxE9c3GLTGkdUrJJHmJY7zuuQwIwgHPDU
         IaJFON2OkmLVskb0HhZRlrrPyqgf3hRioBjQGH9bXFPibtj7dccxFO9sKtJ6JXhOXjsI
         Hj0A==
X-Gm-Message-State: AOJu0YwD/qLZOjkeeCr2Kw7xu3K1cm4QsjyWCmzddEf0Xkun4o89TeST
	vnkLgWOYRyf5LlJ6jeEh9Wb7oUTwRXeDDNhI5lS3d1uPhH+cLrYpsnVioNcA1QyZj0nmwmVNbqn
	Xfr+h1Ys=
X-Gm-Gg: ASbGncteWwPrpbrPabwEP29n//E5j5dhN7s786J+ToXWJp6O9mlI4gxiRCBBR7woLZz
	WdsHAZ/BZrNVeofxS9Flokv6K7wXt25eE0nj2WOTzXw3VBJu8TIaGYA3BMSeO8oOQWjjQjT5VIk
	gBPw9TVEcMP1VXsKT4kjbLa9U0GON8AbT8iQeis3mWg8bSmsF1pCDv5kQ/eYUxkcY7fkGc0ftej
	pIxzwr011wdanMe+WKIL89R8sOrjCrXHl9dKTbBWmtTb2eQHnUG7eUpwyJ7K3VV/oppE2gWQ4wF
	uekJByjDDUS0SFHDEZMQYR8uB/xIDIvKd8vSwxVLy/mphkWdg4WBN2tCA59oKtKrthtjzY8w6a8
	ymKPZJArmgBN0RLffl7Pm/R24QYjjHc7g6gay0afVRAkwuv7OOytHVGCvKmvMYlssfk1SIA/xZl
	q/x2G4wrSPodmAu+GiynRUjLDdNA==
X-Google-Smtp-Source: AGHT+IGg6mhiBpuxAj4zjtdwbUdMA6Cr+QV1ONW5SLgIpfk28JEOXsI5eAGoFwih2a/fJys8j16yFw==
X-Received: by 2002:a05:690c:9a08:b0:724:6d3d:67fc with SMTP id 00721157ae682-763f83967a4mr135460387b3.8.1759097333231;
        Sun, 28 Sep 2025 15:08:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-636d5b1d908sm1927371d50.22.2025.09.28.15.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:08:52 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:08:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 26/49] builtin/repack.c: remove "repack_promisor_objects()"
 from the builtin
Message-ID: <3ba6e86f6116cc42fc8f7d31707dd514f4bc16a4.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

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
index b220f0f7d8..0a73f8adaf 100644
--- a/Makefile
+++ b/Makefile
@@ -1137,6 +1137,7 @@ LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += refspec.o
 LIB_OBJS += remote.o
 LIB_OBJS += repack.o
+LIB_OBJS += repack-promisor.o
 LIB_OBJS += replace-object.o
 LIB_OBJS += repo-settings.o
 LIB_OBJS += repository.o
diff --git a/builtin/repack.c b/builtin/repack.c
index ca7658e38f..18c3df7200 100644
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
index 8ab287a2ed..ca5603b456 100644
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
index 0000000000..8bf42fc715
--- /dev/null
+++ b/repack-promisor.c
@@ -0,0 +1,102 @@
+#include "git-compat-util.h"
+#include "repack.h"
+#include "run-command.h"
+#include "hex.h"
+#include "repository.h"
+#include "packfile.h"
+#include "path.h"
+#include "pack.h"
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
2.51.0.243.g16eca91f2c0

