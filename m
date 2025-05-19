Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23812285404
	for <git@vger.kernel.org>; Mon, 19 May 2025 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668783; cv=none; b=foTpeE9XuxCPJSERIcuZXrnNGp/exBDChlLRbyz2U6U1HDrJWp84fykdLtxNN8CNT+owaStYYY2czQzvYkIueNSaBKpy4Y8QRKzlHBEhFpetsXq/LCzE75M0F3AIzHq6Kmwmce797mhlyx7WRMgoW0fgiTRUD3gER065IccBLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668783; c=relaxed/simple;
	bh=wU1wCJm4HMldr4M3+RZmg00oQKS20+ySaME9zoMBQ2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A5hQIaqK3gJ/mUjNCHGzLjNmr5R9USA0NEUHRU6aLIOL/LWfT8jiIZUPmaloTFdFY4PU+s8qn2oH4s/cf8cxcxTJ8YfMGQYr4OZ7t6j20ctdndim13oSA5hwPZRjNwZe/WfJ3svXo/oTMU03PqrWNDe+R8beJCT0gCrttufELqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YcXh3Yxb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gsxJ5rnR; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YcXh3Yxb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gsxJ5rnR"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D56E42540114;
	Mon, 19 May 2025 11:33:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 19 May 2025 11:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747668780; x=1747755180; bh=2lxZIcnqBc
	AzySNsm26W/foxZixq6oGlqYP1i0paSSM=; b=YcXh3YxbP1fBkVK2fwsNJMk6Vo
	ml+sjbhRIVKaqdqGmeACHx1CRmllT0ppLc+xu1VqOPDzBgbrkZ3w7J7MNq9YEQ71
	LQnGTOhArtV2wMOJxWFav0PTHpKuqVVT8i0Oe6251SWq+mOwKZZMPP925bdfASOj
	6vZFLQKN/QoUR+pF1T8RD04af5KHjPMbgc6F/5jvnGHQgOIuCT02I9ZAdnL5Cci5
	JkAVriU7583Gy/KAoJzvE3ERvbKv6NcK2qzkWrpRD/Jk8JcJHPST0DDzBHamfCos
	+mhgM8wzGRa7olOTPkJz/1YqMFJAlnN7J/dasYPYXei19JE1cQ40nTvU5MGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747668780; x=1747755180; bh=2lxZIcnqBcAzySNsm26W/foxZixq6oGlqYP
	1i0paSSM=; b=gsxJ5rnRRrSFRWD7FJ5LoIm756LLbr3bGQslVSsY9ATmFs7rlht
	5sIdLTmUO7m2b4LxsqgcEzQNq1ca3d7/ZjH+fGpF2uEp83UIDD9ZR3aIYQm3+a+W
	d8Kce6NC0/FMvot7B6vRHINRsnXbfIQ2QOHLvEbCx36EsDOWKARlmRFsXYxM5JGZ
	QXIU/Ym56MsMjuG+YeJqWlecsYhczFfhEAReT5UhIi4B2fiTYJogPlL7NSO9WkZn
	GsPifbRVFMMPcMiRLBVejFySk9o462w9AS4zXNl8L4d9vayq8FdESAJ+gDc1VPgk
	oqvyMTZOeVc0QjGyUYi3BOppcrzajAOkH2A==
X-ME-Sender: <xms:LE8raGJ-GXFOwwwt1E_MDyyAzGtJ6GaVYBHCwKgjw75QGQJDzSrVxQ>
    <xme:LE8raOL3tNUOmlCUtx_x9lsER-E6p2NcnSAOT30I1qCAnS2WBtP97SbLeIQgmEQJS
    4_sXGeI8Z4x8LXg6Q>
X-ME-Received: <xmr:LE8raGvvegxwcAosKA-t27H1BMyobuRkGi6X0cOqJUjFYJtIcCuV7TVWyeI1rsuc4AoUtClDKhrUWuGo6AbfGlRoEXb3HFRb4tdcJRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:LE8raLZ--Yjyc2EP04cMu9_cFGrhrsWL_4uwqKuNWJpv6lLnwuqNCQ>
    <xmx:LE8raNY7HlrUm-K-iA_PHZ-JU_W_gzTyujDSNTwslexDT5vME2X2oQ>
    <xmx:LE8raHBa0MbaGGusMDlhs6G9Fox6ooA14QmxCkx9KZxKRzCY5yxr6w>
    <xmx:LE8raDaz1Mlxbj64Zxa4KeZmYDE9jirAZJ93vkdl3aLU_yVPuH7FzQ>
    <xmx:LE8raAm8f7MnmKmaqdanMPl_TYwvSOON3HmIhuTr6O2-fJeTxBckjUrd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 11:33:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 13/13] object-file: drop support for writing objects
 with unknown types
In-Reply-To: <20250516045013.GM22242@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 16 May 2025 00:50:13 -0400")
References: <20250516044916.GA21985@coredump.intra.peff.net>
	<20250516045013.GM22242@coredump.intra.peff.net>
Date: Mon, 19 May 2025 08:32:59 -0700
Message-ID: <xmqq1pskpqdw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Since "hash-object --literally" no longer supports objects with unknown
> types, there are now no callers of write_object_file_literally() and its
> helpers. Let's drop them to simplify the code.
>
> In particular, this gets rid of some ugly copy-and-paste code from
> write_object_file_literally(), which is a parallel implementation of
> write_object_file(). When the split was originally made, the two weren't
> that long, but commits like 63a6745a07 (object-file: update the loose
> object map when writing loose objects, 2023-10-01) ended up having to
> duplicate some tricky code.
>
> This patch drops all of that duplication and should make things less
> error-prone going forward.

Good.  Creating broken loose object for the purpose of testing was
the only reason to have this "feature", and that is reimplemented in
a shell script in the test suite, so this can safely go.  Nice.

Thanks.
