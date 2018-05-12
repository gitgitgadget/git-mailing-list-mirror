Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B85C81F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751033AbeELIpd (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:45:33 -0400
Received: from mout.web.de ([212.227.17.11]:60505 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750902AbeELIpc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:45:32 -0400
Received: from [192.168.178.36] ([91.20.55.213]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPpIE-1fCUSz0rHW-0053vT; Sat, 12
 May 2018 10:45:19 +0200
Subject: Re: [PATCH] fast-export: avoid NULL pointer arithmetic
To:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de>
 <99d443cd-e817-7db5-f758-bf4cf47f7c06@web.de>
 <xmqqo9hniy1v.fsf@gitster-ct.c.googlers.com>
 <654fac2a-8dca-7bee-2bab-a3986aa7e52d@web.de>
 <xmqqbmdnhr8b.fsf@gitster-ct.c.googlers.com>
 <xmqq7eoahk49.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AN4nssu1+x0x9Kmz1BB1aXO7_UBFCjpyULMeC5K-Fzvw@mail.gmail.com>
 <20180511085634.GC22086@sigill.intra.peff.net>
 <CACsJy8CnJYsgDe11tK4JzH2sDRuLwgoUz=HCso5qOhEfyZNH5Q@mail.gmail.com>
 <20180511133419.GA2170@duynguyen.home>
 <20180511174237.GA19670@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <80397e16-8667-e0cd-4049-aad453d35e6f@web.de>
Date:   Sat, 12 May 2018 10:45:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511174237.GA19670@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:i5U2H2y8K1ZQdChFwKZH68GEgtIC034oDX7w0tUjSa+S0d8O6IA
 vvRialETDWWiQTt7MptluMbiEx+/ix7GMKdABX0nx2hqNlpPb5qkmbSPN6Kraog6/PAseaW
 wP27mmMq/v8CzXSuGOFE/qrd1MDCHr/EdmH8i4aPdKazBO5w8jWCG37kISWSgvhY+F9//X9
 RXsSxqbJjomMy/ms+oZgA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iVfJlZ9GE/E=:aaQFdOoZZ9g2+IOO3If68+
 Kp3S97h+g3NuXoH/r2/WBP7y3lyFELjRTEGJCYwhazh6ldVSJEYIcEwJZBUT8tWW8Rg7PzX+1
 mBnVR5DUmQbogwx8VzEYbm1JUXP0E0DXCHNyDxljYrCDjCKy3xUvnqlD6czmDbhj3VZiLfymj
 wmU5XamiN2asYl/UHTpNrDWNXtwgxmwN1IKFD83W2lYhATLqrPijKIz7dUDlskSVPDX2e+8p6
 1ah6ryaMgHdRJgi9F3MhstPQ+2BPSFSOKvey8JVD7ILZIMfU+yCyuDqaE7ZCxrGCHoGjFX0nK
 ZZQTcFkDin8hyCl0FsMME1e3NhOn75iyWsWKkpsKTCu07VBljtYndEsH3K8YTIDOa7TAYQYzV
 skHHwUg9hWanJlBcL6bCSQpWWK4EHwzLCCab0o7lKezDcX7ZIivvnZFhBwbcCIO3U8wTK1kSN
 oXzPeu/HUZCWH5lmJIT2Z7a+sUjF93uAiKL+j76DuIY7yYe8ER/Vo11K/M0GheVBwbESgstyd
 o38GAT5Sarz/XD6Kzh034YQ/+j8bqGYHsE+2UjotZTR1HnIrR8VkdDRDUDk//3ElnG9orSAPk
 6rH3sX7jD0E3+WlIbc3m/CZuZfNHx7jbWQey68FegqB6BjHV9iQmPJgZLjGsMKD9RsssO+Gon
 YVozB0Dve+gPr2GLIQCw8Ud9HjHFWdLjrUc2N1DOQiPLZPdwM3vBN+rMJZnyLWTcO6d59bFTi
 VuYh6MI+RNt6Q2Wzs/qaXZ7FuwAdjaK+yMyP8c6gJm/SD/6djJoHNgBUnT6s1BWaimah2/gdS
 0LJGKyU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.05.2018 um 19:42 schrieb Jeff King:
> On Fri, May 11, 2018 at 03:34:19PM +0200, Duy Nguyen wrote:
> 
>> On Fri, May 11, 2018 at 03:11:46PM +0200, Duy Nguyen wrote:
>>> Back to fast-export, can we just allocate a new int on heap and point
>>> it there? Allocating small pieces becomes quite cheap and fast with
>>> mem-pool.h and we can avoid this storing integer in pointer business.
>>
>> Something like this seems to work, but we use 4-ish more bytes per
>> object, or 100MB overhead on a repo with 25M objects. I think it's a
>> reasonable trade off.
> 
> I'm not sure I agree. 4 bytes per object certainly isn't the end of the
> world, but what was the problem we were solving in the first place? Just
> that we weren't comfortable with the round-trip from uintptr_t to void
> and back? Is this actually a problem on real platforms? If not, it seems
> silly to incur a run-time cost.

Storing integer values in pointers is a trick that seems to have worked
so far for fast-export.  A portable way to avoid that trick without
requiring more memory would be to use a union.

Or we could roll our own custom hash map, as I mused in an earlier post.
That would duplicate quite a bit of code; are there reusable pieces
hidden within that could be extracted into common functions?

---
 builtin/fast-export.c | 105 ++++++++++++++++++++++++++++++++----------
 1 file changed, 81 insertions(+), 24 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 530df12f05..627b0032f3 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -14,7 +14,6 @@
 #include "diffcore.h"
 #include "log-tree.h"
 #include "revision.h"
-#include "decorate.h"
 #include "string-list.h"
 #include "utf8.h"
 #include "parse-options.h"
@@ -71,9 +70,65 @@ static int parse_opt_tag_of_filtered_mode(const struct option *opt,
 	return 0;
 }
 
-static struct decoration idnums;
+struct object_mark_entry {
+	const struct object *base;
+	uint32_t mark;
+};
+
+struct object_marks {
+	unsigned int size;
+	unsigned int nr;
+	struct object_mark_entry *entries;
+};
+
+static struct object_marks idnums;
 static uint32_t last_idnum;
 
+static unsigned int hash_obj(const struct object *obj, unsigned int n)
+{
+	return sha1hash(obj->oid.hash) % n;
+}
+
+static void set_object_mark(struct object_marks *n, const struct object *base,
+			    uint32_t mark)
+{
+	unsigned int size = n->size;
+	struct object_mark_entry *entries = n->entries;
+	unsigned int j = hash_obj(base, size);
+
+	while (entries[j].base) {
+		if (entries[j].base == base) {
+			entries[j].mark = mark;
+			return;
+		}
+		if (++j >= size)
+			j = 0;
+	}
+	entries[j].base = base;
+	entries[j].mark = mark;
+	n->nr++;
+}
+
+static void grow_object_marks(struct object_marks *n)
+{
+	unsigned int i;
+	unsigned int old_size = n->size;
+	struct object_mark_entry *old_entries = n->entries;
+
+	n->size = (old_size + 1000) * 3 / 2;
+	n->entries = xcalloc(n->size, sizeof(n->entries[0]));
+	n->nr = 0;
+
+	for (i = 0; i < old_size; i++) {
+		const struct object *base = old_entries[i].base;
+		uint32_t mark = old_entries[i].mark;
+
+		if (mark)
+			set_object_mark(n, base, mark);
+	}
+	free(old_entries);
+}
+
 static int has_unshown_parent(struct commit *commit)
 {
 	struct commit_list *parent;
@@ -156,20 +211,13 @@ static void anonymize_path(struct strbuf *out, const char *path,
 	}
 }
 
-/* Since intptr_t is C99, we do not use it here */
-static inline uint32_t *mark_to_ptr(uint32_t mark)
-{
-	return ((uint32_t *)NULL) + mark;
-}
-
-static inline uint32_t ptr_to_mark(void * mark)
-{
-	return (uint32_t *)mark - (uint32_t *)NULL;
-}
-
 static inline void mark_object(struct object *object, uint32_t mark)
 {
-	add_decoration(&idnums, object, mark_to_ptr(mark));
+	unsigned int nr = idnums.nr + 1;
+
+	if (nr > idnums.size * 2 / 3)
+		grow_object_marks(&idnums);
+	return set_object_mark(&idnums, object, mark);
 }
 
 static inline void mark_next_object(struct object *object)
@@ -179,10 +227,21 @@ static inline void mark_next_object(struct object *object)
 
 static int get_object_mark(struct object *object)
 {
-	void *decoration = lookup_decoration(&idnums, object);
-	if (!decoration)
+	unsigned int j;
+
+	/* nothing to lookup */
+	if (!idnums.size)
 		return 0;
-	return ptr_to_mark(decoration);
+	j = hash_obj(object, idnums.size);
+	for (;;) {
+		struct object_mark_entry *ref = idnums.entries + j;
+		if (ref->base == object)
+			return ref->mark;
+		if (!ref->base)
+			return 0;
+		if (++j == idnums.size)
+			j = 0;
+	}
 }
 
 static void show_progress(void)
@@ -897,8 +956,7 @@ static void handle_tags_and_duplicates(void)
 static void export_marks(char *file)
 {
 	unsigned int i;
-	uint32_t mark;
-	struct decoration_entry *deco = idnums.entries;
+	struct object_mark_entry *entry = idnums.entries;
 	FILE *f;
 	int e = 0;
 
@@ -907,15 +965,14 @@ static void export_marks(char *file)
 		die_errno("Unable to open marks file %s for writing.", file);
 
 	for (i = 0; i < idnums.size; i++) {
-		if (deco->base && deco->base->type == 1) {
-			mark = ptr_to_mark(deco->decoration);
-			if (fprintf(f, ":%"PRIu32" %s\n", mark,
-				oid_to_hex(&deco->base->oid)) < 0) {
+		if (entry->base && entry->base->type == 1) {
+			if (fprintf(f, ":%"PRIu32" %s\n", entry->mark,
+				    oid_to_hex(&entry->base->oid)) < 0) {
 			    e = 1;
 			    break;
 			}
 		}
-		deco++;
+		entry++;
 	}
 
 	e |= ferror(f);
-- 
2.17.0
