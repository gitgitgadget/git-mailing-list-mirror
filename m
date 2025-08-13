Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC122D238D
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066349; cv=none; b=hDkMuStaysw9LWb8eTSC5fqRFLn+Ku7AJatb8Jr2mmgnOVzzmtwrMUXbVL3o8ChRc+GCatGPcuuxkyeb5NL5+gLlwfjk5cFnr0Vsbn6yda24hpc/tfoo5J6i/je8H22r8YVmIwLtDpVqaurINzF9AtSiVZEJ2FvdnYAMom/DuUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066349; c=relaxed/simple;
	bh=CKVbs2tuSAbqlbF6bK4XzcgS1i8p+beoAthWka+my2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rB1o/jOtgQ72UzM1JxBJA0PnBJ88UpXVQXksXf3OpwuBV12zctbLJFcpGT7RTkwlBkclIvDg/M2yxu6qtJwBycWnDN8cIM2dm2GMjniFG9xpxSaJhBdGIxW/INs7aV4j2fk/3eIpsP2wXKiEAAJcc8+AumdOCVkuYxdSkLXFRHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QT+SMQGS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bvXAFoN/; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QT+SMQGS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bvXAFoN/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DA8ED1D00111;
	Wed, 13 Aug 2025 02:25:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 13 Aug 2025 02:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755066346;
	 x=1755152746; bh=Esf029FqXimTL39KlZTaFQmkSp7wwlTOks2PCTUZpWA=; b=
	QT+SMQGSqnLMw1IAlbr561/QfNasR6JZiPEv5OxUl578aEQIG9YI0Nliq/LaFWL2
	sZrZzoPAuoYJFEE4FJHH7Mf+LoAQaamEqjseiILlD92fW29Jd65058WhOfXFj7Fq
	wRIKqzZOg6/vVDf3ciam0p9+w1xavH/aNsQOO6I+ZUAQXZjBA7MM+DHNBm7Pt93c
	l22OTvFhPdndwlhrN4rYR9Kux6wYMnRWcRlqdmtodEFoxHyvHZZVUwJMsolOKfLz
	Ubu1RZCFWOTCaRw2x9CaUWItp7d01D7axCNTCC8rOUxXAO0K2oQLc/b+PfWZsli3
	9MofgJKNd59xqb87eaA+sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755066346; x=
	1755152746; bh=Esf029FqXimTL39KlZTaFQmkSp7wwlTOks2PCTUZpWA=; b=b
	vXAFoN/VtFwo1roBSo53WATNMDt0bB4rRF9nvezl65/buGQE+d5P3uII4tlPEEkb
	y19aVWVajjxV8wMwRZHJdLQzrsUcC7H9aFQlFOQfxBw7MudMip+qYGsfXP2RR9Us
	mj25nwtuPYLdJhgXqbx4mWyVjsAz7jxyd+vuag53vYxXpIBCsTv6X0LhK0bdkjCp
	nB3Ay7+aj5WGQafQHiMGTVKfNDgUNWy7PaRI/xpR/qcRQrwWIHqh5ZcqxXJ4q3bW
	cV4/fQ+ezV+2bnBy+sPBTBBEmy/Tc1x8i/YgL99PvtC305sJ4+OLQ6xAyEOf/ges
	526qudEcHkkgMArFZCvsQ==
X-ME-Sender: <xms:6i-caDHkY8-jQj8tY1OfeO1JCrYS9YaU8gaDOk-2VXO0hb8TEymoAQ>
    <xme:6i-caL3ByorrYMLii1EJmV6SQU8URlvhDrZ1h5cd9WN_9pKpwa0R4OO396OwemrNB
    bPDDCIt8dMlRuFuNA>
X-ME-Received: <xmr:6i-caLl1QUgrU6J_e-LHlNzL5upY8svFrupXHb7VUNY88Ge4slY2Do2kU_r0b6xRcBgrGWEV99Ab2A84jv-BkmNpEJo5LXUjlbRq4m7p9XE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtieffuddtudduvddvveehuefffefgkefftdffleffhfffvddtjeffueejudetffen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6i-caL8SRb1cerlYVIIVEsIadb2gHuxzdMKZgZepzI989MHZ7X_Ndw>
    <xmx:6i-caArvUJMTTthz5qedQQsmLhbxXF9GAEzPTwG_CC0hzaD32_p-6w>
    <xmx:6i-caEkLqs8oe5X-7L9F-H3XJv1e1u9IS4Jn-i1L5wYaNgEwecTQEQ>
    <xmx:6i-caHilR95mkZM9dqH49Shcx245SPpsjXVh1Gh3uFj1N7TPS1s85Q>
    <xmx:6i-caKTpB4AJ1k4db-NUbLWjIzE-GAfPJ1VyZioX4m4KgtDtjRRF_fjD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 02:25:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3817bb2c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 13 Aug 2025 06:25:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 13 Aug 2025 08:25:28 +0200
Subject: [PATCH v4 4/8] reftable/stack: fix compiler warning due to missing
 braces
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-pks-reftable-fixes-for-libgit2-v4-4-42b5544c8e2a@pks.im>
References: <20250813-pks-reftable-fixes-for-libgit2-v4-0-42b5544c8e2a@pks.im>
In-Reply-To: <20250813-pks-reftable-fixes-for-libgit2-v4-0-42b5544c8e2a@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Carlo Arenas <carenas@gmail.com>
X-Mailer: b4 0.14.2

While perfectly legal, older compiler toolchains complain when
zero-initializing structs that contain nested structs with `{0}`:

    /home/libgit2/source/deps/reftable/stack.c:862:35: error: suggest braces around initialization of subobject [-Werror,-Wmissing-braces]
            struct reftable_addition empty = REFTABLE_ADDITION_INIT;
                                             ^~~~~~~~~~~~~~~~~~~~~~
    /home/libgit2/source/deps/reftable/stack.c:707:33: note: expanded from macro 'REFTABLE_ADDITION_INIT'
    #define REFTABLE_ADDITION_INIT {0}
                                    ^

We had the discussion around whether or not we want to handle such bogus
compiler errors in the past already [1]. Back then we basically decided
that we do not care about such old-and-buggy compilers, so while we
could fix the issue by using `{{0}}` instead this is not the preferred
way to handle this in the Git codebase.

We have an easier fix though: we can just drop the macro altogether and
handle initialization of the struct in `reftable_stack_addition_init()`.
Callers are expected to call this function already, so this change even
simplifies the calling convention.

[1]: https://lore.kernel.org/git/20220710081135.74964-1-sunshine@sunshineco.com/T/

Suggested-by: Carlo Arenas <carenas@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index ed80710572..9db90cf4ed 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -664,8 +664,6 @@ struct reftable_addition {
 	uint64_t next_update_index;
 };
 
-#define REFTABLE_ADDITION_INIT {0}
-
 static void reftable_addition_close(struct reftable_addition *add)
 {
 	struct reftable_buf nm = REFTABLE_BUF_INIT;
@@ -693,6 +691,7 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 	struct reftable_buf lock_file_name = REFTABLE_BUF_INIT;
 	int err;
 
+	memset(add, 0, sizeof(*add));
 	add->stack = st;
 
 	err = flock_acquire(&add->tables_list_lock, st->list_file,
@@ -739,8 +738,10 @@ static int stack_try_add(struct reftable_stack *st,
 					    void *arg),
 			 void *arg)
 {
-	struct reftable_addition add = REFTABLE_ADDITION_INIT;
-	int err = reftable_stack_init_addition(&add, st, 0);
+	struct reftable_addition add;
+	int err;
+
+	err = reftable_stack_init_addition(&add, st, 0);
 	if (err < 0)
 		goto done;
 
@@ -866,19 +867,18 @@ int reftable_stack_new_addition(struct reftable_addition **dest,
 				struct reftable_stack *st,
 				unsigned int flags)
 {
-	int err = 0;
-	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
+	int err;
 
 	REFTABLE_CALLOC_ARRAY(*dest, 1);
 	if (!*dest)
 		return REFTABLE_OUT_OF_MEMORY_ERROR;
 
-	**dest = empty;
 	err = reftable_stack_init_addition(*dest, st, flags);
 	if (err) {
 		reftable_free(*dest);
 		*dest = NULL;
 	}
+
 	return err;
 }
 

-- 
2.51.0.rc1.215.g0f929dcec7.dirty

