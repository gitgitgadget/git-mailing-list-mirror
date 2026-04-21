Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1F330650
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776750075; cv=none; b=LgknTTEw1XPqfq+8Vaq7peWCnIjhLsqtEfIZd6UBMp1yi+IvF9valVw5Ph3qTmatSAjyoT9RjMtDYnVbzLFBdrPruxh9vL9WUyVRZ1qOCq1pN9rjFA/1V5ms+MfMsdA2vNTV/OLPoqJPrkRpJf83HRW5kZZ8j18uA8oWE//8pPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776750075; c=relaxed/simple;
	bh=hYYyg0sxvpG+C+QexDPrHXChU84fJTnvR8b5D1XU83o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3otFZjLumQyWpdu7iuhOuOjpZvxtVxdx3wFrUB/91uDfDgTgaUGDA441woTPE8D45qWyJjs/dxd4qk5C5xONjpKQkwIJzuS4u9oEzOpY9dPr0ZIqrOQcD0aQCbN/LM4eYC+IvIePCAZfus7i7JlhzYWS2wx3ycNm5sf6FaoToU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uPbkSdGo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s0kty23q; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uPbkSdGo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s0kty23q"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 34911EC0094;
	Tue, 21 Apr 2026 01:41:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 21 Apr 2026 01:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776750073; x=1776836473; bh=jv7QwOXbdw
	epsFMLzYSVSn+ASzZJH/f+V8Ioa2YTM1M=; b=uPbkSdGoL8MS98uqtSfmBiUAnA
	ASR4BjzOT2njrdnAgNptze7nVflgZNCUsUzzVVMptZ+NXvb00xRP0cdNkym9ss4b
	egbBh9sPNr+o3FuIjIo7/NVvZ2pThwZMTvCj3UKJ96Fc9fpqtm1PP6b7zIVJrq0I
	m7eqmlxF1v0uJl7GP46KXMxkUbqiGYS41BvUa+yfW1i9zD//V8tIiJFy7WdqO2Z6
	UuMbysau1softRepDl+4XIo6Icogif911xUY+buyOPzhEoDKjwqFtDHjigD8VOmj
	oG7XlYgC7gBqOy+e3o4wEruIgZuSpi23DdwG7kSIFXeJ6XoUpj6lUqwWkgow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776750073; x=1776836473; bh=jv7QwOXbdwepsFMLzYSVSn+ASzZJH/f+V8I
	oa2YTM1M=; b=s0kty23qaTrGb1nzQVg+fBat0uRZI7Szfin18Rh4DNF/AeH6/jX
	038W89BCXkFilbLT7wKebY2exyltdbnzZdt/O25vIxqXfTD+A1v1sx//cH9moFeY
	iH+mLx8kT10sQBe2j4PetYynCPnjjPrLHFQoYt2ZajHkLeY2DPrl5QQb8sHp29z/
	oQeGuxRNtN3a8xn78TynFmJyj5guWBTpUTR9ipcY5P3ikVAw3oJxyuvjgWm/aFIz
	ClkaDWuOVTeopQA3oeqC4VkWqPN1hFl16f7z/4AstxJhFLY0hoGKOt9YdqnjgdcA
	UkfNQW7XOXP8QcW2z4g1t7Y26PlEVhr7AoQ==
X-ME-Sender: <xms:-Q3naXiQb5Bn7SRWgrnXP8XB0IK54qyrD_psItLIbOuv7FLY7Bb0Dw>
    <xme:-Q3nabATG13zxt5isyOibdbLRxTa5q89ixas6SoX1bAufbHa6jI-ClYmMgWYk2YuJ
    Eolhg3ru1ubwd35fCBPLCbj6-MzkW_GBixhg_kNlT2QdAIzUzPC-ig>
X-ME-Received: <xmr:-Q3nacGPYSy6Tisd1ZywhPV6wRaFvsAwsEj2i-JCHWTbDr2S9rdzQZi_iZjmrxbS6DhefWs29ZJ888tN4a0UKOElQ0TFAxj5zWFW9z9XwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepfedutdduhfdtleffieekvdfgheegvdevgedtud
    efvddvffdtteduvdehfedufedtnecuffhomhgrihhnpehmshhgihgurdhlihhnkhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:-Q3naTKpvUnxvVPL0a0YGTa2JVHsL7fkfb24AEm2QBcNOiSZzwJ-Ig>
    <xmx:-Q3naQksHc8KiflSDspGaKjcXMI8HrP1EhvutV24hz2rVACcv4fOlg>
    <xmx:-Q3nabQj3hl8D_McGH83mBWhZaoYi2kdA_t7NgH2tm_-vzHksDQzmA>
    <xmx:-Q3naSL_gyEgcBeWGWY-WfkYiIxR4F1U3AOzt8P0Ye-0O3ezdpigQA>
    <xmx:-Q3naZTBvpJEL75HxylTAcW5IM8O8URI8LdpY_O2g--5FRGVXSRG8ECL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 01:41:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b696f0ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 05:41:11 +0000 (UTC)
Date: Tue, 21 Apr 2026 07:41:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 00/12] t: detect errors outside of test cases
Message-ID: <aecN9A3WFIU2aBpW@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
 <xmqqfr4pr4e7.fsf@gitster.g>
 <20260421030045.GA1870557@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421030045.GA1870557@coredump.intra.peff.net>

On Mon, Apr 20, 2026 at 11:00:45PM -0400, Jeff King wrote:
> On Mon, Apr 20, 2026 at 09:19:12AM -0700, Junio C Hamano wrote:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > I've created an MR with GitLab [2] and a PR with GitHub [3] to verify
> > > that these changes work on both platforms.
> > >
> > > Changes in v5:
> > >   - Allow opting in via `GIT_TEST_USE_SET_E=yes` and enable this option
> > >     for Linux CI jobs.
> > >   - Another fix for a potentially-failing command.
> > >   - Link to v4: https://patch.msgid.link/20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im
> > 
> > I agree that the explicit GIT_TEST_USE_SET_E option is a good way to
> > go, as it would be clear which ones are (and which ones are not)
> > using it.  I am not sure why we have check_fsck() thing?  Wasn't it
> > determined that this would fail only with a broken shells, or is it
> > futureproofing just in case the function is used without being
> > tested?
> 
> Yes, I think it would only fail on a broken shell. It's not _wrong_ to
> protect against it, but it's the tip of the iceberg. There are many
> other spots that rely on "set -e" being suppressed inside test snippets,
> not the least of which is every single final command in each snippet
> (because it's at the end of the &&-chain).
> 
> So I think it is better to draw the line at things that actually trigger
> with working shells.

Okay, that's fair enough. Let me drop that part again and then send out
another (hopefully final) version. Thanks!

Patrick
