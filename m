Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685938382
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113476; cv=none; b=XL3Va+FHU/TDIvyawtZzFQWvg505+kERvom4kpt9xjOEam6tXtRhSL2BGQVD49HRhCQva0Bsiud+HmEh5V87by5G33IhI+r1ZaTC5fSeRwqKkStf4rP0DwOtRU8ZiFZsrEdwOwn0YFb2kXoCCj10H6w1Z5SHEJv9ckYRW83OBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113476; c=relaxed/simple;
	bh=uUQNL0od1oMn7vXGsbgCKQTOwHHPzad6NzkO2pHChtI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=t01QSDaCStCWbyB/HWSPRRJAxOUIT3Lm6J5F7FcNoyt0fiTp3+YWMNzkV24YLFXcsE5+wIhld5blvTk81tCK5jgsaKnUAIsX/8rFUqk7EjBnRq7tbqMH8Wq4Krj0lctwLuRRgLE9Lvz32MGhDqvb4Gej1vP31SzZsTD64/KMgko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTRZwAsc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTRZwAsc"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412b20dc555so6072935e9.3
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 01:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709113469; x=1709718269; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XsEf3s0TKiM2Ue3xAGxzobH6M9HSAepTLtXiRkRGqQ=;
        b=aTRZwAscNL4nLZZWJyv4k6wXjhihmvaXM4FH9fEVi97VQUiN0RVOcWh+KDxv2E0BPj
         /pSiHJ+X1oyKGTRsOKQXTj4taGROWUZDMsu11/8XLvxsEAkCNUZO6182DzoQTGyFveDg
         tSVWhd/u8Nzapi/UJpLdCgBIgWJR0sEQxgZdsutcwhYYTtARx8cv+x3EIpo7ieM9xddK
         wq1YZV6szHIRMC76lWxj9P+xuwK69xWH17VVj34T54WMkxdxVoqRYWAjEY0/Qh3CMOly
         ysmE1bKhOkFckd6w7AfB8BD/dyri5hQz7Ax79r4R5SRyqZ1XQykZx8liHKwq9P2f4rMO
         XvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709113469; x=1709718269;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XsEf3s0TKiM2Ue3xAGxzobH6M9HSAepTLtXiRkRGqQ=;
        b=Au8IXtfR28xTuyRC/coMyJ2CfK4I6ArsHUW/7Ut9oUDAgczWFsjOs+THdd0kg7FHJm
         Bc7KcVFv2Y7sEd0PdxEpMHK40LhL5lS+m94MLWfK7j1X+9bhDo2JId15KAmDcgX/iwSu
         wXHQ2IMpuyeGo7aqGtpvTGrWE+l+nyueQzN+EX2J3RtvfVXdSteXeyhBb2mpAux+q6CJ
         7z/GKb5iYSOrMQ10pzq+USEmUOyQiZbgkzM53eNt9VRMZ5tUP9DqiTzwN5AkZW0eGR/d
         Xtue7W3Lqp0wByieuQgAGYX+UwotsHFPYuICcNFCatYK1wVZNS9dD4nDmw93TbCi7HfW
         3v8g==
X-Gm-Message-State: AOJu0Yz3N1uwWlMaRo2+1sIlfRKHKTeYsXGQ/TapjyuPNtFXydg2aF5W
	xKdZukda1XARoCEWyejV/sn9+J7DboLzOH2P6cdo39hwUku24OSngSpO+ep4
X-Google-Smtp-Source: AGHT+IGoTQ9H0ceMo98wnEQIx2FjFdicXpgJmaeyUNM7vHk1t8w0hCxngdZY31gp61Y4RDy81OV30w==
X-Received: by 2002:a05:600c:198e:b0:412:a392:23b3 with SMTP id t14-20020a05600c198e00b00412a39223b3mr6825231wmq.25.1709113469628;
        Wed, 28 Feb 2024 01:44:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jn5-20020a05600c6b0500b0041228b2e179sm1513292wmb.39.2024.02.28.01.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:44:28 -0800 (PST)
Message-ID: <b7ef90a57f0b8ec81bc3df484d981e89c5ed4057.1709113458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
References: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 28 Feb 2024 09:44:15 +0000
Subject: [PATCH v4 09/11] commit-reach(get_octopus_merge_bases): pass on
 "missing commits" errors
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
    Dirk Gouders <dirk@gouders.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `merge_bases_many()` function was just taught to indicate parsing
errors, and now the `repo_get_merge_bases()` function (which is also
surfaced via the `get_merge_bases()` macro) is aware of that, too.

Naturally, the callers need to be adjusted now, too.

Next step: adjust `repo_get_merge_bases_many()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/merge-base.c |  8 ++++++--
 builtin/merge.c      |  6 +++++-
 builtin/pull.c       |  5 +++--
 commit-reach.c       | 20 +++++++++++---------
 commit-reach.h       |  2 +-
 5 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 0308fd73289..2edffc5487e 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -77,13 +77,17 @@ static int handle_independent(int count, const char **args)
 static int handle_octopus(int count, const char **args, int show_all)
 {
 	struct commit_list *revs = NULL;
-	struct commit_list *result, *rev;
+	struct commit_list *result = NULL, *rev;
 	int i;
 
 	for (i = count - 1; i >= 0; i--)
 		commit_list_insert(get_commit_reference(args[i]), &revs);
 
-	result = get_octopus_merge_bases(revs);
+	if (get_octopus_merge_bases(revs, &result) < 0) {
+		free_commit_list(revs);
+		free_commit_list(result);
+		return 128;
+	}
 	free_commit_list(revs);
 	reduce_heads_replace(&result);
 
diff --git a/builtin/merge.c b/builtin/merge.c
index ac9d58adc29..94c5b693972 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1526,7 +1526,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	} else {
 		struct commit_list *list = remoteheads;
 		commit_list_insert(head_commit, &list);
-		common = get_octopus_merge_bases(list);
+		if (get_octopus_merge_bases(list, &common) < 0) {
+			free(list);
+			ret = 2;
+			goto done;
+		}
 		free(list);
 	}
 
diff --git a/builtin/pull.c b/builtin/pull.c
index e6f2942c0c5..0c5a55f2f4d 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -820,7 +820,7 @@ static int get_octopus_merge_base(struct object_id *merge_base,
 		const struct object_id *merge_head,
 		const struct object_id *fork_point)
 {
-	struct commit_list *revs = NULL, *result;
+	struct commit_list *revs = NULL, *result = NULL;
 
 	commit_list_insert(lookup_commit_reference(the_repository, curr_head),
 			   &revs);
@@ -830,7 +830,8 @@ static int get_octopus_merge_base(struct object_id *merge_base,
 		commit_list_insert(lookup_commit_reference(the_repository, fork_point),
 				   &revs);
 
-	result = get_octopus_merge_bases(revs);
+	if (get_octopus_merge_bases(revs, &result) < 0)
+		exit(128);
 	free_commit_list(revs);
 	reduce_heads_replace(&result);
 
diff --git a/commit-reach.c b/commit-reach.c
index b2e90687f7c..288d3d896a2 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -176,24 +176,26 @@ static int merge_bases_many(struct repository *r,
 	return 0;
 }
 
-struct commit_list *get_octopus_merge_bases(struct commit_list *in)
+int get_octopus_merge_bases(struct commit_list *in, struct commit_list **result)
 {
-	struct commit_list *i, *j, *k, *ret = NULL;
+	struct commit_list *i, *j, *k;
 
 	if (!in)
-		return ret;
+		return 0;
 
-	commit_list_insert(in->item, &ret);
+	commit_list_insert(in->item, result);
 
 	for (i = in->next; i; i = i->next) {
 		struct commit_list *new_commits = NULL, *end = NULL;
 
-		for (j = ret; j; j = j->next) {
+		for (j = *result; j; j = j->next) {
 			struct commit_list *bases = NULL;
 			if (repo_get_merge_bases(the_repository, i->item,
 						 j->item, &bases) < 0) {
 				free_commit_list(bases);
-				return NULL;
+				free_commit_list(*result);
+				*result = NULL;
+				return -1;
 			}
 			if (!new_commits)
 				new_commits = bases;
@@ -202,10 +204,10 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 			for (k = bases; k; k = k->next)
 				end = k;
 		}
-		free_commit_list(ret);
-		ret = new_commits;
+		free_commit_list(*result);
+		*result = new_commits;
 	}
-	return ret;
+	return 0;
 }
 
 static int remove_redundant_no_gen(struct repository *r,
diff --git a/commit-reach.h b/commit-reach.h
index 2c6fcdd34f6..4690b6ecd0c 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -21,7 +21,7 @@ struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
 						    struct commit *one, int n,
 						    struct commit **twos);
 
-struct commit_list *get_octopus_merge_bases(struct commit_list *in);
+int get_octopus_merge_bases(struct commit_list *in, struct commit_list **result);
 
 int repo_is_descendant_of(struct repository *r,
 			  struct commit *commit,
-- 
gitgitgadget

