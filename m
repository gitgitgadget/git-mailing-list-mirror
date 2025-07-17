Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D724503B
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744062; cv=none; b=X8m0BjIa5Iho+7WcDPgb51BxfUmuRPZWH7sScM+VEBn7BHR1cif6r2NbfIyrP16DpM//H+vXgcixw10OUJbYPG6T4Gk9fCpcQMuJsva4DTm6VdeANJIlEARL5tdZ98l60A+wtttWn4T0zc6p9q/PH66fFJ3ix+djFsntHia2WNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744062; c=relaxed/simple;
	bh=K3NDmqx1n6lOgqxOumYWI0WVlUndx39+31YjOsJ8vYg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CSP4/fmOdJRzgQ4hVIVdGQ1xVslpkpna267TSb8Tr8OAxmf3F8gtjlpHnTl1ZMWfA+EYuwA/NHIK8FpkzFmmtOQKWMRaSGBXIpTYoBS6hzqWEx09z4u3pa/c7shA/Y0TWxngK3EHsdLSvu0olppT/5Rt0uiFo0ybdqxqn3HKnz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=FFxsQOKG; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="FFxsQOKG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752744054; x=1753348854; i=l.s.r@web.de;
	bh=Lb5ADlxfm34UneQdby3+4rdHj8QQKTGemV5uxuxVy1M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FFxsQOKG3easQigG9sbY+2C3sS0bLt1MGWK917x+bOd/TRExSDOpF/sNIkIaICxK
	 SmR/SsJKJsLCI6cPS8zUs5Aj1vbj9suI6oWWvyhKhjKnlqVAbOf25J6d6PS9TKKhR
	 JPtfN5w9jto/LiSx8sXUOgfdDqmQHQ0D3/RMVxipUiFNmvfLEEdlDx/9L4I6ZISU4
	 +33zahNKbMUBDuA/ExZQjY2qoHmNve1RRkZF91JJzkygyiZssYlsddtOLAEZJM5hh
	 +N7aeZUw0g9NkhOa+Y84CpiKLYV+zcoynbduYjBF2ffeYZXO7dQ7WI0Oip3d2Iyb+
	 62HroXGnrNroyPibAw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnpL4-1uwbm81V18-00brcR; Thu, 17
 Jul 2025 11:20:54 +0200
Message-ID: <4ed087c9-0229-4219-8cbd-55f9ee79ca35@web.de>
Date: Thu, 17 Jul 2025 11:20:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] prio-queue: add prio_queue_replace()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <cbabed69-b44a-4920-9a56-e81b404be2de@web.de>
 <20250716050933.GC1396022@coredump.intra.peff.net>
 <298dd1d6-7756-4ecb-9202-d77491541253@web.de>
Content-Language: en-US
In-Reply-To: <298dd1d6-7756-4ecb-9202-d77491541253@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HPSIMgpa1arHVWCq7sklKIgS5tO1RXP81iGYXLyswaEyjZgnu+z
 PqTbIbiG7mJloOrJCW0FC8Fm08eGXvESsa2C0B9vnj+ZX3WcmAs6LmnFOmBMkLsGOx2SfqD
 sOxdAZEN9U+kACV7onxcwXHo0/NCohja1D6s1n/Bx/YBFDMu9XNmK4s+ldskm7qw8sjCbik
 0+FznTOhTlbaQM0IjviDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lVgxa2JUkcU=;jvIHVdStPcvE90qbmQ2uQ/044e3
 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
 9retc6RMCq2euQ=

On 7/16/25 11:38 AM, Ren=C3=A9 Scharfe wrote:
> On 7/16/25 7:09 AM, Jeff King wrote:
>> On Tue, Jul 15, 2025 at 04:51:22PM +0200, Ren=C3=A9 Scharfe wrote:
>>
>>> Add a function to replace the top element of the queue that basically
>>> does the same as prio_queue_get() followed by prio_queue_put(), but
>>> without the work by prio_queue_get() to rebalance the heap.  It can be
>>> used to optimize loops that get one element and then immediately add
>>> another one.  That's common e.g., with commit history traversal, where
>>> we get out a commit and then put in its parents.
>>
>> Hmm. But surely we still need to rebalance the heap after adding an
>> element? And indeed, we still call the new sift_down_root() function.
>=20
> Yes.
>=20
>> But I guess we are getting away without the "bubble up" operation that
>> put would do? So we are doing half as much work (but still big-O the
>> same)?
>=20
> Yes.
>=20
> I thought about building this optimization into prio_queue_get(), but
> that would require prio_queue_peek() and prio_queue_put() to be adjusted
> as well and all prio_queue users would have to be either made aware of
> the not-fully-heapified state, or prevented from accessing prio_queue
> properties like .nr and .array.

Here's what that would like like.  .nr and .array elements are kept
consistent at all times, but the root item is not in heap order after a
prio_queue_get().  That's good enough to enumerate all prio_queue items
like commit-reach.c::queue_has_nonstale() or
negotiator/skipping.c::push_parent() do.

Not sure what other weird patterns people might come up with that
require touching the innards of a prio_queue directly.  I don't even
understand why negotiator/skipping.c::push_parent() does a linear
search for each parent -- isn't that expensive?  Setting an object
flag on prio_queue_put() and clearing it on prio_queue_get() or a
using a commit_slab seem to be better options from a very cursory
glance.

Anyway, here's what doing prio_queue_replace() automatically could look
like.  I almost talked myself into using it now.  Any objections, ideas
on how to make it safer or clearer, other thoughts?

Ren=C3=A9

=2D--
 prio-queue.c | 52 +++++++++++++++++++++++++++++++++++++++-------------
 prio-queue.h |  1 +
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/prio-queue.c b/prio-queue.c
index ec33ac27db..265663e116 100644
=2D-- a/prio-queue.c
+++ b/prio-queue.c
@@ -34,12 +34,46 @@ void clear_prio_queue(struct prio_queue *queue)
 	queue->nr =3D 0;
 	queue->alloc =3D 0;
 	queue->insertion_ctr =3D 0;
+	queue->sift_down_root_pending =3D false;
+}
+
+static void sift_down_root(struct prio_queue *queue)
+{
+	size_t ix, child;
+
+	/* Push down the one at the root */
+	for (ix =3D 0; ix * 2 + 1 < queue->nr; ix =3D child) {
+		child =3D ix * 2 + 1; /* left */
+		if (child + 1 < queue->nr &&
+		    compare(queue, child, child + 1) >=3D 0)
+			child++; /* use right child */
+
+		if (compare(queue, ix, child) <=3D 0)
+			break;
+
+		swap(queue, child, ix);
+	}
+	queue->sift_down_root_pending =3D false;
 }
=20
 void prio_queue_put(struct prio_queue *queue, void *thing)
 {
 	size_t ix, parent;
=20
+	if (queue->sift_down_root_pending) {
+		/*
+		 * Restore the original heap size.  The last item is
+		 * still in the right place.
+		 */
+		queue->nr++;
+
+		/* Now fill the hole at the root with the new item. */
+		queue->array[0].ctr =3D queue->insertion_ctr++;
+		queue->array[0].data =3D thing;
+		sift_down_root(queue);
+		return;
+	}
+
 	/* Append at the end */
 	ALLOC_GROW(queue->array, queue->nr + 1, queue->alloc);
 	queue->array[queue->nr].ctr =3D queue->insertion_ctr++;
@@ -61,31 +95,21 @@ void prio_queue_put(struct prio_queue *queue, void *th=
ing)
 void *prio_queue_get(struct prio_queue *queue)
 {
 	void *result;
-	size_t ix, child;
=20
 	if (!queue->nr)
 		return NULL;
 	if (!queue->compare)
 		return queue->array[--queue->nr].data; /* LIFO */
=20
+	if (queue->sift_down_root_pending)
+		sift_down_root(queue);
 	result =3D queue->array[0].data;
 	if (!--queue->nr)
 		return result;
=20
 	queue->array[0] =3D queue->array[queue->nr];
=20
-	/* Push down the one at the root */
-	for (ix =3D 0; ix * 2 + 1 < queue->nr; ix =3D child) {
-		child =3D ix * 2 + 1; /* left */
-		if (child + 1 < queue->nr &&
-		    compare(queue, child, child + 1) >=3D 0)
-			child++; /* use right child */
-
-		if (compare(queue, ix, child) <=3D 0)
-			break;
-
-		swap(queue, child, ix);
-	}
+	queue->sift_down_root_pending =3D true;
 	return result;
 }
=20
@@ -95,5 +119,7 @@ void *prio_queue_peek(struct prio_queue *queue)
 		return NULL;
 	if (!queue->compare)
 		return queue->array[queue->nr - 1].data;
+	if (queue->sift_down_root_pending)
+		sift_down_root(queue);
 	return queue->array[0].data;
 }
diff --git a/prio-queue.h b/prio-queue.h
index 38d032636d..6d8d268f41 100644
=2D-- a/prio-queue.h
+++ b/prio-queue.h
@@ -32,6 +32,7 @@ struct prio_queue {
 	void *cb_data;
 	size_t alloc, nr;
 	struct prio_queue_entry *array;
+	bool sift_down_root_pending;
 };
=20
 /*
=2D-=20
2.50.1

