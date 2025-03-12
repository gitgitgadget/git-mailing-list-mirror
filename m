Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA67083C
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783791; cv=none; b=fRESBsUMgIfAPuZAn/RfdZAtZBsLTjJWA0opUTmlz/W8+R0eme2sqOSwTx+XlOUMymUrXsfoL3ganT7MqWc6LhxFy/ok9ognCBdb+GwqwzQaWuTjUFrHeHTCk8a7/rO2YBi9M1HPw3cG/G++Nb/FoSWBMj16eIl9EkS5X7nCAxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783791; c=relaxed/simple;
	bh=ELzLTSXf8jITk7oZsXuu/83u3ksCx5//NoIkKPzqt/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAIBhZ46AOHErkHn/uJT1251P6i3B0g2pucnQe2Sh1HbX2VJd2Qq5CEv1Ybfv4bh93djlK7HWfLFfc4+i0u6e12RUpLDXuoXDPQjO3sfeO/khMZdMGkZVy/rCZEk1TXAzZrcqMRy+uecGU++4sTNz+U3wNek/ws7hG6+f3Z3DWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MsWlCGlm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0NWerYSr; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MsWlCGlm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0NWerYSr"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5587F2540283;
	Wed, 12 Mar 2025 08:49:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 12 Mar 2025 08:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741783788; x=1741870188; bh=NPcGHQPgzr
	5Byu8BdAk9vvrhqYIVuun0Ajz92muU4G4=; b=MsWlCGlmxR4n96L07H0ID83+Y/
	ZTxv6dX2ClV72vCtq4hlTg2TvtCfiSXjpYZgU6HRtOZuFmIQTfKn8bXevq5SlpUw
	HLf9mgQdbk+6cYrrfGyVZcoHNhwOFdXkWqjKIV9eGAn4VSr0WdVYUIVH8RvwAgHN
	PkNYgZOqgvtY+gu1Zyfpn6SS+7cY3Ob58r5YJvfyvcrmPFMt1BLdOsSoU0VHij3l
	ZJODUM1NfLepXPMKkwa/0GsjYTv5R/JmupJJiwkIDe//SiHELzBH9CEmb6jG3PEK
	NYUziXf+OVpm/yWzQ1RWCCUuXB6GykpAMyDyk3DTg2xHZGP3lVHQfRFjeUKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741783788; x=1741870188; bh=NPcGHQPgzr5Byu8BdAk9vvrhqYIVuun0Ajz
	92muU4G4=; b=0NWerYSrJuciKmHXvyAabMcLpm+etWgzSi62zkZKuq2jxF2rUZ9
	VlZZxOMDfMWXvAhR83oXkTGvA1nth+be8C5aQU0W+rZtjlynrLb8/LYETBSwqqWz
	jAGSLazfeeAT0m+N4d6TCObbxdee33huSLJ5YBYp8rJWczHrlgVWrIjGNMK1x31O
	VsfvehQZB+EICLTlaySjIzivBpwfqvDSo+IoqzjVajnLnoZs3KLclmAp9JBy5nS/
	vNzet6dcFH0n2hofs0KXwneKyPdOOGweIjx6MKvKn1oa8Y5kBG/ZzGCboOvH4MaE
	w7to6pbFrdEn1TpyCg5+Xv5D7j8IbszpXkg==
X-ME-Sender: <xms:64LRZ4ih2bU6KUh2dup3A77bd8K4PEGYw64Xt_vD3w2BZ0-KM-5ZEw>
    <xme:64LRZxATIBYOlJqIXrb0JcBB3mHtL4ClAMrKJMApjNED4dJ_TP5H0-OnQ6Ul4Djin
    ZhIl1AZ5JORAAqE8g>
X-ME-Received: <xmr:64LRZwHW6KZ52wIJ8U5yWLXz9iwBdwV3tV3gPvpTA_GSQu7l-5Uul04ELRoKlmXi9aCALtXCpxo6tQ7x3pqdgdKpO4MBVnN5_Y41KYcQ5c85YHAUQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:64LRZ5RwN62KnrjwBkfEmlJtamMaJigcA--M34pzvoo3IFuPiZ87mQ>
    <xmx:64LRZ1yrc-y4vGlCZw8mD98XdC_EQlqwfqcd8kZMMNV8gAb3km_NxQ>
    <xmx:64LRZ34669qumblQNepiK-sqzZXmgWVtBAnWrmDyO4kUM3TOqQ23jw>
    <xmx:64LRZyytei9uPW5uX9u5hbNQYrZrJlMWgE82_NWzvCIA8_jN0nFCdQ>
    <xmx:7ILRZ98xhe2vBZdpWz_HDjuQK7xOd6B59P-_h5ozPT0TCP4_pwDIVyM6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 08:49:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 09cb0416 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 12:49:44 +0000 (UTC)
Date: Wed, 12 Mar 2025 13:49:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 2/2] reftable: adapt writer code to propagate
 block_writer_add() errors
Message-ID: <Z9GC400L-XV3SFyj@pks.im>
References: <20250308133349.1591331-1-meetsoni3017@gmail.com>
 <20250312121148.1879604-1-meetsoni3017@gmail.com>
 <20250312121148.1879604-3-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312121148.1879604-3-meetsoni3017@gmail.com>

On Wed, Mar 12, 2025 at 05:41:48PM +0530, Meet Soni wrote:
> diff --git a/reftable/writer.c b/reftable/writer.c
> index f3ab1035d6..0d8181e227 100644
> --- a/reftable/writer.c
> +++ b/reftable/writer.c
> @@ -310,11 +310,12 @@ static int writer_add_record(struct reftable_writer *w,
>  	 * done. Otherwise the block writer may have hit the block size limit
>  	 * and needs to be flushed.
>  	 */
> -	if (!block_writer_add(w->block_writer, rec)) {
> -		err = 0;
> +	err = block_writer_add(w->block_writer, rec);
> +	if (err == 0)
>  		goto done;
> -	}

Style: we'd typically say `if (!err)` here, even though I see that we
have explicit comparisons with 0 elsewhere in this file, too. So I guess
ultimately this is okay.

> @@ -327,18 +328,11 @@ static int writer_add_record(struct reftable_writer *w,
>  		goto done;
>  
>  	/*
> -	 * Try to add the record to the writer again. If this still fails then
> -	 * the record does not fit into the block size.
> -	 *
> -	 * TODO: it would be great to have `block_writer_add()` return proper
> -	 *       error codes so that we don't have to second-guess the failure
> -	 *       mode here.
> +	 * Try to add the record to the writer again.
>  	 */

My comment on the preceding version still applies here: the second
sentence (the one starting with "If this still fails...") should be
retained.

>  	err = block_writer_add(w->block_writer, rec);
> -	if (err) {
> -		err = REFTABLE_ENTRY_TOO_BIG_ERROR;
> +	if (err)
>  		goto done;
> -	}
>  
>  done:
>  	return err;
> @@ -625,10 +619,22 @@ static void write_object_record(void *void_arg, void *key)
>  	if (arg->err < 0)
>  		goto done;
>  
> +	/*
> +	 * Try to add the record to the writer. If this succeeds then we're
> +	 * done. Otherwise the block writer may have hit the block size limit
> +	 * and needs to be flushed.
> +	 */
>  	arg->err = block_writer_add(arg->w->block_writer, &rec);
>  	if (arg->err == 0)
>  		goto done;
>  
> +	if (arg->err != REFTABLE_ENTRY_TOO_BIG_ERROR)
> +		goto done;

Good catch that there is another such pattern!

> +	/*
> +	 * The current block is full, so we need to flush and reinitialize the
> +	 * writer to start writing the next block.
> +	 */
>  	arg->err = writer_flush_block(arg->w);
>  	if (arg->err < 0)
>  		goto done;

But there is another case further down where we do `block_writer_add()`
and then re-try in case the write fails. This one is a bit more curious:
if the write fails, we don't create a new block -- after all we have
just created one. Instead, we reset the record's offset length to zero
before retrying.

I _think_ that this is done because we know that when resetting the
offset we would write less data to the block, as can be seen in
`reftable_obj_record_encode()`. But I'm honestly not quite sure here as
I haven't yet done a deep dive into object records -- after all, we
don't even really use them in Git.

In any case, I think that this callsite also needs adjustment and
warrants a comment. And if so, all changes to `write_object_record()`
should probably go into a separate commit, as well.

Thanks!

Patrick
