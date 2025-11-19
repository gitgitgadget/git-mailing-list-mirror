Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0463631D727
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538455; cv=none; b=Te4nGZToDePRH/uLxu95Chf8s2Zjq7yJiCUcLQhForRavRIpNlK9WuWlTXiTRK74fEc0AxJ+1pynEiSe2gS/HFBqIKXIqWXbKMK/5JvdXmnsvhvZ9QxxnSlb+uR7pIKVX2eZY/6LY3Ekb9KjEfzrE3eEX8/IMfYNEAqCBBhOWkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538455; c=relaxed/simple;
	bh=CE9AmYgTe3Kch5+RBtOtbr7bKyeO03OX4nARTsOYoJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rFt7GDPW3cqEKK6mISlI/FCLWVNnYIPzba53J9Gx55pRLENy+IG3gzpKTVcWip70p1tvVyA+9om37qsYZOL9Z8nQGuakSDdS7Ltlj2yxkwfY3+PaAV694HyvhmUcawHmRIlkyT0wVkWQCmyTuLLkexXGKHp1+irTze75PZ6s//Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nHP27aYy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WuTYahvX; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nHP27aYy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WuTYahvX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 039541400200
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:47:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 19 Nov 2025 02:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538452;
	 x=1763624852; bh=XkgSPJK/b3v8GPuOskJShJkWgBcoxDcsW3arxJekbs8=; b=
	nHP27aYy+P2Hqu1CqRptgqraAZ1j4+uBNNWgypXf1F0nPxyZY+l09Y6MvpdL5XGs
	ADuVsXhJC2gpfoB0fM9gAKzGL4bh3hjehjzV2LJdzJW/z9d5XENH805jyeAEfXyU
	F9nkUuZ3TSFICT8P8rZrmh7ILwkxs9ti8spGBWf1nH7WJbUg/AEvRz1BPrYOCt0J
	O/T+7qedqtI1WRzRzjyogY+gb2oLbWTz4SzXs9cDgJiRgPYwvDbW9ENFzuMemNk4
	f1a8XDfyMv+HOLFHntR66WWSqjbYr/DeKupb0GVtOLc5oYoV0JZdrjzVd2WUHocq
	j6HVV9/eLYN+Q7gOG3jG2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538452; x=
	1763624852; bh=XkgSPJK/b3v8GPuOskJShJkWgBcoxDcsW3arxJekbs8=; b=W
	uTYahvXFcxl5tQg4/UB8O+KeIjx8LTjVze40su37tt1+cAUu/LA0IqeFPAr6F3Zi
	Ntrqo0FilvslyCaNShBlbGdMBhYRr7qOxthLlJ6iYP42e3kChZavEdjjapuYyu0j
	6LSic6DmTN3cItNGRcGv/kwfC85yFGSEhyuea8lSdBLzpPp7hUss6LUXHQaKcvRN
	ydH2SRepg4RqwslshZLQg8KfwLg4C6tDDGeFZRy5YoJugbcxSZUiZKuGag5U/pZX
	oU2Ts4HfYTgiOmmfiLZEmFmNtOhQd09tPbtn9Bzhu+fCr/lgmuwxtH4i9FoAKbl4
	00cW0rD6+b6+HI/yyQWYA==
X-ME-Sender: <xms:E3YdaWFFbGKF0E5ZnfKhccwEWrus9gJLqSJ1myR8hFc6vAJ9f_V9TA>
    <xme:E3YdaeTEeujMbF4NiGzH1gy_A2n3lK3V4GlgY7i6Hiui6ijepg9Fd4BdAgnQm5k3L
    wA3YwUQgsh9l6oJ7PZxMY3NgEvwxBZfLhuGQ4zTSKQBAZ-XO6zf1g>
X-ME-Received: <xmr:E3YdaVwYff8jGH4MiFlIkmaR_y6CtDxew2X3LoZIiFYakra857apXR-7BtLAe8LO9HnWvL0n39qkEt5AHPadBvL-AerZ7wlId1Q2HhyGjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleff
    vdevleenucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphht
    thhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:E3YdaVOIa9EHrUUVFwUFdNRpsfQMUvJxrlC9C6CAfvIfn5O2YpRk-g>
    <xmx:E3YdacOS7A5V-MwnxC6na-1UYs2nd3JLBWfY7gGUZrfch3NskTG4ng>
    <xmx:E3YdafSbBA5QOhnkNyqf4-aymbXooyCm1lY8DcrA_7WorVJvMbWD7Q>
    <xmx:E3YdaWCoAoibTB5RVC8Ku8XKx3Lsh99Sm1g56PwfvsXl-D7LS_Hv-Q>
    <xmx:E3YdaYWS7krpurVxk-3o6dkFbkARs4t9iWmqiDkTbNkLwiRP1mrvgvRC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:47:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08cca7ba (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:47:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:47:02 +0100
Subject: [PATCH 02/18] streaming: drop the `open()` callback function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-read-stream-v1-2-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

When creating a read stream we first populate the structure with the
open callback function and then subsequently call the function. This
layout is somewhat weird though:

  - The structure needs to be allocated and partially populated with the
    open function before we can properly initialize it.

  - We never use the `open()` callback after having opened it initially.

Especially the first point creates a problem for us. In subsequent
commits we'll want to fully move construction of the read source into
the respective object sources. E.g., the loose object source will be the
one that is responsible for creating the structure. But this creates a
problem: if we first need to create the structure so that we can call
the source-specific callback we cannot fully handle creation of the
structure in the source itself.

We could of course work around that and have the loose object source
create the structure and populate it's `open()` callback, only. But
this doesn't really buy us anything due to the second bullet point
above.

Instead, drop the callback entirely and refactor `istream_source()` so
that we open the streams immediately. This unblocks a subsequent step,
where we'll also start to allocate the structure in the source-specific
logic.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/streaming.c b/streaming.c
index 1fb4b7c1c0..5ce6350123 100644
--- a/streaming.c
+++ b/streaming.c
@@ -14,10 +14,6 @@
 #include "replace-object.h"
 #include "packfile.h"
 
-typedef int (*open_istream_fn)(struct odb_read_stream *,
-			       struct repository *,
-			       const struct object_id *,
-			       enum object_type *);
 typedef int (*close_istream_fn)(struct odb_read_stream *);
 typedef ssize_t (*read_istream_fn)(struct odb_read_stream *, char *, size_t);
 
@@ -34,7 +30,6 @@ struct filtered_istream {
 };
 
 struct odb_read_stream {
-	open_istream_fn open;
 	close_istream_fn close;
 	read_istream_fn read;
 
@@ -437,21 +432,25 @@ static int istream_source(struct odb_read_stream *st,
 
 	switch (oi.whence) {
 	case OI_LOOSE:
-		st->open = open_istream_loose;
+		if (open_istream_loose(st, r, oid, type) < 0)
+			break;
 		return 0;
 	case OI_PACKED:
-		if (!oi.u.packed.is_delta &&
-		    repo_settings_get_big_file_threshold(the_repository) < size) {
-			st->u.in_pack.pack = oi.u.packed.pack;
-			st->u.in_pack.pos = oi.u.packed.offset;
-			st->open = open_istream_pack_non_delta;
-			return 0;
-		}
-		/* fallthru */
-	default:
-		st->open = open_istream_incore;
+		if (oi.u.packed.is_delta ||
+		    repo_settings_get_big_file_threshold(the_repository) >= size)
+			break;
+
+		st->u.in_pack.pack = oi.u.packed.pack;
+		st->u.in_pack.pos = oi.u.packed.offset;
+		if (open_istream_pack_non_delta(st, r, oid, type) < 0)
+			break;
+
 		return 0;
+	default:
+		break;
 	}
+
+	return open_istream_incore(st, r, oid, type);
 }
 
 /****************************************************************
@@ -478,19 +477,14 @@ struct odb_read_stream *open_istream(struct repository *r,
 {
 	struct odb_read_stream *st = xmalloc(sizeof(*st));
 	const struct object_id *real = lookup_replace_object(r, oid);
-	int ret = istream_source(st, r, real, type);
+	int ret;
 
+	ret = istream_source(st, r, real, type);
 	if (ret) {
 		free(st);
 		return NULL;
 	}
 
-	if (st->open(st, r, real, type)) {
-		if (open_istream_incore(st, r, real, type)) {
-			free(st);
-			return NULL;
-		}
-	}
 	if (filter) {
 		/* Add "&& !is_null_stream_filter(filter)" for performance */
 		struct odb_read_stream *nst = attach_stream_filter(st, filter);

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

