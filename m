Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2B13FEE
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159567; cv=none; b=sx+KdhXfxqJhdP9o1kbm81/nSEQiKpRs1NilrosHRZ69kVAAvlSOXtgGHekIVjvVQ4P25YZ2pEkYDPxzzZYbUw2nP4wwRp1aZrwI2pJdWQr5fqw/27jpzppeiwH7wXuH7+Mf3s3nP1lHeSp+iU+c8IdwZ0vPmUX+THy7l6eI/5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159567; c=relaxed/simple;
	bh=3LKaxcf6WxuY9i4s9f+9/WoKLCS+T80gtVqvBJ14Y4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWb15niIACtUhdnSFn0k07X7DB7mvvuVElx9HvcoOGc4l9n98rrYWkuu+Gq75N1eQ3No8aWOxwIU8zPYMos7OlQoBo1uSUKk44S6WzJvwy747xpf1qY3z6HVjAC95E2QNsQ2z04LD1tiGZJ6xaVEp9A9PRVFtDaF1zanJTQcIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rMtDkwM+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SagQIaaz; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rMtDkwM+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SagQIaaz"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 479CC1140311;
	Tue, 24 Sep 2024 02:32:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 24 Sep 2024 02:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159565; x=1727245965; bh=mL3oWyEnHv
	HEiP7dArYME5lY7IOUJiRU/6ClTWyk10U=; b=rMtDkwM+iNY4BuwYPf/96Ve2En
	8lkBNBzlHiUJ2pR2L+AKljMJ2N5XmtM+JzPmz4EL/UatlgROo/7OMH2+q3WWpqUb
	sjSLk8kfoUI+NNYcJ2lXlS6f5CkMCaHhMzDJQzWp80KCL7TKDw1WRb29rxEAVMF0
	9v2Tv0xi5iwbIkiyWFX9ZtSeN1eBPma6pu5B3YybO85tAIZ/GFwZ8ik6HeSltDLo
	7o8qn3VX1iQptUp5HugttpgjFQJHSh9qQ+OU5iZwW0Ubnw+QcLZ+jEOCf7xoffJx
	EaORQ+wIXZHshUYbIqxsxmPzV3orFGP2k3K2R9U3ejZj5/BQDdNUtGDE35zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159565; x=1727245965; bh=mL3oWyEnHvHEiP7dArYME5lY7IOU
	JiRU/6ClTWyk10U=; b=SagQIaazLJyzozZsHazjCFHbHQq+yqoBmYNai3fTqF7I
	aZdpYD9ErGV0NnTiw4ClaZ4zZEguskbeyUDN6wvmKSOaqFV1dfq0XxbYqygT7gdN
	iizG7/7wEjwzGSwOHGQvOJHME5uccU5ivx8jdq+VMJUJmjUc/F4kz3o3J/WoipdX
	o0tYtjwvpBkUP2k0unPnSFZqvkoIBYDkixokN58udoZ3INqNraWJkPsdSHUENmUS
	pZ7cd3wCG+lpJZIK99y4J2aRjeobAGMt7dZzax1PqKSW/layLpzdSXleCaLon6Hx
	WlZKaHrZ/zmebkKHqSi/aVBscPJSqM570I8ySxNhlA==
X-ME-Sender: <xms:DV3yZn18Yh4mnocb6DcZ0BOrSdfz8DB_atgrDDak91D6QzZJanLVwg>
    <xme:DV3yZmFr-dzYarzl18g03GYHT1csSE-NABPT6vE3lggggZVBFkOFQoOGsZxsmv8JV
    eCP2FL0oef7BettXA>
X-ME-Received: <xmr:DV3yZn42eD8Q6qmKeUuX8Py80h0F4VWazNjxDRUuENrM-_tRAcq9EcG2_GLmjziGn4ufMiq1BCWq4-DSj_2vw8bvVoN4RW2saxm_zAtpfebwBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DV3yZs3TL8zLdIWnBH7onkOwsypOypOh0oNT0I8-vtzFrQ8_LvYKrg>
    <xmx:DV3yZqEg5ysICcXB3-X-3AZJg8ZhVfZjBSj-H0gqw1Y0OmJHdmsvIQ>
    <xmx:DV3yZt8mDIxxm-zNG-49MYcePYHVnnooy_dFZhMjJfDe_VqZH_Rb5g>
    <xmx:DV3yZnl4SjZjDsiHkVWySK_zT0oHiMPzQDPxuB39qhG9M0fRtoTmJA>
    <xmx:DV3yZmDpmJ7MpSnTubtSzNYnPuQjtMEdOm5fgHYKYDq76U7FY7IuRNMQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:32:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d4b28318 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:32:11 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:32:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 15/22] reftable/stack: handle allocation failures in
 `stack_compact_range()`
Message-ID: <244e8667c5db13b4034af747326ce2822a0f9f72.1727158127.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727158127.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727158127.git.ps@pks.im>

Handle allocation failures in `stack_compact_range()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 1b77c9d0146..2e6dd513d72 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1131,6 +1131,11 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * from the point of view of the newer process.
 	 */
 	REFTABLE_CALLOC_ARRAY(table_locks, last - first + 1);
+	if (!table_locks) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
+
 	for (i = last + 1; i > first; i--) {
 		stack_filename(&table_name, st, reader_name(st->readers[i - 1]));
 
@@ -1312,8 +1317,18 @@ static int stack_compact_range(struct reftable_stack *st,
 		 * thus have to allocate `readers_len + 1` many entries.
 		 */
 		REFTABLE_CALLOC_ARRAY(names, st->merged->readers_len + 1);
-		for (size_t i = 0; i < st->merged->readers_len; i++)
-			names[i] = xstrdup(st->readers[i]->name);
+		if (!names) {
+			err = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto done;
+		}
+
+		for (size_t i = 0; i < st->merged->readers_len; i++) {
+			names[i] = reftable_strdup(st->readers[i]->name);
+			if (!names[i]) {
+				err = REFTABLE_OUT_OF_MEMORY_ERROR;
+				goto done;
+			}
+		}
 		first_to_replace = first;
 		last_to_replace = last;
 	}
-- 
2.46.0.551.gc5ee8f2d1c.dirty

