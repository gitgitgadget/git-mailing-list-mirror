Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844AE3081C2
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567277; cv=none; b=n+BLF3RQHul55gd/zEEI6LoNabkNfadgEjCYbDU5to6MAqS0bzQ83numboNN2oZxFZZJauf3Qckxgq0r7asn3So37Zhbk4P5GqRwPbmexIRr1LQYZOM4IruBnrlHRh6p+zocjgQCeeY3iXEs6Jhv6MtFfObiygDwdUq0qxw2FTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567277; c=relaxed/simple;
	bh=MFrj5cLy7+feVcb7u8HLY0fwSKS9ihloSk7F/Rx+eIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDUhRddC1GHY5Ay73PQynm5ppLOaD1Y7gTvge51AvWpXSqhVGfM9dIIOQqwVqDK8CRqrg0FGvhII76sRJhbKypWOVnExgLSy0+NRygCt7droHIevux8WzW9/8Jmyr6Jyn3Rh/sec9lXkj8Dk0yS3flhWBYq9lytYzMeaiNbdnks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=GnyCqG8A; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="GnyCqG8A"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7815092cd06so920837b3.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567274; x=1761172074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg7yHBnkjuZ01/EIMMDktV7B7AUJ+j8vJ/ax6hsK8/U=;
        b=GnyCqG8AbQcBqLwqjeg2cxyPEl8t44bIdHRJYRvf5k+bRUj8udDkQhbWXSHf9bXuCB
         Xk/58nOSm9R87/UPzFAoZV5Xkff+iMXskgM61GNmyoOGXA2Y/uV8RCLipWncHmIbxPE8
         zPTCb4Z+WwBZbqItHCRjmj+DaTxMHY7TGZlOAFbfl517ryUGj9ucDwIu2jHM2KE7wzCh
         zE0m2u2DjlyM2DExyO+fM1YQjeO5jQ7nOeWlBeHlqCpJyG1e1cIG3e/XLaRtz7ollvMv
         TDgL12k4t7JBvu6unK71ka1OMAG+nhb3YPYdn5oHyyI8lnoQg5ZPesLvNYCoNwwOysZx
         d6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567274; x=1761172074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vg7yHBnkjuZ01/EIMMDktV7B7AUJ+j8vJ/ax6hsK8/U=;
        b=jGgZLfZnCWv3zUceb/CqAC8KwpGaOJIc4fFmUkU4311tf4Tnf8Nyc0eV/ioW8a12jU
         Q98yVjM95L3BtuqIYBdDsyb839Pi5wSzF9blyuu5lmeJleSshFfyuUxImm8Awl2+Bk/3
         yBn38dHHkxhie9zIM+BvvH/ktklrVQ/aGp91FQDqkoUNstK546XUPQ/3i/VHrC3nRhKJ
         Gk3ap7y24emEvjbBc79Dinyk6ohvLemooLHSjz7GjqHrJSCoEmuID1OgZ/yYPpiNZJoW
         vZjtEX24ImNDK6kaXhpfO394LAg9++1eUvI5CylYomNdyt7HGMGlwuowbpue8a1dnEYm
         TLVw==
X-Gm-Message-State: AOJu0YyeMfgetXzOAJVvv3KO/YeXcFxixyoSBEHPgbGxPR/HGPxdsfPC
	CD2VjU6VtJ+OemR5kVElGBdqZ4lVBNQ9XYP2kxTTPmiIBuJPV9JpAF2GXGRPU8H45hzZF3Ht8cm
	o0wTRZLszcw==
X-Gm-Gg: ASbGnctySBDkzqrewVA9CkUriSmwwj34AU+wDhp0UPmmpScTMmPwAJwTrSiPNuNtP7m
	t4vh0O+6hD8u0FYBk43cCENE826SKdESxKX1KFleKusEAyXXDDoJpZIbslrszgLM0TqxvEEDimk
	E2SXAY/AGK4ayBGOoaSKE+DL43jWdF+0y3ddA3Lja0WvMIkWAG0lsWJK1VYJKfbVkdQaZ97LNzS
	eiFtut8ThsJR1JMLl8uslzJeSa3F5hczvtfcDM19L7eB006A5CwdkCYF3ema12pBf/TmyiQPjVt
	zUaHPR2ZD6dZcdFpdqTj1GcbRtM2dAOdysrufYtB70c5I0xAcL5X7OWy+wcSuHMRwRoaDD2HxO/
	kLxU6MOjje1OUs+aaWH16IPKogs2cb2RFzo4Koh+w1NMCPvpWPV+7UUMl68IEpkmLTCFp7Dmn04
	X3JwavndqsStbt8K3bHBEQ52tKiV3mZo/WFsZvLMNYYb/MYTCspwtPF8lBpcf5hyOy4acdVy4YK
	RX+laQlU0pU3gehlQ==
X-Google-Smtp-Source: AGHT+IGv4WbFiQIKNR7y9ddE3gNldY1bx3HlszJW9PzJ9TQzyXyxk3EXQvdkeOospt/TDwJhxvWsEw==
X-Received: by 2002:a05:690c:4b07:b0:77f:aab8:317d with SMTP id 00721157ae682-780e16481d7mr305503287b3.14.1760567274232;
        Wed, 15 Oct 2025 15:27:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-782931f7613sm2576727b3.47.2025.10.15.15.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:27:54 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:27:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 11/49] repack: introduce new compilation unit
Message-ID: <87f2903e757f37cabad073077c9ba177f7418433.1760567210.git.me@ttaylorr.com>
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
index 7ea149598d..58fc05030b 100644
--- a/Makefile
+++ b/Makefile
@@ -1249,6 +1249,7 @@ LIB_OBJS += refs/packed-backend.o
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
index ec55d6a5fd..4a985ce77e 100644
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
2.51.0.540.ga7423965ad8

