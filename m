Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0BF2882B4
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 21:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762638735; cv=none; b=cb3nIJd2f7nzg9outWxLppwDnL4PgXFw+CSrj5vsd0SPMWP/GIDi7TB5QrOhAMLmgQaQhfpUFdtNuVUrINNaN/DKi9cZ4xz4s267v5cRMyHXR0V8keMtqEGs7lO/O9H20mLY6VehxR7rz44OdE4w3WyiqI+fr4ZIG0B953Uhp8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762638735; c=relaxed/simple;
	bh=T9blawi8PFyaaVAOfvnyKcZAaKBr+yPQoRJrJwxyBXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lFTu615AWqMdIGjFYBanfhqcKsxE7XnTbRSvqJ/fedlzsJ51Ui2maDU6kMQ77JR61xvQxMBba1jVaJ/nw/oQA3Ws0A4oM9Ujm477nnt2ZQsiBitrwI+qWHvCqOopixXnW/n9GBgeuDpWzTTq13UhiMr4yAqUxSzMLQIgJaFmTVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYTJhyQK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYTJhyQK"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so3021548a12.0
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 13:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762638732; x=1763243532; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfZEfePFs78UhbIROU2k3WuoQyGuhL1/KKooyNYawtQ=;
        b=YYTJhyQKe6xEDJuXL2Rtcb6RfkVLHWyuU/12NThJqA4+cceUTsTqNA3/vHYPllPklm
         HoIL5WfqYv0wcS4cqNEix4WfUjlyE9h5zg4VHMjwpL5TueBhXDeIpECYyKlJoZpDic/J
         4MfBMgzwy4F/dCsjHA2aHG30IA4SkOFqYFIaNe/lz33EeN377JA+UmJbnf3/GgWtOUCv
         stcQeQjX1WkGH8XtSkSmlhWfiyuCrRKbvnLn/2QYGQhlH30L8+YwSTjl2SPTkx4c3jke
         y7zrfZYAL3A0UfZ02ngAL5yPTKX+5Qfv8Bw8gZErHym0L8vps/T93SAinHNzeU0Tya9x
         E+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762638732; x=1763243532;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xfZEfePFs78UhbIROU2k3WuoQyGuhL1/KKooyNYawtQ=;
        b=gS6uYMtKFeUKMhK0i/qTYwBbpNsOCUL4d3Gf7+8miM0p9uDYrqdozjbtJhheY9e6BD
         LsKRVZdPGePHbHNnF5e01iGWDxkPnNQVC01i/rS2zNaBw39R5t9ON6Q/gvXczIxc6ZZB
         z0N37j2upy25nKCqrX4YWd+l3JIEZIuOGUo/UZOba8L/MpWObzaDsoygnEXAfj8YsSiW
         s5Jt1F7WGEOP8xmz7W7mXGDj6ThWL5Amq3vfetIZXu71HiU1V47A4FjXpa6FY20NgWKE
         u3hvSyFocHCOp1N/jjcPHpHGavI5tBGCD12/lNHb16ZSRjYorechQtvCNBun5XGWOoWx
         NW5A==
X-Gm-Message-State: AOJu0YwRvbGNjr+QdA47n44obZa4aQDenvv0+tnyyrvDkUFaOWNtvaqR
	pl3l04aZ8WGsLUPn4dAzzpVJFfmx/tS2fT+5r0//+pdC+54ujzNzDOZPUS+a8DhU
X-Gm-Gg: ASbGncvCIVkqa5d7JEL28IAGquxZ6h9MdXkPLu3TgNdNwYD80txJUwCtYlZlTanJ9zJ
	EwHcvdrSnm83uVkgK+caWdG6QVgAT2oCEQay9uTL8+C6Z7FcFWnKAAGP9/pYaSz6PhwJMEOJSiN
	XSKBr+5UlYeVu/spV8862t9t/rAXBphaXDaoFTX8FjVZv0dPz8ygqrmvig0Hm64C2k7/XXUtFBI
	kHCo7R0Fdja0S77UOkMcq7Npnkmpk8TbGlkF0vPQa5YiUqjJ7DhmaFJPn1ETFTYhGiZ+snp/dDS
	q7ZJ3LbVfZi6tHVuRKOqNZDjCC7n9tjcbe9tKy5wmTzIcC3HKS1Gpl3MrLY+4LKNKB2FtRC9P9y
	JheduPJh/qGe+V9YXsxK3ejQKsJ3Dnwr7K6VgAxlUWOhTDD2gY7R6p66s3dNkMniYm+aCs2qDD+
	KLA54tlJ1PHz+zeMk=
X-Google-Smtp-Source: AGHT+IGBPJhoD5JikXgXUOJOEAqf13mvsBgNjIwekQq1iUEL6ImbP+ro8X1tj+3eIHVNJrIYKu0Dmg==
X-Received: by 2002:a05:6402:510e:b0:63b:f22d:9254 with SMTP id 4fb4d7f45d1cf-6415e6edc1cmr2713139a12.23.1762638731935;
        Sat, 08 Nov 2025 13:52:11 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:102:72e5:c961:8164:6be0:9490])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6415b69c366sm3056371a12.23.2025.11.08.13.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 13:52:11 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 08 Nov 2025 22:51:56 +0100
Subject: [PATCH v4 4/5] maintenance: add checking logic in
 `pack_refs_condition()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-4-a90f229b6023@gmail.com>
References: <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-0-a90f229b6023@gmail.com>
In-Reply-To: <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-0-a90f229b6023@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3598; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=T9blawi8PFyaaVAOfvnyKcZAaKBr+yPQoRJrJwxyBXg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkPu4GDkKGrzTX/bIPdXhMwSvxYQg3HH3Kzx
 OmINWxd8rTcv4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpD7uBAAoJED7VnySO
 Rox/5hUMAJVebiWhLVDxq7/ZnbgwuLCTl9u5Q4aCuwWStr0HxcIVTEfS9ft3sh92H+Rhk3ENAB8
 QzDH8KXzPkfsqfR7fogoO2hCcwFIOGLi6GOd+fGaEGpai3i0JeEYsOQXcrcnWh4BnGivb1G3j5n
 zS9QNpHMgGfl9S9dkm0Oo0wuabZDNPsCwSPKX4Gl8GhuUVYv39VJklBVumdO5lAdj0IKvOsnqgS
 eT6NCKMmnNNyblF7dB/pi3UXKeyPCj0V/EVEq8SQQmzc2EgDY88hEBJ8BDtYDtx4IXClj5bb6bu
 eN61dc475DZllEYfgAus+u+TGEg631BG3pyJFYa/Eqpl0iTiOnwAJdwBlhCCyaC15Zgw2Y8FBaz
 OJPYltqaDTvzTqaasiru++i96jZKHY2yYvjJpKGmT0CCSZE2VWAkH0MDOXmt4qfonI6l070PIfp
 t8FR2HlYGuUkf/lHWCurtSj0Y/h9lmd5//XHzD6e6kSHwhKqQwOD2ozj/nT8g1pp316KC74Oe+6
 ns=
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
index c6d62c74a7..85e9a38d10 100644
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
+	return required;
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

