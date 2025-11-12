Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9823009D2
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946769; cv=none; b=exUBS/4yaVcMrl/yEOvkZTY06ASFxlcGxyKM0mLIjEZH2a+6/cV5vz1gNZ1o6YlNs4gc1pV4SjZzzXGY3/1ukjgbD4F2E7jh9ajNOXU4+yjbp/afv5eNuqI7ePDgzNoFbDHKawePijXK9ZQMOOSIOuDVoaX6E+VdfGdXy9hbK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946769; c=relaxed/simple;
	bh=o7eso7s8nwtR1cqyJJHo4cJmvo6gcXg3DYq9BqiSD5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBIrXINNzA82Ya0U11tv0izP9rL4PTQ8uTDsNtzXmOP4jHCwVUJkeGEHcxYZHc/wtTY+4UM3hDtF3JIFOtAePrE6WpyuRnVRhPQ1Go0pog/n5Keb6XCUVmP1i2Vh0wms7MobzR2Nj10l87aA62yBodvnoYJvx1hON1ZVGfAOCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T3jJK0/8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wYyPSQeE; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T3jJK0/8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wYyPSQeE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0459F7A00B1;
	Wed, 12 Nov 2025 06:26:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 12 Nov 2025 06:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762946764; x=1763033164; bh=edsadnNSo8
	ZsWxLKJRhwNQusndAIRBJkPx5TLQgse68=; b=T3jJK0/8Itm5ULRDSBkFhu8tOU
	dAA4/ipEPk/EQrF1DhOpD6OqblT4+ktSdJG94Lzqxi6/p4RBXT0K6EGenkFOtm6K
	7Qdps/SAUihnfByMz5W75P4agAHd8PhKUFFnvTBwBWpK75r0T6sEOHaQOvqBW0MX
	tS9uIyG4fEyv0kCO/B7FIc/+0O75IBSOfHiSaIbsBDC6Efm/bMooIA3Ewv0ugwkY
	R563knUVIMaw0K0mytATVvC/iBzFLfPgszgd4WX4cK4yhZpHdlItQSWVF+QTr8j0
	dY9cesWselmH7AED5YQR7LbdW9MA9r+kTpRxpadi+/PTjzASSCYUWzgZr6MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762946764; x=1763033164; bh=edsadnNSo8ZsWxLKJRhwNQusndAIRBJkPx5
	TLQgse68=; b=wYyPSQeEIRQ93GsiSvQLwcPyGxLwolww55NtWfdX40fEmSXKWHm
	XBFIyToPRvm9SsqgdndxLoZXVxpRkFwf9FV5YHpXa5xDlJoEBTxsA0Kb9j4Hfd8Y
	2MI/6984dmWCJcZB/BVakcjvWB5W1SHIAYj+ZBVtNcOFeEbXAYXGmAvOfnilg30t
	GwlUNF/UHoFGfAFnMDILskoK8KJzOPA1MpVu/D3Y53KznQ4KnCiLA/xQlb/nHTtO
	ETjqmR9c0pyDzVb2+cuLkqhnz9VLrq6kDndvsAJrbniDxxrcOmYOLeEhTziwUgIN
	JlMm5Ni63wD6V2BU/OUBT2QPxcFFiwuOvAw==
X-ME-Sender: <xms:zG4UaVqv2pTvQD_CrFVjJ6UGujT4LO1094LL6OVZyhfC7fHsoGG9Ww>
    <xme:zG4UaepFzvB4Xu3DdKSy8CG6hQR0BeJuwd3xTUVu49tTzDvobKrCufh5o4kzwxo2s
    h6VM_tqjIh1yZajffEqvoM5s23nGY51fBty8FUzTagKmjK2wry-Pw>
X-ME-Received: <xmr:zG4UaXMORqh7PpxNHHkxDzoGNAlzYsM3BGvzlW3hPN2revyesFLcQ-egOBbdpa6VVyouPU8qMEYFOi1WE4e23jqOqKKq1L6s9G67Zf0LkUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdefleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegtmhhlihhsthhssehsvghnthdrtghomhdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zG4UafyG83vRmvieO_jToZPd4K_g99lHW4KYVFxkBj53FPvhSUKjCA>
    <xmx:zG4UaQsXiDcoc4jM3pHMKovGSvtMeTXA0Gjx30nxD5Iq1IrFZEg6TA>
    <xmx:zG4UaY7_XwBJC8tXddq55C7I_K1HL8ZtmoTZhIejp1_omagDwmFJ_Q>
    <xmx:zG4UafR2TKs9oACu9Cau31jrKO6Hqr5UbQoYjqQqwtjV_zSy_0RU0w>
    <xmx:zG4UaWuiTbWP9ud--mIsEA7oDX7ONUy1o-Jy6YFwnprT1OZz5xOPURSD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 06:26:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 074287ad (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 12 Nov 2025 11:26:02 +0000 (UTC)
Date: Wed, 12 Nov 2025 12:25:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 8/9] fsck: avoid parse_timestamp() on buffer that isn't
 NUL-terminated
Message-ID: <aRRux2uBfORc214r@pks.im>
References: <20251112075522.GA978866@coredump.intra.peff.net>
 <20251112081040.GH979063@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112081040.GH979063@coredump.intra.peff.net>

On Wed, Nov 12, 2025 at 03:10:40AM -0500, Jeff King wrote:
> In fsck_ident(), we parse the timestamp with parse_timestamp(), which is
> really an alias for strtoumax(). But since our buffer may not be
> NUL-terminated, this can trigger a complaint from ASan's
> strict_string_checks mode. This is a false positive, since we know that
> the buffer contains a trailing newline (which we checked earlier in the
> function), and that strtoumax() would stop there.
> 
> But it is worth working around ASan's complaint. One is because that
> will let us turn on strict_string_checks by default, which has helped
> catch other real problems. And two is that the safety of the current
> code is very hard to reason about (it subtly depends on distant code
> which could change).
> 
> One option here is to just parse the number left-to-right ourselves. But
> we care about the size of a timestamp_t and detecting overflow, since
> that's part of the point of these checks. And doing that correctly is
> tricky. So we'll instead just pull the digits into a separate,
> NUL-terminated buffer, and use that to call parse_timestamp().

So this is another site that would benefit from having something like
`git_parse_int()` with an extra parameter indicating the number of
bytes available for parsing (and a way to disable unit factors).

Patrick
