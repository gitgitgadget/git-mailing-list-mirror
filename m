Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392291F424
	for <e@80x24.org>; Thu, 21 Dec 2017 18:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbdLUSmF (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 13:42:05 -0500
Received: from mout.web.de ([212.227.17.12]:64201 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752509AbdLUSmE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 13:42:04 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mg7Dt-1eeYda0da1-00NSw4; Thu, 21
 Dec 2017 19:41:47 +0100
Subject: Re: [PATCH] revision: introduce prepare_revision_walk_extended()
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <20171218151043.GA9449@sigill.intra.peff.net>
 <39581cd0-0bfd-c8d1-642b-1245cf425ab4@web.de>
 <20171219114906.GB24558@sigill.intra.peff.net>
 <xmqq7etiworw.fsf@gitster.mtv.corp.google.com>
 <20171220130811.GD17569@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c8980a2c-24e2-a877-fa66-31206123ce49@web.de>
Date:   Thu, 21 Dec 2017 19:41:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171220130811.GD17569@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:zG8C5MBPibqBpeb5o4+whxTCZfbtyplSrjcQIokn82izG/fkzW9
 DXC3SQ4xKq9CXiP0JoiRmjnTN5EpbS4ILyFVxpe61w5Ng3DNtECp+3Cqyeje5vGKOrFJ6zT
 KFPeriQ+Zp7ADI7ESunBsS2v3y4Q1zt/TfThWzCxd0hIm952ZOLZ92nfER9mKC0oZ++9/Rk
 vS6cfGQzyqbI/EQE1waUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2enWtRx4kzs=:n15yMvMfTSYqdCKIau+pdM
 V9yb9rpN6K1kCZkoFFyXlWoOpP4c4XGxNpi3msWY+Ckn4W8c4v4EDuWuRN+8Ti6q/AarKpVSE
 Cw/b3jLbtVdXrvQ1JKa4taxkSZg2nMpamK7IpzYioFbkxY0Vd8ZDy9w0jTSIZQFR1AbP37d+u
 KT9qHCflo3fztuL13yKzrqZCq/r1+SNqP+lyQvchwfBaEn62p3Whnx3IsbWYNUa4uR+R4JmR2
 TutFx2w8sL1Al92wp9rfSE91xpGMaeRL3GDhEV3fm/cAHi3csY2+de6iEpgHbFRMytwKnV8mV
 vJtI6nIrx3rT0XiyaCjAjCdJOI2quLf7c+zc4zJpe/6GXUidgLGzMTdcoQGi52mFsVyM5ZKnd
 gkgT8Hu43ChTYCi60ndcATlmhtpMvFjIDJTmzk+r2Is+AJBgkKKH9UEJ7DunrP36z/5vazTNv
 R4RBvJWy6RuHPx7+7ia0r3ACjsndBkajtBP7wESRYOjRA+YD6GJ7Vbeahm61UGI6rHHCQkldI
 CfqkJ58zaLmy76uSwQqbuNuB3OUxio6/wogDIgDSSqeB2cU7jmN6RXdTCG4QpWy3PU1O81oCI
 XIlHH9zb7UapbTrbuD7QLDtXfcJum+GYcJ6lofKJVqQg3gRwyauOfRcyqWKnGv7tttqj7ipwB
 iZjegF+OPIM5dtyhEd1+ODAXZ7enrAIHA7YF3AOhdkW8NSJNPNAsmP81jQuS1difLVvkWLt4u
 NbfhBMOJRb7wT1+NQN32jX8bbQm0U6RvuQMpxi959rJbJD/88XFKApuNYVG/Yr4GaKRdvh21e
 KLsFD2vZzp2wkyu8bV3wDzZfqSkhr9ZSvdAuvEFkwwgZ39/KgEKelqzw8dRl6NQkpedZO3o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.12.2017 um 14:08 schrieb Jeff King:
> On Tue, Dec 19, 2017 at 10:33:55AM -0800, Junio C Hamano wrote:
> 
>> Should we take the patch posted as-is and move forward?
> 
> I suppose so.  I don't really have anything against the patch. My main
> complaint was just that I don't think it's actually cleaning up the
> gross parts of the interface. It's just substituting one gross thing (a
> funny struct flag) for another (a special version of the prepare
> function that takes a funny out-parameter).

If this is a fair description (and I have to admit that it is) then I
don't understand why you aren't against the patch.  Let's drop it.

Can we do better?  How about something this?  It reverts bundle to
duplicate the object_array, but creates just a commit_list in the other
two cases.  As a side-effect this allows clearing flags for all entries
with a single traversal.

---
 bisect.c           | 18 +++++++-----------
 builtin/checkout.c | 13 +++----------
 bundle.c           | 12 +++++-------
 commit.c           | 18 ++++++++++++++++--
 commit.h           |  3 +++
 revision.c         |  3 +--
 revision.h         | 12 ------------
 7 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/bisect.c b/bisect.c
index 0fca17c02b..c966220738 100644
--- a/bisect.c
+++ b/bisect.c
@@ -819,27 +819,23 @@ static void check_merge_bases(int no_checkout)
 static int check_ancestors(const char *prefix)
 {
 	struct rev_info revs;
-	struct object_array pending_copy;
+	struct commit_list *to_clear = NULL;
 	int res;
 
 	bisect_rev_setup(&revs, prefix, "^%s", "%s", 0);
 
-	/* Save pending objects, so they can be cleaned up later. */
-	pending_copy = revs.pending;
-	revs.leak_pending = 1;
-
 	/*
-	 * bisect_common calls prepare_revision_walk right away, which
-	 * (together with .leak_pending = 1) makes us the sole owner of
-	 * the list of pending objects.
+	 * bisect_common() calls prepare_revision_walk() right away,
+	 * which (among other things) clears revs.pending.  Save the
+	 * pending commits so that we can up their marks later.
 	 */
+	commit_list_insert_from_object_array(&revs.pending, &to_clear);
+
 	bisect_common(&revs);
 	res = (revs.commits != NULL);
 
 	/* Clean up objects used, as they will be reused. */
-	clear_commit_marks_for_object_array(&pending_copy, ALL_REV_FLAGS);
-
-	object_array_clear(&pending_copy);
+	clear_and_free_commit_list(to_clear, ALL_REV_FLAGS);
 
 	return res;
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f9f3797e11..0a694ae14a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -791,7 +791,7 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
 {
 	struct rev_info revs;
 	struct object *object = &old->object;
-	struct object_array refs;
+	struct commit_list *to_clear = NULL;
 
 	init_revisions(&revs, NULL);
 	setup_revisions(0, NULL, &revs, NULL);
@@ -803,13 +803,8 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
 	add_pending_oid(&revs, "HEAD", &new->object.oid, UNINTERESTING);
 
 	/* Save pending objects, so they can be cleaned up later. */
-	refs = revs.pending;
-	revs.leak_pending = 1;
+	commit_list_insert_from_object_array(&revs.pending, &to_clear);
 
-	/*
-	 * prepare_revision_walk (together with .leak_pending = 1) makes us
-	 * the sole owner of the list of pending objects.
-	 */
 	if (prepare_revision_walk(&revs))
 		die(_("internal error in revision walk"));
 	if (!(old->object.flags & UNINTERESTING))
@@ -818,9 +813,7 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
 		describe_detached_head(_("Previous HEAD position was"), old);
 
 	/* Clean up objects used, as they will be reused. */
-	clear_commit_marks_for_object_array(&refs, ALL_REV_FLAGS);
-
-	object_array_clear(&refs);
+	clear_and_free_commit_list(to_clear, ALL_REV_FLAGS);
 }
 
 static int switch_branches(const struct checkout_opts *opts,
diff --git a/bundle.c b/bundle.c
index 93290962c9..6916296834 100644
--- a/bundle.c
+++ b/bundle.c
@@ -134,7 +134,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	struct ref_list *p = &header->prerequisites;
 	struct rev_info revs;
 	const char *argv[] = {NULL, "--all", NULL};
-	struct object_array refs;
+	struct object_array refs = OBJECT_ARRAY_INIT;
 	struct commit *commit;
 	int i, ret = 0, req_nr;
 	const char *message = _("Repository lacks these prerequisite commits:");
@@ -158,13 +158,11 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	setup_revisions(2, argv, &revs, NULL);
 
 	/* Save pending objects, so they can be cleaned up later. */
-	refs = revs.pending;
-	revs.leak_pending = 1;
+	for (i = 0; i < revs.pending.nr; i++) {
+		struct object_array_entry *e = revs.pending.objects + i;
+		add_object_array(e->item, e->name, &refs);
+	}
 
-	/*
-	 * prepare_revision_walk (together with .leak_pending = 1) makes us
-	 * the sole owner of the list of pending objects.
-	 */
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 
diff --git a/commit.c b/commit.c
index cab8d4455b..3b96277879 100644
--- a/commit.c
+++ b/commit.c
@@ -550,6 +550,11 @@ void clear_commit_marks_many(int nr, struct commit **commit, unsigned int mark)
 		commit_list_insert(*commit, &list);
 		commit++;
 	}
+	clear_and_free_commit_list(list, mark);
+}
+
+void clear_and_free_commit_list(struct commit_list *list, unsigned int mark)
+{
 	while (list)
 		clear_commit_marks_1(&list, pop_commit(&list), mark);
 }
@@ -559,7 +564,8 @@ void clear_commit_marks(struct commit *commit, unsigned int mark)
 	clear_commit_marks_many(1, &commit, mark);
 }
 
-void clear_commit_marks_for_object_array(struct object_array *a, unsigned mark)
+void commit_list_insert_from_object_array(const struct object_array *a,
+					  struct commit_list **list)
 {
 	struct object *object;
 	struct commit *commit;
@@ -569,10 +575,18 @@ void clear_commit_marks_for_object_array(struct object_array *a, unsigned mark)
 		object = a->objects[i].item;
 		commit = lookup_commit_reference_gently(&object->oid, 1);
 		if (commit)
-			clear_commit_marks(commit, mark);
+			commit_list_insert(commit, list);
 	}
 }
 
+void clear_commit_marks_for_object_array(struct object_array *a, unsigned mark)
+{
+	struct commit_list *list = NULL;
+
+	commit_list_insert_from_object_array(a, &list);
+	clear_and_free_commit_list(list, mark);
+}
+
 struct commit *pop_commit(struct commit_list **stack)
 {
 	struct commit_list *top = *stack;
diff --git a/commit.h b/commit.h
index 99a3fea68d..128a52f264 100644
--- a/commit.h
+++ b/commit.h
@@ -115,6 +115,8 @@ unsigned commit_list_count(const struct commit_list *l);
 struct commit_list *commit_list_insert_by_date(struct commit *item,
 				    struct commit_list **list);
 void commit_list_sort_by_date(struct commit_list **list);
+void commit_list_insert_from_object_array(const struct object_array *a,
+					  struct commit_list **list);
 
 /* Shallow copy of the input list */
 struct commit_list *copy_commit_list(struct commit_list *list);
@@ -220,6 +222,7 @@ struct commit *pop_commit(struct commit_list **stack);
 void clear_commit_marks(struct commit *commit, unsigned int mark);
 void clear_commit_marks_many(int nr, struct commit **commit, unsigned int mark);
 void clear_commit_marks_for_object_array(struct object_array *a, unsigned mark);
+void clear_and_free_commit_list(struct commit_list *list, unsigned int mark);
 
 
 enum rev_sort_order {
diff --git a/revision.c b/revision.c
index f6a3da5cd9..7239315de9 100644
--- a/revision.c
+++ b/revision.c
@@ -2860,8 +2860,7 @@ int prepare_revision_walk(struct rev_info *revs)
 			}
 		}
 	}
-	if (!revs->leak_pending)
-		object_array_clear(&old_pending);
+	object_array_clear(&old_pending);
 
 	/* Signal whether we need per-parent treesame decoration */
 	if (revs->simplify_merges ||
diff --git a/revision.h b/revision.h
index 54761200ad..27be70e75c 100644
--- a/revision.h
+++ b/revision.h
@@ -150,18 +150,6 @@ struct rev_info {
 			date_mode_explicit:1,
 			preserve_subject:1;
 	unsigned int	disable_stdin:1;
-	/*
-	 * Set `leak_pending` to prevent `prepare_revision_walk()` from clearing
-	 * the array of pending objects (`pending`). It will still forget about
-	 * the array and its entries, so they really are leaked. This can be
-	 * useful if the `struct object_array` `pending` is copied before
-	 * calling `prepare_revision_walk()`. By setting `leak_pending`, you
-	 * effectively claim ownership of the old array, so you should most
-	 * likely call `object_array_clear(&pending_copy)` once you are done.
-	 * Observe that this is about ownership of the array and its entries,
-	 * not the commits referenced by those entries.
-	 */
-	unsigned int	leak_pending:1;
 	/* --show-linear-break */
 	unsigned int	track_linear:1,
 			track_first_time:1,

