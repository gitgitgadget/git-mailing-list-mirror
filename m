Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5CA1EF37D
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592394; cv=none; b=pCZ+F+JlDyYMjB0A5igONCvGG9a7iw3WdQRdlf+A+Ar4Bt7Y4/t4xOzz3xmrH8iLbKARow2bpjWw06a2jsOOxfp9dwf9jKlPhOUaqOD+hxMuevS+9TswImyU/aqqdncAFj7f1orKKVabcb/6FfNGvzkS/DT+9hW1V0xovm7dveA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592394; c=relaxed/simple;
	bh=ONJSvoMHBQkWPcwYdEFwZvrx6QHInQGjToHgsBfvrwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tF69uRAJ1lI4Ld7DgQ6pcN+YqoZmk6VbsiUPlNK9l/KKlTAH8d0rFvSmKQnoa0mvfiBO3gZ4rMowJKnlp1dyL4zfjpwD0+L1sBO6LNZFgvxpT6e8iG5baYecyTmb15eQYxOCGMufMHje/5ynd3tZPwjc4S4I/Xl5sQO6WrNLBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jnheZKXB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m2qwB3IO; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jnheZKXB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m2qwB3IO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4214D1140200;
	Wed,  2 Apr 2025 07:13:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 02 Apr 2025 07:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743592391; x=1743678791; bh=cfQL5tOoHf
	0AB3meektb7zU/HwlwT9x7AeqbYHRrGS8=; b=jnheZKXBHj45QO6TxoBkXj/oJy
	RjXBy5G4rF8PzlUH3tPVioEXI5Cc1yqF4QpdNv0SEaONc6s1azT1DxNDQn/+OUTD
	9+MG+XZdFsoIZy6k9bdvV806GeKAaD/4p0ZGs4sgeLY94NIGlyYF7L00bruhCc4c
	3AwhYyjpfn6EqmewByJq/EG/g3tQ2xLeDDjXTOnuKmpdH3fWrE0XDkedsj1tuoCf
	//LRH5FkZFsFQwKdZsTpebWzX5NocrX8Q93UUMxEZOlNg9AdH9oYI5ii/gV2V/Gh
	0rXD1voOueuwX2m0DnDvd+35ipKcD/Wn109vch0JiejN2Xojm74t3ypXBe/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743592391; x=1743678791; bh=cfQL5tOoHf0AB3meektb7zU/HwlwT9x7Aeq
	bYHRrGS8=; b=m2qwB3IOGbRc7Qm4WMognfHj7AevrY1/SSo80eeI0PrH74W5iV2
	DK7HkBLcXmr2Q/tDB6nN8v74p8JPx1ZlFqjdwgegEzrcJpwoOKcV+Kl5ww3rz/B8
	lCfIEfYgIqWJER2r8H49niqQOjZucWNGqyBQCgymod7YP9OFAJ5CU1I/ZuIi2XEL
	sLPVoK5+v2PbdPiyBP4tsHgRKZyOn82wAbDm5A8rSbiGdpQVnA1hhvnSUyZ31SXI
	q+iK6Q4oqHYkSD8tprz2uwI8GUgTegMjgLwB+H3Vvfpme6jrRg+VWUb8H4/2OI9V
	13ns5nZ3cI3rP0cTnznuR47khxz2vRQvIpg==
X-ME-Sender: <xms:xhvtZ1uD3ll0zvwTVu2Vaa3ebIfbG2qJoeXez7hf-GWknBRHn1bceQ>
    <xme:xhvtZ-fLm3dXyYjonQ8Vygz8hwbfWy1Ks6D1AYUKUUJubqu0DmjCiYoKUdNlQs3LF
    xm1p8QImDc3AbekGw>
X-ME-Received: <xmr:xhvtZ4yz2yiulfrE5qL8DixVfc49ygyqlnktZuUbsptWgMXcKBUtxb3HU6KJbAt-8yTL6WQZOaiQaC0xWADNVDoa5NLgleBAzy4RzpRBtlHaUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:xhvtZ8OmzvrYN8lXRpeuUChQ47L1o4CcUHS-t8tcwcKx9RJws1HVcw>
    <xmx:xhvtZ1_314X4lW3umydF1dXvzRUC52h3bt_UkOzNOoKw4LZDr_ynuQ>
    <xmx:xhvtZ8VJrvP9tufMrEcLxpXf60kmspHDvxA0oFD-AeQiTaeUinMOuQ>
    <xmx:xhvtZ2f4taEKJUnyKO-ks4f1AWhdnQQe129ifvMSFVMz73Xrp0T0SQ>
    <xmx:xxvtZ8f5AFmV0-UtTtzZ8ffVPCg8qoHhZadeJ-2wHaL6pEIJ6Wh4XVuT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9b71aefe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:09 +0000 (UTC)
Date: Wed, 2 Apr 2025 13:13:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/10] pack-bitmap: allow passing payloads to
 `show_reachable_fn()`
Message-ID: <Z-0bxM6AjLDAjDx2@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
 <20250327-pks-cat-file-object-type-filter-v2-6-4bbc7085d7c5@pks.im>
 <87h638f54w.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h638f54w.fsf@iotcl.com>

On Tue, Apr 01, 2025 at 02:17:03PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > index 6f7fd94c36f..d192fb87da9 100644
> > --- a/pack-bitmap.c
> > +++ b/pack-bitmap.c
> > @@ -1663,7 +1663,8 @@ static void init_type_iterator(struct ewah_or_iterator *it,
> >  static void show_objects_for_type(
> >  	struct bitmap_index *bitmap_git,
> >  	enum object_type object_type,
> > -	show_reachable_fn show_reach)
> > +	show_reachable_fn show_reach,
> 
> What would you think about adding the `_fn` to `show_reach`? Because the
> function is passed on to `show_objects_for_type()`, I think it improves
> the readability if it's called `show_reach_fn` or somethin?g

We don't have that suffix anywhere else where `show_reachable_fn` is
accepted. So for the sake of consistency I'd rather leave it this way.

Patrick
