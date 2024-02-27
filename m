Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D2C13B78F
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040508; cv=none; b=JJXePDbWKo0tydWDnHg49YWq/oCZlJ399rbVX4RvLolyy8oXp/2KIwWRkXmyJhIjKB9Ta/t9i9yauAD48hYblqJpmbwQGlFCHZWTWPNahX0KPcsYUze0GQNYzCntJRYG7YXXIEzCuDr9D4b5mjteQBfgCUKuIiPev+8A8e4UBHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040508; c=relaxed/simple;
	bh=XK+Coh5PwwNEzPwXMw8DdCAp0qD9ozktfiVc/5uk2rQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PbT1fjxx9rqzGEVXrYuZv1/Fgn8MAnMhsiTnWGbOD5iSLBmPQdHf871bwpnHahO6j6dD9kK4amv/VpvJ/r/kzZc/PuNBl7JJaklL2EA2znKPr37d04R4BPEBXD1MYrUJvXkguI3zVaepjr+stbojSH1iVdM0omPdcXqO/U5c7O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/TS1Wcx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/TS1Wcx"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d32f74833so2363831f8f.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 05:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709040505; x=1709645305; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH5F4ez2NmzNeSHSGewWiOcbU5KriPIckDGLw8M93Tw=;
        b=V/TS1WcxWWg5fhwiss87tqTYnwB8C85fnAyCYi1KjMvvXZn+K9qB42ncf9NxfsXgq1
         qVmpkcveDXQw5pHcF3p3hDOkxOsM6OxpNz5w0YMpwg9TzNfSdASqOfOQ9uYypG+rtjpo
         wKd/p7Tasy7eH9cfuJkf5wxs6tvLLDpWjGZ6nTVcTnHuoa9Vv8t40xFEO97rCGp4+OmP
         EDAWRU2isMvMF8SC34Pu91LGe9v0CCU5sYDCFrj/IHBBSs8TjtD8wbr/esX8lsvnnS+C
         QSQrCZpRPs5q/rM/c/gvKwgKZnKHoDNrZqdTfqO6F6sdNep23136LZODcAi1HKIr+Yva
         Eaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709040505; x=1709645305;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FH5F4ez2NmzNeSHSGewWiOcbU5KriPIckDGLw8M93Tw=;
        b=bWNjArehR1B1r94YpcaTaZv4FQ5c824UEX9uNw1YZLLx+rnnMH0PVtx+cXrn5vvQnC
         aDKJdVotrm8uq74CXmI8nCPRLMpUcElawG5K+H9aZs5i3GL50cVEPeRmDyLCxNNYSQO7
         y09pAoBszqJhc5S6Rz9JYCEZyHgj2+BC780Re9PBXMdVAnMklG5m9GJLbDTHpM05ZMgZ
         Vimn936yFz3guZZCF5H2McWXUXwcSZxCQVTOO/meUAxuaErPcEjI3ZTASf/srT1AXulf
         +r4qJOSdGOQm+Ip/LkBkAEKbMKCKdT81XZhJOqVX7mIWdfCrFRnKE/wOLwDxr1TtOVXA
         GKRg==
X-Gm-Message-State: AOJu0Yx2BOZoPHEPFcDKXmC986GKk6STEekQpsxFlvJeE60zA6JdvkHy
	HSJVKdTo0siUtkVcks8wXDMqPCCcUDBei1EjgGCoJhbYJ1Es3Yj/B6B8Ansr
X-Google-Smtp-Source: AGHT+IG8yUNBttwyzEDASyBqdYuGxQ2b96lRsxCh1BvP5iTchvzjZ11QKGjtQJXkJfzfUsU7txI/aA==
X-Received: by 2002:a5d:6b0f:0:b0:33d:c65a:b5dd with SMTP id v15-20020a5d6b0f000000b0033dc65ab5ddmr5609782wrw.63.1709040504790;
        Tue, 27 Feb 2024 05:28:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bp19-20020a5d5a93000000b0033d4c3b0beesm11848272wrb.19.2024.02.27.05.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:28:24 -0800 (PST)
Message-ID: <84e7fbc07e08956e6c493baf499fee455887b16c.1709040499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Feb 2024 13:28:10 +0000
Subject: [PATCH v3 04/11] Prepare `paint_down_to_common()` for handling
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

