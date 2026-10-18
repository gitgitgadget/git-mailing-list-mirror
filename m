Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0ED33ADAE
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341077; cv=none; b=YgU0d5tcYHqnzWyw6bfsGDTo74LqHadrtVAvMWvWaY1lggDbWT8o3+hKuPvMPQSnoG4UaeW/SpDhllLuglHphoHlK+cDrNZUVICNK4DRlIr0xCp6U35kFwPjXnxfEWCBfJa/pAv5VGTfDDumteBnhYM3ZDsqdT0CGNkzFFueXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341077; c=relaxed/simple;
	bh=bshAta04k0Il0D1cAHGFrl0qh2gobW1OmEXyuJd4etw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=LxM3h206y7oeEdeOvOwgBj/y7fYi+egacS8/HLR1+z67XkPIZLeOvi+FrtEexd0GVTuDAuX1oQmjUr7ZGuIAfYtQalrOGDLTANJOldnXDrBjJyL/Qboi55jKKEBpw2nBfmsFNWj53efpqJC3tAYLs5a6nLu1MEQ5XJ4Q1/IdR/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJwv/anW; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJwv/anW"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-16079d54c17so3336403c88.0
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792341075; x=1792945875; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MoFd/7ExLOeUzxutDpmed4IXttBJ7rDIfEoTQSvIBIY=;
        b=QJwv/anW1MtfnQUHYnGDdB03fxBqv2BiCVG+H37BudOv9y2hagmSZLL7CDqHYeNmnb
         gulz/G+RkGviMZrcCAkXrmxLNp1aVNnB/K7grJxtFtqflQkXuDji1/Sfd6KqJHU5dc3y
         pedKfpViw8UVeg2ZeWF48Wb82F8NrermBfsuXulb9LxtWabe1q6q68zv1lR7WRPcANVl
         zTHVmS6g+tHBwMaR/iYSYn22vqZnpr8zrbk4M0Jx2cUnGtFPfyrWIr/le4ZuL0bniXTk
         o+QLNu0FWefZix1zgBzqt5CYIHgiXMUMpVHvo2FILCoIVhMAvKKlE2jvTW8lXPtYzZm1
         B74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792341075; x=1792945875;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MoFd/7ExLOeUzxutDpmed4IXttBJ7rDIfEoTQSvIBIY=;
        b=JEEhrDAJoTFEJ/h6LTe0ZTHiYiYM8kdmonCix9tG7dr+8flCus78FfMWahlveNnJZq
         dCIpuvswfi6s81XdboaTm/axKjHXfcAxmOzGz9HwqrYtLFkx0HbFTXb7gZjpuU944GUM
         A9uswsdTspgbagxn8TA5n+GuFPQRG/MfYwSIAKmAtIrp3XTXhIDJWbTFzpr/btBsje0d
         R556MXpDcJHMCT4NMr70dG7oO3gWhKFmPbt4kIVX272Db0030LdGVYtMZDIjnPahAZED
         NDL8nAO0KfMBq2+WLr9ao5PY23Tab7QfkSMhijfZYt7/YAH8wQsKKYAFXVJnPvrnHhTL
         FJOw==
X-Gm-Message-State: AFq9FYJs4QjPoPcen9Xf9crEiudMRSoWENxC9nPXQFaddjMVmmhZm44n
	75ZOKbhCiOTT3PeI+IkMzCgcAB2LypY28Ep9QUewHLcOD4NzTXuO6bKWdwZd6Q==
X-Gm-Gg: AYBFou3I9MBLsNVIuRuWaern9KPkkACKCMlj7DkoYprl2fXW5vXz5Q3H69n+EDYcUg4
	dWy1DwCILbDzyUur3Ya2DCE6/cGRh6vqtBXRLoSJ7YAKYviPFaU+OB9RJ8BeXsN1ZaSV/swY72M
	nrqKB/yQy7uo2VpX0B5dqSuln9Bo+Crp9VTRErjcgMnPMqkYC1cJfncITlP9Lp8JK9WLoR9ArS0
	QH7a5TsMF0C+FhyZTL7Lo7cnnDcOu40d2z/5diBu/Ai+DGKjkjvjrBEPBqSsgmx6PYdg46IheM6
	gDQThmbuGJfuhtGFV3RDPczT670DZFp1n7yLwPyqz+55B6oLLVtZ1cRk/KOu6v7ipiE0TvsRioR
	JZIjwCVtsKj1UWpQ/8NwzVVwczj3zXlnHs//DKkLUpSsAeigUZL15Mmvu1uZB71CyjT/YBPEPHr
	PzUQGlWkFcmgrXCywO/ibu+uNWaAm5CglUhOx2zA93hLiyXonqQT5ePWZOS8hR63ccWqqjeSJB
X-Received: by 2002:a05:7022:f213:b0:144:c122:6cc6 with SMTP id a92af1059eb24-185139aea8amr9394833c88.32.1792341074802;
        Sun, 18 Oct 2026 09:31:14 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.96])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831996071csm22701010c88.9.2026.10.18.09.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 09:31:13 -0700 (PDT)
Message-Id: <pull.2266.git.1792341073005.gitgitgadget@gmail.com>
From: "Shashank S via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Oct 2026 16:31:12 +0000
Subject: [PATCH] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
    Christian Couder <christian.couder@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Shashank S <shashu8660@gmail.com>,
    Shashank <shashu8660@gmail.com>

From: Shashank <shashu8660@gmail.com>

Right now, the prune_packed_objects() function uses the global
the_repository variable. To help with the libification effort,
change this function so it takes a 'struct repository' pointer
as an argument instead.

The function for_each_loose_file_in_source() uses a callback
that only takes a single 'void *data' pointer. This means we
cannot pass both the repository pointer and the 'opts' integer
at the same time. To fix this, create a new 'struct prune_data'
to hold both of them together, and update the prune_subdir() and
prune_object() callbacks to read from this new struct.

Update the builtins that call this function (builtin/prune-packed.c,
builtin/prune.c, and builtin/repack.c) to pass their local `repo`
variables. Because we are now actually using the 'repo'  parameter
in these files, we can safely remove the UNUSED macro from them.

finally, drop the USE_THE_REPOSITORY_VARIABLE macro from
prune-packed.c.

Signed-off-by: Shashank <shashu8660@gmail.com>
---
    [Outreachy PATCH] prune-packed: remove use_the_repository_variable

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2266%2Fshashu8660%2Foutreachy2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2266/shashu8660/outreachy2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2266

 builtin/prune-packed.c |  4 ++--
 builtin/prune.c        |  2 +-
 builtin/repack.c       |  2 +-
 prune-packed.c         | 32 ++++++++++++++++++++------------
 prune-packed.h         |  4 +++-
 5 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index 4d63f26b0a..d44e7f81d4 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -11,7 +11,7 @@ static const char * const prune_packed_usage[] = {
 int cmd_prune_packed(int argc,
 		     const char **argv,
 		     const char *prefix,
-		     struct repository *repo UNUSED)
+		     struct repository *repo)
 {
 	int opts = isatty(2) ? PRUNE_PACKED_VERBOSE : 0;
 	const struct option prune_packed_options[] = {
@@ -30,6 +30,6 @@ int cmd_prune_packed(int argc,
 			      prune_packed_usage,
 			      prune_packed_options);
 
-	prune_packed_objects(opts);
+	prune_packed_objects(repo, opts);
 	return 0;
 }
diff --git a/builtin/prune.c b/builtin/prune.c
index a7e4678d11..4eee5a2e27 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -201,7 +201,7 @@ int cmd_prune(int argc,
 	for_each_loose_file_in_source(repo->objects->sources,
 				      prune_object, prune_cruft, prune_subdir, &revs);
 
-	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
+	prune_packed_objects(repo, show_only ? PRUNE_PACKED_DRY_RUN : 0);
 	remove_temporary_files(repo_get_object_directory(repo));
 	s = mkpathdup("%s/pack", repo_get_object_directory(repo));
 	remove_temporary_files(s);
diff --git a/builtin/repack.c b/builtin/repack.c
index c4360382c1..e8970e8eb7 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -757,7 +757,7 @@ int cmd_repack(int argc,
 						       wrote_incremental_midx);
 		if (show_progress)
 			opts |= PRUNE_PACKED_VERBOSE;
-		prune_packed_objects(opts);
+		prune_packed_objects(repo, opts);
 
 		if (!keep_unreachable &&
 		    (!(pack_everything & LOOSEN_UNREACHABLE) ||
diff --git a/prune-packed.c b/prune-packed.c
index d49dc11957..a53b7031b5 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "object-file.h"
@@ -8,40 +6,50 @@
 #include "prune-packed.h"
 #include "repository.h"
 
+struct prune_data {
+	struct repository *r;
+	int opts;
+};
+
 static struct progress *progress;
 
 static int prune_subdir(unsigned int nr, const char *path, void *data)
 {
-	int *opts = data;
+	struct prune_data *d = data;
 	display_progress(progress, nr + 1);
-	if (!(*opts & PRUNE_PACKED_DRY_RUN))
+	if (!(d->opts & PRUNE_PACKED_DRY_RUN))
 		rmdir(path);
 	return 0;
 }
 
 static int prune_object(const struct object_id *oid, const char *path,
-			 void *data)
+			void *data)
 {
-	int *opts = data;
+	struct prune_data *d = data;
 
-	if (!has_object_pack(the_repository, oid))
+	if (!has_object_pack(d->r, oid))
 		return 0;
 
-	if (*opts & PRUNE_PACKED_DRY_RUN)
+	if (d->opts & PRUNE_PACKED_DRY_RUN)
 		printf("rm -f %s\n", path);
 	else
 		unlink_or_warn(path);
 	return 0;
 }
 
-void prune_packed_objects(int opts)
+void prune_packed_objects(struct repository *r, int opts)
 {
+	struct prune_data cb_data = {
+		.r = r,
+		.opts = opts
+	};
+
 	if (opts & PRUNE_PACKED_VERBOSE)
-		progress = start_delayed_progress(the_repository,
+		progress = start_delayed_progress(r,
 						  _("Removing duplicate objects"), 256);
 
-	for_each_loose_file_in_source(the_repository->objects->sources,
-				      prune_object, NULL, prune_subdir, &opts);
+	for_each_loose_file_in_source(r->objects->sources,
+				      prune_object, NULL, prune_subdir, &cb_data);
 
 	/* Ensure we show 100% before finishing progress */
 	display_progress(progress, 256);
diff --git a/prune-packed.h b/prune-packed.h
index 936fa9df23..9ec7ff0d60 100644
--- a/prune-packed.h
+++ b/prune-packed.h
@@ -1,9 +1,11 @@
 #ifndef PRUNE_PACKED_H
 #define PRUNE_PACKED_H
 
+struct repository;
+
 #define PRUNE_PACKED_DRY_RUN 01
 #define PRUNE_PACKED_VERBOSE 02
 
-void prune_packed_objects(int);
+void prune_packed_objects(struct repository *r, int opts);
 
 #endif

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
