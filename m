Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A661CF5FE
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678160; cv=none; b=OqRwaSXRGCuFBW71jYhCr9dHko446ygoMmnJQs9Zot6dlcVb0Vl7rM+JFEqXHcc9mOS2sgzayNkFVJSgUIPtUfqIOxwn8MuuwOUmPJX196Bnh7RLIZ/PQsrZ5KVmEMi5+wpwr2obgdRU5yGYMM+x30bZaLxm3qP84TALi/DKTcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678160; c=relaxed/simple;
	bh=Jlv0WrHMrJqpu5Ka5ghu5iln3wMM77Agdfqo4PPAT0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DkrNNPOjwApwEjZ3ikSYU/OoM9tPGx/jI1lE9VVMMDpF8ND9NmXy5Xf/Ju8iTZyvf+w0AGT/ujdTYOYUF46BenuGRUqpkZ+JUo6VsKrTZV6DuVPjUk90KBQk7Jj/50uotTgfFSjgG4qphQadEPYrXinNx6BBF1Bdo4yUmOH6lBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFFhEEip; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFFhEEip"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f2b95775so2698541e87.1
        for <git@vger.kernel.org>; Fri, 15 Nov 2024 05:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731678156; x=1732282956; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wu6PnOFAU32uDKuJ/o/o//DayrueXF0lIgrvGi2rUr0=;
        b=PFFhEEipo3QWJvTbVRG9o0W7k327/B7IPCVA/KbI1KAYwJi7dJ5O0NJEKKjjz+CtpB
         i0i6lygSqESmpOIVsHkNbnlCJDHGrwuy5rhawa7bAdKLJstDZzyJcERxD3hgD2cTawoF
         gbeveODwQSKH1lutl3ZiyfrhgCWQxjsuyLPY14Hx386uoSaiiqV8UIflPMC2RnaJSynk
         9vkQgbbJ9xZ0hP2JfjH4HmFKOIxhx5RxmSPXkIsI6a1Dp+svfzC7C3rSI/pysma+yIQ/
         ApQGZFruId34sSPrudScGvU4vLbIqRA8hipa+sWhwMI12HqZmeg2Nt3OYz06AKNwCMlV
         O6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678156; x=1732282956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wu6PnOFAU32uDKuJ/o/o//DayrueXF0lIgrvGi2rUr0=;
        b=rGLztNRCEddsz7Z2gdkKrzZjI0Be8OuG01woBw/oLG9DHIbT9wQNwYt5Va9/jtYgA8
         3gxcWnln0nWfLI637WzqU1IIyvDSqAjOn5DR9+ph8Mxq1tCcDVHFiST8lP+XsqUZ07wb
         DDxxR6aYuLQVZlTo05hNvoNjxnGXzHbM73CmskvAL2ONZOwovYWqb5z/XR3pjL/FCZs7
         F/KYg85bxcR9Vizcu0RgOZnQ/D3lYG+E02HVFx/Pdd81XUJ2Xs0CJNtMlUNC/Tq93CnH
         Vp1sOPkwM52KQ6NJyiU+Yt79FE/54qbp2bmKz4EYfLHF0dA1zH6BJ8ecmPxmIVBVbqvz
         lpXQ==
X-Gm-Message-State: AOJu0YwPpa/dK8UZH6Ixb9GEdH3JHd7CQFyjkGY940UxyGHjwSbogzef
	BRwpMwnwIkT/9cZeN6gH8N7YmM+3+AoMwqk1zLSrzPvl0IiJBKVPj/Q5KpWd
X-Google-Smtp-Source: AGHT+IH58sLpuz28wUIL3o7fXQrx9XI0clt6ZOki3Pbs3Djk+p6VfRIDFGv+yF8L+DcxhT/oVhClhA==
X-Received: by 2002:a05:6512:33c3:b0:53d:a9dd:5a1e with SMTP id 2adb3069b0e04-53dab2a6519mr2012382e87.25.1731678155889;
        Fri, 15 Nov 2024 05:42:35 -0800 (PST)
Received: from [10.82.5.93] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26a69sm180753966b.34.2024.11.15.05.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:42:35 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 15 Nov 2024 14:42:16 +0100
Subject: [PATCH 3/8] midx-write: pass down repository to
 `write_midx_file[_only]`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-3-761f8a2c7775@gmail.com>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
In-Reply-To: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, me@ttaylorr.com, peff@peff.net
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5324; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Jlv0WrHMrJqpu5Ka5ghu5iln3wMM77Agdfqo4PPAT0w=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnN0/HzkrnH1QxdXBpTVZcZpmTFr2DMw4bMVpiG
 pmtYl/DVCyJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzdPxwAKCRA+1Z8kjkaM
 fxJ4C/960GgSADUbN/EMA6Wxo2Ow8vmbG2rtSqCbKicvRQyTe8/3MMDPs/zlYSqiDAE6meSpnjp
 /+z41dLD2NkqV+R3KIG//QfxAAr6ep7NKTB55qZZ53e4+8OO1MyhDd81pV3Nfun9IQ6q4zXcRYP
 SPnV35HR+PHaSOkBzqiRkWPdvbNKGK3+SYvdVEDlJibSWChfZsiw9lncQ6tyw48quUuA8vVAbQT
 oRp9qnmSLKv5dE4S8vyl9LI29TW6WFjGY0UwlCsk1Ngybvrvwt+UcNBQfR90qbzQWHauFX7Ymdq
 YRR3p5sDexZd/gj7BrhofGMjEMTHvEMSVSYKb5To7gNsk+cvpgm19KFndIIjuQoUbpq6arW5bUU
 iEkzLC++awBg8rdqymc2Cki7BK9eF1/ocJnalM5/xETvDijYpNIVy+5XzH6XuMCxua/P5rqgijR
 lq6QNrs6U9pwnO/Ey0svnFAZv5Jxq1m7ueTHkDcXWjSulov2WiEYbIhzOijN5/MdG8OUY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In the previous commit, we passed the repository field to all
subcommands in the `builtin/` directory. We utilize this to pass the
repository field down to the `write_midx_file[_only]` functions to
remove the usage of `the_repository` global variables.

With this, we remove all usage of global variables in `midx-write.c` and
so we can remove the `USE_THE_REPOSITORY_VARIABLE` guard from the file.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/multi-pack-index.c |  6 +++---
 builtin/repack.c           |  2 +-
 midx-write.c               | 22 +++++++++-------------
 midx.h                     | 10 ++++------
 4 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 85e40a4b6d3e47e9ec1ec27c094455e5ba75b5b0..2a938466f53aaa11096170554fe11a4ed46a25e4 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -120,7 +120,7 @@ static void read_packs_from_stdin(struct string_list *to)
 
 static int cmd_multi_pack_index_write(int argc, const char **argv,
 				      const char *prefix,
-				      struct repository *repo UNUSED)
+				      struct repository *repo)
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_write_options[] = {
@@ -165,7 +165,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 		read_packs_from_stdin(&packs);
 
-		ret = write_midx_file_only(opts.object_dir, &packs,
+		ret = write_midx_file_only(repo, opts.object_dir, &packs,
 					   opts.preferred_pack,
 					   opts.refs_snapshot, opts.flags);
 
@@ -176,7 +176,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 	}
 
-	ret = write_midx_file(opts.object_dir, opts.preferred_pack,
+	ret = write_midx_file(repo, opts.object_dir, opts.preferred_pack,
 			      opts.refs_snapshot, opts.flags);
 
 	free(opts.refs_snapshot);
diff --git a/builtin/repack.c b/builtin/repack.c
index 96a4fa234bddfd2b63c8d9733379d9b1012a4014..9c21fc482dfb387c818c0d0a74f781848b5a0953 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1569,7 +1569,7 @@ int cmd_repack(int argc,
 		unsigned flags = 0;
 		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL, 0))
 			flags |= MIDX_WRITE_INCREMENTAL;
-		write_midx_file(repo_get_object_directory(the_repository),
+		write_midx_file(the_repository, repo_get_object_directory(the_repository),
 				NULL, NULL, flags);
 	}
 
diff --git a/midx-write.c b/midx-write.c
index a384f7ddc8a396d0cffd528132bb8fcdc6b37e24..5af29899bbe279c7c3ff4bc2c65330620ce37ee2 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
@@ -1504,24 +1502,22 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	return result;
 }
 
-int write_midx_file(const char *object_dir,
+int write_midx_file(struct repository *r, const char *object_dir,
 		    const char *preferred_pack_name,
-		    const char *refs_snapshot,
-		    unsigned flags)
+		    const char *refs_snapshot, unsigned flags)
 {
-	return write_midx_internal(the_repository, object_dir, NULL, NULL,
-				   preferred_pack_name, refs_snapshot, flags);
+	return write_midx_internal(r, object_dir, NULL, NULL,
+				   preferred_pack_name, refs_snapshot,
+				   flags);
 }
 
-int write_midx_file_only(const char *object_dir,
+int write_midx_file_only(struct repository *r, const char *object_dir,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
-			 const char *refs_snapshot,
-			 unsigned flags)
+			 const char *refs_snapshot, unsigned flags)
 {
-	return write_midx_internal(the_repository, object_dir, packs_to_include,
-				   NULL, preferred_pack_name, refs_snapshot,
-				   flags);
+	return write_midx_internal(r, object_dir, packs_to_include, NULL,
+				   preferred_pack_name, refs_snapshot, flags);
 }
 
 int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags)
diff --git a/midx.h b/midx.h
index 3b0ac4d8788b373c59fe69ca2d78e9d914702bc0..c37ad5b5242b56d21fd76bd59957a1bdb82786ec 100644
--- a/midx.h
+++ b/midx.h
@@ -123,15 +123,13 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
  * Variant of write_midx_file which writes a MIDX containing only the packs
  * specified in packs_to_include.
  */
-int write_midx_file(const char *object_dir,
-		    const char *preferred_pack_name,
-		    const char *refs_snapshot,
+int write_midx_file(struct repository *r, const char *object_dir,
+		    const char *preferred_pack_name, const char *refs_snapshot,
 		    unsigned flags);
-int write_midx_file_only(const char *object_dir,
+int write_midx_file_only(struct repository *r, const char *object_dir,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
-			 const char *refs_snapshot,
-			 unsigned flags);
+			 const char *refs_snapshot, unsigned flags);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags);
 int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags);

-- 
2.47.0

