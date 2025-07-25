Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD682E3378
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753440959; cv=none; b=BO3et4phgloGbKXI7SnMurH4q6EvIGB4zLyBkGpniKCtqMnSyV9/6/XZDNDk1pDTbpNrP4qJY61q+hFK0ykaDLWyenq0lsKsWa6PX08g4KjZAFg+jXRrR7Y5NhyUY9Ab7kXsmIrerOfHUP8q3cB9hjOzzWiSQyTFDtcINlkLWRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753440959; c=relaxed/simple;
	bh=FJINnutJNOVBpAcZKOkhwVSL+34aP2YMTwADMMFjSAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaY3pu8st2HqGb4V/w7HG86caRJeFdc+YBfPpMhFtlPBBajp0KcViV72QUZwiIEFdVpI78sQ+kdKk/Yf3UraJDc6r0J0ar3NzNrQWA9FL8yDZnHMPr7dbZqNpvla1ezfK/CbrovpwGNPLWrQwDdo5XciMfTlQ9W1zmxO7m0pLmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d3ckjGni; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I/bVH6qv; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d3ckjGni";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I/bVH6qv"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A48DBEC0631;
	Fri, 25 Jul 2025 06:55:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 25 Jul 2025 06:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753440954; x=1753527354; bh=keWhHJx0YG
	3I4P/i/VtH8SokVPAK7MpdM7PzuzdemtM=; b=d3ckjGniZvfEaCA+/BxbCk/L5B
	qqZ8bv1pQdAsVwDrA0v7yNCwEU7yG3lUTL0NlANTrFc0mkP1ExcvQ7+CVN4jaQzY
	RUiQvJ+rd/QIe8zzoPbK12JhKu1mPqAn/VRBy/eE/er/LMilJkQPhoEswgz6SUQv
	6PNkYJGQNk1Iwl6JV+qeHtH5dJBEz25uf/CEz1KbhDfFa//XAWq7UO6BuUJZ8Mjs
	HuWe4DcnIE468Yas7kVPpyHwsXVI5v2K6oCfpVrvCc/CMv5FnaBfBlr2ZvD5EyNt
	+dqcU3u//dFsJAp3rVhjlPtDA526GQ1yLnsKJGDtnvb/YrtIN3B8qQv3JXog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753440954; x=1753527354; bh=keWhHJx0YG3I4P/i/VtH8SokVPAK7MpdM7P
	zuzdemtM=; b=I/bVH6qvHho4au+pZ70X6RT5NO7OGWERgQ8/ofTIjavCkjpa8Zj
	A9pVgL8tM6tiUhUbM1+Zxlyk+adDotNs0Km/+w0sxBEjNnU7XXTZ9dkcVP9HVvYK
	Ih+YEb1SLDVGWhhCixFp79NkhUBKKWd0HnGYwgcwJRPwj6sTUlCa6K65ehtaraEp
	4KTGHLx/PjKlRnAUie4kyj5YA3ET2cn3cB0NVd0tp1zSsDQNm/iClGwB6ZepdKhf
	D4xm4KXxHMScrfW/A6AnI79YKfpXWkzMH+56egbQSPwOzyqRqxbU7aQeltxB3P7X
	Em4L8+wzdHFiNupgT5owNhGrPKGgHjVYkAg==
X-ME-Sender: <xms:umKDaAhlKP4ToaZRpL1psTMLmqxdfodK2dxFsRRQXAbXT28H7Gfy-w>
    <xme:umKDaJMqocnAIFYMiRhLNvnvQGiMgheim0JyhqudEKdGa36woi7cI5_M1nqMqhNMg
    LBEElg--HBu9EdBbA>
X-ME-Received: <xmr:umKDaJ57PYdb8aFkspAOIP94PlFlYImhNVpLWNHOjS9bGYWoH4DW_caacedgqcpIBHVHcgE3w_FWcvAZwj1XcFcCmIJXWD6YDDQTsQKlpcx6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:umKDaP0TrLUgEUdGvPPB_DnObIJkXXaWldu64D3UfzS6xrHyrsNqiA>
    <xmx:umKDaCa8DWWyabMVjVjJf5mf5CLBSx6uf9jAnjwOJt7EwsTYK2e13w>
    <xmx:umKDaPDyf6BOfm6sKngFxWowUUQDTL0ZcJOACdjaa10OIAzLRPA4EA>
    <xmx:umKDaM8H0BGsOYK8actFOh_hgm2RIdbHWnGOWbaiMW4WdgufO-YiHg>
    <xmx:umKDaFwCyjoNFH0Ri2VtB5TTjE2bFmUTY63B5jhMmXRY87gCjtH2uwcI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 06:55:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5d6e49d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Jul 2025 10:55:52 +0000 (UTC)
Date: Fri, 25 Jul 2025 12:55:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] for-each-ref: fix documentation argument ordering
Message-ID: <aINitJW7Mbxswy4b@pks.im>
References: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
 <20250724-kn-small-cleanups-v1-2-0c70f591de3e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-kn-small-cleanups-v1-2-0c70f591de3e@gmail.com>

On Thu, Jul 24, 2025 at 10:14:43AM +0200, Karthik Nayak wrote:
> diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
> index ae61ba642a..a170de4209 100644
> --- a/Documentation/git-for-each-ref.adoc
> +++ b/Documentation/git-for-each-ref.adoc
> @@ -10,11 +10,11 @@ SYNOPSIS
>  [verse]
>  'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
>  		   [(--sort=<key>)...] [--format=<format>]
> -		   [--include-root-refs] [ --stdin | <pattern>... ]
> -		   [--points-at=<object>]
> +		   [--include-root-refs] [--points-at=<object>]
>  		   [--merged[=<object>]] [--no-merged[=<object>]]
>  		   [--contains[=<object>]] [--no-contains[=<object>]]
> -		   [--exclude=<pattern> ...] [--start-after=<marker>]
> +		   [(--exclude=<pattern>)...] [--start-after=<marker>]
> +           [ --stdin | <pattern>... ]

While at it we could also convert this to use `[synopsis]`.

Patrick
