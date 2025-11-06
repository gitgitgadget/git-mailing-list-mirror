Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE583301025
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417364; cv=none; b=JCvgJ3DZFv9LqZfza4EsHjmLeKN0GpVF+Zz+5mRRrCCZcJyJY0zVxzDB1qWjPJYt46x0qIXfBcpZTA+97a5MKE6A4PuJuXc/wRLlxxcJnNGK7p7qIiC3TrIEz4EZuTK3v3kqCaZlfcOAgZL57x7YOzlUkJgxCa+qRtfGOyaVEFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417364; c=relaxed/simple;
	bh=n8f5/vFWSXT0PPt1NXDg9Ws2ag0GwELeieFbT0qFySQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RxC2pRlSMnX1EHBOceaxi25DdeUdz46VyYZPqAFAYGZQmBx4+V21BFkw7jG695jYgU4NoZITpeF2j4Y6PIo9z1Ra+JWk5Vr9i2/Aj5z+T/gjyHYM31+Fk2E8dWj5pBc817HxN+aX2iL+OFtPoljuOypFJdgsQVLYAddGwekENG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gL79k3R9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gL79k3R9"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so112332366b.3
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 00:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762417361; x=1763022161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPoB9aWL9qvXOgDx6s+tE38lC7DYZiaZwwLaItfpWac=;
        b=gL79k3R9xuH70X4uDryDylrs4rTrU12w8eyVnnF6xjxhcF+WSX1QYXJnLJAwxfdZ6w
         qSN4eMTAuKmhLzHQSe7Gx8J+hyJrPCeSdjZ7F4uzwxdOMLdb3ceXCF+H1deRtB/GIN8I
         H7MsD48Bfdz00scwyWJivv4ZpDoc/Md7JhLEwdegG0F0cuMkxCsT2RjJBZmntWcHgxAS
         AKRDrn1BWU1aKhyRImB6SOpqEOW6N+e95INZWyAwed7WyCOJj2ooy0mEl9De9TLMD/Z1
         wC/fJt0LMoOM4pDUel7ohn6vCQ1wGIyeMDRXS+7Zr9mbWSe6f8solrf/X6qTxO/6DkxN
         YpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762417361; x=1763022161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPoB9aWL9qvXOgDx6s+tE38lC7DYZiaZwwLaItfpWac=;
        b=gmnYYsrJbVt1699h1yXlwEFJSba/eG1jewfH1k/VSjkWppJUXcoOKpflewzcVvE0a7
         znWFSyIxYjQC3FzlIcBWhnWISejqszjEMXRr9W+Qy/1BOwjQaIIBU7W1JiwGBoKjrFhR
         nXXDSQTTil2bboR9IYVzy2gqr3aArWi329as9m19+3lsPtg9Q1woBEAsS6iFbLKxht92
         nPFXGqm3rHdT+UnrYz/4dL5S5w37vkHROPEtiEYXvMpg23eE8zTfmc8yt1WChoCWxiFN
         5/4NXD/t5chmOXyUqZadNe5YnfXRVdvj1P4jrLNdubbQE2ImGw9XbzCYrHQybyMAB/oP
         USEQ==
X-Gm-Message-State: AOJu0YzeCmsN5yq0m8S88cU4HZm7wNd6R2whfPJOXxplmlYoApQ7tRs3
	DmO4g+02LX+LGzrSjS41mmjEFGv5OBRZbMiB8ph6/Q48uQARAg8HiUwy
X-Gm-Gg: ASbGncvchAYigN6bfvW78hj6yq3Jmgkn8zb9NFFwVeNI58h1OYLGqWjzVXqYS0vdMnq
	zKdy6grYI/vhoIP1M2Kn53/Xti6lthPXHs533flnhdG+M1Q1VQaTkA3IuApOsjU380RpkobNelK
	xWFosTYdyh2P02XBqGNXn0Wextqsnz7v/9Fh7YhtZoVSrNCznwSHfLIiKzQAVYWL4G8Y/eBQ9bN
	aYFM6j5fVDv5B5BlktKjbj5h81ttmDE0k9ma2eXoPMcJpi2Fv33g021MicI0HAg6x5bkz1wxJT4
	118np4WmsmyjdNkWMcW/mKcPxO/uO95R2Ur0fTwBVyHo7shyf7yb13cDcoboUj5c/DgFqlJGNIR
	X1XvDs4jEh4AW731D9rj+fJst29jmRTSR+cyF8n+I7eVmLHK1Xxu1jtzcB4YPMu5NMx0bXHorli
	IapRUn
X-Google-Smtp-Source: AGHT+IE3r024rkcp5IgihNNxh4YRw8poTk4eDCUOudll1RRPO5cSqaU5NGyqqWsmY5qCEWplVlq7Gg==
X-Received: by 2002:a17:907:7ea9:b0:b70:e15b:286a with SMTP id a640c23a62f3a-b72655cde7fmr395658666b.57.1762417360898;
        Thu, 06 Nov 2025 00:22:40 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:107:48a1:df96:bd1c:78ca:785c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72893360f6sm160577566b.10.2025.11.06.00.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:22:40 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 06 Nov 2025 09:22:33 +0100
Subject: [PATCH v3 4/5] maintenance: add checking logic in
 `pack_refs_condition()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-4-d611a2a95cf5@gmail.com>
References: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
In-Reply-To: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3606; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=n8f5/vFWSXT0PPt1NXDg9Ws2ag0GwELeieFbT0qFySQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkMWshQuhhdm2qj1moSv5S00kIikHe8y1kZY
 SncB0h1oD7RU4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpDFrIAAoJED7VnySO
 Rox/hLoL/i7bR8zeHOYyy2Vf6zlJy4uHlWfrKzBK/YYfeGuzUOgcwZS87jPyfaVun3Wiqq/ywnq
 To99Qkgink+pnYn7FI/kttS8XlAOCe4mn1GHMDgEMIqhx6fRzvsEuj0j5CLwUHRJns+3JC3Nxqn
 q5uRdAD6m6GZEKK5yJ8RjF+y0AalMCDN9dHoFcSvVUV6LjrtAdljQtvgHqhq8vlmvefVNQbFgSG
 GtuBHToCc39YuQ90bpcr9hFxolRGNl46hjUE+iBf1D4d382gxGZnWejYhKDFfxr5hpQAnPuShqS
 y0E9orgwwmrJE2Qi1k6eq+cuk8PYAOTBpFzv+oal5pw+MJY2cO4L4j+gP/u1VMvUDPjPmIQGDR9
 aSHgcreIz9LATbGEhUVTtYt6hW5Y6+pwCa2qxLbiYdrEm/q2tAU3S6581HmWgzQqz6VXzbiofi7
 f6VlX+iZMUpKn8Dwilx+rSBT/02Y9EvaQC5Xa2OzcBbeXBnQk19Km84v7GBsM2SnhdDIxXvwCK6
 FI=
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

