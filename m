Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF1413221
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787293739; cv=none; b=Vmpkos52JCtwCGQJhRv3J39M5guK01bGW+8aNG42eSct9BGEV7RDHhRc6a+/PwubrAYfKroUpOgs1SJT+L76OIYsrNxO0E8KAj+7B26PsnisfSv/oktXkQmagHuKJx7Kv9ejh8busI+jEVJDbqK2zg1Adonm5dAj62Q6bPsuvd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787293739; c=relaxed/simple;
	bh=D7lT9+/tjpNlBrI/miB+keL3KH8b9LJzG+7Ddm3VK2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdRWSp0n+acy3aZKafVp+WsYcduZOchTivALw+Ob9AmsUVMcYybAvV9CvcSkCQr0OOVMzeZT2eI6+DdXe87ZU2U55i4URma+wjSrrqF3gaGDOaNRtgCcbsxgoERPxpWE8N2+fj7cJ+xNxwtIa7bYOj8/1RpkkhP93zuqhxB0mPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G8F9oXPc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mVY3GJMw; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G8F9oXPc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mVY3GJMw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id CC97AEC027C;
	Fri, 21 Aug 2026 02:28:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 21 Aug 2026 02:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787293736; x=1787380136; bh=CW5dVvxjQB
	1cgaC07DX8Z8r2ESTHhrGF2deDwc7+1pw=; b=G8F9oXPc+zUS0f3ZGXDrcjXGvO
	gHQ5u+IsrL+XCTyTX1L3EJqWuXGySHqDzu6p4G0WmLIMlNwoi9lG6Y5WdnHC4NDP
	Z+XbipkvNbvk+KXoLjzzjDcRNY5vh4C0IJuSx4YgcDo1MvnYkwnMo1BCVk9hIqyg
	/XHGpp/SzMDXUEGWYdCv1y0TQWyGbha+B+ilKTkGMZpjQLSSPeRq12tMMT4rcxqo
	TWS5iF4GpNyJOdBlE21OUu6BMHMnGvp8zf1U4XlidIFes0lHWQqE1HLxhceAA7tz
	acrALmT5lIioeDLyvHuqkDU2UwnIKsThAj4i8MkooJG7V0sBpSK5/mU2V6+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787293736; x=1787380136; bh=CW5dVvxjQB1cgaC07DX8Z8r2ESTHhrGF2de
	Dwc7+1pw=; b=mVY3GJMwe89Sgv4WoA4oH+CYd7CKp9Uowv9cXKWd0Wvo3D4heB4
	u9JAL+2iwpY7yzhwH8aBUbM4GK9pWGvvMJBEgmLZtRI3UZCDZDWJ7hoLcq+KciRP
	duFikxeGl0v3XfjZFaJ9jhpetGFRsBvCWPFa5o9l6EEBUXVd8rKcVwtI1wAaf2Pf
	hKmnZPM2PpXUJHdi2oREG41nK9aAwpdfLFfQ2c5xmtM6cKb2dq+ybEUE9kQSUwR3
	sea7BuEdtWkn90E+TAh3gW3rl9NoiLJQJCazF2F8gyRt+Su4IKjnI4K5QO3GSerm
	bxklVgSQx0nHNN2sVZjqmxpzjOwazRklVdw==
X-ME-Sender: <xms:KPCHagujnjNWUqBIRMzoaZh3D23R2-0ba_3Sw5oNkdkpYWl9ZtxPOg>
    <xme:KPCHakcOWrzJTfGb9KMgxACO1GS63aomCF9wPmqGxJTMrZ1Stw38oDdp-Hat_BOJl
    jTObu5MSVB16eNDn6OdLaOwLAY43OWu2DdGr2JofRRzNb9-o_lmHXk>
X-ME-Received: <xmr:KPCHagzsiUTvoeMMYXwNEeqbDI2O8AKKi9lvPmbODNs7duTGxXcMpNXQj2w7Cc37hT8TAbza13uHUf13xX1I5SXCEeCMM9zXNymcO2Khberw>
X-ME-Proxy-Cause: dmFkZTGcTZ5cgCTrH1pRKoOSrLp9JIo2MQbmlFIGLGVinm8d8rOgTDOVIp7+INWgPHvzVb
    yjEAEKxc3VdITfxIs8NdqW038Yfqavq92ngDnrhNNwhMcqlT/WMu/IJxHjcIqGyyZgnkx+
    /WSvNb2gjwwK01r7HoplTA/REptyNeLgS9sfdoGflUobSxvEP7GtcyD3kyX+jkOi11j/Qq
    pyh0eDs73k1OLDYAf8nNhq354IAKoS5A5cu80zttYbmep3zuW6fVI8HJxaN48OR97GcV4Y
    LZ4YbUjOMpArBJEpb8YxvPLLfqG5p1tbIcJWYGzp1rqE7m7SEY/h6q6u0BnFJ8Y9Moz1PY
    3/1LNKEwHvg56fnJjxoGiwH4ldCo9Tas6g808daYKa1zGBiCrxlM5hAQmm73DFgMkJMmcG
    1+2WFA+Ed9dudwAiPQVbtG+6bTm24lVuYn52FrAfue/3c/xo8DchqEkVGz4akkGvNWoGZL
    uAaUGzzTQdxtUXM9Xwf8viVRUdciOu69hUprYD+6UNMbY7gjsnsP5ojm5mbbxmDL+KZE2z
    ZznU/5163DgeIPAYiPozQ3jNFzaRci0IHVJGkCj5ZuA1X4lroBTQFJ7Wshu7+mwizcUQck
    VNjoyX38zLlS84MNF4ttL/AEhfab2hcOZN2j8ltTZEEsX9xBB0Op2IVjsrNg
X-ME-Proxy: <xmx:KPCHaiFX_PSKoC7AX9ue_YFBW7NajuVBNIKkP3fxpy4EXm08GqXJuw>
    <xmx:KPCHasz0ZaPhBwJhzUnMRWqsUwSMf6621Nx03KUX6NfLSBJH0v5xeg>
    <xmx:KPCHarvQ_g4otut-RwIH4oZrIPsQpwaZ0GcEVOEg0l_PJp0VNLDKjg>
    <xmx:KPCHah31VXDMdxart6h-HBZsl86V5D_fZhGfgyl7LMC35lJt1r_A8Q>
    <xmx:KPCHakQZvOotBPnoMsE9Hs3z4O_gm0AgDZnFKbgVGAQjDYbppGoEz5dW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 02:28:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 42991d73 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 06:28:53 +0000 (UTC)
Date: Fri, 21 Aug 2026 08:28:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 1/6] odb: introduce interface to generate packfiles
Message-ID: <aofwHhFeeWgh_3FY@pks.im>
References: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
 <20260820-b4-pks-odb-generate-pack-v3-1-bc42252f6169@pks.im>
 <xmqqik54soy0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqik54soy0.fsf@gitster.g>

On Thu, Aug 20, 2026 at 10:04:55AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb.c b/odb.c
> > index caf1d0f542..cd9d5b48bc 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -1046,6 +1046,27 @@ bool odb_optimize_required(struct object_database *odb,
> >  	return odb_source_optimize_required(odb->sources, opts);
> >  }
> >  
> > +void odb_generate_pack_options_release(struct odb_generate_pack_options *opts)
> > +{
> > +	oid_array_clear(&opts->wants);
> > +	oid_array_clear(&opts->haves);
> > +	oid_array_clear(&opts->shallows);
> > +}
> > +
> > +int odb_generate_pack(struct object_database *odb,
> > +		      struct odb_pack_generator **out,
> > +		      const struct odb_generate_pack_options *opts)
> > +{
> > +	if (!odb->sources->generate_pack)
> > +		return error(_("primary object source does not support generating packfiles"));
> > +	return odb_source_generate_pack(odb->sources, out, opts);
> > +}
> 
> Perhaps a stupid question but the opts->pack_fd is documented:
> 
> > +struct odb_generate_pack_options {
> > ...
> > +	/*
> > +	 * File descriptor that the generated pack shall be written to. If set
> > +	 * to `-1`, a pipe will be created and exposed via the pack generator's
> > +	 * `out` field. If set to `0`, the pack will be written to the standard
> > +	 * output stream. Otherwise, the provided descriptor will be written to
> > +	 * and is consumed by the generator.
> > +	 */
> > +	int pack_fd;
> > +
> 
> Here I assume that "and is consumed by" refers to "generator writes
> into it and then closes it when it is done"?

Yes.

> odb_source_generate_pack() delegate to source->generate_pack(),
> which I presume goes to odb_source_files_generate_pack(), which in
> turn assigns opts->pack_fd to cp->out and calls start_command(cp) to
> run pack-objects.  The file descriptor is closed when the process
> finishes.

Exactly.

> What happens if the odb->sources[0] does not support .generate_pack?

If it does not support generating packs then Git would crash as this is
a non-optional callback. All sources that could be our primary source
though do support it, and the expectation is that any future backends
would know how to implement it, too.

> Should opts->pack_fd be "consumed" here to avoid leaking it, or we
> do not have to worry about it because the caller will soon exit
> itself?

So this case here should not ever happen -- if we don't have the
callback, then there's nothing that can even set `pack_fd` and we should
die.

Patrick
