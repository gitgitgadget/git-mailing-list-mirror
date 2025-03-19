Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F923AD
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390301; cv=none; b=r6Re0lAvTBHq9BQk2FlUzMN+gd9Ie2i3ig2l8rGLM2IYSaRRWXtVcrrC+1aHR9O7RtOS3tmMNbjfF2/qh4tfg7YMTdr4gWr9Rd5HdaXiG7EeavvKMWK6bqKGD1MGlGN2Ii00btMQYFJyj0WB0+c2oZDsuDrzfhrVaB2RVPtNrFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390301; c=relaxed/simple;
	bh=3PYl/gHbfLOLDT5syDtmFgrmxnpF3WbDTtmyvuDJL2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InDyPewLdVnPFWEOh55Iebrwue1T/S2NZ5NQigih4aXBsmfApiyVXOeh1rUUnNVdMqoUW2K+HqiIGgywN6Cy8XKtKb0jxF+JRX2gk8exoReEcVG/vk3bksFKIOsSR5SC1aChRiF03Wyk5qLWpsIABJ4F0x+7ItSv8Wo/pDovZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K8T8Re+Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5TKLWeN+; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K8T8Re+Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5TKLWeN+"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1260E25401FD;
	Wed, 19 Mar 2025 09:18:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 19 Mar 2025 09:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742390298; x=1742476698; bh=gXYxKVtmPJ
	+5V2kWejmnCDjfYhiyw8KMPL48nL9N+A0=; b=K8T8Re+Y/N/i2Sn/PQkKFSWxpU
	TsCLob+m9JsgUxItQjQkNIR5TlQASctdzT4JITGK6F7sEvMFqXkbGoesoudW7dKa
	p6G+Bnvn/yMFDC4NViA6KpESHdrVaiUqTruaXtloTBQx8PVnUUzoitBbgn3I4aUb
	50xIAycE6heD6izXNzCX6qYgm7mCx67J3TZRNVcbNIhhKTOyZ/NIu6+wQYcLGDEK
	hWliwfRr0BEfN0p6lZI+G0xGgkatFFGKVgPkfbjOzpDwzLoB4sBDz6I0hdUXYUBX
	4/pmUPblvMWUJvy7lEhlc1Ssu30CaNKLaoiHQbddJqy5hPacQ7ApzXEFqIoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742390298; x=1742476698; bh=gXYxKVtmPJ+5V2kWejmnCDjfYhiyw8KMPL4
	8nL9N+A0=; b=5TKLWeN+w3+ANv1I4MC3ET2FUkJ0KZaMdoQ1Qd4ZeANtM/KcdOM
	pKn/ZUdjAy5wgWqZo3gQFRxpB8ifCoS6e+6O78epnCv3uruxePLsLJkQmr9vNCC5
	pfTuISK5IaOMG14kNVzl1j/o7fdG6F8QMKJ/C070bmEenac7BtliSBCkoE3sUX8R
	XZsVBDv/ww31REcLC33nzg1Ulo1GmEzXVG/Cpn9Lf0RPanGUDNzvE5dKYpdfY1LH
	13c2aE+ePtDpH4EKyPUio66JZAYH+mW2aGtmrfKoF5ZzABzcWuqbvawmdjdRvmd8
	vpWUE6ufogLRb/cDsGYB/uCupRGlQK0rD4A==
X-ME-Sender: <xms:GsTaZztQ8dUfIESp3KjCD9JLAYusF5cI_bfk_DKfWlxMZ5T8AwDp-g>
    <xme:GsTaZ0dHLk5jPpjnXgSgHarjwVpGlet4NAkl6BL1C70S_gY6Od3Bn8W5UfC6xenJC
    5c8ZZ814yIzjTfHUA>
X-ME-Received: <xmr:GsTaZ2x7khz6IwEnCVoHVTBmj5emL6IuSaj6DoFAbY8l7Gi_k8neVxlgEMm2VT-sdSQTyn06swqeihXM8sU3Jqo5o8GOBLo1jaucX0Rg3EM8REHPYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehgeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:GsTaZyMBtXmsxV0uvtrb-EgCWLdecF9nD2MNbME-o_OZf7CPhY19Xw>
    <xmx:GsTaZz-ynhOsPUFAFDSdw7NxM6laGmZheIVhwkXiw_IAamGNuYPdXA>
    <xmx:GsTaZyUbsWNozxUQU2v6hyFaMiSQQobE-m83vLwCS0y2LGHUHtJ1wQ>
    <xmx:GsTaZ0dehR_GuetY4k_cKMsE9zO8m1bVcUxx9HUVuP8YCcr6FIj0_w>
    <xmx:GsTaZ2bgsaaSUMYMtyxjAu2QfEGHNOW2stjazLW1JOa9fA5HVA7c2KQH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 09:18:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 43044cc1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 13:18:16 +0000 (UTC)
Date: Wed, 19 Mar 2025 14:18:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 2/2] reftable: adapt writer code to propagate
 block_writer_add() errors
Message-ID: <Z9rEFzVkj2O76B7m@pks.im>
References: <20250308133349.1591331-1-meetsoni3017@gmail.com>
 <20250312121148.1879604-1-meetsoni3017@gmail.com>
 <20250312121148.1879604-3-meetsoni3017@gmail.com>
 <Z9GC400L-XV3SFyj@pks.im>
 <CAPhwyn3rAaFZ0UYniJWUswAWyyPkDNgvKSvRpV6_H9v__txVog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhwyn3rAaFZ0UYniJWUswAWyyPkDNgvKSvRpV6_H9v__txVog@mail.gmail.com>

On Thu, Mar 13, 2025 at 08:59:51PM +0530, Meet Soni wrote:
> On Wed, 12 Mar 2025 at 18:19, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > > +     /*
> > > +      * The current block is full, so we need to flush and reinitialize the
> > > +      * writer to start writing the next block.
> > > +      */
> > >       arg->err = writer_flush_block(arg->w);
> > >       if (arg->err < 0)
> > >               goto done;
> >
> > But there is another case further down where we do `block_writer_add()`
> > and then re-try in case the write fails. This one is a bit more curious:
> > if the write fails, we don't create a new block -- after all we have
> > just created one. Instead, we reset the record's offset length to zero
> > before retrying.
> >
> > I _think_ that this is done because we know that when resetting the
> > offset we would write less data to the block, as can be seen in
> > `reftable_obj_record_encode()`. But I'm honestly not quite sure here as
> > I haven't yet done a deep dive into object records -- after all, we
> > don't even really use them in Git.
> >
> > In any case, I think that this callsite also needs adjustment and
> > warrants a comment. And if so, all changes to `write_object_record()`
> > should probably go into a separate commit, as well.
> >

Sorry for taking so long to respond.

> Regarding the callsite in write_object_record() where we reset the
> record's offset length to zero before retrying: my changes currently
> follow the same principle.
> 
>     - If block_writer_add() returns an error other than
>       REFTABLE_ENTRY_TOO_BIG_ERROR, we simply return.
> 
>     - For REFTABLE_ENTRY_TOO_BIG_ERROR, we flush the block and retry.
> 
>     - If that fails, we reset the record's offset length to zero and
>       then retry.

It's this last step that also needs to be adapted to check for
REFTABLE_ENTRY_TOO_BIG_ERROR, because the intent here is the exact same:
if writing the object record failed even in a completely new block then
we reset the object's offset and try a third time. But same as for the
first time, we don't check whether we get REFTABLE_ENTRY_TOO_BIG_ERROR
here and thus we might be failing and retrying even in unintended cases.

> I'm not sure what adjustments or additional comments you are referring to.
> Could you please clarify what changes you expect at this callsite?

So overall we'd add the check to both callsites, like in the below
patch.

Patrick

diff --git a/reftable/writer.c b/reftable/writer.c
index f3ab1035d61..63629e00a37 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -628,6 +628,8 @@ static void write_object_record(void *void_arg, void *key)
 	arg->err = block_writer_add(arg->w->block_writer, &rec);
 	if (arg->err == 0)
 		goto done;
+	if (arg->err != REFTABLE_ENTRY_TOO_BIG_ERROR)
+		goto done;
 
 	arg->err = writer_flush_block(arg->w);
 	if (arg->err < 0)
@@ -640,6 +642,8 @@ static void write_object_record(void *void_arg, void *key)
 	arg->err = block_writer_add(arg->w->block_writer, &rec);
 	if (arg->err == 0)
 		goto done;
+	if (arg->err != REFTABLE_ENTRY_TOO_BIG_ERROR)
+		goto done;
 
 	rec.u.obj.offset_len = 0;
 	arg->err = block_writer_add(arg->w->block_writer, &rec);

