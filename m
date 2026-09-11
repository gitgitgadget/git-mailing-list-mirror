Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBC2494824
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142042; cv=none; b=Lk/u5MX59ePxuWZ4ELTlxK1jJQKpI7WU8r8PXE0dlC4guvafShdpvh5q/gesudAA/2dlhSs/gJOmpeNDhELlzNcHfUTUWi5rsxvgkwpkgrURkXdsMTtyQrWZ3Wn/PNvmBIYg/9eZLHjjPeIDDd6TOaiPNBmCNmYi6z4WXfY0msM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142042; c=relaxed/simple;
	bh=+foPpnaNzt8STtOfqcqR6TiVEwhLbjUTUHXtejFpjLk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qWwu3m/0SasW5wJjYXBCdWKS5r27Nw1vLrPJDHp2ejvlGSo97YjL57Tof5HIpbM0PCGB++zEy8DnEAQEKe16zDOl4p1kWxIcUmCY4XBEtoxjWx61+SxGfCNSNKloHr/cRiE3qbE38b1V7aakNW1x+46BNZt+haPSktbMe8yMpQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qdcpbA0H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OB5bMCJt; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qdcpbA0H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OB5bMCJt"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4DDB1EC01E1;
	Fri, 11 Sep 2026 11:53:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 11 Sep 2026 11:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789142039; x=1789228439; bh=jA+MaPlSYw
	LueTaka8klDZU3CaPzFkFAg0Rwc+rKr28=; b=qdcpbA0HuHRKUgBTob/LE4LxC8
	AZ1ngqQ/d/ZhmWMRcyZFE1Pca56LPMUPBiiq9Ts752+yW2uHuuukkaajAWUsgZQX
	tIDcQk1uOI/nc8fYzzs0Sy79SI8g/B3yQ5Uqr92ptX4xtA1qbdpnRwMjo6UIKTAR
	H7S5syiTqwYepa+1saA9M6NAte5gJY7eAfifPgy5LE0bzE5863+dFucjUviUfGen
	oU/CxRuJ6M+gcwz/QHgkTEwh7hmVxFCzd/smJl9c/TQaix9JaCP1fc1dh8B7qb/z
	DLpMl5EvQnHXyMjl1PMt9wgjBvCxF53S65zubK+XOJrK1GEED7hRICJJfBlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789142039; x=1789228439; bh=jA+MaPlSYwLueTaka8klDZU3CaPzFkFAg0R
	wc+rKr28=; b=OB5bMCJtd9aAT5qr3KPSXRePdn6yYQvYVOISCoWF3yFBIDxeEFI
	tXD+Z6H4ebQ7fHUrTED51uhmRxmTNMa7clY7bx9GGe7Tl+UVRFsNxvNssa6phcmR
	je3nERCe3SYR/rxz0Jp+Bdpyo7Euk1B6wSZ74JxutIcbRqlV6YO7h5z/KE8LG80k
	WayhvUa7J2Xn3ULuYyHY9KmnhfvvOkj9Mz+dQGHCcTzgIZg9Dq+keEBN3kzoJqaz
	iQ8KO1buf1lzNjK63wLkzRQQYnl9FpWc0onwYH95DHS8k0AX8QN9QqlNSbeHd29N
	vMNRLLzZhTrGTN+5C6xrPxarNpq2wmc8UQg==
X-ME-Sender: <xms:FySkalbjQGdgeVwWLuClwSeibPCV6CZ4meBHGRA86cArilK7sluprw>
    <xme:FySkaj0H-hv_nXoRc71NwLOd2fujjTUkSZVTyzKxNG2vklXPgxacTp9cO6z-qMwPc
    PCrIantVbcXd-uDceiQrBSAcUHq5xmaR1qjRuJ1ICm81yg8vP16a5s>
X-ME-Received: <xmr:FySkalXrr1J0j3QFy0oRUVOOzNd2a8OdlaaIm69o1kFmg3GqIqXcR843L_Hr3qRrBnrtSvtrJXvIs-i9r-n-ob5ywmVmpJwOznhd>
X-ME-Proxy-Cause: dmFkZTEkXBgElkFK5/PP+DewZuXc/XfYLLaYieQV9SZixzezvyBQYa95GeBljvkCM8JWju
    ZEmN3dCgqTlpYUsGjjlBUMw/x3/B/cxs+Jxxs16PQ53GCVZfAI9CRcgf2hYYlrTLP+YJyU
    tgS/Zvfo0+FPWZS8HqY3bA6SMJtT6spAHbPYIn0JXAGCCR0mqqTQ5suuVdXZW3H6FQgqO6
    LsYRObz3b7tj9C0ynpnnpXueycW6bqeXyYMQbPlYIrRdPMhCLMBDhQniFQbdhHRFYCRt/8
    LMoecUqa1IJHejGHIhCbqh3Mn7xmcm9RCcenjYpornSPNTIO1jnLqLWa6bLx4IbM7IMHqv
    4q1kTthD2HK0Rm6KWEsV4bfyUN9FDyHge+heuLOzI0e+32ltZ7i+HIYkAnrwNf8cd3/jXr
    eNCTBMVjne2gH+j3ALUalS5ZCUkbM/OVFQsCy9iNDcgalM7zpY5zavrFs2VMMu7JkTfg4f
    xl7kYmV8pxpfKIlVcVS8baNNUogxt0yXmvEE/zuEdupYrywgjtiI2/ZUCn+G+wO5i0xj98
    rlBkAJwnyH+I632CtCJrNdjo0mfc9cbD674APf8FNgCFkI8LAZ4/POW6+IvrQsbM7tHdAc
    r9Kefvry5pDzzEf1kiwY7a6ocQ4PM9K0/tt+1Hf1Y5D3tzzJf3VPw/XXheEg
X-ME-Proxy: <xmx:FySkatUUfNMOC90cRnZ7zlORzyO2E0NvFUCVqNzFMThft9323r8USw>
    <xmx:FySkake4Sds0YopuC-oxqFkHbkW_AQAurDfen2U6WAcKe-b4oSTK1A>
    <xmx:FySkamXB-BfQgn_OPAmeV9Y2SxTE4HC7M3pUHTvEZEDrPtTULF-g_w>
    <xmx:FySkatcfmv9zTQbufzEMLA8tIYdRWGIkGUOsDGTMdVdhI24BQJozqQ>
    <xmx:FySkar_XQhtkWK3Q6LkIA5vGKxQiFTl59knDQan-as01LSWNa7nXSD1Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 11:53:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2026, #04)
In-Reply-To: <aqOZLBeMLY6NdW2a@pks.im> (Patrick Steinhardt's message of "Fri,
	11 Sep 2026 08:01:16 +0200")
References: <xmqqa4ppf1l5.fsf@gitster.g> <aqOZLBeMLY6NdW2a@pks.im>
Date: Fri, 11 Sep 2026 08:53:57 -0700
Message-ID: <xmqqld97dbsa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Sep 10, 2026 at 10:39:02AM -0700, Junio C Hamano wrote:
>> * bc/maintenance-doc-markup-fix-for-asciidoc (2026-09-09) 1 commit
>>  - doc: fix conjoined maintenance strategies in git-config(1)
>> 
>>  Mark-up fix for 'git maintenance' documentation pages.
>> 
>>  Will merge to 'next'?
>>  cf. <aqJntwrjC4ImuSyW@pks.im>
>>  source: <20260910-maintenance-doc-bullet-fix-v2-1-3ed1c75e24b2@brighamcampbell.com>
>
> Yup, this version looks good to me.

Yup.  We are after the -rc0 preview so let me fast track 'next'
candidates, which usually spends one week in 'next' before moving to
'master', earlier than usual.  A trivially-verifyable documentation
fix like this one is a best example.

>> * ps/libgit-in-subdir (2026-07-12) 2 commits
>>  . Move libgit.a sources into separate "lib/" directory
>>  . t/helper: prepare "test-example-tap.c" for introduction of "lib/"
>>  . Merge branch 'ps/odb-source-packed' into ps/libgit-in-subdir
>> 
>>  The source files for 'libgit.a' have been moved into a new 'lib/'
>>  directory to clean up the top-level directory and clearly separate
>>  library code.  This topic has been ejected for now, as it causes too
>>  many evil merges with other topics.
>> ...
> I didn't really have the feeling that I was gaining consensus on this
> series. Maybe I'll be able to build consensus at the Contributor's
> Summit, but until then we can probably just discard this series.

To be fair, I do not think anybody would unwelcome a change that
makes the sources easier to navigate---otherwise we wouldn't have
odb/ or even builtin/ hierarchies today.  It is just that different
people views how easier to navigate a concrete change proposed makes
the sources.

>> * ps/odb-stop-registering-in-memory-sources (2026-09-02) 13 commits
>>  ...
>>  Expecting a (hopefully small and final) reroll?
>>  cf. <aqD0F795VKJ6jUFd@pks.im>
>>  source: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
>
> I didn't plan to as it was only changing a single word in a commit
> message, but fair enough. Sent out v3 now.

Thanks, let's merge it down to 'next' now.
