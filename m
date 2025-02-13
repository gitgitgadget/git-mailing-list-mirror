Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027442066C1
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 06:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739426906; cv=none; b=hJhcQ5H+00i9A2y912rW0oqyyrMLtgNf3KrrcB9he+MuphfceyPuoIuZ8Fprl2uEPgSzPVzkdvfoZLS0ak0d26GO6bVdodxYdmy8oL0/OK4XeJIRUw7vbTY1AWTTTN91F9pV/cnxxn/Oocl0kTxfzmU43/Qux89CkhqqWVnz8JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739426906; c=relaxed/simple;
	bh=7wlkYsmaR0vwdmcBZkEuBxB4fTLUpSC8EcUUwpB+gLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BH18tkGvTf3qBWbinmHGA1ABlePUnUCXScm9+RgWkr/CIEFC0IQ0jf8RIx85dp3Uypjk1LVRblTBIqwqo/k7XAf7+r1cxyvFd0pGU2GhZQzsvnVb7SpZ82Y0KIjL1a2f9+Bz2J7S285bobzwgO9an9j1zd0HuhS3YZgkh5pgvAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sNTEFwVe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B6qM6Tab; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sNTEFwVe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B6qM6Tab"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id ED2BD1140122;
	Thu, 13 Feb 2025 01:08:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 13 Feb 2025 01:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739426903; x=1739513303; bh=zI1cLnAC4b
	3a+W31QlGl55VaNvSA6AASML35ws7l6B8=; b=sNTEFwVeJVk6Rvy0gLUbhy9BVB
	PKilfNHXTUGXRY7bl1Ig9/RtORjUGR/zwrPW/FbOlLC5j+9zhIiaYrpxOY2xe329
	N/+lGL0R+eb98rN+0bUwB6eRM9V3/u5bGgkl1SHzhRJEd06swk9vdJ2XdPe87VY9
	Vsw0NrXcjhH1/2iqPGlzh4Yvkeha/gQYMOna4vIpvDRvgFMoQMV4OlXQloKAAa9w
	TXITabCGtBdLX6sU0+GRLbbi2qHjMGGbHjfjZcGryUFh7JPWeyZAUOmgGZC5UJ1d
	IoOXZu0zcc3mDGAgN9IQe6Z1dRdrDLOVO5jWF3qvZf6Vi6704P/4RpytpPxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739426903; x=1739513303; bh=zI1cLnAC4b3a+W31QlGl55VaNvSA6AASML3
	5ws7l6B8=; b=B6qM6TabaA1SgkHpcJZd8p0GzghHwDQCpbOFdtHI/XV5YkIgsy6
	23Wt6wTCBvc8X9Wa2z8NH8aXcZn/Fyp6VFJyr+Q7dyNc51aOEGRwmUUrrLiAw6RN
	bmG9MyKLhKpESF52UOmasp50P+I6wGxr/mDLgW1PT4b8Ly8+yrJW7NQV6D97mccW
	1nvSxv6t1Wioaqk5TdBBzdJiFkX7I6b5VtEvU8HPdpxMgd83Y75e0/9WeUvPzpUK
	guRJZHuPMCZhRSqe9tuz//xlSdmR4pG78vfz9GfC6xh5tHgxJ2w3VyYM807QAtvK
	AtsDB4BxtLmua/jRsD0WXjDaKHs8fYIu9ZQ==
X-ME-Sender: <xms:V4ytZ46sYLrgBf1rT6QgfTT0C0uKIqCIEgoBmtUar53lFzuG1qO_Iw>
    <xme:V4ytZ54oD7W1APLugukO5X0Hz9l0OS0d44gD-tjnmI-Sub4BQGsIJvcpv77e5_k-1
    pOw6qC7Ll_gPSj-VQ>
X-ME-Received: <xmr:V4ytZ3eX-iLWQDGqkFmscC1Re2f39uhBK5yub9tk9dyh3KOA_vh9nLYs9LsiGkbzPjUdzH7PoUcTIMgXM6UXwRq2ITEDrBoUgFzYyR1MxfBzpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegiedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvlhhl
    hidriihhrghordegvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:V4ytZ9LTXiEXJvubFhqKvRKUs1r7Z-YACzZFFfCpkbdjnR7FhNnYeA>
    <xmx:V4ytZ8KgigWebTalc8AEVVOdHJE7lvnHbmA_yo_3NWU5cHr7KgUjeA>
    <xmx:V4ytZ-xaM9g9MPY1szhlCINoAw3JwdhI0HveUssWvl17CBsbul2U6g>
    <xmx:V4ytZwJQux2oMxM1to0IajZHcjBuupnrkIcRmm93teg5OKbo_9_Ilg>
    <xmx:V4ytZxEdEk-JnuQ5PjzGIH2yB1IOWcQBtNzGmqu3OjBlp3l49NGCNWDu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 01:08:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 83898da3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Feb 2025 06:08:22 +0000 (UTC)
Date: Thu, 13 Feb 2025 07:08:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Zejun Zhao <jelly.zhao.42@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, newren@gmail.com
Subject: Re: [GSOC][PATCH v2 5/6] apply: use `size_t` loop counters
Message-ID: <Z62MVV_GfzTWIn7W@pks.im>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
 <20250209081216.241350-1-jelly.zhao.42@gmail.com>
 <20250209081216.241350-6-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209081216.241350-6-jelly.zhao.42@gmail.com>

On Sun, Feb 09, 2025 at 08:12:15AM +0000, Zejun Zhao wrote:
> diff --git a/apply.c b/apply.c
> index 72464fb6c2..585f534732 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -2419,9 +2416,9 @@ static int line_by_line_fuzzy_match(struct image *img,
>  				    struct image *postimage,
>  				    unsigned long current,
>  				    int current_lno,
> -				    int preimage_limit)
> +				    size_t preimage_limit)
>  {
> -	int i;
> +	size_t i;
>  	size_t imgoff = 0;
>  	size_t preoff = 0;
>  	size_t extra_chars;

This one does more than just changing the loop counters. Probably makes
sense to split out into a separate commit.

Patrick
