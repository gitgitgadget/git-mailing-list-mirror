Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0D3D982
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728014382; cv=none; b=Dr6ypyapdgQ6QDn1MzTMYLlc/z5mJDoKr+CBWUjbz5HVVc9Ah6j3h2XsW7Ft4cTj2hREfv/fVwv84Nvn26s5SbVbkouZtDp3RuitCLhO4I3UFiT6jzVnXCEJzmYU/LR0uKrF5gPv6qkjTVZxrE167GmxCVPLng99T5UB7W8fAAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728014382; c=relaxed/simple;
	bh=lagfQ/ZPM2gIdebkI0GVAYU2Ag+q84t5kK1PbTqHtp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emuyp/J8D725/EDVxwdsbjCKNzZ5pYaYcLrziZyqOw4AAtaGMwzyeHweMLOf4BrvmfUArvUavtxYgnn3cAZRP3exbBDq58xisQr+CLhimR2ReDtrupIkaD0+zb6bGGc7TIadrPYWvjKjaib8ffzld8GOmgEkQcReFi9OTNILao0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Blte/fp/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l/TgnxMp; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Blte/fp/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l/TgnxMp"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DED88114021E;
	Thu,  3 Oct 2024 23:59:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 03 Oct 2024 23:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728014378; x=1728100778; bh=wza9DgdXbz
	yPHtLCd0QppbqiRC/ZNpddJ1kv1jclnFs=; b=Blte/fp/TLPZmtzAz0PL/20gc5
	+YWi7shGsu2pvB8Bh2D/z+dhejNvT9XB9//FElRKiG4uvek+qk9IP+bSUZ1PsUyH
	JrpLh1xoBzvE9m2KibVs5AiWzkia1zeXeWrZywl5Yju6NwHzjVKqmQBlrm2d/NP1
	Pt8VkDoww7Urq5mzy2ZrvWZ9CnLp/ObiNnTGicQhWP7ljd3NZ/jg5DHnzdM570SP
	NEfc+5s35Oy5E66sKrQiab8sL6o+9U6rD+IzICyACcGUdootB5uvutqxnW6Rq5XH
	C87WifokGutMva6ULKOnKZy6U679aiTzwVKG/RtCmukSu5sZEIlwybI4r0Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728014378; x=1728100778; bh=wza9DgdXbzyPHtLCd0QppbqiRC/Z
	NpddJ1kv1jclnFs=; b=l/TgnxMpSe1jnAYKvqjsWN0ELLViYq9mtDGdrlWqnlhl
	lyw/FTyXl/RXmYCFYBcFKiI+ylzFWFP1b93f3YARnXLRmVxOIg5o2bg8NePOd8BG
	KsKnHu5sSLNAVfoj8chz+hwRXCy3AR5JIZmqNAa2fuY0ZwxfAzrwYJuqoX4ayZYU
	oqbhTEdJokt6mRMAjbJz2pe8oEGxHXqyBEnTHVgSY2I415CHzlzrBjJYBYFBd4cQ
	QaQqdvmlxY/b/rL2dzWf06+zTK7o5F+sGDeRpugPcPcXlooaiew5BC0l9zzKoLxI
	198Mw0/gMMnJuuHxrKabcG4Wy79eOMLVnjzFLzR24g==
X-ME-Sender: <xms:Kmj_ZsOzBU__pCyTOEKAO0YYDSkNyCeH4PVSrJ_Xbs2Ox0L3O37Ygg>
    <xme:Kmj_Zi_YqN4WySfSthr-WSrtPT1Ej4kTFbmDzvOsJPnopNSz9WIFEv5eUk8e_kxPc
    c3CElWX7Kk_nVs7YQ>
X-ME-Received: <xmr:Kmj_ZjSe0oQmZAgX8pRKwNmKKc3unESrB3pjuA9PZPDsaWi9QXwfivkrfIOiCLkk5MKGWctjPpkU08gV-Zs3BBX0vRp2DSpPw-xDExLm9qUBFb4U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrmhhs
    rgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:Kmj_ZkuAo_wzWvLlm3RM_daecuBIwj333enXuVBIsWVo13unX8qe6w>
    <xmx:Kmj_ZkfGSAJkARaqhf-DiFshSONCa208y_CU1aPaMmUA1cRYBgoOjQ>
    <xmx:Kmj_Zo3SejdD5eqV4j-nOpn7jCjm5TKqrV9buFDrXKNcNMh0BgmW9w>
    <xmx:Kmj_Zo_lD8unxJovt8c9EoXUA1MDMew9F4VDm6Tvk5uJqM_NXAJGaQ>
    <xmx:Kmj_Zs4cpFZTRMCPhhPec8ee3ZBGB9hVcVOZHo8CDA9sO_YUIzGbYbjO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 23:59:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac92fb9c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Oct 2024 03:58:43 +0000 (UTC)
Date: Fri, 4 Oct 2024 05:59:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: v2.47.0-rc1 test failure on cygwin
Message-ID: <Zv9oIrKveu-JAGQM@pks.im>
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>

On Fri, Oct 04, 2024 at 02:02:44AM +0100, Ramsay Jones wrote:
> Hi Patrick,
> 
> Just a quick heads up: t0610-reftable-basics.sh test 47 (ref transaction: many
> concurrent writers) fails on cygwin. The tail end of the debug output for this
> test looks like:
> 
[snip]
> 
> t0610-reftable-basics.sh passed on 'rc0', but this test (and the timeout facility)
> is new in 'rc1'. I tried simply increasing the timeout (10 fold), but that didn't
> change the result. (I didn't really expect it to - the 'reftable: transaction
> prepare: I/O error' does not look timing related!).
> 
> Again, just a heads up. (I can't look at it until tomorrow now; any ideas?)

This failure is kind of known and discussed in [1]. Just to make it
explicit: this test failure doesn't really surface a regression, the
reftable code already failed for concurrent writes before. I fixed that
and added the test that is now flaky, as the fix itself is seemingly
only sufficient on Linux and macOS.

I didn't yet have the time to look at whether I can fix it, but should
finally find the time to do so today.

Patrick

[1]: <20240927040752.GA567671@coredump.intra.peff.net>
