Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA71F4A8401
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440134; cv=none; b=GXk+GDEYQ4qqlAvoaE/UxOQglpG0WIGsatc/Bz02RJPAMJreiT3bRAahUYAUoVWrp0LZsKJ+dmrpO9xwIiXql28lhH5t0UtgsndwF22bVe5H2EKgbIjUCTLn+QNgdSdKU/N7CMrWHGcbuoa/dbaSF/Kn5Zh6RfqbaHIDsjku41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440134; c=relaxed/simple;
	bh=SAAv9+pA5+jKP5+L0N7kqwhjZDHleBCq7w6WkEvNDN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1DGr39oGspNkvEhsnFihmbUes76RMXipurwNIJvzOZTzoRp2uhuhgZKQFc0uxkbNup0dhyooFhy1Uo70EpmaA0ZeU1NRaBwuyqX+0S4ZAfyXvSlux2RigTqFlDgpHDEcXPXe3Ym4isWZwGzkgx3urQUFOpYELXN2eIn0InSH5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=c1mPNJ+n; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="c1mPNJ+n"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so21161245e9.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788440131; x=1789044931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EoMVD8dFcthCryGKU+AB3FsyB2Yma9031FlJi0Pjd0E=;
        b=c1mPNJ+n9vLkg3qwWuaEsATnR5NkuSWNSqx5HjCCOUj0J7NyX0GfUlaaXZa0EdU4W2
         GZFmUME3bjAf8PNj5DS4na07pozTZKGiBfGzcwNNf/mDeKXeQuwe8vxZ7Jov9zisqoqd
         HEk29DcpF+UxHH4F/XJPkvHj6puS6ust8JN0j5eRl8yT+YyZSMVvw7iTKj/Iu9TxGYze
         HbFvNKl3doujq2qQA39p79bhPrc4caLJzoSTSLXIp2ZQwZRFoQY56UpJ63kh13qYNEZQ
         CR0cbW/Y7l/Wn9aBJ8xPHkhoA9cLfPLlBIN/Yd1CoAqz7ZIpdKlV8xROe9Yo1IqmGKxj
         lP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788440131; x=1789044931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EoMVD8dFcthCryGKU+AB3FsyB2Yma9031FlJi0Pjd0E=;
        b=HIk83SpQxq1VziejwCo92wtkym2rwE028ku2NHZ7of7R8HcHbbLMKPjD4S+lqjOcWH
         Z8y1ZgRa5h1GWESHJJx4JJIXqdUIxNEawl7aaO8dyuEtRUwhcFmTLxPg4292+3LDffPd
         u3+1r76sSt2BuHXYBt/20O22EV/QFqy64rdgsYEj5uk5pVi5hMuOqXXzPIeJCeT2mSRr
         6wSHLIpu1TKW/NyrmqrgtZZt14TrUKj7A5MUXkjmBVZUnfLeh7O6bH/3sa9oGlkx4XXy
         HWVGTf+VRKtnVi1ic0MDG8RXfKBrDDkmu5Ads8b8NwNYelqIzhBO73WI0BgDvKmuEIq0
         vYnA==
X-Gm-Message-State: AFuF++kpsO8rAktDRUZ22AJRyIJcCvC1d/54VgdggLmQJeiTGWOznq6i
	FrqXILKIfRJAt48tTY9XX1VvMIJjOMNo1qKTPtFud/A468Xr7/Hb9BSuoP46Qk9uS+tAAIU8wYo
	mPAsJEjSm/A==
X-Gm-Gg: AYBFou0Tx0Z661znSZnWH0bTX4LkU7/ovtckI+S9h8OpVk5ZLEkyfbNEKUmZQPBvrda
	F2idf6kiPAoP+U/HGOnAaPmP/w2kS/angmN2yvZhry96ci7ClpKBzJ1AAxeo7KxxJSUciMe5UNw
	ulfrNgp2jR462XpoDXHGoY/gcgDAW0/7m9oErryF3VcwoLfPYQD4B0gXmqVW3SqSPXq55v2PdGh
	9Nob98QGwzeNPzTYzpA3x1Q0BiKfw/nRsbdhx5ToQ293gMVGKCtACK+BfOoNw3ZaeE0ovrx2P2E
	rcVeUzjyDZGyXiIQISYAyJXUsyiVkS2gYGw5FwNS43G5r8M9hyQzDM7Qpo7/wqQEbhwtqevARrZ
	ptOcJPEwyS+/upqBYweL+YAaRzfAW6r0ukcA5HJFdUh9loaVgje3X+3OZljzPa+dPGYsqI/cP06
	ktOnuJULU/1ogj0KLcnSHLe1yeQtRWmITMgzX1iwuU/3hMFt5phWZyj/GpnCXp4KaCFhXc
X-Received: by 2002:a05:600c:5489:b0:499:4e47:eaf2 with SMTP id 5b1f17b1804b1-49ce58092a6mr189252435e9.6.1788440130993;
        Thu, 03 Sep 2026 05:55:30 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5e6115sm73168065e9.14.2026.09.03.05.55.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 05:55:30 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>
Subject: [PATCH] pack-objects: prefetch in the order objects are checked
Date: Thu,  3 Sep 2026 15:55:29 +0300
Message-ID: <20260903125529.67971-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_object_details() sorts a pointer array by pack and offset and
hands each object's position in that array down to prefetch_to_pack(),
which reads it as a position in to_pack.objects. That second array is
in the order the traversal added entries, so the batch of objects to
fetch starts at an unrelated entry.

An object missing from a partial clone sits in no pack, and the offset
sort places such entries ahead of packed ones. The index is small
enough that the batch still covers every missing object in a freshly
cloned repository. Loose objects held locally sort by object name
among the missing ones, and enough of them move the index past entries
that are themselves missing. Those never enter the batch, end up with
no recorded type, and are fetched one at a time as the pack is
written. Packing a list of 2 missing and 16 locally present loose
objects takes two fetches rather than one.

Index the sorted array in prefetch_to_pack() so the batch holds what
the caller has not reached yet.

This was introduced by e00549aa9b (pack-objects: prefetch objects to
be packed, 2020-07-20).

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    Measured on a synthetic repository of 5000 commits, each adding one
    file, cloned with --filter=blob:none over file:// so that all 5000
    blobs are absent.  Fetch invocations counted from GIT_TRACE2_EVENT
    child_start records, objects per fetch read from the --pack_header
    argument index-pack is given.
    
      input to pack-objects              before        after
      fresh blobless clone, --revs       1 fetch/5000  1 fetch/5000
      8 absent blobs, then 400 loose     8 fetches/1   1 fetch/8
    
    The first row is the ordinary case and does not move.
    pack_offset_sort compares the in_pack pointer before anything else,
    and an object that is not present has none, so every absent entry
    lands ahead of every packed entry.  On a fresh clone the first absent
    object is therefore at sorted index 0, and reading 0 as a
    traversal-order index selects the whole array by accident.
    
    The second row is the shape the fix is for.  Loose objects have no
    in_pack pointer either and sort by object name among the absent ones,
    which moves the first absent object to a nonzero sorted index.  The
    scan then starts that far into the traversal-order array.  In this
    input it collects nothing at all, promisor_remote_get_direct()
    returns early on an empty list, type -1 is recorded, and each object
    is fetched by itself while the pack is written.
    
    Alternatives considered:
    
      Drop the start index and scan all of to_pack.objects.  Obviously
      correct, and it removes a parameter rather than adding one.
      Rejected because it repeats the lookups for entries the caller has
      already checked, object_index_start of them on every call.
    
      Pass the unsorted index instead, entry - to_pack.objects.  One line
      at the call site and no new parameter.  Rejected because it only
      guarantees that the triggering object is in its own batch.  The scan
      would still cover an arbitrary suffix of the traversal order and
      leave out absent objects the caller has not reached.
    
    Left alone on purpose:
    
      prefetch_to_pack() keeps its opening brace on the declaration
      line.  CodingGuidelines says nothing about function braces, but
      .clang-format carries BreakBeforeBraces: Linux, so this is a rule
      rather than a habit.  It arrived with the commit named above and
      is one of 9 such definitions under builtin/, 2 of them in this
      file, the other being is_not_in_promisor_pack().  This patch
      rewrites that declaration, so moving the brace would cost one
      character.  Left out because it is not what the patch is about,
      and it is the same edit wherever it lands.
    
      check_object() takes entry, sorted_by_offset and object_index, and
      entry == sorted_by_offset[object_index] holds without being
      written down.  Deriving entry in the callee would make the
      mismatch this patch fixes impossible to express again.  Kept as it
      is because a function that checks one object reads better taking
      that object, and the file has one caller.
    
    Noticed nearby, not touched: pack_offset_sort() orders entries by
    comparing struct packed_git pointers that do not point into one
    array, which C99 6.5.8p5 leaves undefined.  The second paragraph of
    the message rests on that comparison sorting NULL first.  It holds on
    every platform git runs on and predates this patch by years.
    
    The test asserts one fetch round for a packing request of 2 absent and
    16 loose objects, and counts two without the code change, under both
    SHA-1 and SHA-256.  Which objects sort where depends on the hash, so
    the test checks its own precondition, that at least one loose object
    sorts before the first wanted one, instead of assuming it.  A hash
    change turns the test into a failure rather than into one that passes
    for the wrong reason.

 builtin/pack-objects.c | 13 +++++++-----
 t/t5300-pack-object.sh | 45 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 27048bbb4d..448ddb99eb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2227,12 +2227,13 @@ static int can_reuse_delta(const struct object_id *base_oid,
 	return 0;
 }
 
-static void prefetch_to_pack(uint32_t object_index_start) {
+static void prefetch_to_pack(struct object_entry **sorted_by_offset,
+			     uint32_t object_index_start) {
 	struct oid_array to_fetch = OID_ARRAY_INIT;
 	uint32_t i;
 
 	for (i = object_index_start; i < to_pack.nr_objects; i++) {
-		struct object_entry *entry = to_pack.objects + i;
+		struct object_entry *entry = sorted_by_offset[i];
 
 		if (!odb_read_object_info_extended(the_repository->objects,
 						   &entry->idx.oid,
@@ -2246,7 +2247,9 @@ static void prefetch_to_pack(uint32_t object_index_start) {
 	oid_array_clear(&to_fetch);
 }
 
-static void check_object(struct object_entry *entry, uint32_t object_index)
+static void check_object(struct object_entry *entry,
+			 struct object_entry **sorted_by_offset,
+			 uint32_t object_index)
 {
 	size_t canonical_size;
 	enum object_type type;
@@ -2389,7 +2392,7 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 	if (odb_read_object_info_extended(the_repository->objects, &entry->idx.oid, &oi,
 					  OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_LOOKUP_REPLACE) < 0) {
 		if (repo_has_promisor_remote(the_repository)) {
-			prefetch_to_pack(object_index);
+			prefetch_to_pack(sorted_by_offset, object_index);
 			if (odb_read_object_info_extended(the_repository->objects, &entry->idx.oid, &oi,
 							  OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_LOOKUP_REPLACE) < 0)
 				type = -1;
@@ -2619,7 +2622,7 @@ static void get_object_details(void)
 
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = sorted_by_offset[i];
-		check_object(entry, i);
+		check_object(entry, sorted_by_offset, i);
 		if (entry->type_valid &&
 		    oe_size_greater_than(&to_pack, entry,
 					 repo_settings_get_big_file_threshold(the_repository)))
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 73445782e7..d94e3d0630 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -650,6 +650,51 @@ test_expect_success 'prefetch objects' '
 	test_line_count = 1 donelines
 '
 
+test_expect_success 'prefetch objects that sort after locally present ones' '
+	test_when_finished "rm -rf batch_server batch_client" &&
+
+	git init batch_server &&
+	test_config -C batch_server uploadpack.allowanysha1inwant 1 &&
+	test_config -C batch_server uploadpack.allowfilter 1 &&
+	test_config -C batch_server protocol.version 2 &&
+
+	for i in $(test_seq 1 8)
+	do
+		echo "content $i" >batch_server/file$i || return 1
+	done &&
+	git -C batch_server add . &&
+	git -C batch_server commit -m initial &&
+
+	git clone --filter=blob:none --no-checkout \
+		"file://$(pwd)/batch_server" batch_client &&
+	test_config -C batch_client protocol.version 2 &&
+
+	git -C batch_client rev-list --objects --all --missing=print >objects &&
+	sed -n "s/^?//p" objects | sort >absent &&
+	tail -n 2 absent >wanted &&
+
+	>loose_names &&
+	for i in $(test_seq 1 16)
+	do
+		echo "loose $i" |
+		git -C batch_client hash-object -w --stdin >>loose_names ||
+			return 1
+	done &&
+	sort loose_names >loose &&
+
+	# Objects that are in no pack are visited first, in object name
+	# order, so at least one locally present object has to be visited
+	# before the first wanted one for this to test anything.
+	awk -v limit="$(head -n 1 wanted)" "\$0 \"\" < limit \"\"" loose >earlier &&
+	test_file_not_empty earlier &&
+
+	cat wanted loose >to_pack &&
+	GIT_TRACE_PACKET=$(pwd)/trace_batch \
+		git -C batch_client pack-objects --stdout <to_pack >/dev/null &&
+	grep "fetch> done" trace_batch >donelines_batch &&
+	test_line_count = 1 donelines_batch
+'
+
 for hash in sha1 sha256
 do
 	test_expect_success "verify-pack with $hash packfile" '

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0

