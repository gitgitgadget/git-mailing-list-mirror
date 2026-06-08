Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855F73AB5B7
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910054; cv=none; b=jXJBoB0tQj4M1MF1+kA2pKG4uMpT5uZPd2yb9ZyX0gEPHjxDrr1YPqR9TwxjLEzqZEhoHryQKJiAxGfXuSqKGsEgnHxpjMw1sEg3mZ3VRuHxEy8u3pW/nM4sQusSwmmQk1731lgEG/J2HeQEGri/r+zdCPJ3/Gj8yHKUt9FCPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910054; c=relaxed/simple;
	bh=FVaPvJh9DBnDeHIoTQpslvzKQ/yJHywiM2amaeRFhzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oULDv0zPPTmu8vg9hyF9rjp6RRQsJpMCGg6Sip4cuwO/3lvusicrXMYqni+nsIlfN600N1ahz3fSk/ZpDdk/NFdeZzHJ7ume04j/mqgFaI8tZzoeN9gg/ZvBfyvCMQmW7ItxCisTLtOgv0KeVxjpAKA5tsggR+rimBoOc14J3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eE+X2FgZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KoEWkJ99; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eE+X2FgZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KoEWkJ99"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 910C77A002C;
	Mon,  8 Jun 2026 05:14:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 08 Jun 2026 05:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780910052; x=1780996452; bh=PmRH2JbVS0
	G3/N+rdEnm3q+SiOH6V21/WYCx+T/LWak=; b=eE+X2FgZw9+bfJnXP0Cn4BaG+h
	ON14d4WiwRljQpT5MP9ki8tXRO09sSv6orSTX7UzTZTIT1zXev3zg1XoDCvGaEVz
	46zQxyWmzd4+vJZfgzNvbjox3ezpgQ0u2/dSl9l9t94bHU/1fN7plF+aNZ0607Ay
	LRlknzVdYEAlvwKHC5bvYN1vI7IHURqqC9dN8a7W8AxYOmygBTeSxG7eJ7qFirU/
	cVCLUwbp029VY9X7okrkYoVsR3VMXrvoLtnxqbuK3nbwI0F36i9CGyZQWUptIpmp
	0BtfYfCvU0u7rciThUMSJ5I/Jc+HXqVh8SQdBnX7k9zASaNSUgy6GL9ygRjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780910052; x=1780996452; bh=PmRH2JbVS0G3/N+rdEnm3q+SiOH6V21/WYC
	x+T/LWak=; b=KoEWkJ99axEd4yPpaokj7IMvtEr1YP1DcTUDsjKjT7A5sO0zszu
	PUjRPA9Dvnvp2So38c/1bI3GIFcurs7fhXu8JOdx1bTvCmXG+Few02d4Ve+2dERs
	ssY9kcHDGfMNJijSI+2ilt7A2gFjK0LZ+1txs/GURl5o4nAcet+t4EdfFSrqvJ9E
	9QdQpqCLz2iumNxNbCxHPAgKsviGWrVqAC0pDBN87Q/LwQIXaYo9zQIBzW+W+I2i
	03l/O/D6trXzqL+e8M5iV6v6nfTsAQNaqJMhBfUE4gBYnZdFwLPpByiSMwn9jwjh
	OEegSva6/14At1FmYtULJIWUPzf1SveyPsg==
X-ME-Sender: <xms:44cmamufSwWiS5BTtjUqJ4hn4k3Nzv6GvywL45SOOtqNVImZ_JaU3w>
    <xme:44cmapQQMcyIMHkCDlUCIi7Cfh12N3BTeaob3i1IXH94Gtbhm71w_cU5D3O-DCfXP
    x8XRIv25dgk2M0M4DJSxZSLbIeB2uzp5DFaOd5X71ghlsZGXPmO>
X-ME-Received: <xmr:44cmasM8elPTm4nbtjf8c8XvD9Qzz-3xFCV3LcF4hUZZdrUv6dhiMRX3kvoTkwiEtVAybezYa8xG5cWZP6aoOkcqEBjD9UAYfuy4kqpAZw>
X-ME-Proxy-Cause: dmFkZTGTM3U4ptcEJKQkwsgBfB16Wne/YXTN0gy9AQtWQh4/B8HfWz+QxhQqvLDL4b3T7y
    hg3x76ab9HIYpXBEEf4+kajJZQJ9aHsRVWA44M6gxHNUtf5ODCqe3qAwBJnT1EVkcz4Zfk
    ZNurcSo78iuC1YyMJtSbn10bsUHUBWZkmlvXgb1BkhLXN5+7c8LoqBuYz2EykbQa01cHsH
    /AG2MmPBkY35yPwWEpV2HlRU70R9f46TdQr8X1KJDqVHBRcbSguBDppT7stLtoQY8/cAHm
    zUEjXhUcDSLuxLb+uFZ64lh3UcyJltb39W/MmX86hc3hOKWCrRZ3Awl1mJhSgxHERYfBa4
    pqMeOA0W6XT0vutjqzOjyhSOYBg2DypPoL//KLedKl0nc259wx8r4g93IHoOfWI2CN0WUN
    IQzyhJaHW4cJ043R3QNUCuROpTXHmn5zXtaEzqjJUwf2zVphknwe9EWLt8gtWJMOc8RJ4V
    g0zAPXpYLzlM+AUEtp6De4pkfVWWq1SOFM+4jsRIW9Pd32Q0PBQldeoEeAvOCSIgEXoo0j
    wX/ZuBy+trgpP8ZJ88Bhf+6sB9vBIdAsn2RYnAh9hsddr+RHw1HnqCvurYx8JTChZRZA8d
    zoLdibc/zCgVtOIjk5hm+cwjr3Ls/FrDy8vxyVum/5hRaVEX5DxhnNPRS1mQ
X-ME-Proxy: <xmx:44cmauZe_clQK6Huzp3hZqT2lFSW6xLVNdcz2GnRqogqzgRZPAbDxg>
    <xmx:44cmamwfFxyerGLD99rxmg2la2SWObYfM6iGktDlD94fxbDcDY-ReA>
    <xmx:44cmapJP0Hbq1jvhnGwdLlfNdaAXeHnSoTIIKVO3O3YmOEV-p-jcww>
    <xmx:44cmagqg2Vca6Mivwox9oGlo1ITbREefzA2sh31vYKc1nsTJGzjR2w>
    <xmx:5IcmagJ97U2coeDkihEvy7QyA2KvuucssYNT9lPwIbzpcK75bNzF7lH1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 05:14:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f17336ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 09:14:08 +0000 (UTC)
Date: Mon, 8 Jun 2026 11:14:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Pablo Sabater <pabloosabaterr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/9] reset: introduce ability to skip reference updates
Message-ID: <aiaH3ZmFZfmWYwr7@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
 <20260603-b4-pks-history-drop-v2-5-742cb5b5176d@pks.im>
 <0fdaeec8-99cd-4dc9-9549-8a08133deebf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fdaeec8-99cd-4dc9-9549-8a08133deebf@gmail.com>

On Fri, Jun 05, 2026 at 04:12:42PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 03/06/2026 17:14, Patrick Steinhardt wrote:
> > In a subsequent commit we'll introduce a new caller to `reset_head()`
> > that really only wants to update the index and working tree, without
> > updating any references. Introduce a new flag that lets the caller
> > perform this operation.
> 
> We already have a flag to update ORIG_HEAD so would it make more sense to
> have a flag to update HEAD, rather than adding a flag to disable the
> updates? It would mean updating the existing callers but I think it is a
> clearer api and it avoids the pitfall of
> 
> 	RESET_HEAD_ORIG_HEAD | RESET_HEAD_SKIP_REF_UPDATES

Hm. The question is whether it's sensible to have
`!RESET_HEAD_UPDATE_HEAD && RESET_HEAD_UPDATE_ORIG_HEAD`. That feels
like a somewhat weird request, too, and we'd have to introduce extra
logic to make that combination work.

> I wonder about the function name as well if we make updating HEAD optional
> then what does reset_head() mean? Maybe we should rename it something along
> the lines of reset_worktree() or update_working_copy()? I'm not really sure
> what a good name would be.

That's a good point, the name does get somewhat awkward. I think we
should keep "reset" in there, but `reset_worktree()` to me reads as it
if was rather related to git-worktree(1) than anything else. Maybe
`reset_working_tree()`?

Patrick
