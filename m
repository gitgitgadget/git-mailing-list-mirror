Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52D5B1F453
	for <e@80x24.org>; Thu,  4 Oct 2018 22:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeJEFyx (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 01:54:53 -0400
Received: from mout.web.de ([212.227.17.11]:57869 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeJEFyw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 01:54:52 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LjJH1-1fZgVr2zZn-00dVEJ; Fri, 05
 Oct 2018 00:59:04 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LjJH1-1fZgVr2zZn-00dVEJ; Fri, 05
 Oct 2018 00:59:04 +0200
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
 <d1b58614-989f-5998-6c53-c19eee409a2f@web.de>
 <dd798e76-922f-a113-4408-e3892bee3b44@gmail.com>
 <223b14f7-213f-4d22-4776-22dcfd1806c2@web.de>
Message-ID: <7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de>
Date:   Fri, 5 Oct 2018 00:59:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <223b14f7-213f-4d22-4776-22dcfd1806c2@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5wa6HvNjIkMfJCsacZa4+m6QNc7UBf0RPDu1f2pQgKZOMrm8KlR
 ZTwlTjYUy+SAdCkYd3K8hlIZaijJ/CPDzxbnNIYYpw88l2NDTfBopb3TlN2hy+/hUvunFSn
 4hMOA6M0cMPUESdUWjG0WK95fWg1VSm2acHPb5eevBbxzh4yIGBDdwbefokhqAmAeHrybF2
 qAetD0r+5pmhSA5+K/S7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P6EPDBvNWAk=:+/QVYwJWmg5NODSoVGwXBd
 8n2fQPlPcQmeCddsEQ/Y3DlC9G9kdu3sQ8LJDCz3ErL1XZ2nWsSdhXBk8JbZSls6TpBMT4RJ4
 yvVzRdMLZaqEFmwJWjkHHM9bAFnluUPyvqgjJ7mRTv68T6MghDMc/gMxPRpoL8O8Qt8iPm7m/
 ruCCAJeKcxv/rS+cQjSVdHaXpYh3oQOyJWOIJDppP84qaR7Z+LB6P8+fLS/OlMtnAzxC4v+GR
 XU9+PwyFuBgYBaHS2q9VGpqAQH3rKE8adsHEwp8hsKhy0I8W/zMZV666FL7FGZUq5pDE37P3O
 QdVVWupzrpUKz9dq+GQZOJ8OWxp/n0PlvcksVbzKNjUnrOOLwKg+ASOUEI96dJjRy4fWVydz7
 wd3oOYIPBRZChWJvErVhS6N3ohcMHk7Bd87JowbZBvTbL8+YuahqgdKq+vOonMUhru6PrW262
 qRMz3be+QQg7uVFhVIpgjkEiA+BowACIX/piVJTUq0MYS5B30VwlY1VE2+cnRpXFyaWv69I+d
 bYhzbs3QK+p0UaCdyYnhOfSFceVihdwFE/EfGoVv9QVYD7nQYt3g1+UCuXNzXE1eXymvxM8cZ
 6Tcz1SFpzwuVdtmH76GVlSfoE5xiNVpU6pVTQDqPrDOv6hoqOy3ZgyWkQTbWOMN2ZXe/oEm+G
 10/Vtbp2uhq9XH7k+wVzQGMM5beTd99pz1XiokVmcZC++4EcVDgf7Jwc6BVENCAMCfO84oRIk
 M4ts6fuZhltEUr7QUJb+UYB6cRO5I3gzEGG0I9pte17g+4+mntCqH4httyorHo/0NvfD406T1
 Nubi3oiz96Vi/BYumkhq2FhujDOSNZONZwTUjoM5T7n0X0IN8U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.10.2018 um 22:37 schrieb René Scharfe:
> Am 01.10.2018 um 21:26 schrieb Derrick Stolee:
>> On 10/1/2018 3:16 PM, René Scharfe wrote:
>>> Am 28.06.2018 um 14:31 schrieb Derrick Stolee via GitGitGadget:
>>>> diff --git a/commit-reach.c b/commit-reach.c
>>>> index c58e50fbb..ac132c8e4 100644
>>>> --- a/commit-reach.c
>>>> +++ b/commit-reach.c
>>>> @@ -513,65 +513,88 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
>>>>   	return is_descendant_of(commit, list);
>>>>   }
>>>>   
>>>> -int reachable(struct commit *from, int with_flag, int assign_flag,
>>>> -	      time_t min_commit_date)
>>>> +static int compare_commits_by_gen(const void *_a, const void *_b)
>>>>   {
>>>> -	struct prio_queue work = { compare_commits_by_commit_date };
>>>> +	const struct commit *a = (const struct commit *)_a;
>>>> +	const struct commit *b = (const struct commit *)_b;
>>> This cast is bogus.  QSORT gets handed a struct commit **, i.e. an array
>>> of pointers, and qsort(1) passes references to those pointers to the
>>> compare function, and not the pointer values.
>>
>> Good catch! I'm disappointed that we couldn't use type-checking here, as 
>> it is quite difficult to discover that the types are wrong here.
> 
> Generics in C are hard, and type checking traditionally falls by the
> wayside.  You could use macros for that, like klib [*] does, but that
> has its own downsides (more object text, debugging the sort macros
> themselves is harder).
> 
> [*] https://github.com/attractivechaos/klib/blob/master/ksort.h

We could also do something like this to reduce the amount of manual
casting, but do we want to?  (Macro at the bottom, three semi-random
examples at the top.)
---
 bisect.c          | 11 +++--------
 commit-graph.c    |  9 ++-------
 commit-reach.c    | 12 +++++-------
 git-compat-util.h | 12 ++++++++++++
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/bisect.c b/bisect.c
index e8b17cf7e1..06be3a3c15 100644
--- a/bisect.c
+++ b/bisect.c
@@ -192,16 +192,11 @@ struct commit_dist {
 	int distance;
 };
 
-static int compare_commit_dist(const void *a_, const void *b_)
-{
-	struct commit_dist *a, *b;
-
-	a = (struct commit_dist *)a_;
-	b = (struct commit_dist *)b_;
+DEFINE_SORT(sort_by_commit_dist, struct commit_dist, a, b, {
 	if (a->distance != b->distance)
 		return b->distance - a->distance; /* desc sort */
 	return oidcmp(&a->commit->object.oid, &b->commit->object.oid);
-}
+})
 
 static struct commit_list *best_bisection_sorted(struct commit_list *list, int nr)
 {
@@ -223,7 +218,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 		array[cnt].distance = distance;
 		cnt++;
 	}
-	QSORT(array, cnt, compare_commit_dist);
+	sort_by_commit_dist(array, cnt);
 	for (p = list, i = 0; i < cnt; i++) {
 		struct object *obj = &(array[i].commit->object);
 
diff --git a/commit-graph.c b/commit-graph.c
index 7f4519ec3b..a2202414e0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -550,12 +550,7 @@ static void write_graph_chunk_large_edges(struct hashfile *f,
 	}
 }
 
-static int commit_compare(const void *_a, const void *_b)
-{
-	const struct object_id *a = (const struct object_id *)_a;
-	const struct object_id *b = (const struct object_id *)_b;
-	return oidcmp(a, b);
-}
+DEFINE_SORT(sort_oids, struct object_id, a, b, return oidcmp(a, b))
 
 struct packed_commit_list {
 	struct commit **list;
@@ -780,7 +775,7 @@ void write_commit_graph(const char *obj_dir,
 
 	close_reachable(&oids);
 
-	QSORT(oids.list, oids.nr, commit_compare);
+	sort_oids(oids.list, oids.nr);
 
 	count_distinct = 1;
 	for (i = 1; i < oids.nr; i++) {
diff --git a/commit-reach.c b/commit-reach.c
index 2f5e592d16..3aef47c3dd 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -527,17 +527,15 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
 	return is_descendant_of(commit, list);
 }
 
-static int compare_commits_by_gen(const void *_a, const void *_b)
-{
-	const struct commit *a = *(const struct commit * const *)_a;
-	const struct commit *b = *(const struct commit * const *)_b;
-
+DEFINE_SORT(sort_commits_by_gen, struct commit *, ap, bp, {
+	const struct commit *a = *ap;
+	const struct commit *b = *bp;
 	if (a->generation < b->generation)
 		return -1;
 	if (a->generation > b->generation)
 		return 1;
 	return 0;
-}
+})
 
 int can_all_from_reach_with_flag(struct object_array *from,
 				 unsigned int with_flag,
@@ -580,7 +578,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 		nr_commits++;
 	}
 
-	QSORT(list, nr_commits, compare_commits_by_gen);
+	sort_commits_by_gen(list, nr_commits);
 
 	for (i = 0; i < nr_commits; i++) {
 		/* DFS from list[i] */
diff --git a/git-compat-util.h b/git-compat-util.h
index 5f2e90932f..f9e78d69a2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1066,6 +1066,18 @@ static inline void sane_qsort(void *base, size_t nmemb, size_t size,
 		qsort(base, nmemb, size, compar);
 }
 
+#define DEFINE_SORT(name, elemtype, one, two, code)			\
+static int name##_compare(const void *one##_v_, const void *two##_v_)	\
+{									\
+	elemtype const *one = one##_v_;					\
+	elemtype const *two = two##_v_;					\
+	code;								\
+}									\
+static void name(elemtype *array, size_t n)				\
+{									\
+	QSORT(array, n, name##_compare);				\
+}
+
 #ifndef HAVE_ISO_QSORT_S
 int git_qsort_s(void *base, size_t nmemb, size_t size,
 		int (*compar)(const void *, const void *, void *), void *ctx);
-- 
2.19.0


