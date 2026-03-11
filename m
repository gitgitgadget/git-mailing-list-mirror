Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC773E1CE9
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221185; cv=none; b=lbbZ/A7Dh5+Xd6S8lpm1A3TOZbfgToR78TStz4u9V9bskLJcdK+eNV7eNEw6SrnVLRXUdshCJeHNiQ5S+ZtXHteun2nF7nf8qTgT/Ko6spwmHCF4dW2rDhktz6o3TASBBZ4G7AM272hP9Thehx/PP0m9eej+l3svMmYrwRK82iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221185; c=relaxed/simple;
	bh=/BE62Jxev3nNL+NSVR2fNGm7AjqcEEXtwvJESu52/io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z43apzUWKSyuW+OhSuQhrTW63uXqHqUcoCUnuMdPuSxoEFZFkq/gCGxq/1xnVBZ3hq4klHhyF4zPwPz2jRAqfUJ73jpgXFye7VNV8YAd2Fyw+v6sLT4teITebPVz5e3I27IiwYXknQ+7N/W1wJqv2MINuUnOVFAEJNdKELoKHps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GxE5j6ou; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zWSnAYcr; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GxE5j6ou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zWSnAYcr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 583F61D00144;
	Wed, 11 Mar 2026 05:26:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 11 Mar 2026 05:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773221181;
	 x=1773307581; bh=IXIyYSwtJHaLWut+SHJZXWu7al0L7ofANI+7U8Rp+OQ=; b=
	GxE5j6oumOdzjd2zab1S1N+kiNmsC0t9TxDlO1oOIMmeU7IpYBr6PhckekVtxLwa
	RBI9AEDW0z5TqTPQNTN2CwisIj09o15ze7JfbDwwKsguo6duidjQ5+Vk0b7mhg1X
	hrSlUl/IxipgzSztnCBfwcJ+xpaJTFWvuS+QrdkZ0o4pBW9WqTiGpGCofWrfh+7+
	bcjO8AJRKegwcI39gW6diMGt1ZrEUBm5t3Qn6DmdrGIBYg7iksy8YZpwSMVJ1Ra8
	wYRNeMCGpwbXzIOrb8ljwaL6uBApG27AEDs03+QZa6Ngv9aMttueXQxQzfmUOz1d
	QpgwFJSfRnzHya5JxeaNwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773221181; x=
	1773307581; bh=IXIyYSwtJHaLWut+SHJZXWu7al0L7ofANI+7U8Rp+OQ=; b=z
	WSnAYcr2Qfjf4xRMbn1EfxGzmHGK4C036XYhQOoA/kevp9qEwbwIbWzIoXL9lUrj
	8vWIlzXaxLKhem4BXMAo3jEmIQapQYw6OxZITWCBVe2Xt5Ue9h09hDRkG3k13exp
	UwmCSDE+LwhUFqQbnqOpXj0RqtfGGee3+jELlt8H8As5pX2nKNmmMDDEXYWXdYGr
	wcILJAsT446rxh6b3aVft3T0AdQV5dV+nsHsXN2yqmzRz64CmyBwS0gl8k+zyG6A
	9IqN483Z8xI/RPJGenaiB9Qh8/HpQm5Lq1CScOg2Phj7jxo5FsNtVX8JcebEcE5S
	ttxqcMt0xNKdAZVGAmUHA==
X-ME-Sender: <xms:PDWxaQpsqsVGFoTVITuFU5MDsmueq53xoBBHkiHkU6jUX-bQlJG8Mg>
    <xme:PDWxaeHzqj1IH9WFfCIcj6a77WicD9xyT1bAuEsvuPRonwHsKM8XcAlBa1WJV1oKg
    zoPhgFZGH7zNuemITWesE1vxRZDH2Gqzs3Kxu1NRlRN4-zmeuTT>
X-ME-Received: <xmr:PDWxaSkF0P4Y121U3xnsW8u4hMFLWZs-sIeSIq8VrMl655kFI9TlsXGeUSipmpEYLspdDs2DQOwwqgZedBEy_n0G7hyCKnL8yymJMha8Yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:PDWxaRmMy5vzmpXhtUYZjePeTRPd8Lc-Iqux-XImpQ_DwzXPtTuHUw>
    <xmx:PDWxaTuY9nQ2ORbqi3cxRmdj4uR67AmA4_H370sqoeGKidZBK-FJOA>
    <xmx:PDWxaUlUueRV-yqJEQgiJ2Wo9FIF7skjZrxU9cZZBNEYAHe0tOhlYQ>
    <xmx:PDWxaeuCwVMb_p8SYIiBMACTMLEUJmpY_xOc7Nopf0HA9nuZRDgmVQ>
    <xmx:PTWxaThix5LufML3fKAX7BHQGSWW1GdnGcSJwizxQ-U_8GA8anrvpDuG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 05:26:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 143cecb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 09:26:17 +0000 (UTC)
Date: Wed, 11 Mar 2026 10:26:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 7/8] builtin/history: split out extended function to
 create commits
Message-ID: <abE1NwXLCsXanSjy@pks.im>
References: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
 <20260302-pks-history-split-v1-7-444fc987a324@pks.im>
 <CALnO6CC5FB29bHPtyKD=L5EWxTCLx3K2qd+wGySdck7tCvvs_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CC5FB29bHPtyKD=L5EWxTCLx3K2qd+wGySdck7tCvvs_w@mail.gmail.com>

On Tue, Mar 03, 2026 at 01:43:12PM -0500, D. Ben Knoble wrote:
> On Mon, Mar 2, 2026 at 7:17 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > In the next commit we're about to introduce a new command that splits up
> > a commit into two. Most of the logic will be shared with rewording
> > commits, except that we also need to have control over the parents and
> > the old/new trees.
> >
> > Extract a new function `commit_tree_with_edited_message_ext()` to
> > prepare for this commit.
> 
> Curious—what's the "ext" suffix mean here. Extracted? External? (Maybe
> I'll get a better clue in the next patch.)

It stands for "extended". I thought that this was already common use in
our code base:

  - `refs_for_each_ref_ext()`
  - `odb_write_object_ext()`
  - `peel_object_ext()`

But Junio recently asked the same, so maybe I'm biased here (I am, two
of these functions are my doing). Happy to take an alternative suffix.

Patrick
