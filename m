Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A6E1474D4
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608127; cv=none; b=Tw5dF5r6VsRBw+nLQb3xloWtsopE0SPibL0W7EiOlHBdUnkP+++nmdI5IGehWwDpY0jVG+EFQiGfn/R58zo2ZghlhheGGHlSlKBnd2SMHwkKLjHz+aAJpEeHKNbTwIdqoWDwFg3DmA2338RA+2qgy2wU5byt+J+VLwHsT1i9tTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608127; c=relaxed/simple;
	bh=hzRxdBrl2ByI5HBj9L44tIXXHO2fkT2SNobbwjCZPCg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eYF4a3XZBJpk3cWTvfvArCUZ5tf24qkdU3OYw4lrCWAmH48uaJLFNldgNRlUpSVks4YUvlYtFmYAzPwRcyOo6evQsLuMPq/4JeAX2EiAwDk/Qxi9097cLRT04kRK6+/OOSpOwx4RTctSp5ep7uOSYxZEY12VmAxATE5mSaUn8gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0THHLty; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0THHLty"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0e520362cso79211431fa.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 05:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708608122; x=1709212922; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjZk1iDVFshalJ84DkUa03UuxpWms0aWmK5IcaENZJk=;
        b=N0THHLtyfMdQ7GHovQgFMS7LbzOG4gVaqQzOexn046OomtKHZvjwoNq4KirghICYF9
         M5+P1G62wBBrsTDwj+lfF7xybivSJ2EHI8MGfK4jS1JA1iZc5hxK2883BoHHP8U68TKA
         5Fg8RjFqVxN0dZCCC2fJOY1FGXZViBaplZF9jlA31uAZjW1rrvt9vNCU1Z5hOlvwenBv
         T1QSNBDSewfT/VlLOxJX6mu+i+LLoChxrEY4ZOzZ66jfbCtyDFsGqHGvopIQPAJKSVs7
         uihIPtUW/PBmuoS9E6zcepDnUXN9UzXK29Nd6TNZ1DLhj90tOXXeQQ00Ka9ntZIDt9XN
         udyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608122; x=1709212922;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjZk1iDVFshalJ84DkUa03UuxpWms0aWmK5IcaENZJk=;
        b=Zrq+mg48Xm+GxaZ00Z5WP2Nnq8H9J/wXAVhYhtGltgtOWtpX0D5SD1vRV4uawG04ZF
         qtYkY7VkJHOcVgfEHlNd7U1oNQWW3H1USNuq5gOvN3UdQIPKeWE3ZxJ9w6FeiqgEIlM2
         05fi1cCPdTPX8Oy1/vA+Xq4djZ6/zBNNU4bcqz0GaT+dIVX+HNjGpl+Ooc6I8OnfyRRK
         LxcMswyhlw38ddKir7L+PyY+BxXRwkP3e2Y7oJ8iFEeJRLTl+Lyg0xNYn5L6ZL5+Pyki
         n6WGVPlD321UD/e/KjsJNrP35GXg1a3CUR7EUhP7iIZfYvVuM1AD4ytxmFjzRHGnqq+V
         96Gw==
X-Gm-Message-State: AOJu0YzDBLcJJ3UVlndqXkUq71pMOo2E2SlDHPqEpnUa7AYlcYxTlU1b
	5+jgNeywQcug3zUEJpa/Y0SNKsCjLlDWhU+syt6+2hpeGmAUKW53uPpSFfvJ
X-Google-Smtp-Source: AGHT+IH0EHNRZO7GhN9Ia88yxNRVMEWatHWRkW2b0DFeKQONlR+AlxJ4y87bygjQyu0j0tegtjS2SQ==
X-Received: by 2002:a2e:8552:0:b0:2d2:4465:1146 with SMTP id u18-20020a2e8552000000b002d244651146mr6211952ljj.53.1708608122444;
        Thu, 22 Feb 2024 05:22:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p24-20020a05600c1d9800b0041273e84fe1sm6624004wms.25.2024.02.22.05.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:22:01 -0800 (PST)
Message-ID: <b11879edb732263f2f77bc6a38b79db6a8f93826.1708608110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
	<pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 13:21:48 +0000
Subject: [PATCH v2 09/11] get_octopus_merge_bases(): pass on errors from
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
Cc: Patrick Steinhardt <ps@pks.im>,
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
index 10e625ff51b..fa21a8f2f6b 100644
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

