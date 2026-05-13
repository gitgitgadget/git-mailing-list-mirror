Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921A3B6BF5
	for <git@vger.kernel.org>; Wed, 13 May 2026 05:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651828; cv=none; b=ETzOB9hXIrLrFpyjb/XPpOR9UDqN8LD3KVB0XdNbo1B86dmuaF9w6BEX7XUs6/du+ztMstgGSKPF3CTwyeAg0ZB3QOYTUGsziCC2CXCq4mCZ6NWFW2/qVGkNVBXtkperulgHkbJ48WxU8Ly+RJWEFYGnWTlbnTRVjqENfrXOCSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651828; c=relaxed/simple;
	bh=E5zhC3cVNh1VQ5bW+kPo4HszPlUNJIpL3782NRv8guA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qowtBnW+5KRBE/yeC6TSCCgrBepvSqS/VMohCc8qkYQsROtRJdLTlempIiC3yhOrZrPBxaTjEfo96+mYZcqVKwrf1WAfmWr7V2BE+nV0nQNsjtMpJSI0wyFPDYHTrSapuSAHiOXlRHFpVW/9fuWgEOUMZcLMvQVwBR6atqwvmbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ABlT4Vd2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kv+sYqnt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ABlT4Vd2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kv+sYqnt"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 0954EEC0238;
	Wed, 13 May 2026 01:57:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 13 May 2026 01:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778651823; x=1778738223; bh=dbvI1Ve5fe
	vEC12bEkMjyYI0KnAov2RT1gvB3rV5W+U=; b=ABlT4Vd2a89omMm54HB3c7i6fW
	SwLAH+DLLytINuMvWHW5G0e+yWCNP0qO1iaKLkNCShF16P/fM2CV93IWXhd82bX5
	qTRp9YxNmb/DWqAEHhUdq+TW4xCZtzkD/Hg1CpNNMzSozEifMhbM4Rif7nRsMwMk
	Cym2wYhJWkDxgFJID78HKU968Y5eXXC3Py54idWPyKrBmlC2yX6IvX5VTd6yGfQS
	J80NL4hDFXX53VHwfrm7erKnrv/Gi+baw/pUYTNwjY+VUAJYO8H24hwrXsglLXP7
	Dfsu7ECn44ca8tepCiJhGsbrYyVO+GLJI7sY46jUgKEAahmQnR0X/xcXl7yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778651823; x=1778738223; bh=dbvI1Ve5fevEC12bEkMjyYI0KnAov2RT1gv
	B3rV5W+U=; b=Kv+sYqntDMzGkqTUTqQy3mqEVYfRSyzCwA+a59V+Dy5TQrZKyud
	j55rH+hdaISbAtLfAjhQbJxv97E5kyt78YMHVTaMu1s5ulrCp9DqVlt/Y5pYzIdk
	sp2EVmw67KqjiHM/8a1FtRk/E+RrL3+wjeLcgcXvcKzNeyxdnUE64B4YCCdrIPHo
	lMSdlAELLuS7F0ErRqWfsC98oybGtu115kkPFmyd+T2cVbK4wzr2KH45yVAgnaD2
	v6yWkwgtlJxn1/xNPxZ1Z+FpI6HMcGtaNt/8gCJQV1BtDUrkMv5g9exXVqJFkkyv
	DQ97FCVFLSmVXK+3UzDLkDjht5iPV95Djfw==
X-ME-Sender: <xms:rhIEandnkKXa3oUSPkHl4T0MXHd4uHY6rYbJVbDo3oPE5HjTKq2pUg>
    <xme:rhIEakO4UzLvrJOefQZlM5NLYgy2sXqfzuQ-_8Q86gkfWNrhy7B6Cu6b5XC0YrkHd
    YdeqiKoheW82DMgBTXZ9srPYw_0uIaMr_zkf3SO4Xe3Uj8xV2Mljm8>
X-ME-Received: <xmr:rhIEali03woMpGj_p_7pcFqiydqPnZzVg42GClXcQlTlWQxadGr89x73OT4VaeFLOh2n2O9L72zwzCoUXghqzdYoJeUwklVlqqpTzP_wppM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdefkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hmvgessghlrggtkhdquggvshhkrdgtnhdprhgtphhtthhopehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:rhIEan3nhgc5-xwWq8YAiZy72NSpgXDEmBENBjK7I7iyJ7hCHHprzw>
    <xmx:rhIEavgT6OIWbSHdU5LP_3k-vkv_F00_cuiz0Gjx4K53HlF3xlj2tQ>
    <xmx:rhIEanee9-VzHX4dV7diXjDPUJ_UC2gVTJu_4sz7nAGaC6F5y0BAaA>
    <xmx:rhIEail2bDIJjM7THx-mNlSUvMtRWR-4pKVsqSBnfa5MRaZqd6tiGQ>
    <xmx:rxIEavvGGnOeB0A3RM6ysC4UzeWvMJfR8r66zhHk3MbUWz1fYtOWVdf1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 01:57:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dabc8eb2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 May 2026 05:56:59 +0000 (UTC)
Date: Wed, 13 May 2026 07:56:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chen Linxuan <me@black-desk.cn>
Cc: git@vger.kernel.org, gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH v3 2/2] config: add "worktree" and "worktree/i" includeIf
 conditions
Message-ID: <agQSqPY0y9oTY_E8@pks.im>
References: <agLTO0amktCWMsiE@pks.im>
 <DIH7FB91JHU1.3OOTDQ6QEZZJZ@black-desk.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIH7FB91JHU1.3OOTDQ6QEZZJZ@black-desk.cn>

On Wed, May 13, 2026 at 10:47:48AM +0800, Chen Linxuan wrote:
> On Tue, 12 May 2026 09:14:03 +0200, Patrick Steinhardt wrote:
> > Just because it was explicitly mentioned: we might also want to have a
> > test that verifies this works with early-config parsing. We already have
> > a similar test for "gitdir:" in "conditional include, early config
> > reading".
> 
> As I wrote in the commit message, this is not going to work with
> early-config parsing. I am working on the fix. But I am not quite
> sure that this is a must-fix issue or not.

If it's not working we should have a test for this regardless, I think.
We should verify the current behaviour around it and either mark it as
`test_expect_success` if that behaviour is intended, or with
`test_expect_failure` if it's not.

Thanks!

Patrick
