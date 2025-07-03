Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEFC298CBC
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530766; cv=none; b=VesFoRs2TuEVjDnKel35pruySqIuMuVbVR0RVfN/+y+VqHkTFnknbjrfXJQd7B6gySW/0wGAmfYzKJ+LP2/+dgUscb0K4ERjkixLcGvZcvid3HUmWVVObB72z30ENsNykTyhQZ/CopByunxHDVWisktwg0z8pUwMmhXu/9wLVFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530766; c=relaxed/simple;
	bh=HP9LT3a/ShVR1WKPpymJXQvhD30dALKN8UfDh5mrW/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3DBffaNjduDNmXtEKMKCTmXqtHZntYDMcpRpmQNNNJkprJCDXMkQZNS7X3WJfx76GEEXvTVFwprhdx6++/4MwokUoCROD3yzzAcZc3nGxMdfOOAhtT9Pr37lIbkpqZUP6mO3v8zfVjxB/Rq5PHN+l5EdntWUQxCbAfpDKNoDrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R8MIBcGw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nS+eM5Qm; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R8MIBcGw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nS+eM5Qm"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id AE3C91D0023F;
	Thu,  3 Jul 2025 04:19:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 03 Jul 2025 04:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751530762; x=1751617162; bh=PWHBoWKol/
	XCYPrMqLYuul3jNp8VVYYCzSKn0f6OFX8=; b=R8MIBcGwN0DrrvmlNVrNKnOVuG
	OR7GprX6pCqqDoyN4Pj7a5Wv/lD13Brwv9npwVudhXtAhoJDnBv8tZuzdp75QX/8
	Ez+Fl4NB6ihlVq7B4GUuzCMGk/GkzLbe/6WbZu5QMeaFElTsmX+eKxA6RMzcbQW6
	69x2ga6S/HqCAC1PdSpyfR8zbvcGJKvrQWIK6x24hxJCe6JIq8eYZYcgcgccn5Sq
	jk2VVSw94ZpYQmCHAERLtHQ0Gr6oMAkRn3U5qzK0O9kWx6uh5w408Nchp+hx0Cd4
	2zQqBD+k3rk9xPKDSwKDdO2WxBCitEW6GE/1Ln+evPCKzPV5zzbkwP+ZOUAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751530762; x=1751617162; bh=PWHBoWKol/XCYPrMqLYuul3jNp8VVYYCzSK
	n0f6OFX8=; b=nS+eM5Qmv4k2rysKA0uDbvQyijMJ5zonwA6iEO/RIILnN86XGKK
	0VipRf3WY8s5pNoyinVJJ86MKlkaWr9ZGhTq49f9LCJARiAdiEnihKzMSyTpRemc
	xFtqRe2UzfNsxRJFpsc2SoruHNRhJ0NZKDGNE76DtTReA0wV+16jwsHcFmtZohUl
	ctPKtPP/Jhy6LyIRtR1JQ0faI9e8wDq6okj6m4TEnxdnQNm/YwSahrAwe1qcGK/i
	JI5kFl78AZGae3L43mbxWrsqFJ3JbktbTzxe30LCDqxpkBO7ucPk5TZHwKfzWYb5
	4ErrOL/pkYTImYYtggpxfO3n3S9N2hqRC+A==
X-ME-Sender: <xms:CT1maBR8QiZc7_PLikvz3QgnAQaTalFa3FAytt0qXAA2bYaVAKWMTw>
    <xme:CT1maKzoLggMiIiFRQ8JaKduZVXe51mtkzVMXgcYBn3s0xYPN4OZB9dUKKgVNMTBf
    JXNuQi-Jpa5QjHJLQ>
X-ME-Received: <xmr:CT1maG3x8z4vyjvB3IIhRansJ32v9E5B0JB5EYqpJs5eYg-8Orb-1LQp4qdZy-ugo4F6q8aFuzOZ2gzEUb9oUYMIgH27Ft4hdh2hDnWfcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:CT1maJAlJVThoRj6Cm7UjTQjZTtde0NccWOmW3duSOREwcnSYfam-Q>
    <xmx:CT1maKgilPDzlTtui7V9TVZQCW6Em6OTs6cgdkoEebWIID_9Bs8H5Q>
    <xmx:CT1maNpN_Kks-w40Oi507s0kfYe_SybERAWSzDQScEGXLeNYQaBefA>
    <xmx:CT1maFiT9FFKXVuFSl9a0W04cKLpknENHik15bD9GNK3E9TI3T4qxA>
    <xmx:Cj1maNUatvp8IM1vonTfJq1NIVj35PyrNKFKB-Xl2LyZGhDZzSPYTVri>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 04:19:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id db8aac46 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 08:19:19 +0000 (UTC)
Date: Thu, 3 Jul 2025 10:19:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, phillip.wood@dunelm.org.uk,
	git@vger.kernel.org
Subject: Re: [PATCH 0/4] for-each-ref: introduce seeking functionality via
 '--skip-until'
Message-ID: <aGY9AyJ3c5wXpKaX@pks.im>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <5e9b3ef1-931b-4b70-8275-5aed5da3d6f3@gmail.com>
 <CAOLa=ZTwvOiCnYK18GTEUkcW0-YLHkJ=MBggdzOYsbTT+OHPwQ@mail.gmail.com>
 <aGYSjf5H_ZBaVVJm@pks.im>
 <xmqqsejdbywt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsejdbywt.fsf@gitster.g>

On Wed, Jul 02, 2025 at 10:56:18PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Even more importantly though, a numeric offset would be invalidated by a
> > concurrent write in case that write ends up inserting a ref in the range
> > of commits you intend to skip now.
> 
> That argument cuts both ways, no?  You have shown up to some ref
> which you remember in the last cycle, and then while you are
> planning to formulate another query with --skip-until naming that
> ref, somebody removes that ref, then what happens?

This ref was already yielded, and it wouldn't and shouldn't be yielded
on the next page. This works as expected with the proposal, as
`--skip-until` does not care whether the value itself actually exists.

> Or somebody inserts a new ref that sorts earlier than the ref you
> stopped at the last time.

It wouldn't and shouldn't be shown. When I have already yielded all refs
up to refs/heads/something, I don't expect to see any ref that sorts
before refs/heads/something on the next page.

Patrick
