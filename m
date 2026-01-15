Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BAD35C1B0
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469772; cv=none; b=REWAPYOoIVBl0wc7fDsI06rbG3pKl5L+WnqHjWpjTHHRAeja1yJnrLeYDOUQYZnqDG+JJAlQ953yUm1RO6ZdtR6kWuzzBFW+cjUIE6G56U9z+riYLHeYM7MyUeQYiOTZeSuawaMuusT1uiWegpB+4D8itfqM4Bngo7Ag5F/HiB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469772; c=relaxed/simple;
	bh=LawE8jORUvf8EWEM1xV1Kgi8FLY3co5vJUfp/2W/BTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hTeP5mOlvkZ07tSLSOrTezyoM6rP5WQfBM/LhSKmxqq/O1qH69SpwZz9z6QnDJeUnLmwVMB78jvIvT2v8foPdux9+t4QmZvR1vyfjTnELZqoAKajwDQ4od2sH4mvInBAFs8x1u7U641jdaZdmsiT83a+rNg37gmxZll2r0CXEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WOVFiE2G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BI3+xdkb; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WOVFiE2G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BI3+xdkb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 05BB81D00047
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 04:36:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 15 Jan 2026 04:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768469768;
	 x=1768556168; bh=VTSpMFjU19kXHbbOzwJlNoktIR9aSX8LBn0Iiw37vWc=; b=
	WOVFiE2GHEPG1dGjvWH5R8PYfoaRMzNgZx1ibjMYDSbdKEIX0uFsEUSV3/HfbfLE
	slEZ4FFaDMNIWV+GQSBGXxZ/X28CIA4YN6XE4fch7g7SaWhygtEqHXvTFUrK6dVS
	XYqvbfbBu1PDZCbfjmBv/l56fK1FnHMDo6Oe0LKihAqoMvhg+9jwU/5KpE0bGzYb
	anzCWR6nPwcXjzOlGzWsxr8bpAiApcOtalE9hey072xLJMKJKdlS2W3Qg8ABnvAc
	jBqY2e4efTFNW0Xc2tjeaUcu3yD7kyUFPo/jEfgLn11rujz8lLzfOaA7Rk+tP4Nm
	p3o2HoPLxTUGkHFnv7HYLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768469768; x=
	1768556168; bh=VTSpMFjU19kXHbbOzwJlNoktIR9aSX8LBn0Iiw37vWc=; b=B
	I3+xdkbjVbUm24SKNleA1A3JomCoXbypmpHst80vt+St75oeWz4onaaRbFHieUXO
	DP0Bm0cAYDomO4jzcVx1os9SIRmYSGwmWbR/pw4s4onVionohEM2wfdkdcKUGRM1
	PoOkRxGuUugh+8bNpFOmFQMkNmWhk00kHl2K8CnL3aq3S/LzbvJtyzkmtEwTMLTE
	Gn9ubzNg+ychWx4uh7Lae5HUrbv9S89KtDIIcUo8K9C6uofqjtH9PLoe50Gypcm+
	IKEaMlA2wLT8JVzudPz5FD2hSbRRTvuyg71ueSjWiOjDfWUqnhwTYCbvLaOOzEOW
	S9j/freSOpOtsYGT3jsTA==
X-ME-Sender: <xms:CLVoaeK6_m0cMVL5orISx_nO0w6cLr7ydhVlUUgwT2rSky3NQ8gl-w>
    <xme:CLVoadGyVJwUSBIquIbk3dPHqgT2AkA6iGEEJf9yVGWhKt8c5aoJj-6Le9qKNTZcf
    7843HPpEu3AibGgyyNmEv07quFUDyB2f7IhubZ-OwRbdQcCNjFK3A>
X-ME-Received: <xmr:CLVoaUVUhjs4NzJp95Jy2xJmBNP8vGyzYJMkisfJJEIhb0zR-buCorQSGmCHtIMxOGDTroJ9VxoZanOsXoC7WXdw_RPXkHDMhMHlokPz5TN0eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:CLVoaYhg-fUYdId6J-rzkwu0KKK6pcnGk0kT5jAnZk3ZMcujKH4XKg>
    <xmx:CLVoaVQ_bVaZ3GKTaN_JqzXXRDAg_ANeddytq1Eq8QBFb2aw_bQFHg>
    <xmx:CLVoabFbhO4-KGbTBWvc9vtpTY1DPf-Pe8hw8S6gxpEFwSq0ZKcU6A>
    <xmx:CLVoadkZ54ytHjhyYeAcqVbuNdfHJjaQSgirofm5w6eMbCb5VmaGbA>
    <xmx:CLVoafrhpoaAqZh-taa7t1TlYB3P346XiaKdPmVVDJZqd3SQRnCtJAgv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 04:36:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4976bc4f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 09:36:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Jan 2026 10:35:34 +0100
Subject: [PATCH 3/3] commit: rename `free_commit_list()` to conform to
 coding guidelines
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pks-commit-list-coding-guidelines-v1-3-c58868dbf412@pks.im>
References: <20260115-pks-commit-list-coding-guidelines-v1-0-c58868dbf412@pks.im>
In-Reply-To: <20260115-pks-commit-list-coding-guidelines-v1-0-c58868dbf412@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Our coding guidelines say that:

  Functions that operate on `struct S` are named `S_<verb>()` and should
  generally receive a pointer to `struct S` as first parameter.

While most of the functions related to `struct commit_list` already
follow that naming schema, `free_commit_list()` doesn't.

Rename the function to address this and adjust all of its callers. Add a
compatibility wrapper for the old function name to ease the transition
and avoid any semantic conflicts with in-flight patch series. This
wrapper will be removed once Git 2.53 has been released.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c                      | 12 ++++++------
 blame.c                       |  2 +-
 builtin/am.c                  |  2 +-
 builtin/commit-tree.c         |  2 +-
 builtin/commit.c              |  2 +-
 builtin/describe.c            |  2 +-
 builtin/diff-tree.c           |  2 +-
 builtin/gc.c                  |  2 +-
 builtin/log.c                 | 12 ++++++------
 builtin/merge-base.c          | 14 +++++++-------
 builtin/merge-tree.c          |  2 +-
 builtin/merge.c               | 16 ++++++++--------
 builtin/pull.c                |  8 ++++----
 builtin/rebase.c              |  4 ++--
 builtin/rev-list.c            |  2 +-
 builtin/show-branch.c         |  2 +-
 builtin/stash.c               | 10 +++++-----
 commit-graph.c                |  2 +-
 commit-reach.c                | 30 +++++++++++++++---------------
 commit.c                      | 12 ++++++------
 commit.h                      |  7 ++++++-
 contrib/coccinelle/free.cocci |  8 ++++----
 diff-lib.c                    |  2 +-
 fmt-merge-msg.c               |  2 +-
 line-log.c                    |  2 +-
 log-tree.c                    |  2 +-
 merge-ort-wrappers.c          |  2 +-
 merge-ort.c                   |  2 +-
 notes-merge.c                 |  4 ++--
 notes-utils.c                 |  2 +-
 object-name.c                 |  8 ++++----
 pack-bitmap-write.c           |  6 +++---
 ref-filter.c                  |  8 ++++----
 reflog.c                      |  4 ++--
 remote.c                      |  2 +-
 revision.c                    | 32 ++++++++++++++++----------------
 sequencer.c                   | 16 ++++++++--------
 shallow.c                     |  4 ++--
 submodule.c                   |  4 ++--
 t/helper/test-reach.c         | 10 +++++-----
 40 files changed, 136 insertions(+), 131 deletions(-)

diff --git a/bisect.c b/bisect.c
index 326b59c0dc..b313f13240 100644
--- a/bisect.c
+++ b/bisect.c
@@ -257,7 +257,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 			p = p->next;
 	}
 	if (p) {
-		free_commit_list(p->next);
+		commit_list_free(p->next);
 		p->next = NULL;
 	}
 	strbuf_release(&buf);
@@ -438,7 +438,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	if (best) {
 		if (!(bisect_flags & FIND_BISECTION_ALL)) {
 			list->item = best->item;
-			free_commit_list(list->next);
+			commit_list_free(list->next);
 			best = list;
 			best->next = NULL;
 		}
@@ -559,8 +559,8 @@ struct commit_list *filter_skipped(struct commit_list *list,
 		} else {
 			if (!show_all) {
 				if (!skipped_first || !*skipped_first) {
-					free_commit_list(next);
-					free_commit_list(filtered);
+					commit_list_free(next);
+					commit_list_free(filtered);
 					return list;
 				}
 			} else if (skipped_first && !*skipped_first) {
@@ -879,7 +879,7 @@ static enum bisect_error check_merge_bases(size_t rev_nr, struct commit **rev, i
 		}
 	}
 
-	free_commit_list(result);
+	commit_list_free(result);
 	return res;
 }
 
@@ -1142,7 +1142,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 
 	res = bisect_checkout(bisect_rev, no_checkout);
 cleanup:
-	free_commit_list(tried);
+	commit_list_free(tried);
 	release_revisions(&revs);
 	strvec_clear(&rev_argv);
 	return res;
diff --git a/blame.c b/blame.c
index cb0b083423..a3c49d132e 100644
--- a/blame.c
+++ b/blame.c
@@ -2368,7 +2368,7 @@ static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit
 		if (revs->first_parent_only &&
 		    commit->parents &&
 		    commit->parents->next) {
-			free_commit_list(commit->parents->next);
+			commit_list_free(commit->parents->next);
 			commit->parents->next = NULL;
 		}
 		return commit->parents;
diff --git a/builtin/am.c b/builtin/am.c
index 277c2e7937..97a7b1d46a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1726,7 +1726,7 @@ static void do_commit(const struct am_state *state)
 
 	run_hooks(the_repository, "post-applypatch");
 
-	free_commit_list(parents);
+	commit_list_free(parents);
 	strbuf_release(&sb);
 }
 
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 5189e685a7..30535db131 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -154,7 +154,7 @@ int cmd_commit_tree(int argc,
 	ret = 0;
 
 out:
-	free_commit_list(parents);
+	commit_list_free(parents);
 	strbuf_release(&buffer);
 	return ret;
 }
diff --git a/builtin/commit.c b/builtin/commit.c
index 0aa3690b04..b1315b512b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1978,7 +1978,7 @@ int cmd_commit(int argc,
 
 cleanup:
 	free_commit_extra_headers(extra);
-	free_commit_list(parents);
+	commit_list_free(parents);
 	strbuf_release(&author_ident);
 	strbuf_release(&err);
 	strbuf_release(&sb);
diff --git a/builtin/describe.c b/builtin/describe.c
index 989a78d715..abfe3525a5 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -558,7 +558,7 @@ static void process_object(struct object *obj, const char *path, void *data)
 			describe_commit(pcd->current_commit, pcd->dst);
 			strbuf_addf(pcd->dst, ":%s", path);
 		}
-		free_commit_list(pcd->revs->commits);
+		commit_list_free(pcd->revs->commits);
 		pcd->revs->commits = NULL;
 	}
 }
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 49dd4d00eb..cd35d1c915 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -33,7 +33,7 @@ static int stdin_diff_commit(struct commit *commit, const char *p)
 		struct commit *parent = lookup_commit(the_repository, &oid);
 		if (!pptr) {
 			/* Free the real parent list */
-			free_commit_list(commit->parents);
+			commit_list_free(commit->parents);
 			commit->parents = NULL;
 			pptr = &(commit->parents);
 		}
diff --git a/builtin/gc.c b/builtin/gc.c
index 92c6e7b954..6c529c429e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1166,7 +1166,7 @@ static int dfs_on_ref(const struct reference *ref, void *cb_data)
 		}
 	}
 
-	free_commit_list(stack);
+	commit_list_free(stack);
 	return result;
 }
 
diff --git a/builtin/log.c b/builtin/log.c
index 5c9a8ef363..d43ca693bf 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -424,7 +424,7 @@ static int cmd_log_walk_no_free(struct rev_info *rev)
 			 */
 			free_commit_buffer(the_repository->parsed_objects,
 					   commit);
-			free_commit_list(commit->parents);
+			commit_list_free(commit->parents);
 			commit->parents = NULL;
 		}
 		if (saved_nrl < rev->diffopt.needed_rename_limit)
@@ -1697,12 +1697,12 @@ static struct commit *get_base_commit(const struct format_config *cfg,
 				if (die_on_failure) {
 					die(_("could not find exact merge base"));
 				} else {
-					free_commit_list(base_list);
+					commit_list_free(base_list);
 					return NULL;
 				}
 			}
 			base = base_list->item;
-			free_commit_list(base_list);
+			commit_list_free(base_list);
 		} else {
 			if (die_on_failure)
 				die(_("failed to get upstream, if you want to record base commit automatically,\n"
@@ -1732,14 +1732,14 @@ static struct commit *get_base_commit(const struct format_config *cfg,
 				if (die_on_failure) {
 					die(_("failed to find exact merge base"));
 				} else {
-					free_commit_list(merge_base);
+					commit_list_free(merge_base);
 					free(rev);
 					return NULL;
 				}
 			}
 
 			rev[i] = merge_base->item;
-			free_commit_list(merge_base);
+			commit_list_free(merge_base);
 		}
 
 		if (rev_nr % 2)
@@ -2610,7 +2610,7 @@ int cmd_cherry(int argc,
 		print_commit(sign, commit, verbose, abbrev, revs.diffopt.file);
 	}
 
-	free_commit_list(list);
+	commit_list_free(list);
 	free_patch_ids(&ids);
 	return 0;
 }
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 3f82781245..c7ee97fa6a 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -15,7 +15,7 @@ static int show_merge_base(struct commit **rev, size_t rev_nr, int show_all)
 
 	if (repo_get_merge_bases_many_dirty(the_repository, rev[0],
 					    rev_nr - 1, rev + 1, &result) < 0) {
-		free_commit_list(result);
+		commit_list_free(result);
 		return -1;
 	}
 
@@ -28,7 +28,7 @@ static int show_merge_base(struct commit **rev, size_t rev_nr, int show_all)
 			break;
 	}
 
-	free_commit_list(result);
+	commit_list_free(result);
 	return 0;
 }
 
@@ -71,7 +71,7 @@ static int handle_independent(int count, const char **args)
 	for (rev = revs; rev; rev = rev->next)
 		printf("%s\n", oid_to_hex(&rev->item->object.oid));
 
-	free_commit_list(revs);
+	commit_list_free(revs);
 	return 0;
 }
 
@@ -85,11 +85,11 @@ static int handle_octopus(int count, const char **args, int show_all)
 		commit_list_insert(get_commit_reference(args[i]), &revs);
 
 	if (get_octopus_merge_bases(revs, &result) < 0) {
-		free_commit_list(revs);
-		free_commit_list(result);
+		commit_list_free(revs);
+		commit_list_free(result);
 		return 128;
 	}
-	free_commit_list(revs);
+	commit_list_free(revs);
 	reduce_heads_replace(&result);
 
 	if (!result)
@@ -101,7 +101,7 @@ static int handle_octopus(int count, const char **args, int show_all)
 			break;
 	}
 
-	free_commit_list(result);
+	commit_list_free(result);
 	return 0;
 }
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 979a55d3b2..e141fef3ce 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -485,7 +485,7 @@ static int real_merge(struct merge_tree_options *o,
 			die(_("refusing to merge unrelated histories"));
 		merge_bases = commit_list_reverse(merge_bases);
 		merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
-		free_commit_list(merge_bases);
+		commit_list_free(merge_bases);
 	}
 
 	if (result.clean < 0)
diff --git a/builtin/merge.c b/builtin/merge.c
index c421a11b0b..6a0831a658 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -831,7 +831,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 				       LOCK_DIE_ON_ERROR);
 		clean = merge_ort_recursive(&o, head, remoteheads->item,
 					    reversed, &result);
-		free_commit_list(reversed);
+		commit_list_free(reversed);
 		strbuf_release(&o.obuf);
 
 		if (clean < 0) {
@@ -1006,7 +1006,7 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 	finish(head, remoteheads, &result_commit, "In-index merge");
 
 	remove_merge_branch_state(the_repository);
-	free_commit_list(parents);
+	commit_list_free(parents);
 	return 0;
 }
 
@@ -1022,7 +1022,7 @@ static int finish_automerge(struct commit *head,
 	struct object_id result_commit;
 
 	write_tree_trivial(result_tree);
-	free_commit_list(common);
+	commit_list_free(common);
 	parents = remoteheads;
 	if (!head_subsumed || fast_forward == FF_NO)
 		commit_list_insert(head, &parents);
@@ -1035,7 +1035,7 @@ static int finish_automerge(struct commit *head,
 
 	strbuf_release(&buf);
 	remove_merge_branch_state(the_repository);
-	free_commit_list(parents);
+	commit_list_free(parents);
 	return 0;
 }
 
@@ -1197,7 +1197,7 @@ static struct commit_list *reduce_parents(struct commit *head_commit,
 
 	/* Find what parents to record by checking independent ones. */
 	parents = reduce_heads(remoteheads);
-	free_commit_list(remoteheads);
+	commit_list_free(remoteheads);
 
 	remoteheads = NULL;
 	remotes = &remoteheads;
@@ -1748,7 +1748,7 @@ int cmd_merge(int argc,
 				exit(128);
 
 			common_item = common_one->item;
-			free_commit_list(common_one);
+			commit_list_free(common_one);
 			if (!oideq(&common_item->object.oid, &j->item->object.oid)) {
 				up_to_date = 0;
 				break;
@@ -1880,8 +1880,8 @@ int cmd_merge(int argc,
 
 done:
 	if (!automerge_was_ok) {
-		free_commit_list(common);
-		free_commit_list(remoteheads);
+		commit_list_free(common);
+		commit_list_free(remoteheads);
 	}
 	strbuf_release(&buf);
 	free(branch_to_free);
diff --git a/builtin/pull.c b/builtin/pull.c
index 3ff748e0b3..6ad420ce6f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -704,14 +704,14 @@ static int get_octopus_merge_base(struct object_id *merge_base,
 
 	if (get_octopus_merge_bases(revs, &result) < 0)
 		exit(128);
-	free_commit_list(revs);
+	commit_list_free(revs);
 	reduce_heads_replace(&result);
 
 	if (!result)
 		return 1;
 
 	oidcpy(merge_base, &result->item->object.oid);
-	free_commit_list(result);
+	commit_list_free(result);
 	return 0;
 }
 
@@ -803,7 +803,7 @@ static int get_can_ff(struct object_id *orig_head,
 	commit_list_insert(head, &list);
 	merge_head = lookup_commit_reference(the_repository, orig_merge_head);
 	ret = repo_is_descendant_of(the_repository, merge_head, list);
-	free_commit_list(list);
+	commit_list_free(list);
 	if (ret < 0)
 		exit(128);
 	return ret;
@@ -828,7 +828,7 @@ static int already_up_to_date(struct object_id *orig_head,
 		theirs = lookup_commit_reference(the_repository, &merge_heads->oid[i]);
 		commit_list_insert(theirs, &list);
 		ok = repo_is_descendant_of(the_repository, ours, list);
-		free_commit_list(list);
+		commit_list_free(list);
 		if (ok < 0)
 			exit(128);
 		if (!ok)
diff --git a/builtin/rebase.c b/builtin/rebase.c
index c468828189..c487e10907 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -912,7 +912,7 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 	res = 1;
 
 done:
-	free_commit_list(merge_bases);
+	commit_list_free(merge_bases);
 	return res && is_linear_history(onto, head);
 }
 
@@ -929,7 +929,7 @@ static void fill_branch_base(struct rebase_options *options,
 	else
 		oidcpy(branch_base, &merge_bases->item->object.oid);
 
-	free_commit_list(merge_bases);
+	commit_list_free(merge_bases);
 }
 
 static int parse_opt_am(const struct option *opt, const char *arg, int unset)
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 99f876ba85..ddea8aa251 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -216,7 +216,7 @@ static inline void finish_object__ma(struct object *obj, const char *name)
 
 static void finish_commit(struct commit *commit)
 {
-	free_commit_list(commit->parents);
+	commit_list_free(commit->parents);
 	commit->parents = NULL;
 	free_commit_buffer(the_repository->parsed_objects,
 			   commit);
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f3ebc1d4ea..f02831b085 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -1008,7 +1008,7 @@ int cmd_show_branch(int ac,
 out:
 	for (size_t i = 0; i < ARRAY_SIZE(reflog_msg); i++)
 		free(reflog_msg[i]);
-	free_commit_list(seen);
+	commit_list_free(seen);
 	clear_prio_queue(&queue);
 	free(args_copy);
 	free(head);
diff --git a/builtin/stash.c b/builtin/stash.c
index 4cb2351787..aea68a16aa 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1495,7 +1495,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 		goto done;
 	}
 
-	free_commit_list(parents);
+	commit_list_free(parents);
 	parents = NULL;
 
 	if (include_untracked) {
@@ -1564,7 +1564,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	strbuf_release(&commit_tree_label);
 	strbuf_release(&msg);
 	strbuf_release(&untracked_files);
-	free_commit_list(parents);
+	commit_list_free(parents);
 	free(branch_name_buf);
 	return ret;
 }
@@ -2184,7 +2184,7 @@ static int do_import_stash(struct repository *r, const char *rev)
 out:
 	if (this && buffer)
 		repo_unuse_commit_buffer(r, this, buffer);
-	free_commit_list(items);
+	commit_list_free(items);
 	free(msg);
 
 	return res;
@@ -2318,7 +2318,7 @@ static int do_export_stash(struct repository *r,
 		next = commit_list_append(prev, next);
 		next = commit_list_append(stash, next);
 		res = write_commit_with_parents(r, &out, &stash->object.oid, parents);
-		free_commit_list(parents);
+		commit_list_free(parents);
 		if (res)
 			goto out;
 		prev = lookup_commit_reference(r, &out);
@@ -2330,7 +2330,7 @@ static int do_export_stash(struct repository *r,
 		puts(oid_to_hex(&prev->object.oid));
 out:
 	strbuf_release(&revision);
-	free_commit_list(items);
+	commit_list_free(items);
 
 	return res;
 }
diff --git a/commit-graph.c b/commit-graph.c
index 00e8193adc..ed480c0537 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -965,7 +965,7 @@ static int fill_commit_in_graph(struct commit *item,
 	do {
 		if (g->chunk_extra_edges_size / sizeof(uint32_t) <= parent_data_pos) {
 			error(_("commit-graph extra-edges pointer out of bounds"));
-			free_commit_list(item->parents);
+			commit_list_free(item->parents);
 			item->parents = NULL;
 			item->object.parsed = 0;
 			return 0;
diff --git a/commit-reach.c b/commit-reach.c
index e7d9b3208f..9604bbdcce 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -109,7 +109,7 @@ static int paint_down_to_common(struct repository *r,
 				continue;
 			if (repo_parse_commit(r, p)) {
 				clear_prio_queue(&queue);
-				free_commit_list(*result);
+				commit_list_free(*result);
 				*result = NULL;
 				/*
 				 * At this stage, we know that the commit is
@@ -166,7 +166,7 @@ static int merge_bases_many(struct repository *r,
 	}
 
 	if (paint_down_to_common(r, one, n, twos, 0, 0, &list)) {
-		free_commit_list(list);
+		commit_list_free(list);
 		return -1;
 	}
 
@@ -195,8 +195,8 @@ int get_octopus_merge_bases(struct commit_list *in, struct commit_list **result)
 			struct commit_list *bases = NULL;
 			if (repo_get_merge_bases(the_repository, i->item,
 						 j->item, &bases) < 0) {
-				free_commit_list(bases);
-				free_commit_list(*result);
+				commit_list_free(bases);
+				commit_list_free(*result);
 				*result = NULL;
 				return -1;
 			}
@@ -207,7 +207,7 @@ int get_octopus_merge_bases(struct commit_list *in, struct commit_list **result)
 			for (k = bases; k; k = k->next)
 				end = k;
 		}
-		free_commit_list(*result);
+		commit_list_free(*result);
 		*result = new_commits;
 	}
 	return 0;
@@ -249,7 +249,7 @@ static int remove_redundant_no_gen(struct repository *r,
 					 work, min_generation, 0, &common)) {
 			clear_commit_marks(array[i], all_flags);
 			clear_commit_marks_many(filled, work, all_flags);
-			free_commit_list(common);
+			commit_list_free(common);
 			free(work);
 			free(redundant);
 			free(filled_index);
@@ -262,7 +262,7 @@ static int remove_redundant_no_gen(struct repository *r,
 				redundant[filled_index[j]] = 1;
 		clear_commit_marks(array[i], all_flags);
 		clear_commit_marks_many(filled, work, all_flags);
-		free_commit_list(common);
+		commit_list_free(common);
 	}
 
 	/* Now collect the result */
@@ -374,7 +374,7 @@ static int remove_redundant_with_gen(struct repository *r,
 			if (!parents)
 				pop_commit(&stack);
 		}
-		free_commit_list(stack);
+		commit_list_free(stack);
 	}
 	free(sorted);
 
@@ -451,7 +451,7 @@ static int get_merge_bases_many_0(struct repository *r,
 	CALLOC_ARRAY(rslt, cnt);
 	for (list = *result, i = 0; list; list = list->next)
 		rslt[i++] = list->item;
-	free_commit_list(*result);
+	commit_list_free(*result);
 	*result = NULL;
 
 	clear_commit_marks(one, all_flags);
@@ -510,7 +510,7 @@ int repo_is_descendant_of(struct repository *r,
 		int result;
 		commit_list_insert(commit, &from_list);
 		result = can_all_from_reach(from_list, with_commit, 0);
-		free_commit_list(from_list);
+		commit_list_free(from_list);
 		return result;
 	} else {
 		while (with_commit) {
@@ -561,7 +561,7 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 		ret = 1;
 	clear_commit_marks(commit, all_flags);
 	clear_commit_marks_many(nr_reference, reference, all_flags);
-	free_commit_list(bases);
+	commit_list_free(bases);
 	return ret;
 }
 
@@ -578,7 +578,7 @@ int repo_in_merge_bases(struct repository *r,
 
 	next = commit_list_append(commit, next);
 	res = repo_is_descendant_of(r, reference, list);
-	free_commit_list(list);
+	commit_list_free(list);
 
 	return res;
 }
@@ -626,7 +626,7 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 void reduce_heads_replace(struct commit_list **heads)
 {
 	struct commit_list *result = reduce_heads(*heads);
-	free_commit_list(*heads);
+	commit_list_free(*heads);
 	*heads = result;
 }
 
@@ -661,7 +661,7 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 				    new_commit, old_commit_list);
 	if (ret < 0)
 		exit(128);
-	free_commit_list(old_commit_list);
+	commit_list_free(old_commit_list);
 	return ret;
 }
 
@@ -1236,7 +1236,7 @@ void tips_reachable_from_bases(struct repository *r,
 done:
 	free(commits);
 	repo_clear_commit_marks(r, SEEN);
-	free_commit_list(stack);
+	commit_list_free(stack);
 }
 
 /*
diff --git a/commit.c b/commit.c
index 36f02c96aa..ddda9ee19d 100644
--- a/commit.c
+++ b/commit.c
@@ -191,7 +191,7 @@ void unparse_commit(struct repository *r, const struct object_id *oid)
 
 	if (!c->object.parsed)
 		return;
-	free_commit_list(c->parents);
+	commit_list_free(c->parents);
 	c->parents = NULL;
 	c->object.parsed = 0;
 }
@@ -436,7 +436,7 @@ void release_commit_memory(struct parsed_object_pool *pool, struct commit *c)
 	set_commit_tree(c, NULL);
 	free_commit_buffer(pool, c);
 	c->index = 0;
-	free_commit_list(c->parents);
+	commit_list_free(c->parents);
 
 	c->object.parsed = 0;
 }
@@ -480,7 +480,7 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	 * same error, but that's good, since it lets our caller know
 	 * the result cannot be trusted.
 	 */
-	free_commit_list(item->parents);
+	commit_list_free(item->parents);
 	item->parents = NULL;
 
 	tail += size;
@@ -702,7 +702,7 @@ struct commit_list *commit_list_reverse(struct commit_list *list)
 	return next;
 }
 
-void free_commit_list(struct commit_list *list)
+void commit_list_free(struct commit_list *list)
 {
 	while (list)
 		pop_commit(&list);
@@ -977,7 +977,7 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 		prio_queue_reverse(&queue);
 
 	/* We no longer need the commit list */
-	free_commit_list(orig);
+	commit_list_free(orig);
 
 	pptr = list;
 	*list = NULL;
@@ -1107,7 +1107,7 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 
 cleanup_return:
 	free(revs.commit);
-	free_commit_list(bases);
+	commit_list_free(bases);
 	free(full_refname);
 	return ret;
 }
diff --git a/commit.h b/commit.h
index f50d9e5a4a..1635de418b 100644
--- a/commit.h
+++ b/commit.h
@@ -191,7 +191,7 @@ struct commit_list *commit_list_copy(const struct commit_list *list);
 /* Modify list in-place to reverse it, returning new head; list will be tail */
 struct commit_list *commit_list_reverse(struct commit_list *list);
 
-void free_commit_list(struct commit_list *list);
+void commit_list_free(struct commit_list *list);
 
 /*
  * Deprecated compatibility functions for `struct commit_list`, to be removed
@@ -207,6 +207,11 @@ static inline struct commit_list *reverse_commit_list(struct commit_list *l)
 	return commit_list_reverse(l);
 }
 
+static inline void free_commit_list(struct commit_list *l)
+{
+	commit_list_free(l);
+}
+
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 
 const char *repo_logmsg_reencode(struct repository *r,
diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
index 6fb9eb6e88..03799e1908 100644
--- a/contrib/coccinelle/free.cocci
+++ b/contrib/coccinelle/free.cocci
@@ -5,7 +5,7 @@ expression E;
 (
   free(E);
 |
-  free_commit_list(E);
+  commit_list_free(E);
 )
 
 @@
@@ -15,7 +15,7 @@ expression E;
 (
   free(E);
 |
-  free_commit_list(E);
+  commit_list_free(E);
 )
 
 @@
@@ -30,7 +30,7 @@ expression E;
 @@
 - if (E)
 - {
-  free_commit_list(E);
+  commit_list_free(E);
   E = NULL;
 - }
 
@@ -41,5 +41,5 @@ statement S;
 - if (E) {
 + if (E)
   S
-  free_commit_list(E);
+  commit_list_free(E);
 - }
diff --git a/diff-lib.c b/diff-lib.c
index 5307390ff3..4772e5a561 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -615,7 +615,7 @@ void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
 
 	oidcpy(mb, &merge_bases->item->object.oid);
 
-	free_commit_list(merge_bases);
+	commit_list_free(merge_bases);
 }
 
 void run_diff_index(struct rev_info *revs, unsigned int option)
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index c9085edc40..877a7daed5 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -421,7 +421,7 @@ static void shortlog(const char *name,
 
 	clear_commit_marks((struct commit *)branch, flags);
 	clear_commit_marks(head, flags);
-	free_commit_list(rev->commits);
+	commit_list_free(rev->commits);
 	rev->commits = NULL;
 	rev->pending.nr = 0;
 
diff --git a/line-log.c b/line-log.c
index 8bd422148d..eeaf68454e 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1239,7 +1239,7 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 			 * don't follow any other path in history
 			 */
 			add_line_range(rev, parent, cand[i]);
-			free_commit_list(commit->parents);
+			commit_list_free(commit->parents);
 			commit_list_append(parent, &commit->parents);
 
 			ret = 0;
diff --git a/log-tree.c b/log-tree.c
index 1729b0c201..7e048701d0 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1077,7 +1077,7 @@ static int do_remerge_diff(struct rev_info *opt,
 	log_tree_diff_flush(opt);
 
 	/* Cleanup */
-	free_commit_list(bases);
+	commit_list_free(bases);
 	cleanup_additional_headers(&opt->diffopt);
 	strbuf_release(&parent1_desc);
 	strbuf_release(&parent2_desc);
diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index c54d56b344..2110844f53 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -120,7 +120,7 @@ int merge_ort_generic(struct merge_options *opt,
 	repo_hold_locked_index(opt->repo, &lock, LOCK_DIE_ON_ERROR);
 	clean = merge_ort_recursive(opt, head_commit, next_commit, ca,
 				    result);
-	free_commit_list(ca);
+	commit_list_free(ca);
 	if (clean < 0) {
 		rollback_lock_file(&lock);
 		return clean;
diff --git a/merge-ort.c b/merge-ort.c
index 2ddaaffc26..0c755361cd 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5382,7 +5382,7 @@ static void merge_ort_internal(struct merge_options *opt,
 	opt->ancestor = NULL;  /* avoid accidental re-use of opt->ancestor */
 
 out:
-	free_commit_list(merge_bases);
+	commit_list_free(merge_bases);
 }
 
 void merge_incore_nonrecursive(struct merge_options *opt,
diff --git a/notes-merge.c b/notes-merge.c
index 586939939f..49d0dadd32 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -668,11 +668,11 @@ int notes_merge(struct notes_merge_options *o,
 		commit_list_insert(local, &parents);
 		create_notes_commit(o->repo, local_tree, parents, o->commit_msg.buf,
 				    o->commit_msg.len, result_oid);
-		free_commit_list(parents);
+		commit_list_free(parents);
 	}
 
 found_result:
-	free_commit_list(bases);
+	commit_list_free(bases);
 	strbuf_release(&(o->commit_msg));
 	trace_printf("notes_merge(): result = %i, result_oid = %.7s\n",
 	       result, oid_to_hex(result_oid));
diff --git a/notes-utils.c b/notes-utils.c
index 6a50c6d564..5c1c75d5b8 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -40,7 +40,7 @@ void create_notes_commit(struct repository *r,
 			NULL))
 		die("Failed to commit notes tree to database");
 
-	free_commit_list(parents_to_free);
+	commit_list_free(parents_to_free);
 }
 
 void commit_notes(struct repository *r, struct notes_tree *t, const char *msg)
diff --git a/object-name.c b/object-name.c
index 8b862c124e..e697566423 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1281,7 +1281,7 @@ static int peel_onion(struct repository *r, const char *name, int len,
 		commit_list_insert((struct commit *)o, &list);
 		ret = get_oid_oneline(r, prefix, oid, list);
 
-		free_commit_list(list);
+		commit_list_free(list);
 		free(prefix);
 		return ret;
 	}
@@ -1623,7 +1623,7 @@ int repo_get_oid_mb(struct repository *r,
 	if (!two)
 		return -1;
 	if (repo_get_merge_bases(r, one, two, &mbs) < 0) {
-		free_commit_list(mbs);
+		commit_list_free(mbs);
 		return -1;
 	}
 	if (!mbs || mbs->next)
@@ -1632,7 +1632,7 @@ int repo_get_oid_mb(struct repository *r,
 		st = 0;
 		oidcpy(oid, &mbs->item->object.oid);
 	}
-	free_commit_list(mbs);
+	commit_list_free(mbs);
 	return st;
 }
 
@@ -2052,7 +2052,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			refs_head_ref(get_main_ref_store(repo), handle_one_ref, &cb);
 			ret = get_oid_oneline(repo, name + 2, oid, list);
 
-			free_commit_list(list);
+			commit_list_free(list);
 			return ret;
 		}
 		if (namelen < 3 ||
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index bf73ce5710..2e3f1c1530 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -306,7 +306,7 @@ struct bb_commit {
 
 static void clear_bb_commit(struct bb_commit *commit)
 {
-	free_commit_list(commit->reverse_edges);
+	commit_list_free(commit->reverse_edges);
 	bitmap_free(commit->commit_mask);
 	bitmap_free(commit->bitmap);
 }
@@ -414,7 +414,7 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 				p_ent->maximal = 1;
 			else {
 				p_ent->maximal = 0;
-				free_commit_list(p_ent->reverse_edges);
+				commit_list_free(p_ent->reverse_edges);
 				p_ent->reverse_edges = NULL;
 			}
 
@@ -445,7 +445,7 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 			   "num_maximal_commits", num_maximal);
 
 	release_revisions(&revs);
-	free_commit_list(reusable);
+	commit_list_free(reusable);
 }
 
 static void bitmap_builder_clear(struct bitmap_builder *bb)
diff --git a/ref-filter.c b/ref-filter.c
index c318f9ca0e..3917c4ccd9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3782,9 +3782,9 @@ void ref_filter_clear(struct ref_filter *filter)
 {
 	strvec_clear(&filter->exclude);
 	oid_array_clear(&filter->points_at);
-	free_commit_list(filter->with_commit);
-	free_commit_list(filter->no_commit);
-	free_commit_list(filter->reachable_from);
-	free_commit_list(filter->unreachable_from);
+	commit_list_free(filter->with_commit);
+	commit_list_free(filter->no_commit);
+	commit_list_free(filter->reachable_from);
+	commit_list_free(filter->unreachable_from);
 	ref_filter_init(filter);
 }
diff --git a/reflog.c b/reflog.c
index ac87e20c4f..1460ae9d0d 100644
--- a/reflog.c
+++ b/reflog.c
@@ -493,7 +493,7 @@ void reflog_expiry_cleanup(void *cb_data)
 	case UE_HEAD:
 		for (elem = cb->tips; elem; elem = elem->next)
 			clear_commit_marks(elem->item, REACHABLE);
-		free_commit_list(cb->tips);
+		commit_list_free(cb->tips);
 		break;
 	case UE_NORMAL:
 		clear_commit_marks(cb->tip_commit, REACHABLE);
@@ -501,7 +501,7 @@ void reflog_expiry_cleanup(void *cb_data)
 	}
 	for (elem = cb->mark_list; elem; elem = elem->next)
 		clear_commit_marks(elem->item, REACHABLE);
-	free_commit_list(cb->mark_list);
+	commit_list_free(cb->mark_list);
 }
 
 int count_reflog_ent(const char *refname UNUSED,
diff --git a/remote.c b/remote.c
index b756ff6f15..1c8a9f1a88 100644
--- a/remote.c
+++ b/remote.c
@@ -1497,7 +1497,7 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 		clear_commit_marks_many(src_commits.nr, src_commits.items,
 					reachable_flag);
 		commit_stack_clear(&src_commits);
-		free_commit_list(found_commits);
+		commit_list_free(found_commits);
 	}
 
 	string_list_clear(&src_tag, 0);
diff --git a/revision.c b/revision.c
index 9f5baceb85..6d207c2f23 100644
--- a/revision.c
+++ b/revision.c
@@ -1048,7 +1048,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 				continue;
 			}
 
-			free_commit_list(parent->next);
+			commit_list_free(parent->next);
 			parent->next = NULL;
 			while (commit->parents != parent)
 				pop_commit(&commit->parents);
@@ -1083,7 +1083,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 					die("cannot simplify commit %s (invalid %s)",
 					    oid_to_hex(&commit->object.oid),
 					    oid_to_hex(&p->object.oid));
-				free_commit_list(p->parents);
+				commit_list_free(p->parents);
 				p->parents = NULL;
 			}
 		/* fallthrough */
@@ -1405,7 +1405,7 @@ static void limit_to_ancestry(struct commit_list *bottoms, struct commit_list *l
 		p->item->object.flags &= ~(TMP_MARK | ANCESTRY_PATH);
 	for (p = bottoms; p; p = p->next)
 		p->item->object.flags &= ~(TMP_MARK | ANCESTRY_PATH);
-	free_commit_list(rlist);
+	commit_list_free(rlist);
 }
 
 /*
@@ -1508,7 +1508,7 @@ static int limit_list(struct rev_info *revs)
 		}
 	}
 
-	free_commit_list(original_list);
+	commit_list_free(original_list);
 	revs->commits = newlist;
 	return 0;
 }
@@ -2011,7 +2011,7 @@ static void prepare_show_merge(struct rev_info *revs)
 		exit(128);
 	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
 	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);
-	free_commit_list(bases);
+	commit_list_free(bases);
 	head->object.flags |= SYMMETRIC_LEFT;
 
 	if (!istate->cache_nr)
@@ -2105,13 +2105,13 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 			return dotdot_missing(arg, dotdot, revs, symmetric);
 
 		if (repo_get_merge_bases(the_repository, a, b, &exclude) < 0) {
-			free_commit_list(exclude);
+			commit_list_free(exclude);
 			return -1;
 		}
 		add_rev_cmdline_list(revs, exclude, REV_CMD_MERGE_BASE,
 				     flags_exclude);
 		add_pending_commit_list(revs, exclude, flags_exclude);
-		free_commit_list(exclude);
+		commit_list_free(exclude);
 
 		b_flags = flags;
 		a_flags = flags | SYMMETRIC_LEFT;
@@ -3221,13 +3221,13 @@ static void release_revisions_bloom_keyvecs(struct rev_info *revs)
 
 static void free_void_commit_list(void *list)
 {
-	free_commit_list(list);
+	commit_list_free(list);
 }
 
 void release_revisions(struct rev_info *revs)
 {
-	free_commit_list(revs->commits);
-	free_commit_list(revs->ancestry_path_bottoms);
+	commit_list_free(revs->commits);
+	commit_list_free(revs->ancestry_path_bottoms);
 	release_display_notes(&revs->notes_opt);
 	object_array_clear(&revs->pending);
 	object_array_clear(&revs->boundary_commits);
@@ -3335,7 +3335,7 @@ static int mark_redundant_parents(struct commit *commit)
 	if (i != cnt || cnt+marked != orig_cnt)
 		die("mark_redundant_parents %d %d %d %d", orig_cnt, cnt, i, marked);
 
-	free_commit_list(h);
+	commit_list_free(h);
 
 	return marked;
 }
@@ -4232,7 +4232,7 @@ static void save_parents(struct rev_info *revs, struct commit *commit)
 static void free_saved_parent(struct commit_list **parents)
 {
 	if (*parents != EMPTY_PARENT_LIST)
-		free_commit_list(*parents);
+		commit_list_free(*parents);
 }
 
 static void free_saved_parents(struct rev_info *revs)
@@ -4293,7 +4293,7 @@ static void track_linear(struct rev_info *revs, struct commit *commit)
 		if (revs->linear)
 			commit->object.flags |= TRACK_LINEAR;
 	}
-	free_commit_list(revs->previous_parents);
+	commit_list_free(revs->previous_parents);
 	revs->previous_parents = commit_list_copy(commit->parents);
 }
 
@@ -4382,7 +4382,7 @@ static void create_boundary_commit_list(struct rev_info *revs)
 	 * boundary commits anyway.  (This is what the code has always
 	 * done.)
 	 */
-	free_commit_list(revs->commits);
+	commit_list_free(revs->commits);
 	revs->commits = NULL;
 
 	/*
@@ -4504,7 +4504,7 @@ struct commit *get_revision(struct rev_info *revs)
 		reversed = NULL;
 		while ((c = get_revision_internal(revs)))
 			commit_list_insert(c, &reversed);
-		free_commit_list(revs->commits);
+		commit_list_free(revs->commits);
 		revs->commits = reversed;
 		revs->reverse = 0;
 		revs->reverse_output_stage = 1;
@@ -4522,7 +4522,7 @@ struct commit *get_revision(struct rev_info *revs)
 		graph_update(revs->graph, c);
 	if (!c) {
 		free_saved_parents(revs);
-		free_commit_list(revs->previous_parents);
+		commit_list_free(revs->previous_parents);
 		revs->previous_parents = NULL;
 	}
 	return c;
diff --git a/sequencer.c b/sequencer.c
index e09f8eed55..f5a6496937 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1698,7 +1698,7 @@ static int try_to_commit(struct repository *r,
 
 out:
 	free_commit_extra_headers(extra);
-	free_commit_list(parents);
+	commit_list_free(parents);
 	strbuf_release(&err);
 	strbuf_release(&commit_msg);
 	free(amend_author);
@@ -2476,8 +2476,8 @@ static int do_pick_commit(struct repository *r,
 		res |= try_merge_command(r, opts->strategy,
 					 opts->xopts.nr, opts->xopts.v,
 					common, oid_to_hex(&head), remotes);
-		free_commit_list(common);
-		free_commit_list(remotes);
+		commit_list_free(common);
+		commit_list_free(remotes);
 	}
 
 	/*
@@ -4381,8 +4381,8 @@ static int do_merge(struct repository *r,
 leave_merge:
 	strbuf_release(&ref_name);
 	rollback_lock_file(&lock);
-	free_commit_list(to_merge);
-	free_commit_list(bases);
+	commit_list_free(to_merge);
+	commit_list_free(bases);
 	return ret;
 }
 
@@ -6039,11 +6039,11 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 			oidset_insert(&shown, oid);
 		}
 
-		free_commit_list(list);
+		commit_list_free(list);
 	}
 
-	free_commit_list(commits);
-	free_commit_list(tips);
+	commit_list_free(commits);
+	commit_list_free(tips);
 
 	strbuf_release(&label_from_message);
 	strbuf_release(&oneline);
diff --git a/shallow.c b/shallow.c
index c870efcefc..0409b1354c 100644
--- a/shallow.c
+++ b/shallow.c
@@ -40,7 +40,7 @@ int register_shallow(struct repository *r, const struct object_id *oid)
 	oidcpy(&graft->oid, oid);
 	graft->nr_parent = -1;
 	if (commit && commit->object.parsed) {
-		free_commit_list(commit->parents);
+		commit_list_free(commit->parents);
 		commit->parents = NULL;
 	}
 	return register_commit_graft(r, graft, 0);
@@ -267,7 +267,7 @@ struct commit_list *get_shallow_commits_by_rev_list(struct strvec *argv,
 				break;
 			}
 	}
-	free_commit_list(not_shallow_list);
+	commit_list_free(not_shallow_list);
 
 	/*
 	 * Now we can clean up NOT_SHALLOW on border commits. Having
diff --git a/submodule.c b/submodule.c
index 40a5c6fb9d..85e9586e66 100644
--- a/submodule.c
+++ b/submodule.c
@@ -639,7 +639,7 @@ void show_submodule_diff_summary(struct diff_options *o, const char *path,
 	print_submodule_diff_summary(sub, &rev, o);
 
 out:
-	free_commit_list(merge_bases);
+	commit_list_free(merge_bases);
 	release_revisions(&rev);
 	clear_commit_marks(left, ~0);
 	clear_commit_marks(right, ~0);
@@ -729,7 +729,7 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 
 done:
 	strbuf_release(&sb);
-	free_commit_list(merge_bases);
+	commit_list_free(merge_bases);
 	if (left)
 		clear_commit_marks(left, ~0);
 	if (right)
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index feabeb29c2..3131b54a87 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -120,12 +120,12 @@ int cmd__reach(int ac, const char **av)
 			exit(128);
 		printf("%s(A,X):\n", av[1]);
 		print_sorted_commit_ids(list);
-		free_commit_list(list);
+		commit_list_free(list);
 	} else if (!strcmp(av[1], "reduce_heads")) {
 		struct commit_list *list = reduce_heads(X);
 		printf("%s(X):\n", av[1]);
 		print_sorted_commit_ids(list);
-		free_commit_list(list);
+		commit_list_free(list);
 	} else if (!strcmp(av[1], "can_all_from_reach")) {
 		printf("%s(X,Y):%d\n", av[1], can_all_from_reach(X, Y, 1));
 	} else if (!strcmp(av[1], "can_all_from_reach_with_flag")) {
@@ -172,13 +172,13 @@ int cmd__reach(int ac, const char **av)
 			die(_("too many commits marked reachable"));
 
 		print_sorted_commit_ids(list);
-		free_commit_list(list);
+		commit_list_free(list);
 	}
 
 	object_array_clear(&X_obj);
 	strbuf_release(&buf);
-	free_commit_list(X);
-	free_commit_list(Y);
+	commit_list_free(X);
+	commit_list_free(Y);
 	commit_stack_clear(&X_stack);
 	commit_stack_clear(&Y_stack);
 	return 0;

-- 
2.52.0.660.gd05f3a8ea5.dirty

