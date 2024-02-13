Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843F722630
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813722; cv=none; b=fJ/3YSzklMQU48GC5XnB8meDjhd7PIEeb+AE6HjIbYgX6DZ3FHpLh/oQBKj2AgNi14Ic3vDHH9yELfphLiELrk8tRyUqzLNnHozen2L5ddG6E63JaYv/BLPzBkkW3CnvBDY8X0EnkhUSnUHkuML1Kr93rPwPeBbLBCoKYtNuRPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813722; c=relaxed/simple;
	bh=RhPaQ9InCTyM16u1KIe3bU05+wmkCgkLhP5S3cx0sSM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=b6gSQ7d6tDDkvvejix8//pwsYmx3aD4n2nxDCDwvHslCpEw351ZkjKSPyyfP0b8aoSmRUTNvdcYHQ3eYKIt2zmMZr5nI7ZipYbbaLtGAeGDouNSAFklUte4lWPs6hPmIrHrP5IpyYEj/CIzVrcZICMlqLJNynCKrpWDhnhrrgI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSVtPpib; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSVtPpib"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so2913306f8f.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707813718; x=1708418518; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpWtaL7xg4+HRBnHxJRTgSdwPDTJo7o4ScowL/W2lcI=;
        b=VSVtPpibe99K8wRckxh5NlMwvtWCFqqPfhDMQFc5jOxeCmqGvMaMcCuBEhMEsc7W04
         BKYM3Z8BfbMzBXKVM3fYTx4+jNNl8rMZKUBGH0QlKX0iqS+UAa76BX4HvJo3WTLQu8rk
         jXpPnFfXUQddPX3xcjgLQjA6Hu6woLH5MS7BIMRw91H2uiC9kNJFJSTHy6FE4yfMJ7uB
         zdR6r2MYciqaJQV0QUR1/wUmSua0X/PymUgKdpo6ueXko1uN+NY60+UtQ0hD+7u8521i
         U/ZPAwfUgmc9slXv+8npsAeW1z8rHpauWW1aXyatbrD5raKi3WC40ohakK5gJeppGXSu
         1N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813718; x=1708418518;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpWtaL7xg4+HRBnHxJRTgSdwPDTJo7o4ScowL/W2lcI=;
        b=BK0CdWlpjX0CFTeUXNhsHv0ZEoRTu31fQ9k5Icr1NJ/jJUFgGOcGUNG/LAszvb/J4Y
         G7Mv1S6wQBUs7p8AyTsy4LCABzidOZaXaHPL4ZhsJl344zl5988Z/TXknIrexKawsiR/
         zx6Rw7Zx8qM0z//DvOOav+NgJbwijhVrf3CQAwQaVvyTlqFFEjcBxGhiYmNTIi4DAdbS
         XzmJU2C5q3nFspw8mfWbya5T37nqc9pS1DINrJwVYQf/LMNh1BvaB4ysROrr2OIMzqh9
         dW6Aj1VZFrp6Zkx7UByfgitOhnqKiElC7vMBCTnvyAXespFx0MbnIQVpVB4DCLq7zLp5
         wIOA==
X-Gm-Message-State: AOJu0Yy7FBAKluWjF5XGzg3NmFKuv8TBM4xynlNkHYjiwcxeXQ+Jnkmt
	IC6S4BZ68/BpRaHHMIzTOGJwdgbCWWAfM78fIzfUJitpWavVYEWLxod2ZPJL
X-Google-Smtp-Source: AGHT+IF8fJzasbPGYpmojb3Hy22nkvzpq8QQls+rBrWfk2T0DfaKFyAhUT5b3RSx08Gw0Fe0l3bxNQ==
X-Received: by 2002:a5d:554e:0:b0:33a:ee4d:98c8 with SMTP id g14-20020a5d554e000000b0033aee4d98c8mr6445913wrw.61.1707813718135;
        Tue, 13 Feb 2024 00:41:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay20-20020a5d6f14000000b0033b495b1d10sm9154883wrb.8.2024.02.13.00.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:41:57 -0800 (PST)
Message-ID: <7fbf660e371454b309d962624d5121c87aed1e85.1707813709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 08:41:45 +0000
Subject: [PATCH 09/12] get_octopus_merge_bases(): pass on errors from
 `merge_bases_many()`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `merge_bases_many()` function was just taught to indicate parsing
errors, and now the `repo_get_merge_bases()` function (which is also
surfaced via the `get_merge_bases()` macro) is aware of that, too.

Naturally, the callers need to be adjusted now, too.

Next step: adjust `repo_get_merge_bases_many()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/merge-base.c |  5 +++--
 builtin/merge.c      |  6 +++++-
 builtin/pull.c       |  5 +++--
 commit-reach.c       | 20 +++++++++++---------
 commit-reach.h       |  2 +-
 5 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 0308fd73289..6faabfb6698 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -77,13 +77,14 @@ static int handle_independent(int count, const char **args)
 static int handle_octopus(int count, const char **args, int show_all)
 {
 	struct commit_list *revs = NULL;
-	struct commit_list *result, *rev;
+	struct commit_list *result = NULL, *rev;
 	int i;
 
 	for (i = count - 1; i >= 0; i--)
 		commit_list_insert(get_commit_reference(args[i]), &revs);
 
-	result = get_octopus_merge_bases(revs);
+	if (get_octopus_merge_bases(revs, &result) < 0)
+		return 128;
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
index 3471c933f6c..1b618eb9cd1 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -172,24 +172,26 @@ static int merge_bases_many(struct repository *r,
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
@@ -198,10 +200,10 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
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

