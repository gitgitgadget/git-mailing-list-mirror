Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2EE6088F
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 01:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102059; cv=none; b=T4dJZQpsAbE/QQOTBs9DUsCNm7WPOM6zAjodpCOEkIlvnYDzEm568vILC8Ymz2jQyln0l7fRgMEQMaAIg7SevcS4cRCnvN99B+TPBybxvkL0MJMNgIMHxOJ0DxLjXcCQS3ch81JrEzK5X1Z9rUUb4JwatZ8PBZjW4pVo1ufbLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102059; c=relaxed/simple;
	bh=r7L2kc9JpY0YpesDKyq1wTJYHk4zmBeAt9tMrY7iPro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FTISl49Jwi5L5jzTqUBHcg5cShUW+UH6TgTzcVBvnHXFa4/Nbm99rBdRBct9uW3YSnSY3BJ7RLgZG567b0eA7eP6YADGeJcXy4wFwdWIgsqyLhMzZvmITVZOqckCcTW+On74I79wmjjWavFd9fSPc6EANUh0WkF+YIonhPS4Jvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nhfku/Cm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fXHVGy5Y; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nhfku/Cm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fXHVGy5Y"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C99DE13809BA;
	Thu, 20 Feb 2025 20:40:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 20 Feb 2025 20:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1740102055;
	 x=1740188455; bh=5LXflxQm/ve3jz4+J2b6RYF7Y9gQjBfX1nbkiCiM0qs=; b=
	nhfku/Cm/xsSFwNcww2hNRkv91a3fbWu6fG4oG2lN3hZimp2hQqAoKprsxsS7N8Z
	MlzVVEfyQFNM+gyXplJ9b+IMog8YJGmQbRk6XtQ17HL6MVKz3cHZPde0MMiAMLji
	ANYGKX0ZPx7gcK0PX80iYlNJFFt377WQHRoKlIDzrj6NEy4VskYXTfqAuqux42if
	GxxeIDW7VDfEuB9l6RdhrE1w5y83QTxq6MymYBzHatxmClyFNRVL3wbG8dgRb3wa
	iKWzvEKBYeEVVjNrkmKVKyZjCsVUNiC9JTWXMDTj0D73mOHcr+qE2xuxdSae7ORa
	YL3SqcGgxH/pCK1vfpl8gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1740102055; x=
	1740188455; bh=5LXflxQm/ve3jz4+J2b6RYF7Y9gQjBfX1nbkiCiM0qs=; b=f
	XHVGy5Y4YWZG4SsLZjymwA3G6yntnF0cf4zJuyg/O1ikFMHqkKcYqQeVhtGIXH9/
	yosw0QQkzf4ECYwyICtXHmfpkjoO9DjctPv5QHEN+RKozVUX25jaR2Z3m4seDl9L
	CczTosqfOwV9p0MQrMm0Z5UhOpHyv3rBDn3geVnbOwMaHrac/UAUrRpfY0L/8HUU
	lIhttitDKhSTNLY4m+caCgt+yjNBveMO9uUjXPCzy2AQyDp5ZEgr4czUP7ve+oh1
	qIL6KxDnHn6fEOOAXWczjwmlao8aplLBm1EX2CEbj0qaYveroy8GQnYLRfg+VB+x
	hYnRyepOfGuqOYsiJKJ0w==
X-ME-Sender: <xms:p9m3Z89faiJmGGAK6Qde_O71bTfifakK0t4CRiUw-u33lemtbjNu9A>
    <xme:p9m3Z0vhKFYJywExl9E8beZYMFbnigO-1OnJ0rjPL_Ft5VwRkdUppwGyJgXQMc6Yp
    s1Lk5ITCU9Xao000A>
X-ME-Received: <xmr:p9m3ZyCnVRzf3UXKphgGTV6It49_B44q-WSCLsqfn29wYXQ8uj6kvbrm0cYpqTVyMReKhqXhI4WWavAyf7ou46Y1qd-ADIgOHwLqKIo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeikeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepgefhleekgfdukeekveeiueefieelveej
    ieeugeetgeevhfeujeekheejueefkeefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    dpsghishgvtghtrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhope
    ehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehurdhklhgvihhn
    vgdqkhhovghnihhgsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:p9m3Z8dUAhtawAB6N7zeYDb2yFmoWHY7ea1q2GQSlgGqUPLJg3XOyw>
    <xmx:p9m3ZxOn4I240rtESuH2zwEuQLmcj9piL9qC9VCfxI24cAQxP-dAww>
    <xmx:p9m3Z2nRLD-T_p-8j7hCvuLvgzXp2Di8tnK_SqKaz-P5QtVOCWStMg>
    <xmx:p9m3ZzsRo7dv61K0Gm0pVoVLeHLHA2wIwUXsiorNQjmq-CHFygnKJQ>
    <xmx:p9m3Z01bcx2KBYqgrCVfbuChEH6qoqZ6ul6t6zCMgzZ6UFK5CqRK5MnL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 20:40:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6ni?=
 =?utf-8?Q?g?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: first bisection step takes quite a while
In-Reply-To: <xmqqikp4ctoh.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	20 Feb 2025 11:17:18 -0800")
References: <arrp2ye3kid76pwghguu5z4jkpv7xsskzdsjunbfkgmwejgby5@qh4phxwzenyp>
	<CALnO6CACJTKasKT9rX9w4_r9q0DPOPZhGnHt8f65oo6Q=8NxEg@mail.gmail.com>
	<xmqqikp4ctoh.fsf@gitster.g>
Date: Thu, 20 Feb 2025 17:40:53 -0800
Message-ID: <xmqqa5agcbx6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
>> On Thu, Feb 20, 2025 at 9:38 AM Uwe Kleine-König
>> <u.kleine-koenig@baylibre.com> wrote:
>>>
>>> Hello,
>>>
>>> today I did a bisection in the kernel repository:
>>>
>>>         linux$ git version
>>>         git version 2.47.1
>>>
>>>         linux$ time git bisect start 09fbf3d502050282bf47ab3babe1d4ed54dd1fd8 96d8eab5d0a1a9741a4cae1b3c125d75d1aabedf
>>>         Bisecting: 572238 revisions left to test after this (roughly 19 steps)
>>>         [eafdca4d7010a0e019aaaace3dd71b432a69b54c] Merge tag 'staging-4.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
>>>
>>>         real    18m41.374s
>>>         user    27m18.306s
>>>         sys     1m0.565s
>>>
>>> I was surprised that it took that long to find and checkout the first
>>> revision to check. (That is on a 4 x Intel(R) Core(TM) i5-6440HQ CPU @
>>> 2.60GHz, 16 GiB RAM with a Samsung SSD. On a different machine (56 x
>>> Intel(R) Xeon(R) CPU E5-2660 v4 @ 2.00GHz, 256 GiB RAM and (I think a
>>> spinning hard disk)) it took nearly an hour.
>>
>> Related thread:
>> https://lore.kernel.org/git/19461b87a5c.5a2ea74016716.8214238482389812984@zohomail.com/
>
> Indeed.  I haven't had a chance to dig any deeper in the area of the
> code since that discussion, but the ideas raised in the messages
> near the tail end of the thread may be worth exploring.
>
> THanks for the link.

So, here is something that _could_ be the beginning of a patch, but
just to illustrate what I tried.

 * In do_find_bisection(), we try each commit on the incoming commit
   list (which is sorted the way rev-list emits, probably reversed)
   and count how many commits in the set each merge commit can reach
   (which is called "weight") in the "honest and stupid" way.  I try
   to collect these merges in a linear array, and try from the
   middle to older and newer.  As the loop to compute weight for
   merges have an early-exit clause that says "oh, this is good
   enough", this may improve our odds to find a good enough merge
   early.

 * The "this is good enough" logic currently allows us to be within
   0.1% of the real halfway point.  Until the candidate set becomes
   small enough, we could loosen the criteria to allow larger, say
   3%, slack.  This code is written but not enabled (with "0 &&").

 * After computing the weight for a merge in "honest and stupid"
   way, we know what other commits in the set it can reach.  If the
   weight we computed is way smaller than the half the number of
   commits in the set, that means these commits we can reach from
   the merge we are looking at would score even lower.  We could
   mark them as not-viable before clearing the list to check next
   merge with "honest and stupid" way.  Again, this code is written
   but not enabled.

So, in short, I have three ideas, and with the first one (that
is the most straightforward and least error prone) alone, it seems
that we gain significant speedup.

The current code took ~20 minutes for me and its result is

$ git bisect start --no-checkout 09fbf3d5020 96d8eab5d0a1
Bisecting: 581164 revisions left to test after this (roughly 19 steps)
[2c71ab4bb465c79a4687cc2fd5012e470aebdb1f] Merge branch 'for-upstre...

There are 1144459 commits in the range, and the point chosen by
bisection can reach 563294 of them.  563294*2 == 1126588, so we are
1144459 - 1126588 = 17871 commits away from the theoretical halfway.

With the "let's try from the midway merges" approach without
changing anything else, I get a different commit (because the
original algorithm is taking "good enough" early exit), and it took
about 30 seconds.

$ git bisect start --no-checkout 09fbf3d5020 96d8eab5d0a1
Bisecting: 572238 revisions left to test after this (roughly 19 steps)
[eafdca4d7010a0e019aaaace3dd71b432a69b54c] Merge tag 'staging-4.18-...

The size of the original range is the same, of course, 1144459
commits, and the point chosen by bisection reaches 572220 of them.
Since 572220*2 = 1144440, we are 1144459 - 1144440 = 19 commits from
the theoretical halfway.

My current thinking is that the heuristics #1 (which is enabled in
my experiment and in the following patch) is good enough, #2
(loosening the "good enough" threshold) is probably not very
effective, and #3 (discard ones that are closer to the good end than
a merge that is known to be not viable) might be interesting to
pursue further but probably tricky to get right.

Comments?


 bisect.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 8 deletions(-)

diff --git c/bisect.c w/bisect.c
index 7a3c77c6d8..eae8e97958 100644
--- c/bisect.c
+++ w/bisect.c
@@ -23,6 +23,7 @@
 #include "object-store-ll.h"
 #include "path.h"
 #include "dir.h"
+#include "trace2.h"
 
 static struct oid_array good_revs;
 static struct oid_array skipped_revs;
@@ -132,8 +133,10 @@ static inline int approx_halfway(struct commit_list *p, int nr)
 		 * good enough if it's within ~0.1% of the halfway point,
 		 * e.g. 5000 is exactly halfway of 10000, but we consider
 		 * the values [4996, 5004] as halfway as well.
+		 * While we have really large number of commits, we'll
+		 * loosen our target to hit within 3% of the harfway.
 		 */
-		if (abs(diff) < nr / 1024)
+		if ((0 && 10000 < nr && abs(diff) < nr / 64) || abs(diff) < nr / 1024)
 			return 1;
 		return 0;
 	}
@@ -282,11 +285,15 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 					     int nr, int *weights,
 					     unsigned bisect_flags)
 {
-	int n, counted;
+	int n, counted, num_merges;
 	struct commit_list *p;
+	struct commit_list **merge; /* ugh */
 
+	num_merges = 0;
 	counted = 0;
+	num_merges = 0;
 
+	trace2_region_enter("bisect", "do_find_bisection_0", the_repository);
 	for (n = 0, p = list; p; p = p->next) {
 		struct commit *commit = p->item;
 		unsigned commit_flags = commit->object.flags;
@@ -309,16 +316,30 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			weight_set(p, -1);
 			break;
 		default:
+			num_merges++;
 			weight_set(p, -2);
 			break;
 		}
 	}
+	trace2_region_leave("bisect", "do_find_bisection_0", the_repository);
 
 	show_list("bisection 2 initialize", counted, nr, list);
 
+	/*
+	 * Collect merges into an array.
+	 */
+	CALLOC_ARRAY(merge, num_merges);
+	for (n = 0, p = list; p; p = p->next) {
+		if (weight(p) != -2)
+			continue;
+		merge[n++] = p;
+	}
+	if (num_merges != n)
+		BUG("Whoa!");
+
 	/*
 	 * If you have only one parent in the resulting set
-	 * then you can reach one commit more than that parent
+	 * then you can reach one commit more than your parent
 	 * can reach.  So we do not have to run the expensive
 	 * count_distance() for single strand of pearls.
 	 *
@@ -330,25 +351,73 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 	 * So we will first count distance of merges the usual
 	 * way, and then fill the blanks using cheaper algorithm.
 	 */
-	for (p = list; p; p = p->next) {
-		if (p->item->object.flags & UNINTERESTING)
-			continue;
+	trace2_region_enter("bisect", "do_find_bisection_1", the_repository);
+
+	/*
+	 * Use the element of a list from its midpoint.
+	 * (num_merges == 1) mid = 0; ix = 0
+	 * (num_merges == 2) mid = 0; ix = 0, 1
+	 * (num_merges == 3) mid = 1; ix = 1, 2, 0
+	 * (num_merges == 4) mid = 1; ix = 1, 2, 0, 3
+	 * (num_merges == 5) mid = 2; ix = 2, 3, 1, 4, 0
+	 * (num_merges == 6) mid = 2; ix = 2, 3, 1, 4, 0, 5
+	 */
+	for (n = 0; n < num_merges; n++) {
+		struct commit_list *p;
+		int ix = (num_merges - 1) / 2;
+
+		if (n % 2)
+			ix += (n + 1) / 2;
+		else
+			ix -= n / 2;
+
+		p = merge[ix];
 		if (weight(p) != -2)
 			continue;
 		if (bisect_flags & FIND_BISECTION_FIRST_PARENT_ONLY)
 			BUG("shouldn't be calling count-distance in fp mode");
 		weight_set(p, count_distance(p));
+
+#if 0
+		/* 
+		 * If the current merge can reach way fewer than half
+		 * the commits in the graph, any of its ancestors can
+		 * reach even fewer commits, which means they will not
+		 * make better half-way candidate than this one.
+		 *
+		 * Just as a slack, let's cut at 3/8 not exactly 1/2.
+		 */
+		if (weight(p) * 8 < nr * 3) {
+			for (struct commit_list *q = list; q; q = q->next) {
+				if (q->item->object.flags & UNINTERESTING)
+					continue;
+				if (!(q->item->object.flags & COUNTED))
+					continue;
+				if (weight(q) != -2)
+					continue;
+				/* mark it as not a viable candidate */
+				weight_set(q, 1);
+			}
+		}
+#endif
 		clear_distance(list);
 
 		/* Does it happen to be at half-way? */
 		if (!(bisect_flags & FIND_BISECTION_ALL) &&
-		      approx_halfway(p, nr))
+		    approx_halfway(p, nr)) {
+			trace2_data_string("bisect", the_repository, "early-exit", "do_find_bisection_1");
+			trace2_region_leave("bisect", "do_find_bisection_1", the_repository);
+			free(merge);
 			return p;
+		}
 		counted++;
 	}
+	trace2_region_leave("bisect", "do_find_bisection_1", the_repository);
+	free(merge);
 
 	show_list("bisection 2 count_distance", counted, nr, list);
 
+	trace2_region_enter("bisect", "do_find_bisection_2", the_repository);
 	while (counted < nr) {
 		for (p = list; p; p = p->next) {
 			struct commit_list *q;
@@ -384,10 +453,14 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 
 			/* Does it happen to be at half-way? */
 			if (!(bisect_flags & FIND_BISECTION_ALL) &&
-			      approx_halfway(p, nr))
+			    approx_halfway(p, nr)) {
+			trace2_data_string("bisect", the_repository, "early-exit", "do_find_bisection_2");
+				trace2_region_leave("bisect", "do_find_bisection_2", the_repository);
 				return p;
+			}
 		}
 	}
+	trace2_region_leave("bisect", "do_find_bisection_2", the_repository);
 
 	show_list("bisection 2 counted all", counted, nr, list);
 
