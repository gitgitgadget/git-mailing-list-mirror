Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E1522A803
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035865; cv=none; b=OXPYxbLrfzMKz7XEB7e04/70U36HiFEOF6IbrFnMh0wOj8KLuWsRjL5CDXyQ47YBE6rXs7optRDw1Ef1ncHpwOXRid20iQexnOFKdrld6k2CsVQ4P0nxVH85p6gw9Evl2jY/7QjfHDCNYxaVdpkAxO1adOWccvNvEla4/1Ui4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035865; c=relaxed/simple;
	bh=0nMRC3K9sOm7Jmkt6iR1JaZ5rrwXG0/ij4Cme2JKRjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDfFyBkDuoedQZGp3D/1Ssm9N7luZv2vCO0FUIsxu7ZR0vj1s/eD37I4dI9Oizw+xDXUhyZfnQTsUmthkIsM5JP3ITjCryNBXKFmpeUy3utWMBAP8/Wd7bhoaoqv5bVnegp+7HqpEhWCE5grRGJLPRaZ+t8kTzujlxTv84ZIOL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SNjjyezy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L6ATPo0Z; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SNjjyezy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L6ATPo0Z"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2EC7625401C4;
	Thu, 16 Jan 2025 08:57:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jan 2025 08:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737035863; x=1737122263; bh=HTAgW3hmVH
	v2u6AKn9WqJ0EsTROtU0gmzWmg1iPPopc=; b=SNjjyezyruT9+OGp7hubpj2USh
	AT5gyGEe9v9VzW996phoT1vQbZkz5TR4A0CXpg4IEC1cPBtGhWx9pEtVwn9H/Btj
	03NpQsLojoD6Rg4ms4QAyhYqh0Mkwy2p/O/Bq90p6Jq94nIjWsuykUIbxmZX3A1Q
	f4OGe3VD3fvhzX7IGYbfzb0+KAKha9NklU2EFutGWGecvqeFPegorJIERHYo25VI
	7SdGnZ66ajtBFgzO+E4g8ETsdtiHXfoYAOOfP6rcibmfRa88okGj2GfW78xObXGC
	Vd79BlAgbjZuxghRo522Dz/5udAnsikaOeVyB0ryplhsxo1MiKI9JufTPe0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737035863; x=1737122263; bh=HTAgW3hmVHv2u6AKn9WqJ0EsTROtU0gmzWm
	g1iPPopc=; b=L6ATPo0ZJ8xCrsCD/AvKjQbrenbPo86G2vK7F7HSVknmohwN/Au
	y0Iomu1xcKOWEuasdGa7z1NjSzHjtQVmTjWuIMU70YZT7v/DvY/nvC6aRR+lc0QY
	0WcihJ7SlB/Dv3XOJ+jYierUGzZLaWXckMXc4hyhL7o4+O0UM+3VxgyR/LnWUxYW
	84IrRwvilvHkvK/vIBcKkiYfXi+h6r7YAQHKcesaPAAHUIOd6S1iV3nZdMSg9HQz
	69z3IuT79RttB4clSiP6RBpqZV/cSDbhPTxbxteHmWuPE4LMSul3Q1NHT6r9Gm0P
	Gf8VIc9lxag4SspcWqzRinCckbObivLTt2Q==
X-ME-Sender: <xms:VhCJZ7vHS42F_Rc1iO0fOTp0xr7D2CcIz-FiLBY3TrSu6qWyle2KXw>
    <xme:VhCJZ8coENFRXxRbEJVs3JTZ-IBK9Q9vYLhARk_Nes3tkm6UiIf9ziHdrdtBwNLjn
    MpwGDfwMDZ7dK5wuw>
X-ME-Received: <xmr:VhCJZ-x-WKlIrS86oPmnI7XZWwkPfXjR6Hx1VSirksqjmHdcUrYUYE3yaydflMz31Fiw85jQTtiQZb_rKCPlWp4CmElao1StvPtOWNnkk90XcEYPXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmhhgrghhgvghrsegrlhhumhdrmhhithdrvgguuhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesgh
    hmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:VhCJZ6N-KYvJnosn-DgzbD-sjVNh6-bLCQYNOFuixvMDFCaIt_4ptg>
    <xmx:VhCJZ78h-dw83TAuU11U242IGAZMDyqinr0BEfoKofDqCxdryKoVgg>
    <xmx:VhCJZ6WUXylUcpVEo5kJnyBXWqro7xdwwdgrbWwddf68AYFCzEA5Ig>
    <xmx:VhCJZ8cZ-A1KadszViX2Zvr1BOnpRX-LRINnxZeqxnMZTJFax_3dXA>
    <xmx:VxCJZ2keFa8rPNJVv505haAeYzAaYrg5N2j7fEj727pAZ4vFZ6ncHLuG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 08:57:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4ee8a7c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 13:57:41 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:57:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 05/10] packed-backend: check whether the refname contains
 NULL binaries
Message-ID: <Z4kQVHw7Uio-Pzo5@pks.im>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qN_8-HKdspwcDb@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qN_8-HKdspwcDb@ArchLinux>

On Sun, Jan 05, 2025 at 09:49:51PM +0800, shejialuo wrote:
> We have already implemented the header consistency check for the raw
> "packed-refs" file. Before we implement the consistency check for each
> ref entry, let's analysis [1] which reports that "git fsck" cannot
> detect some binary zeros.
> 
> "packed-backend.c::next_record" will use "check_refname_format" to check
> the consistency of the refname. If it is not OK, the program will die.
> So, we already have the code path and we must miss out something.
> 
> We use the following code to get the refname:
> 
>     strbuf_add(&iter->refname_buf, p, eol - p);
>     iter->base.refname = iter->refname_buf.buf
> 
> In the above code, `p` is the start pointer of the refname and `eol` is
> the next newline pointer. We calculate the length of the refname by
> subtracting the two pointers. Then we add the memory range between `p`
> and `eol` to get the refname.
> 
> However, if there are some NULL binaries in the memory range between `p`

You probably mean NUL characters, not NULL binaries?

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 3b11abe5f8..f6142a4402 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -493,6 +493,23 @@ static void verify_buffer_safe(struct snapshot *snapshot)
>  				 last_line, eof - last_line);
>  }
>  
> +/*
> + * When parsing the "packed-refs" file, we will parse it line by line.
> + * Because we know the start pointer of the refname and the next
> + * newline pointer, we could calculate the length of the refname by
> + * subtracting the two pointers. However, there is a corner case where
> + * the refname contains corrupted embedded NULL binaries. And
> + * `check_refname_format()` will not catch this when the truncated
> + * refname is still a valid refname. To prevent this, we need to check
> + * whether the refname contains the NULL binaries.
> + */
> +static int refname_contains_null(struct strbuf refname)
> +{
> +	if (refname.len != strlen(refname.buf))
> +		return 1;
> +	return 0;
> +}
> +
>  #define SMALL_FILE_SIZE (32*1024)
>  
>  /*
> @@ -894,6 +911,9 @@ static int next_record(struct packed_ref_iterator *iter)
>  	strbuf_add(&iter->refname_buf, p, eol - p);
>  	iter->base.refname = iter->refname_buf.buf;
>  
> +	if (refname_contains_null(iter->refname_buf))

We can replace this with `memchr(iter->refname_buf.buf, '\0',
iter->refname_buf.len)`, which should be more efficient than using
strlen(3p).

> +		die("packed refname contains embedded NULL: %s", iter->base.refname);
> +

I was a bit surprised to find that we modify the way that we read refs
from the packed-refs file instead of adapting the fsck code. But I think
this check is sensible.

Patrick
