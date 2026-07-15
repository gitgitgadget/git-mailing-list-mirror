Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF192F616B
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096526; cv=none; b=mybkKReQ9UucIJjjI8edk6YQVdq8rx5BayxCft4PiYjZSmLpVkrbvogZRWNSVIPv40e+lVz0fZtcl8B3rvzwdWOq/MU512WJzJrI9kPmBJQng2A0lTjTZi7sN2i+JM2Y07s+VNjHtg3X9nqoMK6gb80QrGH7u7oyz3artN7OWbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096526; c=relaxed/simple;
	bh=DMidcWG9qZi8ZEftQMpknNnvB7C4i7DPdxMyqlLyizE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW+L/3v/GKoCz0IGhbQA4qgUQeM/gRoLdnuw8wDHc/vo3Z40z0gGJPEUSy+u+cPtpb+dYyH4LnR+8LCWoIlVHlERnlq+kWomkZ56LWhzNKHI/RrlAyT31CDbnuGyQigCOQ/KL+RoTwJm+z6wp7mFebxMl6ai4hDBpSp56L5f45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GPs0qLnU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PkEc+KYS; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GPs0qLnU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PkEc+KYS"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A17A1D00015;
	Wed, 15 Jul 2026 02:22:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 15 Jul 2026 02:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784096524; x=1784182924; bh=t2mFdZQIJE
	hlKWcFZG92Va0NNnNLUUwufNJjoBJMSmc=; b=GPs0qLnUfqc3aM0J7YN9/bjYH0
	iBfpa/6wc4QyaJZd/cg5zk9wm2e5HGpb4exGhVJzTSw1J4lfXm8rk1SqYZVhGMXW
	nhOrKo+YgE3NgiHXbdZKViU+4choxcy/eDloK+VOuztLZlge970Z4lCEAfWZEO6u
	ZjFP7RzaeQDLDlccYBTgnKgtPcJJOc3jPFzcQpKD+iKRwf7lcRzxcmrWQwEGaui2
	OA8lTFBCnvjQkHk5TljbHxm9/Wwz35iCejAKLPcShorvHeWLKGSqjgNwo5j3dPFp
	LAMKcepfdP0csiAfQm23qhFDVIG9Cf4iGE7e1ItsDP5vssI0uQN0ZkW5deWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784096524; x=1784182924; bh=t2mFdZQIJEhlKWcFZG92Va0NNnNLUUwufNJ
	joBJMSmc=; b=PkEc+KYS8X5KsRflYBaoCSwe6eUOVq1jtjRelffU7U7GqlLRioW
	zjeL4IrWhDjjykJWyHqDlM0lFeG99wkvx6x9pfJkf4hFBQL7Mmfh/l3tkzNg7BjE
	4SFHQUUa/9y86E5dN3U/0w5JBVysSDfOFEBf/AfjfO4EAu4kb3Z4L4FpgzECOPzD
	Yfbue+gNsf3HpWAwIX7pBEPeb0gZs7wSWEnZOCLbZ6ipu8bxJE6rvdWDs8ahmR5a
	q2F5maJDL/g1+/iuoeVD3s4jn3qZXa01PBSLD+ZqeuAQSZ4/jTT/8DoIufVHf3ea
	afJ/CusxwRPnCBEqlSh6NnBu4G0dlXsY08A==
X-ME-Sender: <xms:CydXao49qp8FJEDunIJK_O9O_Pl8uDThbN051Y2bcHXp8zf5NMSi-Q>
    <xme:CydXatkKI8k9lwzM5m8ap_6c1UruSIFANiEpG8WFElA17c5lN3mIuatf2BycZSRDi
    Oc0ecFXP1OZnk89lGgo0-kZW2ZxWrSgKC1xqArhXALyAFWmXCZ5>
X-ME-Received: <xmr:CydXahTveZYasMALBXlhhYz62xx8BA_fHS9kFIoz9WvnQvtzllD158EXufkbG4kvVgzl1z6gbXMwp68Gak-82qbWE_iBfDkV6zcIMfuBLfA>
X-ME-Proxy-Cause: dmFkZTGfiWP82Rq5w3ZS3de41GSewmvtskoPx9VtlpvYYkcuPNQw34SGOds/RHmQZ2UtG+
    5oE7Lp72y+Oyx8Af1CXPoOjq6oKDd3cnNMVepeQfSU/S9v8XPXrvsr8+oukwVOMKeF3XGw
    7mm4fa7eCZqUY8aF0UYB9A9jeZg7EpLn4A7Y6c7wAFQSlGu2txok/93LaEdpf1y84fBWut
    MhGGDrlZYNs0YJ48Hloq6v4r5T344EFzvk9ZBCGOgqxooJqNgd6hWPMfhQrfECFqJwWCYg
    Rfw9Cm7gouR6w5cB+2m59+6rfusWPtg8jD/pG4eDfAJlkUFPOzePiw3d4/+uLv5+HmyPnK
    vv6xCnD6w7Ad6eMT0Iv2cPNjxqSLlnq2rvhT7KBattu8t6y1dEYGzgAzq0BxC8xld0Dzs/
    cTKAp3MQkYdJXPI1cuB58C2y08xxhWUwJ+x/01tYc8OuqzGEAD7C3VWaD49u4NJxqTcMJm
    VpRPPYDWkTzyCIeBssEHxd70yK95ZpMsJVSehTvXtrmNC8E/FmfoJxcrUvdr5mkZ78vzFS
    sP15txdXI00YAAQvTQ6l9YLGcWL4KqMWec87TUz62Q7ytHW5RGEjwJVCDbiRH3FjG111Wh
    K913owOUzu5Kgwjk2euEspWc16WfqkEptT/r3TCAq0pNwuJ4qmjxN7L8Wunw
X-ME-Proxy: <xmx:CydXakEzFEHlWIUsP0T_SbjOHsMuV92vf7tCqgNy61vjXunPXca9Ug>
    <xmx:CydXauEHCOB4DzQlAOwjWZRsWQtOiw6fjb6D3QEMiSPGBsnUl0QX4Q>
    <xmx:CydXaqSfG4v3qaKdlrNRmk3BPqWSpHSwsjRF3oJ-TLfJG2KQ2BO_yA>
    <xmx:CydXanLHaH3C8V0dEtpAocNfpVusjvMgwrM2CeKytUPJikXJx0FS4Q>
    <xmx:DCdXahwyjAh3C2wgZRueOvsSxe4V5OFrmI76tCL7iDPCIetyXEXK90er>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:22:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 56aae93c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:21:59 +0000 (UTC)
Date: Wed, 15 Jul 2026 08:21:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: Taylor Blau <ttaylorr@openai.com>, git@vger.kernel.org,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/9] odb: introduce object filters to
 `odb_for_each_object()`
Message-ID: <alcnBXTLa7cqrL-d@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
 <alW0KzSZuZnHmOZD@com-79390>
 <alXKzb-GHodV6uGj@pks.im>
 <87wluwlsdf.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wluwlsdf.fsf@emacs.iotcl.com>

On Wed, Jul 15, 2026 at 07:43:56AM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Mon, Jul 13, 2026 at 08:59:39PM -0700, Taylor Blau wrote:
> >> On Mon, Jul 13, 2026 at 04:41:24PM +0200, Patrick Steinhardt wrote:
> >> > Range-diff versus v2:
> >> >
> >> >  1:  baf2adb012 =  1:  7c0dc1be0d odb/source-packed: improve lookup when enumerating objects
> >> >  2:  57eecf3031 =  2:  2e5908c9c3 pack-bitmap: mark object filter as `const`
> >> >  -:  ---------- >  3:  f4d66ccfc6 pack-objects: drop unused return value from add_object_entry()
> >> >  3:  92dd6a6f6e =  4:  af475654b8 pack-bitmap: allow aborting iteration of bitmapped objects
> >> >  4:  92fe41577d =  5:  6ca42587c9 pack-bitmap: iterate object sources when opening bitmaps
> >> >  5:  e5d59959e3 =  6:  f62c3bbc81 pack-bitmap: drop `_1` suffix from functions that open bitmaps
> >> >  6:  ab3547ac2b =  7:  b2d25b6e9b pack-bitmap: introduce function to open bitmap for a single source
> >> >  7:  026f21f522 =  8:  a5bf309bec odb: introduce object filters to `odb_for_each_object()`
> >> >  8:  534b25c817 =  9:  600b15a907 builtin/cat-file: filter objects via object database
> >> 
> >> Thanks, this version looks good to me.
> 
> I only posted a nit about function name in the commit messages 7 & 8
> isn't correct, but other than that I'm happy with these patches too.

Thanks for your review! I'll send one more iteration that fixes these
nits.

Patrick
