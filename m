Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309E2745C
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771256299; cv=none; b=cYzV/4MVPBqkvQdoUyH5j07LiTc/68bkNrxFYkTQwClQT5L0u9sAzha2aI9/e2zDpnAt/BeU3Gqzkbl5V6YexHVk9KgoT+XQqVvRGfYzZV/iijgOEHCbxEmGuEz9WQpTvE3PtTu0lnZ9uoeQJo7/ESPt5Xx4nyVuKnmOYNtDhsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771256299; c=relaxed/simple;
	bh=ZQYkUKRuhPlWnBq7jq/DdFv1f0nVn6ML0JdcmKCxPbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EGsOxnK9KzF+V5jdjuFqEmRUqCXIPfMGZ0tt+g5LAemLqIiVb98m05Hd1YuDVomtZiYeS//8uWaJCsr1DmuOOZv9w51zg12J8QH7YD2i6k+0aHmZGTPFSQsiO/zDfs5P5etV7JlHxR1wPXKniFsrr32nxieChZlu66rpi7BMD7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jbpDBRdO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ejvkr7ML; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jbpDBRdO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ejvkr7ML"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0B2BDEC05AD;
	Mon, 16 Feb 2026 10:38:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 16 Feb 2026 10:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771256297;
	 x=1771342697; bh=7HcBuB7CHBmQ/Rno05C7kpmDK5y2nVDDbWWGvuwt6xw=; b=
	jbpDBRdObpsNgJoccclUqWVE2CfM3p/TmA8YfXva6BkT6IVif9pkIA4C2VKAvjOI
	u9vqBuJamhEhOdTikjxvSz0me9NBNxq9D+TBhUICGTf14bVS+NzH5JiFM+8uMOB6
	/kCVyNjrwAJ1jBZXLCsrJ2lCCXqrrYuH6BcxAEUnFEX3dG4LnjEEn7KpEshw+NCE
	Nerby0RAdR7m1oGTsLFptaKtvA1YHjcaihAJpXdVca4Hg2J6BYffBfDx7CHlgXI2
	2U/CjFbA3iFVS6aeSH0PXIrE71rgEhRn8XcfFpJIeWur/GNjJ+SIQi6pabSXAKy0
	mgDyJ8/E/HwRIjDXKyGfaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771256297; x=
	1771342697; bh=7HcBuB7CHBmQ/Rno05C7kpmDK5y2nVDDbWWGvuwt6xw=; b=E
	jvkr7MLSIlEnyEwvl9QT2RlAG2ilMywpDVJhvDdUnNJVs/NWtjZODqiDYuCpKzvY
	eTwBOE0gU7HeWSZBAjCr/YHV9gZd1zaPhpB8QdNsi13DKQVAYveeyj9+rYUQGG0x
	J+/nIY71xTQo2CkTebsJe5eezeNwuzzPMTbOcq5b+eywwljpHbfrQUxHfZV0VjNL
	ODEMItxidpVgME+6AOi7AH/025zRXze2EYu5pHuHPmbqGiUUGS5do5Qym8mr6Mih
	1UGKewm+5bG/9dmIswBm6LxQQmKVMG5DZWgStnPR/1nMqjqof1QvFOFiZQFHMGYp
	flrPs92s9JvvwY0HjMIAg==
X-ME-Sender: <xms:6DmTaU1-VZA6n-OI5fF_v6nC_6npkAySmR8UF5Y5hjHSJ_bXKmVCIQ>
    <xme:6DmTaVGUb1EncyUhV7T3uL7G0FI-tZ2z-4uK-E80I2gbhORaGIOelggkwk-NaO_OF
    _69IOil5CawapPnu-r9ZnBwRGZHgjy9Fq1apaSVPJoiJMW9srGOew>
X-ME-Received: <xmr:6DmTaajitxgrbn_u89LVHJwlil6IESbjyTRifWKsmIo1ThklnfeqAiKzveHGjMDR3TLfrvqD0tx34mEpn-frC3CBJKP3dl1aaXAq0haSWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudejvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6DmTaY-6qIZfDCKDR0LbO5ttDgFQQkzbGS7sl2pfWGQo8uDt9XyR9Q>
    <xmx:6DmTaZpmDtU5O9TnAFdSxgph4ZNq1YBYyj3xLlPJZFWnwq0kmCFodA>
    <xmx:6DmTaf_232ao3VfaBFnhX9RHcd-FrR0YZPjJGA02kRaPg7RXbeLDYw>
    <xmx:6DmTaVX37bWwnpbg-ty9JG_ZR9e-ycc3XSYqRDQOvS_WJLcP8GkODA>
    <xmx:6TmTaRnWFt3rn0bx4ryUkkNdJ4rDEjQsmpNyuzf0h5A-CDDyDIvZF5Yz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 10:38:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6f8a359a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Feb 2026 15:38:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Feb 2026 16:38:01 +0100
Subject: [PATCH 1/3] commit: avoid parsing non-commits in
 `lookup_commit_reference_gently()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-b4-pks-receive-pack-optimize-shallow-v1-1-e98886daff2b@pks.im>
References: <20260216-b4-pks-receive-pack-optimize-shallow-v1-0-e98886daff2b@pks.im>
In-Reply-To: <20260216-b4-pks-receive-pack-optimize-shallow-v1-0-e98886daff2b@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>
X-Mailer: b4 0.14.3

The function `lookup_commit_reference_gently()` can be used to look up a
committish by object ID. As such, the function knows to peel for example
tag objects so that we eventually end up with the commit.

The function is used quite a lot throughout our tree. One such user is
"shallow.c" via `assign_shallow_commits_to_refs()`. The intent of this
function is to figure out whether a shallow push is missing any objects
that are required to satisfy the ref updates, and if so, which of the
ref updates is missing objects.

This is done by painting the tree with `UNINTERESTING`. We start
painting by calling `refs_for_each_ref()` so that we can mark all
existing referenced objects as the boundary of objects that we already
have, and which are supposed to be fully connected. The reference tips
are then parsed via `lookup_commit_reference_gently()`, and the commit
commit is then marked as uninteresting.

But references may not necessarily point to a committish, and if a lot
of them aren't then this step takes a lot of time. This is mostly due to
the way that `lookup_commit_reference_gently()` is implemented: before
we learn about the type of the object we already call `parse_object()`
on the object ID. This has two consequences:

  - We parse all objects, including trees and blobs, even though we
    don't even need the contents of them.

  - More importantly though, `parse_object()` will cause us to check
    whether the object ID matches its contents.

Combined this means that we deflate and hash every non-committish
object, and that of course ends up being both CPU- and memory-intensive.

Improve the logic so that we first use `peel_object()`. This function
won't parse the object for us, and thus it allows us to learn about the
object's type before we parse and return it.

The following benchmark pushes a single object from a shallow clone into
a repository that has 100,000 refs. These refs were created by listing
all objects via `git rev-list(1) --objects --all` and creating refs for
a subset of them, so lots of those refs will cover non-commit objects.

  Benchmark 1: git-receive-pack (rev = HEAD~)
    Time (mean ± σ):     62.571 s ±  0.413 s    [User: 58.331 s, System: 4.053 s]
    Range (min … max):   62.191 s … 63.010 s    3 runs

  Benchmark 2: git-receive-pack (rev = HEAD)
    Time (mean ± σ):     38.339 s ±  0.192 s    [User: 36.220 s, System: 1.992 s]
    Range (min … max):   38.176 s … 38.551 s    3 runs

  Summary
    git-receive-pack . </tmp/input (rev = HEAD) ran
      1.63 ± 0.01 times faster than git-receive-pack . </tmp/input (rev = HEAD~)

This leads to a sizeable speedup as we now skip reading and parsing
non-commit objects. Before this change we spent around 40% of the time
in `assign_shallow_commits_to_refs()`, after the change we only spend
around 1.2% of the time in there. Almost the entire remainder of the
time is spent in git-rev-list(1) to perform the connectivity checks.

Despite the speedup though, this also leads to a massive reduction in
allocations. Before:

  HEAP SUMMARY:
      in use at exit: 352,480,441 bytes in 97,185 blocks
    total heap usage: 2,793,820 allocs, 2,696,635 frees, 67,271,456,983 bytes allocated

And after:

  HEAP SUMMARY:
      in use at exit: 17,524,978 bytes in 22,393 blocks
    total heap usage: 33,313 allocs, 10,920 frees, 407,774,251 bytes allocated

Note that when all references refer to commits performance stays roughly
the same, as expected. The following benchmark was executed with 600k
commits:

  Benchmark 1: git-receive-pack (rev = HEAD~)
    Time (mean ± σ):      9.101 s ±  0.006 s    [User: 8.800 s, System: 0.520 s]
    Range (min … max):    9.095 s …  9.106 s    3 runs

  Benchmark 2: git-receive-pack (rev = HEAD)
    Time (mean ± σ):      9.128 s ±  0.094 s    [User: 8.820 s, System: 0.522 s]
    Range (min … max):    9.019 s …  9.188 s    3 runs

  Summary
    git-receive-pack (rev = HEAD~) ran
      1.00 ± 0.01 times faster than git-receive-pack (rev = HEAD)

This will be improved in the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit.c | 32 +++++++++++++++++++++++++++-----
 object.c | 23 ++++++++++++++++++-----
 object.h |  5 +++++
 3 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/commit.c b/commit.c
index 9bb471d217..b7c4ec2eb5 100644
--- a/commit.c
+++ b/commit.c
@@ -43,13 +43,35 @@ const char *commit_type = "commit";
 struct commit *lookup_commit_reference_gently(struct repository *r,
 		const struct object_id *oid, int quiet)
 {
-	struct object *obj = deref_tag(r,
-				       parse_object(r, oid),
-				       NULL, 0);
+	const struct object_id *maybe_peeled;
+	struct object_id peeled_oid;
+	struct object *object;
+	enum object_type type;
 
-	if (!obj)
+	switch (peel_object_ext(r, oid, &peeled_oid, 0, &type)) {
+	case PEEL_NON_TAG:
+		maybe_peeled = oid;
+		break;
+	case PEEL_PEELED:
+		maybe_peeled = &peeled_oid;
+		break;
+	default:
 		return NULL;
-	return object_as_type(obj, OBJ_COMMIT, quiet);
+	}
+
+	if (type != OBJ_COMMIT) {
+		if (!quiet)
+			error(_("object %s is a %s, not a %s"),
+			      oid_to_hex(oid), type_name(type),
+			      type_name(OBJ_COMMIT));
+		return NULL;
+	}
+
+	object = parse_object(r, maybe_peeled);
+	if (!object)
+		return NULL;
+
+	return object_as_type(object, OBJ_COMMIT, quiet);
 }
 
 struct commit *lookup_commit_reference(struct repository *r, const struct object_id *oid)
diff --git a/object.c b/object.c
index 4669b8d65e..99b6df3780 100644
--- a/object.c
+++ b/object.c
@@ -207,10 +207,11 @@ struct object *lookup_object_by_type(struct repository *r,
 	}
 }
 
-enum peel_status peel_object(struct repository *r,
-			     const struct object_id *name,
-			     struct object_id *oid,
-			     unsigned flags)
+enum peel_status peel_object_ext(struct repository *r,
+				 const struct object_id *name,
+				 struct object_id *oid,
+				 unsigned flags,
+				 enum object_type *typep)
 {
 	struct object *o = lookup_unknown_object(r, name);
 
@@ -220,8 +221,10 @@ enum peel_status peel_object(struct repository *r,
 			return PEEL_INVALID;
 	}
 
-	if (o->type != OBJ_TAG)
+	if (o->type != OBJ_TAG) {
+		*typep = o->type;
 		return PEEL_NON_TAG;
+	}
 
 	while (o && o->type == OBJ_TAG) {
 		o = parse_object(r, &o->oid);
@@ -241,9 +244,19 @@ enum peel_status peel_object(struct repository *r,
 		return PEEL_INVALID;
 
 	oidcpy(oid, &o->oid);
+	*typep = o->type;
 	return PEEL_PEELED;
 }
 
+enum peel_status peel_object(struct repository *r,
+			     const struct object_id *name,
+			     struct object_id *oid,
+			     unsigned flags)
+{
+	enum object_type dummy;
+	return peel_object_ext(r, name, oid, flags, &dummy);
+}
+
 struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
 {
 	struct object *obj;
diff --git a/object.h b/object.h
index 4bca957b8d..8f98382243 100644
--- a/object.h
+++ b/object.h
@@ -309,6 +309,11 @@ enum peel_status peel_object(struct repository *r,
 			     const struct object_id *name,
 			     struct object_id *oid,
 			     unsigned flags);
+enum peel_status peel_object_ext(struct repository *r,
+				 const struct object_id *name,
+				 struct object_id *oid,
+				 unsigned flags,
+				 enum object_type *typep);
 
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p);

-- 
2.53.0.352.gd1286b26eb.dirty

