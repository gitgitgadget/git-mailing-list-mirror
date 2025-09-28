Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D10519C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097277; cv=none; b=YJVlhB9S5ylH5STXtAXUjjsaKWTrXHQE3yn6jBAeDfZMBzIZ2UrJSC8RiDidCT9pEpNn5k2CkkRi/Q2Qu8S6jUlYEezA5FZffbqtfUe2t+iWCAC0A5GgfcJQw6hSETOekTzx3a0+CTyC7SMp7f/t54F7sNzZoi1N7Ai2XIoZamg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097277; c=relaxed/simple;
	bh=8YWMcigOphK9imbH+cpi6DAg1Sf3ApKdF5hvr5eBZzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEcdVuf+rhi0aot/uNxc5cS3oQ3r19QZoXrBuNadUYpqbKXWWXRfwQqMM45WjqVqRuVKhfAZuEBJoAreaLgvTpYEw2EckstnqgwRJYePNkPfZ7AWn0+YgOFMo4I5BYsZaDuslRoaAnY2bvSbfIs1mEmh6/jZ39kgzX+dXmUDS/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=nS+1h8fj; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="nS+1h8fj"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-77636fb28f6so7953477b3.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097275; x=1759702075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=peteeGN20LmvzT7yNMHBLjDmlDbPthJJZkKe+3GyYiI=;
        b=nS+1h8fjzRCkLilXvS1SwQ0QQWuVHHlIwpS73YPFmJrR3QxoWBgF2ycNnxDCx4jMe0
         fI0vBt9Lhu9VRgd3Oc4JHgZf+PVDnImCnglblJYIfd58CynN0bTpYoZngEKubgKB7Zvy
         Hr18CRKGGf/dppLc0P4QTKNssu7IsbTOuW2/Mx2EPi12n+fF0MH9yqfH/YYWpgV21F3p
         uDbvx8v25yXXjtkoUgyz/89yKkRLXKnmlP0ZsZEIS8+AmBkgyRlK6EF0CsjzSiUhFzYc
         aZVgF5s7NqSTihjGaf4PCo39ATzN7ZAZIUzCazQZiqyKSskteC3pNCcPCS92z+cAphLN
         OOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097275; x=1759702075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peteeGN20LmvzT7yNMHBLjDmlDbPthJJZkKe+3GyYiI=;
        b=VjCdGzUdhzwlQ9lYUIn3EOKwkqSCZMEwX8a50h2ej5IN07eg8JrK6gJZcqiw5okGiu
         dV32GeMNanSTFBeedZy11ii9kpuvZx/Ox3JF0Rj3Go623n2BgE9YJqLaFfzN7/Tc6LSF
         Fmua8sVdDveq39pM4u2t4ZdMe9PkUEQNZgoR+EgTWIcFuxJ/8KifKnJIkBR3dizvOrHO
         XSkjMbPK8LgfzA/4YVi1QiEHM81yloLAQhETlbWrUip+DbpQZmYlGKdsJyk9Yi+7hFGP
         ccrtkvGGmqHGugezVdy5LkpQfIQbcD4z0RJNNJuJb+8OFU57O5oFjb0AlgqcSUfb+WK1
         Mohg==
X-Gm-Message-State: AOJu0YxCezIedd/CAOOE96TioxaYJqIybUHFG+yN+jOlOfZkB6MBiVOV
	PNsyGiiQJdgZ6hf3fsWSQWFnM2ijttyrUrlSPMC1qQ4V33gBL+JyXxSZSByctL+0QGknEWceuZq
	dTDfsoSM=
X-Gm-Gg: ASbGnctGfgdlVTfGGCgvMAoJSwt5W/nWRWd+HcP3zdNrW/U8nenHtyEb2YtdEAjDOf3
	/P8JjIwnCSUMfVddFrULBbaPCUlt3RCbnK5ytRQCSSAUYb0186KXQCWe2hVo2WJKu6KAQrFoYwb
	x/PwuzH+Z/gHSKJJj/xCV54GQY17Fv+hygeS3W0sunk6ni++2C2bBO7FaZoBbL9ZNe0HGlQEry9
	GfSv65vHyxF6a9Wgb6g+7CbNNEw8s1GDGuN7URy8p+SkTiwpcIsTLSKbUnKJ+t/uT64rjo9Jk6q
	x2lMwT4jt96+it/gRZd19enIbBibDEkhpOnLlhFdf4Tfsq3DkyUcTHN4XaWKlzbMEzKwSxTXguk
	mFIiF8/dJBEYsVUoTnnqp34vmYWI86Iohi5B3erfHlfMkXb+gWPbrNtd1GNMlqDGbAHS+IXrJBp
	kldmk78i5lGYNAWQNvOIr+8bhIcssTo4xq8iNl
X-Google-Smtp-Source: AGHT+IENQbtrtkXd9Mn0ilixSGMAdu5QFhNQWo6kwWuaketnKEapdt/aSIfd4dPdOE1sxSOg+m0WHg==
X-Received: by 2002:a05:690c:6ac1:b0:77a:3162:44de with SMTP id 00721157ae682-77a31624710mr34985517b3.45.1759097275148;
        Sun, 28 Sep 2025 15:07:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-765bb916b6fsm22828307b3.15.2025.09.28.15.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:07:54 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:07:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 11/49] repack: introduce new compilation unit
Message-ID: <fe3328eb3d8202f8fa8cbef11cca215ace8b2285.1759097191.git.me@ttaylorr.com>
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

Over the years, builtin/repack.c has turned into a grab-bag of
functionality powering the 'git repack' builtin. Among its many
capabilities, it:

 - can build and spawn 'git pack-objects' commands, which in turn
   generate new packs
 - has infrastructure to manage the set of existing packs in a
   repository
 - has infrastructure to split a sequence of packs into a geometric
   progression based on object size
 - can manage both generating and combining cruft packs together
 - can write new MIDXs

to name a few.

As a result, this builtin has accumulated a lot of code, making adding
new functionality difficult. In the future, 'repack' will learn how to
manage a chain of incremental MIDXs, adding yet more functionality into
the builtin.

As a prerequisite step, let's first move some of the functionality in
the builtin into its own repack.[ch].

This will be done over the course of many steps, since there are many
individual components, some of which will end up in other, yet-to-exist
compilation units of their own. Some of the code movement here is also
non-trivial, so performing it in individual steps will make it easier to
verify.

Let's start by migrating 'struct pack_objects_args' (and the related
corresponding pack_objects_args_release() function) into repack.h, and
teach both the Makefile and Meson how to build the new compilation unit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile         |  1 +
 builtin/repack.c | 25 +------------------------
 meson.build      |  1 +
 repack.c         | 11 +++++++++++
 repack.h         | 23 +++++++++++++++++++++++
 5 files changed, 37 insertions(+), 24 deletions(-)
 create mode 100644 repack.c
 create mode 100644 repack.h

diff --git a/Makefile b/Makefile
index 555b7f4dc3..b220f0f7d8 100644
--- a/Makefile
+++ b/Makefile
@@ -1136,6 +1136,7 @@ LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += refspec.o
 LIB_OBJS += remote.o
+LIB_OBJS += repack.o
 LIB_OBJS += replace-object.o
 LIB_OBJS += repo-settings.o
 LIB_OBJS += repository.o
diff --git a/builtin/repack.c b/builtin/repack.c
index 0d35f15b4b..6dfcb3327e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -19,6 +19,7 @@
 #include "prune-packed.h"
 #include "odb.h"
 #include "promisor-remote.h"
+#include "repack.h"
 #include "shallow.h"
 #include "pack.h"
 #include "pack-bitmap.h"
@@ -53,21 +54,6 @@ static const char incremental_bitmap_conflict_error[] = N_(
 "--no-write-bitmap-index or disable the pack.writeBitmaps configuration."
 );
 
-struct pack_objects_args {
-	char *window;
-	char *window_memory;
-	char *depth;
-	char *threads;
-	unsigned long max_pack_size;
-	int no_reuse_delta;
-	int no_reuse_object;
-	int quiet;
-	int local;
-	int name_hash_version;
-	int path_walk;
-	struct list_objects_filter_options filter_options;
-};
-
 static int repack_config(const char *var, const char *value,
 			 const struct config_context *ctx, void *cb)
 {
@@ -116,15 +102,6 @@ static int repack_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
-static void pack_objects_args_release(struct pack_objects_args *args)
-{
-	free(args->window);
-	free(args->window_memory);
-	free(args->depth);
-	free(args->threads);
-	list_objects_filter_release(&args->filter_options);
-}
-
 struct existing_packs {
 	struct repository *repo;
 	struct string_list kept_packs;
diff --git a/meson.build b/meson.build
index e8ec0eca16..8ab287a2ed 100644
--- a/meson.build
+++ b/meson.build
@@ -462,6 +462,7 @@ libgit_sources = [
   'reftable/tree.c',
   'reftable/writer.c',
   'remote.c',
+  'repack.c',
   'replace-object.c',
   'repo-settings.c',
   'repository.c',
diff --git a/repack.c b/repack.c
new file mode 100644
index 0000000000..a1f5b796fb
--- /dev/null
+++ b/repack.c
@@ -0,0 +1,11 @@
+#include "git-compat-util.h"
+#include "repack.h"
+
+void pack_objects_args_release(struct pack_objects_args *args)
+{
+	free(args->window);
+	free(args->window_memory);
+	free(args->depth);
+	free(args->threads);
+	list_objects_filter_release(&args->filter_options);
+}
diff --git a/repack.h b/repack.h
new file mode 100644
index 0000000000..421d439d5a
--- /dev/null
+++ b/repack.h
@@ -0,0 +1,23 @@
+#ifndef REPACK_H
+#define REPACK_H
+
+#include "list-objects-filter-options.h"
+
+struct pack_objects_args {
+	char *window;
+	char *window_memory;
+	char *depth;
+	char *threads;
+	unsigned long max_pack_size;
+	int no_reuse_delta;
+	int no_reuse_object;
+	int quiet;
+	int local;
+	int name_hash_version;
+	int path_walk;
+	struct list_objects_filter_options filter_options;
+};
+
+void pack_objects_args_release(struct pack_objects_args *args);
+
+#endif /* REPACK_H */
-- 
2.51.0.243.g16eca91f2c0

