Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77202F43
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734852293; cv=none; b=MlJDz8QypImr3QjT3pK8uVjSoD1inmdALcf2BLsMchlrtf+pvTIlcQ+EK+fx+c3MGthLxP+a8lTK3bs2LkjXmuOfAHDwXCRGu0ercTB+f2LqedbziiohY8xB0vUrZzuiX6MnDiW/ZOwB6fGzrSKLNNN6/g6z5cQ1BbDtlwMBuSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734852293; c=relaxed/simple;
	bh=LZwzhkCdK0zCOqgJW5CmuY+JrfBaxzcujYhCwHq4SYM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=u1Uxct8fRrc504OebnQzLQ4vk4kuZXar5LkFa+PdzrjdS6qFD8MQ7tvL+VEMtJ4hw3WVVoX+wxO2+QlwDVpuHhGNcndsZGyqMmB9uerLr+j5ugwRUjq0hWbcs3D43029VYG9Co1QBOMR+3oK7sIaPPZ4IbxyV0ZyGgTclioHaf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QjNv7UrQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UcRO7RiA; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QjNv7UrQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UcRO7RiA"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BB7A3114017C;
	Sun, 22 Dec 2024 02:24:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 22 Dec 2024 02:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734852289;
	 x=1734938689; bh=d9YzzNZSi437DWGZeUGNMMMckSbZJxP4PIGHvXY3GlI=; b=
	QjNv7UrQ1QBMWsVxQORnFOx+90/gVz6zGKgM0eFj/eW5nvNHvizVjgeC2cOGUYCW
	Vb2B9QpnF05W5KOkBmreZxt1Pf0E/adeD+hj3WSazWIG4UyYfYubqXvG9kb8+MZj
	tP9qQJrxqhFQz8DMHoHzl/W3O4ohQoec3cWnnUXJ4KW2grv7oOltARKm5i/09Xoe
	YEBtD45+eH3ByLAL3+TDUEeQkmtpZx9dLDEN44GPLa8n6fli77T4hHaFOZWRQuzq
	X4pTGrxBM1wstebuNEQVU88FneDdIpU6DKWOtj0i1TVCwo7T9boCDF+LbB0uRJDq
	HtLUB/8FtqaTrSqPsjY+rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734852289; x=
	1734938689; bh=d9YzzNZSi437DWGZeUGNMMMckSbZJxP4PIGHvXY3GlI=; b=U
	cRO7RiAockm29WTmMYcxcgV57OUV6tyKAXHL7foCRzdtJmXgMdEo8pUeAteoyljI
	vHzPI4WRnrWpgar7g7eMXmrb/8vVA20bIokr6k92mkWPNQRX/+uPOEjKYfEMqXd4
	gBVh1SdMLhKoRSmcwtknnIx6UPt1Zm2A32A2QSjVf4sIPMHV4fbVFxEWMmSCqU7z
	oZBhoAvxdFzl9olrZmexkjYAn7stLTPxHPB+lku+ODYWvv0ql0LrOgNVZY7OJd6U
	Fz3R04UxhcGLl43BqgO/bcaY+yzn1cGXryQYMhztof1tCPhO+jolac5VlXSkIYR4
	CdZx/nmqhZyVusFctjwLw==
X-ME-Sender: <xms:wb5nZ_GYo3pjUsZ4BwRQbS9mnBSqVJPRoBByq2-Pm47t7Vp6452kBg>
    <xme:wb5nZ8XAMndZt1LLa2chGmVKqRr7CXY28_ohqXa7GLl3FD-zGCIIsLg77CCoQFryq
    2SBSeznAMntP3Lagw>
X-ME-Received: <xmr:wb5nZxJqydwJvsZhWBNKf4mDNfmzda6qCEhkKh10suY7s989vw9yjyMnH5kZ_qMQ1AjQxxvzZKWKAMr8UFHsKC5T0nOwwGFNF5-zJ0uNznn6IQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtjedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheef
    hfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprh
    grnhgurghllhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:wb5nZ9HBiaBi6WrcvImfLQOipiTUvMYgJZEiGXH4rdLK7XPPXS8rOg>
    <xmx:wb5nZ1UQuUVtH7YXzxoNuf-K_PYYwB4l3TPueuz3WbKBqZZOXAGgJg>
    <xmx:wb5nZ4Puujl7KTHcjaWVhylZPIeegRS4-HPhdciXz3hxPwZM6qq-Sw>
    <xmx:wb5nZ03RQnR4bt8b2bnbiq8ayR3eSjcDkbmy3spPkGtD8lWRZzg7Xg>
    <xmx:wb5nZ7xcruQUevfHxVq-QVXTBU4KlOzneqam8Jb5ZccuYLZBFcmPqu2d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 02:24:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dea038cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 22 Dec 2024 07:22:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/4] reftable: fix out-of-memory errors on NonStop
Date: Sun, 22 Dec 2024 08:24:27 +0100
Message-Id: <20241222-b4-pks-reftable-oom-fix-without-readers-v2-0-19550090d15a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKu+Z2cC/42NwQ6CMBBEf4Xs2TVtIYCe/A/DodAiG4WStlYM4
 d9dSbx7fDOZeSsE68kGOGcreJsokJsY1CGDbtDTzSIZZlBCFVIpgW2B8z2gt33U7cOicyP2tOC
 L4uCekQttrA/YVabujRblqTDAbzMvaNlN14Z5oBCdf+/iJL/pzyH/diSJAqUybZ3rXJVVd+HZk
 UZotm37AFSyvEnbAAAA
X-Change-ID: 20241220-b4-pks-reftable-oom-fix-without-readers-c7d8fda0694d
In-Reply-To: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

Hi,

this small patch series fixes out-of-memory errors on NonStop with the
reftable backend. These errors are caused by zero-sized allocations,
which return `NULL` pointers on NonStop.

Changes in v2:

  - Some small touchups to commit messages.
  - Explain why it is safe to stop auto-compacting with less than two
    tables.
  - Adapt `reftable_stack_reload_once()` so that we only do the minimum
    changes required to fix issue.
  - Link to v1: https://lore.kernel.org/r/20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (4):
      reftable/stack: don't perform auto-compaction with less than two tables
      reftable/merged: fix zero-sized allocation when there are no readers
      reftable/stack: fix zero-sized allocation when there are no readers
      reftable/basics: return NULL on zero-sized allocations

 reftable/basics.c |  7 +++++++
 reftable/merged.c | 12 +++++++-----
 reftable/stack.c  | 27 +++++++++++++++++----------
 3 files changed, 31 insertions(+), 15 deletions(-)

Range-diff versus v1:

1:  9fcd452995 ! 1:  a7c5b7c52e reftable/stack: don't perform auto-compaction with less than two tables
    @@ Commit message
         from `reftable_stack_auto_compact()` in case we have less than two
         tables.
     
    -    This is mostly defense in depth: `stack_table_sizes_for_compaction()`
    -    may try to allocate a zero-byte object when there aren't any readers,
    -    and that may lead to a `NULL` pointer on some platforms like NonStop
    -    which causes us to bail out with an out-of-memory error.
    +    In the original, `stack_table_sizes_for_compaction()` yields an array
    +    that has the same length as the number of tables. This array is then
    +    passed on to `suggest_compaction_segment()`, which returns an empty
    +    segment in case we have less than two tables. The segment is then passed
    +    to `segment_size()`, which will return `0` because both start and end of
    +    the segment are `0`. And because we only call `stack_compact_range()` in
    +    case we have a positive segment size we don't perform auto-compaction at
    +    all. Consequently, this change does not result in a user-visible change
    +    in behaviour when called with a single table.
    +
    +    But when called with no tables this protects us against a potential
    +    out-of-memory error: `stack_table_sizes_for_compaction()` would try to
    +    allocate a zero-byte object when there aren't any tables, and that may
    +    lead to a `NULL` pointer on some platforms like NonStop which causes us
    +    to bail out with an out-of-memory error.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
2:  0703e520de ! 2:  1ca81345ce reftable/merged: fix zero-sized allocation when there are no readers
    @@ Metadata
      ## Commit message ##
         reftable/merged: fix zero-sized allocation when there are no readers
     
    -    It was reported [1c that Git started to fail with an out-of-memory error
    +    It was reported [1] that Git started to fail with an out-of-memory error
         when initializing repositories with the reftable backend on NonStop
         platforms. A bisect led to 802c0646ac (reftable/merged: handle
         allocation failures in `merged_table_init_iter()`, 2024-10-02), which
    @@ Commit message
         The root cause of this seems to be that NonStop returns a `NULL` pointer
         when doing a zero-sized allocation. This would've already happened
         before the above change, but we never noticed because we did not check
    -    the result. Now that we do we notice and thus return an out-of-memory
    -    error to the caller.
    +    the result. Now we do notice and thus return an out-of-memory error to
    +    the caller.
     
         Fix the issue by skipping the allocation altogether in case there are no
         readers.
3:  67baf67817 ! 3:  9be3c6e6c1 reftable/stack: fix zero-sized allocation when there are no readers
    @@ Commit message
         situation, and thus we return an error.
     
         Fix this by only allocating arrays when they have at least one entry.
    -    Refactor the code so that we don't try to access those arrays in case
    -    they are empty.
     
         Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    @@ reftable/stack.c: static int reftable_stack_reload_once(struct reftable_stack *s
      	size_t reused_len = 0, reused_alloc = 0, names_len;
      	size_t new_readers_len = 0;
      	struct reftable_merged_table *new_merged = NULL;
    - 	struct reftable_buf table_path = REFTABLE_BUF_INIT;
    +@@ reftable/stack.c: static int reftable_stack_reload_once(struct reftable_stack *st,
      	int err = 0;
    --	size_t i;
    + 	size_t i;
      
     -	cur = stack_copy_readers(st, cur_len);
     -	if (!cur) {
    @@ reftable/stack.c: static int reftable_stack_reload_once(struct reftable_stack *s
      	}
      
      	names_len = names_length(names);
    --
    + 
     -	new_readers = reftable_calloc(names_len, sizeof(*new_readers));
     -	if (!new_readers) {
     -		err = REFTABLE_OUT_OF_MEMORY_ERROR;
    @@ reftable/stack.c: static int reftable_stack_reload_once(struct reftable_stack *s
     +		}
      	}
      
    --	while (*names) {
    -+	for (size_t i = 0; i < names_len; i++) {
    - 		struct reftable_reader *rd = NULL;
    --		const char *name = *names++;
    -+		const char *name = names[i];
    - 
    - 		/* this is linear; we assume compaction keeps the number of
    - 		   tables under control so this is not quadratic. */
    --		for (i = 0; reuse_open && i < cur_len; i++) {
    --			if (cur[i] && 0 == strcmp(cur[i]->name, name)) {
    --				rd = cur[i];
    --				cur[i] = NULL;
    -+		for (size_t j = 0; reuse_open && j < cur_len; j++) {
    -+			if (cur[j] && 0 == strcmp(cur[j]->name, name)) {
    -+				rd = cur[j];
    -+				cur[j] = NULL;
    - 
    - 				/*
    - 				 * When reloading the stack fails, we end up
    -@@ reftable/stack.c: static int reftable_stack_reload_once(struct reftable_stack *st,
    - 	 * file of such an open reader wouldn't have been possible to be
    - 	 * unlinked by the compacting process.
    - 	 */
    --	for (i = 0; i < cur_len; i++) {
    -+	for (size_t i = 0; i < cur_len; i++) {
    - 		if (cur[i]) {
    - 			const char *name = reader_name(cur[i]);
    - 
    -@@ reftable/stack.c: static int reftable_stack_reload_once(struct reftable_stack *st,
    - 	 * happen on the successful case, because on the unsuccessful one we
    - 	 * decrement their refcount via `new_readers`.
    - 	 */
    --	for (i = 0; i < reused_len; i++)
    -+	for (size_t i = 0; i < reused_len; i++)
    - 		reftable_reader_decref(reused[i]);
    - 
    - done:
    --	for (i = 0; i < new_readers_len; i++)
    -+	for (size_t i = 0; i < new_readers_len; i++)
    - 		reftable_reader_decref(new_readers[i]);
    - 	reftable_free(new_readers);
    - 	reftable_free(reused);
    + 	while (*names) {
4:  16ae8201b1 = 4:  8028e2cf68 reftable/basics: return NULL on zero-sized allocations

---
base-commit: ff795a5c5ed2e2d07c688c217a615d89e3f5733b
change-id: 20241220-b4-pks-reftable-oom-fix-without-readers-c7d8fda0694d

