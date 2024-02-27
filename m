Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B913B2AF
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040508; cv=none; b=EgJCsrn4HN11LGHwmaZgDd7SjyqpJ3ZVhx6Rmrf3seHucX8yJKDouFlA3X2BcO8oGOdjmV6NhEeoF/QEV+oHpDLkGH1FA57w97gM79j7KlT3ZLmACoTELoOmfOAaqCqxBtIn8BekLuQQ6aNVB99zag+/ezYb+R1jMo3ELkN5jjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040508; c=relaxed/simple;
	bh=Yb5I4d4X0STAz8HVRFsE5uLAsM9osTqtn183H3EGqBE=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=vGbOuppzLcX9ANfZeBcBz0ryjzL2ojSwT+YjVqjjMyAEKCH6KX+4FBTHg6a8JebPzlrZ9krERf8Y52c+45RbQdq4+BgKQJPBu4wNh2u7f4gv1opYnlh6ZcV7RAhNRjvlPXIfB9h+aPf1UUWBmfJWFOKNJ91xpwf6ZjcMF4oxwDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlCN4Xsg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlCN4Xsg"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4129ed6f514so20367425e9.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 05:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709040503; x=1709645303; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAPyFrwfCmVzEDacD+j6dAGnCBdXEXmFNhgtGhf5Hoc=;
        b=QlCN4XsgW4XVr0biJL3j3ieukXGEtEiayN8n7Ic/EFrwGPwRyqV19oLQ/C2ocQRQ7z
         k3jHkfbX8KDxTm0JegHqYLV1NS1jiv7PU4NyNc49X2O7auH2t5bd9izMRB9YepOGxiZh
         n1NVb9qvRPf32k7BZlLrWOGWZHcpeZv9dcA/orrRkdx4YYIv/QzhmdWWhq9kwK2YKhgv
         NnakTQzoK8gT2jhS2RN4ibBN2nC4iIDona9Z/bnvU8kHWUjaK38u96MjMh4/91eU1hHy
         sIOpQ+DfW3ZmCwn0GLEcohvaMJjiF5rMTXIQVQEjHk46y/ACHcI7FLUqs6mLYd8Yf37i
         vWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709040503; x=1709645303;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAPyFrwfCmVzEDacD+j6dAGnCBdXEXmFNhgtGhf5Hoc=;
        b=iSId93jGkOfVLtR749Jck0myDczt1AJKww0FY5SkCg9yir6dWK/99teuwgZ8MOtXYV
         L/xFgW7GiFS4ezYGslFuzK8K1zqO4NOaqo4iaIdIoOTU5VM3epZp1bvY2aamsoLlPWoY
         t3e58o1+T/urhacB5qVVIy20mXwQIpYw2rC9WwIEFmM7uRPspFRm+MdqUJkAVfCez/XG
         c4HMCHh8/nWiQzrNMBCmIdDdAN90jJiZaCk8TYm8Jeh4YLcfj/lyjL2DrZJUA4Ob32Qi
         TDmf6xBVy8QFDPEpp8tTbctU91uzCDArwqJB9NIK+pzHsy1D7N8x7uUuSVKu/E1htsGQ
         Z04A==
X-Gm-Message-State: AOJu0YyoTt7FbEsRBOQFRTNI9Oh4e0WaE665/JRQu1phC0DvLINwDq0S
	dML+RgkuBmFVvC9WHevQbTPyfYXOEAaEsb5TFAZe06TBrsuVIWLruNQhfFOR
X-Google-Smtp-Source: AGHT+IGAsJ1JlkZbRgmrPtnTLkw1DcWx3xy1VPzeGp+SJTunqRu5EsjnZXEuSOgmT7qGmPF2JYJsyg==
X-Received: by 2002:a05:600c:35c1:b0:412:9064:fd12 with SMTP id r1-20020a05600c35c100b004129064fd12mr6317972wmq.26.1709040503125;
        Tue, 27 Feb 2024 05:28:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1-20020a05600c4f8100b004127ead18aasm11459359wmq.22.2024.02.27.05.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:28:22 -0800 (PST)
Message-ID: <f68d77c612398368f860592a756b95c4d64d3b53.1709040499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Feb 2024 13:28:08 +0000
Subject: [PATCH v3 02/11] Prepare `repo_in_merge_bases_many()` to optionally
 expect missing commits
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

Currently this function treats unrelated commit histories the same way
as commit histories with missing commit objects.

Typically, missing commit objects constitute a corrupt repository,
though, and should be reported as such. The next commits will make it
so, but there is one exception: In `git fetch --update-shallow` we
_expect_ commit objects to be missing, and we do want to treat the
now-incomplete commit histories as unrelated.

To allow for that, let's introduce an additional parameter that is
passed to `repo_in_merge_bases_many()` to trigger this behavior, and use
it in the two callers in `shallow.c`.

This commit changes behavior slightly: unless called from the
`shallow.c` functions that set the `ignore_missing_commits` bit, any
non-existing tip commit that is passed to `repo_in_merge_bases_many()`
will now result in an error.

Note: When encountering missing commits while traversing the commit
history in search for merge bases, with this commit there won't be a
change in behavior just yet, their children will still be interpreted as
root commits. This bug will get fixed by follow-up commits.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-reach.c        | 9 +++++----
 commit-reach.h        | 3 ++-
 remote.c              | 2 +-
 shallow.c             | 5 +++--
 t/helper/test-reach.c | 2 +-
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 7ea916f9ebd..5c1b5256598 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -467,7 +467,7 @@ int repo_is_descendant_of(struct repository *r,
 
 			other = with_commit->item;
 			with_commit = with_commit->next;
-			if (repo_in_merge_bases_many(r, other, 1, &commit))
+			if (repo_in_merge_bases_many(r, other, 1, &commit, 0))
 				return 1;
 		}
 		return 0;
@@ -478,17 +478,18 @@ int repo_is_descendant_of(struct repository *r,
  * Is "commit" an ancestor of one of the "references"?
  */
 int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
-			     int nr_reference, struct commit **reference)
+			     int nr_reference, struct commit **reference,
+			     int ignore_missing_commits)
 {
 	struct commit_list *bases;
 	int ret = 0, i;
 	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
 
 	if (repo_parse_commit(r, commit))
-		return ret;
+		return ignore_missing_commits ? 0 : -1;
 	for (i = 0; i < nr_reference; i++) {
 		if (repo_parse_commit(r, reference[i]))
-			return ret;
+			return ignore_missing_commits ? 0 : -1;
 
 		generation = commit_graph_generation(reference[i]);
 		if (generation > max_generation)
diff --git a/commit-reach.h b/commit-reach.h
index 35c4da49481..68f81549a44 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -30,7 +30,8 @@ int repo_in_merge_bases(struct repository *r,
 			struct commit *reference);
 int repo_in_merge_bases_many(struct repository *r,
 			     struct commit *commit,
-			     int nr_reference, struct commit **reference);
+			     int nr_reference, struct commit **reference,
+			     int ignore_missing_commits);
 
 /*
  * Takes a list of commits and returns a new list where those
diff --git a/remote.c b/remote.c
index abb24822beb..763c80f4a7d 100644
--- a/remote.c
+++ b/remote.c
@@ -2675,7 +2675,7 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
 		if (MERGE_BASES_BATCH_SIZE < size)
 			size = MERGE_BASES_BATCH_SIZE;
 
-		if ((ret = repo_in_merge_bases_many(the_repository, commit, size, chunk)))
+		if ((ret = repo_in_merge_bases_many(the_repository, commit, size, chunk, 0)))
 			break;
 	}
 
diff --git a/shallow.c b/shallow.c
index ac728cdd778..dfcc1f86a7f 100644
--- a/shallow.c
+++ b/shallow.c
@@ -797,7 +797,7 @@ static void post_assign_shallow(struct shallow_info *info,
 		for (j = 0; j < bitmap_nr; j++)
 			if (bitmap[0][j] &&
 			    /* Step 7, reachability test at commit level */
-			    !repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits)) {
+			    !repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits, 1)) {
 				update_refstatus(ref_status, info->ref->nr, *bitmap);
 				dst++;
 				break;
@@ -828,7 +828,8 @@ int delayed_reachability_test(struct shallow_info *si, int c)
 		si->reachable[c] = repo_in_merge_bases_many(the_repository,
 							    commit,
 							    si->nr_commits,
-							    si->commits);
+							    si->commits,
+							    1);
 		si->need_reachability_test[c] = 0;
 	}
 	return si->reachable[c];
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 3e173399a00..aa816e168ea 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -113,7 +113,7 @@ int cmd__reach(int ac, const char **av)
 		       repo_in_merge_bases(the_repository, A, B));
 	else if (!strcmp(av[1], "in_merge_bases_many"))
 		printf("%s(A,X):%d\n", av[1],
-		       repo_in_merge_bases_many(the_repository, A, X_nr, X_array));
+		       repo_in_merge_bases_many(the_repository, A, X_nr, X_array, 0));
 	else if (!strcmp(av[1], "is_descendant_of"))
 		printf("%s(A,X):%d\n", av[1], repo_is_descendant_of(r, A, X));
 	else if (!strcmp(av[1], "get_merge_bases_many")) {
-- 
gitgitgadget

