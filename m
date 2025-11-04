Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B82C31283A
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245854; cv=none; b=UHdzZlHXIipaWtA04K5t74yzjIHNMTpezwVOf/Zut3wXRz+rY6HEmIoQcQbLNIf+M3Z6btvvxAGqs6mDTYCUnxXPkCW16TNTutWIKV15W+eW7s9Y8V447MrK70Iml/THnz1cxXt4hYjlnLZTZxsWxf8kJdmjV/FZWOJLJCh3fdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245854; c=relaxed/simple;
	bh=n8f5/vFWSXT0PPt1NXDg9Ws2ag0GwELeieFbT0qFySQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IdgnaHWJGJzUVywRxnDGcqG2LbRptx05JOYGHLhfRlBwBPhghflVThX09Y1DJwK16zq22qYIMyTOfZwAMF7DPpS7KRcFt2f2YvkP7e6Qq05DybV5w+8oLmRhJwXTP1aO68y40Sjb+KjsRdzhojKb8531uWcX5jmbKowGNBRcjLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gExMQ/J6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gExMQ/J6"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47109187c32so27043145e9.2
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 00:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762245850; x=1762850650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPoB9aWL9qvXOgDx6s+tE38lC7DYZiaZwwLaItfpWac=;
        b=gExMQ/J6damJP1lJUqutxTBOiSqIaWQTBB/UidaeIEjirMU3hUESwbWAeaiIJgNesX
         uaB645Gw2pqsO1jjJf+q5bnUOzCPMpGrqpZFwNYM4JX8tRkqYbicnNhn7W7QLye01SPY
         Uyd59P1ZsstrshSJQGiFxDltg4c3pxyAL55DssE/MYrTgjkt+qrlOUulHvSPkZJFi1xp
         VnEXNMVcJEZE/e1/Wz34GHJF1bFcPiUH++/8lbj/+dXKfcnztEkqdrU2j638T28vS0Cg
         zH9ZineAEUXyg8IVseABm/3FcWFzSzJRcQa8sTnIF7eQsY809s4msm8p3hFGDHlQ+zdX
         emMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245850; x=1762850650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPoB9aWL9qvXOgDx6s+tE38lC7DYZiaZwwLaItfpWac=;
        b=ECikWijbjpt0EwvOvm/ym1TmcZTXEcLrSpeumpyirVeVWZ8VzOyJPM9ueQNQxYELOm
         iDFodw70l/SLWWOAEpmk7vf0wdkPNcHpl8NB5Ge3uFggaVMTOi57yOg/ITsHr4QaBNA8
         Wh686MN6ucSLboad9IiXKgUfshaYN8G+e8mMfOz15Rp59eHiAr/Xt1yJrGNQddqQw0KE
         nYejIuJVapugpQBHaNwQQMP1Iw0UH8cxd6Ereyd1Gb7kvbtoxFZ1NUHXcRiLlyB7ID6s
         hRcshXMRMbDcz8cuKEwtXlaF62Ag07/aaWBIQLGZS6qyjpufuMt4brXAkYRGrOEJHAvR
         mdXA==
X-Gm-Message-State: AOJu0Yw/E+r1p0jVDB8f55lii2BTXNeqccNAlE7OqyqP5fprU0Q6KfuF
	CJyRKAruPLu4GCLR1WBCBlDJXhfTKm9JtKJzLR3EP+MmAH10SnGViqJb
X-Gm-Gg: ASbGncu4IoD/JppWVTYH8wipmTEN2pO6aV2i7/eRJU8sqAH8duJE4fbfoOh1sGq0pJr
	Mmxu7ZI7fMEoxIJkPmMzfniQOVLFuBMi1qE1RgDbETgEElZihSftDhV4wygeEEpMb/fwX3wyTUx
	O6FXfnoh7b5ElBz7rtNWXvTgZAZINyF42/JTaLf9pLodNlAVYlEUEnWaEtThm47gCnWiMJ+zYl6
	jpV7+N9ihSLEKk9Dr+YCRmD4y01hTKGyx9gIIjuvAHfhbPmrHJAlE+WPQfUhIscpNRjjTtV783P
	hf+7jcxMLzVxGuh1bXdDK31nMwxwssmWTp/dPuT6Kkvs2rihBUujgnS9aItyvxL7QFeCz393BlF
	RlGxYiofMtux8fN3lxSMHUyNQmGJXMc1FnXPkTjS2Xz+WzVO/kwXMEXStGuFlNDhtIBOjyPlIsi
	95Na2O
X-Google-Smtp-Source: AGHT+IFyVTJLWHxkW/GJNZSzQZEnPwYDCJwPJsSfqqSrQ3PbxtkTg+s6vAtI0YtbSGd21LkC8XOtJg==
X-Received: by 2002:a05:600d:838e:b0:477:54cd:200a with SMTP id 5b1f17b1804b1-47754cd21f4mr15892895e9.6.1762245850208;
        Tue, 04 Nov 2025 00:44:10 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:b03:96aa:b9b4:f746:b8e9:7f4d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773d81cb03sm193379035e9.13.2025.11.04.00.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:44:09 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 04 Nov 2025 09:43:59 +0100
Subject: [PATCH v2 4/5] maintenance: add checking logic in
 `pack_refs_condition()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-4-303462a9e4ed@gmail.com>
References: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
In-Reply-To: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3606; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=n8f5/vFWSXT0PPt1NXDg9Ws2ag0GwELeieFbT0qFySQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkJvNVEdpbp7ma/MkjnKvZF7rAqWPtsogVf3
 48uOxUwVZsB0okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpCbzVAAoJED7VnySO
 Rox/UMkMAJjpOhe/8J67AyLF0KXP9AlTc9BjEJK+BKiatGTYzgsCh7+4gQdVlWcN5zeXu8oKk9+
 gyBfxHjDX3BLXFrYttK0sgen/V69PHRO0ePh8BZ8BZBZVbb+eSBl91YwN0YXmcp7a77mvRzWWDh
 /h4lDIg0p7eyUvrL4HhdfNFY7phrE0W4ywNO1wvxM8gNXtnkGG77/1eZzV4Tc7xkzWcadwXis1L
 Cf83M5m/kxZoMc5XH0w6Myyj18A45lmU1JhdbQQI4ijtZUQucnl/HaeaZnTCSWyKr434QxToJ35
 tiglI5OsvGSB4yDH4avL1I0lS9w9tTqNtNTTcdWEcFeiCSsdaJpqIuKkalzmujltCBPAh0ZuXXa
 wrF6cL1rvq8bcfHb5+YCy6YMOuaSGRbROqt9JSdrOEPMAuIrOn+biplbr4dKn1nFvfRkq8CS1Px
 te2NQo/nj2ZxRlqn5PN04w6XwaSfwY29HsMY/ZWeYWGe7GT69Y5v1okm1lbPXoYFYdkNfp9+Ks8
 jA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'git-maintenance(1)' command supports an '--auto' flag. Usage of the
flag ensures to run maintenance tasks only if certain thresholds are
met. The heuristic is defined on a task level, wherein each task defines
an 'auto_condition', which states if the task should be run.

The 'pack-refs' task is hard-coded to return 1 as:
1. There was never a way to check if the reference backend needs to be
optimized without actually performing the optimization.
2. We can pass in the '--auto' flag to 'git-pack-refs(1)' which would
optimize based on heuristics.

The previous commit added a `refs_optimize_required()` function, which
can be used to check if a reference backend required optimization. Use
this within `pack_refs_condition()`.

This allows us to add a 'git maintenance is-needed' subcommand which can
notify the user if maintenance is needed without actually performing the
optimization. Without this change, the reference backend would always
state that optimization is needed.

Since we import 'revision.h', we need to remove the definition for
'SEEN' which is duplicated in the included header.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/gc.c | 30 +++++++++++++++++++++---------
 object.h     |  1 -
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c6d62c74a7..c3e7a84ec2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -35,6 +35,7 @@
 #include "path.h"
 #include "reflog.h"
 #include "rerere.h"
+#include "revision.h"
 #include "blob.h"
 #include "tree.h"
 #include "promisor-remote.h"
@@ -285,12 +286,26 @@ static void maintenance_run_opts_release(struct maintenance_run_opts *opts)
 
 static int pack_refs_condition(UNUSED struct gc_config *cfg)
 {
-	/*
-	 * The auto-repacking logic for refs is handled by the ref backends and
-	 * exposed via `git pack-refs --auto`. We thus always return truish
-	 * here and let the backend decide for us.
-	 */
-	return 1;
+	struct string_list included_refs = STRING_LIST_INIT_NODUP;
+	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
+	struct refs_optimize_opts optimize_opts = {
+		.exclusions = &excludes,
+		.includes = &included_refs,
+		.flags = REFS_OPTIMIZE_PRUNE | REFS_OPTIMIZE_AUTO,
+	};
+	bool required;
+
+	/* Check for all refs, similar to 'git refs optimize --all'. */
+	string_list_append(optimize_opts.includes, "*");
+
+	if (refs_optimize_required(get_main_ref_store(the_repository),
+				   &optimize_opts, &required))
+		return 0;
+
+	clear_ref_exclusions(&excludes);
+	string_list_clear(&included_refs, 0);
+
+	return required == true;
 }
 
 static int maintenance_task_pack_refs(struct maintenance_run_opts *opts,
@@ -1090,9 +1105,6 @@ static int maintenance_opt_schedule(const struct option *opt, const char *arg,
 	return 0;
 }
 
-/* Remember to update object flag allocation in object.h */
-#define SEEN		(1u<<0)
-
 struct cg_auto_data {
 	int num_not_in_graph;
 	int limit;
diff --git a/object.h b/object.h
index 1499f63d50..832299e763 100644
--- a/object.h
+++ b/object.h
@@ -79,7 +79,6 @@ void object_array_init(struct object_array *array);
  * list-objects-filter.c:                                      21
  * bloom.c:                                                    2122
  * builtin/fsck.c:           0--3
- * builtin/gc.c:             0
  * builtin/index-pack.c:                                     2021
  * reflog.c:                           10--12
  * builtin/show-branch.c:    0-------------------------------------------26

-- 
2.51.0

