Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7252B39525B
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783617; cv=none; b=Qbls3aWx/nrkh14RCaFKGUG3AnLu4i3NYznryxiZwkEI1Ysj4wcQ4N7EWvkct9xjLOBkjxc14/gdSeE9TSHgeQy9mOBi7x5M9AsrhhkKN/caAj0yNG3v7rpAWMWCAl6Bl9Wv3S1HVAfdWzdq/zYKC5EtunnhCkLWckcqXS8uW38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783617; c=relaxed/simple;
	bh=9ChJ7RoCoQMHBYlPIohBZNVSlXqYsQivqkNaNlU1N6Y=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=QbEW9QR4I9JWePors1M301nNfojKEcBWu52kehRvH55P6TAFr69OPZp4N1xsXrBvaygA/7Xd9Gvt+3xtPM4IY8wwsawAgxlxLznjLeERnuWwJdcEGQra+JeUF6EfCpuhah4yHikSLr162Sk4YUL0Wlszfq9igLMZUsWBf1zD1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=P/Is/Gdh; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="P/Is/Gdh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773783607; x=1774388407; i=l.s.r@web.de;
	bh=RgGg0Fr0bvNDrvX8h5AW4KMUVLDPKcmrIp04idcfzEk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=P/Is/GdhnyeeSaQqZXl++KJarKYdMO64m07peisQ+5hlZdA28D6/lx2EU3XWpmZG
	 hzhMkI9pM4gipQVAXPLX5n/GtMucIqbWDm2b7eUmJ33tfYxesSxGimKCE9MZLJovR
	 4k0xlcygtJtvgVpFVyr7HiqB0sRw5OMH88STwrT7mS8dgxc6qjNguMLkpTJtaw9+R
	 TGGQcfWL38Y+Fc4/hxB6aFY141vYGOTXtYRlNqqaglQbuzkKBMfTFxgSoksTHfW7T
	 QEkEQeg4KB892OaCHhIpuFsbof3P0IyIGjvLbdl642S44EJsxDe+4NhB1iHYmaPgB
	 JS+zXIu4UB8p9ePyKg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfkd-1wA08w2puX-00Z4q3 for
 <git@vger.kernel.org>; Tue, 17 Mar 2026 22:40:07 +0100
Message-ID: <05fc946f-6670-46e9-a058-231ee464029d@web.de>
Date: Tue, 17 Mar 2026 22:40:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use commit_stack instead of prio_queue in LIFO mode
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ktn9BZHzG/uuJVdX/3z8c4mgDy1oh7hWuq2POGspFM9jAg5Tznj
 przOM9hv+vwwhg1gdx2vfIcSx1D2nW1iasXdadP04NVRlLFpZJbUSwFCJnVn2e2iLmJXL2O
 IxhFtS9x2bzvECgelMxXiI7iZdJdr/jrkrulHcqiOz1qS5yFJcVUw6O4Gh8NRybFqiI+LcY
 6gvbAFuOeLr3u1b3VDT2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8AudUUw2jzo=;CjaGfL0mQBMwm2X4D7uj4mWiNxA
 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

A prio_queue with a NULL compare function acts as a stack -- the last
element in is the first one out (LIFO).  Use an actual commit_stack
instead where possible, as it documents the behavior better, provides
type safety and saves some memory because prio_queue stores an
additional tie-breaking counter per element.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/name-rev.c    | 16 +++++++---------
 negotiator/default.c  | 10 +++++-----
 negotiator/skipping.c | 10 +++++-----
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6188cf98ce..d6594ada53 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -12,7 +12,6 @@
 #include "object-name.h"
 #include "pager.h"
 #include "parse-options.h"
-#include "prio-queue.h"
 #include "hash-lookup.h"
 #include "commit-slab.h"
 #include "commit-graph.h"
@@ -178,7 +177,7 @@ static void name_rev(struct commit *start_commit,
 		const char *tip_name, timestamp_t taggerdate,
 		int from_tag, int deref, struct mem_pool *string_pool)
 {
-	struct prio_queue queue;
+	struct commit_stack stack =3D COMMIT_STACK_INIT;
 	struct commit *commit;
 	struct commit_stack parents_to_queue =3D COMMIT_STACK_INIT;
 	struct rev_name *start_name;
@@ -197,10 +196,9 @@ static void name_rev(struct commit *start_commit,
 	else
 		start_name->tip_name =3D mem_pool_strdup(string_pool, tip_name);
=20
-	memset(&queue, 0, sizeof(queue)); /* Use the prio_queue as LIFO */
-	prio_queue_put(&queue, start_commit);
+	commit_stack_push(&stack, start_commit);
=20
-	while ((commit =3D prio_queue_get(&queue))) {
+	while ((commit =3D commit_stack_pop(&stack))) {
 		struct rev_name *name =3D get_commit_rev_name(commit);
 		struct commit_list *parents;
 		int parent_number =3D 1;
@@ -241,13 +239,13 @@ static void name_rev(struct commit *start_commit,
 			}
 		}
=20
-		/* The first parent must come out first from the prio_queue */
+		/* The first parent must come out first from the stack */
 		while (parents_to_queue.nr)
-			prio_queue_put(&queue,
-				       commit_stack_pop(&parents_to_queue));
+			commit_stack_push(&stack,
+					  commit_stack_pop(&parents_to_queue));
 	}
=20
-	clear_prio_queue(&queue);
+	commit_stack_clear(&stack);
 	commit_stack_clear(&parents_to_queue);
 }
=20
diff --git a/negotiator/default.c b/negotiator/default.c
index 116dedcf83..3cac0476a7 100644
=2D-- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -57,19 +57,19 @@ static int clear_marks(const struct reference *ref, vo=
id *cb_data UNUSED)
 static void mark_common(struct negotiation_state *ns, struct commit *comm=
it,
 		int ancestors_only, int dont_parse)
 {
-	struct prio_queue queue =3D { NULL };
+	struct commit_stack stack =3D COMMIT_STACK_INIT;
=20
 	if (!commit || (commit->object.flags & COMMON))
 		return;
=20
-	prio_queue_put(&queue, commit);
+	commit_stack_push(&stack, commit);
 	if (!ancestors_only) {
 		commit->object.flags |=3D COMMON;
=20
 		if ((commit->object.flags & SEEN) && !(commit->object.flags & POPPED))
 			ns->non_common_revs--;
 	}
-	while ((commit =3D prio_queue_get(&queue))) {
+	while ((commit =3D commit_stack_pop(&stack))) {
 		struct object *o =3D (struct object *)commit;
=20
 		if (!(o->flags & SEEN))
@@ -94,12 +94,12 @@ static void mark_common(struct negotiation_state *ns, =
struct commit *commit,
 				if ((p->object.flags & SEEN) && !(p->object.flags & POPPED))
 					ns->non_common_revs--;
=20
-				prio_queue_put(&queue, parents->item);
+				commit_stack_push(&stack, parents->item);
 			}
 		}
 	}
=20
-	clear_prio_queue(&queue);
+	commit_stack_clear(&stack);
 }
=20
 /*
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 0a272130fb..fe4126ca4d 100644
=2D-- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -91,15 +91,15 @@ static int clear_marks(const struct reference *ref, vo=
id *cb_data UNUSED)
  */
 static void mark_common(struct data *data, struct commit *seen_commit)
 {
-	struct prio_queue queue =3D { NULL };
+	struct commit_stack stack =3D COMMIT_STACK_INIT;
 	struct commit *c;
=20
 	if (seen_commit->object.flags & COMMON)
 		return;
=20
-	prio_queue_put(&queue, seen_commit);
+	commit_stack_push(&stack, seen_commit);
 	seen_commit->object.flags |=3D COMMON;
-	while ((c =3D prio_queue_get(&queue))) {
+	while ((c =3D commit_stack_pop(&stack))) {
 		struct commit_list *p;
=20
 		if (!(c->object.flags & POPPED))
@@ -113,11 +113,11 @@ static void mark_common(struct data *data, struct co=
mmit *seen_commit)
 				continue;
=20
 			p->item->object.flags |=3D COMMON;
-			prio_queue_put(&queue, p->item);
+			commit_stack_push(&stack, p->item);
 		}
 	}
=20
-	clear_prio_queue(&queue);
+	commit_stack_clear(&stack);
 }
=20
 /*
=2D-=20
2.53.0
