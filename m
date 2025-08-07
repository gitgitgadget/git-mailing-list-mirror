Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC3A2AD00
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754558588; cv=none; b=n0seDM+n03BwQsBNMWwf9cB1YcvcAIeOa6m1IFUdmb7qG7XWHjZ7/wsQyFJ6oTqXNJqrEM2njxK20h09z2lAWOp2fPgVONAqIbicsmqszkVRgU3N5CssnfDqd0PDubvhxtajAwFfu3c2Q0GGck0zq5t+Vrxn2mXpmOJYemxtRwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754558588; c=relaxed/simple;
	bh=rmvXg81gZ7H/1D/Fnm11+ANn1n11+T49H4qYZBclEvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GSBvDZMPugSGTfVASItde3i6UxR4YrbBmd9MJR3CFlNKrg8R1PzvIm4mK3MR+vH/spSNCm1jihzZMvyC6s+34vPa4w41bwQqSOS/8ZmgpBrYihSeLg3sUpkBcaeA4lAqHHowdp5FHsu1mKxbxnwnqWWuMbw1J7IasxN5Cy80Ivc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kzqJh57P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KOYNNSei; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kzqJh57P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KOYNNSei"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9FAD6EC0200;
	Thu,  7 Aug 2025 05:23:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 07 Aug 2025 05:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1754558584; x=1754644984; bh=7IhVoVHqKA
	NM1X2l6yz7TLpoigPfqgG9ppns7TB/p+c=; b=kzqJh57PQqPVNQk406lymMnhGZ
	j0dqPxGRwaXCOYZXX8tb82g3bOqLyye1M0n3SfD+fzjxhEthKs0KbEd7NacsMLyZ
	uwWNRccW1xbaPVaxEhvVtnJumw97Uctho5j3iKpqXXBOpuLVI1D2FbCjxFTJ2x6i
	NmwaWwYq+BnMhDbS3I9fxM0C7/Glqei/BVhPodh2fugyq+skmom5mm0TFwR7uLGx
	uRY3N8cCYngChb4iEZW1IwsJjybNgyp7SGN7I/+rBcWuYryzctUsa3V94ABhYSGy
	6rl4f+b6FUyh3Dxo3zwuWL3+IAO7UnLfHyXn5rhIse+R+sGu+p54se5Dq5bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754558584; x=1754644984; bh=7IhVoVHqKANM1X2l6yz7TLpoigPf
	qgG9ppns7TB/p+c=; b=KOYNNSei0kq8YiOzJtzSZFqaJxmIMP5aWYXgpzVPHVDC
	havAv7RRS0skmx+LJmRj49wKOe80opN6zk8bjLPSCiwcO5VbL+11JpgDasoYGiGo
	OqE2oxLpwaGQcdd2QiezZGr/6SppV5CitFHTl4WifQmOEEpLnh3j2+3BxZ7tZq6D
	QY509QGY+zLKyzbZXXv7YvZ3cic2r1ckmQvz/5iyszumbFLLMJl4VGq2RsJ9jMFK
	TjVHtouWuSf3mb1uL3IaGipHv/+gsWn4+9tkrbjLGjfZo/d+PA/AJcGRMCATQWzn
	yZi8BBtLdoGVduB2KJ6TJEBv3/PxSPqiW2JGI4iTxw==
X-ME-Sender: <xms:eHCUaAVaTcErvIDLPwz51tHVyAEncA8ilPQBI07Fa65EzUakiFwPhg>
    <xme:eHCUaAFlfsKaORxb70uWztoKqV_6CApmcUBmv0V-2rVahtt1hu426d5LXb9emIF4j
    L6CpN7M6Ty-3sHR_Q>
X-ME-Received: <xmr:eHCUaK0RHd-LOQg0F2bog-Yvuvbl28ASPoyTV6JVIwENF5A2jP1d-gkk6y14lGRp7d2VyV5JA0jXoFxhrO6QYdXk6xV4bePRneg_Fy5KBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eljeehudfghfefleehhfehhfetgeevhfefhfeffeekleefheejheejueegueevjeenucff
    ohhmrghinhepvghnthhrhigpnhhrrdhnrghmvgdpvghnthhrhigpnhhrrdhishenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:eHCUaKOx06P4k37XiQ97o2le-bCsLacU9zADxI2jHVpun6MFtWW-xg>
    <xmx:eHCUaB5u-xJOWW8QHV-6cisSie8SmJk1EQwamFwsgKVpp9U7mmc8Sw>
    <xmx:eHCUaM0e3tcprvmgVtPNUKzh7GfjhPbZ88jZ-ijmgLl9PBuzAoqBbA>
    <xmx:eHCUaKyMrJtY2LufLerKv9pND8z5cS7ArTMU0CvJB2eWE1WUabbSww>
    <xmx:eHCUaJp40JjisnvsWVH3AXI-96-rIpUwyN8B8Tl3b_hk54PiI_reycex>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 05:23:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a83e392e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 09:23:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 11:22:56 +0200
Subject: [PATCH] git-compat-util: introduce `count_t` typedef
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-pks-introduce-count-t-v1-1-e96be52d8db1@pks.im>
X-B4-Tracking: v=1; b=H4sIAG9wlGgC/x3MQQqAIBBA0avErBuYpEi7SrQIG2sINNQiiO6et
 HyL/x9IHIUTDNUDkS9JEnxBU1dgt9mvjLIUgyLVkaYejz2h+BzDclpGG06fMSO5tjXGaVKqgdI
 ekZ3c/3ec3vcDV3XtG2cAAAA=
X-Change-ID: 20250807-pks-introduce-count-t-0f4499f80221
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Historically, Git has been very lenient with its use of integer types
and didn't really give much thought into which type to use in what
situation. We interchangeably mix and match signed and unsigned types
and often times blindly convert them. This use has led to several
out-of-bounds reads and writes in the past, some of which could be
turned into arbitrary code execution.

As a counter measure we have eventually enabled "-Wsign-compare"
warnings. Most of our code base generates heaps of warnings, which is
why we have a macro `DISABLE_SIGN_COMPARE_WARNINGS` defined for every
such file. The expectation is that slowly but surely we'll convert our
code base to have better hygiene around signedness, and new code that is
being added handles types correctly from the start.

There are regular discussions around whether or not these warnings are
sensible to have in the first place. My (biased) opinion with having
fixed several out-of-bounds reads and writes is that they are senisble,
as they would have provided warnings around code sites that had those
issues. And arguably, we still have _lots_ of sites that are susceptible
to using the wrong type, and more likely than not some of those will be
exploitable.

Furthermore, I would claim that the question of whether or not those
warnings are helpful wouldn't have come up if we had the warnings
enabled from the inception of Git. The churn caused by the fixes for
such warnings is real, and they need to be done with a lot of care. But
since we have removed this project from our microprojects page we don't
see "random" contributions in this area anymore.

So overall, the conversions are on the painful side, but in the long
term they will help us to protect against introducing new exploits.

A discussion that regularly comes up in this context though is what
types to use for counting entities:

  - One question is whether the type should be signed or unsigned.
    Arguably, the answer should be to use unsigned types as long as we
    know that we never need a negative value, e.g. as a sentinel. This
    helps guide the reader and explicitly conveys the sense that such a
    counter is only ever going to be a non-negative number. Otherwise,
    code would need to be more careful as it may hold negative values.

  - Another question is what type to use. In lots of situations we have
    used `size_t`, but this is conflating semantics. `size_t` is used to
    count bytes, not entities.

Introduce a new typedef for `count_t` that is of type `uintptr_t` to
give clear guidance what type to use for counting entities. This type
was chosen because in the worst case, an entity may be a single byte and
we fill all of our memory with these entities. As `uintptr_t` is
guaranteed to hold at least the value of a pointer, we know that it
could be used to index into every single such entity.

Amend the coding guidelines to state when to use `size_t` and when to
use `count_t`. Convert an example file to use the new type.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/CodingGuidelines |  3 +++
 builtin/rm.c                   | 25 ++++++++++++-------------
 git-compat-util.h              | 15 +++++++++++++++
 3 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 224f0978a8..2e9f3c07ff 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -238,6 +238,9 @@ For shell scripts specifically (not exhaustive):
 
 For C programs:
 
+ - We use `size_t` to count the number of bytes and `count_t` to count the
+   number of entities of a given type.
+
  - We use tabs to indent, and interpret tabs as taking up to
    8 spaces.
 
diff --git a/builtin/rm.c b/builtin/rm.c
index 05d89e98c3..99b845cf34 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -33,11 +33,11 @@ static const char * const builtin_rm_usage[] = {
 };
 
 static struct {
-	int nr, alloc;
 	struct {
 		const char *name;
 		char is_submodule;
 	} *entry;
+	count_t entry_nr, entry_alloc;
 } list;
 
 static int get_ours_cache_pos(const char *path, unsigned int pos)
@@ -73,8 +73,7 @@ static void print_error_files(struct string_list *files_list,
 
 static void submodules_absorb_gitdir_if_needed(void)
 {
-	int i;
-	for (i = 0; i < list.nr; i++) {
+	for (count_t i = 0; i < list.entry_nr; i++) {
 		const char *name = list.entry[i].name;
 		int pos;
 		const struct cache_entry *ce;
@@ -106,14 +105,14 @@ static int check_local_mod(struct object_id *head, int index_only)
 	 * lazy, and who cares if removal of files is a tad
 	 * slower than the theoretical maximum speed?
 	 */
-	int i, no_head;
+	int no_head;
 	int errs = 0;
 	struct string_list files_staged = STRING_LIST_INIT_NODUP;
 	struct string_list files_cached = STRING_LIST_INIT_NODUP;
 	struct string_list files_local = STRING_LIST_INIT_NODUP;
 
 	no_head = is_null_oid(head);
-	for (i = 0; i < list.nr; i++) {
+	for (count_t i = 0; i < list.entry_nr; i++) {
 		struct stat st;
 		int pos;
 		const struct cache_entry *ce;
@@ -268,7 +267,7 @@ int cmd_rm(int argc,
 	   struct repository *repo UNUSED)
 {
 	struct lock_file lock_file = LOCK_INIT;
-	int i, ret = 0;
+	int ret = 0;
 	struct pathspec pathspec;
 	char *seen;
 
@@ -321,10 +320,10 @@ int cmd_rm(int argc,
 			continue;
 		if (!ce_path_match(the_repository->index, ce, &pathspec, seen))
 			continue;
-		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
-		list.entry[list.nr].name = xstrdup(ce->name);
-		list.entry[list.nr].is_submodule = S_ISGITLINK(ce->ce_mode);
-		if (list.entry[list.nr++].is_submodule &&
+		ALLOC_GROW(list.entry, list.entry_nr + 1, list.entry_alloc);
+		list.entry[list.entry_nr].name = xstrdup(ce->name);
+		list.entry[list.entry_nr].is_submodule = S_ISGITLINK(ce->ce_mode);
+		if (list.entry[list.entry_nr++].is_submodule &&
 		    !is_staging_gitmodules_ok(the_repository->index))
 			die(_("please stage your changes to .gitmodules or stash them to proceed"));
 	}
@@ -335,7 +334,7 @@ int cmd_rm(int argc,
 		char *skip_worktree_seen = NULL;
 		struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
 
-		for (i = 0; i < pathspec.nr; i++) {
+		for (int i = 0; i < pathspec.nr; i++) {
 			original = pathspec.items[i].original;
 			if (seen[i])
 				seen_any = 1;
@@ -390,7 +389,7 @@ int cmd_rm(int argc,
 	 * First remove the names from the index: we won't commit
 	 * the index unless all of them succeed.
 	 */
-	for (i = 0; i < list.nr; i++) {
+	for (count_t i = 0; i < list.entry_nr; i++) {
 		const char *path = list.entry[i].name;
 		if (!quiet)
 			printf("rm '%s'\n", path);
@@ -414,7 +413,7 @@ int cmd_rm(int argc,
 		int removed = 0, gitmodules_modified = 0;
 		struct strbuf buf = STRBUF_INIT;
 		int flag = force ? REMOVE_DIR_PURGE_ORIGINAL_CWD : 0;
-		for (i = 0; i < list.nr; i++) {
+		for (count_t i = 0; i < list.entry_nr; i++) {
 			const char *path = list.entry[i].name;
 			if (list.entry[i].is_submodule) {
 				strbuf_reset(&buf);
diff --git a/git-compat-util.h b/git-compat-util.h
index 9408f463e3..e9c30d59e8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -610,6 +610,21 @@ static inline bool strip_suffix(const char *str, const char *suffix,
 int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
 
+/*
+ * The type used to count the number of entities, e.g. in an array. We have
+ * historically used `size_t` for this, but `size_t` is expected to count the
+ * maximum number of _bytes_, not entities.
+ *
+ * The counter is unsigned. If you need to store sentinel values like `-1` you
+ * should use a different type.
+ *
+ * Note that we pick `uintptr_t` because in the theoretical worst case, every
+ * entity is a single byte and we populate the entire address space with them.
+ * As `uintptr_t` is able to point to every addressable byte it would also be
+ * able to count them all.
+ */
+typedef uintptr_t count_t;
+
 static inline size_t st_add(size_t a, size_t b)
 {
 	if (unsigned_add_overflows(a, b))

---
base-commit: 64cbe5e2e8a7b0f92c780b210e602496bd5cad0f
change-id: 20250807-pks-introduce-count-t-0f4499f80221

