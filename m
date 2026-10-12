Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7D9498904
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817781; cv=none; b=qiIVOS49KEIQJar5FrdpNXP0x9qQ96wk+XS3Lf0xUjX+hEQQpc7jsIicjocqHoAvtncNuAi1nAQDsgxFZuOYD4IM9QK0PBmYPsDq+8ZwyssMjmwFtf5XXRkfjAOUNdoyU61RML7ruBVqnzV5+82QZci3yY5F3oxBNuoghRWw9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817781; c=relaxed/simple;
	bh=LlgYAFB1TCd7SUc/kspbrlzpNoMidHK3D9yZ+TVrRAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JXni9ErwZn0pQ9JKadcSYtamuRa0qZYdWo9UoYS+tlj5y0m8Y08MjzW85z0Ui9M/u4uA0Z71yGuvd6+xTxhG0IKAlwMVGA/lYVHMfCmlSj01WvCWRbjfs12K/EF9w3M3W1bo4/eRDMS/B27tN02WImaRbvmpFD/bi866Qrlc3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nUATHmFX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gMD9/Ear; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nUATHmFX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gMD9/Ear"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 525161400101
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 11:09:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 12 Oct 2026 11:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791817779; x=1791904179; bh=JNDuoQrJtA
	hXH9XLI3Z2VsIEnZfTa8T8f5pR5USYWIM=; b=nUATHmFXtYsoXLGnVE23Bt5ks5
	MMvmBvzdUO6Di/kkhImVCfiDrQoCUpxuwIFcxPD4jPocuHJ0e25K4o7RDh1VCtjH
	CsSLqkDx4pqfIMOoXBzHYeWKdzxaJW/+6ZAAfBcVFZwQhs+ZlNzdNdKrYZcejGD3
	eU0X8kA3B7KVB2Mgg0jzgF58Ip0wFw9riGO92rHuaO1lUEh9yJ7PnM0Amx5/aDAw
	z3VjCqjMKXjwCwna2fNAPuOhSEu8b2ql2j8/RgzDZHJSRVSw6TWc5fBbJ3MGEUBQ
	enHAqhemK+mDH5xLcYWjOuVF/5uuUWQMyeMJ5k8cCMuRXtPevJag5iqd3LLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791817779; x=1791904179; bh=JNDuoQrJtAhXH9XLI3Z2VsIEnZfTa8T8f5p
	R5USYWIM=; b=gMD9/EarzfrFbTmb2rHb4nzMqGVZno+rTuF7MjStwJB6MT6nVvc
	3xpi8Si0ngvdXvyUl3+peu0AYhzjr0jtJx7JF5MTpNCA5JxhsCa1H/8cATy/wrzG
	h0L86OOTWXGAgpzxjzU31qpGAKhCoduyYN7LsbcLCYtQfMtF4Qw7BlKAqgBRY/vW
	gvEg6BYbtLQ+8nPRVJgVt9XR9sPK2RgChu/OuG1JRKaf0dnXZiVN+CqdW3Awsy/N
	+shoFD7PTx2rUa/USr6HuWRzufi2q0gVeZTJDOYuZn1Vd262nggpG8sVkxPOz+B0
	blNIzYy6xN3XSITtDY6ZfpzEZfhYjAE3zjQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791817779; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:R7y8znnd9OZPwYBw0GTEYkf2ROifJVEfgtghOhsgk/jkUB0
	NRNrxJldhcytRRdQ+PZMSygPzvCcbIzGo/2pVIuiQpT0+/bja0H8FMt68OrjRv6Q
	lcAJzLgQNcXUN1ADRCidXLgoQ0jkgr8DbJKJwvNyRqrrThlQvqoY7SBK1yAc4mVA
	T0QJ3jaaMtXoOQXOgiIVXoDx03YOrbB6p4wH+p/gzXSD2g4aULaGp8mTJOrUIVQ+
	uMAy3tXynOiqoqZnKCiZ4EpgmKzel9PcgfR16Jnhu58863/fR8gBTUQTNFkh84kC
	cd7PHxM5CGB7/GNJacPaXF8FcAVLAJ364FJo4NQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:nh4YDy32x4YZQiee6+zhRTA394s3jCMowZXEQikqtkM=:LlgYAFB1TCd7SUc/kspbrlzpNoMidHK3D9yZ+TVrRAE=;
X-ME-Sender: <xms:M_jManMJR0GMgEauWtWfjWdCXu5Q5VtyPCbOxS1oORfr77khX1kK-Q>
    <xme:M_jMao0-7Sg3-tFAYpM_5SxPDkOQhnzu-iCYbZROKYQzgIL9cFlFT5o2yG-Xze3mX
    T-HeOBxSuC-OPrdtPgxNDLBKMU8-t3kKpGL-Ue2D_1vAsm2GNfnaeU>
X-ME-Received: <xmr:M_jMauniRCYWdmgtoChkpI1wBf5IRXKUrM3n5lSpxebgnD8C3IE_HvZF2KttlUtKoAa3u44iZJca_VW2Xxd-TK4oL1V9QOUetRQa>
X-ME-Proxy-Cause: dmFkZTEW/PkDzRZBIjtePKIQH0k+O0DqG4Vbfqp8wlp2eHj8YqCYN0eOC8iw00SdcnKlVe
    F/LE1x3/xgwbZTVXDCFDIKLFfy4tUFTKLOPWA+X+54fXX/2CUkxENsrIGX8tzYq869EubX
    Ots/jM5qF1xxI+YOZSOidMjcxaX1QgF1Ot1GLRt24mcKH4mTWuleXGB2fjdV8eoUAQ75J1
    Rv2+nx7senSWA3qhK8h033kxZczz8nlhlwjuk5/tS2YZOpjv0y1MngNSrzz9xyUxIfzl//
    Ac1cOyfBxQSsM+gZuC3U8QAlYKC6qrQtY7jvm5aXgmHAJbE1up3WM62zBY1Ees6zGj8VNe
    lLYSKpLvs7V5a8sxs/aEXa6IS6PUY0szmSWc3SyV3c6e+71aPZkTwCU0afOjQFFGZn/6Oq
    O7fxwkaJZOuaJM78YmAt2kxgrMEJ1FZb/Y/9SZuI8QBgqMDgMc2wMNDzi5VErcjJCn7Pfc
    KgX3L8ux6ds8HP3DXG3nNeIThvu4rLN99BseEwvEFbKY6+UfzyV0YyMwtgq7OsOy2XRcl6
    eKuiSIwD5UxctNqG04/qZv6P4U7zSf78LD6Vvs5H2B/uRc/TWYfShkfb0rflbPpySxWoKG
    c0wfFxfGlo5SQqIZwkoMr+OSlMIMddczrB4sI7HaYR7EK/VsE2CGdan0epsg
X-ME-Proxy: <xmx:M_jManUdn_Ggzr6MA9vhtWMCcU4uEIQqFKSmb6IMs6A7dhjGS-KSjA>
    <xmx:M_jMastlKKhXocLWFcMNPlgQLvCE_GcnL8vCMWGzj-aE9fj9d-V9AA>
    <xmx:M_jMaiYTyMlNCVGkzWIjeOQoL1hgJEUIlwW49Mo3aVhc6zGREqhKjA>
    <xmx:M_jMajWTpZzo_xDb76NWxJaEOtocNLI7LVXVOolC03KWTT1brEnpSA>
    <xmx:M_jMaqED54pPcboYash16ZesS78G6K9j1DgoDJ-a6BPF3OTHDCNo1tQB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 11:09:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Johannes Sixt
 <j6t@kdbg.org>
Subject: Re: [PATCH v3 2/2] merge: remember conflict labels
In-Reply-To: <9ac1a744-b326-4b61-869a-546fee80da20@gmail.com> (Phillip Wood's
	message of "Mon, 12 Oct 2026 15:10:32 +0100")
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
	<cover.1791537203.git.phillip.wood@dunelm.org.uk>
	<182edb2e8874986206a38a0af005e4df9ef9dd8f.1791537203.git.phillip.wood@dunelm.org.uk>
	<xmqq1p9yjtcp.fsf@gitster.g>
	<9ac1a744-b326-4b61-869a-546fee80da20@gmail.com>
Date: Mon, 12 Oct 2026 08:09:37 -0700
Message-ID: <xmqqld839cr2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Junio
>
> On 10/10/2026 01:24, Junio C Hamano wrote:
>> 
>> This function is called once for each conflicted path, which means
>> we would read the "merge.renormalize" configuration variable and the
>> MERGE_LABELS file, both of which will stay constant during a single
>> conflicted "checkout -m".  The issue is shared with the original,
>> but looking up the same configuration variable repeatedly would be
>> helped with in-core configset cache.  Compared to that, the overhead
>> added by this patch is to open the same unchanging file, read & parse,
>> allocate and deallocate.
>> 
>> Perhaps we want to have another preliminary [PATCH 1.5/2] before
>> this step to allow setting these "per invocation constants" once to
>> be reused?  Then step [PATCH 2/2] can read labels in the prepare
>> phace just once, use it from the data structure in
>> checkout_merged(), and free them in release phase when we are done.
>
> That's a good idea, I'll re-roll using the diff below (I assume you're 
> happy for me to add your sign off?)

You assumed correctly, but if you ask me, I would say that it
probably does not count much as coauthorship than a mere helped-by.

