Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BC53E4C69
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920436; cv=none; b=SwrAzbSPW/X7hodnafYZ0u6kO9BiDKnwYFLRqZapAe/tgQrD6Wdlu2RXp29JYqxOr7ts+AIFDKXoB5EGHSPE8lyc8gD+d/I15GCjgNSSM/loy/Yd3ceAIpjxYQJ/bWL/vcvrlQymTmX9+CGSeymRZeRfYeaYCn/RgdEvOPzUUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920436; c=relaxed/simple;
	bh=NPgwZ7dj0M3sAJjYXnbUnhkiFG7MD8RD82AkcyiRY68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqIG4uImdjeXI6+Lbe3b8Tpo4Vt51AbPnDR4G7YyC4V+lpJFhEjTSlUgIDEYTKcX+712bPQpsPScUHm4i+KqIcY88QMcLCKdYqBfE8UDJvOYhEtiqkQ7bNP0hJoq8RhjSpUD0AemS/QvPaEJ9P4npHALkunf5qPWASKsnO8jZBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vwvevo+o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZVALUi6j; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vwvevo+o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZVALUi6j"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6121EEC01E5;
	Wed,  5 Aug 2026 05:00:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 05 Aug 2026 05:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785920430; x=1786006830; bh=zUBMWn9lgA
	6TIYPBy2mL6THku2WLVTpL4P4OrMoZyjM=; b=Vwvevo+oKzd0sP618RFX/yFVPL
	st+LfLUw7mJmj9J3C8kHSj6of+eb8Y4z1MKyovKt3HfIRKLhD4jTlK3Hz5hHx+qw
	XMWoNDggoEjCgzO3omnSkkiJzwR7kZD7wdLEfj8GwHmuio6m859lBWzrFB7wSdlP
	ogcNGairVFp+7xtQq0SrDkgJtDAq/8op2qeHVbWErX+KsISJKETGkxCAfrhURW6I
	bdHC2GIk1vVd0msSPO0cla4GaoikmC3IXqxiohjerfMEEuQCw5nY1pY/4498L/Yf
	TRW0y9x2Y+fbgAezROl39Ct13EzZD1OxgMvz4yuWa/T7l67LJ8L0jFkmVuiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785920430; x=1786006830; bh=zUBMWn9lgA6TIYPBy2mL6THku2WLVTpL4P4
	OrMoZyjM=; b=ZVALUi6j6sF1HC2Qnh0PeeSRk7gauqKDN54a9LV/eMvJUeKK9l1
	IVUT/FEhfAsWK66R3bDgSKU5Fb9gJ7sZ8lAdsQhxm7KbBihDu6kJMki44NW71pge
	y3+HOG1Q4o8EzXyWQlvqaUGvyzpbszILIh06ipJHSiX8cAHPaw9627wWrITupobU
	cxrMdT3wIXbR2uUqsq/M4sxE63b0EILyKSZp7ujkvxvMGNcAFmSKbe33Tskqxagl
	FdIqvUbjRwXh3pflJFxJpF1NgaY7KNLiA1hNfuRCy9K20mQ4Q44xzpyZESx8QZEP
	zwPtEtmvt6zEe7mVsZXZH0o+50u1tqELndg==
X-ME-Sender: <xms:rvtyarflvewMC_dNWIK4K-AosMLVUOBsrTiYqlpZIvuRBAbiHBxXPw>
    <xme:rvtyaooww5Em7PfQlpRwZWJpsPr98Ya4PUdSQ7kmqoR_AQsDlai2Xjjjrl57tmnuZ
    AW1FzhTbC_9T3uggMtYgZGWSL49x9E97LssaxgXIFONZvWOKvpoLsE>
X-ME-Received: <xmr:rvtyah6vbQ26VdSBJ2IJXNAHcSvPu2j3x15zSr_RMHqCKDDDrbxJ9wcIWVMiWcOPSbTSpEKf_5VUDZqtXOkJ8DObI_iArLnc8KNqdHHBnw>
X-ME-Proxy-Cause: dmFkZTF+IPhItshHZ0zAxRIjt3YU4piPXwLZJ/C/68pur23DBZ8NFpmOD2vCwu4qIzxZtN
    4QbolidCTPlTC6J0gwh/82sUBG5L/CA0gp9XE4OoDAkKPtFTkFoWbWRAhJXBnDvUH543zD
    qgEHq8AYI7ET5Rd6zltVvWzZU3Riw7/vhixp+AuHQC3HlFEtt5g8/mBxMTMlpjtvYk6GNe
    sem6OqXpoBUfqyrQFKajtmdI484bNuHt25PxvVKd3/nN0bBa5/gxq0kCY4sEkcx0X2mfxJ
    JUcbdjZcr8AapYikJRi6LkliCGXv+EoouDfkFbdp5sZDRMxbgrPV8g2nDjMoQciNssR4pv
    kqJjWBeu++1W5AjDvY5hebCj/rbonlaQHnjrvpoKGHewYMTZA/Yw0HPeV4ktftoYebFjcF
    x06pK2ZCLI4Pa7GGSbjbsiDD3peZfTBpz4VNcb1A0tWlPR20RIsC2aRl4OI6Q9EPfGPzHl
    PFBhlnEWvfidjPTdt7VJyE4ve+fzNQtJTY+ql84trekwQ00gtq4+UWw1luuncOTqTLpPzR
    d3Ley8ydbKNAL9f6qyh7V2VadsyeIoub098hwrU73EtKFL1Qzt/c+1QTLg40f9xtmcbsj+
    E9e0ZET0O1R84fcTsk14gOrGtZnrne5K4ZvA59hTdeoHBFlhfvxEvtrAGbHg
X-ME-Proxy: <xmx:rvtyamoHe585Eh7OXo7QforwgkxdkXS2YjxVFV5S3Ambt43LD6-L6Q>
    <xmx:rvtyarjfJJyBbNpsusA6uGTfiL9V1qMZG7MYT8qzr-iQsax6_R9aqw>
    <xmx:rvtyaoIS5HT0yZcU_jo9FBO6NXyPLHpP2gvRR6g7oF1guD34mH7XWA>
    <xmx:rvtyajC3Z-eBnyfIqGkczIwOAqzmXG_Oi0GmZKX8Aw9elnHDLm_AMw>
    <xmx:rvtyajmy2rqlA0F8elI7slZV-vVDV2RBwwgdWaunXSBrVaCKqIgO13LN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:00:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c0d5db46 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 09:00:27 +0000 (UTC)
Date: Wed, 5 Aug 2026 11:00:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chungmin Lee <chungmin@chungminlee.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] regexec: work around macOS TRE leak on invalid UTF-8
Message-ID: <anL7qL2-4h8ZlLcg@pks.im>
References: <20260722053127.37244-1-chungmin@chungminlee.com>
 <20260728052538.12429-1-chungmin@chungminlee.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728052538.12429-1-chungmin@chungminlee.com>

On Mon, Jul 27, 2026 at 10:25:38PM -0700, Chungmin Lee wrote:
> On macOS, the system regex engine leaks an internal buffer when
> regexec() encounters an invalid multibyte sequence in a UTF-8 locale.
> The line-by-line path can call regexec_buf() for each pattern on every
> line, so "git grep" can leak repeatedly on a file containing invalid
> UTF-8.  The total leak grows with the number of calls, and the per-call
> allocation grows with the pattern's automaton.  In one case, grepping a
> repository containing PDFs exhausted memory and caused the machine to
> restart.
> 
> ce025ae4f61e (grep: disable lookahead on error, 2024-10-20) made "git
> grep" fall back to line-by-line matching when regexec() reports an error
> on invalid UTF-8.  That fallback cannot prevent this leak: the allocation
> has already leaked when regexec() returns REG_ILLSEQ.
> 
> Avoid the leaking path by providing a Darwin-specific regexec_buf().
> Walk the input with mbrtowc(), split it at bytes that cannot form a
> complete multibyte character, and search each valid segment separately.
> This preserves matches in valid text on either side of an invalid byte.

Hm. I feel like we're adding quite a lot of logic only to fix an
upstream bug that we expect will be eventually fixed. At the same time
we already have a compatibility "regexec" implementation that I'd expect
doesn't have the bug. So would an alternative be to detect whether the
given platform is susceptible to the bug and, if so, define NO_REGEX and
then use our own regex implementation? Or are there good reasons to not
do that?

Patrick
