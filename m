Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A159617624F
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 06:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948562; cv=none; b=gndpgWpOp3oFa9f/sAASAP9E66ZEP/XxTcAzFPvJw+H/7nfEiaFWKC732UGuRUPvqRGFSRs21FLrgjBqi93pdP8NbZje+W6hIW/+bjGXO+KoajZGjE2EvSydclybp1eiAZS/MK9i4m4A0uSteJqZLPCUR4yfA7BW7Cy0SC2rWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948562; c=relaxed/simple;
	bh=4EL1NcwpZrdiIId9rOMmNEn6sZ8Zye/becPK9Pvuhrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQY2OYvL5Ux6Qis/zTxbln2S4ifV5OVNDbBWeWoTdWuNDZ9R8dWSxOpJt40bf6iegCQdNAkyuiXlFJunI8JCW6oQ/mQkTN1sK/FIwRJQP7FSs0J8RlQupyW0VD9/SIZusLwpUKeVMLEtQJdGHc5G70SwBYEI2NFH5MNll3JFNCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GePwzP5i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jptl4g1e; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GePwzP5i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jptl4g1e"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id AC53C13802C2;
	Tue, 10 Sep 2024 02:09:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 10 Sep 2024 02:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725948559; x=1726034959; bh=puu4yU1ZIE
	iknkAUZPqkLQDiDsHg8PsoncmZjemv3bk=; b=GePwzP5i6VaigkbRa7ZhSuwQfC
	qqTLsqIFKEkaKnl6D1sjGt6IUdMw9gMA7dwbxEN2aSgxat74wqEog8ZABERiZ2Zk
	ekO/QTZ4uBn9emF1Lldw6knskTZWjCXeTxtCSTiom3pA1BuN9AqYoItkD+bsPAj3
	ZKvKKRQ2O0ZfERAviLS1DRqRg+NhMgMek9Kf4wK8gZI59P4xhgxiPlvSaVLIOlII
	+mmOTNDGNveErh9j2n5rRa0+tpRd5FoPIc3guLdiqgiX8igC0vpAQ+y+sS77amQf
	sXm8GfYIvlzt1Z6o9fe+RNvrw7i9YwB055FlbE/DsRumhoULguUQ0jCe2NjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725948559; x=1726034959; bh=puu4yU1ZIEiknkAUZPqkLQDiDsHg
	8PsoncmZjemv3bk=; b=jptl4g1eH6/7Qq72MrCLLKwL7KdTPL7eUgUJIoE494jl
	qCxqXNsW7FYxa72uEJicfiywNXv3IP/2YIk8LQr5ZEtngK+WE+iMiFUcO6tcWJzt
	4902QhjiXmsakzdVO/kb6w5yziDQPSVjhcHFWj4J4OgUitfTS6mBVrdOcLYeyRyt
	9TXGboYRdnTiyLi3nQV1ugL6IgxHvirUsjH0lWuUEaL8LDe5pU+WKFS5Hl1TDENU
	gs2nGi526uh00TD1GZN65h7Q/zz/sVCfPxtALv5e3wERL/tGNRs8ZynTci2yBH3b
	4FAiXHPKBkUjipDiFYDeqwcxDKtZB8GJa6C7n9BAnw==
X-ME-Sender: <xms:j-LfZl75DM75aRz5I7RUZxx2RldLQ85yOJE6WBJBekQYbntE1arNXA>
    <xme:j-LfZi69LhLEOtKVJZw0o1RaPZUOIlywJN0C0Hsf4_YD-18d02F_GYXxeguZf6_jc
    Rq5lU9gFB53w-jdUQ>
X-ME-Received: <xmr:j-LfZsc4pv235FQbLBAnJIugpgfq_tskcxU9uVfLPnGyR6IYbmnSr8RW536MonZ3WKyTB55vwaVzcWhhG4a2fw-7h3ECc8E8aEx7oqhEIHhBYGI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsghrohhokhgvsegrlhgthhgvmhhishhtshdrihhopd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:j-LfZuJiIIXbwadyaxsmUJ7hnswEh9LxY7_7R12y6MjEgHLBXfho9A>
    <xmx:j-LfZpLqPCg20QAvCIlJFYUFUGhYNbOwnJ1LJS5L8o0ZsSJE4xW1vw>
    <xmx:j-LfZnyoLTimaKq32V4Bbbm76CizT94g2Ro8dFdCGaNgtY3anWT4bw>
    <xmx:j-LfZlK2vT2zgBFNNvQJ3DGCAa_gEyzWo0TQB0EhJ0Dv3UYsFSxpmw>
    <xmx:j-LfZp0hHN15Vup7IvioE8V1vZEAjwniIbTqmxxcUlb0wScC66ix_8ps>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 02:09:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 750832a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Sep 2024 06:09:14 +0000 (UTC)
Date: Tue, 10 Sep 2024 08:09:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Brooke Kuhlmann <brooke@alchemists.io>
Subject: Re: [PATCH 9/9] ref-filter: add ref_format_clear() function
Message-ID: <Zt_ijEqdsylYYkNn@pks.im>
References: <20240909230758.GA921697@coredump.intra.peff.net>
 <20240909232118.GI921834@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909232118.GI921834@coredump.intra.peff.net>

On Mon, Sep 09, 2024 at 07:21:18PM -0400, Jeff King wrote:
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index e8db612f95..b3163629c5 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -5,6 +5,7 @@
>  
>  test_description='for-each-ref test'
>  
> +TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  GNUPGHOME_NOT_USED=$GNUPGHOME
>  . "$TEST_DIRECTORY"/lib-gpg.sh

Nice! There's also t6302, which has been failing due to all the memory
leaks in our atom handling, as well. After your series there's a single
memory leak left to make it pass. So we may want to add below patch on
top as a low-hanging fruit.

Patrick

-- >8 --

diff --git a/ref-filter.c b/ref-filter.c
index ce1bcfad857..b06e18a569a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1001,6 +1001,7 @@ struct ref_formatting_stack {
 	struct ref_formatting_stack *prev;
 	struct strbuf output;
 	void (*at_end)(struct ref_formatting_stack **stack);
+	void (*at_end_data_free)(void *data);
 	void *at_end_data;
 };
 
@@ -1169,6 +1170,8 @@ static void pop_stack_element(struct ref_formatting_stack **stack)
 	if (prev)
 		strbuf_addbuf(&prev->output, &current->output);
 	strbuf_release(&current->output);
+	if (current->at_end_data_free)
+		current->at_end_data_free(current->at_end_data);
 	free(current);
 	*stack = prev;
 }
@@ -1228,15 +1231,13 @@ static void if_then_else_handler(struct ref_formatting_stack **stack)
 	}
 
 	*stack = cur;
-	free(if_then_else);
 }
 
 static int if_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state,
 			   struct strbuf *err UNUSED)
 {
 	struct ref_formatting_stack *new_stack;
-	struct if_then_else *if_then_else = xcalloc(1,
-						    sizeof(struct if_then_else));
+	struct if_then_else *if_then_else = xcalloc(1, sizeof(*if_then_else));
 
 	if_then_else->str = atomv->atom->u.if_then_else.str;
 	if_then_else->cmp_status = atomv->atom->u.if_then_else.cmp_status;
@@ -1245,6 +1246,7 @@ static int if_atom_handler(struct atom_value *atomv, struct ref_formatting_state
 	new_stack = state->stack;
 	new_stack->at_end = if_then_else_handler;
 	new_stack->at_end_data = if_then_else;
+	new_stack->at_end_data_free = free;
 	return 0;
 }
 
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 163c378cfd1..7f44d3c3f22 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -2,6 +2,7 @@
 
 test_description='test for-each-refs usage of ref-filter APIs'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
