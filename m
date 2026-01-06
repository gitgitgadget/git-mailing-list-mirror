Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D373D2FF143
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767681307; cv=none; b=PQOsC/qIuw7RmT9e6ZIHOXFeUd39NsNoKJGg+hq5efjJVW8BiwYQtalO6XsZiudcIPPgyfspUP7cnHgteSA5gGYDOp1M1B7O4puJRecPK98p7zTj2Xhpvmb6v7EpB59rhinPloDlmwK/8UjSC7osZjjHOYUgBcHkvvPo5wcwpfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767681307; c=relaxed/simple;
	bh=b+ZOdzEJy7skDzQnE0eAALX/xq0XY94x2wmob75LWCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiXbGcec6uar5xiTVHOjAosTuLDrq8fDQATVBQ1Iom+WSYrrS6abcUUK4sXWxcf98rhvbahI2seX2kXNMu8KhpW9RzYgIUXaSR8Or1M7+gPUpLfVqp0VH4gQtFM+5GaFmiAqr4UnIx+Pa43sIqlKMN8AH/F8nO8q92/8KRYMeVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RhzL/lXR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UX7u4oPg; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RhzL/lXR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UX7u4oPg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B5E9C1D00089;
	Tue,  6 Jan 2026 01:35:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 06 Jan 2026 01:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767681302; x=1767767702; bh=6VNLw/DP8X
	7KRcRoe+KKGtCHrdO4g8yPjCF37rxpdnw=; b=RhzL/lXR0kDxgXeSBVGUEu07hX
	HtGX/P7xeclhQIoSHPndZemI8pVkQrxXFnhxueRN6HmhPaCTjrBAHGdNuOeh4re9
	9QHtBHeS64pTjOgKoUtcOJh9vdFHFvK1oCjSez8ns/ObfR6kEa+b6G+xeD//N/d9
	2DWR1Dsko50oy6/cPoMYXx+xBvVXHeRI7ylGkpFxTY1kmlDLHnKBpFW6N99q3+sY
	t8YdC2UU/46mdxagjqzfeRWlbgQ4E/8McNPn62EO7lA3GMvFPHoP/flYp01Uopj5
	SlRsFjxmanqvlBzOtvZzPlwlTKe0vXV6df4PorQwlXpQERpTPUMApwA5E5HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767681302; x=1767767702; bh=6VNLw/DP8X7KRcRoe+KKGtCHrdO4g8yPjCF
	37rxpdnw=; b=UX7u4oPg4BG0+uKlqUN24sA0h/K+o36msJ5s0dro9JJvXYIPXOh
	Tj3KxjrO+dyfOv7332vz+wRi/zeHBcoFHTdZQ47u+jolGbrOpt/1Vb1h2NsUyK+P
	Is66fTCmMb/WhKRyrJww5cscWIILJV1x8O6ospW6yCYbwdnceiXEZ/d4fQJvmLM0
	dPFtNbXi/bnAcCdhiSfHYT7X/fUAQvEoV6xE6WXPUmS2/aLv5QVQf0UkynAKsGqb
	LONJpBmK2+fBbUHYmp+vJAR2IXMH9RXbLC629Hi53wwKAfbEKfxYe1zrsgBZQUYm
	PrNg46rBtzA9S4b9INLi57ZMW9KvVRAQnoA==
X-ME-Sender: <xms:Fa1cab58HZd6omWlR-azMPKxeU5KNyD5kFlnDXiE6i5yEJd0c86Bzg>
    <xme:Fa1caX6R9_uVeZwClNP-zjzXgZbXtiUYXeEu2-BthjgWLQdyMK8shWwvbp1CNWcx0
    QnfbrHPWmkK1koWJXv39skxbVvIvSgVQg8zc1vJb030c6VDDV2yzw>
X-ME-Received: <xmr:Fa1caXc0ModmnW5b2zcrHf-jFXeXYR0oDlO3y9qrEICHobSRYrPBtLJ3NgVPZLks6h-orTVGbjldQYKLqUbCkH6DILgOCT6Io91n3HSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegrphhlrghtthhnvghrsehnvhhiughirgdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:Fa1cabBOVxTp66chsnmdFOe2aj8zxZWQ18XVPBDYiGytdGqaYcOfsw>
    <xmx:Fa1caa_WX_E2lq8RiN7zjmqmKjavbWqVWYo8vv6Vk4TAR7mQH15v9Q>
    <xmx:Fa1caWLwmdoyHYCnQQhieqd2HtimHDdJW7HooGp6WFQkkOprkCdZiw>
    <xmx:Fa1caTh5xn_kFHYRyKt9ZmWvAvdSXzRv3xzmvvhVxTsi5-fmLxMcbg>
    <xmx:Fq1cafmKnXtMiT4X5E5U2j8YYqpnnrGosrEOpzI6yZnLKxcxCopwpXBg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 01:35:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ac2a801c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 06:34:58 +0000 (UTC)
Date: Tue, 6 Jan 2026 07:34:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Aaron Plattner <aplattner@nvidia.com>
Subject: Re: [PATCH v2 3/7] packfile: extend `is_delta` field to allow for
 "unknown" state
Message-ID: <aVytEHdNHDHHNpLt@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
 <20251218-b4-pks-odb-read-object-info-improvements-v2-3-62e3e49072bc@pks.im>
 <87o6n8oyw2.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6n8oyw2.fsf@iotcl.com>

On Mon, Jan 05, 2026 at 04:35:57PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The `struct object_info::u::packed::is_delta` field determines whether
> > or not a specific object is stored as a delta. It only stores whether or
> > not the object is stored as delta, so it is treated as a boolean value.
> >
> > This boolean is insufficient though: when reading a packed object via
> > `packfile_store_read_object_info()` we know to skip parsing the actual
> > object when the user didn't request any object-specific data. In that
> > case we won't read the object itself, but will only look up its position
> > in the packfile. Consequently, we do not know whether it is a delta or
> > not.
> 
> This explains why you're introducing "unknown", but I'm having trouble
> understanding why we need distinction between ofs-delta and ref-delta?
> 
> (To any other reader: If you want to know what those two are, check
> "Deltified representation" in Documentation/gitformat-pack.adoc)

Good question, and indeed we don't need that information at any
callsite right now. We do discern the delta type in various locations,
but mostly do so internally at "packfile.c" so that we know how to read
the given object. And there we rely on the `OBJ_REF_DELTA` and
`OBJ_OFS_DELTA` types.

We could of course adapt this to only use `PACKED_OBJECT_TYPE_DELTA`.
But we already have the information readily available at our figertips,
and over time I'd ideally rather want to get rid of the `OBJ_*_DELTA`
values as they leak internal implementation details of the packfile
store into the generic object interfaces. That's way down the road, but
by keeping around the information now it makes such a later conversion
easier.

> > This isn't really an issue right now, as the check for an empty request
> > is broken. But a subsequent commit will fix it, and once we do we will
> > have the need to also represent an "unknown" delta state.
> >
> > Prepare for this change by introducing a new enum that encodes the
> > object type. We don't use the "unknown" state just yet, but will start
> > to do so in the next commit.
> 
> A little bit confusing this "next commit" is [PATCH 6/7], but that's a
> note to any other reader and not so much a nitpick worth addressing.

Fair. I've fixed this up locally to say "subsequent commit".

Thanks!

Patrick
