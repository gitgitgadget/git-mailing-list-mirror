Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66967C433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 22:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242209AbhL3WEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 17:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbhL3WEo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 17:04:44 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE3BC061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 14:04:43 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w16so102757215edc.11
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 14:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aojkE8YG7tqlY0qysb07VnyUqiC5HXPjFjkrigVefQg=;
        b=PbTsdS4G87DUjY7adyz0TG6U75PdKF4+2R0x4bc9YYvRJX7yUbXceCvdUawyeDpM8V
         gXevb09DNC0Cyt8PhTuAmJlJFamrad9AmnYT4hP3uwVyw/ahZ+UvU0wOVSz/g93IPAbb
         phnXkNXDtYCp8vSxJOa05b1NEJmSBMFfTQMOo2n2cOixlxcRJ3sj+m5IAqe5RcHaW3Kt
         rFGYJGAQAPa4cKb17hkGjLyJLVHUTenNEBIkXxXa7V3dDPnnoy4Xik9Af7WuArZohl00
         WQshprXKiridHd1MIRbhYdLVtqLO6RVhJyoRLD4Rb578TLX25kVq6q7ksNCH5apb1yQs
         9BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aojkE8YG7tqlY0qysb07VnyUqiC5HXPjFjkrigVefQg=;
        b=uCTgmHf1y3/SE3gbkqZeN+OmWfZ+djBXiCalvp2Ja8+LC5NTjj7AHKmhv1bmGhEyqj
         uQaLyo/wx8ZXfRbCqSL8OiUJySnP9JQ556m7cu1otvKv2a/UqvXkXmYJhZ5K+P0JMnwO
         vtt64FqrvAjCbU97syYdkaW8M2JpH2fcRHtKM3noyqGfaCx5x6LLtp7l0bR9BgZnMOyB
         8pp0JFrltWfZFPo/PiCNyBYqRsByCppHAgTuOxYJh+krUMBc9VfibmdHrGZQeSHbU2mf
         ysB00eMN5o97lGJQwC9WTA8FR1NNUb5ODc3VurNwSJigMaoz84PDP0nlTp6BdJmXOZ01
         ByfQ==
X-Gm-Message-State: AOAM533n0LUl11swjnJMjFsndsmWwXnEvf/DyoYLU4Y3Ajc6cb9yFt9X
        HrmLYtzrtXyLJAJz5GKBdCVajEAQACvxX38FPoI=
X-Google-Smtp-Source: ABdhPJzJrvCoGX8Gfgqw8iYUq6bHQa6niicNiGe1oylkl0cbBq1sx79E5hJGHk9lsTSNRMGoHH8R96BK13hi6zg2chI=
X-Received: by 2002:a17:907:60c8:: with SMTP id hv8mr26152170ejc.192.1640901882182;
 Thu, 30 Dec 2021 14:04:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com> <e94706513038adc85e818e8736ad713b2e6b6be4.1640419160.git.gitgitgadget@gmail.com>
 <20211228105733.lomkg23htd2kjtii@gmail.com> <CABPp-BH5XUsmTo=BD7osUgi4o=eFWgaQkN1qYDky6uqb9SykHA@mail.gmail.com>
 <20211229001647.6pv5damtyt3dsiyr@gmail.com>
In-Reply-To: <20211229001647.6pv5damtyt3dsiyr@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Dec 2021 14:04:30 -0800
Message-ID: <CABPp-BHoiNiYoVzknJEGQpe5a6nnQXj_bwwrtWbmKLBiUCOj_Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] diff: add ability to insert additional headers for paths
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 4:16 PM Johannes Altmanninger <aclopte@gmail.com> wrote:
>
> On Tue, Dec 28, 2021 at 01:09:57PM -0800, Elijah Newren wrote:
> > On Tue, Dec 28, 2021 at 2:57 AM Johannes Altmanninger <aclopte@gmail.com> wrote:
> > >
> > > On Sat, Dec 25, 2021 at 07:59:18AM +0000, Elijah Newren via GitGitGadget wrote:
....
> > > but they are not
> > > really necessary for computing/printing a diff.
> >
> > Technically agree that it _could_ be solved a different way, but the
> > strmaps are a much more natural solution to this problem in this
> > particular case; more on this below.
>
> Oh yeah, I agree that strmaps are the more intuitive solution.

Cool, sounds like we're heading towards consensus.

> > > It feels like this is an
> > > implementation detail from merge-ort that's leaking into other components.
> >
> > And I disagree here, on _both_ the explicit point and the underlying
> > suggestion that you seem to be making that strmap should be avoided
> > outside of merging.  The strmap.[ch] type was originally a suggestion
> > from Peff for areas of git completely unrelated to merging (see the
> > beginning of https://lore.kernel.org/git/20200821194857.GD1165@coredump.intra.peff.net/,
> > and the first link in that email).  It's a new datatype for git, much
> > like strbuf or string_list or whatever before it, that is there to be
> > used when it's a natural fit for the problem at hand.  The lack of
> > strmap previously led folks to abuse other existing data structures
> > (and in a way that often led to poor performance to boot).
>
> Right, all those rename-detection performance fixes were pretty dazzling

I actually wasn't talking about rename-detection or merge machinery
(though it applies there too).  The original strmap proposal was
suggested in an email entitled, "ordered string-list considered
harmful", and neither rename-detection nor merge machinery were part
of the thread at the time.  I also didn't participate in the
thread...until I implemented the suggested API with some tweaks and
submitted it about a year later.

> > > What we want to do is
> > >
> > >         for file_pair in additional_headers:
> > >                 if not already_queued(file_pair):
> > >                         queue(file_pair)
> >
> > Yes, precisely.
> >
> > > to do that, you use a temporary has-set ("present") that records everything
> > > that's already queued (already_queued() is a lookup in that set).
> > >
> > > Let's assume both the queue and additional_headers are sorted arrays.
> >
> > That's a bad assumption; we can't rely on *either* being sorted.  I
>
...
> > > Then we could efficiently merge them (like a merge-sort algorithm)
> > > without ever allocating a temporary hash map.
> > >
> > > I haven't checked if this is practical (better wait for feedback).
> > > We'd probably need to convert the strmap additional_path_headers into an
> > > array and sort it (I guess our hash map does not guarantee any ordering?)
> >
> > Right, strmap has no ordering either.  I was willing to stick those
> > into a string_list and sort them, but making temporary copies of both
> > the strmap and the diff_queued_diff just to sort them so that I can
>
> But you already sort diff_queued_diff at the end of
> create_filepairs_for_header_only_notifications(), so sorting a bit earlier
> in that function, before enqueueing the new entries won't change the final
> result, and allows us to work with a sorted queue; no need for a temporary
> copy (we'd only need to copy the strmap).

Good point, although...

> > reasonably cheaply ask "are items from this thing present in this
> > other thing?" seems to be stretching things a bit too far.
> > maps/hashes provide a very nice "is this item present" lookup and are
> > a natural way to ask that.  Since that is exactly the question I am
> > asking, I think they are the better data structure here.
>
> Yeah that makes sense. In theory if we ask
> "What is the union of the queued pairs and the extra pairs induced by
> conflict messages?"  we could abstract away the "is this item present"
> lookup but in practice that's hard.
>
> > So, this was not at all a leak of merge-ort datastructures, but rather a
> > picking of the appropriate data structures for the problem at hand.
>
> I think we have two viable solutions to this problem
> 1. use a temporary strset to figure out which pairs to add
> 2. use a temporary array, sort it, and "merge" the two arrays
>
> I agree that 1 is more intuitive and natural for humans, and it's probably the
> way to go. But it is a bit less elegant because it adds a strmap entry for
> each pair in the queue, whereas 2 only needs to add an array element for
> each pair with non-content conflicts, which are much fewer. (Okay that's a
> minor detail.)  With the right abstractions 2 is pretty simple as well:
>
>         j = 0
>         extra_headers = sorted((key, val) for key, val in additional_headers)

Right, so this is two sorts instead of one.  (Sorting both the
diff_queued_diff initially, as well as the additional_headers, before
then attempting to merge the two.)  Probably a win performance-wise,
but just noting that it makes the code slightly less simple.

>         for i in 0..len(queue):
>                 while j < len(extra_headers) && compare(extra_headers[j].key, queue[i]) <= 0:
>                         if compare(extra_headers[j].key, queue[i]) < 0:

The duplicate comparison (two calls to strcmp) probably kills any
performance gain you were aiming for with this strategy.  Fixable, but
it does make the code longer.

>                                 enqueue(file_pair_for(extra_headers[j]))

The queue is an array of sorted items, so enqueue here would be
insertion into an already sorted list.  Inserting N items into a list
of M items is quadratic (O(N*M)) -- unless you meant to just append to
the end and add a third sort at the end?

>                         j++

At the end of the for loop, there may be remaining additional headers
that sort after all those found in the queue, so you'll need an
additional loop to handle those.

> where
>
>         def compare(key: str, pair: diff_filepair) -> int:
>                 other = pair.one ? pair.one.path : pair.two.path # Mimic diffnamecmp
>                 return strcmp(key, other)


Since you clearly felt this approach might be better, I went and
implemented it (+ tested and debugged):

 diff.c | 112 +++++++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 73 insertions(+), 38 deletions(-)

diff --git a/diff.c b/diff.c
index d771406e69..0cdaa2e2ab 100644
--- a/diff.c
+++ b/diff.c
@@ -6389,52 +6389,87 @@ void diff_warn_rename_limit(const char
*varname, int needed, int degraded_cc)
                warning(_(rename_limit_advice), varname, needed);
 }

+static void diff_queue_placeholder(char *path)
+{
+       struct diff_filespec *one, *two;
+       struct diff_filepair *p;
+
+       one = alloc_filespec(path);
+       two = alloc_filespec(path);
+       fill_filespec(one, null_oid(), 0, 0);
+       fill_filespec(two, null_oid(), 0, 0);
+       p = diff_queue(&diff_queued_diff, one, two);
+       p->status = DIFF_STATUS_MODIFIED;
+}
+
 static void create_filepairs_for_header_only_notifications(struct
diff_options *o)
 {
-       struct strset present;
-       struct diff_queue_struct *q = &diff_queued_diff;
+       struct diff_queue_struct tmp_queue = { 0 };
+       struct string_list tmp_list = STRING_LIST_INIT_NODUP;
        struct hashmap_iter iter;
        struct strmap_entry *e;
+       char *queue_path = NULL, *list_path = NULL;
        int i;
+       int j;

-       strset_init_with_options(&present, /*pool*/ NULL, /*strdup*/ 0);
-
-       /*
-        * Find out which paths exist in diff_queued_diff, preferring
-        * one->path for any pair that has multiple paths.
-        */
-       for (i = 0; i < q->nr; i++) {
-               struct diff_filepair *p = q->queue[i];
-               char *path = p->one->path ? p->one->path : p->two->path;
-
-               if (strmap_contains(o->additional_path_headers, path))
-                       strset_add(&present, path);
-       }
-
-       /*
-        * Loop over paths in additional_path_headers; for each NOT already
-        * in diff_queued_diff, create a synthetic filepair and insert that
-        * into diff_queued_diff.
-        */
-       strmap_for_each_entry(o->additional_path_headers, &iter, e) {
-               if (!strset_contains(&present, e->key)) {
-                       struct diff_filespec *one, *two;
-                       struct diff_filepair *p;
-
-                       one = alloc_filespec(e->key);
-                       two = alloc_filespec(e->key);
-                       fill_filespec(one, null_oid(), 0, 0);
-                       fill_filespec(two, null_oid(), 0, 0);
-                       p = diff_queue(q, one, two);
-                       p->status = DIFF_STATUS_MODIFIED;
-               }
-       }
-
-       /* Re-sort the filepairs */
+       /* Ensure existing filepairs are sorted */
        diffcore_fix_diff_index();

-       /* Cleanup */
-       strset_clear(&present);
+       /* Get a sorted list of additional_path_headers */
+       strmap_for_each_entry(o->additional_path_headers, &iter, e) {
+               string_list_append(&tmp_list, e->key);
+       }
+       string_list_sort(&tmp_list);
+
+       /*
+        * Move everything from diff_queued_diff to tmp_queue.  We'll copy
+        * them back one-by-one, with extra entries inserted from tmp_list.
+        */
+       SWAP(tmp_queue, diff_queued_diff);
+
+       /*
+        * Add entries from tmp_queue and tmp_list to diff_queued_diff, keeping
+        * the overall list sorted.
+        */
+       j = 0;
+       for (i = 0; i < tmp_queue.nr; i++) {
+               struct diff_filepair *p = tmp_queue.queue[i];
+               queue_path = p->one->path ? p->one->path : p->two->path;
+
+               while (j < tmp_list.nr) {
+                       int cmp;
+
+                       list_path = tmp_list.items[j].string;
+                       cmp = strcmp(queue_path, list_path);
+
+                       if (cmp < 0)
+                               break;
+                       else if (cmp > 0)
+                               diff_queue_placeholder(list_path);
+                       j++;
+               }
+               diff_q(&diff_queued_diff, p);
+       }
+       /*
+        * We've got all the entries from tmp_queue now, but may have more
+        * from tmp_list to insert.  Make sure to only add new entries for
+        * strings not already in diff_queued_diff.
+        */
+       if (j < tmp_list.nr && !strcmp(queue_path, list_path))
+               j++;
+       while (j < tmp_list.nr) {
+               char *list_path = tmp_list.items[j].string;
+               diff_queue_placeholder(list_path);
+               j++;
+       }
+
+       /*
+        * We *only* free tmp_queue.queue, not the stuff it points to because
+        * that has been copied into diff_queued_diff.  Zero out tmp_queue to
+        * make it clear we don't want to free anything else.
+        */
+       free(tmp_queue.queue);
+       memset(&tmp_queue, 0, sizeof(tmp_queue));
 }

 static void diff_flush_patch_all_file_pairs(struct diff_options *o)


It's actually considerably more code as you can see from the diffstat,
and feels like we're reaching into some ugly internals with tmp_queue
(the SWAP and the special-case freeing) in order to get the desired
performance improvements.  And it was already O(NlogN) overall (due to
the sort), which doesn't change with this new algorithm.  It's really,
really hard for me to imagine a case where we have large numbers of
additional headers.  Even if someone else can imagine that we for some
reason have a huge number of conflicts in order to generate a huge
number of additional headers...how could the performance of sorting
O(N) filenames and merging these lists possibly matter in comparison
to the O(N) three-way file merges that would likely have been
performed from those conflicts?

So, I'm going to throw this code away and keep the original.

It was an interesting idea and exercise; thanks for keeping me on my toes.
