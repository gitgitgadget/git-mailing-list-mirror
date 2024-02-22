Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD05134CCE
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608121; cv=none; b=AOQjAiFDLQptS47iAAHI20XzdYeGm6mmndzu+C9C65eInQUxjVmS8DkKNECHhyiovlHwmnesRC6hqQ0UjbjKzUp7emzMU0Uucn1v5dIXU0GMmITuZoUaZ4b5QD5c3+Kube9iDW3FQe10lPxhmpxZlMvee9UHgoGPP0t4DTQzq2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608121; c=relaxed/simple;
	bh=XK+Coh5PwwNEzPwXMw8DdCAp0qD9ozktfiVc/5uk2rQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WZHl0bAzFecRfRdpg2ea0HfR0w0hbX8RRe0Fml16GgpItlspSvrzzViqqnCyUhjvluVqU/C39Vf4lUUfxaVkekjkGQbjtxTmeztoSuTNeyKkclTANq03gbujw2aB3ID91bnRY60i6W7EXD83JeHrtaC+NiLpvkQHi3Dj0mUVOxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fR0RK/ar; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR0RK/ar"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412700a7207so13154285e9.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 05:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708608117; x=1709212917; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH5F4ez2NmzNeSHSGewWiOcbU5KriPIckDGLw8M93Tw=;
        b=fR0RK/arZKrxceqaLPO2Colm0eJBVkocBBJ0RbkpXvHq3Iow4Nb64AeEBNGorsbnEq
         yc1oiR/eryuyCUjTer/qjNhhApjaz2ibCzt08tpVUdmlEIhm/0yj+ZrgpNRxmcdHkJXL
         YsBMcVfwHY0GLpdjvce2+8H5suW2RVQmN0JPn1jd/wyTUkXzwp+4lVEJmEC+R61wAyqz
         wNXo0n/35FSjOwQWHew8m+8cwnm3UlOamuFex8+IXzMQbqeL0UBMmt9QEYtImtx0Fzom
         PTrLO1eVFQWU81D4xqs4nRDSyBJdQdtEE6ipBvOtZMPOyLcHGM8p7+hXpcbn3Px26vuv
         QIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608117; x=1709212917;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FH5F4ez2NmzNeSHSGewWiOcbU5KriPIckDGLw8M93Tw=;
        b=SxVaxWry87sXI3JBcCTKTf+QjRta2qfilVz2rMJxBUNt0ClZmU9KS5RZesoUEX+ALS
         0s4yjpBP7mtWcXWFK7sDYt3NhNtNpY3HOicTc5hvVZXAob21+PEh4V1Td4xkncL5uK3r
         aIFOJcWci7b27Xv4+oSqx7wlrV9Tu+lElJlOA2y/ML5qxIgOrIwo0WWfInw9FgUIhkWs
         0pA91Ee6jkff4pNgmdvjDkLl7cupJsydwTqDuXMnnqjvVpA2ow4p6cHUkPaWLtAAcl4D
         7GbHmXaF4AFuZksqmzwFq9zsk1/TizU5kRmTelqvCR/dXG0wkt0D5GIvrgH0XkK+u86G
         nyPA==
X-Gm-Message-State: AOJu0YwIcUJHSdxUY++sE6YHQRPYYug1IjTRaVh64mVjO8a7QlrovtRB
	DM4FzQ9BROP0FxidXqUKnyeVQzkB3zpsBfRlL3uC7B13Ai+taHDSonJFm38r
X-Google-Smtp-Source: AGHT+IGvX+qhRxWSRoVFjX0852iGMzj9joWSEYRNUtk2WJC0tLSvviu3Sjtef+w5HNTaN2EBfESHDg==
X-Received: by 2002:a5d:4104:0:b0:33b:5f1d:5ef4 with SMTP id l4-20020a5d4104000000b0033b5f1d5ef4mr13168462wrp.1.1708608116538;
        Thu, 22 Feb 2024 05:21:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2-20020adfef82000000b0033b75b39aebsm20363506wro.11.2024.02.22.05.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:21:56 -0800 (PST)
Message-ID: <53bdeddb4cb0293b2d7f896b5a8943ab10b57037.1708608110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
	<pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 13:21:43 +0000
Subject: [PATCH v2 04/11] Prepare `paint_down_to_common()` for handling
 shallow commits
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `git fetch --update-shallow` needs to test for commit ancestry, it
can naturally run into a missing object (e.g. if it is a parent of a
shallow commit). To accommodate, the merge base logic will need to be
able to handle this situation gracefully.

Currently, that logic pretends that a missing parent commit is
equivalent to a missing parent commit, and for the purpose of
`--update-shallow` that is exactly what we need it to do.

Therefore, let's introduce a flag to indicate when that is precisely the
logic we want.

We need a flag, and cannot rely on `is_repository_shallow()` to indicate
that situation, because that function would return 0: There may not
actually be a `shallow` file, as demonstrated e.g. by t5537.10 ("add new
shallow root with receive.updateshallow on") and t5538.4 ("add new
shallow root with receive.updateshallow on").

Note: shallow commits' parents are set to `NULL` internally already,
therefore there is no need to special-case shallow repositories here, as
the merge-base logic will not try to access parent commits of shallow
commits.

Likewise, partial clones aren't an issue either: If a commit is missing
during the revision walk in the merge-base logic, it is fetched via
`promisor_remote_get_direct()`. And not only the single missing commit
object: Due to the way the "promised" objects are fetched (in
`fetch_objects()` in `promisor-remote.c`, using `fetch
--filter=blob:none`), there is no actual way to fetch a single commit
object, as the remote side will pass that commit OID to `pack-objects
--revs [...]` which in turn passes it to `rev-list` which interprets
this as a commit _range_ instead of a single object. Therefore, in
partial clones (unless they are shallow in addition), all commits
reachable from a commit that is in the local object database are also
present in that local database.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-reach.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 5ff71d72d51..7112b10eeea 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -53,7 +53,8 @@ static int queue_has_nonstale(struct prio_queue *queue)
 static struct commit_list *paint_down_to_common(struct repository *r,
 						struct commit *one, int n,
 						struct commit **twos,
-						timestamp_t min_generation)
+						timestamp_t min_generation,
+						int ignore_missing_commits)
 {
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	struct commit_list *result = NULL;
@@ -108,6 +109,13 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 			if (repo_parse_commit(r, p)) {
 				clear_prio_queue(&queue);
 				free_commit_list(result);
+				/*
+				 * At this stage, we know that the commit is
+				 * missing: `repo_parse_commit()` uses
+				 * `OBJECT_INFO_DIE_IF_CORRUPT` and therefore
+				 * corrupt commits would already have been
+				 * dispatched with a `die()`.
+				 */
 				return NULL;
 			}
 			p->object.flags |= flags;
@@ -143,7 +151,7 @@ static struct commit_list *merge_bases_many(struct repository *r,
 			return NULL;
 	}
 
-	list = paint_down_to_common(r, one, n, twos, 0);
+	list = paint_down_to_common(r, one, n, twos, 0, 0);
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
@@ -214,7 +222,7 @@ static int remove_redundant_no_gen(struct repository *r,
 				min_generation = curr_generation;
 		}
 		common = paint_down_to_common(r, array[i], filled,
-					      work, min_generation);
+					      work, min_generation, 0);
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] = 1;
 		for (j = 0; j < filled; j++)
@@ -504,7 +512,7 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 
 	bases = paint_down_to_common(r, commit,
 				     nr_reference, reference,
-				     generation);
+				     generation, ignore_missing_commits);
 	if (commit->object.flags & PARENT2)
 		ret = 1;
 	clear_commit_marks(commit, all_flags);
-- 
gitgitgadget

