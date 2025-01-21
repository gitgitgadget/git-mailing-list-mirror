Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DA61A83F4
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737442596; cv=none; b=AQnM95xWpiiOSk7lI/x0U0bllQCWWw/bZW2dfxrmQVnZLcIbwdr+CcrFhsIqWuMWgx/N2YUj7iWvCy/6DQZWUEnV4JFI3gOLv8XWIJk+9zB9k7rXeSioVdMbjTiZrs8pFtlU7DE0DIq6RxnssNVM8e+hCH2jja2tSNq0E2Fl3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737442596; c=relaxed/simple;
	bh=wOHvhWezJHjyrMsidQLFsrQSDByQlUPdSohRzsbR+aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhTYWEa5cGdElTpBlezCpniYhkyPEgcQ0/4MZPUDXycr0Hp04wuRRfEbyXtIu1g01qfffRgDWrH8J/F1U8897mJAmoZyd2D0vatA9w8DDbA83aLi2lf++WS9ZbsnZFrRm7oOGL4E+mi+PDz4x9mkSzasImZ12pew0iEsYZhDgrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S06zRpmz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T30Cy0yM; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S06zRpmz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T30Cy0yM"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 354EC25401BF;
	Tue, 21 Jan 2025 01:56:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 21 Jan 2025 01:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737442593; x=1737528993; bh=v7CE1uIVGs
	OspYTPrCMOe45y+ArJXnk6EHNUOzbBVWo=; b=S06zRpmzf4OXQo4bWmJnf2EVM+
	sWta8Q7m7cOPLZGQ+eRZz2cSKcnMzFaYCVCpk/Hn9IqmQopOo5soz4fBtiGKobbx
	hDTiGyvQ4OciBce9cyFoinUcVPz1f78an8c6tLLtkVzWDCfih9vou+phczcEX9W+
	3IWJShi2SO8qfF16OAvN8qYmmAyrwWqZc9m8IQwa/BpohTKfjLccooITNrvR/RBM
	0P50QuU1LGjRmg2QCoa6qwBe+eqWrW4FPbrfT27Pi7cOC5qsJILU0WyaICOq2eRp
	8HauP3aY5iKEE5cXpwFoQlXjvmwtN9lpaIDvsLnYp73YmIH2xmcLp+gxx8xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737442593; x=1737528993; bh=v7CE1uIVGsOspYTPrCMOe45y+ArJXnk6EHN
	UOzbBVWo=; b=T30Cy0yMEZ5jjdF/IFtL4l2baR0eH4OgatjOb+dQmFBvrdvsWi2
	vrvcyWdC2gD+hkJOcw6hho8SWhMXJ2IKe3FMWXAS1ZinNXH+DzQlmSLflxY7+dbO
	ZWC5EAwcCg5a33kXs91HxwvK39XwSUzAA7+vqe7aqaXF56bl6qACkn7vaiFMtUs7
	MzmFC9Cl/j+U4byayptsjNwh3GBSq2mj8Qi9muVyYwZOcJ0HI/rTYI0fASDQrTRM
	kam8xqMSC4I1RnYOM3m7rTTIcpEzN/o3IH+HkuUMIoUFKllnzr2AymY0gUWfqXOC
	X9UcGnPHQYnHUDmFl/b9R4z9UqwxQMWJXWQ==
X-ME-Sender: <xms:IEWPZ9B6f4asNrDifTfqozTXvjFnTRq5FWTz3g4TsnZPdYKqmpTwzQ>
    <xme:IEWPZ7hGVKyNhDlzvq07_sl_KUzrumvPKKEisoq8UG9tlaDBDVf-PWlV3tIFtkSR6
    EQfckKY-cCuU7lGTQ>
X-ME-Received: <xmr:IEWPZ4nEa9CWcWwFxZpIa58I-uGWpO369ueAQFhZp8X37bjLyp-cjDbBiI59I_zNQ9JIe4iJuHee6NF-_HVwwdXc-WKFiCLN1-qGUKy3Pd5ttw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejtddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IEWPZ3wwpdGDXz4P-VB9IuI80ku2drA83CMI3MVs0FcCcZZT1sUivw>
    <xmx:IEWPZyTReCPkRlNyRlV2M-sc8uGK5TY4AXkpe-_6hjLyqnIDCzan4Q>
    <xmx:IEWPZ6YAbixvqn9re_8WihtRmpAhMOfC1Cfnr_VnH7s5vfhZoQmdlw>
    <xmx:IEWPZzT8EL-gNfDcJeSF7SiWfv3C2oBE3wmJMfpvgwB0F0RrvYbmQA>
    <xmx:IUWPZ9ded-9kLt_O1epSFgtnBhMLfTr8K7nXKEXBhabxQ14IsVrMzKWD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 01:56:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac58d3d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Jan 2025 06:56:30 +0000 (UTC)
Date: Tue, 21 Jan 2025 07:56:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] reftable: prevent 'update_index' changes after
 adding records
Message-ID: <Z49FHQgsFSX6sTxu@pks.im>
References: <20250121-461-corrupted-reftable-followup-v2-0-37e26c7a79b4@gmail.com>
 <20250121-461-corrupted-reftable-followup-v2-3-37e26c7a79b4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121-461-corrupted-reftable-followup-v2-3-37e26c7a79b4@gmail.com>

On Tue, Jan 21, 2025 at 04:34:12AM +0100, Karthik Nayak wrote:
> The function `reftable_writer_set_limits()` allows updating the
> 'min_update_index' and 'max_update_index' of a reftable writer. These
> values are written to both the writer's header and footer.
> 
> Since the header is written during the first block write, any subsequent
> changes to the update index would create a mismatch between the header
> and footer values. The footer would contain the newer values while the
> header retained the original ones.
> 
> To fix this bug, prevent callers from updating these values after any

Nit: it's not really fixing a bug, but protecting us against it. Not
worth a reroll though, from my point of view.

> diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
> index 5f9afa620bb00de66c311765fb0ae8c6f56401ae..1ea014d389cc47f173279e3234a82f3fcbc807a0 100644
> --- a/reftable/reftable-writer.h
> +++ b/reftable/reftable-writer.h
> @@ -124,17 +124,21 @@ int reftable_writer_new(struct reftable_writer **out,
>  			int (*flush_func)(void *),
>  			void *writer_arg, const struct reftable_write_options *opts);
>  
> -/* Set the range of update indices for the records we will add. When writing a
> -   table into a stack, the min should be at least
> -   reftable_stack_next_update_index(), or REFTABLE_API_ERROR is returned.
> -
> -   For transactional updates to a stack, typically min==max, and the
> -   update_index can be obtained by inspeciting the stack. When converting an
> -   existing ref database into a single reftable, this would be a range of
> -   update-index timestamps.
> +/*
> + * Set the range of update indices for the records we will add. When writing a
> + * table into a stack, the min should be at least
> + * reftable_stack_next_update_index(), or REFTABLE_API_ERROR is returned.
> + *
> + * For transactional updates to a stack, typically min==max, and the
> + * update_index can be obtained by inspeciting the stack. When converting an
> + * existing ref database into a single reftable, this would be a range of
> + * update-index timestamps.
> + *
> + * The function should be called before adding any records to the writer. If not
> + * it will fail with REFTABLE_API_ERROR.
>   */

Thanks for updating this. I think the reftable library is one of those
code areas where it makes sense to sneak in a formatting fix every now
and then because its coding style is quite alien to Git's own in some
places. We could also do it all in one go, but I strongly doubt that it
would be worth the churn.

> -void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
> -				uint64_t max);
> +int reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
> +			       uint64_t max);
>  
>  /*
>    Add a reftable_ref_record. The record should have names that come after

> diff --git a/reftable/writer.c b/reftable/writer.c
> index 740c98038eaf883258bef4988f78977ac7e4a75a..03acbdbcce75fd51820c5fb016bd94f0f7f4914a 100644
> --- a/reftable/writer.c
> +++ b/reftable/writer.c
> @@ -179,11 +179,20 @@ int reftable_writer_new(struct reftable_writer **out,
>  	return 0;
>  }
>  
> -void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
> -				uint64_t max)
> +int reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
> +			       uint64_t max)
>  {
> +	/*
> +	 * The limits should be set before any records are added to the writer.
> +	 * Check if any records were added by checking if `last_key` was set.
> +	 */
> +	if (w->last_key.len)
> +		return REFTABLE_API_ERROR;

Hm. Using the last key feels somewhat dangerous to me as it does get
reset at times, e.g. when finishing writing the current section. It
_should_ work, but overall it just feels a tad to disconnected from the
thing that we actually want to check.

How about we instead use `next`? This variable records the offset of the
next block we're about to write, and `writer_flush_nonempty_block()`
uses it directly to check whether we're currently writing the first
block in order to decide whether it needs to write a header or not. If
it's 0, we know that we haven't written the first block yet. That feels
much closer aligned with what we're checking.

> diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
> index aeec195b2b1014445d71c5db39a9795017fd8ff2..b23edf18a7d75b0c2292490ad06d4dfaaa571e79 100644
> --- a/t/unit-tests/t-reftable-stack.c
> +++ b/t/unit-tests/t-reftable-stack.c

Can we maybe add a unit test that demonstrates the error?

Patrick
