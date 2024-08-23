Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A6193079
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422369; cv=none; b=pGoD96q3MMTpOfXdzurr6kbPDbX5J7ZSDiQ5rQsUpaEy0yUgK3fTJ9V+aHGmkGffZxb4CQJzrcvwiO4WbdxeyHn7OHvAgyvXQsrQSWxJm0GJp1bPIZuWKVwM4YqhVLFwwjlZOCpM+bxezSj5YNLj8LvvfM8+NivpsOtBaJwKNhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422369; c=relaxed/simple;
	bh=ZgSunjuh6ggOd8p/VvvntkSSOQweJDtzHpRiLnx5aZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4FYtFj3L2RbPDrbdUu2nAazWk+JRgQez84y/cycPfZKf3xbgOVKIk5Ijp0mwl7y2+LEl75oiIp7mNSBQYQVLrweD0BVmuG4C221E5YYLxFU4pSNmEE25edCXINmKy954Z0uN12AGe8Oj07AushNxeceYPwEIbswB4lF5OA7S1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SZW+Zsie; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RUkJX99E; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SZW+Zsie";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RUkJX99E"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 92874138FFCD;
	Fri, 23 Aug 2024 10:12:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 23 Aug 2024 10:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724422366; x=1724508766; bh=Q+FierekXH
	iyCpu0QO+M9TUVyqp6BxOqI9P3ZH60sAk=; b=SZW+ZsiehrYM5EnrgRfF/FiQo3
	wW00AJIfdzgpu9E9r94SmAdwsazROYw4MRta/MZ71+DrJU2cqoFNbtPverkgJpDV
	HcP0hc5EfS8846hIE+7ckYpNpXt3PB5E+IOlMvkTKiUM6lMa3s6+XUEPo01e5ojd
	w8lNNXbZVyNHk+6kxL8enWjTpocOMzfODc8moUk+496Qpha68sWHCUC+ke5RlXzI
	7pT5SCYo+fLGfnEfwPIMjWzaHRyhw3JjP/7YpewVScNDyvY9aVdZHvD/tSwV8gGM
	JsXVirs+Yp/DBxAUFyhJhYydwZyPSjcMxnnfDe2KiFf84/pRrkIBIH83bHmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724422366; x=1724508766; bh=Q+FierekXHiyCpu0QO+M9TUVyqp6
	BxOqI9P3ZH60sAk=; b=RUkJX99Evi2Hhe4ZfHx7QrN5q1/ZwFnVDqSMXA5dSSjN
	UCTXtXQax2O8kn1jBKUxydTkjDmm0WN6ttmVbotkZf1GOqQLvUylaIm1FLQvnBUh
	BJshUTluCbQBPDzY5ZZWGyVYEBwq15yEfCCpgUy+vmRJuaPCOJR1N7mCip0z6yVo
	JrmGpJgRXsRh7AP9/se30ESjjicIu0HmX8uVa8Xqb/vIPj4AskNaF+43egrAiWvf
	dXOspNbEcVQ/o5Kga4dANOiKfFEo07Bf9Ec2kUYAUh4rljbTG7KhcW7/lAchpvzS
	n5R6Ja8XbTJfmp+xhJPgNvhsjrQucV6x/dcNE6ryLA==
X-ME-Sender: <xms:3pjIZkaSY83hLHdVxG2-G7tofQ-K9X4jC1M8005p2Sx_9y21ogSVtg>
    <xme:3pjIZvZHTr2eIm11VnOAQOTEZ1QCAnV5K40O2Ugo4-oJ0zN5g4ri-PbNzt8fxGD08
    DCleX-gnmipLfz6Ew>
X-ME-Received: <xmr:3pjIZu__I5E3tsqhZ_mfQ_PUuqQiVSPSLVxv4I2TfBo668jUHapph2lWRuR0HJTDFYG8OEf5lzrPY9Oyen8W5YnlQpxJe05TF_P1tOK34sVAPpXyYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvvddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:3pjIZuoefJtqL4yQjcsKabZI6twap2GXwCGPWsr41ZJF1t_pKRvWMg>
    <xmx:3pjIZvopm1-GYig-8dzwHQtuaN_vpENk0cS8-uwj0jHKDl7-kR0XLg>
    <xmx:3pjIZsQXJhyNyKTcLDJgCAYyPfJhwBOIQcLGe13iqrDIIrA52JWCPQ>
    <xmx:3pjIZvrH34gnSwO3sCck1xviaaSlnGl339qqREd389NyfELzo89D2w>
    <xmx:3pjIZgmcICQ9B-KQKPXvPA9wzgYc_hAwqw4idkyMPcQfHM2rMoCb3p65>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 10:12:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 892fe8b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Aug 2024 14:12:07 +0000 (UTC)
Date: Fri, 23 Aug 2024 16:12:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/10] reftable/reader: inline `reader_close()`
Message-ID: <b129d8a8687975a813f3b165b82ce4599b6e3901.1724420744.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im>
 <cover.1724420744.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724420744.git.ps@pks.im>

Same as with the preceding commit, we also provide a `reader_close()`
function that allows the caller to close a reader without freeing it.
This is unnecessary now that all users will have an allocated version of
the reader.

Inline it into `reftable_reader_free()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 9 ++-------
 reftable/reader.h | 1 -
 reftable/stack.c  | 5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 9239679ad95..037417fcf63 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -579,12 +579,6 @@ void reftable_reader_init_log_iterator(struct reftable_reader *r,
 	reader_init_iter(r, it, BLOCK_TYPE_LOG);
 }
 
-void reader_close(struct reftable_reader *r)
-{
-	block_source_close(&r->source);
-	FREE_AND_NULL(r->name);
-}
-
 int reftable_reader_new(struct reftable_reader **out,
 			struct reftable_block_source *source, char const *name)
 {
@@ -655,7 +649,8 @@ void reftable_reader_free(struct reftable_reader *r)
 {
 	if (!r)
 		return;
-	reader_close(r);
+	block_source_close(&r->source);
+	FREE_AND_NULL(r->name);
 	reftable_free(r);
 }
 
diff --git a/reftable/reader.h b/reftable/reader.h
index 762cd6de667..88b4f3b4212 100644
--- a/reftable/reader.h
+++ b/reftable/reader.h
@@ -52,7 +52,6 @@ struct reftable_reader {
 	struct reftable_reader_offsets log_offsets;
 };
 
-void reader_close(struct reftable_reader *r);
 const char *reader_name(struct reftable_reader *r);
 
 void reader_init_iter(struct reftable_reader *r,
diff --git a/reftable/stack.c b/reftable/stack.c
index c72435b0596..0ac9cdf8de1 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -290,7 +290,6 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 			const char *name = reader_name(cur[i]);
 			stack_filename(&table_path, st, name);
 
-			reader_close(cur[i]);
 			reftable_reader_free(cur[i]);
 
 			/* On Windows, can only unlink after closing. */
@@ -299,10 +298,8 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	}
 
 done:
-	for (i = 0; i < new_readers_len; i++) {
-		reader_close(new_readers[i]);
+	for (i = 0; i < new_readers_len; i++)
 		reftable_reader_free(new_readers[i]);
-	}
 	reftable_free(new_readers);
 	reftable_free(cur);
 	strbuf_release(&table_path);
-- 
2.46.0.164.g477ce5ccd6.dirty

